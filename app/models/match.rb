class Match < ApplicationRecord
  has_many :matchlists
  has_many :summoners, through: :matchlists

  serialize :participants
  serialize :blue_team
  serialize :red_team

  def self.create_from_service(hash, summoner=nil)
    Match.find_or_create_by(id: hash["matchId"]) do |m|
        m.region =      hash["region"]
        m.platform_id = hash["platformId"]
        m.mode =        hash["matchMode"]
        m.match_type =  hash["matchType"]
        m.creation =    hash["matchCreation"]
        m.duration =    hash["matchDuration"]
        m.queue_type =  hash["queueType"]
        m.map_id =      hash["mapId"]
        m.season =      hash["season"]
        m.version =     hash["matchVersion"]
        m.participants= hash["participants"]
        m.blue_team =   hash["blueTeam"]
        m.red_team =    hash["redTeam"]
     end
  end


  def blue_team
    Team.new(self[:blue_team])
  end

  def red_team
    Team.new(self[:red_team])
  end
end

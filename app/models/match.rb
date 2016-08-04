class Match < ApplicationRecord
  has_many :matchlists
  has_many :summoners, through: :matchlists

  serialize :participants
  serialize :blue_team
  serialize :red_team

  def self.create_from_service(hash, summoner=nil)
    Match.create(
        id:           hash["matchId"],
        region:       hash["region"],
        platform_id:  hash["platformId"],
        mode:         hash["matchMode"],
        match_type:   hash["matchType"],
        creation:     hash["matchCreation"],
        duration:     hash["matchDuration"],
        queue_type:   hash["queueType"],
        map_id:       hash["mapId"],
        season:       hash["season"],
        version:      hash["matchVersion"],
        participants: hash["participants"],
        blue_team:    hash["blueTeam"],
        red_team:     hash["redTeam"]
     )
  end


  def blue_team
    Team.new(self[:blue_team])
  end

  def red_team
    Team.new(self[:red_team])
  end
end

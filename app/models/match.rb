class Match < ApplicationRecord
  has_many :matchlists
  has_many :summoners, through: :matchlists

  serialize :participants
  serialize :blue_team
  serialize :red_team

  def participants
    self[:participants].map do |participant|
      Participant.new(participant)
    end
  end

  def blue_team
    Team.new(self[:blue_team])
  end

  def red_team
    Team.new(self[:red_team])
  end
end

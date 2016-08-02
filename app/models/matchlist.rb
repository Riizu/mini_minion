class Matchlist < ActiveRecord::Base
  belongs_to :summoner
  belongs_to :match
end

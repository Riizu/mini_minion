class Match < ApplicationRecord
  has_many :matchlists
  has_many :summoners, through: :matchlists
end

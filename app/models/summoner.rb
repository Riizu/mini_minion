class Summoner < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :profile_icon_id, presence: true
  validates :level, presence: true

  validates_presence_of :user_id

  has_many :matchlists
  has_many :matches, through: :matchlists
end

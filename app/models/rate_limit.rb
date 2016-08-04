class RateLimit < ApplicationRecord
  validates :name, presence: true
  validates :limit, presence: true
end

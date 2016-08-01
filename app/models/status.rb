class Status < ApplicationRecord
  validates :version, presence: true, uniqueness: true
end

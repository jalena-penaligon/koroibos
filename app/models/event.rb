class Event < ApplicationRecord
  belongs_to :sport
  validates :name, presence: true, uniqueness: true
end

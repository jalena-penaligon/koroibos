class Event < ApplicationRecord
  belongs_to :sport
  has_many :olympian_events
  has_many :olympians, through: :olympian_events
  validates :name, presence: true, uniqueness: true
end

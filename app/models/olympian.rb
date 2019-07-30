class Olympian < ApplicationRecord
  belongs_to :sport
  has_many :olympian_events
  has_many :events, through: :olympian_events
  validates :name, presence: true, uniqueness: true
  validates_presence_of :age, :sex, :weight, :team, :height
end

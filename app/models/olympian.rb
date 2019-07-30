class Olympian < ApplicationRecord
  belongs_to :sport
  validates :name, presence: true, uniqueness: true
  validates_presence_of :age, :sex, :weight, :team, :height
end

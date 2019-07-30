class Sport < ApplicationRecord
  has_many :olympians
  validates :name, presence: true, uniqueness: true
end

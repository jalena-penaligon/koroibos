class Sport < ApplicationRecord
  has_many :olympians
  has_many :events
  validates :name, presence: true, uniqueness: true

  def as_json options={}
    {
      sport: name,
      events: self.events.pluck(:name)
    }
  end
end

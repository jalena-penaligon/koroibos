class Olympian < ApplicationRecord
  belongs_to :sport
  has_many :olympian_events
  has_many :events, through: :olympian_events
  validates :name, presence: true, uniqueness: true
  validates_presence_of :age, :sex, :weight, :team, :height

  def self.by_age(direction)
    if direction == "youngest"
      order(age: :asc).limit(1)
    else direction == "oldest"
      order(age: :desc).limit(1)
    end
  end

  def as_json options={}
    {
      name: name,
      team: team,
      age: age,
      sport: Sport.find(sport_id).name,
      total_medals_won: total_medals
    }
  end

  def total_medals
    self.olympian_events.where.not(medal: "NA").count
  end

end

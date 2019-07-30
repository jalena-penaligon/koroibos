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

  def self.get_stats
    {
      total_competing_olympians: Olympian.all.count,
      average_weight: Olympian.average_weight,
      average_age: Olympian.average(:age).round(2).to_f
    }
  end

  def self.average_weight
    {
      unit: "kg",
      male_olympians: Olympian.where(sex: "M").average(:weight).round(2).to_f,
      female_olympians: Olympian.where(sex: "F").average(:weight).round(2).to_f
    }
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

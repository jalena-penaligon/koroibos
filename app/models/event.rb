class Event < ApplicationRecord
  belongs_to :sport
  has_many :olympian_events
  has_many :olympians, through: :olympian_events
  validates :name, presence: true, uniqueness: true

  def get_medalists
    olympians = self.find_olympians
    build_medalist_info(olympians)
  end

  def find_olympians
    Olympian.joins(:olympian_events)
    .where("olympian_events.event_id = #{self.id}")
    .where.not("olympian_events.medal = 'NA'")
  end

  def build_medalist_info(olympians)
    olympians.map do |olympian|
      {
          name: olympian.name,
          team: olympian.team,
          age: olympian.age,
          medal: olympian.olympian_events.where(event_id: self.id)[0].medal
      }
    end
  end
end

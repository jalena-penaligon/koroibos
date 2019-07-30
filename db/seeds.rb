require 'csv'

OlympianEvent.destroy_all
Olympian.destroy_all
Event.destroy_all
Sport.destroy_all

olympians = {}

options = {headers: true, header_converters: :symbol}

CSV.foreach('./db/olympians.csv', options) do |row|
  olympians = row.to_h
  sport = Sport.find_or_create_by(name: olympians[:sport])
  olympian = sport.olympians.create(name: olympians[:name],
                                    sex: olympians[:sex],
                                    age: olympians[:age],
                                    height: olympians[:height],
                                    weight: olympians[:weight],
                                    team: olympians[:team])
  event = sport.events.find_or_create_by(name: olympians[:event])
  olympian_event = OlympianEvent.create(olympian_id: olympian.id, event_id: event.id, medal: olympians[:medal])
end

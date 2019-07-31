require 'rails_helper'

describe "Get Medalists Stats API" do
  before :each do
    # create sports
    weightlifting = Sport.create(name: "Weightlifting")
    @weightlifting_event = weightlifting.events.create(name: "Weightlifting Women's Super-Heavyweight")

    # weightlifting olympians
    andreaa = Olympian.create(name: "Andreea Aanei", sex: "F", age: 22, height: 170, weight: 125, team: "Romania", sport_id: weightlifting.id)
    sri = Olympian.create(name: "Sri Wahyuni Agustiani", sex: "F", age: 21, height: 147, weight: 47, team: "Indonesia", sport_id: weightlifting.id)
    mikiko = Olympian.create(name: "Mikiko Ando", sex: "F", age: 23, height: 155, weight: 58, team: "Japan", sport_id: weightlifting.id)
    esraa = Olympian.create(name: "Esraa Ahmed El-Sayed", sex: "F", age: 17, height: 150, weight: 63, team: "Egypt", sport_id: weightlifting.id)

    # create olympian events
    andreaa_event = OlympianEvent.create(olympian_id: andreaa.id , event_id: @weightlifting_event.id, medal: "Gold")
    sri_event = OlympianEvent.create(olympian_id: sri.id, event_id: @weightlifting_event.id, medal: "Silver")
    mikiko_event = OlympianEvent.create(olympian_id: mikiko.id, event_id: @weightlifting_event.id, medal: "Bronze")
    esraa_event = OlympianEvent.create(olympian_id: esraa.id, event_id: @weightlifting_event.id, medal: "NA")
  end

  it "displays a single event and its medalists" do
    get "/api/v1/events/#{@weightlifting_event.id}/medalists"

    expect(response).to be_successful

    medalists = JSON.parse(response.body)

    expect(medalists["event"]).to eq("Weightlifting Women's Super-Heavyweight")
    expect(medalists["medalists"].count).to eq(3)
    expect(medalists["medalists"][0]).to have_key(:name)
    expect(medalists["medalists"][0]).to have_key(:team)
    expect(medalists["medalists"][0]).to have_key(:age)
    expect(medalists["medalists"][0]).to have_key(:medal)
  end
end

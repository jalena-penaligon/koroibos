require 'rails_helper'

describe "Get Olympian Stats API" do
  before :each do
    # create sports
    weightlifting = Sport.create(name: "Weightlifting")
    gymnastics = Sport.create(name: "Gymnastics")
    athletics = Sport.create(name: "Athletics")

    # create pertaining events
    weightlifting_event = weightlifting.events.create(name: "Weightlifting Women's Super-Heavyweight")
    gymnastics_mens_event = gymnastics.events.create(name: "Gymnastics Men's Individual All-Around")
    gymnastics_womens_event = gymnastics.events.create(name: "Gymnastics Women's Team All-Around")
    athletics_event = athletics.events.create(name: "Athletics Men's 5,000 metres")

    # weightlifting olympians
    andreaa = Olympian.create(name: "Andreea Aanei", sex: "F", age: 22, height: 170, weight: 125, team: "Romania", sport_id: weightlifting.id)

    # gymnastics olympians
    tabea = Olympian.create(name: "Tabea Lara Alt", sex: "F", age: 16, height: 158, weight: 50, team: "Germany", sport_id: gymnastics.id)
    nstor = Olympian.create(name: "Nstor Abad Sanjun", sex: "M", age: 23, height: 167, weight: 64, team: "Spain", sport_id: gymnastics.id)

    # atletics olympians
    antonio = Olympian.create(name: "Antonio Abadia Beci", sex: "M", age: 26, height: 170, weight: 65, team: "Spain", sport_id: athletics.id)

    # create olympian events
    andreaa_event = OlympianEvent.create(olympian_id: andreaa.id , event_id: weightlifting_event.id, medal: "NA")
    nstor_event = OlympianEvent.create(olympian_id: nstor.id, event_id: gymnastics_mens_event.id, medal: "NA")
    tabea_event = OlympianEvent.create(olympian_id: tabea.id, event_id: gymnastics_womens_event.id, medal: "NA")
    antonio_event = OlympianEvent.create(olympian_id: antonio.id, event_id: athletics_event.id, medal: "Bronze")
  end

  it "displays overall olympian stats" do
    get '/api/v1/olympian_stats'

    expect(response).to be_successful

    stats = JSON.parse(response.body)["olympian_stats"]

    expect(stats["total_competing_olympians"]).to eq(4)
    expect(stats["average_weight"]["unit"]).to eq("kg")
    expect(stats["average_weight"]["male_olympians"]).to eq(64.5)
    expect(stats["average_weight"]["female_olympians"]).to eq(87.5)
    expect(stats["average_age"]).to eq(21.75)
  end
end

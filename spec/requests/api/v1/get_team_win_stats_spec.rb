require 'rails_helper'

describe "Get Most Winning Team Stats API" do
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
    tabea = Olympian.create(name: "Tabea Lara Alt", sex: "F", age: 16, height: 158, weight: 50, team: "Romania", sport_id: gymnastics.id)
    nstor = Olympian.create(name: "Nstor Abad Sanjun", sex: "M", age: 23, height: 167, weight: 64, team: "Spain", sport_id: gymnastics.id)

    # atletics olympians
    antonio = Olympian.create(name: "Antonio Abadia Beci", sex: "M", age: 26, height: 170, weight: 65, team: "Spain", sport_id: athletics.id)

    # create olympian events
    andreaa_event = OlympianEvent.create(olympian_id: andreaa.id , event_id: weightlifting_event.id, medal: "NA")
    nstor_event = OlympianEvent.create(olympian_id: nstor.id, event_id: gymnastics_mens_event.id, medal: "NA")
    tabea_event = OlympianEvent.create(olympian_id: tabea.id, event_id: gymnastics_womens_event.id, medal: "Gold")
    antonio_event = OlympianEvent.create(olympian_id: antonio.id, event_id: athletics_event.id, medal: "Bronze")
  end

  it "displays the most winning team" do
    get '/api/v1/most_winning_team'

    expect(response).to be_successful

    wins = JSON.parse(response.body)

    expect(wins["team"]).to eq("Spain")
    expect(wins["medals"]["total_medals"]).to eq(2)
    expect(wins["medals"]["gold"]).to eq(1)
    expect(wins["medals"]["silver"]).to eq(0)
    expect(wins["medals"]["bronze"]).to eq(1)
  end
end

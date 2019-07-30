require 'rails_helper'

describe "Get Olympians API" do
  before :each do
    weightlifting = Sport.create(name: "Weightlifting")
    gymnastics = Sport.create(name: "Gymnastics")
    athletics = Sport.create(name: "Athletics")

    weightlifting_event = weightlifting.events.create(name: "Weightlifting Women's Super-Heavyweight")
    gymnastics_event = gymnastics.events.create(name: "Gymnastics Men's Individual All-Around")
    athletics_event = athletics.events.create(name: "Athletics Men's 5,000 metres")

    andreaa = Olympian.create(name: "Andreea Aanei", sex: "F", age: 22, height: 170, weight: 125, team: "Romania", sport_id: weightlifting.id)
    nstor = Olympian.create(name: "Nstor Abad Sanjun", sex: "M", age: 23, height: 167, weight: 64, team: "Spain", sport_id: gymnastics.id)
    antonio = Olympian.create(name: "Antonio Abadia Beci", sex: "M", age: 26, height: 170, weight: 65, team: "Spain", sport_id: athletics.id)

    andreaa_event = OlympianEvent.create(olympian_id: andreaa.id , event_id: weightlifting_event.id, medal: "NA")
    nstor_event = OlympianEvent.create(olympian_id: nstor.id, event_id: gymnastics_event.id, medal: "NA")
    antonio_event = OlympianEvent.create(olympian_id: antonio.id, event_id: athletics_event.id, medal: "Bronze")
  end

  it "sends a list of olympians" do
    get '/api/v1/olympians'

    expect(response).to be_successful

    olympians = JSON.parse(response.body)["olympians"]
    expect(olympians.count).to eq(3)

    expect(olympians.first).to have_key("name")
    expect(olympians.first).to have_key("team")
    expect(olympians.first).to have_key("age")
    expect(olympians.first).to have_key("sport")
    expect(olympians.first).to have_key("total_medals_won")

    expect(olympians.first).to_not have_key("sex")
    expect(olympians.first).to_not have_key("height")
    expect(olympians.first).to_not have_key("weight")
    expect(olympians.first).to_not have_key("sport_id")
    expect(olympians.first).to_not have_key("created_at")
    expect(olympians.first).to_not have_key("updated_at")
  end

  it "displays the youngest olympian" do
    get '/api/v1/olympians?age=youngest'

    expect(response).to be_successful

    olympian = JSON.parse(response.body)["olympian"]
    expect(olympian.count).to eq(1)

    expect(olympian.first["name"]).to eq("Andreea Aanei")
    expect(olympian.first["team"]).to eq("Romania")
    expect(olympian.first["age"]).to eq(22)
    expect(olympian.first["sport"]).to eq("Weightlifting")
    expect(olympian.first["total_medals_won"]).to eq(0)
  end


end

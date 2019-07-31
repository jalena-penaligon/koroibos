require 'rails_helper'

describe "Get Events API" do
  before :each do
    weightlifting = Sport.create(name: "Weightlifting")
    gymnastics = Sport.create(name: "Gymnastics")
    athletics = Sport.create(name: "Athletics")

    womens_weightlifting_event = weightlifting.events.create(name: "Weightlifting Women's Super-Heavyweight")
    mens_gymnastics_event = gymnastics.events.create(name: "Gymnastics Men's Individual All-Around")
    womens_gymnastics_event = gymnastics.events.create(name: "Gymnastics Women's Individual All-Around")
    womens_athletics_event = athletics.events.create(name: "Athletics Men's 5,000 metres")
    mens_athletics_event = athletics.events.create(name: "Athletics Women's 5,000 metres")
  end

  it "sends a list of events by sport" do
    get '/api/v1/events'

    expect(response).to be_successful

    sports = JSON.parse(response.body)["events"]
    expect(sports.count).to eq(3)

    expect(sports[0]["events"].count).to eq(1)
    expect(sports[0]["events"][0]).to eq("Weightlifting Women's Super-Heavyweight")
    expect(sports[1]["events"].count).to eq(2)
  end

end

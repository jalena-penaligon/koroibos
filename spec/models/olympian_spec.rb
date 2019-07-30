require 'rails_helper'

RSpec.describe Olympian, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :age }
    it { should validate_presence_of :height }
    it { should validate_presence_of :weight }
    it { should validate_presence_of :team }
    it { should validate_uniqueness_of :name }
  end

  describe 'relationships' do
    it { should belong_to :sport }
    it { should have_many :olympian_events }
    it { should have_many :events }
  end

  describe 'class methods' do
    before(:each) do
      weightlifting = Sport.create(name: "Weightlifting")
      gymnastics = Sport.create(name: "Gymnastics")
      athletics = Sport.create(name: "Athletics")

      # create olympians
      @andreaa = Olympian.create(name: "Andreea Aanei", sex: "F", age: 22, height: 170, weight: 125, team: "Romania", sport_id: weightlifting.id)
      @tabea = Olympian.create(name: "Tabea Lara Alt", sex: "F", age: 16, height: 158, weight: 50, team: "Germany", sport_id: gymnastics.id)
      @nstor = Olympian.create(name: "Nstor Abad Sanjun", sex: "M", age: 23, height: 167, weight: 64, team: "Spain", sport_id: gymnastics.id)
      @antonio = Olympian.create(name: "Antonio Abadia Beci", sex: "M", age: 26, height: 170, weight: 65, team: "Spain", sport_id: athletics.id)
    end

    it "self.by_age sorts olympians by age" do
      expect(Olympian.by_age("youngest")[0]).to eq(@tabea)
      expect(Olympian.by_age("oldest")[0]).to eq(@antonio)
    end

    it "self.get_stats returns a hash of olympian stats" do
      expect(Olympian.get_stats).to be_a(Hash)
      expect(Olympian.get_stats[:total_competing_olympians]).to eq(4)
      expect(Olympian.get_stats).to have_key(:average_weight)
      expect(Olympian.get_stats[:average_age]).to eq(21.75)
    end

    it "self.average_weight returns a hash of male and female averages" do
      expect(Olympian.average_weight).to be_a(Hash)
      expect(Olympian.average_weight[:unit]).to eq("kg")
      expect(Olympian.average_weight[:male_olympians]).to eq(64.5)
      expect(Olympian.average_weight[:female_olympians]).to eq(87.5)
    end
  end

  describe 'instance methods' do
    before(:each) do
      @weightlifting = Sport.create(name: "Weightlifting")
      @weightlifting_event_1 = @weightlifting.events.create(name: "Weightlifting Women's Super-Heavyweight")
      @weightlifting_event_2 = @weightlifting.events.create(name: "Weightlifting Women's Heavyweight")
      @andreaa = Olympian.create(name: "Andreea Aanei", sex: "F", age: 22, height: 170, weight: 125, team: "Romania", sport_id: @weightlifting.id)
      @andreaa_event_1 = OlympianEvent.create(olympian_id: @andreaa.id , event_id: @weightlifting_event_1.id, medal: "NA")
      @andreaa_event_2 = OlympianEvent.create(olympian_id: @andreaa.id , event_id: @weightlifting_event_1.id, medal: "Bronze")
    end

    it "as_json customizes hash output" do
      expect(@andreaa.as_json).to be_a(Hash)
      expect(@andreaa.as_json).to have_key(:name)
      expect(@andreaa.as_json).to have_key(:team)
      expect(@andreaa.as_json).to have_key(:age)
      expect(@andreaa.as_json).to have_key(:sport)
      expect(@andreaa.as_json).to have_key(:total_medals_won)
    end

    it "total_medals calculates an athletes medals" do
      expect(@andreaa.total_medals).to eq(1)
    end
  end
end

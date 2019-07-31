require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe 'relationships' do
    it { should belong_to :sport }
    it { should have_many :olympian_events }
    it { should have_many :olympians }
  end

  describe 'class methods' do
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

    it 'self.get_medalists returns an array of olympians' do
      medalists = @weightlifting_event.get_medalists

      expect(medalists).to be_a(Array)
      expect(medalists.count).to eq(3)
      expect(medalists[0]).to have_key(:name)
      expect(medalists[0]).to have_key(:team)
      expect(medalists[0]).to have_key(:age)
      expect(medalists[0]).to have_key(:medal)
    end
  end
end

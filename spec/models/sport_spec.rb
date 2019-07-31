require 'rails_helper'

RSpec.describe Sport, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe 'relationships' do
    it { should have_many :olympians }
    it { should have_many :events }
  end

  describe 'instance methods' do
    it "as_json customizes hash output" do
      weightlifting = Sport.create(name: "Weightlifting")
      weightlifting_event = weightlifting.events.create(name: "Weightlifting Women's Super-Heavyweight")

      expect(weightlifting.as_json).to be_a(Hash)
      expect(weightlifting.as_json).to have_key(:name)
      expect(weightlifting.as_json[:events].count).to eq(1)
      expect(weightlifting.as_json[:events]).to be_a(Array)
    end
  end
end

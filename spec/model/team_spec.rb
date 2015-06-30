require "rails_helper"

RSpec.describe Team, type: :model do
  before do
    @team = FactoryGirl.build :team
  end

  context "test hay_many" do
    it {expect(@team).to have_many(:users).through(:team_users)}
    it {expect(@team).to have_many(:team_users)}
    it {expect(@team).to belong_to(:leader).class_name("User")}
  end

  context "Validates" do
    it "name should be valid" do
      expect(@team).to be_valid
    end
  end
end

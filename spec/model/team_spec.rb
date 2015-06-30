require "rails_helper"

RSpec.describe Team, type: :model do

  context "test hay_many" do
    let(:team) {FactoryGirl.create :team}
    it {expect(team).to have_many(:users).through(:team_users)}
    it {expect(team).to have_many(:team_users)}
    it {expect(team).to belong_to(:leader).class_name("User")}
  end

  describe "#name" do
    subject {FactoryGirl.create :team}
    before {subject.name = nil}
    it {is_expected.to have(1).error_on(:name)}
  end
end

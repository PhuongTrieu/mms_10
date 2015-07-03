require "rails_helper"

RSpec.describe Skill, type: :model do
  describe "associations" do
    let(:skill) {FactoryGirl.create :skill}
    context "#has_many" do
      it {expect(skill).to have_many(:skill_users).dependent(:destroy)}
      it {expect(skill).to have_many(:users).through(:skill_users)}
    end
  end

  describe "validates" do
    subject {FactoryGirl.create :skill}
    before {subject.name = nil}
    it {is_expected.to have(1).error_on(:name)}
  end
end

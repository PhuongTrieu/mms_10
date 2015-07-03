require "rails_helper"

RSpec.describe Skill, type: :model do
  context "test has many" do
    let(:skill) {FactoryGirl.build(:skill)}
    it {expect(skill).to have_many(:skill_users)}
    it {expect(skill).to have_many(:users).through(:skill_users)}
  end

  context "#name" do
    subject {FactoryGirl.create :skill}
    before {subject.name = nil}
    it {is_expected.to have(1).error_on(:name)}
  end
end

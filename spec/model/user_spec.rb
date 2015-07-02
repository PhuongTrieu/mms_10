require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    let(:user) {FactoryGirl.create :user}
    context "#has_many" do
      it {expect(user).to have_many(:skills).through(:skill_users)}
      it {expect(user).to have_many(:team_users)}
      it {expect(user).to have_many(:teams).through(:team_users)}
      it {expect(user).to have_many(:projects).through(:project_users)}
      it {expect(user).to have_many(:project_users)}
    end

    context "#has_one" do
      it {expect(user).to have_one(:leader)}
    end
  end

  describe "scope" do
    context "#not_in_team" do
      before do
        @team = FactoryGirl.create :team
        @team.users << FactoryGirl.create(:user)
        it {expect(User.users_not_in_team).not_to include @team.users}
      end
    end

    context "#normal_users" do
      let(:user) {FactoryGirl.create :user, is_admin: true}
      it {expect(User.normal_users).not_to include user}
    end
  end
end

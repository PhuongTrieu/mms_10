require "rails_helper"

describe Admin::SkillsController, type: :controller do
  before do
    @user_admin = FactoryGirl.create :user, is_admin: true
    @user_normal = FactoryGirl.create :user
    sign_in @user_admin
  end

  describe "Get #index" do
    context "response to render template index" do
      before {get :index}
      it {is_expected.to render_template :index}
    end

    context "response when normal user to access to admin index" do
      before do
        sign_out @user_admin
        sign_in  @user_normal
        get :index
      end

      it {expect(flash[:danger]).to eq "Please login as ADMIN!"}
      it {expect(response).to redirect_to :root}
    end

    context "response when guest to access to admin index" do
      before do
        sign_out @user_admin
        get :index
      end

      it {expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."}
      it {expect(response).to redirect_to new_user_session_url}
    end
  end

  describe "Get #new" do
    context "should response new form of skill" do
      before {get :new}
      it {expect(response).to render_template :new}
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "create a new skill" do
        expect{
          post :create, skill: FactoryGirl.attributes_for(:skill)
        }.to change(Skill, :count).by(1)
      end

      it "redirect to the index of skill" do
        post :create, skill: FactoryGirl.attributes_for(:skill)
        expect(response).to redirect_to admin_skills_url
      end

      it "re-renders the new method" do
        post :create, skill: FactoryGirl.attributes_for(:skill, name: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe "Get #edit" do
    context "should response edit form of skill" do
      before {get :edit, id: FactoryGirl.create(:skill)}
      it {expect(response).to render_template :edit}
    end
  end

  describe "PUT #update" do
    before :each do
      @skill = FactoryGirl.create(:skill, name: "phuong")
    end

    context "valid attributes" do
      it "changes @skill's attributes" do
        put :update, id: @skill,
        skill: FactoryGirl.attributes_for(:skill, name: "phuong")
        @skill.reload
        expect(@skill.name).to eq "phuong"
        expect(flash[:success]).to eq "Update skill successfully!"
      end

      it "re-renders the edit method" do
        put :update, id: @skill,
        skill: FactoryGirl.attributes_for(:skill, name: nil)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @skill = FactoryGirl.create :skill
    end

    it "deletes the skill" do
      expect{
        delete :destroy, id: @skill
        }.to change(Skill, :count).by(-1)
    end

    it "redirects to admin/skills#index" do
      delete :destroy, id: @skill
      expect(response).to redirect_to admin_skills_url
    end
  end
end

require "rails_helper"

RSpec.describe "admin/users/index.html.erb" do
  it "check action and url of users index" do
    expect(controller.request.path_parameters[:controller]).to eq "admin/users"
    expect(controller.request.path_parameters[:action]).to eq "index"
  end

  it "should have pagination" do
    50.times do
      FactoryGirl.create :user
    end
    @users = User.paginate page: params[:page],
                           per_page: Settings.number_per_page
    render
    expect(rendered).to have_css("div.pagination")
  end
end

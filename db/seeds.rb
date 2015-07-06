FactoryGirl.create :user, name: "Phuong", email: "phuong@abc.com", is_admin: true

30.times do
  FactoryGirl.create :user
end

FactoryGirl.define do

factory :user do
  first_name "First"
  last_name "Last"
  sequence(:email) { |n| "user#{n}@odot.com"}
  password "test123"
  password_confirmation "test123"
end

end
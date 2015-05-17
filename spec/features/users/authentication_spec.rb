require "spec_helper"

describe "Logging In" do

  it "logs the user in and goes to the todo lists" do
    User.create(first_name: "Frizky",
                last_name: "Kramer",
                email: "frizkykramer@gmail.com",
                password: "test123",
                password_confirmation: "test123")
    visit new_user_session_path
    fill_in "Email Address", with: "frizkykramer@gmail.com"
    fill_in "Password", with: "test123"
    click_button "Log In"
    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in!")
  end

  it "displays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Email Address", with: "frizkykramer@gmail.com"
    fill_in "Password", with: "nopes"
    click_button "Log In"

    expect(page).to have_content("There was a problem logging in, please check your email and password.")
    expect(page).to have_field("Email", with: "frizkykramer@gmail.com")
  end
end
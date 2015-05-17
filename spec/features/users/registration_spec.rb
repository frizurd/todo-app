require "spec_helper"

describe "Signing up" do
  it "allows a user to sign up for the site and creates the object in the database" do
    expect(User.count).to eq(0)

    visit "/"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"

    fill_in "First name", with: "Frizky"
    fill_in "Last name", with: "Kramer"
    fill_in "Email", with: "frizkykramer@gmail.com"
    fill_in "Password", with: "test123"
    fill_in "Password (again)", with: "test123"
    click_button "Sign Up"

    expect(User.count).to eq(1)

  end
end
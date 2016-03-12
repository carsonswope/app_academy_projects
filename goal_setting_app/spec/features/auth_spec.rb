require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      sign_up
      expect(page).to have_content 'some_guy'
    end

    it "rejects too short of a password" do
      fill_in "Username", with: "some_guy"
      click_button "Sign Up"
      expect(page).to have_content 'Password is too short'
    end

    it "rejects a blank username" do
      fill_in "Password", with: "password"
      click_button "Sign Up"
      expect(page).to have_content "Username can't be blank"
    end

  end
end

feature "logging in" do
  before :each do
    visit new_session_url
  end

  it "re-renders sign in page on failed login" do
    fill_in "Username", with: "ajdklf"
    fill_in "Password", with: "askljf"
    click_button "Sign In"
    expect(page).to have_content "incorrect credentials"
    expect(page).to have_content "Sign In"
  end

  it "shows username on the homepage after login" do
    sign_in
    expect(page).to have_content 'some_guy'
    expect(page).to have_button 'Sign Out'
  end

end

feature "logging out" do
  before :each do
    visit new_session_url
  end

  it "begins with logged out state" do
    expect(page).to have_content "Sign In"
    expect(page).to_not have_button "Sign Out"
  end

  it "doesn't show username on the homepage after logout" do
    sign_in
    click_button 'Sign Out'
    expect(page).to_not have_content 'some_guy'
  end

end

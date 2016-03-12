require 'spec_helper'
require 'rails_helper'

feature "making a goal" do

  before :each do
    sign_up
  end

  it "has an 'Make Goal' link on the user show page" do
    expect(page).to have_content "Make Goal"
  end

  it "redirects to a new goal form after clicking 'Make Goal' link" do
    click_link "Make Goal"
    expect(page).to have_content "Description"
    expect(page).to have_button "Make Goal"
  end

  it "redirects to user show page on success" do
    make_goal
    click_button "Make Goal"
    expect(page).to have_content "succeed"
    expect(page).to have_content "some_guy"
    expect(page).to have_content "Goals"
  end

  it "defaults the private setting to false on the new goal form" do
    make_goal
    click_button "Make Goal"
    expect(page).to_not have_content "private"
  end

  it "shows when a goal is private" do
    make_goal
    choose('Private')
    click_button "Make Goal"
    expect(page).to have_content "private"
  end

end

feature "can manipulate goals" do

  before :each do
    sign_up
    make_goal
    click_button "Make Goal"
  end

  it "has a button to mark goal as completed" do
    expect(page).to have_button "Done"
  end

  it "updates status when goal is marked as completed" do
    click_button "Done"
    expect(page).to have_content "Completed"
  end

  it "has a button to give up on goal" do
    expect(page).to have_button "Give Up"
  end

  it "removes goal when give up button is clicked" do
    click_button "Give Up"
    expect(page).to_not have_content "succeed"
  end

end

feature "enforces privacy" do

  before :each do
    sign_up
    make_goal
    click_button 'Make Goal'
    make_private_goal
    click_button 'Sign Out'
    sign_up_as_other_guy
    visit user_url(User.find_by_username('some_guy'))
  end

  it "should not provide buttons for 'Give Up' nor 'Done'" do
    expect(page).to_not have_button "Give Up"
    expect(page).to_not have_button "Done"
  end

  it "should not show private goals" do
    expect(page).to_not have_content "get laid"
  end

  it "should instead show simple 'in progress' notification" do
    expect(page).to have_content "Goal in progress"
  end

end

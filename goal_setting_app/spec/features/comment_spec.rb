require 'spec_helper'
require 'rails_helper'

feature "goal comments" do
  before :each do
    sign_up
    make_goal
    click_button "Make Goal"
    click_link "succeed"
  end

  it "has a 'Make Comment' form on the goal's show page" do
    expect(page).to have_content "Make Comment"
    expect(page).to have_button "Submit Comment"
  end

  it "adds the comment to the goal's list of comments" do
    add_comment
    expect(page).to have_content "yeah right, loser"
  end

  it "can be removed by its author" do
    add_comment
    click_button "Remove Comment"
    expect(page).to_not have_content "yeah right, loser"
  end

end

feature "user comments" do
  before :each do
    sign_up
    make_goal
    click_button "Make Goal"
  end

  it "has a 'Make Comment' form on the user's show page" do
    expect(page).to have_content "Make Comment"
    expect(page).to have_button "Submit Comment"
  end

  it "adds the comment to the user's list of comments" do
    add_comment
    expect(page).to have_content "yeah right, loser"
  end

  it "can be removed by its author" do
    add_comment
    click_button "Remove Comment"
    expect(page).to_not have_content "yeah right, loser"
  end

end

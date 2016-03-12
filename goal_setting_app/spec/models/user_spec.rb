# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validates the user's paramaters" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
  end

  describe "has appropriate associations" do
    it { should have_many(:goals) }
    it { should have_many(:comments) }
  end

  describe "only accepts valid password" do

    let(:short_pw) { FactoryGirl.build(:short_pw) }
    let(:user) { FactoryGirl.build(:user) }

    it "rejects short passwords" do
      expect(short_pw).to_not be_valid
    end

    it "accepts good passwords" do
      expect(user).to be_valid
    end
  end

end

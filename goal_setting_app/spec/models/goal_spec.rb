# == Schema Information
#
# Table name: goals
#
#  id          :integer          not null, primary key
#  description :text             not null
#  user_id     :integer          not null
#  completed   :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pprivate    :boolean          default(FALSE), not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do

  describe "validates paramaters" do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user_id) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
  end

end

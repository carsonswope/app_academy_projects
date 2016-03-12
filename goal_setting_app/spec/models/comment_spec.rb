# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  body             :text             not null
#  commentable_type :string           not null
#  commentable_id   :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validates that it has an owner" do
    it "validates a user as it's subject" do
      
    end
  end
end

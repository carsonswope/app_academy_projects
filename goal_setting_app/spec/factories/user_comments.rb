# == Schema Information
#
# Table name: user_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#

FactoryGirl.define do
  factory :user_comment do
    
  end

end

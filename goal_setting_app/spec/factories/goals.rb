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

FactoryGirl.define do
  factory :goal do
    pprivate false
    description Faker::Hacker.say_something_smart
    user_id 1
    completed false

    factory :no_desc do
      description nil
    end

  end

end

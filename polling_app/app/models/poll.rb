# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Poll < ActiveRecord::Base
  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: "User"

  has_many :questions,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: "Question"

  has_many :responses,
    through: :questions,
    source: :responses

  has_many :respondents,
    through: :responses,
    source: :respondent
end

# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base
  validate :not_duplicate_response
  validate :author_not_responding_to_own_poll

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: "AnswerChoice"

  belongs_to :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "User"

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  has_many :responses_to_same_question,
    through: :question,
    source: :responses

  def sibling_responses
    responses_to_same_question.where.not(id: id)
  end

  def not_duplicate_response
    if sibling_responses.map { |r| r.user_id }.include?(user_id)
      errors[:respondent] << "user has already answered this question"
    end
  end

  def author_not_responding_to_own_poll
    if question.poll.author_id == user_id
      errors[:respondent] << "user answered own poll!"
    end
  end

end

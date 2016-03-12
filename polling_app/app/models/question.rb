# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  has_many :answer_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: 'AnswerChoice'

  belongs_to :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: "Poll"

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results_slow
    results = {}
    answer_choices.each do |choice|
      results[choice.text] = choice.responses.length
    end
    results
  end

  def results_fast
    results = {}
    answer_choices.includes(:responses).each do |choice|
      results[choice.text] = choice.responses.length
    end

    results
  end

  def results_best
    result = answer_choices.joins(:responses).where("answer_choices.question_id = ?", id).group("answer_choices.id").select("answer_choices.text, COUNT(*) as num_responses")
    returnhash = {}

    result.each do |choice|
      returnhash[choice.text] = choice.num_responses
    end

    returnhash

  end

end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :authored_polls,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: 'Poll'

  has_many :responses,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'Response'

  has_many :answered_questions,
    through: :responses,
    source: :question

    def active_record_completed_polls
      Poll.joins("JOIN questions ON polls.id = questions.poll_id").joins("LEFT OUTER JOIN answer_choices ON questions.id = answer_choices.question_id")
      .joins("JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .joins("JOIN users ON responses.user_id = users.id")
      .where("users.id = ? OR users.id IS NULL", id)
      .group("polls.id")
      .having("COUNT(polls.*) = COUNT(responses.*)")
    end

    # SELECT
    #   polls.id, sjdkl.responses.id
    # FROM
    #   polls
    # JOIN
    #   questions ON questions.poll_id = polls.id
    # LEFT OUTER JOIN
    #
    #   ( SELECT
    #       *
    #     FROM
    #       answer_choices
    #     JOIN
    #       responses ON answer_choices.id = responses.answer_choice_id
    #     JOIN
    #       users ON reponses.user_id = users.id
    #     WHERE
    #       users.id = 14 ) as sjdkl ON questions.id = answer_choices.question_id


    def completed_polls_sql
      Poll.find_by_sql([<<-SQL, id])
        SELECT
          users.id, questions.id, responses.id
        FROM
          users
        JOIN
          responses ON responses.user_id = users.id
        JOIN
          answer_choices ON answer_choices.id = responses.answer_choice_id
        RIGHT OUTER JOIN
          questions ON questions.id = answer_choices.question_id
        JOIN
          polls ON polls.id = questions.poll_id
        WHERE
          users.id = 14 OR users.id IS NULL
        GROUP BY
          polls.id
        HAVING
          COUNT(polls.*) = COUNT(responses.*)
      SQL
    end
end

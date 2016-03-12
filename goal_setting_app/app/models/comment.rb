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

class Comment < ActiveRecord::Base

  validates :commentable_id, :commentable_type, :user_id, :body, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :author, foreign_key: :user_id, class_name: "User"

end

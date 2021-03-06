# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to :moderator, class_name: "User"
  has_many :post_subs

  has_many :posts, through: :post_subs, source: :post, dependent: :destroy # how to handle case where post is on multiple subreddits?
end

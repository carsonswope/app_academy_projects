# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class Post < ActiveRecord::Base
  attr_reader :sub_ids

  validates :title, :author_id, presence: true
  validates :sub_ids, length: { minimum: 1 }

  belongs_to :author, class_name: "User"

  has_many :post_subs,
    foreign_key: :post_id,
    primary_key: :id,
    class_name: 'PostSub'

  has_many :subrs, through: :post_subs, source: :subr

  def sub_ids=(sub_ids)
    @sub_ids = sub_ids
  end

end

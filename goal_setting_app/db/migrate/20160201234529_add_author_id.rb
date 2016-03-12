class AddAuthorId < ActiveRecord::Migration
  def change

    add_column :user_comments, :author_id, :integer, null: false
    add_column :goal_comments, :author_id, :integer, null: false

    add_index :user_comments, :author_id
    add_index :goal_comments, :author_id

  end
end

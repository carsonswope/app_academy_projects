class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.integer :user_id, null: false
      t.text :body, null: false
      t.string :commentable_type, null: false
      t.integer :commentable_id, null: false

      t.timestamps null: false
    end

    add_index :comments, :user_id
    add_index :comments, [:commentable_type, :commentable_id]
  end
end

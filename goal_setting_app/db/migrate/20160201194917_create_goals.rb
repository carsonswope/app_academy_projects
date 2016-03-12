class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.boolean :private, null: false, default: false
      t.text :description, null: false
      t.integer :user_id, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps null: false
    end

    add_index :goals, :user_id
  end
end

class ChangeGoals < ActiveRecord::Migration
  def change
    remove_column :goals, :private
    add_column :goals, :pprivate, :boolean, null: false, default: false
  end
end

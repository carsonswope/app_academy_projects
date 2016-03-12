class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :contact_name
      
      t.timestamps null: false
    end
  end
end

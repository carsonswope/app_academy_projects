class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :name
      t.string :field_type
      t.timestamps null: false
    end
  end
end

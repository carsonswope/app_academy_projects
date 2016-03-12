class AddTimeConstraintsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :before_req, :boolean
    add_column :teams, :before_req_time, :integer
    add_column :teams, :after_req, :boolean
    add_column :teams, :after_req_time, :integer
  end
end

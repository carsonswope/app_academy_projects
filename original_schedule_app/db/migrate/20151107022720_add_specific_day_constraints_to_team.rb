class AddSpecificDayConstraintsToTeam < ActiveRecord::Migration
  def change
    0.upto(9) do |req_number|
      start = "day_req_#{req_number}"
      add_column :teams, start.to_sym, :boolean
      add_column :teams, "#{start}_before_after".to_sym, :boolean
      add_column :teams, "#{start}_time".to_sym, :integer
      add_column :teams, "#{start}_date".to_sym, :date
    end
  end
end

class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      [:mon, :tues, :weds, :thurs, :fri, :sat, :sun].each do |day|
        t.boolean day
        t.integer "#{day}_first_game".to_sym
        t.integer "#{day}_last_game".to_sym
      end

    end
  end
end

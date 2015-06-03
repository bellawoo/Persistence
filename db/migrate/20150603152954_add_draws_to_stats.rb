class AddDrawsToStats < ActiveRecord::Migration
  def change
  	add_column :stats, :draws, :integer
  end
end

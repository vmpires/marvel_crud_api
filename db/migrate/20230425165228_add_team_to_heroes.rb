class AddTeamToHeroes < ActiveRecord::Migration[5.2]
  def change
    add_column :heroes, :team, :integer
  end
end

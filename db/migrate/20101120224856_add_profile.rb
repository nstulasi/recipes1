class AddProfile < ActiveRecord::Migration
  def self.up
    add_column :users, :forename, :string
    add_column :users, :surname, :string
    add_column :users, :occupation, :string
    add_column :users, :town, :string
  end

  def self.down
    remove_column :users, :forename
    remove_column :users, :surname
    remove_column :users, :occupation
    remove_column :users, :town
  end

end

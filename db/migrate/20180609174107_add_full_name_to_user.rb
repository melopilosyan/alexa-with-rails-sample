class AddFullNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string, default: 'John Wick'
  end
end

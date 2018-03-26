class AddHobbyToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :job, :string
    add_column :users, :residence, :string
    add_column :users, :hobby, :string
  end
end

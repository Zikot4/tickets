class AddModeratorToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :moderator, :boolean,    default: false
  end
end

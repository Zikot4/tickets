class AddModeratorIdToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :moderator_id, :integer
  end
end

class RemoveFieldFromTicket < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :status, :integer
  end
end

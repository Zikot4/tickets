class AddStatusToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :status, :integer,         default: 0
    add_column :tickets, :complete, :boolean,       default: false
  end
end

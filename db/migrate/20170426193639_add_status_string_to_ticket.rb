class AddStatusStringToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :status, :string,      default: Ticket::STATUSES['Waiting']
  end
end

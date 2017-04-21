class AddLinkIdToTicket < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :link_id, :string
  end
end

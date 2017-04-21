class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :body
      t.string :email

      t.timestamps
    end
  end
end

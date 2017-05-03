class CreateCancans < ActiveRecord::Migration[5.0]
  def change
    create_table :cancans do |t|

      t.timestamps
    end
  end
end

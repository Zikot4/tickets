class RemoveFieldFromComment < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :commentable_link_id, :string
  end
end

class AddCommentableIdToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :commentable_id, :integer
  end
end

class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :posts, [:user_id, :content_at]
  end
end

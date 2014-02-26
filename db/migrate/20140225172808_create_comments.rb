class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false, default: ""
      t.references :user
      t.references :snippet

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :snippet_id
  end
end

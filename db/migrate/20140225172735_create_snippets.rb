class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :code, null: false, default: ""
      t.string :title, null: false, default: ""
      t.references :user

      t.timestamps
    end

    add_index :snippets, :user_id
  end
end

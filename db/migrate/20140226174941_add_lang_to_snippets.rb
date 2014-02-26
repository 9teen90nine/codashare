class AddLangToSnippets < ActiveRecord::Migration
  def change
    add_column :snippets, :lang, :string, null: false, default: ''
  end
end

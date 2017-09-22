class BooksNewInfo < ActiveRecord::Migration
  def change
    add_column :books, :tags, :text
    add_column :books, :read, :boolean
  end
end
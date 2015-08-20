class AddBookRefToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :book, index: true
    add_foreign_key :reviews, :books
  end
end

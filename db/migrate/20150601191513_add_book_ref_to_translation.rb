class AddBookRefToTranslation < ActiveRecord::Migration
  def change
    add_reference :translations, :book, index: true
    add_foreign_key :translations, :books
  end
end

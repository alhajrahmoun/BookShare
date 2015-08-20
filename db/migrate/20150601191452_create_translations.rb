class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :title
      t.string :language
      t.string :translator

      t.timestamps null: false
    end
  end
end

class AddCommunityRefToBooks < ActiveRecord::Migration
  def change
    add_reference :books, :community, index: true
    add_foreign_key :books, :communities
  end
end

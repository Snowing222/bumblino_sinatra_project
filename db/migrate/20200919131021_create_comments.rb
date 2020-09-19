class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :parent_id
      t.integer :playdate_id
    end
  end
end

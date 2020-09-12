class CreateBabies < ActiveRecord::Migration
  def change
    create_table :babies do |t|
      t.string :name
      t.string :gender
      t.text :about_me
      t.integer :parent_id
    end
  end
end

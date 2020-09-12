class CreatePlaydates < ActiveRecord::Migration
  def change
    create_table :playdates do |t|
      t.datetime :date
      t.string :title
      t.string :location
      t.integer :zipcode
      t.text :description
    end
  end
end

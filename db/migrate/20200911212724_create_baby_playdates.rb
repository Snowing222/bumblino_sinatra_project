class CreateBabyPlaydates < ActiveRecord::Migration
  def change
    create_table :baby_playdates do |t|
      t.integer :baby_id
      t.integer :playdate_id
    end
  end
end

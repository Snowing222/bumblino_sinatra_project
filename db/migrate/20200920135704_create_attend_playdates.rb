class CreateAttendPlaydates < ActiveRecord::Migration
  def change
    create_table :attend_playdates do |t|
      t.integer :parent_id
      t.integer :playdate_id
    end
  end
end

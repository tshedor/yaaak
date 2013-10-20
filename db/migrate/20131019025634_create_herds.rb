class CreateHerds < ActiveRecord::Migration

  def change
    create_table :herds do |t|
      t.integer :parent_id
      t.float :geo_lat
      t.float :geo_long
      t.timestamps
    end
  end

end

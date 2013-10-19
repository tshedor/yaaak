class CreateGrunts < ActiveRecord::Migration

  def change
    create_table :grunts do |t|
      t.integer :yak_id
      t.integer :herd_id
      t.text :message
      t.float :geo_lat
      t.float :geo_long
      t.timestamps
    end
  end

end

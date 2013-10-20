class CreateYaks < ActiveRecord::Migration

  def change
    create_table :yaks do |t|
      t.string :name
      t.string :auth_hash
      t.float :geo_lat
      t.float :geo_long
      t.integer :herd_id
      t.timestamps
    end
  end

end

class CreateYaks < ActiveRecord::Migration

  def change
    create_table :yaks do |t|
      t.string :name
      t.string :hash
      t.float :geo_lat
      t.float :geo_long
      t.timestamps
    end
  end

end

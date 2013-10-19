class CreateHerds < ActiveRecord::Migration

  def change
    create_table :herds do |t|
      t.integer :parent_id
      t.timestamps
    end
  end

end

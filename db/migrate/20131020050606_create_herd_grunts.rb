class CreateHerdGrunts < ActiveRecord::Migration

  def change
    create_table :herd_grunts do |t|
      t.integer :grunt_id
      t.integer :herd_id
      t.timestamps
    end
  end

end

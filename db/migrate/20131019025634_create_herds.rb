class CreateHerds < ActiveRecord::Migration

  def change
    create_table :herds do |t|
      t.timestamps
    end
  end

end

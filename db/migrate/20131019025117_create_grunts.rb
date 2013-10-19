class CreateGrunts < ActiveRecord::Migration

  def change
    create_table :grunts do |t|
      t.integer :user_id
      t.integer :heard_id
      t.text :message
      t.timestamps
    end
  end

end

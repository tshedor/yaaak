class AddColorToYaks < ActiveRecord::Migration
  def change
    add_column :yaks, :color, :string
  end
end

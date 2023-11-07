class CreateColors < ActiveRecord::Migration[7.1]
  def change
    create_table :colors do |t|
      t.string :rgb, :null => false
      t.text :description

      t.timestamps
    end
  end
end

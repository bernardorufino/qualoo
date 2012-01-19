class CreateVisibilities < ActiveRecord::Migration
  def change
    create_table :visibilities do |t|
      t.string :name
      t.string :symbol
      t.text :description

      t.timestamps
    end
  end
end

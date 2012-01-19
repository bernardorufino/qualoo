class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.integer :level
      t.integer :measured_id
      t.integer :measurer_id

      t.timestamps
    end
  end
end

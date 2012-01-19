class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|

      t.timestamps
    end
  end
end

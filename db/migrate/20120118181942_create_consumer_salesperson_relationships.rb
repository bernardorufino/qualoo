class CreateConsumerSalespersonRelationships < ActiveRecord::Migration
  def change
    create_table :consumer_salesperson_relationships do |t|
      t.integer :consumer_id
      t.integer :salesperson_id
      t.string :owner_type
      t.integer :visibility_id

      t.timestamps
    end
  end
end

class CreateRelationshipTaggings < ActiveRecord::Migration
  def change
    create_table :relationship_taggings do |t|
      t.integer :consumer_salesperson_relationship_id
      t.integer :tag_id

      t.timestamps
    end
  end
end

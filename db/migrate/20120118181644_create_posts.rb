class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :salesperson_id
      t.text :body

      t.timestamps
    end
  end
end

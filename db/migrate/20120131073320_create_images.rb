class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.string :file_format
      
      t.timestamps
    end
  end
  
  def down
    Image.all.each(&:destroy);
    drop_table :images;
  end
end

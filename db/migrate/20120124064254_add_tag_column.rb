class AddTagColumn < ActiveRecord::Migration
  def up
    add_column :tags, :user_id, :integer;
  end

  def down
    remove_column :tags, :user_id;
  end
end

class AddMessageReadColumn < ActiveRecord::Migration
  def up
    add_column :messages, :read, :boolean;
  end

  def down
    remove_column :messages, :read;
  end
end

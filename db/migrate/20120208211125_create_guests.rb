class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name;
      t.string :email;
      t.string :city;
      t.string :profile_type;

      t.timestamps
    end
  end
end

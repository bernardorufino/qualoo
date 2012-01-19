class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_hash
      t.integer :location_id
      t.integer :profile_id
      t.string :profile_type

      t.timestamps
    end
  end
end

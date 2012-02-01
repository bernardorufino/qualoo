class AddColumnsToLocation < ActiveRecord::Migration
  def up
    {
      :visibility_id => :integer,
      :localizable_id => :integer,
      :localizable_type => :string,
      :street => :string,
      :city => :string,
      :state => :string,
      :country => :string,
      :postal_code => :integer
    }.to_a.each do |(name, type)|
      add_column :locations, name, type;
    end
    remove_column :users, :location_id;
  end

  def down
    [:visibility_id, :localizable_id, :localizable_type, :street, :city, :state, :country, :postal_code].each do |name|
      remove_column :locations, name;
    end
    add_column :users, :location_id, :integer;
  end
end

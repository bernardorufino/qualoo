class Consumer < ActiveRecord::Base
  include ChildBehavior;
  include Profile;
  
  has_one :location, as: :localizable, dependent: :destroy;
  is_one :user, as: :profile;
  has_many :consumer_salesperson_relationships, conditions: {owner_type: "Consumer"};
  has_many :salespeople, through: :consumer_salesperson_relationships;

  def relates_with
    "Salesperson"
  end
  
  def relates_with?(salesperson)
    salespeople.include?(salesperson.try(:profile));
  end
  
  def network
    relationships.select(&:public?).map(&:salesperson);
  end
  
end

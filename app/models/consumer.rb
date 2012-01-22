class Consumer < ActiveRecord::Base
  include ChildBehavior;
  
  is_one :user, as: :profile;
  has_many :consumer_salesperson_relationships;
  has_many :salespeople, through: :consumer_salesperson_relationships;

  def relates_with
    "Salesperson"
  end
  
  def relates_with?(salesperson)
    salespeople.include?(salesperson);
  end
  
end

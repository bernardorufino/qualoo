class Salesperson < ActiveRecord::Base
  include ChildBehavior;
  
  is_one :user, as: :profile;
  has_many :consumer_salesperson_relationships;
  has_many :consumers, through: :consumer_salesperson_relationships;
  has_many :posts;
  has_many :company_salesperson_contracts;
  has_many :companies, through: :company_salesperson_contracts;
  
  def relates_with
    "Consumer"
  end
  
  def relates_with?(consumer)
    consumers.include?(consumer);
  end
  
end
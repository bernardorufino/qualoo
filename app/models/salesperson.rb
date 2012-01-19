class Salesperson < ActiveRecord::Base
  include ChildBehavior;
  
  is_one :user, as: :profile;
  
  has_many :consumer_salesperson_relationships;
  has_many :consumers, through: :consumer_salesperson_relationships;
  has_many :posts;
  has_many :company_salesperson_contracts;
  has_many :companies, through: :company_salesperson_contracts;
 
  
end

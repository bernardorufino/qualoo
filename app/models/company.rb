class Company < ActiveRecord::Base
  has_many :company_salesperson_contracts;
  has_many :salespeople, :through => :company_salesperson_contracts;
  has_and_belongs_to_many :categories;
  
end

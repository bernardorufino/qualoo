class CompanySalespersonContract < ActiveRecord::Base
  belongs_to :company;
  belongs_to :salesperson;
  
end

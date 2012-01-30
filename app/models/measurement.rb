class Measurement < ActiveRecord::Base
  belongs_to :measurer, class_name: "User";
  belongs_to :measured, class_name: "Salesperson";
  
  validates :level, inclusion: {:in => 0..5};
  validates_presence_of :measured;
  
end

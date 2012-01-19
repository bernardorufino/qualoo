class Measurement < ActiveRecord::Base
  belongs_to :measurer, class_name: "User";
  belongs_to :measured, class_name: "User";
  
end

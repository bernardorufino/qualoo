module ConsumerSalespersonRelationshipsHelper
  
  def visibilities
    Visibility.all.map{|v| [v.name, v.id];};
  end
  
end

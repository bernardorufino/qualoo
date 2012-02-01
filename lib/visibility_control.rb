module VisibilityControl
  
  def self.included(klass)
    klass.send(:delegate, *Visibility::Main.map{|v| v.to_s + "?"}, to: :visibility);
    klass.extend(ClassMethods);
  end
  
  Visibility::Main.each do |v|
    define_method(v.to_s + "!"){self.visibility = Visibility[v]; self.save;}; 
  end
  
  protected
  def default_visibility
    self.visibility = Visibility
  end
  
  module ClassMethods
    
    def default_visibility(v)
      after_initialize do |record|
        record.visibility = Visibility[v] unless record.visibility;
      end
    end
    
  end
  
end
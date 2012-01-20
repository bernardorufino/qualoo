module ChildBehavior

  def self.included(klass)
    klass.extend ClassMethods;
  end
  
  module ClassMethods
    
    def parent_public_methods
      return @parent_public_methods if instance_variable_defined?(:@parent_public_methods);
      @parent_public_methods = @parent_model.public_instance_methods - self.instance_methods - [:id, :id=];
      @parent_public_methods.reject!{|m| m =~ /^_/};
      # Check ActiveModel::AttributeMethods, they map (almost) all methods matching the Regexp bellow 
      # to the attributes provided by *attribute_names*
      # FIX: The lines commented below (16 and 20, specially 20) were causing unknow problems when running rake db:reset
      #attribute_methods = @parent_model.private_instance_methods.select{|m| m =~ /(_|^)attribute(_|[\?!=]?$)/};
      attribute_methods = [:attribute_changed?, :attribute_change, :attribute_was, :attribute_will_change!, :reset_attribute, :attribute, :attribute=, :attribute_before_type_cast, :attribute];
      #attribute_methods = [:attribute_changed?, :attribute?, :attribute, :attribute=];
      @parent_public_methods += (@parent_model.attribute_names - self.attribute_names).map do |attr|
        attribute_methods.map{|m| m.to_s.gsub(/attribute/, attr).to_sym}.select do |m|
          @parent_model.new.respond_to?(m);
        end
      end
      @parent_public_methods.flatten!;
    end
    
    def is_one(parent_model, opts={})
      parent_model = parent_model.to_sym;
      @parent_model = parent_model.to_s.classify.constantize;
      has_one(parent_model, {
        dependent: :destroy,
        autosave: true,
        validate: true
      }.merge(opts));
      delegate(*parent_public_methods, to: parent_model, allow_nil: true);
    end  
    
  end
    
end
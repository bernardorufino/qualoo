module EmbedFormHelper
  
  def self.included(klass)
    klass.extend(ClassMethods);
  end
  
  module ClassMethods
    
    def form_helper(*helpers)
      helpers.flatten.each do |helper|
        ActionView::Helpers::FormBuilder.send(:define_method, helper) do |*args, &block|
          @template.send(helper, @object_name, *args, &block);
        end
      end
    end
    
  end
  
end
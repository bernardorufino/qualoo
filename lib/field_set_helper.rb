module FieldSetHelper
  
  def self.included(klass)
    klass.send :form_helper, :field_set;
  end
  
  def field_set(object_name, attribute, label_name, opts={}, &content)
    if block_given? then input = capture_input_for_fieldset(attribute, opts, &content);      
    else
      input = opts.delete(:type) || :text_field;
      this_opts = {};
      if instance_variable_defined?("@#{object_name}")
        record = instance_variable_get("@#{object_name}");
        if input.to_sym == :password_field and record
          value = record.send(attribute);
          this_opts.merge!(:value => value) if value.present?; 
        end
      end
      input = send(input, object_name, attribute, this_opts.merge(opts.delete(:input) || {}));
    end
    label = label(object_name, attribute, label_name, (opts.delete(:label) || {}));
    field_set_html(input, label, opts);
  end
  
  def field_set_tag(name, label_name, opts={}, &content)
    if block_given? then input = capture_input_for_fieldset(attribute, opts, &content);
    else
      input = opts.delete(:type) || :text_field_tag;
      input = send(input, name, params[name], opts[:input] || {});
      input = ActionView::Base.field_error_proc.call(input, nil) if opts[:error];
    end
    label = label_tag(opts.delete(:input).try(:id) || name, label_name, (opts.delete(:label) || {}));
    label = ActionView::Base.field_error_proc.call(label, nil) if opts.delete(:error);
    field_set_html(input, label, opts);      
  end
  
  def field_set_html(input, label, opts={})
    line_break = (opts.delete(:line_break)) ? "<br />" : "\n";
    content_tag(opts.delete(:tag) || :fieldset, label + line_break + input, opts);
  end
  
  def capture_input_for_fieldset(attribute, opts={}, &content)
    input = capture(attribute, &content);
    unless opts.key?(:block_tag) and !opts[:block_tag]
      this_opts = {:class => "input-info"}.merge(opts.delete(:block) || {});
      input = content_tag(opts.delete(:block_tag) || :span, input, this_opts);
    end
    input;
  end
  
end
module ApplicationHelper
  include EmbedFormHelper;
  include FieldSetHelper;
  
  def before_flash(&code)
    if block_given?
      @before_flash = capture(&code);
    else
      @before_flash || "";
    end
  end
  
  def hidden_fields(object_name, methods, opts={})
    fields = methods.to_a.map do |(method, value)|
      hidden_field(object_name, method, {:value => value}.merge(opts));
    end
    fields.join("\n").html_safe;
  end
  
  def flash_msgs(prefix="flash-")
    flash.to_a.inject("".html_safe) do |code, (type, msg)|
      code + content_tag(:p, msg, :class => prefix + type.to_s);
    end
  end  
  
  # Comment this if you have browser's compatibility problems
  def submit_tag(*args, &block)
    button_tag(*args, &block);
  end
  
  def form_actions(opts={})
    submit = opts.delete(:submit) || "Submeter";
    reset = opts.delete(:reset) || "Resetar";
    submit = (submit) ? submit_tag(submit) : "";
    reset = (reset) ? submit_tag(reset, :type => "reset") : "";
    content_tag(opts.delete(:tag) || :p,  reset + submit, {:class => "actions"}.merge(opts));
  end
  
  # friendly_profile_name in ApplicationControlller ;)
  
  def icon(name, opts={})
    image_tag("icons/#{name}.png", {width: 16, height: 16, class: "icon"}.merge(opts));
  end
  
  def user_icon(user)
    icon({:consumer => "user", :salesperson => "user_suit"}[user.profile_type.downcase.to_sym]);
  end
  
  protected
  class Debug < StandardError; end
  
  def debug(message)
    raise Debug, message;
  end
  
end


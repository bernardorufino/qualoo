module ApplicationHelper
  include EmbedFormHelper;
  include FieldSetHelper;
  
  def flash_msgs(prefix="flash-")
    flash.to_a.inject("".html_safe) do |code, (type, msg)|
      code + content_tag(:p, msg, :class => prefix + type.to_s);
    end
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
  
end


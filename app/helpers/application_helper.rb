module ApplicationHelper
  include EmbedFormHelper;
  include FieldSetHelper;
  
  def page(html_class=nil)
    @html_class = html_class if html_class;
    @html_class || "medium";
  end
  
  def search_buffer
    @_search ||= Search.new(session[:search] || {});      
  end
  
  def search_scopes
    {
      friendly_profile_name(:consumer, plural: true) => "consumers",
      friendly_profile_name(:salesperson, plural: true) => "salespeople",
      "Usuarios" => "users",
      "Marcas" => "companies",
      "Generos" => "categories"      
    };
  end
  
  def main(opts={}, &content)
    main = capture(&content);
    opts.merge!(:class => "with-sidebar") if @sidebar and not @hide_sidebar;
    content_tag(:div, main, {:id => "main"}.merge(opts));    
  end
  
  # Call only once with block for setting up sidebar, the second call will have its block ignored
  # Useful because the second call is at application.html.erb, which is the default
  def sidebar(opts={}, &content)
    @sidebar = content_tag(:div, capture(&content), {:id => "sidebar"}.merge(opts)) if block_given? and !@sidebar;
    (@hide_sidebar) ? "" : (@sidebar || "");
  end
  
  def no_sidebar
    @sidebar = nil;
    @hide_sidebar = true;
  end
  
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
  
  form_helper :hidden_fields;
  
  def flash_msgs(prefix="flash-")
    flash.to_a.inject("".html_safe) do |code, (type, msg)|
      code + content_tag(:p, msg, :class => prefix + type.to_s);
    end
  end  
  
  # Comment this if you have browser's compatibility problems
  def submit_tag(*args, &block)
    button_tag(*args, &block);
  end
  
  def form_actions(opts={}, &content)
    submit = opts.key?(:submit) ? opts.delete(:submit) : "Submeter";
    reset = opts.key?(:reset) ? opts.delete(:reset) : "Resetar";
    submit = (submit) ? submit_tag(submit) : "";
    reset = (reset) ? submit_tag(reset, :type => "reset") : "";
    content = (block_given?) ? capture(&content) : "";
    content_tag(opts.delete(:tag) || :p, (content + reset + submit).html_safe, {:class => "actions"}.merge(opts));
  end
  
  def profile_picture(profile)
    content_tag(:p, :class => "profile-picture") do
      #image_tag(profile.avatar.version(:profile).path, 
      # Uncomment above and comment below when commit to production :)
      image_tag(profile.avatar.path,
        :alt => profile.name,
        :width => Image::Versions[:profile][:resize].first,
        :height => Image::Versions[:profile][:resize].last,
        :class => "profile-picture"
      ) + (if current_user?(profile.user)
        "<br />" + icon("picture") + " " + link_to("Atualizar foto", edit_avatar_path)
      else 
        ""
      end).html_safe;
    end
    
  end
  
  def icon(name, opts={})
    image_tag("icons/#{name}.png", {width: 16, height: 16, class: "icon"}.merge(opts));
  end
  
  def user_icon(user)
    icon({
      :consumer => "user", 
      :salesperson => "user_red",
      :network => "user_green"
    }[classify_user(user)]);
  end
  
  def user_class(user)
    {
      :consumer => "consumer", 
      :salesperson => "salesperson",
      :network => "user-network"
    }[classify_user(user)];    
  end
  
  def user_name(user, path=nil)
    path ||= user_path(user);
    user_icon(user) + " " + link_to(user.name, path, :class => user_class(user));
  end
  
  def current_user_relates_with?(user)
    logged_in? and current_profile.relates_with?(user.profile);
  end
  
  def classify_user(user)
    if user.respond_to?(:profile)
      user = if(current_user_relates_with?(user) && !manage_relationships_path?)
        :network
      else
        to_profile_sym(user);
      end
    end
    user.to_sym;
  end
  
  def parent_layout(layout)
    @view_flow.set(:layout, output_buffer);
    self.output_buffer = render(file: "layouts/#{layout}");
  end
end


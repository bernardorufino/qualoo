class Qualoo::Application
  
  # Include GlobalHelper
  require "#{config.root}/app/helpers/global_helper";
  
  # Extend Sass
  require "#{config.root}/app/assets/stylesheets/sass";

  require "#{config.root}/lib/extend"
  
end
    
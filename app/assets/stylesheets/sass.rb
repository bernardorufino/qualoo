module Sass::Script::Functions
  
  def hexcode(color)
    assert_type color, :Color;
    Sass::Script::String.new(color.to_s.sub(/^./, ""));
  end
  
end
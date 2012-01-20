ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  class_name = "error";
  if /class="/i =~ html_tag
    html_tag.sub(/(class=")/i, "\\1#{class_name} ").html_safe;
  else
    html_tag.sub(/<(\w+) /i, "<\\1 class=\"#{class_name}\" ").html_safe;
  end
end


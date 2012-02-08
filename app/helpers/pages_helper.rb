module PagesHelper
  
  def selected_class(type, guest)
    (guest.profile_type.to_s.downcase == type.to_s.downcase) ? " selected" : "";
  end
  
end

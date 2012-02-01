module LocationsHelper
  
  def distance(a, b)
    a = a.location if a.respond_to?(:location);
    b = b.location if b.respond_to?(:location);
    d = a.distance_from(b.coordinates).to_km;
    format = lambda do |d, u|
      "<span class=\"distance\">#{d}</span><span class=\"unit\">#{u}</span>".html_safe;
    end
    case d
      when 0...1 then format.call((d*1000).round, "m");
      when 1...10 then format.call(d.round(1), "km");
      else format.call(d.round, "km");
    end
  end
  
end

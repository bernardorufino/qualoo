class Location < ActiveRecord::Base
  include VisibilityControl;
  default_visibility :public;
  
  geocoded_by :address;
  
  belongs_to :localizable, polymorphic: true;
  belongs_to :visibility;
  
  validates :postal_code, length: {is: 9}, # It is a mapped String, plus '-' is 9
                          allow_nil: true;  
  
  after_validation :geocode, if: :address_changed?;
  after_validation :fetch_postal_code, if: :fetch_postal_code?;
  
  class CoordinatesAssignment < StandardError; end
  
  def address
    [street, city, state, country].compact.join(", ");
  end
  
  def address_changed?
     new_record? or street_changed? or city_changed? or state_changed? or country_changed?;
  end
  
  def coordinates
    [latitude, longitude];
  end
  
  def latitude=(*args)
    coordinates_assignment_error!;
  end
  
  def longitude=(*args)
    coordinates_assignment_error!;
  end
  
  def postal_code=(postal_code)
    if postal_code.kind_of?(String) and postal_code =~ /^\d{5}-\d{3}/
      write_attribute(:postal_code, postal_code.sub("-", "").to_i);
    else
      super(postal_code);
    end
  end
  
  def postal_code
    postal_code = read_attribute(:postal_code);
    (postal_code) ? "#{postal_code.to_s[0..4]}-#{postal_code.to_s[5..8]}" : nil;
  end
  
  def fetch_postal_code
    self.postal_code = Geocoder.search(coordinates).first.postal_code if (latitude and longitude);
  end
  
  protected
  def fetch_postal_code?
    postal_code.nil? and geocoded?;
  end
  
  def coordinates_assignment_error!
    raise CoordinatesAssignment, "can't assign coordinates manually, specify address instead";
  end
  
end
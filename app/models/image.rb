class Image < ActiveRecord::Base
  ResizerUrl = "http://imageproxy.heroku.com/convert";
  DomainUrl = "http://www.qualoo.com.br"
  DefaultPath = "/images";
  Versions = {
    :profile => {
      resize: [100, 120],
      format: :jpg
      
    },
    :thumbnail => {
      resize: [50, 50],
      format: :jpg
    }
  };
  
  belongs_to :imageable, polymorphic: true;
  
  # Infinite recursion
  # validates_presence_of :imageable;
  validates :file_format, inclusion: %w(jpg gif png jpeg);
  # Implement validation of file for new records (more?)
  
  attr_accessor :file;
  
  after_save :copy_file;
  before_destroy :delete_file;
  
  def self.default(type)
    new(:file => File.new(store_path + "/" + {
      :avatar => "avatar.gif"
    }[type]));
  end
  
  def file
    (@file or not file_exists?) ? @file : File.open(physical_path, "r");
  end
  
  def file=(file)
    delete_file;
    @file = file;
    if @file.respond_to?(:tempfile) # If uploaded file
      self.file_format = extension(@file.original_filename);
      @file = @file.tempfile;
    else # Its a system file
      self.file_format = extension(@file.path);
    end
  end
  
  def path
    @path || original_path;
  end
  
  # Call it this way
  #   i = <Image ...>
  #   i.version(:thumbnail).path
  #
  def version(opts)
    opts = Versions[opts.to_sym] unless opts.is_a?(Hash);
    opts.merge!(source: DomainUrl + original_path);
    @path = "#{ResizerUrl}?#{opts.to_query}";
    new_version = self.clone;
    @path = nil;
    new_version;
  end
  
  protected
  def self.store_path
    Rails.root.to_s + "/public" + DefaultPath;
  end
  
  def original_path
    "#{DefaultPath}/#{id}.#{file_format}";
  end
  
  def physical_path
    Rails.root.to_s + "/public" + original_path
  end
  
  def copy_file
    File.copy_stream(@file, physical_path);
  end
  
  def delete_file
    (File.delete(physical_path) rescue nil) if file_exists?;
  end
  
  def file_exists?
    File.exists?(physical_path);
  end
  
  def extension(path)
    File.extname(path).to_s.downcase.sub(/^./, "")
  end
  
end

class Tag < ActiveRecord::Base
  belongs_to :user;
  has_many :relationship_taggings, dependent: :destroy;
  has_many :consumer_salesperson_relationships, through: :relationship_taggings;

  validates :name, presence: true,
                   uniqueness: {scope: :user_id};

  def relationships
    consumer_salesperson_relationships;
  end

end

class Organisation < ActiveRecord::Base
  validates :slug, uniqueness: true, presence: true

  belongs_to :user
  has_many :profiles

  before_validation :set_slug, unless: :slug

  def to_param
    self.slug
  end

  def set_slug
    self.slug = generate_slug
  end

  def generate_slug(n=1)
    return nil unless self.name
    candidate = self.name.downcase.gsub(/[^a-z0-9]+/, '-')
    candidate += "-#{n}" if n > 1
    return candidate unless Organisation.find_by_slug(candidate)
    generate_slug(n+1)
  end
end

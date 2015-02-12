class Lion < ActiveRecord::Base
  belongs_to :organization

  has_many :image_sets, dependent: :nullify
  belongs_to :primary_image_set, class_name: 'ImageSet'

  validates :name, presence: true

  validate :primary_image_set_in_image_sets

  def self.create_from_image_set(image_set, name)
    lion = Lion.new(
      organization: image_set.organization,
      name: name,
      gender: image_set.gender,
      age: image_set.age
    )

    lion.image_sets << image_set
    lion.primary_image_set = image_set
    lion.save

    lion
  end

  def self.search(search_params)
    if search_params[:age]
      age_int = search_params[:age].to_i
      search_params[:age] = convert_age_to_birthdate(age_int)
    end

    Lion.where(search_params)
  end

  def self.convert_age_to_birthdate(age)
    Date.today - age.years
  end

  def birthdate
    self[:age]
  end

  def age=(val)
    self[:age] = val ? self.class.convert_age_to_birthdate(val.to_i) : val # leave age as nil if not provided
  end

  def age
    return nil unless self[:age]

    difference = (Date.today - self[:age].to_date)/365.to_f.to_i
    difference.to_i
  end

  private

  def primary_image_set_in_image_sets
    if primary_image_set && !image_sets.include?(primary_image_set)
      errors.add(:primary_image_set, 'must be included in image_sets')
    end
  end
end

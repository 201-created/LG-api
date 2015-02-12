class ImageSet < ActiveRecord::Base
  belongs_to :lion

  # organization starts same as uploading_organization but then
  # can be assigned to a different one
  belongs_to :organization, foreign_key: 'owner_organization_id'

  belongs_to :uploading_organization, class_name: 'Organization',
                                      foreign_key: 'uploading_organization_id'
  belongs_to :uploading_user, class_name: 'User',
                              foreign_key: 'uploading_user_id'

  has_many :images, inverse_of: :image_set
  belongs_to  :main_image, class_name: 'Image'

  has_one :cv_request
  has_many :cv_results, through: :cv_request

  accepts_nested_attributes_for :images

  validate :main_image_in_image_set

  def age=(val)
    @age = val.to_i
  end

  private

  def main_image_in_image_set
    if main_image && !images.include?(main_image)
      errors.add(:main_image, 'must be included in images')
    end
  end
end

class ImageSet < ActiveRecord::Base
  belongs_to :lion
  belongs_to :organization, -> { where is_verified: true },
                            foreign_key: 'owner_organization_id'

  belongs_to :uploading_organization, class_name: 'Organization',
                                      foreign_key: 'uploading_organization_id'
  belongs_to :uploading_user, class_name: 'User',
                              foreign_key: 'uploading_user_id'

  has_many :images, inverse_of: :image_set
  belongs_to  :main_image, class_name: 'Image'

  accepts_nested_attributes_for :images
end
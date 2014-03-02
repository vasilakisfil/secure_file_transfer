
class SecureFile < ActiveRecord::Base
  mount_uploader :secure_file, FileUploader

  belongs_to :user
  validates :user_id, presence: true
end


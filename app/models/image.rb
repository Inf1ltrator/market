class Image < ActiveRecord::Base
	belongs_to :imageable, polymorphic: true
	mount_uploader :file, FileUploader
  before_destroy{
    self.remove_file!
  }
end

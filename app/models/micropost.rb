class Micropost < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user 
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size

  private
  def picture_size
    debugger
    if picture.size > 500.kilobytes
      errors.add(:picture, "should be less than 500 kilobyte")
    end
  end
end

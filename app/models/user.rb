class User < ApplicationRecord
  has_attached_file :avatar, styles: { medium: "150x150>", thumb: "50x50>" }, default_url: "/system/users/avatars/missing/photo_:style.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
end

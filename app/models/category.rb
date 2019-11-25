class Category < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true

  has_many :posts, dependent: :destroy
end

class Post < ApplicationRecord

	acts_as_votable

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  has_one_attached :image
end

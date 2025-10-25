class Movie < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :poster
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  acts_as_taggable_on :tags
  validates :title, presence: true
end

class Category < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :movies, through: :categorizations
end

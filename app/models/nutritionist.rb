class Nutritionist < ApplicationRecord
  has_and_belongs_to_many :tags
  has_one_attached :avatar
end

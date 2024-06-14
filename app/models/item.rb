class Item < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :description, presence: true
end

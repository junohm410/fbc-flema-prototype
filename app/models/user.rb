# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true, inclusion: { in: %w[discord] }
end

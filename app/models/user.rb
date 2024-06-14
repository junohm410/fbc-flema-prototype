# frozen_string_literal: true

class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:discord]

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true, inclusion: { in: %w[discord] }

  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash['provider']
    uid = auth_hash['uid']
    name = auth_hash['info']['name']
    avatar = auth_hash['info']['image']

    User.find_or_create_by!(provider:, uid:) do |user|
      user.name = name
      user.avatar = avatar
    end
  end
end

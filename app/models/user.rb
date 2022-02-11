# frozen_string_literal: true

class User < ApplicationRecord
  validates :handle, presence: true, uniqueness: true
  validates :password, presence: true
  validates_inclusion_of :login_count, in: [nil, 0, 1, 2, 3]

  def self.login(params)
    user = User.where(handle: params[:handle]).first
    login_count = user&.login_count
    if user && login_count.to_i < 3
      login_count = if user&.password == params[:password]
                      0
                    else
                      login_count.to_i + 1
                    end
      user.login_count = login_count
      user.save
    end

    login_count
  end
end

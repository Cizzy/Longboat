# frozen_string_literal: true

class UsersController < ApplicationController
  def login
    login_count = User.login(params)
    if !login_count
      redirect_to '/users/index'
    elsif login_count.to_i.zero?
      redirect_to '/users/logout'
    elsif login_count.to_i > 2
      redirect_to '/users/account_locked'
    else
      redirect_to '/users/index'
    end
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users/index'
  get 'users/logout'
  get 'users/account_locked'
  post 'users/login'
end

# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'redirects to the index page if the user does not exist' do
    post users_login_url({ handle: 'invalid', password: 'invalid' })
    assert_redirected_to '/users/index'
  end

  test 'redirects to the logout page on successful login' do
    @user = users(:valid)
    post users_login_url(@user.attributes)
    assert_redirected_to '/users/logout'
  end

  test 'redirects to the account_locked page if the maximum login attempts has been exceeded' do
    @user = users(:invalid)
    post users_login_url(@user.attributes)
    assert_redirected_to '/users/account_locked'
  end

  test 'login_count increments with incorrect password attempts and is reset on successful login' do
    @user = users(:valid)
    assert @user.login_count.nil?
    post users_login_url({ handle: @user.handle, password: 'invalid' })

    @user.reload
    assert @user.login_count == 1
    post users_login_url({ handle: @user.handle, password: 'invalid' })

    @user.reload
    assert @user.login_count == 2
    post users_login_url(@user.attributes)

    @user.reload
    assert @user.login_count.zero?
    assert @user.valid?
  end
end

# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user is valid with a handle and password' do
    user = User.new(handle: 'test_handle', password: 'test_password')
    assert user.valid?
  end

  test 'user is invalid without handle' do
    user = User.new(handle: nil, password: 'test_password')
    assert !user.valid?

    user = User.new(handle: '', password: 'test_password')
    assert !user.valid?
  end

  test 'user is invalid if handle already exists' do
    user = User.new(handle: User.first.handle, password: 'test_password')
    assert !user.valid?
  end

  test 'user is invalid without password' do
    user = User.new(handle: 'test_handle', password: nil)
    assert !user.valid?

    user = User.new(handle: 'test_handle', password: '')
    assert !user.valid?
  end

  test 'user is valid if password already exists' do
    user = User.new(handle: 'test_handle', password: User.first.handle)
    assert user.valid?
  end

  test 'user is valid if login_count is inside the accepted range' do
    user = User.new(handle: 'test_handle', password: 'test_password', login_count: nil)
    assert user.valid?

    user = User.new(handle: 'test_handle', password: 'test_password', login_count: 0)
    assert user.valid?

    user = User.new(handle: 'test_handle', password: 'test_password', login_count: 1)
    assert user.valid?

    user = User.new(handle: 'test_handle', password: 'test_password', login_count: 2)
    assert user.valid?

    user = User.new(handle: 'test_handle', password: 'test_password', login_count: 3)
    assert user.valid?
  end

  test 'user is invalid if login_count is outside the accepted range' do
    user = User.new(handle: 'test_handle', password: 'test_password', login_count: -1)
    assert !user.valid?

    user = User.new(handle: 'test_handle', password: 'test_password', login_count: 4)
    assert !user.valid?
  end
end

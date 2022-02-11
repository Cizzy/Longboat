# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :handle
      t.string :password
      t.integer :login_count

      t.timestamps
    end
  end
end

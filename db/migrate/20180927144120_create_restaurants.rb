# frozen_string_literal: true


class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :cuisine_id
      t.integer :rating, inclusion: { in: 0..3 }
      t.boolean :ten_bis, default: false
      t.string :address
      t.integer :delivery_time

      t.timestamps
    end

    add_index('restaurants', :name)
    add_index('restaurants', :cuisine_id)
  end
end

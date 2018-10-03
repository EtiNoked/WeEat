class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.integer :restaurant_id
      t.integer :rating, inclusion: {in: 0..3}
      t.string :summary, null: false
      t.text :full_review

      t.timestamps
    end
  end
end

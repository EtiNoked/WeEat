class CreateCuisines < ActiveRecord::Migration[5.2]
  def change
    create_table :cuisines do |t|
      t.string :name
      t.string :image_url

      t.timestamps
    end

    add_index('cuisines', :name)

  end
end

class CreateNutritionists < ActiveRecord::Migration[6.0]
  def change
    create_table :nutritionists do |t|
      t.string :name
      t.string :number
      t.string :clinic
      t.string :street
      t.string :city
      t.string :personal_page
      t.integer :price

      t.timestamps
    end
  end
end

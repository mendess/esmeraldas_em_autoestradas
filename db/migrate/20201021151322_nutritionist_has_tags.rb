class NutritionistHasTags < ActiveRecord::Migration[6.0]
  def change
    create_join_table :nutritionists, :tags
  end
end

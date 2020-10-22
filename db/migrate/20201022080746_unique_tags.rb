class UniqueTags < ActiveRecord::Migration[6.0]
  def change
    change_table :tags do |t|
      t.index :name, unique: true
    end
  end
end

class CreateAwardCategories < ActiveRecord::Migration
  def change
    create_table :award_categories do |t|
      t.integer :user_id
      t.string :title

      t.timestamps null: false
    end
  end
end

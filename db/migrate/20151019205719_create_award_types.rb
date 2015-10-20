class CreateAwardTypes < ActiveRecord::Migration
  def change
    create_table :award_types do |t|
      t.integer :user_id
      t.integer :award_category_id
      t.string :title
      t.string :token

      t.timestamps null: false
    end
  end
end

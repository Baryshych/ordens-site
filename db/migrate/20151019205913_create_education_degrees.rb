class CreateEducationDegrees < ActiveRecord::Migration
  def change
    create_table :education_degrees do |t|
      t.integer :user_id
      t.text :title
      t.text :token
      
      t.timestamps null: false
    end
  end
end

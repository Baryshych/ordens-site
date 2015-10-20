class CreateWorkplaces < ActiveRecord::Migration
  def change
    create_table :workplaces do |t|
      t.integer :user_id
      t.text :title
      t.text :address
      t.text :token

      t.timestamps null: false
    end
  end
end

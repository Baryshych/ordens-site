class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :workplace_id
      t.integer :years_worked_total
      t.integer :years_worked_on_current_place
      t.integer :education_degree_id
      t.integer :science_degree_id

      t.date :born_at

      t.boolean :male, default: true

      t.text :education
      t.text :post
      t.text :characteristic
      t.text :archievements
      t.text :special_degree
      t.text :party_membership

      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :nationality
      t.string :home_address
      t.string :home_phone
      t.string :work_phone

      t.timestamps null: false

      t.integer :old_id
    end
  end
end

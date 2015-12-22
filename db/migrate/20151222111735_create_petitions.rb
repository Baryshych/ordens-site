class CreatePetitions < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.integer :petitioner_id
      t.integer :award_id
      
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :nationality
      t.string :home_address
      t.string :home_phone
      t.string :work_phone
      t.string :award_type
      t.string :status

      t.integer :years_worked_total
      t.integer :years_worked_on_current_place
      t.integer :education_degree_id
      t.integer :science_degree_id

      t.date :born_at

      t.boolean :male, default: true

      t.text :education
      t.text :post
      t.text :archievements
      t.text :special_degree
      t.text :party_membership
      t.text :award_cause
      t.text :comment
      t.text :workplace
      t.text :workplace_address

      t.timestamps null: false
    end
  end
end

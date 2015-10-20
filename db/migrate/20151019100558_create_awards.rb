class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.integer :user_id
      t.integer :profile_id
      t.integer :award_type_id
      t.integer :document_quality_id
      t.integer :petition_initiator_id

      t.string :status
      t.string :result

      t.date :comission_date
      t.date :petition_got_at

      t.string :comission_protocol_number
      t.string :registry_petition_number
      
      t.text :award_cause
      
      t.timestamps null: false
      t.integer :old_id
    end
  end
end

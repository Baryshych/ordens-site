class CreatePetitionInitiators < ActiveRecord::Migration
  def change
    create_table :petition_initiators do |t|
      t.integer :user_id
      t.text :title
      t.text :token
      
      t.timestamps null: false
    end
  end
end

class CreateDocumentQualities < ActiveRecord::Migration
  def change
    create_table :document_qualities do |t|
      t.integer :user_id
      t.text :description
      t.text :token

      t.timestamps null: false
    end
  end
end

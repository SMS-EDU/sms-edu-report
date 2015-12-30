# DB Schema in English
class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |school|
      school.text :encrypted_phone_number, :encrypted_name,
                  :encrypted_email, :encoded_nonce
      school.timestamps null: false
    end
  end
end

# DB Schema in English
class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |guardian|
      guardian.text :encrypted_phone_number, :encrypted_name,
                    :encrypted_email, :encoded_nonce
      guardian.timestamps null: false
    end
  end
end

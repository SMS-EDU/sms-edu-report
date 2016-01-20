# DB Schema in English
class CreateUploaders < ActiveRecord::Migration
  def change
    create_table :uploaders do |uploader|
      uploader.belongs_to :school, index: true
      uploader.text :encrypted_first_name, :encrypted_last_name,
                    :encrypted_email, :encrypted_phone_number,
                    :hashed_password, :encoded_nonce, :encoded_salt
      uploader.timestamps null: false
    end
  end
end

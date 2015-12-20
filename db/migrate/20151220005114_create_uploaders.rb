# DB Schema in English
class CreateUploaders < ActiveRecord::Migration
  def change
    create_table :uploaders do |uploader|
      uploader.text :encrypted_email, :encrypted_school, :hashed_password,
                    :encoded_nonce, :encoded_salt
      uploader.timestamps null: false
    end
  end
end

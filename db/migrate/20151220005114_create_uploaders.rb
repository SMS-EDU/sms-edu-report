# DB Schema in English
class CreateUploaders < ActiveRecord::Migration
  def change
    create_table :uploaders do |uploader|
      uploader.text :encrypted_email, :encrypted_school, :encrypted_nonce,
                    :hashed_password, :salt
      uploader.timestamps null: false
    end
  end
end

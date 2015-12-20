# DB Schema in English
class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |record|
      record.text :encrypted_uploader_email, :record_type,
                  :encrypted_record_json, :encrypted_nonce
      record.timestamps null: false
    end
  end
end

# DB Schema in English
class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |record|
      record.text :encrypted_uploader_email, :record_type, :encoded_nonce
      record.text :encrypted_record_json, limit: 4_294_967_295
      record.timestamps null: false
    end
  end
end

# DB Schema in English
class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |record|
      record.belongs_to :uploader, index: true
      record.text :record_type, :encrypted_session, :encrypted_term,
                  :encrypted_class, :encrypted_record_json, :encoded_nonce
      record.text :sent?, default: false
      record.timestamps null: false
    end
  end
end

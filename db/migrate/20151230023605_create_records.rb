# DB Schema in English
class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |record|
      record.belongs_to :student, index: true
      record.belongs_to :uploader, index: true
      record.text :record_type, :encrypted_session, :encrypted_term,
                  :encrypted_class, :encrypted_record_json, :encoded_nonce
      record.timestamps null: false
    end
  end
end

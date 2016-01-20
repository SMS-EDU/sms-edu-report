# DB Schema in English
class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |student|
      student.belongs_to :school, index: true
      student.belongs_to :guardian, index: true
      student.text :encrypted_first_name, :encrypted_last_name,
                   :encrypted_student_school_id, :encoded_nonce
      student.timestamps null: false
    end
  end
end

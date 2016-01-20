# Service Object to save students
class SaveStudentsToDB
  def initialize(params)
    doc = CSV.read(params['file'][:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    @students_hashes = values.map { |value| keys.zip(value).to_h }
  end

  def call
    @students_hashes.each do |student_hash|
      student = Student.new
      student.student_school_id = student_hash['student_school_id']
      student.last_name = student_hash['last_name']
      student.first_name = student_hash['first_name']
      student.school_id = student_hash['school_id']
      student.guardian_id = student_hash['guardian_id']
      student.save
    end
  end
end

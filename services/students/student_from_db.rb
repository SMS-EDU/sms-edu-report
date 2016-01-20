# Service Object to retrieve a student
class StudentFromDB
  def initialize(params)
    arr =
    if params[:school_id]
      [:school_id, params[:school_id].to_i]
    elsif params[:guardian_id]
      [:guardian_id, params[:guardian_id].to_i]
    end
    @search, @query_param = *arr
  end

  def call
    students = find_students
    return nil if students.empty?
    students.map do |st|
      { id: st.id, student_school_id: st.student_school_id,
        last_name: st.last_name, first_name: st.first_name,
        school_id: st.school_id, guardian_id: st.guardian_id }.to_json
    end
  end

  def find_students(results = [])
    return results unless [:school_id, :guardian_id].include? @search
    Student.all.map do |st|
      search = @search == :school_id ? st.school_id : st.guardian_id
      results << st if search == @query_param
    end
    results
  end
end

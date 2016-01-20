# Service Object to retrieve a record
class RecordFromDB
  def initialize(params)
    @uploader_id = uploader_id(params[:uploader_email])
  end

  def call
    records = find_records
    return nil if records.empty?
    records.map do |r|
      { id: r.id, session: r.session, term: r.term, record_type: r.record_type,
        student_class: r.student_class, uploader_id: r.uploader_id,
        sent: r.sent?, record_json: r.record_json }.to_json
    end
  end

  def uploader_id(uploader_email)
    Uploader.all.each { |u| return u.id if u.email == uploader_email }
  end

  def find_records(results = [])
    Record.all.each do |r|
      results << r if r.uploader_id == @uploader_id
    end
    results
  end
end

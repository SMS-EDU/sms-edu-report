# Service Object to retrieve a record
class RecordFromDB
  def initialize(params)
    @uploader_email = params[:uploader_email]
  end

  def call
    records = find_records
    return nil if records.empty?
    records.map do |r|
      { uploader_email: r.uploader_email, record_type: r.record_type,
        record_json: r.record_json }.to_json
    end
  end

  def find_records(results = [])
    Record.all.each do |r|
      results << r if r.uploader_email == @uploader_email
    end
    results
  end
end

# Service Object to save records
class SaveRecordsToDB
  def initialize(params)
    @uploader_id = uploader_id(params[:uploader_email])
    @session = params[:session]
    @term = params[:term]
    @student_class = params[:student_class]
    @record_type = params[:record_type]
    @record_details = record_details(params['file'])
  end

  def uploader_id(uploader_email)
    Uploader.all.each { |u| return u.id if u.email == uploader_email }
  end

  def call
    record = Record.new
    record.session = @session
    record.term = @term
    record.student_class = @student_class
    record.uploader_id = @uploader_id
    record.record_type = @record_type
    record.record_json = @record_details
    record.save
  end

  def record_details(file)
    doc = CSV.read(file[:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    values.map { |value| keys.zip(value).to_h.to_json }.to_s
  end
end

# Service Object to save records
class SaveRecordsToDB
  def initialize(params)
    @uploader_email = params[:uploader_email]
    @record_type = params[:record_type]
    doc = CSV.read(params['file'][:tempfile])
    keys = doc[0]
    values = JSON.parse("#{doc[1..-1]}")
    @record_json = values.map { |value| keys.zip(value).to_h.to_json }.to_s
  end

  def call
    record = Record.new
    record.uploader_email = @uploader_email
    record.record_type = @record_type
    record.record_json = @record_json
    record.save
  end
end

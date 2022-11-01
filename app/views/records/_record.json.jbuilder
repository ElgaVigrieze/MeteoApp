json.extract! record, :id, :station_id, :parameter_id, :time, :value, :created_at, :updated_at
json.url record_url(record, format: :json)

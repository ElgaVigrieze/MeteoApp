module Loaders
  class Record

    def initialize
    end

    def records
      @records ||=
        results.map do |result|
          {
            station_id: find_station_id(result["STATION_ID"]),
            parameter_id: find_parameter_id(result["ABBREVIATION"]),
            time: result["DATETIME"],
            value: result["VALUE"]
          }
        end
    end

    def find_parameter_id(parameter_code)
      ::Parameter.find_by(code: parameter_code)
    end

    def find_station_id(station_code)
      ::Station.find_by(code: station_code)
    end

    def load!
      ActiveRecord::Base.transaction do
        delete_records
        save_records
      end

      true
    end

    def load
      ActiveRecord::Base.transaction do
        save_records
      end

      true
    end

    private

    def service
      @service ||= WebServices::Record.new
    end

    def results
      service.results_chomp(service.results)
    end

    def delete_records
      ::Record.delete_all
    end

    def save_records
      records.each do |record|
        record = ::Record.find_or_initialize_by(
          station: record[:station_id],
          parameter: record[:parameter_id],
          time: record[:time],
          value: record[:value]
        )

        record.save!
      end
    end
  end
end

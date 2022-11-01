# require "csv"

# module Loaders
#   class Parameter
#     def text_content
#       @text_content ||= File.read(Rails.root.join("files", "parameters.csv"))
#     end

#     def csv_content
#       @csv_content ||= CSV.read(Rails.root.join("files", "parameters.csv"))
#     end

#     def save_records
#       csv_content.each do |line|
#         parameter = ::Parameter.find_or_initialize_by(
#           name: line[1],
#           code: line[0],
#           measuring_unit: line[7]
#         )
    
#          puts parameter
#       # station.save!
#       end
#     end
#   end
# end

# # https://ruby-doc.org/stdlib-3.0.0/libdoc/csv/rdoc/CSV.html

module Loaders
  class Parameter

    def initialize
    end

    def records
      @records ||=
        results.map do |result|
          {
            name: result["EN_DESCRIPTION"],
            code: result["ABBREVIATION"],
            measuring_unit: result["MEASUREMENT_UNIT"],
          }
        end
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
      @service ||= WebServices::Parameter.new
    end

    def results
      service.results_chomp(service.results)
    end

    def delete_records
      ::Parameter.delete_all
    end

    def save_records
      records.each do |record|
        parameter= ::Parameter.find_or_initialize_by(
          name: record[:name],
          code: record[:code],
          measuring_unit: record[:measuring_unit]
        )

         parameter.save!
      end
    end
  end
end

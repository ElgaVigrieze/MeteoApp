require "csv"

module Loaders
  class Station
    def text_content
      @text_content ||= File.read(Rails.root.join("files", "stations.csv"))
    end

    def csv_content
      @csv_content ||= CSV.read(Rails.root.join("files", "stations.csv"))
    end

def save_records
  csv_content.each do |line|
    station = ::Station.find_or_initialize_by(
      name: line[1],
      code: line[0]
  )
    station.save!
  end
end

end
end

# https://ruby-doc.org/stdlib-3.0.0/libdoc/csv/rdoc/CSV.html

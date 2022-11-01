module Loaders
  class RubyGem
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def records
      @records ||=
        results.map do |result|
          {
            name: name,
            number: result["number"],
            downloads_count: result["downloads_count"]
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
      @service ||= WebServices::RubyGem.new(name)
    end

    def results
      service.results
    end

    def delete_records
      ::RubyGem.delete_all
    end

    def save_records
      records.each do |record|
        ruby_gem = ::RubyGem.find_or_initialize_by(
          name: record[:name],
          version_number: record[:number],
          downloads_count: record[:downloads_count]
        )

        ruby_gem.save!
      end
    end
  end
end

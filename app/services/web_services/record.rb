module WebServices
  class Record

    def initialize
    end


    def results
      if response.is_a?(Net::HTTPSuccess)
        case content_kind
        when :xml then xml_document(response.body)
        when :json then json_document(response.body)
        else
          response.body
        end
      else
        response.to_s
      end
    end

    def results_chomp(results)
      results["result"]["records"]
    end

    private

    def response
      @response ||= Net::HTTP.get_response(uri)
    end

    def content_type
      @content_type ||= response.header["content-type"]
    end

    def content_kind
      return :text unless content_type
      # binding.pry
      return :xml if (content_type =~ %r{application\/xml|text\/xml}im).present?
      return :json if (content_type =~ %r{\Aapplication\/json}i).present?

      :text
    end


    def uri
      @uri ||= URI(url)
    end

    def url
      # @url ||= "https://data.gov.lv/dati/api/3/action/datastore_search?resource_id=ecc62e27-2071-483c-bca9-5e53d979faa8&limit=10000"
      @url ||="https://data.gov.lv/dati/api/3/action/datastore_search?resource_id=ecc62e27-2071-483c-bca9-5e53d979faa8&limit=500000"
    end

    def xml_document(content)
      xml = Nokogiri::XML(content)
      xml.encoding = "utf-8"
      xml
    end

    # :reek:UtilityFunction
    def json_document(content)
      JSON.parse(content)
    end

  end
end

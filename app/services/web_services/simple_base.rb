module WebServices
  class SimpleBase
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def results
      if response.is_a?(Net::HTTPSuccess)
        response.body
      else
        response.to_s
      end
    end

    private

    def response
      @response ||= Net::HTTP.get_response(uri)
    end

    def uri
      @uri ||= URI(url)
    end

    def url
      @url ||= "https://rubygems.org/api/v1/versions/#{name}.json"
    end
  end
end

# https://ruby-doc.org/stdlib-3.1.2/libdoc/net/http/rdoc/Net/HTTP.html

# Alternative: https://github.com/jnunemaker/httparty

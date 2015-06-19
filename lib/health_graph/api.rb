module HealthGraph
  module API

    def get(path, accept_header, params = {})
      request(:get, accept_header, path, params)
    end

    def post(path, accept_header, params = {})
      request(:post, accept_header, path, params)
    end

    def put(path, accept_header, params = {})
      request(:put, accept_header, path, params)
    end

    def delete(path, accept_header, params = {})
      request(:delete, accept_header, path, params)
    end

    private

    def request(method, accept_header, path, params)
      response = connection(method).send(method) do |request|

        unless access_type.nil?
          request.headers['Authorization'] = "Basic #{access_token}"
        else
          request.headers['Authorization'] = "Bearer #{access_token}"
        end

        case method.to_sym
        when :get, :delete
          request.headers['Accept'] = accept_header
          request.url(path, params)
        when :put, :post
          request.headers['Content-Type'] = accept_header
          request.path = path
          request.body = params.to_json unless params.empty?
        end
      end

      raise 'Empty response body' if response.body.nil?
      raise response.body.reason if response.body.reason

      response
    end

    def connection method
      merged_options = HealthGraph.faraday_options.merge({
        url: HealthGraph.endpoint
      })

      Faraday.new(merged_options) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use FaradayMiddleware::EncodeJson if method == :post
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
        builder.adapter(HealthGraph.adapter)
      end
    end
  end
end

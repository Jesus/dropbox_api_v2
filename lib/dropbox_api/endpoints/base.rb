# frozen_string_literal: true
module DropboxApi::Endpoints
  class Base
    def self.add_endpoint(name, &block)
      define_method(name, block)
      DropboxApi::Client.add_endpoint(name, self)
    end

    private

    def perform_request(params)
      process_response(get_response(params))
    end

    def get_response(*args)
      run_request(*build_request(*args))
    end

    def process_response(raw_response)
      # Official Dropbox documentation for HTTP error codes:
      # https://www.dropbox.com/developers/documentation/http/documentation#error-handling
      case raw_response.status
      when 200, 409
        # Status code 409 is "Endpoint-specific error". We need to look at
        # the response body to build an exception.
        build_result(raw_response.env[:api_result])
      when 429
        error = DropboxApi::Errors::TooManyRequestsError.build(
          raw_response.env[:api_result]['error_summary'],
          raw_response.env[:api_result]['error']['reason']
        )

        error.retry_after = raw_response.headers['retry-after'].to_i

        raise error
      else
        raise(
          DropboxApi::Errors::HttpError,
          "HTTP #{raw_response.status}: #{raw_response.body}"
        )
      end
    end

    def build_result(api_result)
      result_builder = DropboxApi::ResultBuilder.new(api_result)

      if result_builder.has_error?
        raise result_builder.build_error(self.class::ErrorType)
      else
        result_builder.build(self.class::ResultType)
      end
    end

    def run_request(body, headers)
      @connection.run_request(
        self.class::Method,
        self.class::Path,
        body,
        headers
      )
    end
  end
end

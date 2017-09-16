module DropboxApi::Endpoints
  class ContentUpload < DropboxApi::Endpoints::Base
    def initialize(builder)
      @connection = builder.build("https://content.dropboxapi.com") do |c|
        c.response :decode_result
      end
    end

    def build_request(params, content)
      # TODO: It would be better to have a stream object on which we can call
      #       #read, rather than the full file content.
      body = content
      headers = {
        'Dropbox-API-Arg' => JSON.dump(params),
        'Content-Type' => 'application/octet-stream'
      }
      if body.respond_to?(:length)
        headers['Content-Length'] = body.length.to_s
      elsif body.respond_to?(:stat)
        headers['Content-Length'] = body.stat.size.to_s
      end

      return body, headers
    end

    def perform_request(params, content)
      process_response(get_response(params, content))
    end
  end
end

# frozen_string_literal: true
module DropboxApi::MiddleWare
  class PathRoot < Faraday::Middleware
    HEADER_NAME = 'Dropbox-API-Path-Root'

    def initialize(app, options = {})
      super(app)
      @options = options
    end

    def namespace_id
      if options[:namespace_id].nil?
        return nil
      else
        return options[:namespace_id]
      end
    end

    def namespace_id_header_value
      JSON.dump(
        DropboxApi::Metadata::NamespaceId.new({
          'namespace_id' => namespace_id
        }).to_hash
      )
    end

    def call(env)
      if !namespace_id.nil?
        env[:request_headers][HEADER_NAME] ||= namespace_id_header_value
      end

      @app.call env
    end
  end
end

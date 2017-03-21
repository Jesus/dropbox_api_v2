module DropboxApi::Endpoints::Files
  class UploadSessionStart < DropboxApi::Endpoints::ContentUpload
    Method      = :post
    Path        = "/2/files/upload_session/start".freeze
    ResultType  = DropboxApi::Results::UploadSessionStart
    ErrorType   = nil

    include DropboxApi::Endpoints::OptionsValidator

    # Upload sessions allow you to upload a single file in one or more
    # requests, for example where the size of the file is greater than 150 MB.
    #
    # This call starts a new upload session with the given data. You can then
    # use {Client#upload_session_append_v2} to add more data and
    # {Client#upload_session_finish} to save all the data to a file in Dropbox.
    #
    # A single request should not upload more than 150 MB of file contents.
    #
    # @option options close [Boolean] If +true+, the current session will be
    #   closed, at which point you won't be able to call
    #   {Client#upload_session_append_v2} anymore with the current session.
    #   The default for this field is +false+.
    # @return [DropboxApi::Metadata::UploadSessionCursor] The session cursor
    #   that you can use to continue the upload afterwards.
    add_endpoint :upload_session_start do |content, options = {}|
      validate_options([
        :close
      ], options)

      session = perform_request(options, content)

      DropboxApi::Metadata::UploadSessionCursor.new({
        "session_id" => session.session_id,
        "offset" => content.bytesize
      })
    end
  end
end

module DropboxApi::Endpoints::Files
  class Upload < DropboxApi::Endpoints::ContentUpload
    Method      = :post
    Path        = "/2/files/upload".freeze
    ResultType  = DropboxApi::Metadata::File
    ErrorType   = DropboxApi::Errors::UploadError

    include DropboxApi::Endpoints::OptionsValidator

    # @method upload(path, content, options = {})
    # Creates a new file.
    #
    # Do not use this to upload a file larger than 150 MB. Instead, create an
    # upload session with #upload_session_start().
    #
    # @example
    #   client = DropboxApi::Client.new
    #   file_content = IO.read "local_image.png"
    #   client.upload "/image.png", file_content
    #   #=> #<DropboxApi::Metadata::File: @name="image.png" ...>
    # @example
    #   client = DropboxApi::Client.new
    #   client.upload "/file.txt", "Contents of a plain text file."
    #   #=> #<DropboxApi::Metadata::File: @name="file.txt" ...>
    # @param path [String] Path in the user's Dropbox to save the file.
    # @param content The contents of the file that will be uploaded. This
    #   could be the result of the +IO::read+ method.
    # @option options mode [:add, :overwrite, :update] Selects what to do if
    #   the file already exists. The default for this union is add.
    # @option options autorename [Boolean] If there's a conflict, as
    #   determined by mode, have the Dropbox server try to autorename the
    #   file to avoid conflict. The default for this field is False.
    # @option options mute [Boolean] Normally, users are made aware of any file
    #   modifications in their Dropbox account via notifications in the client
    #   software. If true, this tells the clients that this modification
    #   shouldn't result in a user notification. The default for this field is
    #   `false`.
    add_endpoint :upload do |path, content, options = {}|
      validate_options([
        :mode,
        :autorename,
        :mute
      ], options)

      perform_request(options.merge({:path => path}), content)
    end
  end
end

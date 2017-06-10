module DropboxApi::Endpoints::Files
  class CopyReferenceGet < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/copy_reference/get".freeze
    ResultType  = DropboxApi::Results::GetCopyReferenceResult
    ErrorType   = DropboxApi::Errors::GetCopyReferenceError

    # Get a copy reference to a file or folder.
    # This reference string can be used to save that file or folder
    # to another user's Dropbox by passing it to {Client#copy_reference_save}.
    #
    # @param path [String] The path to the file or folder you want to get a
    #   copy reference to.
    # @return [DropboxApi::Results::GetCopyReferenceResult]
    add_endpoint :copy_reference_get do |path|
      perform_request({
        :path => path
      })
    end
  end
end

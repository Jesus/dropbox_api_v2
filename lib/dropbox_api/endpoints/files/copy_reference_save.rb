module DropboxApi::Endpoints::Files
  class CopyReferenceSave < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/copy_reference/save".freeze
    ResultType  = DropboxApi::Results::SaveCopyReferenceResult
    ErrorType   = DropboxApi::Errors::SaveCopyReferenceError

    # Save a copy reference returned by {Client#copy_reference_get} to the
    # user's Dropbox.
    #
    # @param copy_reference [String] A copy reference returned by
    #   {Client#copy_reference_get}.
    # @param path [String] Path in the user's Dropbox that is the destination.
    # @return [DropboxApi::Results::SaveCopyReferenceResult]
    add_endpoint :copy_reference_save do |copy_reference, path|
      perform_request({
        :copy_reference => copy_reference,
        :path => path
      })
    end
  end
end

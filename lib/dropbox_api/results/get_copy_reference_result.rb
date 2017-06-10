module DropboxApi::Results
  class GetCopyReferenceResult < DropboxApi::Results::Base
    # Metadata of the file or folder.
    def resource
      @resource ||= DropboxApi::Metadata::Resource.new @data["metadata"]
    end

    # A copy reference to the file or folder.
    def copy_reference
      @copy_reference ||= @data["copy_reference"]
    end

    # The expiration date of the copy reference.
    # This value is currently set to be far enough in the future
    # so that expiration is effectively not an issue.
    def expires
      @expires ||= Time.parse(@data["expires"])
    end
  end
end

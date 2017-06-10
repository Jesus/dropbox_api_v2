module DropboxApi::Results
  class SaveCopyReferenceResult < DropboxApi::Results::Base
    # The saved file or folder in the user's Dropbox.
    def resource
      @resource ||= DropboxApi::Metadata::Resource.new @data["metadata"]
    end
  end
end

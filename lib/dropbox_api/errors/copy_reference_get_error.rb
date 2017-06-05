module DropboxApi::Errors
  class CopyReferenceGetError < BasicError
    ErrorSubtypes = {
      :path => LookupError
    }.freeze
  end
end

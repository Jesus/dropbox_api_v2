module DropboxApi::Errors
  class GetCopyReferenceError < BasicError
    ErrorSubtypes = {
      :path => LookupError
    }.freeze
  end
end

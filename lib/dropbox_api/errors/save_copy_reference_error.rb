module DropboxApi::Errors
  class SaveCopyReferenceError < BasicError
    ErrorSubtypes = {
      :path => WriteError,
      :invalid_copy_reference => InvalidCopyReferenceError,
      :no_permission => NoPermissionError,
      :not_found => NotFoundError,
      :too_many_files => TooManyFilesError
    }.freeze
  end
end

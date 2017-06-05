module DropboxApi::Errors
  class BasicError < StandardError
    def initialize(message, metadata)
      @metadata = metadata
      super message
    end

    class << self
      def build(message, metadata)
        subtype, metadata = find_subtype metadata

        if subtype.nil?
          new message, metadata
        else
          subtype.build message, metadata
        end
      end

      def find_subtype(metadata)
        if defined? self::ErrorSubtypes
          discriminator = metadata[".tag"]
          metadata = metadata[discriminator] unless metadata[discriminator].nil?
          [self::ErrorSubtypes[discriminator.to_sym], metadata]
        else
          [nil, metadata]
        end
      end
    end
  end

  class BadPathError < BasicError; end
  class CantCopySharedFolderError < BasicError; end
  class CantMoveFolderIntoItselfError < BasicError; end
  class CantNestSharedFolderError < BasicError; end
  class CantShareOutsideTeamError < BasicError; end
  class ContainsSharedFolderError < BasicError; end
  class CursorClosedError < BasicError; end
  class CursorNotClosedError < BasicError; end
  class DisallowedNameError < BasicError; end
  class DisallowedSharedLinkPolicyError < BasicError; end
  class DownloadFailedError < BasicError; end
  class EmailUnverifiedError < BasicError; end
  class FileAncestorConflictError < BasicError; end
  class FileConflictError < BasicError; end
  class FolderConflictError < BasicError; end
  class GroupDeletedError < BasicError; end
  class GroupNotOnTeamError < BasicError; end
  class InProgressError < BasicError; end
  class InsideAppFolderError < BasicError; end
  class InsideOsxPackageError < BasicError; end
  class InsidePublicFolderError < BasicError; end
  class InsideSharedFolderError < BasicError; end
  class InsufficientPlanError < BasicError; end
  class InsufficientSpaceError < BasicError; end
  class InternalError < BasicError; end
  class InvalidCommentError < BasicError; end
  class InvalidCopyReferenceError < BasicError; end
  class InvalidCursorError < BasicError; end
  class InvalidDropboxIdError < BasicError; end
  class InvalidEmailError < BasicError; end
  class InvalidFileError < BasicError; end
  class InvalidIdError < BasicError; end
  class InvalidMemberError < BasicError; end
  class InvalidPathError < BasicError; end
  class InvalidRevisionError < BasicError; end
  class InvalidSettingsError < BasicError; end
  class InvalidUrlError < BasicError; end
  class IsAppFolderError < BasicError; end
  class IsFileError < BasicError; end
  class IsFolderError < BasicError; end
  class IsOsxPackageError < BasicError; end
  class IsPublicFolderError < BasicError; end
  class MalformedPathError < BasicError; end
  class NoAccountError < BasicError; end
  class NoPermissionError < BasicError; end
  class NoWritePermissionError < BasicError; end
  class NotAMemberError < BasicError; end
  class NotFileError < BasicError; end
  class NotFolderError < BasicError; end
  class NotFoundError < BasicError; end
  class RateLimitError < BasicError; end
  class RestrictedContentError < BasicError; end
  class SharedLinkAlreadyExistsError < BasicError; end
  class TeamFolderError < BasicError; end
  class TeamPolicyDisallowsMemberPolicyError < BasicError; end
  class TooManyFilesError < BasicError; end
  class TooManyMembersError < BasicError; end
  class TooManyPendingInvitesError < BasicError; end
  class TooManySharedFolderTargetsError < BasicError; end
  class UnmountedError < BasicError; end
  class UnsupportedContentError < BasicError; end
  class UnsupportedExtensionError < BasicError; end
  class UnverifiedDropboxId < BasicError; end
end

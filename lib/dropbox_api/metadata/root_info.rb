# frozen_string_literal: true
module DropboxApi::Metadata
  # Example of a serialized {RootInfo} object:
  #
  # ```json
  # {
  #   ".tag":"user",
  #   "root_namespace_id":"42",
  #   "home_namespace_id":"42"
  # }
  # ```
  class RootInfo < Base
    class << self
      def new(data)
        class_for(data['.tag'].to_sym).new(data)
      end

      private

      def class_for(tag)
        case tag
        when :user
          DropboxApi::Metadata::UserRootInfo
        when :team
          DropboxApi::Metadata::TeamRootInfo
        else
          raise ArgumentError, "Unable to infer type for `#{tag}`"
        end
      end
    end
  end
end

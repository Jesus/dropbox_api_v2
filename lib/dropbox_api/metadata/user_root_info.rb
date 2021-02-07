# frozen_string_literal: true
module DropboxApi::Metadata
  class UserRootInfo < Base
    field :root_namespace_id, String
    field :home_namespace_id, String
  end
end

# frozen_string_literal: true
module DropboxApi::Metadata
  class TeamRootInfo < Base
    field :root_namespace_id, String
    field :home_namespace_id, String
    field :home_path, String
  end
end

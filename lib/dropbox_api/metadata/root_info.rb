module DropboxApi::Metadata
  # Example of a serialized {BasicAccount} object:
  #
  # ```json
  # {
  #   root_namespace_id: 7,
  #   home_namespace_id: 1,
  #   home_path: "/Franz Ferdinand"
  # }
  # ```
  class RootInfo < Base
    field :root_namespace_id, String
    field :home_namespace_id, String
    field :home_path, String
  end
end

# frozen_string_literal: true
module DropboxApi::Metadata
  class NamespaceId < Base
    field :namespace_id, String

    def to_hash
      super.merge({".tag": 'namespace_id'})
    end
  end
end

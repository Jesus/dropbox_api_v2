module DropboxApi::Endpoints::Files
  class Search < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/search_v2".freeze
    ResultType  = DropboxApi::Results::SearchResult
    ErrorType   = DropboxApi::Errors::SearchError

    include DropboxApi::OptionsValidator

    # Searches for files and folders.
    #
    # Note: Recent changes may not immediately be reflected in search results
    # due to a short delay in indexing.
    #
    # @param query [String] The string to search for. The search string is
    #   split on spaces into multiple tokens. For file name searching, the last
    #   token is used for prefix matching (i.e. "bat c" matches "bat cave" but
    #   not "batman car").
    # @param path [String] The path in the user's Dropbox to search.
    # @option options start [Numeric] The starting index within the search
    #   results (used for paging). The default for this field is 0.
    # @option options max_results [Numeric] The maximum number of search
    #   results to return. The default for this field is 100.
    # @option options mode [:filename, :filename_and_content, :deleted_filename]
    #   The search mode. Note that searching file content is only
    #   available for Dropbox Business accounts. The default is filename.
    add_endpoint :search do |query, path = "", options = {}|
      validate_options([
        :start,
        :max_results,
        :mode
      ], options)
      options[:start] ||= 0
      options[:max_results] ||= 100
      options[:mode] ||= :filename

      perform_request options.merge({
        :query => query,
        :path => path
      })
    end
  end
end

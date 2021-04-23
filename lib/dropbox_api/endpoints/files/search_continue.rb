# frozen_string_literal: true
module DropboxApi::Endpoints::Files
  class SearchContinue < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = '/2/files/search/continue_v2'
    ResultType  = DropboxApi::Results::SearchV2Result
    ErrorType   = DropboxApi::Errors::SearchError

    include DropboxApi::OptionsValidator

    # Fetches the next page of search results returned from search:2.
    # Note: search:2 along with search/continue:2 can only be used to retrieve a maximum of 10,000 matches.
    # Recent changes may not immediately be reflected in search results due to a short delay in indexing. 
    # Duplicate results may be returned across pages. Some results may not be returned.


    # @param cursor [String] The cursor returned by your last call to 
    # search:2. Used to fetch the next page of results.
    add_endpoint :search_continue do |cursor|
      perform_request cursor: cursor
    end
  end
end

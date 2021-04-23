# frozen_string_literal: true
module DropboxApi::Results
  class SearchV2Result < DropboxApi::Results::Base
    # A list (possibly empty) of matches for the query.
    def matches
      @matches ||= @data['matches'].map do |match|
        DropboxApi::Metadata::SearchMatchV2.new match
      end
    end

    # Used for paging. If true, indicates there is another page of results
    # available that can be fetched by calling search again.
    def has_more?
      @data['has_more'].to_s == 'true'
    end

    # Pass the cursor into #search_continue to fetch the next page of results.
    # This field is optional.
    def cursor
      @data['cursor']
    end
  end
end

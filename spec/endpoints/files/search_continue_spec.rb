# frozen_string_literal: true
describe DropboxApi::Client, '#search_continue' do
  before :each do
    @client = DropboxApi::Client.new
  end

  before :each do
    VCR.use_cassette('search_continue/search') do
      result = @client.search 'file', { max_results: 1 }
      expect(result.has_more?).to be_truthy
      @cursor = result.cursor
    end
  end

  it 'returns a SearchResult', cassette: 'search_continue/success' do
    result = @client.search_continue(@cursor)

    expect(result).to be_a(DropboxApi::Results::SearchV2Result)
  end
end

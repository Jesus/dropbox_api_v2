# frozen_string_literal: true
describe DropboxApi::Client, '#list_folder' do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :list_folder }
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'returns a ListFolderResult', cassette: 'list_folder/success' do
    result = @client.list_folder ''

    expect(result).to be_a(DropboxApi::Results::ListFolderResult)
  end

  it "raises an error if the file can't be found", cassette: 'list_folder/not_found' do
    expect {
      @client.list_folder '/unexisting_folder'
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end

  it 'returns all entries as metadata objects', cassette: 'list_folder/success' do
    result = @client.list_folder ''

    result.entries.each do |resource|
      expect(resource).to be_a(DropboxApi::Metadata::Base)
    end
  end

  it 'lists entries in shared folder if given', cassette: 'list_folder/success_shared_folder' do
    result = @client.list_shared_links(path: "#{path_prefix}/shared_folder")
    result = @client.list_folder '', shared_link: result.links.first.url

    result.entries.each do |resource|
      expect(resource).to be_a(DropboxApi::Metadata::Base)
    end
    expect(result.entries.map(&:name).inspect).to include('cow.txt')
  end

  it 'raises an argument error with invalid options' do
    expect {
      @client.list_folder '/img.png', invalid_arg: 'value'
    }.to raise_error(ArgumentError)
  end

  context 'with a namespace ID' do
    it 'works with a namespace_id', cassette: 'list_folder/success_with_namespace_id' do
      @client.namespace_id = 70721710
      @client.list_folder '/dropbox_api_fixtures'
    end

    it 'fails with an invalid namespace ID', cassette: 'list_folder/invalid_namespace_id' do
      @client.namespace_id = 938429923

      expect do
        @client.list_folder '/dropbox_api_fixtures'
      end.to raise_error(DropboxApi::Errors::HttpError)
    end

    it 'works if namespace ID is unset ', cassette: 'list_folder/unset_namespace_id' do
      @client.namespace_id = 70721710

      # we expect this to use a namespace ID
      @client.list_folder '/dropbox_api_fixtures'

      @client.namespace_id = nil
      # we expect the next not to use any namespace ID
      @client.list_folder '/dropbox_api_fixtures'
    end
  end
end

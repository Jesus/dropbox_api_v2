# frozen_string_literal: true
describe DropboxApi::Client, '#get_current_account' do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'returns the current account information', cassette: 'get_current_account/success' do
    account = @client.get_current_account

    expect(account).to be_a(DropboxApi::Metadata::BasicAccount)
    expect(account.root_info).to be_a(DropboxApi::Metadata::UserRootInfo)
  end
end

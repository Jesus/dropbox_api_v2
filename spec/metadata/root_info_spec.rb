# frozen_string_literal: true
context DropboxApi::Metadata::RootInfo do
  it 'can be initialized as a UserRootInfo' do
    metadata = {
      '.tag' => 'user',
      'root_namespace_id' => '42',
      'home_namespace_id' => '42'
    }

    resource = DropboxApi::Metadata::RootInfo.new metadata

    expect(resource).to be_a(DropboxApi::Metadata::UserRootInfo)
  end

  it 'can be initialized as a TeamRootInfo' do
    metadata = {
      '.tag' => 'team',
      'root_namespace_id' => '42',
      'home_namespace_id' => '42',
      'home_path' => '/'
    }

    resource = DropboxApi::Metadata::RootInfo.new metadata

    expect(resource).to be_a(DropboxApi::Metadata::TeamRootInfo)
  end
end

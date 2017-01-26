class DropboxScaffoldBuilder
  PREFIX = "/dropbox_api_fixtures"

  def clobber(endpoint_name)
    client.delete(endpoint_prefix endpoint_name)
  rescue DropboxApi::Errors::NotFoundError
    false
  end

  def generate(endpoint_name)
    send endpoint_name
  end

  def client
    @client ||= DropboxApi::Client.new
  end

  def get_metadata
    prefix = endpoint_prefix :get_metadata

    client.upload("#{prefix}/file.txt", "This is a test file.", {
      :client_modified => Time.new(1988, 12, 8, 1, 1, 0, "+00:00")
    })
    client.create_folder("#{prefix}/folder")
    client.upload("#{prefix}/deleted_file.txt", "This is a test file.")
    client.delete("#{prefix}/deleted_file.txt")
  end

  private

  def endpoint_prefix(endpoint_name)
    File.join PREFIX, endpoint_name.to_s
  end
end

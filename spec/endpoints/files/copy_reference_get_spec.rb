describe DropboxApi::Client, "#copy_reference_get" do
  before :each do
    @client = DropboxApi::Client.new
  end

  context "on a file" do
    it "returns a copy reference", :cassette => "copy_reference_get/success_file" do
      result = @client.copy_reference_get "/file.txt"

      expect(result).to be_a(DropboxApi::Results::GetCopyReferenceResult)
      expect(result.resource.name).to eq("file.txt")
      expect(result.copy_reference).to be_a(String)
      expect(result.expires).to be_a(Time)
    end
  end

  context "on a folder" do
    it "returns a copy reference", :cassette => "copy_reference_get/success_folder" do
      result = @client.copy_reference_get("/folder")

      expect(result).to be_a(DropboxApi::Results::GetCopyReferenceResult)
      expect(result.resource.name).to eq("folder")
      expect(result.copy_reference).to be_a(String)
      expect(result.expires).to be_a(Time)
    end
  end

  context "if the path doesn't exist" do
    it "raises an error", :cassette => "copy_reference_get/not_found" do
      expect {
        @client.copy_reference_get("/c.jpg")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end
  end
end

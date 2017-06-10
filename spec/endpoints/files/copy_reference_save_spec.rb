describe DropboxApi::Client, "#copy_reference_save" do
  before :each do
    @client = DropboxApi::Client.new
    # Taken from fixture (copy_reference_get/success_file.yml)
    @copy_reference = "WI-v4zliNDByb3JwejZlNw"
  end

  context "when a file is being referenced" do
    it "returns the saved file", :cassette => "copy_reference_save/success_file" do
      result = @client.copy_reference_save @copy_reference, "/copied-file.txt"

      expect(result).to be_a(DropboxApi::Results::SaveCopyReferenceResult)
      expect(result.resource.name).to eq("copied-file.txt")
    end
  end

  context "when a folder is being referenced" do
    it "returns the saved folder", :cassette => "copy_reference_save/success_folder" do
      # Taken from fixture (copy_reference_get/success_folder.yml)
      copy_reference = "WI-v42h5NWxnbDZ2enpjbw"
      result = @client.copy_reference_save copy_reference, "/copied-folder"

      expect(result).to be_a(DropboxApi::Results::SaveCopyReferenceResult)
      expect(result.resource.name).to eq("copied-folder")
    end
  end

  context "if the path is already in use by another resource" do
    it "raises an error", :cassette => "copy_reference_save/conflict" do
      expect {
        @client.copy_reference_save @copy_reference, "/copied-file.txt"
      }.to raise_error(DropboxApi::Errors::FileConflictError)
    end
  end

  context "if the copy reference is invalid" do
    it "raises an error", :cassette => "copy_reference_save/invalid_reference" do
      expect {
        @client.copy_reference_save "invalid-reference", "/copied-file.txt"
      }.to raise_error(DropboxApi::Errors::InvalidCopyReferenceError)
    end
  end

  context "if the path is malformed" do
    it "raises an error", :cassette => "copy_reference_save/malformed_path" do
      expect {
        @client.copy_reference_save @copy_reference, "//copied-file.txt"
      }.to raise_error(DropboxApi::Errors::MalformedPathError)
    end
  end

  context "if the user doesn't have permission to save the copy reference" do
    it "raises an error", :cassette => "copy_reference_save/no_permission" do
      expect {
        @client.copy_reference_save @copy_reference, "/copied-file.txt"
      }.to raise_error(DropboxApi::Errors::NoPermissionError)
    end
  end

  context "if the referenced resource has been deleted" do
    it "raises an error", :cassette => "copy_reference_save/not_found" do
      expect {
        @client.copy_reference_save @copy_reference, "/copied-file.txt"
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end
  end
end

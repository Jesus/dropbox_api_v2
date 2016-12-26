context DropboxApi::Endpoints::Files do
  before :each do
    @client = DropboxApi::Client.new
  end

  describe "#copy" do
    it "returns the copied file on success", :cassette => "copy/success" do
      file = @client.copy("/a.jpg", "/b.jpg")

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("b.jpg")
    end

    it "raises an error if the file can't be found", :cassette => "copy/not_found" do
      expect {
        @client.copy("/z.jpg", "/b.jpg")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end

    it "raises an error if the path is invalid", :cassette => "copy/malformed_path" do
      expect {
        @client.copy("/../invalid_path.jpg", "/b.jpg")
      }.to raise_error(DropboxApi::Errors::MalformedPathError)
    end
  end

  describe "#create_folder" do
    it "returns the new folder on success", :cassette => "create_folder/success" do
      folder = @client.create_folder("/arizona_baby")

      expect(folder).to be_a(DropboxApi::Metadata::Folder)
      expect(folder.name).to eq("arizona_baby")
    end

    it "raises an error if the name is invalid", :cassette => "create_folder/malformed_path" do
      expect {
        @client.create_folder("/arizona\\baby")
      }.to raise_error(DropboxApi::Errors::MalformedPathError)
    end

    it "raises an error if the resource causes a conflict", :cassette => "create_folder/conflict" do
      expect {
        @client.create_folder("/b.jpg")
      }.to raise_error(DropboxApi::Errors::FileConflictError)
    end
  end

  describe "#delete" do
    it "returns the deleted resource", :cassette => "delete/success_folder" do
      folder = @client.delete("/arizona_baby")

      expect(folder).to be_a(DropboxApi::Metadata::Folder)
      expect(folder.name).to eq("arizona_baby")
    end

    it "returns the deleted resource", :cassette => "delete/success_file" do
      file = @client.delete("/b.jpg")

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("b.jpg")
    end

    it "raises an error if the name is invalid", :cassette => "delete/not_found" do
      expect {
        @client.delete("/unexisting folder")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end
  end

  describe "#download" do
    it "returns the file", :cassette => "download/success" do
      file = @client.download "/file.txt"

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("file.txt")
    end

    it "yields the file contents", :cassette => "download/success" do
      file_contents = ""
      file = @client.download "/file.txt" do |chunk|
        file_contents << chunk
      end

      expect(file_contents).to eq("Viva Rusia!\n")
    end

    it "raises an error if the name is invalid", :cassette => "download/not_found" do
      expect {
        @client.download("/c.jpg")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end
  end

  describe "#get_metadata" do
    it "may return a `File`", :cassette => "get_metadata/success_file" do
      file = @client.get_metadata("/file.txt")

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("file.txt")
    end

    it "parse time specific fields", :cassette => "get_metadata/success_file" do
      file = @client.get_metadata("/file.txt")

      expect(file.client_modified).to eq(Time.new(2016, 05, 01, 1, 1, 0, "+00:00"))
      expect(file.server_modified).to eq(Time.new(2016, 05, 01, 1, 1, 0, "+00:00"))
    end

    it "may return a `Folder`", :cassette => "get_metadata/success_folder" do
      folder = @client.get_metadata("/folder")

      expect(folder).to be_a(DropboxApi::Metadata::Folder)
      expect(folder.name).to eq("folder")
    end

    it "raises an error if the path is wrong", :cassette => "get_metadata/not_found" do
      expect {
        @client.get_metadata("/unexisting_folder")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end

    it "raises an error if an invalid option is given" do
      expect {
        @client.get_metadata("/file.txt", :invalid_option => true)
      }.to raise_error ArgumentError
    end

    context "on a deleted file" do
      it "raises an error", :cassette => "get_metadata/deleted" do
        expect {
          @client.get_metadata("/file.txt")
        }.to raise_error(DropboxApi::Errors::NotFoundError)
      end

      it "with `:include_deleted`, returns a `File`", :cassette => "get_metadata/success_deleted" do
        file = @client.get_metadata("/file.txt", :include_deleted => true)

        expect(file).to be_a(DropboxApi::Metadata::Deleted)
        expect(file.name).to eq("file.txt")
      end
    end
  end

  describe "#get_preview" do
    it "returns the file", :cassette => "get_preview/success" do
      file = @client.get_preview("/file.docx")

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("file.docx")
    end

    it "raises an error if the name is invalid", :cassette => "get_preview/not_found" do
      expect {
        @client.get_preview("/unknown_file.jpg")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end
  end

  describe "#get_temporary_link", :cassette => "get_temporary_link/success" do
    it "returns a GetTemporaryLinkResult with file and link" do
      result = @client.get_temporary_link "/img.png"

      expect(result).to be_a(DropboxApi::Results::GetTemporaryLinkResult)
      expect(result.file.name).to eq("img.png")
    end

    it "raises an error if the file can't be found", :cassette => "get_temporary_link/not_found" do
      expect {
        @client.get_preview "/unknown_file.jpg"
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end
  end

  describe "#get_thumbnail", :cassette => "get_thumbnail/success" do
    it "returns a file" do
      file = @client.get_thumbnail "/img.png"

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("img.png")
    end

    it "raises an error if the file can't be found", :cassette => "get_thumbnail/not_found" do
      expect {
        @client.get_thumbnail "/unknown_file.jpg"
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end

    it "raises an argument error with invalid options" do
      expect {
        @client.get_thumbnail "/img.png", :invalid_arg => "value"
      }.to raise_error(ArgumentError)
    end
  end

  describe "#list_folder" do
    it "returns a ListFolderResult", :cassette => "list_folder/success" do
      result = @client.list_folder ""

      expect(result).to be_a(DropboxApi::Results::ListFolderResult)
    end

    it "raises an error if the file can't be found", :cassette => "list_folder/not_found" do
      expect {
        @client.list_folder "/unexisting_folder"
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end

    it "returns all entries as metadata objects", :cassette => "list_folder/success" do
      result = @client.list_folder ""

      result.entries.each do |resource|
        expect(resource).to be_a(DropboxApi::Metadata::Base)
      end
    end

    it "raises an argument error with invalid options" do
      expect {
        @client.list_folder "/img.png", :invalid_arg => "value"
      }.to raise_error(ArgumentError)
    end
  end

  describe "#list_revisions" do
    it "returns a ListRevisionsResult", :cassette => "list_revisions/success" do
      result = @client.list_revisions "/file.txt"

      expect(result).to be_a(DropboxApi::Results::ListRevisionsResult)
    end

    it "raises an error if the file can't be found", :cassette => "list_revisions/not_found" do
      expect {
        @client.list_revisions "/unexisting_file"
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end

    it "returns all revisions as metadata objects", :cassette => "list_revisions/success" do
      result = @client.list_revisions "/file.txt"

      result.entries.each do |resource|
        expect(resource).to be_a(DropboxApi::Metadata::Base)
      end
    end

    it "indicates if the file has been deleted", :cassette => "list_revisions/success" do
      result = @client.list_revisions "/file.txt"

      expect(result.is_deleted?).to be_truthy
    end
  end

  describe "#list_folder_continue" do
    before :each do
      VCR.use_cassette("list_folder_continue/list_folder") do
        result = @client.list_folder "/folder"
        expect(result.has_more?).to be_truthy
        @cursor = result.cursor
      end
    end

    it "returns a ListFolderResult", :cassette => "list_folder_continue/success" do
      result = @client.list_folder_continue(@cursor)

      expect(result).to be_a(DropboxApi::Results::ListFolderResult)
    end
  end

  describe "#list_folder_longpoll" do
    before :each do
      VCR.use_cassette("list_folder_longpoll/list_folder") do
        @cursor = @client.list_folder("").cursor
      end
    end

    it "returns a ListFolderLongpollResult", :cassette => "list_folder_longpoll/success" do
      result = @client.list_folder_longpoll @cursor

      expect(result).to be_a(DropboxApi::Results::ListFolderLongpollResult)
    end

    it "indicates if there're changes", :cassette => "list_folder_longpoll/success" do
      result = @client.list_folder_longpoll @cursor

      expect(result.changes).to be_truthy
    end

    it "raises an error with an invalid cursor", :cassette => "list_folder_longpoll/reset" do
      expect {
        @client.list_folder_longpoll "I believe in the blerch"
      }.to raise_error DropboxApi::Errors::HttpError
    end
  end

  describe "#list_folder_get_latest_cursor" do
    before :each do
      VCR.use_cassette "list_folder_get_latest_cursor/list_folder" do
        result = @client.list_folder "/folder"
        @cursor = result.cursor
      end
    end

    it "returns a ListFolderGetLatestCursorResult", :cassette => "list_folder_get_latest_cursor/success" do
      result = @client.list_folder_get_latest_cursor :path => "/folder"

      expect(result)
        .to be_a(DropboxApi::Results::ListFolderGetLatestCursorResult)
    end
  end

  describe "#move" do
    it "returns the moved file on success", :cassette => "move/success_file" do
      file = @client.move("/img.png", "/image.png")

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("image.png")
    end

    it "returns the moved folder on success", :cassette => "move/success_folder" do
      file = @client.move("/folder", "/test/folder")

      expect(file).to be_a(DropboxApi::Metadata::Folder)
      expect(file.name).to eq("folder")
    end

    it "renames the moved file if required", :cassette => "move/success_rename" do
      file = @client.move("/a.jpg", "/photo.jpg", :autorename => true)

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("photo (1).jpg")
    end

    it "raises an error if the file can't be found", :cassette => "move/not_found" do
      expect {
        @client.move("/z.jpg", "/b.jpg")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end
  end

  describe "#restore" do
    it "returns the restored file on success", :cassette => "restore/success" do
      # "/file.txt" has two revisions: ["1a6b24061bdd", "1a6a24061bdd"]
      file = @client.restore("/file.txt", "1a6a24061bdd")

      expect(file).to be_a(DropboxApi::Metadata::File)
    end

    it "raises an error with an invalid revision", :cassette => "restore/invalid_revision" do
      expect {
        file = @client.restore("/file.txt", "1a6a24061000")
      }.to raise_error(DropboxApi::Errors::InvalidRevisionError)
    end
  end

  describe "#save_url" do
    it "returns the saved file on success", :cassette => "save_url/success_dropbox" do
      result = @client.save_url("/photo_1.jpg", "https://www.dropbox.com/s/834xngq25alcwsi/IMG_8998.JPG?dl=0")

      expect(result.async_job_id).to eq("VofXAX8DO1sAAAAAAAAD_Q")
    end

    it "returns the saved file on success", :cassette => "save_url/success_external" do
      result = @client.save_url("/photo_2.jpg", "https://static1.squarespace.com/static/518aa4bee4b050d373a7e8a2/t/558add71e4b062927077adc6/1435164035794/photo-1427348693976-99e4aca06bb9.jpg")

      expect(result.async_job_id).to eq("VofXAX8DO1sAAAAAAAAD_w")
    end

    it "raises an error with an invalid URL", :cassette => "save_url/invalid_url" do
      expect {
        file = @client.save_url("/photo_3.jpg", "1a6a24061000")
      }.to raise_error(DropboxApi::Errors::InvalidUrlError)
    end
  end

  describe "#save_url_check_job_status" do
    it "returns the saved file if job completed", :cassette => "save_url_check_job_status/complete" do
      result = @client.save_url_check_job_status "VofXAX8DO1sAAAAAAAAD_Q"

      expect(result).to be_a(DropboxApi::Metadata::File)
    end

    it "returns :in_progress if job not completed", :cassette => "save_url_check_job_status/in_progress" do
      save_url_result = @client.save_url("/file.zip", "http://ipv4.download.thinkbroadband.com/1GB.zip")
      status = @client.save_url_check_job_status save_url_result.async_job_id

      expect(status).to eq(:in_progress)
    end

    it "returns a descriptive error if the job failed", :cassette => "save_url_check_job_status/failed" do
      save_url_result = @client.save_url("/missing_file.zip", "http://ipv4.download.thinkbroadband.com/not_found.zip")
      # sleep 30 # We may need to wait until job completes to get its failure
      status = @client.save_url_check_job_status save_url_result.async_job_id

      expect(status).to be_a(DropboxApi::Errors::DownloadFailedError)
    end
  end

  describe "#search" do
    it "returns a list of matching results", :cassette => "search/success" do
      result = @client.search("image.png")

      expect(result).to be_a(DropboxApi::Results::SearchResult)
      file = result.matches.first.resource
      expect(file.name).to eq("image.png")
    end

    it "raises an error if the file can't be found", :cassette => "search/not_found" do
      expect {
        @client.search("/image.png", "/bad_folder")
      }.to raise_error(DropboxApi::Errors::NotFoundError)
    end
  end

  describe "#upload" do
    it "uploads a file", :cassette => "upload/success" do
      file = @client.upload("/file.txt", "Hello Dropbox!")

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("file.txt")
    end

    it "overwrites the uploaded file if it exists and the mode is :overwrite", :cassette => "upload/success_overwrite" do
      file = @client.upload("/file.txt", "Hello Again, Dropbox!", :mode => :overwrite)

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("file.txt")
    end

    it "renames the uploaded file if required", :cassette => "upload/success_rename" do
      file = @client.upload("/file.txt", "Hello Again, Dropbox!", :autorename => true)

      expect(file).to be_a(DropboxApi::Metadata::File)
      expect(file.name).to eq("file (1).txt")
    end

    context "when too many write operations" do
      it "raises a DropboxApi::Errors::TooManyWriteOperations exception", :cassette => "upload/too_many_write_operations" do
        expect {
          @client.upload("/file.txt", "Hello Dropbox!")
        }.to raise_error(DropboxApi::Errors::TooManyWriteOperationsError)
      end

      it "raises an exception with info to retry", :cassette => "upload/too_many_write_operations" do
        expect {
          @client.upload("/file.txt", "Hello Dropbox!")
        }.to raise_error { |error|
          expect(error.retry_after).to eq(1)
        }
      end
    end
  end

  describe "#list_folder_members" do
  end
end

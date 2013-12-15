#!/usr/bin/ruby

require "azure"

#Recuerda establecer las variables de entorno AZURE_STORAGE_ACCOUNT and AZURE_STORAGE_ACCESS_KEY

azure_blob_service = Azure::BlobService.new
begin
  container = azure_blob_service.create_container("test-container",
                                                  :public_access_level => "blob" )
rescue
  puts $!
end

content = File.open("blob-azure.rb", "rb") { |file| file.read }
blob = azure_blob_service.create_block_blob(container.name,
                                            "file-blob", content)
puts blob.name

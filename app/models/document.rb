class Document < ActiveRecord::Base
	belongs_to :folder

	has_attached_file :file,
	:storage => :dropbox,
	:dropbox_credentials => Rails.root.join("config/dropbox.yml"),
	:dropbox_options => {:path => proc { |style| "files/#{id}/#{file.original_filename}" }}
end

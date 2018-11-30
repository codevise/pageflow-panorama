class CreatePackages < ActiveRecord::Migration[4.2]
  def change
    create_table :pageflow_panorama_packages do |t|
      t.belongs_to(:entry, index: true)
      t.belongs_to(:uploader, index: true)

      t.string(:state)
      t.string(:rights)

      t.string(:attachment_on_filesystem_file_name)
      t.string(:attachment_on_filesystem_content_type)
      t.integer(:attachment_on_filesystem_file_size, limit: 8)
      t.datetime(:attachment_on_filesystem_updated_at)

      t.string(:attachment_on_s3_file_name)
      t.string(:attachment_on_s3_content_type)
      t.integer(:attachment_on_s3_file_size, limit: 8)
      t.datetime(:attachment_on_s3_updated_at)

      t.timestamps

      t.integer(:unpacking_progress)
      t.string(:unpacking_error_message)
      t.string(:index_document)
      t.attachment(:thumbnail)
    end
  end
end

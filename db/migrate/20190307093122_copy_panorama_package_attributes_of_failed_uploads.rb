class CopyPanoramaPackageAttributesOfFailedUploads < ActiveRecord::Migration[5.2]
  def up
    execute("UPDATE pageflow_panorama_packages pp
                SET pp.attachment_on_s3_file_name = pp.attachment_on_filesystem_file_name,
                    pp.attachment_on_s3_content_type = pp.attachment_on_filesystem_content_type,
                    pp.attachment_on_s3_file_size = pp.attachment_on_filesystem_file_size,
                    pp.attachment_on_s3_updated_at = pp.attachment_on_filesystem_updated_at,
                    pp.state = 'uploading_failed'
              WHERE pp.state = 'uploading_to_s3_failed';")
  end

  def down
    execute("UPDATE pageflow_panorama_packages pp
                SET pp.attachment_on_s3_file_name = NULL,
                    pp.attachment_on_s3_content_type = NULL,
                    pp.attachment_on_s3_file_size = NULL,
                    pp.attachment_on_s3_updated_at = NULL,
                    pp.state = 'uploading_to_s3_failed'
              WHERE pp.state = 'uploading_failed';")
  end
end

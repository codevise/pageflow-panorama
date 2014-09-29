json.(package, :unpacking_progress, :unpacking_error_message, :index_document_path)

if package.thumbnail.present?
  json.thumbnail_url(package.thumbnail.url(:thumbnail))
end

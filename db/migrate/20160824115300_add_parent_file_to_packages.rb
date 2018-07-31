class AddParentFileToPackages < ActiveRecord::Migration[4.2]
  def change
    add_column :pageflow_panorama_packages, :parent_file_id, :integer
    add_column :pageflow_panorama_packages, :parent_file_model_type, :string
    add_index :pageflow_panorama_packages, [:parent_file_id, :parent_file_model_type],
              name: 'index_package_files_on_parent_id_and_parent_model_type'
  end
end

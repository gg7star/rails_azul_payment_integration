class AddAzulJsonAttributesToAzulJson < ActiveRecord::Migration[5.1]
  def change
    add_column :azul_jsons, :azul_json_url, :string
    add_column :azul_jsons, :auth1, :string
    add_column :azul_jsons, :auth2, :string
  end
end

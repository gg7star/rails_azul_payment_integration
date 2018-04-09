class AddECommerceUrlAddToAzulJson < ActiveRecord::Migration[5.1]
  def change
    add_column :azul_jsons, :e_commerce_url, :string
  end
end

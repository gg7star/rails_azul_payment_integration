class AddAttributesToAzulJson < ActiveRecord::Migration[5.1]
  def change
    add_column :azul_jsons, :itbis, :string
    add_column :azul_jsons, :revenue_or_limit, :string
    add_column :azul_jsons, :authorization_code, :string
    add_column :azul_jsons, :iso_code, :string
    add_column :azul_jsons, :rrn, :string
    add_column :azul_jsons, :lot_number, :string
  end
end

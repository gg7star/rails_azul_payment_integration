class AddCustomFieldsToAzuls < ActiveRecord::Migration[5.1]
  def change
    add_column :azuls, :custom_field_1, :integer
    add_column :azuls, :custom_field_1_label, :string
    add_column :azuls, :custom_field_1_value, :string
    add_column :azuls, :custom_field_2, :integer
    add_column :azuls, :custom_field_2_label, :string
    add_column :azuls, :custom_field_2_value, :string
  end
end

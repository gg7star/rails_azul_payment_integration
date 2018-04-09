class CreateAzulJsons < ActiveRecord::Migration[5.1]
  def change
    create_table :azul_jsons do |t|
      t.string :channel
      t.string :store
      t.string :card_number
      t.string :expiration
      t.string :pos_input_mode
      t.string :trx_type
      t.string :amount
      t.string :currency_pos_code
      t.string :payments
      t.string :plan
      t.string :original_date
      t.string :original_trx_ticket_nr
      t.string :customer_service_phone
      t.string :cvc
      t.string :acquirer_ref_data
      t.string :order_number
      t.string :custom_order_id

      t.timestamps
    end
  end
end

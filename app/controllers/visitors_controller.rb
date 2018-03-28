class VisitorsController < ApplicationController
  def index
    @order_number = "DEV5487"
    @currency = "$"
    @amount = 720.0
    @itbis = 180.0
  end
end

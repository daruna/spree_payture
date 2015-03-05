class Spree::PaytureController < ApplicationController

  def handle
    config = Paytureman::Configuration.instance.configurations[Rails.env.to_sym]
    api = Paytureman::Api.new(config.host, config.key, config.password)
    if api.status(params["payment_id"]) == :charged
      @order = Spree::Order.find(params[:id])
      payment_method = @order.available_payment_methods.detect {|pm| pm.is_a?(Spree::Gateway::Payture) }
      @order.payments.create!({
        :amount => @order.total,
        :payment_method => payment_method,
        :state => 'completed'
      })
      unless @order.next
        flash[:error] = @order.errors.full_messages.join("\n")
        redirect_to checkout_state_path(@order.state) and return
      end

      if @order.completed?
        session[:order_id] = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash[:commerce_tracking] = "nothing special"
        redirect_to order_path(@order, checkout_complete: true)
      else
        redirect_to checkout_state_path(@order.state)
      end
    else
      redirect_to checkout_state_path('payment')
    end
  end
end

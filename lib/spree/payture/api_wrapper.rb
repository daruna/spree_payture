module Spree
  module Payture
    class ApiWrapper

      #attr_accessor :payture_payment

      #def initialize(payture_payment)
      #@payture_payment = payture_payment
      #end

      def purchase(amount, source, gateway_options={})
        #byebug
        #description = ::Paytureman::PaymentDescription.new(total: amount)
        #paytureman_payment = ::Paytureman::PaymentNew.new(gateway_options[:order_id], amount, gateway_options[:ip])
        #paytureman_payment = paytureman_payment.prepare(description)
        #paytureman_payment.pay
      end
    end
  end
end

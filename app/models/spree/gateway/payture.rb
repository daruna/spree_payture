module Spree
  class Gateway::Payture < Gateway
    preference :key, :string
    preference :password, :string

    def supports?(source)
      true
    end

    def source_required?
      false
    end

    def purchase(money, source, gateway_options)
      # dumb - we do this via redirect
      ActiveMerchant::Billing::Response.new(true, "")
    end

    def provider_class
      Payture::ApiWrapper
    end

    def method_type
      "payture"
    end

    def provider
      Paytureman::Configuration.setup Rails.env do |config|
        config.host = preferred_server == "test" ? "sandbox": "live"
        config.key = preferred_key
        config.password = preferred_password
      end
      provider_class.new
    end

    def auto_capture?
      true
    end
  end
end

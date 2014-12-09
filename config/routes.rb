Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  get "/payture/handle/:id" => "payture#handle", as: :handle_payture
end

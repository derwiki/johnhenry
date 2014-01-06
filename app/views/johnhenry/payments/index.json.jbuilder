json.array!(@payments) do |payment|
  json.extract! payment, :id, :user_id, :stripe_token, :stripe_customer_id
  json.url payment_url(payment, format: :json)
end

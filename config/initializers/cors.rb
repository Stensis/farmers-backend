# Rails.application.config.middleware.insert_before 0, Rack::Cors do
#     allow do
#       origins '*' # later change to the domain of the frontend app
#       resource '*',
#                headers: :any,
#                methods: %i[get post put patch delete options head],
#                expose: [:Authorization]
#     end
#   end


Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5173' # Replace with your frontend URL
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], credentials: true
  end
end

# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
    def after_sign_in_path_for(resource)
      if resource.admin?
        admin_dashboard_path
      elsif resource.buyer?
        buyer_dashboard_path
      elsif resource.farmer?
        farmer_dashboard_path
      end
    end
end
  
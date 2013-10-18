class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.user_type_id == 1
        redirect_to management_path
      elsif current_user.user_type_id == 2
        redirect_to waitstaff_path
      elsif current_user.user_type_id == 3
        redirect_to cashier_path
      elsif current_user.user_type_id == 4
        redirect_to kitchenstaff_path
      end
    end
  end
end

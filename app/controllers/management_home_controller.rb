class ManagementHomeController < ApplicationController
  before_filter :is_authorized

  def index
  end

  private

  def is_authorized
    if ![1].include?(current_user.user_type_id)
      flash[:error] = 'Not authorized to view this resource.'
      redirect_to :back
    end
  end
end

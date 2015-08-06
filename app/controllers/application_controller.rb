class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private def logged_in_user
    unless logged_in?
      set_login_forwarding
      flash[:error] = "Please log in."
      redirect_to login_url
    end
  end

  private def clear_highlighted_student
    session[:highlighted_student_id] = nil
  end

  private def save_highlighted_student
    if params[:student_id]
      session[:highlighted_student_id] = params[:student_id]
      @student = Student.find_by_id(params[:student_id])
    end
  end
end

class SignupController < ApplicationController
  layout 'fullscreen', only: :granted_access

  def grant_access # TODO: refactor into UnauthorisedController
    @user = User.find_by(unlock_token: params[:unlock_token])
    @user.unlock
    UserMailer.notify_unlock(@user).deliver_now
    redirect_to granted_access_path(@user.unlock_token)
  end

  def granted_access # TODO: refactor into UnauthorisedController
    @user = User.find_by(unlock_token: params[:unlock_token])
  end

  def unauthorised # TODO: refactor into UnauthorisedController
    # TODO: redirect to funds once authorised
  end

  private

    def catch_unauthorised; end
end

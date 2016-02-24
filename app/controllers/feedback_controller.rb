class FeedbackController < ApplicationController

  before_filter :ensure_logged_in, :load_recipient, :prevent_funder_access
  before_filter :redirect_to_funder, only: [:new, :create]

  def new
    @feedback = current_user.feedbacks.new
    @funder = Funder.find_by_slug(@redirect_to_funder)

    redirect_to recommended_funders_path, alert: "It looks like you've already provided feedback" if current_user.feedbacks.count > 0
  end

  def create
    @feedback = current_user.feedbacks.new(feedback_params)
    @funder = Funder.find_by_slug(@redirect_to_funder)

    if @feedback.save
      session.delete(:redirect_to_funder)
      flash[:notice] = "You're a star! Thanks for the feedback."
      redirect_to recipient_eligibility_path(Funder.find_by_slug(@redirect_to_funder))
    else
      render :new
    end
  end

  def edit
    @feedback = Feedback.find(params[:id])
    session[:return_to] ||= request.referer
  end

  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update_attributes(params.require(:feedback).permit(:price))
      flash[:notice] = 'Thanks for the feedback!'
      redirect_to session.delete(:return_to)
    else
      render :edit
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:most_useful, :nps, :taken_away,
    :informs_decision, :other, :application_frequency, :grant_frequency,
    :marketing_frequency)
  end

  def load_recipient
    @recipient = current_user.organisation if logged_in?
  end

  def redirect_to_funder
    @redirect_to_funder = session[:redirect_to_funder]
  end

end

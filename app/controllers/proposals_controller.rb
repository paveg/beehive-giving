class ProposalsController < ApplicationController
  before_action :ensure_logged_in
  before_action :load_proposal, only: [:edit, :update] # TODO: refactor

  def new
    if @proposal.complete?
      @proposal = @recipient.proposals.new(
        countries: [Country.find_by(alpha2: @recipient.country)]
      )
      return if @recipient.subscribed?
      redirect_to request.referer || root_path,
                  alert: 'Please upgrade to create multiple funding proposals'
      # TODO: redirect to update path
    else
      redirect_to edit_signup_proposal_path(@proposal)
    end
  end

  def create
    @proposal = @recipient.proposals.new(
      proposal_params.merge(state: 'registered')
    )
    if @proposal.save
      @proposal.next_step!
      redirect_to proposal_funds_path(@proposal)
    else
      render :new
    end
  end

  def index
    @proposals = @recipient.proposals
  end

  def edit
    return unless request.referer
    session.delete(:return_to) if request.referer.ends_with?('/proposals')
  end

  def update
    @proposal.state = 'transferred' if @proposal.initial?
    respond_to do |format|
      if @proposal.update_attributes(proposal_params)
        format.js do
          @proposal.next_step! unless @proposal.complete?
          flash[:notice] = 'Funding recommendations updated!'

          if session[:return_to]
            fund = Fund.find_by(slug: session.delete(:return_to))
            render js: "window.location.href = '#{eligibility_proposal_fund_path(@proposal, fund)}';
                        $('button[type=submit]').prop('disabled', true)
                        .removeAttr('data-disable-with');"
          else
            render js: "window.location.href = '#{proposal_funds_path(@proposal)}';
                        $('button[type=submit]').prop('disabled', true)
                        .removeAttr('data-disable-with');"
          end
        end
        format.html do
          @proposal.next_step! unless @proposal.complete?
          flash[:notice] = 'Funding recommendations updated!'

          if session[:return_to]
            fund = Fund.find_by(slug: session.delete(:return_to))
            redirect_to eligibility_proposal_fund_path(@proposal, fund)
          else
            redirect_to proposal_funds_path(@proposal)
          end
        end
      else
        format.js
        format.html { render :edit }
      end
    end
  end

  private

    def load_proposal # TODO: refactor
      @proposal = @recipient.proposals.find(params[:id])
    end
end

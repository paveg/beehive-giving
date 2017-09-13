class FundsController < ApplicationController
  before_action :ensure_logged_in, :update_legacy_suitability, except: :sources

  def show
    @fund = Fund.includes(:funder).find_by(slug: params[:id])
    return redirect_to request.referer || root_path, alert: 'Fund not found' unless @fund
    redirect_to account_upgrade_path(@recipient) unless
      @proposal.show_fund?(@fund)
  end

  def index
    query = Fund.active
                .includes(:funder, :themes)
                .eligibility(@proposal, params[:eligibility])
                .duration(@proposal, params[:duration])
                .order_by(@proposal, params[:sort])

    @fund_count = query.size
    @funds = Kaminari.paginate_array(query).page(params[:page])
  end

  def themed
    @theme = Theme.find_by(slug: params[:theme]) if params[:theme].present?
    @funds = Fund.active
                 .includes(:funder, :themes)
                 .where(themes: { id: @theme })
                 .page(params[:page])
    redirect_to root_path, alert: 'Not found' if @funds.empty?
  end

  private

    def update_legacy_suitability
      @proposal.update_legacy_suitability
    end
end

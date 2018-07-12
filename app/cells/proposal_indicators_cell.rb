# TODO: refactor
class ProposalIndicatorsCell < Cell::ViewModel
  include ActionView::Helpers::NumberHelper

  def eligibility_progress_bar
    @counts = eligibility_counts
    @pcs = count_percentages(@counts)
    bg_color = { INELIGIBLE => 'bg-red', INCOMPLETE => 'bg-blue', ELIGIBLE => 'bg-green' }
    names = { INELIGIBLE => 'ineligible', INCOMPLETE => 'to check', ELIGIBLE => 'eligible' }
    states = [-1, 0, 1]
    render view: :progress_bar, locals: {bg_color: bg_color, names: names, states: states}
  end

  def funds_checked
    model.assessments.where("eligibility_status != #{INCOMPLETE}").size
  end

  private

    def count_percentages(counts)
      total = counts.values.inject(0, :+).to_f
      return counts.map{|k, v| [k,0]}.to_h if total == 0
      counts.map{|k, v| [k, v / total]}.to_h
    end

    def eligibility_counts
      { INELIGIBLE => 0, INCOMPLETE => 0, ELIGIBLE => 0 }.merge(
        model.assessments.group(:eligibility_status).size
      )
    end
end

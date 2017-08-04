class CheckSuitability
  class Theme < CheckSuitability
    def call(proposal, fund)
      super
      proposal_themes = get_proposal_themes(proposal)
      match_score = match_themes(proposal_themes, fund_themes).values.reduce(:+)
      proposal_score = proposal_themes.values.reduce(:+)
      match_score.to_f / proposal_score.to_f
    end

    private

      def get_proposal_themes(proposal)
        # get all the themes from a proposal, including the related themes attached to each theme
        proposal_themes = {}
        proposal.themes.each do |theme|
          proposal_themes[theme.name] = 1
          theme.related.each do |theme_name, theme_score|
            proposal_themes[theme_name] = [theme_score, proposal_themes[theme_name] || 0].max
          end
        end
        proposal_themes
      end

      def match_themes(proposal_themes, fund_themes)
        # return the themes from the proposal that match those from the fund
        proposal_themes.filter { |theme, score| fund_themes.pluck(:name).include? theme }
      end
  end
end

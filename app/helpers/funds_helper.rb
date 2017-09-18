module FundsHelper
  def period(fund = @fund, date_format="%b %Y")
    return unless fund.open_data
    if fund.period_start.strftime(date_format) == fund.period_end.strftime(date_format)
      period_desc = fund.period_start.strftime(date_format)
    else
      period_desc = fund.period_start.strftime(date_format) + ' - ' + fund.period_end.strftime(date_format)
    end
    content_tag :span, period_desc
  end

  def amount_awarded_distribution
    @fund.amount_awarded_distribution.each_with_index do |s, i|
      if i == @fund.amount_awarded_distribution.length - 1
        s['segment'] = 'More than ' + number_with_delimiter(s['start'])
      else
        s['segment'] = number_with_delimiter(s['start']) + ' - ' +
                       number_with_delimiter(s['end'] + 1)
      end
    end.to_json
  end

  def top_award_months(fund = @fund)
    fund.award_month_distribution
        .group_by { |i| i['count'] }
        .sort.last[1]
        .map { |i| Date::MONTHNAMES[i['month']] }
        .to_sentence
  end

  def award_month_distribution
    @fund.award_month_distribution
         .sort_by { |i| i['sort'] }
         .each { |m| m['month'] = Date::MONTHNAMES[m['month']].slice(0, 3) }
         .to_json
  end

  def top_countries(fund = @fund)
    fund.country_distribution
        .group_by { |i| i['count'] }
        .sort.last[1]
        .map { |i| i['name'] }
        .to_sentence
  end

  def country_distribution
    @fund.country_distribution
         .collect { |c| { c['name'] => c['count'] } }
         .reduce({}, :merge)
  end

  def org_type_desc(fund)
    arr = fund.org_type_distribution.select do |hash|
      hash['label'] == ORG_TYPES[@recipient.org_type + 1][0]
    end
    return if arr.empty?
    "
      <strong>
        #{number_to_percentage arr[0]['percent'] * 100, precision: 0}
      </strong>
      of funded organisations were like you - #{arr[0]['label'].downcase}.
    "
  end

  def income_desc(fund)
    arr = fund.income_distribution.select do |hash|
      hash['label'] == Recipient::INCOME_BANDS[@recipient.income_band][0]
    end
    return if arr.empty?
    return if arr[0]['percent']==0
    if arr[0]['label'].include? '-'
      label = "between #{arr[0]['label'].sub('-', 'and')}"
    else
      label = "of #{arr[0]['label']}"
    end
    "
      Like you,
      <strong>
        #{number_to_percentage arr[0]['percent'] * 100, precision: 0}
      </strong>
      had income #{label}.
    "
  end

  def beneficiaries_desc(fund)
    if fund.beneficiary_distribution.length==0
      return ""
    end
    proposal_bens = @proposal.beneficiaries.map { |b| b[:sort] }
    matched_bens = fund.beneficiary_distribution.select { |b| (proposal_bens.include? b["sort"]) && (b["count"] > 0) }
    if matched_bens.length == 1
      "
        This fund also funds work with
        <strong>#{ matched_bens[0]["label"].downcase }</strong>
        (#{ number_to_percentage(matched_bens[0]["percent"] * 100, precision: 0) } of recent grants).
      "
    elsif matched_bens.length > 1
      matched_bens = matched_bens[0..1]
      "
        This fund also funds work with
        <strong>#{ matched_bens[0]["label"].downcase }</strong>
        (#{ number_to_percentage(matched_bens[0]["percent"] * 100, precision: 0) } of recent grants) and
        <strong>#{ matched_bens[1]["label"].downcase }</strong>
        (#{ number_to_percentage(matched_bens[1]["percent"] * 100, precision: 0) }).
      "
    else
      "<strong>None</strong> of your beneficiaries overlap with this fund."
    end
  end
end

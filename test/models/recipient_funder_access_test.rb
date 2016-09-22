# TODO: deprecated
require 'test_helper'

class RecipientFunderAccessTest < ActiveSupport::TestCase
  test "recipients should have methods to show locked and unlocked funders" do
    @recipient = create(:recipient)
    assert @recipient.respond_to?(:locked_funders)
    assert @recipient.respond_to?(:unlocked_funders)
  end

  test "recipient should be able to unlock a funder" do
    @funder = create(:funder)
    @recipient = create(:recipient)

    assert @recipient.unlocked_funders.empty?
    assert @recipient.locked_funders.include?(@funder)

    @recipient.unlock_funder!(@funder)

    assert @recipient.unlocked_funders.include?(@funder)
    assert @recipient.locked_funders.empty?
  end
end

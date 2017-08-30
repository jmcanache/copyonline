require 'test_helper'

class TransferTest < ActionMailer::TestCase
  test "transfer_info" do
    mail = Transfer.transfer_info
    assert_equal "Transfer info", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

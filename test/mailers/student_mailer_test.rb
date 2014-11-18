require 'test_helper'

class StudentMailerTest < ActionMailer::TestCase
  test "send_assignment" do
    mail = StudentMailer.send_assignment
    assert_equal "Send assignment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

RSpec.describe "membership confirmation process" do
  let(:member) {
    Member.create!(
      full_name: "John Doe",
      email: "john.doe@example.com",
      address: "22 Pollen Street, Grey Lynn, Auckland 1021"
    )
  }

  context "via email" do
    it "allows them to confirm membership" do
      MembershipMailer.confirm(member).deliver_now

      email = ActionMailer::Base.deliveries.last

      expect(email.to).to include "john.doe@example.com"

      expect(email.body.encoded).to match(
        %r{
          (?-x:Hi John Doe).*
          (?-x:Membership of the Ruby New Zealand Society has grown in recent).*
          (?-x:years, and we \(the current Ruby New Zealand Committee\) want to).*
          (?-x:ensure that we have an accurate list of current members.).*
          (?-x:If you would like to remain a member of Ruby New Zealand).*
          (?-x:please confirm your existing membership here:).*
          (?-x:Being a member of Ruby New Zealand allows you to have your say).*
          (?-x:about the committee and other society matters at the annual AGM).*
          (?-x:Kind regards.*The 2021 New Zealand Ruby Committee.)
        }xm
      )

      url = URI.extract(email.body.encoded).detect do |url|
        url.match(%r{example.com})
      end

      visit url.gsub("http://www.example.com", "")

      expect(page).to have_content "Membership Confirmation"
      expect(page).to have_content(
        "Submitting your email address will automatically confirm your " \
        "continued NZ Ruby Membership."
      )

      fill_in "Email", with: "john.doe@example.com"
      expect {
        click_on "Confirm Membership"
      }.to change {
        member.reload.last_active_at
      }

      expect(page).to have_content(
        "Congratulations. You have successfully confirmed your continuing " \
        "Ruby NZ Membership."
      )
    end

    it "allows them to navigate to the membership register" do
      MembershipMailer.confirm(member).deliver_now

      email = ActionMailer::Base.deliveries.last

      expect(email.to).to include "john.doe@example.com"

      expect(email.body.encoded).to match(
        %r{
          (?-x:.*If you choose not to confirm your membership before the end of).*
          (?-x:next month, we will remove your details from the Ruby New Zealand).*
          (?-x:Member’s register. Should you wish to rejoin, you can register).*
          (?-x:for membership here:).*
          (?-x:Kind regards.*The 2021 New Zealand Ruby Committee)
        }xm
      )

      url = URI.extract(email.body.encoded).detect do |url|
        url.match(%r{example.com/$})
      end

      visit url.gsub("http://www.example.com", "")

      expect(page).to have_content("New Members")
      expect(page).to have_content(
        "This is Ruby New Zealand’s official membership register."
      )
    end
  end

  context "via membership register url" do
    it "allows them to confirm membership" do
      visit "/"

      click_on "Confirm existing membership…"

      fill_in "Email", with: "john.doe@example.com"

      expect {
        click_on "Confirm Membership"
      }.to change {
        member.reload.last_active_at
      }

      expect(page).to have_content(
        "Congratulations. You have successfully confirmed your continuing " \
        "Ruby NZ Membership."
      )
    end
  end

  it "errors gracefully when a fake or invalid email is provided" do
    visit "/membership_confirmation/new"

    fill_in "Email", with: "bob"

    click_on "Confirm Membership"

    expect(page).to have_selector(".has-error")
    expect(page).to have_content("couldn't be found in our membership register")
  end
end

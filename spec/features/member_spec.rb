RSpec.describe "Member" do
  it "registers for a membership" do
    visit "/"

    click_on "Register for membership…"
    fill_in "Full Name", with: "John Doe"
    fill_in "Email", with: "john.doe@example.com"
    fill_in "Physical Address", with: "22 Pollen Street, Grey Lynn, Auckland 1021"
    fill_in "Phone", with: "02X 000 0000"

    expect(page).to have_content "Collecting your phone is a requirement"

    click_on "Register"

    expect(page).to have_content "Membership Details"
    expect(page).to have_content "Full Name: John Doe"
    expect(page).to have_content "Joined: "
    expect(page).to have_content "Email: john.doe@example.com"
    expect(page).to have_content %[Physical Address:
22 Pollen Street, Grey Lynn, Auckland 1021]
    expect(page).to have_content "Phone: 02X 000 0000"
  end

  it "updates their member right after registering" do
    visit "/"

    click_on "Register for membership…"
    fill_in "Full Name", with: "John Doe"
    fill_in "Email", with: "john.doe@example.com"
    fill_in "Physical Address", with: "22 Pollen Street, Grey Lynn, Auckland 1021"
    fill_in "Phone", with: "02X 000 0000"

    click_on "Register"

    expect(page).to have_content "Membership Details"

    click_on "Update Details…"

    fill_in "Full Name", with: "Alice Doe"
    fill_in "Email", with: "alice.doe@example.com"
    fill_in "Physical Address", with: "5 Leamington Street, Addington, Christchurch 8024"
    fill_in "Phone", with: "02X 000 0001"

    click_on "Save Changes"

    expect(page).to have_content "Membership Details"
    expect(page).to have_content "Full Name: Alice Doe"
    expect(page).to have_content "Joined: "
    expect(page).to have_content "Email: alice.doe@example.com"
    expect(page).to have_content %[Physical Address:
5 Leamington Street, Addington, Christchurch 8024]
    expect(page).to have_content "Phone: 02X 000 0001"
  end

  it "updates their membership" do
    Member.create!(
      full_name: "John Doe",
      email: "john.doe@example.com",
      address: "22 Pollen Street, Grey Lynn, Auckland 1021",
      phone: "02X 000 0000"
    )

    visit "/"

    click_on "Check existing membership…"

    fill_in "Email", with: "john.doe@example.com"
    click_on "Request Access"

    expect(page).to have_content "Sent email with membership details. Delivery may take a few minutes"

    email = ActionMailer::Base.deliveries.last

    expect(email.to).to include "john.doe@example.com"
    expect(email.body.encoded).to match "Your Ruby New Zealand Membership"
    expect(email.body.encoded).to match %r[Full Name:.*John Doe]
    url = URI.extract(email.body.encoded).detect { |url| url.match(%r[example.com]) }

    visit url.gsub("http://www.example.com", "")

    expect(page).to have_content "Editing Membership"

    fill_in "Full Name", with: "Alice Doe"
    fill_in "Email", with: "alice.doe@example.com"
    fill_in "Physical Address", with: "5 Leamington Street, Addington, Christchurch 8024"
    fill_in "Phone", with: "02X 000 0001"
    click_on "Save Changes"

    expect(page).to have_content "Membership Details"
    expect(page).to have_content "Full Name: Alice Doe"
    expect(page).to have_content "Joined: "
    expect(page).to have_content "Email: alice.doe@example.com"
    expect(page).to have_content %[Physical Address:
5 Leamington Street, Addington, Christchurch 8024]
    expect(page).to have_content "Phone: 02X 000 0001"
  end

  context "when token to update the memebership is invalid" do
    it "does not let the membership to be updated" do
      member = Member.create!(
        full_name: "John Doe",
        email: "john.doe@example.com",
        address: "22 Pollen Street, Grey Lynn, Auckland 1021",
      )

      visit "/"

      click_on "Check existing membership…"

      fill_in "Email", with: "john.doe@example.com"
      click_on "Request Access"

      expect(page).to have_content "Sent email with membership details. Delivery may take a few minutes"

      visit "/members/#{member.id}/edit?token=abc"

      expect(page).to have_content "The security token is invalid"
    end
  end
end

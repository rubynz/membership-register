require "rails_helper"

describe "Admin" do
  context "when user is not authenticated" do
    it "does not see anything" do
      visit "/admin/members"

      expect(page).to have_content "HTTP Basic: Access denied."
      expect(page).not_to have_content "Full Name"
    end
  end

  context "when user uses wrong password" do
    it "does not see anything" do
      page.driver.browser.authorize "secretary", "xxxx"

      visit "/admin/members"

      expect(page).to have_content "HTTP Basic: Access denied."
      expect(page).not_to have_content "Full Name"
    end
  end

  context "when user is authenticated" do
    before { page.driver.browser.authorize "secretary", "password" }

    it "sees all memberships" do
      ["Alice", "Beatrice"].each do |full_name|
        Member.create!(
          full_name: full_name,
          email: %[#{full_name}@example.com].downcase,
        )
      end

      visit "/admin/members"

      expect(page).to have_content "Alice"
      expect(page).to have_content "alice@example.com"
      expect(page).to have_content "Beatrice"
      expect(page).to have_content "beatrice@example.com"
    end

    it "edits a membership" do
      Member.create!(full_name: "Alice Doe", email: "alice.doe@example.com")

      visit "/admin/members"

      click_on "Alice"
      click_on "Edit"

      fill_in "Full Name", with: "John Doe"
      fill_in "Email", with: "john.doe@example.com"
      fill_in "Physical Address", with: %[22 Pollen Street, Grey Lynn, Auckland 1021]

      click_on "Save Changes"

      expect(page).to have_content "Full Name: John Doe"
      expect(page).to have_content "Joined: "
      expect(page).to have_content "Email: john.doe@example.com"
      expect(page).to have_content %[Physical Address:
22 Pollen Street, Grey Lynn, Auckland 1021]
    end

    it "registers for a membership" do
      visit "/admin/members"

      click_on "New Member"

      fill_in "Full Name", with: "John Doe"
      fill_in "Email", with: "john.doe@example.com"
      fill_in "Physical Address", with: %[22 Pollen Street, Grey Lynn, Auckland 1021]

      click_on "Register"

      expect(page).to have_content "Full Name: John Doe"
      expect(page).to have_content "Joined: "
      expect(page).to have_content "Email: john.doe@example.com"
      expect(page).to have_content %[Physical Address:
22 Pollen Street, Grey Lynn, Auckland 1021]
    end
  end
end

RSpec.feature 'Voting' do
  scenario 'Member requests vote' do
    member = Member.create!(
      full_name: 'Ada Lovelace',
      email: 'ada@example.com',
      address: 'Marylebone',
      phone: "02X 000 0000"
    )

    visit '/'
    click_on 'Cast your vote'
    fill_in 'Email', with: 'ada@example.com'
    click_on 'Send voting link'
    expect(page).to have_content('Thanks!')

    open_email 'ada@example.com'
    expect(current_email).to have_content('Your unique voting link')
    expect(current_email).to have_content(member.voting_token)
  end
end

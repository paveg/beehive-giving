require 'rails_helper'

feature 'Cookies' do
  context 'banner' do
    before { visit root_path }

    scenario 'reset_session makes banner appear after sign out'

    scenario('visible') { expect(page).to have_text('Change settings') }

    scenario 'continuing hides' do
      click_link 'Continue'
      expect(page).not_to have_text('Change settings')
    end

    scenario 'changing settings hides' do
      click_link 'Change settings'
      expect(page).not_to have_text('Change settings')
    end
  end

  scenario 'can be dectivated', js: true do
    visit root_path
    browser = page.driver.browser.manage
    browser.add_cookie(name: '_beehive_session', value: 'value')
    browser.add_cookie(name: 'tracker', value: 'value')

    click_link 'Change settings'

    expect(browser.all_cookies.pluck(:name))
      .to contain_exactly('_beehive_session', 'tracker')

    click_link 'Turn Off', match: :first
    sleep(1)
    expect(browser.all_cookies.pluck(:name))
      .to contain_exactly('_beehive_session')
  end
end

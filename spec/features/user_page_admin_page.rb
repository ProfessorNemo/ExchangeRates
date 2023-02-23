# frozen_string_literal: true

RSpec.describe 'User page admin page' do
  let!(:exchange_rate) { create(:exchange_rate) }

  it 'User looks admin page' do
    visit '/user'

    # пользовательская страничка
    # save_and_open_page

    click_link 'Курс доллара'

    expect(page).to have_current_path('/admin')
    expect(page).not_to have_content('Курс евро:')
    expect(page).to have_content('До этого времени курс форсированный')
    expect(page).to have_content('Курс доллара:')
    # find_button(value: 'Обновить') == find(:xpath, '/html/body/div/div[2]/div/div/form/input[2]')
    expect(find_field('Курс доллара:').value).to have_content('62,05 руб.')
    expect(find(:xpath, '/html/body/div/div[2]/div/div/form/input[2]').value)
      .to have_content('Обновить')
  end

  it 'Admin looks user page' do
    visit '/admin'

    # админская страничка
    # save_and_open_page

    click_link 'Главная'

    expect(page).to have_current_path('/user')
    expect(page).not_to have_content('До этого времени курс форсированный')
    expect(page).to have_content('Курс доллара:')
    expect(page).to have_content('62,05 руб.')
  end
end

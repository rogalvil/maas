# frozen_string_literal: true

require 'system_helper'

RSpec.describe 'Post', type: :system do
  describe 'Index Page' do
    it 'displays a list of post' do
      visit posts_path

      expect(page).to have_content('Posts')
    end
  end
end

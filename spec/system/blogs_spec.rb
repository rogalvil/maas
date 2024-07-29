# frozen_string_literal: true

require 'system_helper'

RSpec.describe 'Blogs', type: :system do
  describe 'Index Page' do
    it 'displays a list of blogs' do
      visit blogs_path

      expect(page).to have_content('My first blog')
      expect(page).to have_content('Another blog')
    end

    # it 'contains links to individual blog pages' do
    #   visit blogs_path

    #   # Blog.all.each do |blog|
    #   #   expect(page).to have_link(blog.title, href: blog_path(blog))
    #   # end
    # end
  end
end

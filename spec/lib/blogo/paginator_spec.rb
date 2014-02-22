require 'spec_helper'

describe Blogo::Paginator do
  describe '#items' do
    it 'returns items of passed page' do
      FactoryGirl.create_list(:post, 10)
      paginator = described_class.new(Blogo::Post.all, page: 3, per_page: 2)
      expect(paginator.items).to eq Blogo::Post.all[4..5]
    end
  end

  describe '#pages' do
    it 'returns array of page numbers (per_page => 1)' do
      FactoryGirl.create_list(:post, 10)

      data = [
        # page, per_page, size,  expected pages
        [ 1   , 1       , 5   , [1, 2, 3, 4, 5]],
        [ 2   , 1       , 5   , [1, 2, 3, 4, 5]],
        [ 3   , 1       , 5   , [1, 2, 3, 4, 5]],
        [ 4   , 1       , 5   , [2, 3, 4, 5, 6]],
        [ 5   , 1       , 5   , [3, 4, 5, 6, 7]],
        [ 10  , 1       , 5   , [6, 7, 8, 9, 10]],

        [ 2   , 5       , 5   , [1, 2]],
      ]

      data.each do |(page, per_page, size, expected_pages)|
        paginator = described_class.new(Blogo::Post.all, per_page: per_page, page: page, size: size)
        expect(paginator.pages).to eq expected_pages
      end
    end
  end


  describe '#prev_page' do
    it 'returns nil if paginator includes first page' do
      FactoryGirl.create_list(:post, 10)
      # << 1, 2, 3, 4, 5 >>
      paginator = described_class.new(Blogo::Post.all, per_page: 1, page: 3, size: 5)

      expect(paginator.pages.first).to eq 1
      expect(paginator.prev_page).to be_nil
    end

    it 'returns page be first shown' do
      FactoryGirl.create_list(:post, 10)
      paginator = described_class.new(Blogo::Post.all, per_page: 1, page: 5, size: 3)

      expect(paginator.pages.first).to eq 4
      expect(paginator.prev_page).to eq 3
    end
  end

  describe '#next_page' do
    it 'returns nil if the last page shown' do
      FactoryGirl.create_list(:post, 10)
      # << 6, 7, 8, 9, 10 >>
      paginator = described_class.new(Blogo::Post.all, per_page: 1, page: 8, size: 5)

      expect(paginator.pages.last).to eq 10
      expect(paginator.next_page).to be_nil
    end

    it 'returns next not shown page' do
      FactoryGirl.create_list(:post, 10)
      # << 5, 6, 7, 8, 9 >>
      paginator = described_class.new(Blogo::Post.all, per_page: 1, page: 7, size: 5)

      expect(paginator.pages.last).to eq 9
      expect(paginator.next_page).to eq 10
    end
  end
end

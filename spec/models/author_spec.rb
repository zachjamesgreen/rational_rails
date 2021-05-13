require 'rails_helper'

RSpec.describe Author do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :rating }
    it { should validate_presence_of :admin }
  end

  describe 'relationships' do
    it { should have_many :stories }
  end

  it 'should count how mant stories' do
    attrs = attributes_for(:author)
    author = Author.create(attrs)
    3.times do
      s = Story.new(attributes_for(:story))
      s.author = author
      s.save!
    end
    expect(author.stories_count).to eq(3)
  end
end
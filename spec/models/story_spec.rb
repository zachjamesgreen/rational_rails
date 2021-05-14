require 'rails_helper'

RSpec.describe Story do

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :likes }
    # it { should validate_presence_of :published }
  end

  describe 'relationships' do
    it {should belong_to :author}
  end
end
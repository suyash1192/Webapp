require 'rails_helper'

RSpec.describe Product, :type => :model do
  describe 'validations' do
    subject {
      described_class.new(title: "Apple Airpods")
    }

    it "is valid with valid attributes" do  
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end
  end
end

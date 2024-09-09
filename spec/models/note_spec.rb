require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      note = Note.new(title: 'Valid title', content: 'Valid content')
      expect(note).to be_valid
    end

    it 'is not valid without a title' do
      note = Note.new(title: nil, content: 'Valid content')
      expect(note).to_not be_valid
    end

    it 'is not valid without content' do
      note = Note.new(title: 'Valid title', content: nil)
      expect(note).to_not be_valid
    end
  end
end

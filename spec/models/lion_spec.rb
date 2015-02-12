require 'rails_helper'

RSpec.describe Lion, :type => :model do
  describe 'validations' do
    subject { Fabricate :lion }
    it { should be_valid }

    describe 'not valid is primary image set not in image sets' do
      subject { Fabricate.build(:lion, primary_image_set: Fabricate(:image_set)) }
      it { should_not be_valid }
    end
  end

  describe 'create from image set' do
    let(:image_set) { Fabricate :image_set }
    let(:name) { 'isaac' }
    let!(:lion) { Lion.create_from_image_set(image_set, name) }

    it { expect(lion).to be_valid }
    it { expect(lion.name).to eq name }
    it { expect(lion.age).to eq image_set.age }
    it { expect(lion.gender).to eq image_set.gender }
    it { expect(lion.organization).to eq image_set.organization }
    it { expect(image_set.reload.lion).to eq lion }
  end

  describe 'set age' do
    let(:birthdate) { Date.today - 26.years }
    let(:lion) { Fabricate :lion, age: 26 }

    it { expect(lion).to be_valid }
    it { expect(lion.age).to eq 26 }
    it { expect(lion.birthdate).to eq birthdate }
  end
end

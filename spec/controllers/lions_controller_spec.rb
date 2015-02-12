require 'rails_helper'

RSpec.describe LionsController, :type => :controller do
  let(:resource) { Fabricate(:user) }
  before { sign_in resource }
  subject { request.call }

  describe '#show' do
    let(:lion) { Fabricate :lion }
    let(:request) { ->{ get :show, id: lion.id } }

    it_behaves_like "an authenticated controller"
    it { expect(subject).to serialize_to(LionSerializer, lion) }
  end

  describe '#index' do
    let(:lion1) { Fabricate(:lion, age: 24, gender:'male')}
    let(:lion2) { Fabricate(:lion, age: 25, gender:'female')}
    let!(:lions) { [lion1, lion2] }
    let(:request) { ->{ get :index, params } }

    context 'no params' do
      let(:params) { {} }
      it_behaves_like "an authenticated controller"
      it { expect(subject).to serialize_to(LionsSerializer, lions) }
    end

    describe 'search by age' do
      let(:params) { { age: '24' } }

      it { expect(subject).to serialize_to(LionsSerializer, [lion1]) }
    end

    describe 'search by gender' do
      let(:params) { { gender: 'female' } }

      it { expect(subject).to serialize_to(LionsSerializer, [lion2]) }
    end
  end

  describe '#create' do
    let(:name) { 'isaac' }
    let(:image_set) { Fabricate :image_set }
    let(:params) {
      {
        lion: {
          primary_image_set_id: image_set.id,
          name: name
        }
      }
    }
    let(:request) { ->{ post :create, params } }

    it_behaves_like "an authenticated controller"
    it { expect { subject }.to change { Lion.count }.by(1) }
    it { expect(subject).to serialize_to(LionSerializer, Lion.all.last) }
  end
end

require 'rails_helper'

describe TweetsController, type: :controller do
  before(:each) do
    @tweet = create(:tweet)
    @tweet1 = create(:tweet)
    @tweet2 = create(:tweet)
  end

  describe 'GET #index' do
    it 'tweets order by created_at DESC' do
      get :index
      expect(assigns(:tweets)).to match([@tweet, @tweet1, @tweet2])
    end

    it "renders the :index template" do
      get :index, id: @tweet
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it "renders the :new template" do
      get :index, id: @tweet
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    it "create tweet" do
      login_user
      expect{
        post :create, tweet: attributes_for(:tweet)
      }.to change(Tweet, :count).by(1)
    end

    it "renders the :create template" do
      login_user
      post :create, tweet: attributes_for(:tweet)
      expect(response).to render_template :create
    end
  end

  describe 'GET "#edit' do
    it '@tweets is correct tweets by request' do
      get :edit, id: @tweet
      expect(assigns(:tweet)).to eq @tweet
    end

    it 'renders the :edit template' do
      get :edit, id: @tweet
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    before(:each) do
      login_user
      @tweet = create(:tweet, user: subject.current_user)
    end

    it 'update tweets' do
      patch :update, id: @tweet, text: 'update tweet'
      @tweet.reload
      expect(@tweet.text).to eq('update tweet')
    end

    it 'renders the :update template' do
      put :update, id: @tweet
      expect(response).to render_template :update
    end
  end

  describe 'DELETE #destory' do
    before(:each) do
      login_user
      @tweet = create(:tweet, user: subject.current_user)
    end

    it 'destory tweet' do
      expect{
        delete :destroy, id: @tweet
      }.to change(Tweet, :count).by(-1)
    end

    it 'renders the :destroy template' do
      delete :destroy, id: @tweet
      expect(response).to render_template :destroy
    end
  end
end

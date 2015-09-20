require 'rails_helper'
describe UsersController, type: :controller do
  before :each do
    login_user
    @user = subject.current_user
    get :show, id: @user
  end

  describe 'GET #show' do
    it "@nickname is current_user.nickname" do
      expect(assigns(:nickname)).to eq @user.nickname
    end

    describe "about tweets" do
      before :each do
        @tweet1 = create(:tweet, user: @user)
        @tweet2 = create(:tweet, user: @user)
      end

      it "@tweets belongs to current_user" do
        expect(assigns(:tweets)).to match([@tweet1, @tweet2])
      end

      it "correct current_user's tweets count" do
         expect(assigns(:tweets_count)) == 2
      end
    end

    it 'renders the :show template' do
        delete :show, id: @user
        expect(response).to render_template :show
    end

  end
end

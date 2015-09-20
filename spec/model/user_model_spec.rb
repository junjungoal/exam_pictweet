require 'rails_helper'

describe User, type: :model do
  describe 'validation' do
    it 'is invalid without nickname' do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it 'is invalid if nickname length is more than 6' do
      user = build(:user, nickname: Faker::Internet.user_name(7..7))
      user.valid?
      expect(user.errors[:nickname]).to include('is too long (maximum is 6 characters)')
    end

    it 'is invalid without email' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid without password' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is invalid when email has already exist' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)
      user2.invalid?
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end

  describe "count_tweets" do
    it "tweets count is correct" do
      user = create(:user)
      7.times{create(:tweet, user: user)}
      expect(user.count_tweets).to be 7
    end
  end
end

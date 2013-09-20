require_relative '../lib/follower_clash'

describe FollowerClash::Comparer do
  describe '#compare' do
    context 'when user 1 has more followers' do
      it 'should return user1' do
        user1 = double("user1")
        user2 = double("user2")

        allow(user1).to receive(:followers).and_return(10)
        allow(user2).to receive(:followers).and_return(1)
        allow(user1).to receive(:login).and_return("ornellasmike")
        allow(user2).to receive(:login).and_return("techpeace")

        expect(FollowerClash::Comparer.new(user1, user2).compare).to eq(user1.login)
      end
    end

    context 'when user 1 and user 2 have the same number of followers' do
      it 'should return tie' do
        user1 = double('user1')
        user2 = double('user2')

        allow(user1).to receive(:followers).and_return(10)
        allow(user2).to receive(:followers).and_return(10)
        allow(user1).to receive(:login).and_return("ornellasmike")
        allow(user2).to receive(:login).and_return("techpeace")

        expect(FollowerClash::Comparer.new(user1, user2).compare).to eq('tie')
      end
    end
  end
end

describe FollowerClash::User do
  describe '#followers' do
    it 'returns the number of followers from the Twitter API' do
      Twitter::Client.stub_chain(:new, :configure, :user, :followers_count).and_return(20)

      expect(FollowerClash::User.new('ornellasmike').followers).to eq(20)
    end
  end
end
shared_examples "authenticated action" do |method, action, attributes = {}|

  let!(:guest) { create(:guest) }

  let!(:user) { create(:user) }

  let!(:admin) { create(:admin) }

  context "without username and password" do
    it "should deny access to " do
      send(method, action, attributes)

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with wrong password" do
    before { http_auth(user.username, 'wrong_password') }

    it "should deny access to users " do
      send(method, action, attributes)

      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "with username and password" do
    before { http_auth(user.username, user.password) }

    it "should define current user" do
      send(method, action, attributes)

      expect(assigns(:current_user)).to eql(user)
    end

    it "should allow access" do
      send(method, action, attributes)

      expect(response).to have_http_status(:ok)
    end
  end

end

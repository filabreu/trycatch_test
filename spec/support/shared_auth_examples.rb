shared_examples "authenticated action" do |method, action, attributes = {}|

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

      expect(response).to have_http_status(:success)
    end
  end

end

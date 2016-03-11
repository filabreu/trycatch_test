require 'rails_helper'

RSpec.describe FoosController, type: :controller do

  let!(:guest) { create(:guest) }
  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }

  let!(:foo) { create(:foo, user: user) }

  let(:admin_foo) { create(:foo, user: admin)}

  describe "GET #index" do
    it_behaves_like 'authenticated action', :get, :index
  end

  describe "GET #show" do
    it_behaves_like 'authenticated action', :get, :show, { id: 1 }
  end

  describe "POST #create" do
    it_behaves_like 'authenticated action', :post, :create, { foo: { title: "foo" } }
  end

  describe "PUT #update" do
    it_behaves_like 'authenticated action', :put, :update, { id: 1, foo: { title: "foo" } }

    context "with admin role" do
      before { http_auth(admin.username, admin.password) }

      it "should allow to update his resources" do
        put :update, { id: admin_foo.id, foo: { title: 'new title' } }

        expect(response).to have_http_status(:ok)
      end

      it "should allow to update resources that don't belong to him" do
        put :update, { id: foo.id, foo: { title: 'new title' } }

        expect(response).to have_http_status(:ok)
      end
    end

    context "with user role" do
      before { http_auth(user.username, user.password) }

      it "should allow to update his resources" do
        put :update, { id: foo.id, foo: { title: 'new title' } }

        expect(response).to have_http_status(:ok)
      end

      it "should deny to update resources that don't belong to him" do
        put :update, { id: admin_foo.id, foo: { title: 'new title' } }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like 'authenticated action', :delete, :destroy, { id: 1 }

    context "with admin role" do
      before { http_auth(admin.username, admin.password) }

      it "should allow to delete his resources" do
        delete :destroy, { id: admin_foo.id }

        expect(response).to have_http_status(:ok)
      end

      it "should allow to delete resources that don't belong to him" do
        delete :destroy, { id: foo.id }

        expect(response).to have_http_status(:ok)
      end
    end

    context "with user role" do
      before { http_auth(user.username, user.password) }

      it "should allow to delete his resources" do
        delete :destroy, { id: foo.id }

        expect(response).to have_http_status(:ok)
      end

      it "should deny to delete resources that don't belong to him" do
        delete :destroy, { id: admin_foo.id }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

end

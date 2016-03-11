require 'rails_helper'

RSpec.describe BarsController, type: :controller do

  let!(:guest) { create(:guest) }
  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }

  let!(:foo) { create(:foo, user: user) }
  let!(:bar) { create(:bar, foo: foo) }

  let(:admin_foo) { create(:foo, user: admin) }
  let(:admin_bar) { create(:bar, foo: admin_foo) }

  describe "GET #index" do
    it_behaves_like 'authenticated action', :get, :index, { foo_id: 1 }
  end

  describe "GET #show" do
    it_behaves_like 'authenticated action', :get, :show, { id: 1, foo_id: 1 }
  end

  describe "POST #create" do
    it_behaves_like 'authenticated action', :post, :create, { foo_id: 1, bar: { title: "bar" } }
  end

  describe "PUT #update" do
    it_behaves_like 'authenticated action', :put, :update, { id: 1, foo_id: 1, bar: { title: "bar" } }

    context "with admin role" do
      before { http_auth(admin.username, admin.password) }

      it "should allow to update his resources" do
        put :update, { foo_id: admin_foo.id, id: admin_bar.id, bar: { title: 'new title' } }

        expect(response).to have_http_status(:ok)
      end

      it "should allow to update resources that don't belong to him" do
        put :update, { foo_id: foo.id, id: bar.id, bar: { title: 'new title' } }

        expect(response).to have_http_status(:ok)
      end
    end

    context "with user role" do
      before { http_auth(user.username, user.password) }

      it "should allow to update his resources" do
        put :update, { foo_id: foo.id, id: bar.id, bar: { title: 'new title' } }

        expect(response).to have_http_status(:ok)
      end

      it "should deny to update resources that don't belong to him" do
        put :update, { foo_id: admin_foo.id, id: admin_bar.id, bar: { title: 'new title' } }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like 'authenticated action', :delete, :destroy, { id: 1, foo_id: 1 }

    context "with admin role" do
      before { http_auth(admin.username, admin.password) }

      it "should allow to update his resources" do
        delete :destroy, { foo_id: admin_foo.id, id: admin_bar.id }

        expect(response).to have_http_status(:ok)
      end

      it "should allow to update resources that don't belong to him" do
        delete :destroy, { foo_id: foo.id, id: bar.id }

        expect(response).to have_http_status(:ok)
      end
    end

    context "with user role" do
      before { http_auth(user.username, user.password) }

      it "should allow to update his resources" do
        delete :destroy, { foo_id: foo.id, id: bar.id }

        expect(response).to have_http_status(:ok)
      end

      it "should deny to update resources that don't belong to him" do
        delete :destroy, { foo_id: admin_foo.id, id: admin_bar.id }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

end

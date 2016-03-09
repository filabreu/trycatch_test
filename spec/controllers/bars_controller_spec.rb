require 'rails_helper'

RSpec.describe BarsController, type: :controller do

  let!(:guest) { create(:guest) }

  let!(:user) { create(:user) }

  let!(:admin) { create(:admin) }

  describe "GET #index" do
    it_behaves_like 'authenticated action', :post, :create, { foo_id: 1 }
  end

  describe "GET #show" do
    it_behaves_like 'authenticated action', :post, :create, { id: 1, foo_id: 1 }
  end

  describe "GET #create" do
    it_behaves_like 'authenticated action', :post, :create, { foo_id: 1 }
  end

  describe "GET #update" do
    it_behaves_like 'authenticated action', :put, :create, { id: 1, foo_id: 1 }
  end

  describe "GET #destroy" do
    it_behaves_like 'authenticated action', :delete, :create, { id: 1, foo_id: 1 }
  end

end

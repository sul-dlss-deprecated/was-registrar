require 'rails_helper'

RSpec.describe CrawlRegistrarController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET register" do
    it "returns http success" do
      get :register
      expect(response).to have_http_status(:success)
    end
  end

end

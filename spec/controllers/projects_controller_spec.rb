require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "GET #neca" do
    it "returns http success" do
      get :neca
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #coolcool" do
    it "returns http success" do
      get :coolcool
      expect(response).to have_http_status(:success)
    end
  end

end

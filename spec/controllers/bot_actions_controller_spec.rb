require 'rails_helper'

RSpec.describe BotActionsController, type: :controller do

  describe "GET #process_user_input" do
    it "returns http success" do
      get :process_user_input
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'

RSpec.describe "WorkOrders", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/work_orders/index"
      expect(response).to have_http_status(:success)
    end
  end

end

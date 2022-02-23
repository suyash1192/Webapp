require "rails_helper"

RSpec.describe ProductsController, :type => :controller do
  describe "products api" do
    it "on GET INDEX, it has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "on CREATE product with valid params, it saves and redirects_to root with status 302" do
      post :create, params: {
        title: "Airpods"
      }
      expect(response.status).to eq(302)
      expect(response).to redirect_to root_path
    end

    it "on CREATE product with invalid params, it throws errors in json format" do
      post :create, params: {
        title: nil
      }
      expect(response.status).to eq(422)
      expect(response.content_type).to eq "application/json; charset=utf-8"
      expect(JSON.parse(response.body).length).to eq(1)
    end

    it "on DELETE product with valid params, it redirects_to root" do
      product = create(:product)
      delete :destroy, params: {
        id: product.id
      }      
      expect(Product.count).to eq(0)
      expect(response.status).to eq(303)
      expect(response).to redirect_to root_path
    end

    it "on DELETE product with invalid params, it throws errors in json format" do
      product = create(:product)
      delete :destroy, params: {
        id: 100
      }      
      expect(response.status).to eq(422)
      expect(response.content_type).to eq "application/json; charset=utf-8"
      expect(JSON.parse(response.body).length).to eq(1)
    end

    it "on UPDATE product with valid params, it respond in json format" do
      product = create(:product)
      patch :update, params: {
        id: product.id,
        task: "add"
      }, :format => :json   
      expect(response.status).to eq(200)
      expect(product.count).to eq(1)
    end

    it "on UPDATE product with invalid params, it respond in json format with errors" do
      product = create(:product)
      patch :update, params: {
        id: product.id,
      }, :format => :json   
      byebug  
      expect(response.status).to eq(422)
      expect(response.content_type).to eq "application/json; charset=utf-8"
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end
end

require 'spec_helper'

describe SessionsController do

  describe "GET '#new'" do
    it "returns login page" do
      get :new
      expect(response).to render_template :new
    end
  end


  describe "POST '#create'" do
    context "with correct credentials" do
      context "when user does not exist yet" do
        before do
          allow(controller).to receive(:validate_credentials).and_return(true)
          @params = {}
          @params[:session] = {username: "username", password: "password"}
        end
        it "saves the user in the database" do
          expect{post :create, @params}.to change(User, :count).by(1)
        end

        it "flashes the proper message" do
          post :create, @params
          expect(flash.now[:login]).to eq "Welcome new user username"
        end

        it "redirects to user path" do
          post :create, @params
          expect(flash.now[:login]).to eq "Welcome new user username"
        end
      end

      context "when user does exist" do
        before do
          allow(controller).to receive(:validate_credentials).and_return(true)
          @params = {}
          @params[:session] = {username: "username", password: "password"}
          @user = User.new(username: "username")
        end
        it "saves the user in the database" do
          expect{post :create, @params}.to change(User, :count).by(1)
        end

        it "flashes the proper message" do
          @user.save
          post :create, @params
          expect(flash.now[:login]).to eq "Welcome user #{@user.username}"
        end
      end
    end
    context "with wrong credentials" do
      before do
        allow(controller).to receive(:validate_credentials).and_return(false)
        @params = {}
        @params[:session] = {username: "username", password: "password"}
      end

      it "flashes the proper message" do
        post :create, @params
        expect(flash.now[:wrong_credentials]).to eq "Invalid email/password combination"
      end
    end
  end

end

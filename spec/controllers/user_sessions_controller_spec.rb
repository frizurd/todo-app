require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST 'create'" do
    context "with correct credentials" do
      let!(:user) { User.create(first_name: "Frizky",
                               last_name: "Kramer",
                               email: "frizkykramer@gmail.com",
                               password: "test123",
                               password_confirmation: "test123") }

      it "redirects to the todo list path" do
        post :create , email: "frizkykramer@gmail.com", password: "test123"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it "authenticates the user" do
        allow(User).to receive(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create , email: "frizkykramer@gmail.com", password: "test123"
      end

      it "sets the user_id in the session" do
        post :create , email: "frizkykramer@gmail.com", password: "test123"
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets the flash success message" do
        post :create , email: "frizkykramer@gmail.com", password: "test123"
        expect(flash[:success]).to eq("Thanks for logging in!")
      end
    end

    context "with blank credentials" do

      it "renders the new template" do
        post :create, email: "", password: ""
        expect(response).to render_template('new')
      end

      it "sets the flash error message" do
        post :create
        expect(flash[:error]).to eq("There was a problem logging in, please check your email and password.")
      end

    end

    context "with an incorrect password" do
      let!(:user) { User.create(first_name: "Frizky",
                                last_name: "Kramer",
                                email: "frizkykramer@gmail.com",
                                password: "test123",
                                password_confirmation: "test123") }

      it "renders the new template" do
        post :create, email: user.email, password: "sjaak"
        expect(response).to render_template('new')
      end

      it "sets the flash error message" do
        post :create, email: user.email, password: "sjaak"
        expect(flash[:error]).to eq("There was a problem logging in, please check your email and password.")
      end

    end

  end

end

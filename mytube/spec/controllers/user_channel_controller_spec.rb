require 'rails_helper'

RSpec.describe UserChannelController, :type => :controller do

  describe "GET list" do
    it "returns http success" do
      get :list
      expect(response).to be_success
    end
  end

end

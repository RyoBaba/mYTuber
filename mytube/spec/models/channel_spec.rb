require 'rails_helper'

# RSpec.describe Channel, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"

describe Channel do
  describe "hello method" do
    before do
      channel = Channel.new
      channel.name = "Someone"
      channel.c_id = "ChannelId"
      channel.save
      @channel = Channel.where("name = ?", "Someone").first
    end

    context "youtube resource rules" do
      
      it "resource type string" do
        Channel.resource_type.should == 'channels'
      end

      ## youtube api test
      
      # it "api call" do
      #   @channel.import_channel_info.should == 'foobar'
      # end

    end
  end

end

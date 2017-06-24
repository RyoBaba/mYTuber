require 'rails_helper'

# RSpec.describe Channel, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"

describe Channel do
  describe "hello method" do
    before do
      channel = Channel.new
      channel.name = "ヒカル"
      channel.c_id = "ABC"
      channel.save
      @channel = Channel.where("name = ?", "ヒカル").first
    end

    context "normal case." do
      
      it "not null" do
        @channel.hello.should_not be_nil
      end

      it "name値の比較" do
        result_val = @channel.hello
        result_val.should == "ヒカルでござる"
        result_val.should.eql "ヒカルでござる"
      end
    end
  end

end

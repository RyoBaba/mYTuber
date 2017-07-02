class UserChannel < ApplicationRecord
  belongs_to :user, :dependent => :destroy
  belongs_to :channels, :dependent => :destroy
end

class Video < ApplicationRecord
  belongs_to :channels
  paginates_per 25
end

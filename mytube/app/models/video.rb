class Video < ApplicationRecord
  belongs_to :channels, optional: true
  paginates_per 18
end

class BaseYoutubeResource < ApplicationRecord
  self.abstract_class = true
  def self.resource_type
    self.name.downcase.pluralize
  end
end

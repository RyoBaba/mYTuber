class Channel < ApplicationRecord
  def hello
    self.name += "でござる"
  end
end

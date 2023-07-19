class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include EnumHelper
  include SessionsHelper
end

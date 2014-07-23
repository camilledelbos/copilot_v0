ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_girl'

FactoryGirl.find_definitions


class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include FactoryGirl::Syntax::Methods


  # fixtures :all

end

class ActionController::TestCase
  include Devise::TestHelpers
end

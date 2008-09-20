require 'test_helper'

class FixtureValidationTest < ActionController::IntegrationTest

  test "fixtures should be valid" do
    models = Fixtures.all_loaded_fixtures.keys
    models.each do |model|
      model = model.capitalize.singularize.constantize
      fixtures = model.find(:all)
      fixtures.each do |fixture|
        if !fixture.valid?
          puts; puts "WARNING: Invalid fixture: #{fixture.inspect}"
        end
        assert_valid fixture
      end
    end
  end
end

require 'spec_helper'

#
# The factories spec is in the root of the specs directory to avoid circular require
#
FactoryBot.factories.map(&:name).each do |factory_name|
  describe "Factory: #{factory_name}" do
    it "can be created" do
      create(factory_name)
    end
  end
end

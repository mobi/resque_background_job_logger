require 'test_helper'

class BackgroundJobLoggerPluginTest < Minitest::Test

  def setup
    @subject = Class.new do
      include Resque::Plugins::BackgroundJobLogger
    end
  end

  def test_plugin_provides_configuration_methods
    %i(store_arguments store_arguments? track_memory track_memory?).each do |method|
      assert @subject.respond_to?(method), "Plugin does not provide #{method}"
    end
  end

  def test_store_arguments_defaults_to_false_and_can_be_set_to_true
    assert_equal false, @subject.store_arguments?
    @subject.store_arguments
    assert_equal true, @subject.store_arguments?
  end

  def test_track_memory_defaults_to_false_and_can_be_set_to_true
    assert_equal false, @subject.track_memory?
    @subject.track_memory
    assert_equal true, @subject.track_memory?
  end

end

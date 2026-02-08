require "test_helper"
require Rails.root.join("lib/learn/provider_config")

class Learn::ProviderConfigTest < ActiveSupport::TestCase
  test "defaults to production provider when oauth_provider_env is missing" do
    env = {}

    assert_equal "production", Learn::ProviderConfig.provider_environment(env)
    assert_equal "https://learn.derose.app", Learn::ProviderConfig.default_site(env)
  end

  test "uses development provider when oauth_provider_env is development" do
    env = {"oauth_provider_env" => "development"}

    assert_equal "development", Learn::ProviderConfig.provider_environment(env)
    assert_equal "http://localhost:3031", Learn::ProviderConfig.default_site(env)
  end

  test "supports uppercase OAUTH_PROVIDER_ENV as fallback" do
    env = {"OAUTH_PROVIDER_ENV" => "development"}

    assert_equal "development", Learn::ProviderConfig.provider_environment(env)
    assert_equal "http://localhost:3031", Learn::ProviderConfig.default_site(env)
  end

  test "falls back to production provider for unknown values" do
    env = {"oauth_provider_env" => "staging"}

    assert_equal "staging", Learn::ProviderConfig.provider_environment(env)
    assert_equal "https://learn.derose.app", Learn::ProviderConfig.default_site(env)
  end
end

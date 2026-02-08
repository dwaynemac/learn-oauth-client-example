module Learn
  module ProviderConfig
    DEVELOPMENT_SITE = "http://localhost:3031"
    PRODUCTION_SITE = "https://learn.derose.app"

    module_function

    def provider_environment(env = ENV)
      raw_value = env["oauth_provider_env"] || env["OAUTH_PROVIDER_ENV"]
      normalized_value = raw_value.to_s.strip.downcase

      normalized_value.empty? ? "production" : normalized_value
    end

    def default_site(env = ENV)
      if provider_environment(env) == "development"
        DEVELOPMENT_SITE
      else
        PRODUCTION_SITE
      end
    end
  end
end

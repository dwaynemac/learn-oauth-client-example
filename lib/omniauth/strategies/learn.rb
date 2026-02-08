module OmniAuth
  module Strategies
    class Learn < OmniAuth::Strategies::OAuth2
      option :name, "learn"

      uid do
        raw_info["sub"]
      end

      info do
        {
          email: raw_info["email"],
          name: raw_info["name"],
          first_name: raw_info["given_name"],
          last_name: raw_info["family_name"],
          image: raw_info["picture"],
          enabled_accounts: raw_info["enabled_accounts"] || raw_info["accounts"]
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get("/oauth/userinfo").parsed
      end
    end
  end
end

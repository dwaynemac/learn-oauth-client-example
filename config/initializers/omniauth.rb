require Rails.root.join("lib/omniauth/strategies/learn")

default_learn_site = if Rails.env.development?
  "http://localhost:3031"
else
  "https://learn.derose.app"
end

default_redirect_uri = if Rails.env.development?
  "http://localhost:3000/auth/learn/callback"
else
  "https://your-app.example.com/auth/learn/callback"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :learn,
    scope: "openid email profile",
    client_id: ENV.fetch("LEARN_CLIENT_ID", ""),
    client_secret: ENV.fetch("LEARN_CLIENT_SECRET", ""),
    client_options: {
      site: ENV.fetch("LEARN_SITE", default_learn_site),
      authorize_url: "/oauth/authorize",
      token_url: "/oauth/token"
    },
    callback_url: ENV.fetch("LEARN_REDIRECT_URI", default_redirect_uri),
    pkce: true
end

# OmniAuth 2 acepta solicitudes por POST para iniciar el flujo.
OmniAuth.config.allowed_request_methods = [:post]
OmniAuth.config.silence_get_warning = true

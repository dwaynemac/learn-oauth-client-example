# OAuth Client Example (Login with LEARN)

Rails 8 sample client that authenticates users against the LEARN OAuth 2.0 /
OpenID Connect provider using Authorization Code + PKCE.

Provider reference used:
`oauth_provider.md` (source documentation file provided locally)

## Ruby / Rails

- Ruby: `3.3.4`
- Rails: `8.0.2`

## OAuth Settings

This app uses OmniAuth OAuth2 with LEARN endpoints and these defaults:

- Development issuer: `http://localhost:3031`
- Non-development issuer: `https://learn.derose.app`
- Callback path: `/auth/learn/callback`
- Default development callback URL:
  `http://localhost:3000/auth/learn/callback`

## Environment Variables (`.env`)

This app now loads env vars from a `.env` file in development/test.

1. Copy the template:

```bash
cp .env.example .env
```

2. Edit `.env` and set:

```bash
LEARN_CLIENT_ID=your-client-id
LEARN_CLIENT_SECRET=your-client-secret
LEARN_SITE=http://localhost:3031
LEARN_REDIRECT_URI=http://localhost:3000/auth/learn/callback
```

`LEARN_SITE` defaults to `http://localhost:3031` in development if omitted.

## Register OAuth Application in LEARN

In LEARN admin, create an OAuth app with:

- Scopes: `openid email profile`
- Redirect URI:
  `http://localhost:3000/auth/learn/callback`

Redirect URI must match exactly.

## App Routes

- `GET /` home page with login button
- `POST /auth/learn` start OAuth flow
- `GET|POST /auth/learn/callback` OAuth callback
- `GET /auth/failure` OAuth failure handler
- `DELETE /logout` clear local session

## Setup

```bash
bundle install
bin/rails db:prepare
bin/rails server
```

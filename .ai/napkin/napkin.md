# Napkin

## Corrections
| Date | Source | What Went Wrong | What To Do Instead |
|------|--------|----------------|-------------------|

## User Preferences
- Prefer Ruby over Python.
- Follow `standard-rails` style for Ruby edits.

## Patterns That Work
- Search with `rg` to find config entry points quickly.
- Keep `LEARN_SITE` as an explicit override and use `oauth_provider_env` only for default mapping.
- Support both `oauth_provider_env` and `OAUTH_PROVIDER_ENV` to reduce env-key friction.
- Remove `LEARN_SITE` from `.env` when validating env-based toggles, otherwise the override masks new behavior.

## Patterns That Don't Work
- N/A

## Domain Notes
- OAuth provider defaults now map from `oauth_provider_env`:
  - `development` => `http://localhost:3031`
  - `production` (or unset/unknown) => `https://learn.derose.app`

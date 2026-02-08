# Napkin

## Corrections
| Date | Source | What Went Wrong | What To Do Instead |
|------|--------|----------------|-------------------|
| 2026-02-07 | self | Assumed Rails CLI might already be available | Verify `rails -v` early and prepare local `vendor/bundle` install path when system gems are unavailable |
| 2026-02-07 | user | Asked for Rails 8 specifically after Rails 6 attempt | Use the exact major version requested before scaffolding |
| 2026-02-07 | self | `omniauth-openid-connect` resolved to a legacy version incompatible with Rails 8 | Use `omniauth-oauth2` + custom strategy for LEARN on Rails 8 |
| 2026-02-07 | self | `minitest` auto-resolved to 6.x and broke Rails test runner | Pin `minitest` to a 5.x version in Rails 8 apps when resolver picks 6.x |
| 2026-02-07 | self | `git rm --cached` failed in sandbox due `.git/index.lock` permission | Retry git index-writing commands with escalated permissions when sandbox blocks `.git` writes |

## User Preferences
- Prefer Ruby over Python.
- Ruby style should follow `standard-rails`.
- Comments should be in Spanish when helpful.

## Patterns That Work
- Start by reading provider docs before scaffolding OAuth flows.
- For Rails 8 OAuth clients, `omniauth-oauth2` with a custom strategy is more reliable than legacy OIDC strategy gems.
- For OmniAuth callback controller tests, add a test-only route outside `/auth/*` to bypass middleware CSRF/state checks.
- `client_id missing` from provider maps directly to missing `LEARN_CLIENT_ID` in the Rails process env.
- Use `dotenv-rails` in `development,test` so `.env` values are loaded automatically for local OAuth credentials.
- For frontend refresh tasks, keep OAuth forms unchanged and layer modern UI via CSS classes to avoid test regressions.
- In Rails repos, treat committed `config/master.key` as critical even when only `credentials.yml.enc` is present.

## Patterns That Don't Work
- Making assumptions about OAuth endpoint paths without provider documentation.

## Domain Notes
- This repo is used to build an OAuth client example for LEARN login integration.
- Local environment has Ruby 2.6.10 and Bundler 1.17.2.
- `rbenv` has newer Rubies available, including 3.3.4 for Rails 8 work.

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Ruby on Rails web application for tracking influencer merch collections. Users can browse merch items, mark ownership, upload proof images, and share collections via Meta Threads. Items are linked to brands (Maker model) and influencers.

## Development Commands

```bash
# Install dependencies
bundle install

# Database setup
bin/rails db:create db:migrate db:seed

# Run development server (includes TailwindCSS compilation)
./bin/dev

# Run all tests
bin/rails test

# Run specific test types
bin/rails test:models
bin/rails test:controllers
bin/rails test:system

# Run a single test file
bin/rails test test/models/item_test.rb

# Run a single test by line number
bin/rails test test/models/item_test.rb:10

# Lint
bin/rubocop
```

## Architecture

**Stack:** Rails 8.1, Ruby 3.4.8, PostgreSQL, Hotwire (Turbo + Stimulus), TailwindCSS 3.0, Propshaft (asset pipeline)

**Core Models:**
- `User` - `has_secure_password`; has many items through ownerships; has many `threads_accounts` and `api_tokens`
- `Item` - merch product with `has_one_attached :image`, belongs to maker/brand (via `belongs_to :item_maker, foreign_key: :maker_id, class_name: "Maker"`), optionally belongs to `Influencer`. Uses `store_accessor :data` for JSON fields: `category`, `size`, `color`, `limited_edition`, `amazon_url`, `official_url`
- `Ownership` - join table between User and Item, `has_one_attached :proof`
- `ItemGroup` - collections of items via `Joiner` join table
- `Maker` - brands/manufacturers (title, origin, homepage). Displayed as "Brand" in the UI
- `Influencer` - content creators (name, bio, platform, handle, profile_url, follower_count). `has_one_attached :avatar` with `:thumb` variant. `has_many :items, dependent: :nullify`
- `ThreadsAccount` - stores encrypted Threads API tokens via `EncryptedJsonSerializer` on the `tokens` column
- `ApiToken` - token-based API auth with SHA256 digest, 30-day expiry

**Two authentication systems:**
1. **Web:** Session-based (`session[:user_id]`) with bcrypt. Auth methods in `ApplicationController`: `ensure_login`, `ensure_admin`, `signed_in?`, `current_user`. Admin determined by email match (`admin@lininglink.com`).
2. **API:** Token-based via `Authorization: Bearer <token>` header. `API::V1::BaseController` inherits from `ActionController::API` and authenticates via `ApiToken.authenticate(token)`.

**File Storage:** Active Storage with local disk or Google Cloud Storage backends (`config/storage.yml`).

**Key Web Routes:**
- `/items` - catalog with search/pagination (Pagy, 8 per page)
- `/items/:id/own` and `/unown` - toggle ownership
- `/items/collection` - user's owned items
- `/influencers` - influencer listing
- `/influencers/:id` - influencer profile with their merch items
- `/users/:id/share` - Threads sharing interface
- `/admin/items/:id/edit` and `/admin/item_groups/*` - admin-only management
- `/admin/influencers/*` - admin influencer CRUD

**JSON API** (`/api/v1/`):
- `POST /api/v1/session` - login, returns token
- `POST /api/v1/registration` - signup, returns token
- `GET /api/v1/items` - paginated items (20 per page), search via `title` param
- `GET /api/v1/items/:id` - item detail with ownership status
- `POST /api/v1/items/:id/own`, `DELETE /api/v1/items/:id/unown` - toggle ownership
- `PATCH /api/v1/ownerships/:id` - upload proof image
- `GET /api/v1/collection` - current user's collection
- `GET /api/v1/me` - current user info
- `GET /api/v1/makers` - all makers/brands with item counts
- `GET /api/v1/influencers` - all influencers with item counts
- `GET /api/v1/influencers/:id` - influencer detail with items
- `GET /api/v1/users/:id` - public user profile
- `GET /api/v1/item_groups`, `GET /api/v1/item_groups/:id` - item groups

## Important Patterns

- Image variant `:thumb` defined as `resize_to_limit: [100, 100]` on `Item` and `Influencer`
- `EncryptedJsonSerializer` (`app/serializers/encrypted_json_serializer.rb`) encrypts/decrypts individual JSON values using `ActiveSupport::MessageEncryptor` with `secret_key_base`
- Controller auth: web uses `ensure_login` before_action; API uses `authenticate_token!`
- Pagination: `Pagy::Backend` in controllers, `Pagy::Frontend` in `ApplicationHelper`
- CORS: configured in `config/initializers/cors.rb`, allows all origins for `/api/*` routes
- Database name prefix: `post_items_` (development/test/production)
- Maker model is displayed as "Brand" in the UI
- Items have optional influencer association (`belongs_to :influencer, optional: true`)

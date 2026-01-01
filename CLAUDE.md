# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Ruby on Rails web application for tracking mechanical pencil collections. Users can browse items, mark ownership, upload proof images, and share collections via Meta Threads.

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
```

## Architecture

**Stack:** Rails 7.1, PostgreSQL, Hotwire (Turbo + Stimulus), TailwindCSS

**Core Models:**
- `User` - has many items through ownerships; integrates with Threads OAuth
- `Item` - mechanical pencil with image attachment, belongs to maker
- `Ownership` - join table between User and Item, has proof image attachment
- `ItemGroup` - collections of items via Joiner join table
- `Maker` - item manufacturers
- `ThreadsAccount` - stores encrypted Threads API tokens

**Authentication:** Session-based with bcrypt. Admin determined by email (admin@lininglink.com).

**File Storage:** Active Storage with local or Google Cloud Storage backends (configured in `config/storage.yml`).

**Key Routes:**
- `/items` - catalog with search/pagination (Pagy)
- `/items/:id/own` and `/unown` - toggle ownership
- `/items/collection` - user's owned items
- `/users/:id/share` - Threads sharing interface

## Important Patterns

- Image variants defined in `Item#thumbnail` method
- Encrypted token storage uses `EncryptedJsonSerializer` for Threads tokens
- Controller authentication via `authenticate_user!` before_action
- Admin checks via `current_user_admin?` helper

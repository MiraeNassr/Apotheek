# AI Assistant Instructions for Apotheek Project

## Project Overview
This is a pharmacy (apotheek) management system built with Vue 3 and PHP. The project uses Vite for frontend tooling and has a PHP/MySQL backend.

## Architecture

### Frontend (Vue 3)
- Single-page application using Vue 3's Composition API
- Located in `src/` directory with main components:
  - `App.vue`: Root component with authentication modals
  - `producten.vue`: Products component with category filtering
- State management uses Vue's ref/reactive system (no Vuex/Pinia)

### Backend (PHP/MySQL)
- REST API endpoints in `back-end/` directory
- Database: MySQL (`de_pillen_all_stars` database)
- Key endpoints:
  - `get_products.php`: Retrieves products with optional category filtering

## Key Patterns

### Category Mapping
Products use different category names in frontend vs database. See mapping in `producten.vue`:
```javascript
const mapCategoryToDB = {
  'Antihistamine': 'Antihistamine',
  'Vitaminen & Supplements': 'Vitaminen & Supplements',
  'Antibiotics': 'Antibioticum',
  'Pain relief': 'Pijnstillers'
};
```

### Authentication
- Modal-based login/register system in `App.vue`
- Password requirements enforced via `isStrongPassword` helper:
  - Minimum 8 characters
  - Must contain uppercase, lowercase, numbers, and special characters

## Development Workflow

### Setup
1. Install dependencies:
```sh
npm install
```

2. Configure MySQL:
- Create database `de_pillen_all_stars`
- Import schema from `back-end/de_pillen_all-stars.sql`
- Update connection settings in PHP files if needed (default: localhost/root/no password)

### Development
```sh
npm run dev  # Starts Vite dev server
```

### Production Build
```sh
npm run build  # Creates optimized build in dist/
```

## Common Tasks

### Adding New Product Categories
1. Update mapping in `producten.vue`:
  - Add to `getCategoryDisplayName`
  - Add to `mapCategoryToDB`
2. Update database category in `product` table

### API Integration
- All API calls use native `fetch` API
- Backend responses are always JSON with consistent error format:
```json
{ "error": "error message" }  // On error
{ "data": [...] }            // On success
```

## Common Pitfalls
- Always encode URL parameters for PHP endpoints using `encodeURIComponent`
- Backend allows CORS from all origins (for development) - update in production
- Password validation happens on both frontend and backend
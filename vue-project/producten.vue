<script setup>
import { ref, onMounted } from 'vue';

// Props
const props = defineProps({
  category: {
    type: String,
    default: ''
  }
});

// Reactive data
const products = ref([]);
const selectedCategoryName = ref('');
const error = ref('');

// Category mapping constants
const CATEGORY_DISPLAY_NAMES = {
  'Antihistamine': 'Antihistamine Producten',
  'Vitaminen & Supplements': 'Vitaminen & Supplementen',
  'Antibiotics': 'Antibiotica Producten',
  'Pain relief': 'Pijnverlichting Producten',
};

const CATEGORY_DB_MAPPING = {
  'Antihistamine': 'Antihistamine',
  'Vitaminen & Supplements': 'Vitaminen & Supplements',
  'Antibiotics': 'Antibioticum',
  'Pain relief': 'Pijnstillers',
};

// Function to get display name for category
const getCategoryDisplayName = (category) => {
  return CATEGORY_DISPLAY_NAMES[category] || 'Alle Producten';
};

// Function to map frontend category to database category
const mapCategoryToDB = (category) => {
  return CATEGORY_DB_MAPPING[category] || category;
};

// Fetch products on mount
onMounted(async () => {
  selectedCategoryName.value = getCategoryDisplayName(props.category);
  try {
    const dbCategory = mapCategoryToDB(props.category);
    console.log('Fetching category:', dbCategory); // Debug log

  // Use dev-server proxy (relative path) so requests are proxied to Apache and avoid CORS
  const apiUrl = `/back-end/get_products.php?category=${encodeURIComponent(dbCategory)}`;
    console.log('Attempting to fetch from:', apiUrl); // Debug URL
    const response = await fetch(apiUrl, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
        'Cache-Control': 'no-cache'
      },
    });
      
    if (!response.ok) {
      console.error('Response not OK:', {
        status: response.status,
        statusText: response.statusText,
        url: response.url
      });
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    console.log('Received data:', data); // Debug log
    if (data.error) {
      throw new Error(data.error);
    }
    products.value = data;
  } catch (err) {
    error.value = err.message;
  }
});

// Helper to safely format prices (handles string or numeric inputs)
const formatPrice = (price) => {
  if (price === null || price === undefined) return '';
  const num = Number(String(price).replace(',', '.'));
  if (!isFinite(num)) return String(price);
  return num.toFixed(2).replace('.', ',');
};

// Helper to format image URLs to point to Apache server
const formatImageUrl = (url) => {
  if (!url) return '';
  // Point directly to the assets directory in Apache's root
  return `http://localhost/${url}`;
};
</script>

<template>
  <div id="hoofd-app">
    <header class="top-bar">
    </header>

    <main class="main-content product-page-layout">
      <h1 id="category-title">Producten: {{ selectedCategoryName }}</h1>

      <section class="product-list">
        <p v-if="error" class="error-message">{{ error }}</p>
        <p v-else-if="products.length === 0" class="no-results-message">Geen producten gevonden in de categorie '{{ selectedCategoryName }}'.</p>
        <div v-else v-for="product in products" :key="product.product_id" class="product-item">
          <div class="product-image-box">
            <img :src="formatImageUrl(product.afbeelding_url)" :alt="product.naam" class="product-img">
          </div>
          <div class="product-details">
            <p class="product-info-title">{{ product.naam }}</p>
            <p class="product-info-description">{{ product.beschrijving }}</p>
            <button class="add-to-cart-btn">
              € {{ formatPrice(product.prijs) }} | Bestel
            </button>
          </div>
        </div>
      </section>

      <button class="chat-icon-fixed">💬</button>
    </main>

    <footer class="main-footer">
    </footer>
  </div>
</template>

<style scoped>
@import './src/assets/style.css';
</style>

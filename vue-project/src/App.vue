<script setup>
import { ref } from 'vue';

// Reactive state for modal visibility
const showLoginModal = ref(false);
const showRegisterModal = ref(false);

// Form data
const loginData = ref({
  email: '',
  password: ''
});

const registerData = ref({
  name: '',
  email: '',
  password: '',
  confirmPassword: '',
  address: ''
});

// Methods to handle modal actions
const openLoginModal = () => {
  showLoginModal.value = true;
  showRegisterModal.value = false;
};

const openRegisterModal = () => {
  showRegisterModal.value = true;
  showLoginModal.value = false;
};

const closeModals = () => {
  showLoginModal.value = false;
  showRegisterModal.value = false;
};

const handleLogin = () => {
  // Add login logic here (e.g., API call)
  console.log('Login data:', loginData.value);
  closeModals();
};

const handleRegister = () => {
  // Add register logic here (e.g., API call)
  console.log('Register data:', registerData.value);
  closeModals();
};
</script>

<template>
  <div class="modal-component">
    <header class="top-bar">
      <div class="logo-container">
        <a href="/" class="logo-link">
          <span class="logo-text">De Pillen All-stars </span>
        </a>
      </div>

      <nav class="nav-links">
        <a href="/" class="nav-link">Home</a>
        <a href="/over-ons" class="nav-link">Over Ons</a>
        <a href="/diensten" class="nav-link">Diensten</a>
        <a href="/contact" class="nav-link">Contact</a>
      </nav>

      <div class="actions">
        <button class="action-btn theme-switch-icon" title="Schakel thema">🌙</button>
        <button class="action-btn search-icon">🔍</button>
        <button class="action-btn cart-icon">🛒</button>
        <button @click="openLoginModal" class="auth-btn login-btn">Inloggen</button>
        <button @click="openRegisterModal" class="auth-btn register-btn">Registreren</button>
      </div>
    </header>

    <main class="main-content">
      <section class="search-section">
        <div class="search-box-container">
          <img src="" alt="">
          <input type="search" placeholder="Zoeken" class="search-input" id="searchQuery">
          <button class="search-button">🔍</button>
        </div>
      </section>

      <section class="info-text">
        <p>Welkom bij Apotheek De Pillen All-stars , uw complete platform voor het bestellen van medicijnen en gezondheidsproducten. U kunt medicijnen zoeken of de onderstaande categorieën bekijken.</p>
      </section>

      <section class="category-grid">
        <a href="producten.html?category=Antihistamine" class="category-link">
          <div class="category-item">
            <div class="category-icon-box">
              <img src="./assets/images/home1.jpg" alt="Pijnstillers" class="category-img">
            </div>
            <p>Antihistamine</p>
          </div>
        </a>

        <a href="producten.html?category=Vitaminen & Supplements" class="category-link">
          <div class="category-item">
            <div class="category-icon-box">
              <img src="./assets/images/home3.jpg" alt="Vitaminen" class="category-img">
            </div>
            <p>Vitaminen & Supplements </p>
          </div>
        </a>

        <a href="producten.html?category=Antibiotics" class="category-link">
          <div class="category-item">
            <div class="category-icon-box">
              <img src="./assets/images/home2.jpg" alt="Huidverzorging" class="category-img">
            </div>
            <p>Antibiotics</p>
          </div>
        </a>

        <a href="producten.html?category=Pain relief" class="category-link">
          <div class="category-item">
            <div class="category-icon-box">
              <img src="./assets/images/home4.jpg" alt="Baby & Kind" class="category-img">
            </div>
            <p>Pain relief</p>
          </div>
        </a>
      </section>

      <button class="chat-icon-fixed">💬</button>
    </main>

    <footer class="main-footer">
      <div class="footer-contact">
        <h4>Contactinformatie</h4>
        <ul>
          <li>Adres: Iuvhkjfggdggf</li>
          <li>E-mail: Fdgopsgdffg@jdfm.nl</li>
          <li>Telefoon: 0612XXXXXX</li>
        </ul>
      </div>
    </footer>

    <!-- Login Modal -->
    <div v-if="showLoginModal" class="modal-overlay" @click="closeModals">
      <div class="modal" @click.stop>
        <h2>Inloggen</h2>
        <form @submit.prevent="handleLogin">
          <div class="form-group">
            <label for="login-email">Email:</label>
            <input id="login-email" v-model="loginData.email" type="email" required>
          </div>
          <div class="form-group">
            <label for="login-password">Wachtwoord:</label>
            <input id="login-password" v-model="loginData.password" type="password" required>
          </div>
          <div class="modal-actions">
            <button type="submit" class="btn">Inloggen</button>
            <button type="button" @click="closeModals" class="btn cancel">Annuleren</button>
          </div>
        </form>
      </div>
    </div>

    <!-- Register Modal -->
    <div v-if="showRegisterModal" class="modal-overlay" @click="closeModals">
      <div class="modal" @click.stop>
        <h2>Registreren</h2>
        <form @submit.prevent="handleRegister">
          <div class="form-group">
            <label for="register-name">Naam:</label>
            <input id="register-name" v-model="registerData.name" type="text" required>
          </div>
          <div class="form-group">
            <label for="register-email">Email:</label>
            <input id="register-email" v-model="registerData.email" type="email" required>
          </div>
          <div class="form-group">
            <label for="register-address">Adres:</label>
            <input id="register-address" v-model="registerData.address" type="text" required>
          </div>
          <div class="form-group">
            <label for="register-password">Wachtwoord:</label>
            <input id="register-password" v-model="registerData.password" type="password" required>
          </div>
          <div class="form-group">
            <label for="register-confirm-password">Bevestig Wachtwoord:</label>
            <input id="register-confirm-password" v-model="registerData.confirmPassword" type="password" required>
          </div>
          <div class="modal-actions">
            <button type="submit" class="btn">Registreren</button>
            <button type="button" @click="closeModals" class="btn cancel">Annuleren</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped>
@import './assets/style.css';

.app-container {
  text-align: center;
  padding: 20px;
}
</style>

<script setup>
import { ref, onMounted } from 'vue';
import Producten from '../producten.vue';
//import OllamaChat from 'App.jsx';

// Reactive state for user and modal visibility
const isLoggedIn = ref(false);
const currentUser = ref(null);
const showLoginModal = ref(false);
const showRegisterModal = ref(false);

// Theme state
const isDarkTheme = ref(false);

// Toggle theme function
const toggleTheme = () => {
  isDarkTheme.value = !isDarkTheme.value;
  localStorage.setItem('theme', isDarkTheme.value ? 'dark' : 'light');
  if (isDarkTheme.value) {
    document.documentElement.classList.add('dark-theme');
    document.body.classList.add('dark-theme');
    document.querySelector('#app')?.classList.add('dark-theme');
  } else {
    document.documentElement.classList.remove('dark-theme');
    document.body.classList.remove('dark-theme');
    document.querySelector('#app')?.classList.remove('dark-theme');
  }
};

// Check login status and theme on mount
onMounted(() => {
  // Load user data
  const userData = localStorage.getItem('user');
  if (userData) {
    currentUser.value = JSON.parse(userData);
    isLoggedIn.value = true;
  }

  // Load theme preference
  const savedTheme = localStorage.getItem('theme');
  if (savedTheme) {
    isDarkTheme.value = savedTheme === 'dark';
  } else {
    // Check system preference
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    isDarkTheme.value = prefersDark;
  }
  
  // Apply theme
  if (isDarkTheme.value) {
    document.documentElement.classList.add('dark-theme');
    document.body.classList.add('dark-theme');
  } else {
    document.documentElement.classList.remove('dark-theme');
    document.body.classList.remove('dark-theme');
  }
});

// Reactive state for products view
const selectedCategory = ref('');
const showProducts = ref(false);

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

// Error states
const loginErrors = ref({});
const registerErrors = ref({});

// Helper function for password strength
const isStrongPassword = (password) => {
  const minLength = 8;
  const hasUpperCase = /[A-Z]/.test(password);
  const hasLowerCase = /[a-z]/.test(password);
  const hasNumbers = /\d/.test(password);
  const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);
  return password.length >= minLength && hasUpperCase && hasLowerCase && hasNumbers && hasSpecialChar;
};

// Helper function for email validation
const isValidEmail = (email) => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

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

const handleLogout = () => {
  localStorage.removeItem('user');
  currentUser.value = null;
  isLoggedIn.value = false;
  // You could redirect to home page or refresh the page here if needed
};

// Methods to handle category selection
const selectCategory = (category) => {
  selectedCategory.value = category;
  showProducts.value = true;
};

const goHome = () => {
  showProducts.value = false;
  selectedCategory.value = '';
};

const handleLogin = async () => {
  // Reset errors
  loginErrors.value = {};

  try {
    // Validation
    if (!loginData.value.email || !isValidEmail(loginData.value.email)) {
      loginErrors.value.email = 'Voer een geldig e-mailadres in.';
      return;
    }
    if (!loginData.value.password) {
      loginErrors.value.password = 'Wachtwoord is verplicht.';
      return;
    }

    console.log('Attempting login...'); // Debug log

    const response = await fetch('/back-end/login_klant.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        email: loginData.value.email.trim(),
        wachtwoord: loginData.value.password
      })
    });

    const data = await response.json();
    console.log('Server response:', data); // Debug log

    if (!response.ok || data.error) {
      throw new Error(data.error || 'Login failed');
    }

    // Store user data and update login state
    localStorage.setItem('user', JSON.stringify(data.user));
    currentUser.value = data.user;
    isLoggedIn.value = true;
    
    // Clear form and close modal on success
    loginData.value = {
      email: '',
      password: ''
    };
    closeModals();
    
    // You can add additional logic here, like redirecting to a dashboard
    // or updating the UI to show the logged-in state

  } catch (err) {
    console.error('Login error:', err); // Debug log
    loginErrors.value.submit = err.message;
  }
};

const handleRegister = async () => {
  // Reset errors
  registerErrors.value = {};

  try {
    // Validation
    if (!registerData.value.name?.trim()) {
      registerErrors.value.name = 'Naam is verplicht.';
    }
    if (!registerData.value.email || !isValidEmail(registerData.value.email)) {
      registerErrors.value.email = 'Voer een geldig e-mailadres in.';
    }
    if (!registerData.value.password || !isStrongPassword(registerData.value.password)) {
      registerErrors.value.password = 'Wachtwoord moet minimaal 8 tekens bevatten, met hoofdletters, kleine letters, cijfers en speciale tekens.';
    }
    if (registerData.value.password !== registerData.value.confirmPassword) {
      registerErrors.value.confirmPassword = 'Wachtwoorden komen niet overeen.';
    }

    // If errors, don't proceed
    if (Object.keys(registerErrors.value).length > 0) {
      return;
    }

    console.log('Sending registration data...'); // Debug log

    const response = await fetch('/back-end/register_klant.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        naam: registerData.value.name.trim(),
        email: registerData.value.email.trim(),
        wachtwoord: registerData.value.password,
        adres: registerData.value.address?.trim() || ''
      })
    });

    const data = await response.json();
    console.log('Server response:', data); // Debug log

    if (!response.ok || data.error) {
      throw new Error(data.error || 'Registration failed');
    }

    // Clear form and close modal on success
    registerData.value = {
      name: '',
      email: '',
      password: '',
      confirmPassword: '',
      address: ''
    };
    closeModals();
    alert('Registratie succesvol! U kunt nu inloggen.');

  } catch (err) {
    console.error('Registration error:', err); // Debug log
    registerErrors.value.submit = err.message;
  }
};
</script>

<template>
  <div :class="['modal-component', {'dark-theme': isDarkTheme}]">
    <header class="top-bar">
      <div class="logo-container">
        <a href="/" class="logo-link">
          <span class="logo-text">De Pillen All-stars </span>
        </a>
      </div>

      <nav class="nav-links">
        <a href="/" @click="goHome" class="nav-link">Home</a>
        <a href="/over-ons" class="nav-link">Over Ons</a>
        <a href="/diensten" class="nav-link">Diensten</a>
        <a href="/contact" class="nav-link">Contact</a>
      </nav>

      <div class="actions">
        <button @click="toggleTheme" class="action-btn theme-switch-icon" :title="isDarkTheme ? 'Schakel naar licht thema' : 'Schakel naar donker thema'">
          {{ isDarkTheme ? '☀️' : '🌙' }}
        </button>
        
        <button class="action-btn cart-icon">🛒</button>
        <template v-if="!isLoggedIn">
          <button @click="openLoginModal" class="auth-btn login-btn">Inloggen</button>
          <button @click="openRegisterModal" class="auth-btn register-btn">Registreren</button>
        </template>
        <template v-else>
          <span class="welcome-text">Welkom, {{ currentUser?.naam }}</span>
          <button @click="handleLogout" class="auth-btn logout-btn">Uitloggen</button>
        </template>
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

      <section v-if="!showProducts" class="category-grid">
        <div @click="selectCategory('Antihistamine')" class="category-link">
          <div class="category-item">
            <div class="category-icon-box">
              <img src="./assets/images/home1.jpg" alt="Antihistamine" class="category-img">
            </div>
            <p>Antihistamine</p>
          </div>
        </div>

        <div @click="selectCategory('Vitaminen & Supplements')" class="category-link">
          <div class="category-item">
            <div class="category-icon-box">
              <img src="./assets/images/home3.jpg" alt="Vitaminen" class="category-img">
            </div>
            <p>Vitaminen & Supplements </p>
          </div>
        </div>

        <div @click="selectCategory('Antibiotics')" class="category-link">
          <div class="category-item">
            <div class="category-icon-box">
              <img src="./assets/images/home2.jpg" alt="Antibioticum" class="category-img">
            </div>
            <p>Antibiotics</p>
          </div>
        </div>

        <div @click="selectCategory('Pain relief')" class="category-link">
          <div class="category-item">
            <div class="category-icon-box">
              <img src="./assets/images/home4.jpg" alt="Pijnstillers" class="category-img">
            </div>
            <p>Pain relief</p>
          </div>
        </div>
      </section>

      <Producten v-if="showProducts" :category="selectedCategory" />
      <button v-if="showProducts" @click="goHome" class="back-btn">Terug naar Home</button>

     <!--<OllamaChat/>--> 
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
            <span v-if="loginErrors.email" class="error">{{ loginErrors.email }}</span>
          </div>
          <div class="form-group">
            <label for="login-password">Wachtwoord:</label>
            <input id="login-password" v-model="loginData.password" type="password" required>
            <span v-if="loginErrors.password" class="error">{{ loginErrors.password }}</span>
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
            <span v-if="registerErrors.name" class="error">{{ registerErrors.name }}</span>
          </div>
          <div class="form-group">
            <label for="register-email">Email:</label>
            <input id="register-email" v-model="registerData.email" type="email" required>
            <span v-if="registerErrors.email" class="error">{{ registerErrors.email }}</span>
          </div>
          <div class="form-group">
            <label for="register-address">Adres:</label>
            <input id="register-address" v-model="registerData.address" type="text" required>
            <span v-if="registerErrors.address" class="error">{{ registerErrors.address }}</span>
          </div>
          <div class="form-group">
            <label for="register-password">Wachtwoord:</label>
            <input id="register-password" v-model="registerData.password" type="password" required>
            <span v-if="registerErrors.password" class="error">{{ registerErrors.password }}</span>
          </div>
          <div class="form-group">
            <label for="register-confirm-password">Bevestig Wachtwoord:</label>
            <input id="register-confirm-password" v-model="registerData.confirmPassword" type="password" required>
            <span v-if="registerErrors.confirmPassword" class="error">{{ registerErrors.confirmPassword }}</span>
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

<style>
@import './src/assets/style.css';
</style>

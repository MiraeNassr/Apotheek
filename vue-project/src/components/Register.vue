<![CDATA[<script setup>
import { ref } from 'vue';

const formData = ref({
  naam: '',
  email: '',
  wachtwoord: '',
  adres: ''
});

const error = ref('');
const success = ref('');

const handleSubmit = async (e) => {
  e.preventDefault();
  error.value = '';
  success.value = '';

  try {
    const response = await fetch('/back-end/register_klant.php', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formData.value)
    });

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error || 'Registration failed');
    }

    success.value = 'Registration successful! You can now login.';
    formData.value = { naam: '', email: '', wachtwoord: '', adres: '' }; // Clear form
  } catch (err) {
    error.value = err.message;
  }
};
</script>

<template>
  <div class="register-container">
    <h2>Registreren</h2>
    
    <form @submit="handleSubmit" class="register-form">
      <div class="form-group">
        <label for="naam">Naam:</label>
        <input 
          type="text" 
          id="naam"
          v-model="formData.naam"
          required
          placeholder="Voer uw naam in"
        >
      </div>

      <div class="form-group">
        <label for="email">Email:</label>
        <input 
          type="email" 
          id="email"
          v-model="formData.email"
          required
          placeholder="Voer uw email in"
        >
      </div>

      <div class="form-group">
        <label for="wachtwoord">Wachtwoord:</label>
        <input 
          type="password" 
          id="wachtwoord"
          v-model="formData.wachtwoord"
          required
          placeholder="Voer uw wachtwoord in"
          minlength="6"
        >
      </div>

      <div class="form-group">
        <label for="adres">Adres:</label>
        <textarea 
          id="adres"
          v-model="formData.adres"
          placeholder="Voer uw adres in"
        ></textarea>
      </div>

      <div v-if="error" class="error-message">
        {{ error }}
      </div>

      <div v-if="success" class="success-message">
        {{ success }}
      </div>

      <button type="submit" class="register-button">
        Registreren
      </button>
    </form>
  </div>
</template>

<style scoped>
.register-container {
  max-width: 500px;
  margin: 2rem auto;
  padding: 2rem;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.register-form {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

label {
  font-weight: 600;
  color: #333;
}

input, textarea {
  padding: 0.75rem;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 1rem;
}

textarea {
  min-height: 100px;
  resize: vertical;
}

.register-button {
  background-color: #4CAF50;
  color: white;
  padding: 1rem;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.2s;
}

.register-button:hover {
  background-color: #45a049;
}

.error-message {
  color: #dc3545;
  padding: 0.5rem;
  background-color: #fde8e8;
  border-radius: 4px;
}

.success-message {
  color: #28a745;
  padding: 0.5rem;
  background-color: #e8f5e9;
  border-radius: 4px;
}
</style>]]>
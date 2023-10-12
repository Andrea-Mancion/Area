<template>
  <div>
    <br />
    <p class="tittle">Welcome to the action list view !</p>
    <p class="tittle" >{{ this.ServiceName }}</p>
    <b-card-group deck class="card-container">
      <div v-for="action in this.getActions" :key="action">
        <b-card
          bg-variant="info"
          :header="action.Name"
          class="service-card text-center"
        >
          <b-button variant="info" class="full-width-button">Select</b-button>
        </b-card>
      </div>
    </b-card-group>
  </div>
</template>

<script>
export default {
  data() {
    return {
      ServiceName: '',
    };
  },
  mounted() {
    this.ServiceName = this.$route.params.name;
  },
  computed: {
    getActions() {
        const service = this.ServiceName;
        return this.$store.state.Services[service].Actions;
    },
  }
};
</script>

<style scoped>
.tittle {
  display: flex;
  justify-content: center; /* Centrer verticalement le contenu */
  height: 10vh; /* Ajuster la hauteur pour centrer le contenu dans la fenêtre */
}

.card-container {
  display: flex; /* Utilisation de flexbox pour afficher les cards sur la même ligne */
  justify-content: space-around; /* Centrer horizontalement les cards */
  flex-wrap: wrap; /* Passer à la ligne suivante si l'espace est insuffisant */
}

.service-card {
  width: 400px; /* Largeur fixe de 300px pour les cards carrées */
  height: 100px; /* Hauteur fixe de 200px pour les cards carrées */
  object-fit: cover; /* Remplissage complet du carré sans déformation */
}

.full-width-button {
  width: 100%;
}
</style>

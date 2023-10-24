<template>
  <div>
    <p class="tittle">Welcome to the Reaction Service list view!</p>
    <div class="image-container">
      <div v-for="service in this.$store.state.Services" :key="service">
        <img
          :src="service.ImageLink"
          class="service-image"
          @click="RedirectToReactionList(service)"
        />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "actionServiceList",
  methods: {
    RedirectToReactionList(service) {
      if (this.$store.state.Services[service.Name].AuthentificationTokens == "") {
        this.$store.state.Services[service.Name].IsLog = true;
        this.$router.push({ name: "oauth-login", params: { name: service.Name } });
      } else {
        this.$store.commit("setServiceReactionSelected", service.Name);
        this.$router.push({ name: "reaction-list", params: { name: service.Name } });
      }
    },
  },
};
</script>

<style scoped>
.tittle {
  display: flex;
  justify-content: center; /* Centrer verticalement le contenu */
  height: 10vh; /* Ajuster la hauteur pour centrer le contenu dans la fenêtre */
}

.image-container {
  display: flex; /* Utilisation de flexbox pour afficher les images sur la même ligne */
  justify-content: space-around; /* Centrer horizontalement les images */
  flex-wrap: wrap; /* Passer à la ligne suivante si l'espace est insuffisant */
}

.service-image {
  width: 300px; /* Largeur fixe de 300px pour les images carrées */
  height: 300px; /* Hauteur fixe de 200px pour les images carrées */
  object-fit: cover; /* Remplissage complet du carré sans déformation */
}
</style>

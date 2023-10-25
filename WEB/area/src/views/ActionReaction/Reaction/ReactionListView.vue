<template>
  <div>
    <br />
    <p class="tittle">Welcome to the Reaction list view !</p>
    <p class="tittle">{{ this.ServiceName }}</p>
    <b-card-group deck class="card-container">
      <div v-for="reaction in this.getReactions" :key="reaction">
        <b-card bg-variant="info" :header="reaction.Name" class="service-card text-center">
          <b-button
            variant="info"
            class="full-width-button"
            @click="RedirectToReactionParams(reaction)"
            >Select</b-button
          >
        </b-card>
      </div>
    </b-card-group>
  </div>
</template>

<script>
export default {
  data() {
    return {
      ServiceName: "",
    };
  },
  mounted() {
    this.ServiceName = this.$route.params.name;
  },
  computed: {
    getReactions() {
      const service = this.ServiceName;
      return this.$store.state.Services[service].Reactions;
    },
  },
  methods: {
    RedirectToReactionParams(reaction) {
      if (reaction.IsParams == true) {
        this.$store.commit("setSavedReaction", reaction.Name);
        this.$router.push({
          name: "reaction-params",
          params: { reaction: reaction },
        });
      } else {
        this.$store.commit("setSavedReactionParams", '');
        this.$store.commit("setSavedReaction", reaction.Name);
        this.$router.push("/action-reaction");
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

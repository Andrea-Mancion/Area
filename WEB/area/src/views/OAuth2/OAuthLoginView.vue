<template>
  <div>
    <div class="tittle">
      <b-button @click="login" variant="info"
        >Connexion à {{ this.serviceName }}</b-button
      >
    </div>
    <b-alert v-model="ShowLoginAlert" variant="danger" dismissible>
      Service not yet implemented.
    </b-alert>
  </div>
</template>

<script>
export default {
  data() {
    return {
      serviceName: "",
      serviceNotImplemented: false,
    };
  },
  mounted() {
    this.serviceName = this.$route.params.name;
  },
  methods: {
    login() {
      if (this.serviceName == "Spotify") {
        // URL d'autorisation OAuth2
        const authUrl = "https://accounts.spotify.com/authorize";
        // Votre client_id OAuth2
        const clientId = "fdbe5e5dbe5c42b680efb3ab1d3574af";
        // URL de redirection après l'autorisation
        const redirectUri = "http://localhost:8080/oauth-callback";
        // Les scopes que vous souhaitez demander (séparés par des espaces)
        const scopes =
          "user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public";
        // Créez l'URL de redirection OAuth2 en incluant le scope
        const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(
          scopes
        )}`;
        // Redirigez l'utilisateur vers l'URL d'autorisation OAuth2
        window.location.href = oauthRedirectUrl;
      } else {
        this.serviceNotImplemented = true;
      }
    },
  },
};
</script>

<style scoped>
.tittle {
  display: flex;
  justify-content: center;
  height: 5vh;
  margin-top: 100px;
}
</style>

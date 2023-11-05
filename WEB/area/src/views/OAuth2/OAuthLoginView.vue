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
        this.$store.state.TryToLogTo = this.serviceName;
        // URL d'autorisation OAuth2
        const authUrl = "https://accounts.spotify.com/authorize";
        // Votre client_id OAuth2
        const clientId = process.env.SPOTIFY_CLIENT_ID;
        // URL de redirection après l'autorisation
        const redirectUri = `http://localhost:8081/oauth-callback?service=${this.serviceName}`;
        // Les scopes que vous souhaitez demander (séparés par des espaces)
        const scopes =
          "user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public";
        // Créez l'URL de redirection OAuth2 en incluant le scope
        const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(
          scopes
        )}`;
        // Redirigez l'utilisateur vers l'URL d'autorisation OAuth2
        window.location.href = oauthRedirectUrl;
      }
      if (this.serviceName == "Discord") {
        this.$store.state.TryToLogTo = this.serviceName;
        const authUrl = "https://discord.com/api/oauth2/authorize";
        const clientId = process.env.DISCORD_CLIENT_ID;
        const redirectUri = `http://localhost:8081/oauth-callback?service=${this.serviceName}`;
        const scopes = "identify guilds";
        const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(
          scopes
        )}`;
        window.location.href = oauthRedirectUrl;
      }
      if (this.serviceName == "Twitch") {
        this.$store.state.TryToLogTo = this.serviceName;
        const authUrl = "https://id.twitch.tv/oauth2/authorize";
        const clientId = process.env.TWITCH_CLIENT_ID;
        const redirectUri = `http://localhost:8081/oauth-callback?service=${this.serviceName}`;
        const scopes = "";
        const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(
          scopes
        )}`;
        window.location.href = oauthRedirectUrl;
      }
      if (this.serviceName == "Yahoo") {
        this.$store.state.TryToLogTo = this.serviceName;
        const authUrl = "https://api.login.yahoo.com/oauth2/request_auth";
        const clientId = process.env.YHAOO_CLIENT_ID;
        const redirectUri = `http://localhost:8081/oauth-callback?service=${this.serviceName}`;
        const scopes = "";
        const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(
          scopes
        )}`;
        window.location.href = oauthRedirectUrl;
      }
      if (this.serviceName == "GitHub") {
        this.$store.state.TryToLogTo = this.serviceName;
        const authUrl = "https://github.com/login/oauth/authorize";
        const clientId = process.env.GITHUB_CLIENT_ID;
        const redirectUri = `http://localhost:8081/oauth-callback?service=${this.serviceName}`;
        const scopes = "";
        const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(
          scopes
        )}`;
        window.location.href = oauthRedirectUrl;
      }
      if (this.serviceName == "Deezer") {
        this.$store.state.TryToLogTo = this.serviceName;
        const authUrl = "https://connect.deezer.com/oauth/auth.php";
        const clientId = process.env.DEEZER_CLIENT_ID;
        const redirectUri = `http://localhost:8081/oauth-callback?service=${this.serviceName}`;
        const scopes = "";
        const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(
          scopes
        )}`;
        window.location.href = oauthRedirectUrl;
      }
      if (this.serviceName == "Google") {
        this.$store.state.TryToLogTo = this.serviceName;
        const authUrl = "https://accounts.google.com/o/oauth2/auth";
        const clientId = process.env.GOOGLE_CLIENT_ID;
        const redirectUri = `http://localhost:8081/oauth-callback?service=${this.serviceName}`;
        const scopes = "";
        const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(
          scopes
        )}`;
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

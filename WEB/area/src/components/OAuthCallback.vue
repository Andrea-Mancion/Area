<template>
  <div>
    <h1>Redirection après l'autorisation OAuth2...</h1>
  </div>
</template>

<script>
import axios from "axios";
export default {
  mounted() {
    // Récupérez le code d'autorisation de l'URL
    const code = this.$route.query.code;
    // Utilisez Axios pour échanger le code d'autorisation contre un jeton d'accès
    axios
      .post("https://accounts.spotify.com/api/token", null, {
        params: {
          code: code,
          client_id: "fdbe5e5dbe5c42b680efb3ab1d3574af",
          client_secret: "8f5b9b576da44c32bf53b1fa53786b8f",
          redirect_uri: "http://localhost:8080/oauth-callback",
          grant_type: "authorization_code",
        },
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      })
      .then((response) => {
        const accessToken = response.data.access_token;
        this.$store.commit("setSpotifyToken", accessToken);
        this.$router.push("/action-reaction");
      })
      .catch((error) => {
        console.error("Erreur lors de l'échange du code d'autorisation : ", error);
      });
  },
};
</script>

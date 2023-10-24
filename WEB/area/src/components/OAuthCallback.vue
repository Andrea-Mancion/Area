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
          scopes:"user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public playlist-modify-private playlist-read-private playlist-read-collaborative user-read-currently-playing user-read-recently-played user-top-read user-follow-read user-follow-modify streaming app-remote-control user-read-playback-position user-read-playback-state user-modify-p"
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

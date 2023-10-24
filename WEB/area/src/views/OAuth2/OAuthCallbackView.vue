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
    if (this.$route.query.service == "Spotify") {
      axios
        .post("https://accounts.spotify.com/api/token", null, {
          params: {
            code: code,
            client_id: "fdbe5e5dbe5c42b680efb3ab1d3574af",
            client_secret: "8f5b9b576da44c32bf53b1fa53786b8f",
            redirect_uri: `http://localhost:8080/oauth-callback?service=Spotify`,
            grant_type: "authorization_code",
            scopes:
              "user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public",
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
    }
    if (this.$route.query.service == "Discord") {
      const params = new URLSearchParams();
      params.append("client_id", "1156974898644795393");
      params.append("client_secret", "X8IKJ1RTnh-QUyfFTTh6N5d1lZoUuSGD");
      params.append(
        "redirect_uri",
        "http://localhost:8080/oauth-callback?service=Discord"
      );
      params.append("grant_type", "authorization_code");
      params.append("code", code);
      params.append("scope", "identify guilds");

      axios
        .post("https://discord.com/api/v9/oauth2/token", params, {
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((response) => {
          const accessToken = response.data.access_token;
          this.$store.commit("setDiscordToken", accessToken);
          this.$router.push("/action-reaction");
        })
        .catch((error) => {
          console.error("Erreur lors de l'échange du code d'autorisation : ", error);
        });
    }
  },
};
</script>

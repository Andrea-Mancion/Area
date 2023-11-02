<template>
  <div>
    <h1>Redirection après l'autorisation OAuth2...</h1>
  </div>
</template>

<script>
import axios from "axios";
import Cookies from "js-cookie";
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
            client_secret: process.env.SPOTIFY_CLIENT_SECRET,
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
          Cookies.set("Spotify_access_token", accessToken, { expires: 7, secure: true });
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
      params.append("client_secret", process.env.DISCORD_CLIENT_SECRET);
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
          Cookies.set("Discord_access_token", accessToken, { expires: 7, secure: true });
          this.$store.commit("setDiscordToken", accessToken);
          this.$router.push("/action-reaction");
        })
        .catch((error) => {
          console.error("Erreur lors de l'échange du code d'autorisation : ", error);
        });
    }
    if (this.$route.query.service === "GitHub") {
      // Gestion de l'authentification pour GitHub
      const clientId = process.env.GITHUB_CLIENT_ID;
      const clientSecret = process.env.GITHUB_CLIENT_SECRET;
      const redirectUri = `http://localhost:8080/oauth-callback?service=GitHub`;

      axios
        .post("https://github.com/login/oauth/access_token", null, {
          params: {
            client_id: clientId,
            client_secret: clientSecret,
            code: code,
            redirect_uri: redirectUri,
          },
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((response) => {
          const accessToken = response.data.access_token;
          Cookies.set("GitHub_access_token", accessToken, { expires: 7, secure: true });
          this.$store.commit("setGitHubToken", accessToken);
          this.$router.push("/action-reaction");
        })
        .catch((error) => {
          console.error("Erreur lors de l'échange du code d'autorisation : ", error);
        });
    } else if (this.$route.query.service === "Yahoo") {
      // Gestion de l'authentification pour Yahoo
      const clientId = process.env.YAHOO_CLIENT_ID;
      const clientSecret = process.env.YAHOO_CLIENT_SECRET;
      const redirectUri = `http://localhost:8080/oauth-callback?service=Yahoo`;

      axios
        .post("https://api.login.yahoo.com/oauth2/get_token", null, {
          params: {
            client_id: clientId,
            client_secret: clientSecret,
            code: code,
            redirect_uri: redirectUri,
            grant_type: "authorization_code",
          },
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((response) => {
          const accessToken = response.data.access_token;
          Cookies.set("Yahoo_access_token", accessToken, { expires: 7, secure: true });
          this.$store.commit("setYahooToken", accessToken);
          this.$router.push("/action-reaction");
        })
        .catch((error) => {
          console.error("Erreur lors de l'échange du code d'autorisation : ", error);
        });
    }
    if (this.$route.query.service === "Deezer") {
      // Gestion de l'authentification pour Deezer
      const clientId = process.env.DEEZER_CLIENT_ID;
      const clientSecret = process.env.DEEZER_CLIENT_SECRET;
      const redirectUri = `http://localhost:8080/oauth-callback?service=Deezer`;
      axios
        .post("https://connect.deezer.com/oauth/access_token.php", null, {
          params: {
            app_id: clientId,
            secret: clientSecret,
            code: code,
            redirect_uri: redirectUri,
          },
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((response) => {
          // Parse response to get access token
          const params = new URLSearchParams(response.data);
          const accessToken = params.get("access_token");
          Cookies.set("Deezer_access_token", accessToken, { expires: 7, secure: true });
          this.$store.commit("setDeezerToken", accessToken);
          this.$router.push("/action-reaction");
        })
        .catch((error) => {
          console.error("Erreur lors de l'échange du code d'autorisation : ", error);
        });
    } else if (this.$route.query.service === "Google") {
      // Gestion de l'authentification pour Google
      const clientId = process.env.GOOGLE_CLIENT_ID;
      const clientSecret = process.env.GOOGLE_CLIENT_SECRET;
      const redirectUri = `http://localhost:8080/oauth-callback?service=Google`;

      axios
        .post("https://accounts.google.com/o/oauth2/token", null, {
          params: {
            client_id: clientId,
            client_secret: clientSecret,
            code: code,
            redirect_uri: redirectUri,
            grant_type: "authorization_code",
          },
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((response) => {
          const accessToken = response.data.access_token;
          Cookies.set("Google_access_token", accessToken, { expires: 7, secure: true });
          this.$store.commit("setGoogleToken", accessToken);
          this.$router.push("/action-reaction");
        })
        .catch((error) => {
          console.error("Erreur lors de l'échange du code d'autorisation : ", error);
        });
    }
    if (this.$route.query.service === "Twitch") {
      // Gestion de l'authentification pour Twitch
      const clientId = process.env.TWITCH_CLIENT_ID;
      const clientSecret = process.env.TWITCH_CLIENT_SECRET;
      const redirectUri = `http://localhost:8080/oauth-callback?service=Twitch`;

      axios
        .post("https://id.twitch.tv/oauth2/token", null, {
          params: {
            client_id: clientId,
            client_secret: clientSecret,
            code: code,
            redirect_uri: redirectUri,
            grant_type: "authorization_code",
          },
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        })
        .then((response) => {
          const accessToken = response.data.access_token;
          Cookies.set("Twitch_access_token", accessToken, { expires: 7, secure: true });
          this.$store.commit("setTwitchToken", accessToken);
          this.$router.push("/action-reaction");
        })
        .catch((error) => {
          console.error("Erreur lors de l'échange du code d'autorisation : ", error);
        });
    }
  },
};
</script>

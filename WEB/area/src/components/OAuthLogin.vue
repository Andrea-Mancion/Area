<template>
  <div>
    <button @click="login">Se connecter avec OAuth2</button>
  </div>
</template>

<script>
export default {
  methods: {
    login() {
      // URL d'autorisation OAuth2
      const authUrl = "https://accounts.spotify.com/authorize";
      // Votre client_id OAuth2
      const clientId = "fdbe5e5dbe5c42b680efb3ab1d3574af";
      // URL de redirection après l'autorisation
      const redirectUri = "http://localhost:8080/oauth-callback";
      // Les scopes que vous souhaitez demander (séparés par des espaces)
      const scopes =
        "user-read-private user-read-email user-read-playback-state user-modify-playback-state user-library-read user-modify-playback-state playlist-modify-public playlist-modify-private playlist-read-private playlist-read-collaborative user-read-currently-playing user-read-recently-played user-top-read user-follow-read user-follow-modify streaming app-remote-control ";

      // Créez l'URL de redirection OAuth2 en incluant le scope
      const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code&scope=${encodeURIComponent(scopes)}`;

      // Redirigez l'utilisateur vers l'URL d'autorisation OAuth2
      window.location.href = oauthRedirectUrl;
    },
  },
};
</script>

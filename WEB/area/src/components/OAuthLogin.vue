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
            const authUrl = 'https://accounts.spotify.com/authorize';
            // Votre client_id OAuth2
            const clientId = 'fdbe5e5dbe5c42b680efb3ab1d3574af';
            // URL de redirection après l'autorisation
            const redirectUri = 'http://localhost:8080/oauth-callback';
            // Créez l'URL de redirection OAuth2
            const oauthRedirectUrl = `${authUrl}?client_id=${clientId}&redirect_uri=${redirectUri}&response_type=code`;

            // Redirigez l'utilisateur vers l'URL d'autorisation OAuth2
            window.location.href = oauthRedirectUrl;
        }
    }
};
</script>
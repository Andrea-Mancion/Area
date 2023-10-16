<template>
  <div>
    <img :src="ImageUrl" class="centerImage" @click="ToggleVisibility"/>
    <ReactionListComp v-if="IsClicked"></ReactionListComp>
  </div>
</template>

<script>
import axios from "axios";
import ReactionListComp from "./ReactionsList.vue"

export default {
  name: "ReactionApplicationComp",
  props: ["ImageUrl"],
  components: {
    ReactionListComp,
  },
  data () {
    return {
      IsClicked: false,
    }
  },
  methods: {
    ToggleVisibility() {
      if (this.$store.state.authentificationTokens.Spotify == '')
        this.$router.push('/oauth-login');
      this.IsClicked = !this.IsClicked;
    },
    CallServer() {
      axios
        .post("http://localhost:3000/create_action_saved_track")
        .then((response) => {
          if (response.status === 200) console.log(response.data);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    // loginToSpotify() {
    //   const oauth2 = new OAuth2Client({
    //     clientId: "fdbe5e5dbe5c42b680efb3ab1d3574af",
    //     redirectUri: "http://localhost:3000/callback",
    //     authorizationUri: "https://accounts.spotify.com/authorize",
    //     tokenUri: "https://accounts.spotify.com/api/token",
    //   });
    //   oauth2.authorize();
    // },
  },
};
</script>

<style scoped>
.home {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
}

.centerImage {
  text-align: center;
  width: 15%;
}
</style>

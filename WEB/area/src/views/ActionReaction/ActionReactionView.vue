<template>
  <div class="ActionReaction">
    <div class="centered-containe">
      <p>Welcome to the action/reaction view !</p>
      <div v-if="this.$store.getters.getServiceActionSelected != ''">
        <p>
          Service Action selected is {{ this.$store.getters.getServiceActionSelected }}
        </p>
      </div>
      <div v-if="this.$store.getters.getServiceReactionSelected != ''">
        <p>
          Service Reaction selected is
          {{ this.$store.getters.getServiceReactionSelected }}
        </p>
      </div>
      <div v-if="this.$store.getters.getSavedAction != ''">
        <p>Action selected: {{ this.$store.getters.getSavedAction }}</p>
        <div v-for="(value, key) in this.$store.getters.getSavedActionParams" :key="key">
          <p>{{ key }} : {{ value }}</p>
        </div>
      </div>
      <b-button variant="info" @click="RedirectActionList">Add an Action</b-button>
      <br />
      <br />
      <div v-if="this.$store.getters.getSavedReaction != ''">
        <p>Reaction selected: {{ this.$store.getters.getSavedReaction }}</p>
        <div
          v-for="(value, key) in this.$store.getters.getSavedReactionParams"
          :key="key"
        >
          <p>{{ key }} : {{ value }}</p>
        </div>
      </div>
      <b-button variant="info" @click="RedirectReactionList">Add an Reaction</b-button>
      <br />
      <br />
      <b-button variant="info" @click="CreateActionReaction">Create</b-button>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import Cookies from 'js-cookie';
export default {
  data() {
    return {
      createActRecData: {
        action_service_Name: "",
        reaction_service_Name: "",
        action_Name: "",
        reaction_Name: "",
        action_Param: {},
        reaction_Param: {},
        action_access_token: "",
        reaction_access_token: "",
        user_id: "",
      },
    };
  },
  mounted() {
    if (Cookies.get('Spotify_access_token'))
      this.$store.commit("setSpotifyToken", Cookies.get('Spotify_access_token'));
    if (Cookies.get('Discord_access_token'))
      this.$store.commit("setDiscordToken", Cookies.get('Discord_access_token'));
  },
  methods: {
    RedirectActionList() {
      this.$router.push("/action-service-list");
    },
    RedirectReactionList() {
      this.$router.push("/reaction-service-list");
    },
    CreateActionReaction() {
      this.setActionReactionData();
      axios
        .post("http://localhost:3000/create_action", this.createActRecData)
        .then((response) => {
          if (response.status === 200) console.log("ça marche!");
          if (response.status === 500) console.log("ça marche pas (arg invalide)!");
        })
        .catch((error) => {
          console.log(error);
        });
    },
    setActionReactionData() {
        this.createActRecData.action_service_Name = this.$store.getters.getServiceActionSelected;
        this.createActRecData.reaction_service_Name = this.$store.getters.getServiceReactionSelected;
        this.createActRecData.action_Name = this.$store.getters.getSavedAction;
        this.createActRecData.reaction_Name = this.$store.getters.getSavedReaction;
        this.createActRecData.action_Param = this.$store.getters.getSavedActionParams;
        this.createActRecData.reaction_Param = this.$store.getters.getSavedReactionParams;
        this.createActRecData.action_access_token = this.$store.state.Services[this.$store.getters.getServiceActionSelected].AuthentificationTokens;
        this.createActRecData.reaction_access_token = this.$store.state.Services[this.$store.getters.getServiceReactionSelected].AuthentificationTokens;
        this.createActRecData.user_id = "test";
    },
  },
};
</script>

<style scoped>
.ActionReaction {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 50vh;
}

.centered-container {
  max-width: 1000px;
  text-align: center;
}
</style>

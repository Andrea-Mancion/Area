<template>
  <div class="ActionReaction">
    <div class="centered-containe">
      <p>Welcome to the action/reaction view !</p>
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
        <!-- <p> name : {{ this.$store.state.ReactionsList.Spotify.createPlaylistData.name }}</p>
                <p> description : {{ this.$store.state.ReactionsList.Spotify.createPlaylistData.description }}</p>
                <p> is public : {{ this.$store.state.ReactionsList.Spotify.createPlaylistData.is_public }}</p> -->
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
export default {
  data() {
    return {
      createActRecData: {
        service_Name: "",
        action_Name: "",
        reaction_Name: "",
        action_Param: {},
        reaction_Param: {},
        access_token: "",
        user_id: "",
      },
    };
  },
  methods: {
    RedirectActionList() {
      this.$router.push("/action-service-list");
    },
    RedirectReactionList() {
      this.$router.push("/reaction-service-list");
    },
    CreateActionReaction() {
      // this.setActionReactionData();
      axios
        .post("http://localhost:3000/create_action", this.createActRecData)
        .then((response) => {
          if (response.status === 200) console.log("ça marche!");
          if (response.status === 500) console.log("ça marche pas (arg invalide)!");
        })
        .catch((error) => {
          console.log(error);
          console.log("ça marche pas (arg invalide)!");
        });
    },
    // setActionReactionData() {
    //     this.createActRecData.service_Name = 'spotify';
    //     this.createActRecData.action_Name = this.$store.getters.getSavedAction;
    //     this.createActRecData.reaction_Name = this.$store.getters.getSavedReaction;
    //     this.createActRecData.action_Param = this.$store.state.ActionsList.Spotify.check_new_episode;
    //     this.createActRecData.reaction_Param = this.$store.state.ReactionsList.Spotify.createPlaylistData;
    //     this.createActRecData.access_token = this.$store.state.authentificationTokens.Spotify;
    //     this.createActRecData.user_id = "toto";
    // },
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

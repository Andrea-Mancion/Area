<template>
  <div>
    <p class="tittle">Welcome to the Reaction params view!</p>
    <p class="tittle">Please Enter Params</p>
    <b-form>
      <b-form-group class="tittle">
        <div v-for="(value, key) in this.reaction.Params" :key="key">
          <p> {{ key }} :</p>
          <input
            v-model="params[key]"
            required
          />
        </div>
        <div v-if="this.reaction.IsBoolParams">
          <div v-for="(value, key) in this.reaction.BoolParams" :key="key">
            <p>{{ key }} :</p>
            <b-form-checkbox v-model="boolParams[key]" required />
          </div>
        </div>
        <br/>
        <b-button variant="info" @click="SubmitData">Submit</b-button>
      </b-form-group>
    </b-form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      reaction: {},
      params: {},
      boolParams: {},
    };
  },
  mounted() {
    this.reaction = this.$route.params.reaction;
    this.params = this.reaction.Params;
    if (this.reaction.IsBoolParams == true)
      this.BoolParams = this.reaction.BoolParams;

  },
  methods: {
    SubmitData() {
      if (this.reaction.IsBoolParams == true)
        this.params = {...this.params, ...this.boolParams}
      console.log(this.params);
      this.$store.commit("setSavedReactionParams", this.params);
      this.$router.push("/action-reaction");
    },
  },
};
</script>

<style scoped>
.tittle {
  display: flex;
  justify-content: center;
  height: 10vh;
}
</style>

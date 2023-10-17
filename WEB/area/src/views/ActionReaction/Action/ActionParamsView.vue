<template>
  <div>
    <p class="tittle">Welcome to the action params view!</p>
    <p class="tittle">Please Enter Params</p>
    <b-form>
      <b-form-group class="tittle">
        <div v-for="(value, key) in this.action.Params" :key="key">
          <p> {{ key }} :</p>
          <input
            v-model="params[key]"
            required
          />
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
      action: {},
      params: {},
    };
  },
  mounted() {
    this.action = this.$route.params.action;
    this.params = this.action.Params;
  },
  methods: {
    SubmitData() {
      console.log(this.params);
      this.$store.commit("setSavedActionParams", this.params);
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

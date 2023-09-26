<template>
  <div class="hello">
    <b-navbar toggleable="lg" type="dark" variant="info" class="navbar-expand-lg">
      <b-navbar-brand href="#" @click="redirectHome">Area</b-navbar-brand>
      <div class="mr-auto">
        <router-link to="/login">Login</router-link>
        <router-link to="/action-reaction">Action/Reaction</router-link>
        <router-link to="/service">Service</router-link>
      </div>
    </b-navbar>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  },

  methods: {
    redirectHome () {
      this.$router.push('/');
    }
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>

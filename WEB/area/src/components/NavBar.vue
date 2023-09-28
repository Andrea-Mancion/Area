<template>
  <div class="hello">
    <b-navbar toggleable="lg" type="dark" variant="info" class="navbar-expand-lg">
      <b-navbar-brand href="#" @click="redirectHome" class="AreaMargin">Area</b-navbar-brand>
      <b-nav>
        <b-nav-item to="/action-reaction">Action/Reaction</b-nav-item>
        <b-nav-item to="/service">Service</b-nav-item>
        <b-nav-item to="/login" class="ml-auto">Login</b-nav-item>
      </b-nav>
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
<style scoped>
.b-nav-item:not(:last-child) {
  margin-right: 20px; /* Ajustez la valeur selon votre préférence */
}
.AreaMargin {
  margin-left: 20px; /* Ajustez la valeur selon votre préférence */
}
</style>

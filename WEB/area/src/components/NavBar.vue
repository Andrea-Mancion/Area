<template>
  <div class="hello">
    <b-navbar toggleable="lg" type="dark" variant="info" class="navbar-expand-lg">
      <b-navbar-brand href="#" @click="redirectHome" class="AreaMargin">Area</b-navbar-brand>
      <b-nav>
        <b-nav-item to="/action-reaction">Action/Reaction</b-nav-item>
        <b-nav-item to="/login" class="ml-auto">Login</b-nav-item>
      </b-nav>
    </b-navbar>
  </div>
</template>

<script>
export default {
  name: 'NavBar',
  props: {
    msg: String
  },

  methods: {
    redirectHome() {
      this.$router.push('/');
    }
  },
}
</script>

<style scoped>
.b-nav-item:not(:last-child) {
  margin-right: 20px;
}

.AreaMargin {
  margin-left: 20px;
}
</style>

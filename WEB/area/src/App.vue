<template>
  <div id="app">
    <nav>
      <NavBar/>
      <!-- <router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link> -->
    </nav>
    <router-view/>
  </div>
</template>

<script>
// @ is an alias to /src
import NavBar from './components/NavBar.vue'

export default {
  name: 'HomeView',
  components: {
    NavBar
  }
}
</script>


<style>
</style>

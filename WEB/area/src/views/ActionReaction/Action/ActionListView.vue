<template>
  <div>
    <p class="tittle">Welcome to the action list view !</p>
    <p> {{$route.params}}</p>
  </div>
</template>

<style scoped>
.tittle {
  display: flex;
  justify-content: center; /* Centrer verticalement le contenu */
  height: 10vh; /* Ajuster la hauteur pour centrer le contenu dans la fenêtre */
}
</style>

<template>
  <div>
    <button @click="downloadFile">Télécharger le fichier</button>
  </div>
</template>

<script>
export default {
  methods: {
    downloadFile() {
      // Remplacez l'URL par le chemin du fichier que vous souhaitez télécharger
      const fileUrl = '/app-release.apk';

      // Créez un élément <a> dynamique pour déclencher le téléchargement
      const a = document.createElement('a');
      a.href = fileUrl;
      a.download = 'app-release.apk';
      a.style.display = 'none';

      // Ajoutez l'élément <a> au DOM et simulez un clic pour déclencher le téléchargement
      document.body.appendChild(a);
      a.click();

      // Supprimez l'élément <a> du DOM après le téléchargement
      document.body.removeChild(a);
    },
  },
};
</script>

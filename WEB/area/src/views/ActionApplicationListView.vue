<template>
    <div>
        <p>Welcome to the Action Application list view !</p>
        <ActionApplicationComp ImageUrl="https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png"></ActionApplicationComp>
    </div>
</template>

<script>
import ActionApplicationComp from "../components/ActionApplication.vue"

export default {
    name: "actionApplicationList",
    components: {
        ActionApplicationComp,
    }
}

</script>
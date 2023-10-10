<template>
    <div>
        <p>Welcome to the Reaction list view !</p>
        <ReactionApplicationComp ImageUrl="https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png"></ReactionApplicationComp>
    </div>
</template>

<script>
import ReactionApplicationComp from "../components/ReactionApplication.vue"

export default {
    name: "reactionApplicationList",
    components: {
        ReactionApplicationComp,
    }
}

</script>
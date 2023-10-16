<template>
    <div>
        <div v-for="reaction in this.$store.state.ReactionsList.Spotify.reactions" :key="reaction">
            <b-button @click="show">{{ reaction }}</b-button>
            <div v-if="isShow">
                <br />
                <b-form-input placeholder="Name" v-model="Name"></b-form-input>
                <b-form-input placeholder="Description" v-model="Description"></b-form-input>
                <p>Is public : {{  IsPublic  }}</p>
                <b-form-checkbox v-model="IsPublic"></b-form-checkbox>
                <b-button @click="addAction(reaction)">confirm</b-button>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'reactionsListComp',
    data() {
        return {
            isShow: false,
            Name: '',
            Description: '',
            IsPublic: false,
        }
    },
    methods: {
        show() {
            this.isShow = !this.isShow;
        },
        addAction(reaction) {
            this.$store.state.ReactionsList.Spotify.createPlaylistData.name = this.Name;
            this.$store.state.ReactionsList.Spotify.createPlaylistData.description = this.Description;
            this.$store.state.ReactionsList.Spotify.createPlaylistData.is_public = this.IsPublic;
            this.$store.commit("setSavedReaction", reaction);
            this.$router.push('/action-reaction');
        }
    }
}
</script>

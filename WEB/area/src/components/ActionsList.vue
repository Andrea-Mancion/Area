<template>
    <div>
        <div v-for="action in this.$store.state.ActionsList.Spotify.actions" :key="action">
            <b-button @click="show">{{ action }}</b-button>
        </div>
        <div v-if="isShow">
                <br />
                <b-form-input placeholder="ShowId" v-model="ShowId"></b-form-input>
                <b-button @click="addAction(action)">confirm</b-button>
            </div>
    </div>
</template>

<script>
export default {
    name: 'actionsListComp',
    data() {
        return {
            isShow: false,
            ShowId: '',
        }
    },
    methods: {
        show() {
            this.isShow = !this.isShow;
        },
        addAction (action) {
            this.$store.state.ActionsList.Spotify.check_new_episode.showId = this.ShowId;
            this.$store.commit("setSavedAction", action);
            this.$router.push('/action-reaction')
        }
    }
}
</script>

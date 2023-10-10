import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    authentificationTokens: {
      Spotify: '',
    },
    Action: '',
    Reaction: '',
    ActionsList: {
      Spotify: {
        actions: ['check_new_episode', 'check_new_saved_track',],
        check_new_episode: {
          showId: '',
        },
      },
    },
    ReactionsList: {
      Spotify: {
        reactions: ['createPlaylist'],
        createPlaylistData : {
          name: '',
          description: '',
          is_public: false,
        },
      }
    }
  },
  getters: {
    getSpotifyToken(state) {
      return state.authentificationTokens.spotify;
    },
    getSavedAction(state) {
      return state.Action;
    },
    getSavedReaction(state) {
      return state.Reaction;
    }
  },
  mutations: {
    setSpotifyToken(state, token) {
      state.authentificationTokens.spotify = token;
    },
    setSavedAction(state, action) {
      state.Action = action;
    },
    setSavedReaction(state, reaction) {
      state.Reaction = reaction;
    },
  },
  actions: {
  },
  modules: {
  }
})

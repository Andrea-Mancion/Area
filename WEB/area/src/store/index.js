import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    Action: '',
    ActionParams: {},
    Reaction: '',
    ReactionParams: {},
    Services: {
      Spotify: {
        Name: 'Spotify',
        ImageLink: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png',
        AuthentificationTokens: '',
        Actions: {
          Check_new_episode: {
            Name: 'check_new_episode',
            Params: {

            },
          },
        },
        Reactions: {
          CreatePlaylist: {
            Name: 'CreatePlaylist',
            Params: {

            },
          },
        },
      },
      Discord: {
        Name: 'Discord',
        ImageLink: 'https://m1.quebecormedia.com/emp/emp/discord31fa7044-2286-4838-be61-a8fb7db67d6e_ORIGINAL.jpg?impolicy=crop-resize&x=0&y=0&w=0&h=0&width=925',
        AuthentificationTokens: '',
        Actions: {
        },
        Reactions: {
        },
      },
      Gmail: {
        Name: 'Gmail',
        ImageLink: 'https://f.hellowork.com/blogdumoderateur/2019/03/gmail-logo-1200x758.jpg',
        AuthentificationTokens: '',
        Actions: {
        },
        Reactions: {
        },
      },
    },


    authentificationTokens: {
      Spotify: '',
    },
    ActionsList: {
      Spotify: {
        Actions: ['check_new_episode', 'check_new_saved_track',],
        ActionParams: {},
      },
    },
    ReactionsList: {
      Spotify: {
        reactions: ['createPlaylist'],
        ActionParams: {},
      }
    }
  },
  getters: {
    getSpotifyToken(state) {
      return state.authentificationTokens.Spotify;
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
      state.authentificationTokens.Spotify = token;
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

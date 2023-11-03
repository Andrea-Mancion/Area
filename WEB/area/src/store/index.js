import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    Connected: false,
    TryToLogTo: '',
    Action: '',
    ActionParams: {},
    Reaction: '',
    ReactionParams: {},
    ServiceActionSelected: '',
    ServiceReactionSelected: '',
    Services: {
      Spotify: {
        Name: 'Spotify',
        ImageLink: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
          CheckNewEpisode: {
            Name: 'check_new_episode',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              showId: '',
            },
          },
          CheckNewSavedTrack: {
            Name: 'check_new_saved_track',
            IsParams: false,
            IsBoolParams: false,
            Params: {},
          },
        },
        Reactions: {
          CreatePlaylist: {
            Name: 'create_playlist',
            IsParams: true,
            IsBoolParams: true,
            Params: {
              name: '',
              description: '',
            },
            BoolParams: {
              is_public: false,
            },
          },
          AddItemsToPlaylist: {
            Name: 'add_items_to_playlist',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              playlist_id: '',
              track_id: '',
            },
          },
          AddTrackToQueue: {
            Name: 'add_track_to_queue',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              track_id: '',
            },
          },
          SetVolume: {
            Name: 'set_volume',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              volume: '',
            },
          },
          StartSong: {
            Name: 'start_song',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              volume: '',
            },
          },
          PauseSong: {
            Name: 'pause_song',
            IsParams: false,
            IsBoolParams: false,
          },
          NextSong: {
            Name: 'next_song',
            IsParams: false,
            IsBoolParams: false,
          },
          PreviousSong: {
            Name: 'previous_song',
            IsParams: false,
            IsBoolParams: false,
          },
          FollowPlaylist: {
            Name: 'follow_playlist',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              playlist_id: '',
            }
          },
          RemoveSavedTrack: {
            Name: 'remove_saved_track',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              track_id: '',
            }
          },
          save_show: {
            Name: 'save_show',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              show_id: '',
            }
          },
          RemoveSavedShow: {
            Name: 'remove_saved_show',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              show_id: '',
            }
          },
        },
      },
      Discord: {
        Name: 'Discord',
        ImageLink: 'https://m1.quebecormedia.com/emp/emp/discord31fa7044-2286-4838-be61-a8fb7db67d6e_ORIGINAL.jpg?impolicy=crop-resize&x=0&y=0&w=0&h=0&width=925',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
          WeatherHour: {
            Name: 'weather_hour',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              hours: '',
            }
          },
          WeatherDiff: {
            Name: 'weather_diff',
            IsParams: false,
            IsBoolParams: false,
          },
        },
        Reactions: {
          ListMessage: {
            Name: 'list_message',
            IsParams: false,
            IsBoolParams: false,
          },
          SendMessage: {
            Name: 'send_message',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              message: '',
            }
          },
          SendWeather: {
            Name: 'send_weather',
            IsParams: false,
            IsBoolParams: false,
          },
        },
      },
      Deezer: {
        Name: 'Deezer',
        ImageLink: 'https://assets.stickpng.com/images/6297981ce01809629f11358d.png',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
        },
        Reactions: {
        },
      },
      GitHub: {
        Name: 'GitHub',
        ImageLink: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Font_Awesome_5_brands_github.svg/1200px-Font_Awesome_5_brands_github.svg.png',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
        },
        Reactions: {
        },
      },
      Yahoo: {
        Name: 'Yahoo',
        ImageLink: 'https://s.yimg.com/cv/apiv2/social/images/yahoo_default_logo.png',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
        },
        Reactions: {
        },
      },
      Twitch: {
        Name: 'Twitch',
        ImageLink: 'https://play-lh.googleusercontent.com/QLQzL-MXtxKEDlbhrQCDw-REiDsA9glUH4m16syfar_KVLRXlzOhN7tmAceiPerv4Jg',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
          CheckNewFollow: {
            Name: 'check_new_follow',
            IsParams: false,
            IsBoolParams: false,
            Params: {
              access_token: '',
            }
          },
          CheckNewFollowers: {
            Name: 'check_new_followers',
            IsParams: false,
            IsBoolParams: false,
            Params: {
              access_token: '',
            }
          },
          GetSchedule: {
            Name: 'get_schedule',
            IsParams: false,
            IsBoolParams: false,
            Params: {
              access_token: '',
            }
          },
          GetVideo: {
            Name: 'get_video',
            IsParams: false,
            IsBoolParams: false,
            Params: {
              access_token: '',
            }
          },
          GetStream: {
            Name: 'get_stream',
            IsParams: false,
            IsBoolParams: false,
            Params: {
              access_token: '',
            }
          },
        },
        Reactions: {
          SendMail: {
            Name: 'send_mail',
            IsParams: true,
            IsBoolParams: false,
            Params: {
              message: '',
            }
          },
        },
      },
      Google: {
        Name: 'Google',
        ImageLink: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png',
        IsLog: false,
        AuthentificationTokens: '',
        Actions: {
        },
        Reactions: {
        },
      },
    },
  },
  getters: {
    getSpotifyToken(state) {
      return state.Services.Spotify.AuthentificationTokens;
    },
    getDiscordToken(state) {
      return state.Services.Discord.AuthentificationTokens;
    },
    getTwitchToken(state) {
      return state.Services.Twitch.AuthentificationTokens;
    },
    getGitHubToken(state) {
      return state.Services.GitHub.AuthentificationTokens;
    },
    getDeezerToken(state) {
      return state.Services.Deezer.AuthentificationTokens;
    },
    getSavedAction(state) {
      return state.Action;
    },
    getSavedActionParams(state) {
      return state.ActionParams;
    },
    getSavedReaction(state) {
      return state.Reaction;
    },
    getSavedReactionParams(state) {
      return state.ReactionParams;
    },
    getServiceActionSelected(state) {
      return state.ServiceActionSelected;
    },
    getServiceReactionSelected(state) {
      return state.ServiceReactionSelected;
    }
  },
  mutations: {
    setSpotifyToken(state, token) {
      state.Services.Spotify.AuthentificationTokens = token;
    },
    setTwitchToken(state, token) {
      state.Services.Twitch.AuthentificationTokens = token;
    },
    setDiscordToken(state, token) {
      state.Services.Discord.AuthentificationTokens = token;
    },
    setGitHubToken(state, token) {
      state.Services.GitHub.AuthentificationTokens = token;
    },
    setDeezerToken(state, token) {
      state.Services.Deezer.AuthentificationTokens = token;
    },
    setSavedAction(state, action) {
      state.Action = action;
    },
    setSavedActionParams(state, actionParams) {
      state.ActionParams = actionParams;
    },
    setSavedReaction(state, reaction) {
      state.Reaction = reaction;
    },
    setSavedReactionParams(state, reactionParams) {
      state.ReactionParams = reactionParams;
    },
    setServiceActionSelected(state, serviceSelectedName) {
      state.ServiceActionSelected = serviceSelectedName;
    },
    setServiceReactionSelected(state, serviceSelectedName) {
      state.ServiceReactionSelected = serviceSelectedName;
    },
  },
  actions: {
  },
  modules: {
  }
})

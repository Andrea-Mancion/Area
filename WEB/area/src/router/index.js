import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import ActionReactionView from '../views/ActionReaction/ActionReactionView.vue'
import ServiceView from '../views/ServiceView.vue'
import ActionServiceListView from '../views/ActionReaction/Action/ActionServiceListView.vue'
import ActionListView from '../views/ActionReaction/Action/ActionListView.vue'
import ActionParamsView from '../views/ActionReaction/Action/ActionParamsView.vue'
import ReactionServiceListView from '../views/ActionReaction/Reaction/ReactionServiceListView.vue'
import ReactionListView from '../views/ActionReaction/Reaction/ReactionListView.vue'
import ReactionParamsView from '../views/ActionReaction/Reaction/ReactionParamsView.vue'
import SignInView from '../views/SignInView.vue'
import OAuthLogin from '../views/OAuth2/OAuthLoginView.vue'
import OAuthCallback from '../views/OAuth2/OAuthCallbackView.vue'
import TelechargerFichierView from '../views/TelechargerFichierView.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView,
  },
  {
    path: '/action-reaction',
    name: 'action-reaction',
    component: ActionReactionView,
  },
  {
    path: '/service',
    name: 'service',
    component: ServiceView,
  },
  {
    path: '/action-service-list',
    name: 'action-service-list',
    component: ActionServiceListView,
  },
  {
    path: '/action-list',
    name: 'action-list',
    component: ActionListView,
    props: true,
  },
  {
    path: '/action-params',
    name: 'action-params',
    component: ActionParamsView,
    props: true,
  },
  {
    path: '/reaction-service-list',
    name: 'reaction-service-list',
    component: ReactionServiceListView,
  },
  {
    path: '/reaction-list',
    name: 'reaction-list',
    component: ReactionListView,
    props: true,
  },
  {
    path: '/reaction-params',
    name: 'reaction-params',
    component: ReactionParamsView,
    props: true,
  },
  {
    path: '/sign-in',
    name: 'sign-in',
    component: SignInView,
  },
  {
    path: '/oauth-login',
    name: 'oauth-login',
    component: OAuthLogin
  },
  {
    path: '/oauth-callback',
    name: 'oauth-callback',
    component: OAuthCallback
  },
  {
    path: '/client.apk',
    name: 'telecharger-fichier',
    component: TelechargerFichierView,
  },
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router

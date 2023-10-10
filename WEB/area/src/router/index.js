import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import ActionReactionView from '../views/ActionReactionView.vue'
import ServiceView from '../views/ServiceView.vue'
import ActionApplicationListView from '../views/ActionApplicationListView.vue'
import ReactionApplicationListView from '../views/ReactionApplicationListView.vue'
import SignInView from '../views/SignInView.vue'
import OAuthLogin from '../components/OAuthLogin.vue'
import OAuthCallback from '../components/OAuthCallback.vue'

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
    path: '/action-application-list',
    name: 'action-application-list',
    component: ActionApplicationListView,
  },
  {
    path: '/reaction-application-list',
    name: 'reaction-application-list',
    component: ReactionApplicationListView,
  },
  {
    path: '/sign-in',
    name: 'sign-in',
    component: SignInView,
  },
  {
    path: '/oauth-login',
    name: 'oauth-logi',
    component: OAuthLogin
  },
  {
    path: '/oauth-callback',
    name: 'oauth-callback',
    component: OAuthCallback
  },
]

const router = new VueRouter({
  mode: 'history',
  routes
})

export default router

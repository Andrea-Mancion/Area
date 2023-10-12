import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import ActionReactionView from '../views/ActionReaction/ActionReactionView.vue'
import ServiceView from '../views/ServiceView.vue'
import ActionServiceListView from '../views/ActionReaction/Action/ActionServiceListView.vue'
import ActionListView from '../views/ActionReaction/Action/ActionListView.vue'
import ReactionerviceListView from '../views/ActionReaction/Reaction/ReactionServiceListView.vue'
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
    path: '/reaction-service-list',
    name: 'reaction-service-list',
    component: ReactionerviceListView,
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

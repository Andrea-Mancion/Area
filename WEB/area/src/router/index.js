import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import ActionReactionView from '../views/ActionReactionView.vue'
import ServiceView from '../views/ServiceView.vue'
import DetailServiceView from '../views/DetailServiceView.vue'
import SignInView from '../views/SignInView.vue'

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
    path: '/service/detail',
    name: 'detail-service',
    component: DetailServiceView,
  },
  {
    path: '/sign-in',
    name: 'sign-in',
    component: SignInView,
  }
]

const router = new VueRouter({
  routes
})

export default router

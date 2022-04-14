import Vue from 'vue'
import VueRouter from 'vue-router'
import AuthService from './services/auth'

// Dashboard
import Basic from './views/admin/dashboard/Basic.vue'

// Layouts
import LayoutBasic from './views/layouts/LayoutBasic.vue'
import LayoutLogin from './views/layouts/LayoutLogin.vue'
import LayoutPassword from './views/layouts/LayoutPassword.vue'

// Users
import Users from './views/admin/users/Users.vue'
import Profile from './views/admin/users/Profile.vue'
import Verification from './views/admin/users/Verification.vue'

// Setting
import NewUser from './views/admin/users/NewUser.vue'
import RegionManagement from './views/admin/users/RegionManagement.vue'

// Auth
import Login from './views/auth/Login.vue'
import Register from './views/auth/Register.vue'
import PasswordReset from './views/auth/PasswordReset.vue'
import ResetForm from './views/auth/ResetForm.vue'

// Email_Verification
import EmailVerification from './views/emailVerification/EmailVerification.vue'

import NotFoundPage from './views/errors/404.vue'

Vue.use(VueRouter)

const routes = [

  {
    path: '/',
    component: LayoutLogin,
    redirect: "login",
    children: [
      {
        path: 'login',
        component: Login,
        name: 'login'
      },
      {
        path: 'register',
        component: Register,
        name: 'register'
      }
    ]
  },

  {
    path: '/password',
    component: LayoutPassword,
    children: [
      {
        path: 'password-reset',
        component: PasswordReset,
        name: 'password_reset'
      },
      {
        path: 'reset-form',
        component: ResetForm,
        name: 'reset_form'
      }
    ]
  },

  {
    path: '/admin',
    component: LayoutBasic, // Change the desired Layout here
    meta: { requiresAuth: true },
    children: [
      // Dashboard
      {
        path: 'dashboard/basic',
        component: Basic,
        name: 'dashboard'
      },

      // Users
      {
        path: 'users/all',
        component: Users
      },
      {
        path: 'users/profile/:id',
        component: Profile
      },
      {
        path: 'users/verification/:id',
        component: Verification
      },

      // New User
      {
        path: 'new_user',
        component: NewUser
      },

      // Region Management
      {
        path: 'region_management',
        component: RegionManagement
      }
    ]
  },

  {
    path: '/email_verification',
    component: EmailVerification,
    name: 'email_verification'
  },

  //  DEFAULT ROUTE
  { path: '*', component: NotFoundPage }
]

const router = new VueRouter({
  routes,
  base: "/",
  mode: 'history',
  linkActiveClass: 'active'
})

router.beforeEach((to, from, next) => {
  //  If the next route is requires user to be Logged IN
  if (to.matched.some(m => m.meta.requiresAuth)) {
    return AuthService.check().then(authenticated => {
      if (!authenticated) {
        return next({ path: '/login' })
      }

      return next()
    })
  }

  return next()
})

export default router

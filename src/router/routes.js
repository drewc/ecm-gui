import claimRoute from './claim'
import personRoute from './person'
import policyRoute from './policy'
import contractRoute from './contract'

const routes = [
  {
    path: '/admin/',
    component: () => import('layouts/MyLayout.vue'),
    children: [
      { path: '', component: () => import('pages/Index.vue') }
      // ,
      // {
      //   path: 'user',
      //   component: () => import('pages/ManageUsers.vue'),
      //   children: [
      //     { path: ':id', props: true, component: () => import('components/UserView') }
      //   ]
      // }
    ]
  },
  {
    path: '/create',
    component: () => import('layouts/MyLayout.vue'),
    children: [
      { path: '', component: () => import('pages/Index.vue') },
      {
        path: 'entity',
        component: () => import('pages/CreateEntity.vue'),
        children: [
          { path: 'person', component: () => import('pages/CreatePerson.vue') }
        ]
      }
    ]
  },
  {
    path: '/',
    component: () => import('layouts/MyLayout.vue'),
    children: [
      policyRoute,
      claimRoute,
      personRoute,
      contractRoute,
      { path: 'login', component: () => import('pages/Login.vue') },
      { path: '', component: () => import('components/Masonry.vue') }
    ]
  }
]

// Always leave this as last one
if (process.env.MODE !== 'ssr') {
  routes.push({
    path: '*',
    component: () => import('pages/Error404.vue')
  })
}

export default routes

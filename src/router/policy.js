const policyRoute = {
  path: '/policy/:id', props: true, component: () => import('pages/PolicyPage')
}

export default policyRoute

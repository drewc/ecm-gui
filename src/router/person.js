const personRoute = {
  path: '/person/:id', props: true, component: () => import('pages/PersonPage')
}

export default personRoute

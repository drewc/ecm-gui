const contractRoute = {
  path: '/contract/:id', props: true, component: () => import('pages/ContractPage')
}

export default contractRoute

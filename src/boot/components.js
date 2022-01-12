import MExpansionItem from 'components/MExpansionItem'
import MBrick from 'components/MBrick'
import Masonry from 'components/Masonry'

export default async ({ Vue }) => {
  Vue.component('MExpansionItem', MExpansionItem)
  Vue.component('Masonry', Masonry)
  Vue.component('MBrick', MBrick)
}

<template>
  <q-expansion-item
    @before-show="raise" @after-show="reveal" @after-hide="reveal"
    v-bind="$attrs"
    >
    <template slot="header">
      <slot name="header"/>
    </template>
 <slot></slot>
 </q-expansion-item>
</template>
<script>
import Masonry from 'components/Masonry'

export default {
  name: 'MExpansionItem',
  methods: {
    reveal () {
      Masonry.methods.resizeMasonryItem(this.$el.closest('.masonry-item'))
      Masonry.methods.layBricks(); this.lower()
    },
    raise () {
      console.log('Raising '); console.log(this.$el.closest('.masonry-item'))
      this.$el.style.position = 'relative'
      this.$el.style.zIndex = 1024
    },
    lower () {
      this.$el.style.position = 'unset'
      this.$el.style.zIndex = 'unset'
    }
  }
}
</script>

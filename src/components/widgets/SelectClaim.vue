<script setup>
import { ref, computed, onMounted } from 'vue'
import { useStore } from 'vuex'
import { post } from 'axios'

import SimpleTypeAhead from '../SimpleTypeAhead.vue';
import { cache } from '../../assets/storage.js'
import InlineClaim from './InlineClaim.vue'
const claim = ref()

window.localforage = cache

const store = useStore();
const user = computed(() => store && store.state && store.state.user)

if (claims.value.length == 0) updateClaims();

const props = defineProps({
    modelValue: Object
})
const emits = defineEmits(['update:modelValue']);



const error = ref(err)
const inp = (ta) => ta.$el.getElementsByTagName("input")[0].setAttribute("class", "uk-input")

const typeahead = ref()

onMounted(() => {
 const ta = typeahead.value
 ta && inp(ta)
 // if (contracts.value.length == 0) updateClaims();
})

const taInput = ({ input, items }) => {
 console.log('Test Input', input, items, typeahead)
}

const aroundItems = (items) => {
 console.log("aroundItems?", items)
  return [
    {
      claim_id: "Search for " + typeahead.value.input,
      search_for_claim: typeahead.value.input
    },
    ...items
  ]

};

const findClaim = (thing) => {
  console.log('findClaim', thing, !isNaN(thing))
  if (!isNaN(thing)) {
    console.log('posting!')
    return post('/rpc/db/claim', { claim_id: parseInt(thing) })
}
}
const selectItem = (i) => {
  if (!!i.search_for_claim) {
   console.log("Searching ", i.search_for_claim)
   typeahead.value.input = i.search_for_claim
    findClaim(i.search_for_claim).then(c => {
      typeahead.value.selectItem(c.data);
      console.log('Found one', c)
    })
         .catch(e => console.error(e))
  } else {
  claim.value = i;
  emits('update:modelValue', i)
  }
}

</script>

<script>
import { ref } from 'vue'

const claims = ref([])
const err = ref()

const updateClaims = () => { false }

</script>
<template>
  <InlineClaim v-if="claim" :claim="claim" />
<SimpleTypeAhead
  ref="typeahead"
  placeholder="Claim # or search" :items="claims"
    :min-input-length="2" :item-projection="(i) => i.claim_id"
  :around-items="aroundItems"
    @onInput="taInput"
    @select-item="selectItem">
 <template #list-item-text="{ boldMatchText, itemProjection, item }">
 <h4 style="display: inline-block" v-html="boldMatchText(itemProjection(item))"></h4>
  </template>
</SimpleTypeAhead>

<!-- <div v-if="claims.length === 0" uk-spinner></div> -->
</template>

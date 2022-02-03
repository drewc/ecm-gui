<script setup>
import { ref, computed, onMounted } from 'vue'
import { get } from 'axios'

import SimpleTypeAhead from '../SimpleTypeAhead.vue';

const props = defineProps({
    modelValue: Object
})
const emits = defineEmits(['update:modelValue']);

const selectItem = (i) => {
  emits('update:modelValue', i)
}

const sortItems = ({input, items}) => {
  const comp = (i, str) => i.name.startsWith(str) ? 1 : 0
  items.sort((a,b) => 0 - comp(a, input) + comp(b, input))
  console.log(items)
}

const syndicates = ref([])
const error = ref()

const typeahead = ref()
let selecta;

onMounted(() => {
 const ta = typeahead.value
 selecta = ta
 ta.$el.getElementsByTagName("input")[0].setAttribute("class", "uk-input")
})

get('/rpc/db/syndicates').then(
  r => syndicates.value = r.data.syndicates)
  .catch(e => error.value = e);

</script>

<template>
 <SimpleTypeAhead
    ref="typeahead"
    placeholder="Syndicate Name" :items="syndicates"
    :min-input-length="0" :item-projection="(i) => i.name"
    @select-item="selectItem" @onInput="sortItems"
   />
</template>

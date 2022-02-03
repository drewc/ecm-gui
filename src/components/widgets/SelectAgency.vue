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


const agencies = ref([])
const error = ref()

const typeahead = ref()
onMounted(() => {
 const ta = typeahead.value
 ta.$el.getElementsByTagName("input")[0].setAttribute("class", "uk-input")
})

get('/rpc/db/agencies').then(
  r => agencies.value = r.data.agencies)
  .catch(e => error.value = e);

</script>

<template>
 <SimpleTypeAhead
    ref="typeahead"
    :defaultItem="modelValue"
    placeholder="Agency Name" :items="agencies"
    :min-input-length="0" :item-projection="(i) => i.name"
    @select-item="selectItem"
   />
</template>

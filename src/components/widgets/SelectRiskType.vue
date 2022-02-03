<script setup>
import { ref, computed, onMounted } from 'vue'
import { get } from 'axios'

import SimpleTypeAhead from 'vue3-simple-typeahead';

const props = defineProps({
    modelValue: Object,
    allowNone: Boolean
})
const emits = defineEmits(['update:modelValue']);

const selectItem = (i) => {
  emits('update:modelValue', i)
}



const risk_types = ref([])
const error = ref()

const typeahead = ref()
onMounted(() => {
 const ta = typeahead.value
 ta.$el.getElementsByTagName("input")[0].setAttribute("class", "uk-input")
})

get('/rpc/db/risk-types').then(
  r => {
    const none = !!props.allowNone ? [{ name: "None" }] : []
    risk_types.value = [...none, ...r.data.risk_types]
  })
  .catch(e => error.value = e);

</script>

<template>
 <SimpleTypeAhead
    ref="typeahead"
    placeholder="Risk Type" :items="risk_types"
    :min-input-length="0" :item-projection="(i) => i.name"
    @select-item="selectItem"
   />
</template>

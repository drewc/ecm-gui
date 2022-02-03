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

const diary_users = ref([])
const error = ref()

const typeahead = ref()
let selecta;

onMounted(() => {
 const ta = typeahead.value
 selecta = ta
 ta.$el.getElementsByTagName("input")[0].setAttribute("class", "uk-input")
})

get('/rpc/db/diary-users').then(
  r => diary_users.value = r.data.diary_users)
  .catch(e => error.value = e);

</script>

<template>
 <SimpleTypeAhead
    ref="typeahead"
    placeholder="Diary_user Name" :items="diary_users"
    :min-input-length="0" :item-projection="(i) => i.name"
    @select-item="selectItem" @onInput="sortItems"
   />
</template>

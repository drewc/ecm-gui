<script setup>
import uniqueid from "lodash.uniqueid"
import { ref, computed } from 'vue'

import datepicker from 'vue3-datepicker'
const props = defineProps({
    modelValue: Object
})
const emit = defineEmits(['update:modelValue']);


const to = ref()
const from = ref()


const clone = o => Object.assign({}, o);
const range = clone(props.modelValue);
const update = (k) => {
  console.log('update fn', k)
  return (v) => { range[k] = v ; emit('update:modelValue', clone(range)) }
}
const updateFrom = update('from');
const updateTo = update('to');

const id = uniqueid()
const $id = (i) => i + id

</script>

<template>
 <div class="uk-margin">
  <label class="uk-form-label" :for="$id('range-from')">From</label>
  <div class="uk-form-controls">
    <datepicker
      class="uk-input" placeholder="Start at yyyy-mm-dd" typeable
      @update:modelValue="updateFrom" v-model="from"
      :id="$id('range-from')" />
        </div>
    </div>
 <div class="uk-margin">
  <label class="uk-form-label" :for="$id('range-to')">To</label>
  <div class="uk-form-controls">
    <datepicker
      class="uk-input" placeholder="End at yyyy-mm-dd" typeable
      @update:modelValue="updateTo" v-model="to"
      :id="$id('range-to')" />
        </div>
    </div>
</template>

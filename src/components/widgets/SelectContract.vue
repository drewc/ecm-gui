<script setup>
import { ref, computed, onMounted } from 'vue'
import { useStore } from 'vuex'

import SimpleTypeAhead from '../SimpleTypeAhead.vue';

const store = useStore();
const user = computed(() => store && store.state && store.state.user)

if (contracts.value.length == 0) updateContracts();
const props = defineProps({
    modelValue: Object
})
const emits = defineEmits(['update:modelValue']);

const selectItem = (i) => {
  emits('update:modelValue', i)
}


const error = ref(err)
const inp = (ta) => ta.$el.getElementsByTagName("input")[0].setAttribute("class", "uk-input")

const typeahead = ref()

onMounted(() => {
 const ta = typeahead.value
 ta && inp(ta)
if (contracts.value.length == 0) updateContracts();
})


</script>

<script>
import { ref } from 'vue'
import { get } from 'axios'

const contracts = ref([])
const err = ref()

const updateContracts = () => {
   get('/rpc/db/contracts').then(
     r => { contracts.value = r.data.contracts})
 .catch(e => err.value = e);
}

</script>
<template>
<SimpleTypeAhead
  :hidden="contracts.length === 0" ref="typeahead"
  uk-tooltip="title: Enter at least 3 characters of the Contract#; pos: top"
    placeholder="Contract Number" :items="contracts"
    :min-input-length="3" :item-projection="(i) => i.contract_number"
    @select-item="selectItem">
 <template #list-item-text="{ boldMatchText, itemProjection, item }">
 <h4 style="display: inline-block" v-html="boldMatchText(itemProjection(item))"></h4>
 <span v-html="' ' + item.effective_date + '-' + item.expiry_date"></span>
 <small v-if="item.syndicate_id" uk-tooltip="Syndicate"
        v-html="' ' + item.syndicate"></small>
 <small v-if="item.london_broker_id" uk-tooltip="London Broker"
        v-html="', ' + item.london_broker"></small>
 <small v-if="item.insurance_company_id" uk-tooltip="Insurance Company"
        v-html="', ' + item.insurance_company"></small>
 <small v-if="item.agency_id" uk-tooltip="Agency"
        v-html="', ' + item.agency"></small>
  </template>
</SimpleTypeAhead>

<div v-if="contracts.length === 0" uk-spinner></div>
</template>

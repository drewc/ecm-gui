<script setup>
const props = defineProps({
    contract: Object
})
</script>
<template>
  <div style="display: inline-block">
    <h4 style="display: inline-block" v-html="contract.contract_number"></h4>
 <span v-html="' ' + contract.effective_date + ' to ' + contract.expiry_date"></span>
 <small v-if="contract.syndicate_id" uk-tooltip="Syndicate"
        v-html="' ' + contract.syndicate"></small>
 <small v-if="contract.london_broker_id" uk-tooltip="London Broker"
        v-html="', ' + contract.london_broker"></small>
 <small v-if="contract.insurance_company_id" uk-tooltip="Insurance Company"
        v-html="', ' + contract.insurance_company"></small>
 <small v-if="contract.agency_id" uk-tooltip="Agency"
        v-html="', ' + contract.agency"></small>
  </div>
</template>

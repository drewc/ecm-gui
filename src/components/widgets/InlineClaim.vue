<script setup>
import InlineContract from './InlineContract.vue'
const props = defineProps({
    claim: Object
})
</script>
<template>
  <div>
    <span class="uk-text-lead">#{{ claim.claim_id }}&nbsp;</span>
    <span><span class="uk-text-meta">Insured </span>
    <span v-html="claim.risk.policy.insured.full_name"></span></span>
    <span><span class="uk-text-meta">DOL </span>
    <span v-html="claim.timeline.date_of_loss"></span></span>
    <span><span class="uk-text-meta">Contract </span> {{ claim.risk.contract }}
      <InlineContract :contract="claim.risk.contract" /></span>
  </div>
</template>

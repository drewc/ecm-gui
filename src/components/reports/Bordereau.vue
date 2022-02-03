<script setup>
import { ref, computed, onMounted } from 'vue'
import Report from '../Report.vue'
import Datepicker from  '../../components/DateTimePicker.vue'

import SelectSyndicate from '../widgets/SelectSyndicate.vue'
import SelectAgency from '../widgets/SelectAgency.vue'
import SelectContract from '../widgets/SelectContract.vue'
import SelectClaim from '../widgets/SelectClaim.vue'
import SelectRiskType from '../widgets/SelectRiskType.vue'

const range = ref()
const tz = Intl.DateTimeFormat().resolvedOptions().timeZone

const st = { hours: 0, minutes: 0 }
const startTime = ref([st, st])

const picked = ref();
const agency = ref();
const claim = ref();
const syndicate = ref();
const contract = ref();
const risk_type = ref();

const allowRun = computed(() => picked.value && range.value)

const reportOn = computed(() => {
  const r = {
    timezone: tz,
    from: range.value[0],
    to: range.value[1],
    risk_type: risk_type.value && risk_type.value.name
  }
  if (picked.value === 'agency') {
    return {
      agency_id: agency.value.agency_id,
      ...r
    }
  } else {
    return {
      // agency_id: contract.value.agency_id,
      contract_id: contract.value.contract_id,
      ...r


    }
  }

})
</script>

<template>
<div class="ecm-center-inputs"> {{ claim }}
  <Report title="Bordereau">
    <template #default="{ toggle, runReport }">
      <div class="uk-width-expand uk-text-center uk-margin">
        <label><input class="uk-radio" type="radio"
                      value="syndicate" v-model="picked">&nbsp;Syndicate</label>
        &nbsp;&nbsp;
        <label><input class="uk-radio" type="radio"
                      value="contract" v-model="picked">&nbsp;Contract</label>
        &nbsp;&nbsp;
        <label><input class="uk-radio" type="radio"
                      value="agency" v-model="picked">&nbsp;Agency</label>
        &nbsp;&nbsp;
        <label><input class="uk-radio" type="radio"
                      value="claim" v-model="picked">&nbsp;Claim</label>
      </div>
      <div v-if="picked">
        <div class="uk-margin">

          <SelectSyndicate v-if="picked === 'syndicate'" v-model="syndicate"/>
          <SelectAgency v-if="picked === 'agency'" v-model="agency"/>
          <SelectClaim v-if="picked === 'claim'" v-model="claim"/>
          <SelectContract v-if="picked === 'contract'" v-model="contract"/>
        </div>
        <div class="uk-margin">
          <SelectRiskType v-model="risk_type" allow-none />
        </div>

  <Datepicker inputClassName="uk-input foo"
              format="yyyy-MM-dd HH:mm" v-model="range"
              placeholder="Date Range"
              range twoCalendars autoApply :startTime="startTime" />

     <div class="uk-width-expand uk-text-center uk-padding" v-if="allowRun">
     <button
       @click="runReport('/rpc/report/cheque-register', reportOn)"
       class="uk-button uk-button-primary" type="button"
       >
        Run Report
      </button>
    </div>
</div>
</template>
</Report>
</div>
</template>

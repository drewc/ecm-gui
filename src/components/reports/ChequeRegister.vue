<script setup>
import { ref, computed, onMounted } from 'vue'
import Report from '../Report.vue'
import Datepicker from 'vue3-date-time-picker';
// import 'vue3-date-time-picker/dist/main.css'

import SelectAgency from '../widgets/SelectAgency.vue'
import SelectContract from '../widgets/SelectContract.vue'
import SelectRiskType from '../widgets/SelectRiskType.vue'

const range = ref()
const tz = Intl.DateTimeFormat().resolvedOptions().timeZone

const st = { hours: 0, minutes: 0 }
const startTime = ref([st, st])
const picked = ref();

const agency = ref();
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
  <div class="ecm-center-inputs">
<Report title="Cheque Register">
  <template #default="{ toggle, runReport }">
 <div class="uk-width-expand uk-text-center uk-margin">
 <label><input class="uk-radio" type="radio"
               value="agency" v-model="picked">&nbsp;Agency</label>
 &nbsp;&nbsp;
 <label><input class="uk-radio" type="radio"
               value="contract" v-model="picked">&nbsp;Contract</label>
 </div>
 <div v-if="picked">
           <div class="uk-margin">

  <SelectAgency v-if="picked === 'agency'" v-model="agency"/>
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
<style>
.ecm-center-inputs .uk-open{ padding-bottom:1em; }
.ecm-center-inputs input {
   text-align: center;
}
.ecm-center-inputs ::-webkit-input-placeholder {
   text-align: center;
}

 .ecm-center-inputs :-moz-placeholder { /* Firefox 18- */
   text-align: center;
}

 .ecm-center-inputs ::-moz-placeholder {  /* Firefox 19+ */
   text-align: center;
}

 .ecm-center-inputs :-ms-input-placeholder {
   text-align: center;
}
</style>
<style lang="scss">
  @import "uikit/src/scss/variables.scss";
  $dp__font_family: $global-font-family;
  $dp__font_size: $global-font-size;
  @import 'vue3-date-time-picker/src/Vue3DatePicker/style/main.scss';
.dp__input {
  background-color: var(--dp-background-color);
  border-radius: $dp__border_radius;
  font-family: $dp__font_family;
  border: 1px solid var(--dp-border-color);
  outline: none;
  transition: border-color 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
  width: 100%;
  font-size: $dp__font_size;
  line-height: $dp__font_size * 1.5;
  padding-right: $form-select-padding-right * 2;
  color: $global-color;
  box-sizing: border-box;

  &::placeholder {
    opacity: unset;
    text-align: center;
  }
}


</style>

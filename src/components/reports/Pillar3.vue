<script setup>
import { ref, computed, onMounted } from 'vue'
import { post } from 'axios'
import { SQLStatement } from '../../assets/sql/objects'
import '../../assets/sql/spreadsheet'
import SelectSyndicate from '../widgets/SelectSyndicate.vue'
import DateRange from '../widgets/DateRange.vue'
import SpreadSheet from '../SpreadSheet.vue'
import { saveWorkBook } from '../../assets/SheetTemplate'
import UIkit from 'uikit'

import uniqueid from "lodash.uniqueid"
const id = uniqueid()
const $id = (i) => i + id


const syndicate = ref()
const date_range = ref()
const loading = ref()

const show_run = computed(() =>
   !loading.value && syndicate.value
    && date_range.value && date_range.value.to && date_range.value.from)

const error = ref()
const report = ref()
const sheet = ref()

const accordionEl = ref()

let accordion;

onMounted(() => {
 accordion = accordionEl.value
})

function runReport() {
  error.value = undefined
  loading.value = true
  post('/rpc/report/pillar3', {
    syndicate_id: syndicate.value.syndicate_id,
    start_date: date_range.value.from,
    end_date: date_range.value.from
  }).then(res => {
    loading.value = false
    const stmt =  new SQLStatement(res.data);
    UIkit.accordion(accordion).toggle(0,true)
    report.value = stmt;
    sheet.value = stmt.spreadsheet('Pillar 3')
    console.log('accordion', accordion);
  }).catch( e => {error.value = e ;loading.value = false})
}

const fn = ref('Pillar 3.xlsx')
const saveReport =  () => {
 saveWorkBook(fn.value, sheet.value.workbook)
}

const itemClass = computed(()=>
  "uk-background-default uk-container" + report.value ?
    "" : "uk-height-viewport")



</script>

<template>
  <div class="uk-card uk-card-default" >
    <ul uk-accordion ref="accordionEl">
      <li class="uk-open"><br>
             <a class="uk-accordion-title uk-padding-small">
               <h2 class="uk-width-expand uk-text-center">Pillar 3</h2> </a>
   <div class="uk-accordion-content uk-card uk-card-default uk-card-body uk-width-xlarge uk-align-center">

    <form>

    <fieldset class="uk-fieldset uk-form-horizontal">
 <div class="uk-margin">
  <label class="uk-form-label" :for="$id('syndicate')">Syndicate</label>
  <div class="uk-form-controls">
 <SelectSyndicate v-model="syndicate" />
        </div>
    </div>
 <DateRange v-model="date_range" />

     <div class="uk-width-expand uk-text-center">

     <div v-if="error" class="uk-alert-danger" uk-alert>
        <a class="uk-alert-close" uk-close></a>
        <p style="text-align:center"> {{ error }} </p>
      </div>
    <button v-if="show_run" @click="runReport"
            class="uk-button uk-button-primary" type="button">Run Report</button>
    <div v-if="loading" uk-spinner></div>
    </div>
    </fieldset>
    </form>
    </div>
    <br>
</li>
    </ul>
  </div>
   <div v-if="sheet" class="uk-background-default uk-padding">
     <button @click="saveReport" class="uk-align-right uk-button"> Save Spreadsheet</button>
    <SpreadSheet :sheet="sheet" class="uk-table uk-table-divider" />
   </div>

</template>
<style scoped>
  .uk-open>.uk-accordion-title::before {
    background-image: unset;
  }
</style>

<script setup>
import UIkit from 'uikit'
import SimpleTypeAhead from 'vue3-simple-typeahead';
import { downloadWorkBook, saveWorkBook } from '../../assets/SheetTemplate'
import { ref, computed } from 'vue'
import datepicker from 'vue3-datepicker'
import { get, post } from 'axios'
import { onMounted } from 'vue'
import ResultsTable from '../../components/ResultsTable.vue'
import SpreadSheet from '../SpreadSheet.vue'
const error = ref(false);

const current_date = new Date()
const current_month = current_date.getMonth()
const current_year = 1900 + current_date.getYear()

const start_month = current_month < 3 ?
      current_month + 9 : current_month - 3;

const start_year = current_month < 3 ? current_year - 1 : current_year;
const start_date = ref(new Date(start_year, start_month, 1))
const end_date = ref(new Date(current_year, current_month, 1))

const syndicates = ref([]);
const syndicate = ref();
const lob = ref(false)

get('/rpc/report/pmi').then(
  r => syndicates.value = r.data.syndicates)
  .catch(e => error.value = e);

const fr_on = 'Filter by line of business?'
const fr_off = 'Remove LOB filter'
const filterLabel=ref(fr_on)

onMounted(()=> {
  UIkit.util.on('#lob', "show", function () {
    filterLabel.value = fr_off
  })

  UIkit.util.on('#lob', "hide", function () {
   lob.value = null;
   filterLabel.value = fr_on
  })
})

const report2book = async (rep) => {
  const wb = await downloadWorkBook('/report/pmi/template.xlsx')
  const ws = wb.getWorksheet("US");
  Object.entries(rep).forEach(([k,v]) => ws.getCell(k).value = v);
  return wb;
}

const report = ref()
const workbook = ref()
const worksheet = computed(() =>
  workbook.value ? workbook.value.getWorksheet("US") : undefined)
const loading = ref(false)

function runReport() {
  error.value = undefined
  loading.value = true
  post('/rpc/report/pmi', {
    syndicate_id: syndicate.value.syndicate_id,
    start_date: start_date.value,
    end_date: end_date.value,
    line_of_business: lob.value
  }).then(res => {
    loading.value = false
    report.value = res.data
    report2book(res.data).then(wb => workbook.value = wb);


  }).catch( e => {error.value = e ;loading.value = false})

 }

const saveReport =  () => {
 saveWorkBook(workbook.value)
}

</script>

<template>
  <div class="uk-container-expand">
 <h1 class="uk-align-center uk-text-center uk-width-expand"> Performance Management Information </h1>
 <div class="uk-flex uk-flex-center uk-flex-wrap">
<div class="uk-card uk-card-default uk-card-hover uk-card-small uk-card-body">
  For:
  <SimpleTypeAhead
    style="width: unset"
    placeholder="Syndicate" :items="syndicates" v-model="syndicate"
    :min-input-length="0" :item-projection="(i) => i.name"
    @select-item="(i) => {syndicate = i }"/>
</div>
<div class="uk-card uk-card-default uk-card-body uk-card-hover uk-card-small uk-margin-left">
  From: <datepicker v-model="start_date" :upperLimit="current_date"/>
</div>
<div class="uk-card uk-card-default uk-card-body uk-card-hover uk-card-small uk-margin-left">
  To: <datepicker v-model="end_date" :upperLimit="current_date" />
</div>
<div class="uk-card uk-card-default uk-card-hover uk-card-small uk-card-body uk-flex uk-flex-center uk-margin-left">
  <div id="lob" hidden>
            <select class="uk-select" v-model="lob">
                <option>Liability</option>
                <option>Property</option>
            </select>
</div>
   <div>
    <a href="#" uk-toggle="target: #lob">{{ filterLabel }}</a>
    </div>
</div>
     <div v-if="error" class="uk-alert-danger" uk-alert>
        <a class="uk-alert-close" uk-close></a>
        <p style="text-align:center"> {{ error }} </p>
      </div>
<div v-if="syndicate" class="uk-card uk-card-default uk-card-hover uk-card-small uk-card-body uk-flex uk-flex-center uk-margin-left">
    <button v-if="!loading" @click="runReport"
            class="uk-button uk-button-primary" type="button">Run Report</button>
    <div v-if="loading" uk-spinner></div>

</div>


 </div>
   <hr>
    <SpreadSheet v-if="workbook" :sheet="worksheet" />
  </div>

</template>

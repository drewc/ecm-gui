<script setup>
import { ref, computed, onMounted } from 'vue'
import { post } from 'axios'
import  WorkBook from './WorkBook.vue'
import UIkit from 'uikit'
import { SQLStatement } from './../assets/sql/objects'
import './../assets/sql/spreadsheet'
import { saveWorkBook } from './../assets/SheetTemplate'

const props = defineProps({
    title: String,
    workbook: Object
})
const localworkbook = ref()
const workbook = computed(() => props.workbook || localworkbook.value)

// This "accordion" is simply to collapse the slot when run
const refAccordion = ref();
const accordion = ref();
const toggle = () => {
  console.log("toggle", accordion.value)
  UIkit.accordion(accordion.value).toggle(0,true)
}


const refModal = ref();

let loadingModal;

onMounted(() => {
 accordion.value = refAccordion.value
 loadingModal = refModal.value;
})

const report = ref()
const error = ref()
const loading = ref()

const toggleLoading = () => { loading.value = !loading.value
  const m = UIkit.modal(loadingModal);
  loading.value ? m.show() : m.hide();
  console.log(m, 'load')
 }
function runReport(uri, obj, title = props.title) {
  console.warn('Running', uri, 'with', obj)
  error.value = undefined
  loading.value = true
  UIkit.modal(loadingModal).show();
  post(uri, obj).then(res => {
    loading.value = false
    const stmt =  new SQLStatement(res.data);
    toggle()
    UIkit.modal(loadingModal).hide();
    report.value = stmt;
    localworkbook.value = stmt.spreadsheet(title).workbook

    // console.log('accordion', localworkbook.value)
    // window.TestBook = workbook.value

  }).catch( e => {error.value = e ;loading.value = false})
}

const saveReport =  () => {
 saveWorkBook(props.title + '.xlsx', workbook.value)
}
</script>

<template>
<div class="uk-card uk-card-default uk-card-small" >
  <ul uk-accordion class="ecm-single" ref="refAccordion">
    <li class="uk-open">
      <a class="uk-accordion-title uk-padding-small">
        <h2 class="uk-width-expand uk-text-center" style="margin:0;">{{ title || "Report"}}</h2> </a>
      <div  style="margin-top:0;margin-bottom:1em;"
        class="uk-accordion-content uk-card uk-card-default uk-card-body uk-width-xlarge uk-align-center">

      <fieldset class="uk-fieldset">
        <slot :toggle="toggle" :runReport="runReport"
              :toggleLoading="toggleLoading">
          This is where things will appear</slot>
      </fieldset>
      </div>
    </li>
  </ul>
</div>

<div id="modal-center" class="uk-flex-top" uk-modal
     ref="refModal">
  <div class="uk-modal-dialog uk-modal-body uk-margin-auto-vertical">

    <button class="uk-modal-close-default" type="button" uk-close></button>
    <div class="uk-align-right" uk-spinner="ratio: 3"></div>
    <h3> Running {{ title }} </h3>

  </div>
</div>
<div v-if="error" class="uk-alert-danger" uk-alert>
  <a class="uk-alert-close" uk-close></a>
  <p style="text-align:center"> {{ error }} </p>
</div>

<div v-if="workbook" class="uk-background-default uk-padding">
  <button @click="saveReport" class="uk-align-right uk-button"> Save Spreadsheet</button>
  <WorkBook :book="workbook" />
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
<style scoped>
  .ecm-single>.uk-open>.uk-accordion-title::before {
    background-image: unset;
  }
</style>

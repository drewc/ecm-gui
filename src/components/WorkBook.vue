<script setup>
import ExcelJS from 'exceljs'
import { ref, computed } from 'vue'
import numfmt from "numfmt";

import SpreadSheet from './SpreadSheet.vue'

const props = defineProps({
    book: Object
})

const sheets = ()=> {
  const ss = [];
  props.book.eachSheet((s, i) => {
   console.log('shheet', s, i);
   if (!!s) ss.push(s)  ;
  })
  return ss;
}

</script>

<template>
  <ul v-if="book" class="uk-subnav uk-subnav-pill" uk-switcher>
    <li v-for="sheet in sheets()">
      <a href="#">{{ sheet && sheet.name }}</a></li>
</ul>

<ul v-if="book" class="uk-switcher uk-margin">
    <li v-for="sheet in sheets()">
      <SpreadSheet :sheet="sheet"  class="uk-table uk-table-divider" />
      </li>
</ul>
</template>

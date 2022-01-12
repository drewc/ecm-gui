<script setup>
import ExcelJS from 'exceljs'
import { ref, computed } from 'vue'
import numfmt from "numfmt";

import RichText from './SpreadSheet/RichText.vue'

  // reusable function
  const str = '"£"#,##0.00;[Red]\-"£"#,##0.00';
  const num = 123567890.42
  const formatter = numfmt(str);
  const out = formatter(num)
  console.log(out);

  // ... or just
  const output = numfmt.format(str, 0 - num);
  console.log(output);

const props = defineProps({
    sheet: Object
})

const rows = computed(() => props.sheet.getRows(1, props.sheet.actualRowCount))
const cells = (row) => {
  const cs = []
  row.eachCell({ includeEmpty: true },function(cell, colNumber) {
    // console.log('Cell ' + colNumber + ' = ' + cell.value);
  cs.push([colNumber, cell])
  });

 return cs;

}

const argb2rgba = color =>
 '#' + color.argb.slice(2).concat(color.argb.slice(0,2))

const cellStyle = cell => {
  // console.log('num val', cell, cell.row, cell.value)
  const style = {}
  if (cell.value === null) { style.margin = 0; style.padding = 0 }
  const trans = {
    fill: (o) => {
      if (o.pattern !== 'none') {
        style.backgroundColor =  argb2rgba(o.fgColor)
        // console.log('Have pattern', o, style)
      }
    },
    font(f) {
      // console.log('funt', f)
      if (f.size) style.fontSize = '' + f.size + 'pt'
      if (f.color) style.color=argb2rgba(f.color)

      // console.log('funt', f, style)
    },
    border(b) {
      if (Object.keys(b).length > 0) style.borderStyle ="solid"
      Object.entries(b).forEach(([k,v]) => {
       //  console.log('Brder Etnry', k ,v)
        const start = 'border-'+k+'-'
        Object.entries(v).forEach(([k,v]) => {
        // console.log('Each B Enbtry', k, v)
          if (k === "style") {
            style[start+'width'] = v
         // console.log('weighin', style)
          } else if (k === 'color') {
            style[start+k] = argb2rgba(v)
          }

        })
      })
      // console.log('border:', style)
    }
  }

  Object.entries(cell.style).forEach(([k,v]) => {
    const t = trans[k]
     // console.log('looking for', k, 'found', t, 'have', v)
    if (t) t(v)
  })
  const formatter = numfmt(cell.numFmt);
  const numColour = isNaN(cell.value) ? false : formatter.color(cell.value)

  if (numColour) style.color = numColour;

  // console.log('Got style', style, 'from', cell.style)
  return style;
}


const formatCell = (cell) => {
  const v = cell.value
  if (!isNaN(v)) return numfmt.format(cell.numFmt, v);
  return v;
}

const isRichText = cell =>
      cell.value !== null &&
      typeof cell.value === "object" &&
      cell.value.richText


</script>

<template>
<table class="uk-table" style="border-collapse: collapse;">
  <tbody>
        <tr v-for="row in rows" :key="row.row">
          <td v-for="[n,v] in cells(row)"
              :style="cellStyle(v)"
              :key="v.address"
              :data-style="JSON.stringify(v.numFmt)">
            <rich-text v-if="isRichText(v)"
                       :rich-text="v.value.richText" />
            <template v-else>
              {{formatCell(v)}}
              </template>
                      </td>
        </tr>
    </tbody>
</table>

</template>

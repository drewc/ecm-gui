<template>
<m-expansion-item
   v-bind="$attrs">
  <template slot="header">
      <div style="width:100%" class="text-center row " v-if="value">
        <div class="vertical-middle col-md-1 cl-sm-2 self-center">
          <q-icon name="assessment"
                  style="font-size: 150%"
                  color="secondary" /> &nbsp;
        </div>
         <div class="col-shrink" >
             <span style="font-size:150%">Balance</span>
             <b>&nbsp;</b>
           </div>
         <div class="col-sm-grow col-xs-12 text-center" >
           <big>
             <span class="text-weight-thin"> incurred&nbsp;</span>${{ value.incurred }}
             <span class="text-weight-thin"> deductible&nbsp;</span>${{ value.deductible}}
           </big>
         </div>
      </div>
  </template>
  <masonry v-if="value">
    <m-brick>
      <m-expansion-item default-opened>
        <template slot="header">
          <div class="row" style="width:100%;padding:0px;">
            <div class="col-md-shrink col-xs-12 text-h6">
              Headings&nbsp;
            </div>
            <div class="col-md col-xs-11 offset-xs-1 self-center text-center">
              <big :style="headingStyle()">
                <span class="text-weight-thin">limit&nbsp;of&nbsp;cover </span>${{ value.limit_of_cover }}
                <span class="text-weight-thin">outstanding&nbsp;reserve&nbsp;</span>${{ value.outstanding_reserve }}
                <span class="text-weight-thin">total&nbsp;paid&nbsp;</span>${{ value.total_paid }}
              </big>
            </div>
          </div>
        </template>
      <q-separator/>
        <q-markup-table wrap-cells dense flat separator="vertical">
          <tr style="text-align:left"> <th>Heading</th><th>Limit of Cover</th><th>Outstanding Reserve</th><th>Total Paid</th></tr>
          <tr> <td colspan="4"> <q-separator/></td></tr>
          <tr v-for="item in value.headings" :key="item.heading">
            <td>{{item.heading}}</td>
            <td><template v-if="item.limit_of_cover">${{item.limit_of_cover}}</template></td>
            <td>${{item.outstanding_reserve}}</td>
            <td>${{item.total_paid}}</td>
          </tr>
          <tr>
            <th style="border-top: 1px dotted black"> TOTAL: </th>
            <td style="border-top: 1px dotted black"> <template v-if="value.limit_of_cover"> ${{ value.limit_of_cover }} </template></td>
            <td style="border-top: 1px dotted black">${{ value.outstanding_reserve }} </td>
            <td style="border-top: 1px dotted black">${{ value.total_paid }} </td>
          </tr>
        </q-markup-table>
      </m-expansion-item>
    </m-brick>

  <m-brick>
    <q-item>
      <div class="row" style="width:100%;">
        <div class="col-md-2 col-xs-3 text-h6">Deductible&nbsp;</div>
        <span v-if="$q.screen.gt.sm">&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <div class="col self-center vertical-middle text-left">
          <big> ${{ value.deductible }} </big>
          <big :style="headingStyle()">
            <span class="text-weight-thin"> outstanding&nbsp;</span>${{ value.outstanding_deductible}}
            <br v-if="$q.screen.xs"/>
            <span class="text-weight-thin"> recovered&nbsp;</span>${{ value.recovered_deductible}}
          </big>
        </div>
        <div v-if="$q.screen.gt.sm" class="col-1"> </div>
      </div>
    </q-item>
  </m-brick>
  <m-brick>
    <q-item>
      <div class="row" style="width:100%;">
        <div class="col-md-2 col-xs-3 text-h6">Authority&nbsp;</div>
        <span v-if="$q.screen.gt.sm">&nbsp;&nbsp;&nbsp;&nbsp;</span>
        <div  class="col self-center vertical-middle text-left">
          <big> ${{ authorityBalance() }} </big>
       <big :style="headingStyle()">
            <span class="text-weight-thin"> actual&nbsp;</span>${{ value.authority.actual }}
            <br v-if="$q.screen.xs"/>
            <span class="text-weight-thin"> contract&nbsp;</span>${{ value.authority.contract }}
            <br v-if="$q.screen.xs"/>
            <span class="text-weight-thin"> claim&nbsp;</span>${{ value.authority.claim}}
       </big>
        </div>
        <div v-if="$q.screen.gt.sm" class="col-1"> </div>
      </div>
    </q-item>
  </m-brick>
  </masonry>
</m-expansion-item>
</template>
<script>
export default {
  name: 'Balance',
  props: ['value'],
  methods: {
    headingStyle () { if (this.$q.screen.lt.md) { return 'font-size: 120%' } else { return '' } },
    authorityBalance () { return this.value.authority.actual - this.value.incurred }
  }
}
</script>

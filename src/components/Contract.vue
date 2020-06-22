<template>
 <m-expansion-item
   default-opened
   >
   <template slot="header">
     <div class="row" style="width:100%;padding:0px;">
       <div class="col-shrink text-h6 "> Contract &nbsp; </div>
       <div class="col self-center text-center">
         <router-link class="" v-if="link" :to="{ path: '/contract/' + value.contract_id, query: { backToClaim: backToClaim } }">
           <big>{{ value.contract_number }}</big>
         </router-link>
         <big v-else>{{ value.contract_number }}</big>
         &nbsp;&nbsp;{{value.effective_date}}
         <small class="text-weight-thin"> to </small>
         {{ value.expiry_date }}
       </div>
     </div>
   </template>
   <q-separator/>
   <q-markup-table wrap-cells dense flat separator="vertical">
     <tbody>
       <tr v-if="value.syndicate">
         <th class="text-left">&nbsp;Syndicate&nbsp;</th>

         <td class="text-center">
           <router-link :to="{ path: '/person/' + value.syndicate.person_id,
                             query: { backToClaim: backToClaim } }">
             {{ value.syndicate.full_name }}
           </router-link>

         </td>
       </tr>
       <tr v-if="value.london_broker">
         <th class="text-left">&nbsp;Broker&nbsp;</th>

         <td class="text-center">
           <router-link :to="{ path: '/person/' + value.london_broker.person_id,
                             query: { backToClaim: backToClaim } }">
             {{ value.london_broker.full_name }}
           </router-link>

         </td>
       </tr>
       <tr v-if="value.agency">
         <th class="text-left">&nbsp;Agency&nbsp;</th>

         <td class="text-center">
           <router-link :to="{ path: '/person/' + value.agency.person_id,
                             query: { backToClaim: backToClaim } }">
             {{ value.agency.full_name }}
           </router-link>

         </td>
       </tr>

     </tbody>
   </q-markup-table>
 </m-expansion-item>
</template>
<script>
// import Risk from 'components/Risk'
export default {
  name: 'Contract',
  // components: { Risk },
  props: { value: Object, link: Boolean, backToClaim: Number, masonry: Boolean },
  methods: {
    reveal () { this.$ecm.revealComp(this) },
    raise () { this.$ecm.raiseComp(this) }
  }
}
</script>

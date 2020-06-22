<template>

 <m-expansion-item
   :default-opened="false"
   >
   <template slot="header">
     <div class="row" style="width:100%;padding:0px;">
     <q-tooltip v-if="value.loss_code">
      {{ value.loss_code.description }}
     </q-tooltip>
       <div class="col-shrink text-h6">
         Loss&nbsp;
       </div>
       <div class="col self-center vertical-middle text-center">
         <big v-if="link">
           <router-link  :to="{ path: '/loss/' + value.loss_id, query: { backToClaim: backToClaim } }">
             {{ value.date }}
             <template v-if="value.loss_code">
               <span class="text-weight-thin"> code&nbsp;</span>{{ value.loss_code.code }}
             </template>
           </router-link>
         </big>
         <big v-else>
           {{ value.loss_type }}
           <template v-if="value.loss_code">
             <span class="text-weight-thin"> code&nbsp;</span>{{ value.loss_code.code }}
           </template>
         </big>

       </div>
     </div>

   </template>
     <q-separator/>
    <q-markup-table wrap-cells dense flat separator="vertical">
     <tbody>
       <tr>
         <th class="text-left">&nbsp;Date&nbsp;of&nbsp;Loss&nbsp;</th>
         <td class="text-center"> {{ value.date }} </td>
       </tr>
       <tr v-if="value.description">
         <th class="text-left">&nbsp;Description&nbsp;</th>
         <td class="text-center"> {{ value.description }} </td>
       </tr>
       <tr>
         <th class="text-left">&nbsp;Location&nbsp;</th>
         <td class="text-center">
           <div>{{ value.location.line1 }}</div>
           <div>{{ value.location.line2 }}</div>
           <div>{{ value.location.city }}, {{ value.location.province }}, {{ value.location.country}}</div>
           <div>{{ value.location.postal_code }}</div>
         </td>
       </tr>
     </tbody>
   </q-markup-table>
 </m-expansion-item>
</template>
<script>

export default {
  name: 'Loss',
  props: { value: Object, backToClaim: Number, link: Boolean, subscription: Number, masonry: Boolean },
  methods: {
    reveal () { this.$ecm.revealComp(this) },
    raise () { this.$ecm.raiseComp(this) }
  }
}
</script>

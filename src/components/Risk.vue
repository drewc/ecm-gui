<template>

 <m-expansion-item :default-opened="false">
   <template slot="header">
     <div class="row" style="width:100%;padding:0px;">
       <q-tooltip v-if="value.code && value.code.description">
         {{ value.code.description }}
       </q-tooltip>
       <div class="col-md-shrink col-xs-3 text-h6">
         Risk &nbsp;
       </div>
       <div class="col-md-grow col-xs-9 self-center vertical-middle text-center">
         <big v-if="link">
           <router-link  :to="{ path: '/risk/' + value.risk_id, query: { backToClaim: backToClaim } }">
             {{ value.risk_type }}
           </router-link>
         </big>
         <big v-else>
           {{ value.risk_type }}
         </big>
         <big v-if="value.code">
           <span class="text-weight-thin"> code&nbsp;</span>{{ value.code.code }}
         </big>
         <big v-if="subscription">
           {{ subscription }}%
         </big>
       </div>
     </div>
   </template>
    <q-separator/>
    <q-card bordered flat class="masonry-brick-in" v-if="value.policy">
      <policy v-model="value.policy" :masonry="true" pass-attr="yay"
              :link="true" :back-to-claim="backToClaim" />
    </q-card>

    <q-card bordered flat class="masonry-brick-in" v-if="value.contract">
      <contract v-if="value.contract" v-model="value.contract" :masonry="true"
                :link="true" :back-to-claim="backToClaim" />
     </q-card>

 </m-expansion-item>
</template>
<script>
import Policy from 'components/Policy'
import Contract from 'components/Contract'

export function riskTree (risk) {
  return 1
}

export default {
  name: 'Risk',
  props: {
    value: Object,
    backToClaim: Number,
    link: Boolean,
    subscription: Number,
    masonry: Boolean
  },
  methods: {
    reveal () { this.$ecm.revealComp(this) },
    raise () { this.$ecm.raiseComp(this) }
  },
  components: { Policy, Contract }
}
</script>

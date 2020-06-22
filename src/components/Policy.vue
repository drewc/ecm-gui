<template>
  <m-expansion-item
    default-opened
    >
    <template slot="header" >
      <div class="row" style="width:100%;padding:0px;">
        <div class="col-2 text-h6">
          Policy &nbsp;
        </div>

        <div class="col text-center">
          <router-link v-if="link" :to="{ path: '/policy/' + value.policy_id, query: { backToClaim: backToClaim } }">
            <big>{{ value.policy_number }}</big>
          </router-link>
          <big v-else>{{ value.policy_number }}</big>
          <br v-if="$q.screen.lt.md"/><template v-else>&nbsp;&nbsp;</template>{{value.effective_date}}  <small class="text-weight-thin"> to </small>{{ value.expiry_date }}
        </div>
      </div>
    </template>
    <q-separator/>
    <q-markup-table wrap-cells dense flat separator="vertical">
      <tbody>
        <tr v-if="value.insured">
          <th class="text-left"><span>Insured </span></th>
          <td class="text-center">
            <router-link class="text-center" :to="{ path: '/person/' + value.insured_id,
                              query: { backToClaim: backToClaim } }">
              {{ value.insured.full_name }}
            </router-link>
          </td>
        </tr>
        <tr v-if="value.agency_office">
          <th  class="text-left">&nbsp;Office&nbsp;</th>
          <td class="text-center">
            <router-link :to="{ path: '/person/' + value.agency_office.person_id,
                              query: { backToClaim: backToClaim } }">
              {{ value.agency_office.full_name }}
            </router-link>
          </td>
        </tr>
        <tr v-if="value.agent">
             <th class="text-left">&nbsp;Agent&nbsp;</th>
             <td class="text-center">
               <router-link :to="{ path: '/person/' + value.agent.person_id,
                                 query: { backToClaim: backToClaim } }">
                 {{ value.agent.full_name }}
               </router-link>
             </td>
           </tr>
           <tr v-if="value.insurance_company">
             <th class="text-left">&nbsp;Company&nbsp;</th>
             <td class="text-center">
               <router-link :to="{ path: '/person/' + value.insurance_company.person_id,
                                 query: { backToClaim: backToClaim } }">
                 {{ value.insurance_company.full_name }}
               </router-link>
             </td>
           </tr>
           <tr v-if="value.risks">
             <q-tree
               :nodes="value.risks"
               node-key="risk_id"
               >
               <template v-slot:default-header="prop">
                 <risk v-model="prop.node" />
               </template>
               <template v-slot:default-body="prop">
                 <risk v-model="prop.node" />
               </template>
             </q-tree>
  </tr>
  <!-- <div class="col"> {{ value }} </div> -->

      </tbody>
    </q-markup-table>
 </m-expansion-item>
</template>
<style>

a:hover, a:visited:hover {
    color: #2255EE;
}

a:before {
    content: '';
    border-bottom: solid 1px  #2255EE;
    position: absolute;
    bottom: 0; left: 0;
    width: 100%;
    opacity: 0;
}

a:hover:before {
    opacity: 0.6;
}

 a, a:before {
    -webkit-transition: all 0.2s ease;
    transition: all 0.2s ease;
}

 .q-table tbody td:before {
  background: unset!important;
 }

a:visited {
    color: black;
}
</style>
<script>
import Risk from 'components/Risk'
export default {
  name: 'Policy',
  components: { Risk },
  props: { value: Object, link: Boolean, backToClaim: Number, masonry: Boolean },
  methods: {
    reveal () { this.$ecm.revealComp(this); console.log(this.$attrs) },
    raise () { this.$ecm.raiseComp(this) }
  }
}
</script>

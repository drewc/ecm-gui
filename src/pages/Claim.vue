<template>
<div v-if="claim" class="q-pa-md row items-start q-gutter-md full-width">
  <q-list bordered class="full-width">
    <m-expansion-item header-class="bg-white" class="bg-blue-1">
      <template slot="header">
        <div style="width:100%" class="text-center row" v-if="claim.status">
          <div class="vertical-middle col-md-1 cl-sm-2 self-center">
            <q-icon name="local_library"
                    color='primary'
                    style="font-size: 150%" /> &nbsp;
          </div>
          <div class="col-sm-shrink col-xs-10 text-center self-center vertical-middle" >
            <span class="text-weight-thin" style="font-size:150%"> Claim#<b>&nbsp;{{ claim.claim_id }}</b>
            </span>
            <b>&nbsp;</b>
          </div>
          <div class="col-sm col-xs-10 self-center text-center" >
            <span style="font-size:150%">
              <span class="text-weight-thin"> Status&nbsp;</span>{{ claim.status }}
              <div :class="$q.screen.gt.xs ? 'risk-inline' : 'risk-insured-name'" v-if="claim.risk">
                <span v-if="$q.screen.gt.xs" class="text-weight-thin"> Insured&nbsp;</span>
                {{ claim.risk.policy.insured.full_name }}
              </div>
            </span>
            <div class="text-subtitle2">
              <span class="text-weight-thin"> DoL&nbsp;</span>{{ claim.date_of_loss }}
              <div  v-if="claim.risk" style="display: inline-block">
                <span class="text-weight-thin"> Contract&nbsp;</span>{{ claim.risk.contract.contract_number }}</div>
              <div  v-if="claim.risk.contract.agency" style="display: inline-block">
                <span class="text-weight-thin"> Agency&nbsp;</span>{{ claim.risk.contract.agency.full_name }}</div>
              <template v-if="claim.risk.contract.syndicate">
                <span class="text-weight-thin"> Syndicate&nbsp;</span>{{ claim.risk.contract.syndicate.full_name }}
              </template>
            </div>
          </div>
        </div>
      </template>
      <hr style="margin:0.25em; visibility:hidden;" />
      <masonry ref="claimMason">
        <div class="masonry-item" v-if="claim.risk">
          <div class="masonry-content">
            <risk
              v-model="claim.risk"
              :masonry="true"
              :link="true" :back-to-claim="claim.claim_id"
              :subscription="claim.subscription_percent"/>
          </div>
        </div>
        <div class="masonry-item" v-if="claim.loss">
          <div class="masonry-content">
            <loss v-model="claim.loss" :masonry="true" :link="true" :back-to-claim="claim.claim_id" />
          </div>
        </div>
        <div class="masonry-item" v-if="claim.cause">
          <div class="masonry-content">
            <q-item>
              <div class="row" style="width:100%;">
                <div class="col-shrink text-h6">Cause&nbsp; </div>
                <span v-if="$q.screen.gt.sm">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                <div class="col self-center vertical-middle text-center">
                  <big> {{ claim.cause.description }}
                    <br v-if="$q.screen.xs"/>
                    <span class="text-weight-thin"> code&nbsp;</span>{{ claim.cause.code}}
                  </big>
                </div>
                <div v-if="$q.screen.gt.sm" class="col-1"> </div>
              </div>
            </q-item>
          </div>
        </div>
        <div class="masonry-item">
          <div class="masonry-content">
            <m-expansion-item
              :default-opened="false"
              >
              <template slot="header">
                <div class="row" style="width:100%;padding:0px;">
                  <div class="col-sm-shrink col-xs-3 text-h6 text-left">
                    Examiner
                  </div>
                  <div class="col-sm col-xs-grow text-center">
                     <template v-if="$q.platform.is.iphone">&nbsp; &nbsp;  &nbsp; &nbsp; </template>
                    <big>
                      <router-link v-if="claim.examiner"  :to="{ path: '/person/' + claim.examiner.person_id, query: { backToClaim: claim.claim_id } }">
                        {{ claim.examiner.short_name }}
                      </router-link>
                      <span v-else> None </span>
                     </big>
                  </div>
                </div>

              </template>
            <q-separator/>
                <q-markup-table wrap-cells dense flat separator="vertical">
                  <tbody>
                    <tr v-if="claim.adjuster">
                      <th class="text-left"><span>Adjuster </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.adjuster.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.adjuster.full_name }}
                        </router-link>
                      </td>
                    </tr>
                    <tr v-if="claim.claimant">
                      <th class="text-left"><span>Claimant </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.claimant.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.claimant.full_name }}
                        </router-link>
                      </td>
                    </tr>
                    <tr v-if="claim.coverage_counsel">
                      <th class="text-left"><span>Coverage&nbsp;Counsel </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.coverage_counsel.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.coverage_counsel.full_name }}
                        </router-link>
                      </td>
                    </tr>
                    <tr v-if="claim.defense_counsel">
                      <th class="text-left"><span>Defense&nbsp;Counsel </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.defense_counsel.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.defense_counsel.full_name }}
                        </router-link>
                      </td>
                    </tr>
                    <tr v-if="claim.restoration_firm_emergency">
                      <th class="text-left"><span>Restoration&nbsp;Firm (emergency) </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.restoration_firm_emergency.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.restoration_firm_emergency.full_name }}
                        </router-link>
                      </td>
                    </tr>
                    <tr v-if="claim.restoration_firm_repair">
                      <th class="text-left"><span>Restoration&nbsp;Firm (repair) </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.restoration_firm_repair.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.restoration_firm_repair.full_name }}
                        </router-link>
                      </td>
                    </tr>
                  </tbody>
              </q-markup-table>
            </m-expansion-item>
          </div>
        </div>
        <div class="masonry-item">
          <div class="masonry-content">
            <m-expansion-item
              :default-opened="false" v-if="claim.metadata"
              >
              <template slot="header">
                <div class="row" style="width:100%;padding:0px;">
                  <div class="col-sm-shrink col-xs-3 text-h6 text-left">
                   Meta
                  </div>
                 <div  class="col-sm col-xs-9 text-center">
                   <big>
                     {{ claim.metadata.status }}
                   </big>
                    <big v-if="claim.metadata.lineage">
                     <span class="text-weight-thin">lineage&nbsp;</span>{{ claim.metadata.lineage }}
                     </big>
                    <big v-else-if="claim.metadata.refer_to_underwriters">
                      <span class="text-weight-thin"> Refer&nbsp;to&nbsp;Underwriters</span>
                     </big>
                    <big v-else-if="claim.metadata.line_of_business" class="col-xs-grow">
                     <span class="text-weight-thin">line&nbsp;of&nbsp;business&nbsp;</span>{{ claim.metadata.line_of_business }}
                     </big>
                    <big v-else-if="claim.metadata.industry_code">
                     <span class="text-weight-thin">industry</span>
                       {{ claim.metadata.industry_code.industry }} {{ claim.metadata.industry_code.industry_classification }}
                    </big>
                    <big v-else-if="claim.metadata.import">
                     <span class="text-weight-thin">import</span>
                        <template v-if="claim.metadata.import.date"> {{ claim.metadata.import.date}} </template>
                          {{ claim.metadata.import.from}} #{{ claim.metadata.import.number}}
                    </big>
                  </div>
                </div>

              </template>
            <q-separator/>
                <q-markup-table wrap-cells dense flat separator="vertical">
                  <tbody>
                    <tr v-if="claim.metadata.line_of_business">
                      <th class="text-left">Line&nbsp;of&nbsp;Business</th>
                      <td class="text-center"> {{ claim.metadata.line_of_business }}
                      </td>
                    </tr>
                    <tr v-if="claim.metadata.coverage">
                      <th class="text-left">Coverage</th>
                      <td class="text-center"> {{ claim.metadata.coverage}}
                      </td>
                    </tr>
                    <tr v-if="claim.metadata.peer_reviewed">
                      <th class="text-left">Peer&nbsp;Reviewed</th>
                      <td class="text-center"> {{ claim.timeline.peer_reviewed}}
                      </td>
                    </tr>
                    <tr v-if="claim.metadata.refer_to_underwriters">
                      <th class="text-left">Refer&nbsp;to&nbsp;Underwriters</th>
                      <td class="text-center"> {{ claim.metadata.refer_to_underwriters}}
                      </td>
                    </tr>
                    <tr v-if="claim.metadata.open_for_recovery">
                      <th class="text-left">Open&nbsp;for&nbsp;Recovery</th>
                      <td class="text-center"> <span class="text-weight-thin">Recovery/Subrogation</span> {{ claim.timeline.recovery_subrogation }}
                      </td>
                    </tr>
                    <tr v-if="claim.metadata.industry_code">
                      <th class="text-left">IBC Industry</th>
                      <td class="text-center">
                       {{ claim.metadata.industry_code.industry }} {{ claim.metadata.industry_code.industry_classification }}
                         {{ claim.metadata.industry_code.description }}
                      </td>
                    </tr>
                    <tr v-if="claim.metadata.import">
                      <th class="text-left">Import</th>
                      <td class="text-center">
                        <template v-if="claim.metadata.import.date"> {{ claim.metadata.import.date}} </template>
                          {{ claim.metadata.import.from}} #{{ claim.metadata.import.number}}
                      </td>
                    </tr>
                    <tr v-if="claim.claimant">
                      <th class="text-left"><span>Claimant </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.claimant.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.claimant.full_name }}
                        </router-link>
                      </td>
                    </tr>
                    <tr v-if="claim.coverage_counsel">
                      <th class="text-left"><span>Coverage&nbsp;Counsel </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.coverage_counsel.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.coverage_counsel.full_name }}
                        </router-link>
                      </td>
                    </tr>
                    <tr v-if="claim.defense_counsel">
                      <th class="text-left"><span>Defense&nbsp;Counsel </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.defense_counsel.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.defense_counsel.full_name }}
                        </router-link>
                      </td>
                    </tr>
                    <tr v-if="claim.restoration_firm_emergency">
                      <th class="text-left"><span>Restoration&nbsp;Firm (emergency) </span></th>
                      <td class="text-center">
                        <router-link class="text-center" :to="{ path: '/person/' + claim.restoration_firm_emergency.person_id,
                                                              query: { backToClaim: claim.claim_id } }">
                          {{ claim.restoration_firm_emergency.full_name }}
                        </router-link>
                      </td>
                    </tr>
                  </tbody>
              </q-markup-table>

            </m-expansion-item>
          </div>
        </div>
        <div class="masonry-item">
          <div class="masonry-content">
            <m-expansion-item
              :default-opened="false" v-if="claim.timeline"
              >
              <template slot="header">
                <div class="row" style="width:100%;padding:0px;">
                  <div class="col-sm-shrink col-xs-3 text-h6 text-left">
                   Timeline
                  </div>
                 <div  class="col-sm col-xs-9 text-center" v-if='timeline' >
                   <big>
                     {{ timeline[0].name }} {{ $ecm.date.formatDate(timeline[0].date, 'YYYY-MM-DD') }}
                   </big>
                  </div>
                </div>
              </template>
            <q-separator/>
                <q-markup-table wrap-cells dense flat separator="vertical">
                  <tbody>
                    <tr v-for="item in timeline.slice().reverse()" :key="item.name">
                      <th class="text-left">{{ item.name }}</th>
                      <td class="text-center"> {{ $ecm.date.formatDate(item.date, 'YYYY-MM-DD HH:MM:SS ZZ') }} </td>
                    </tr>
                  </tbody>
              </q-markup-table>

            </m-expansion-item>
          </div>
        </div>
        <hr style="margin:0.25em; visibility:hidden;" />
      </masonry>
    </m-expansion-item>

    <balance v-model="claim.balance"
             header-class="bg-white no-box-shadow"
             class="bg-white"
             />
    <m-expansion-item header-class="bg-white no-box-shadow">
      <template slot="header">
        <div style="width:100%" class="text-center row" v-if="claim.status">
          <div class="vertical-middle col-md-1 cl-sm-2 self-center">
            <q-icon name="attach_email"
                    color="deep-purple-6"
                    style="font-size: 150%" /> &nbsp;
          </div>
          <div class="col-sm-shrink col-xs-10 text-center self-center" >
            <span style="font-size:150%"> Attachments</span>
            <b>&nbsp;</b>
          </div>
          <div class="col-sm col-xs-12 text-center" >
          </div>
        </div>
      </template>

      <q-table
       :pagination="{ rowsPerPage: 0 }"
        dense wrap-cells hide-bottom flat
        class="my-sticky-header-table"
        table-header-class="bg-deep-purple-2"
        v-if="attachments"
        :data="attachments"
        :columns="attachment_columns"
        row-key="sha1"
        />
    </m-expansion-item>
      <m-expansion-item header-class="q-card no-box-shadow full-width">
       <template slot="header">
         <div style="width:100%" class="text-center row" v-if="claim.status">
           <div class="vertical-middle col-md-1 cl-sm-2 self-center">
             <q-icon name="local_atm"
                     color="green"

                     style="font-size: 185%" /> &nbsp;
           </div>
           <div class="col-sm-shrink col-xs-10 text-center self-center" >
             <span style="font-size:150%">Transactions</span>
             <b>&nbsp;</b>
           </div>
           <div class="col-sm col-xs-12 self-center text-center" >
             <div :class="transaction_menu_class">
           <q-btn
             flat round dense
             :icon="transactions_fullscreen ? 'fullscreen_exit' : 'fullscreen'"
             @click.stop="toggleThis('transactions_fullscreen')"
             /></div>
          <big>
           <span class="text-weight-thin" v-if="$q.screen.gt.xs">outstanding&nbsp;</span><span class="text-weight-thin">reserve&nbsp;</span>${{ claim.balance.outstanding_reserve }}
           <span class="text-weight-thin">total&nbsp;paid&nbsp;</span>${{ claim.balance.total_paid }}
          </big>
           </div>

         </div>

    </template>

       <q-table
         ref="transactionTable"
         dense wrap-cells
         class="my-sticky-header-table"
         table-header-class="bg-green-2"
         hide-bottom
         :fullscreen="transactions_fullscreen"
         :pagination="{ rowsPerPage: 0 }"
         v-if="transactions"
         :data="transactions"
         :columns="transactions_columns"
         row-key="transaction_id"
         >
         <template v-slot:header="props">
          <q-overlay v-model="new_transaction_overlay" z-index="2046">
             <template #body>
               <div class="fullscreen row justify-evenly items-center"
                    @click.stop="new_transaction_overlay = false">
                 <q-card :style="newTransactionStyle" class="text-center" @click.stop.prevent >
                  <q-card-section>
                    <div class="text-h6">Create New Transaction</div>
                  </q-card-section>
                  <q-separator />

                  <q-card-section>
                  <!-- * Here's the EditTransaction -->
                    <edit-transaction v-model="new_transaction"
                                      @cancel="() => { new_transaction = {}; new_transaction_overlay = false; }"
                                      @submit="(t) => submitTransaction(t)"/>
                  </q-card-section>
                 </q-card>
               </div>
             </template>
           </q-overlay>
          <q-tr :props="props" class='bg-green-2'>
             <q-th auto-width>
               <q-btn-group unelevated rounded dense >
                 <q-btn size="sm" icon="add" color="secondary" round
                        @click.stop="newTransactionOverlay()"
                        @submit="submitTransaction"
                        @cancel="cancelTransaction"
                        >
                   <q-tooltip anchor="center right"
                              self="center left"
                              :offset="[10, 10]"
                             content-class="bg-secondary">Add New Transaction</q-tooltip>
                 </q-btn>
                 <q-btn color="secondary" size="sm" round
                        :icon="transactions_fullscreen ? 'fullscreen_exit' : 'fullscreen'"
                        @click="toggleThis('transactions_fullscreen')"
                        >
                   <q-tooltip anchor="center right" self="center left" :offset="[10, 10]">
                    {{  transactions_fullscreen ? 'Exit ' : ''}} Fullscreen
                   </q-tooltip>
                 </q-btn>
               </q-btn-group>
             </q-th>
             <q-th
               v-for="col in props.cols"
               :key="col.name"
               :props="props"
               >
               {{ col.label }}
             </q-th>
           </q-tr>
         </template>

    <template v-slot:body="props">
      <q-tr :props="props" :class="props.row.highlight ? 'highlight' : ''">
        <q-td auto-width> <a :data-transaction-id="props.row.transaction_id"></a>
          <q-btn size="sm" color="secondary" round dense
                 @click="props.expand = !props.expand"
                 :icon="props.expand ? 'remove' : 'request_quote'" />
        </q-td>
        <q-td
          v-for="col in props.cols"
          :key="col.name"
          :props="props"
        >
          <template v-if="col.name == 'amount'">$&nbsp;</template>{{ col.value }}
        </q-td>
      </q-tr>
      <q-tr v-if="props.row.cheque" v-show="props.expand" :props="props">
        <q-td colspan="100%">
          <q-markup-table wrap-cells dense flat separator="vertical">
         <tbody>
           <tr>
             <th class="text-left">Cheque #</th>
             <td class="text-center"> {{ props.row.cheque.cheque_number }} </td>
           </tr>
         </tbody>
     </q-markup-table>

          <div class="text-left">This is expand slot for row above: {{ props.row }}.</div>
        </q-td>
      </q-tr>
    </template>
       </q-table>
     </m-expansion-item>

      <m-expansion-item header-class="q-card no-box-shadow full-width">
        <template slot="header">
          <div style="width:100%" class="text-center row" v-if="claim.status">
            <div class="vertical-middle col-md-1 cl-sm-2 self-center">
              <q-icon name="local_library"
                      style="font-size: 150%" /> &nbsp;
            </div>
            <div class="col-sm-shrink col-xs-10 text-center self-center" >
              <span style="font-size:150%"> Timecards</span>
              <b>&nbsp;</b>
            </div>
            <div class="col-sm col-xs-12 text-center" >
            </div>
          </div>
        </template>
        <q-table
          dense
          :pagination="{ rowsPerPage: 0 }"
          wrap-cells
          class="my-sticky-header-table"
          table-header-class="bg-green-2"
          hide-bottom
          v-if="attachments"
          :data="attachments"
          :columns="attachment_columns"
          row-key="sha1"
      />
    <!-- {{ attachments }} -->
  </m-expansion-item>

  </q-list>

</div>
</template>
<style lang="scss">

.bg-blue-1-hover:hover {
   background-color: $blue-1
}

.q-table tbody th {
    width:7.5vw;
}

.risk-inline {
   display: inline
 }
.risk-insured-name {
    display:inline-block;
    max-height: 20vh;
    overflow:hidden;
    text-overflow: ellipsis;
}
.risk-insured-name:hover {
    overflow:visible;
}
.masonry-brick-in {
    margin: 0.5vh;
}

.claim-bg {
  background-color: $blue-grey-1;
}
a {
    color: $blue-10;
    text-decoration: none;
    position: relative;
    display: inline-block;
}

a:visited {
    color: $indigo-10;
}

.my-sticky-header-table.fullscreen {
 max-height: 100vh;
}

 @keyframes highlight {
  0% {background-color: transparent;}
  50% {background-color: $green-1;}
  100% {background-color: transparent;}
}

.highlight {
  animation-name: highlight;
  animation-duration: 3.5s;
}

</style>
<style lang="sass">
.my-sticky-header-table
  /* height or max-height is important */
  max-height: 40vh

  thead tr th
    position: sticky
    z-index: 1
  thead tr:first-child th
    top: 0

  /* this is when the loading indicator appears */
  &.q-table--loading thead tr:last-child th
    /* height of all previous header rows */
    top: 48px
</style>
<script>
import Risk from 'components/Risk'
import Loss from 'components/Loss'
import Balance from 'components/Balance'
import EditTransaction from 'components/EditTransaction'

export default {
  name: 'Claim',
  props: { id: String },
  components: { Risk, Loss, Balance, EditTransaction },
  data () {
    return {
      claim: false,
      error: false,
      expand_cache: false,
      timeline: false,
      attachments: false,
      attachments_fullscreen: false,
      attachment_columns: [
        { field: 'date',
          name: 'date',
          format: (v) => this.$ecm.date.formatDate(v, 'YYYY-MM-DD'),
          label: 'Date',
          align: 'left',
          sortable: true
        },
        { field: 'description',
          name: 'description',
          label: 'Description',
          align: 'left',
          sortable: true
        },
        { field: 'filename',
          name: 'filename',
          label: 'File Name',
          align: 'center',
          classes: 'text-left',
          headerClasses: 'text-center',
          sortable: true
        }
      ],

      // Transacions

      transactions: false,
      new_transaction_overlay: false,
      new_transaction: {},
      transactions_fullscreen: false,
      transaction_select_values: false,
      // transaction_visable: [
      //   'date', 'type', 'heading',
      //   'expense_type', 'amount', 'payee'
      // ],
      transactions_columns: [
        { field: 'date',
          name: 'date',
          format: (v) => this.$ecm.date.formatDate(v, 'YYYY-MM-DD HH:MM'),
          label: 'Date',
          align: 'left',
          sortable: true
        },
        // { field: 'transaction_id',
        //   name: 'transaction_id',
        //   label: '#',
        //   align: 'left',
        //   sortable: true
        // },
        { field: 'type',
          name: 'type',
          // format: (v) => this.$ecm.date.formatDate(v, 'YYYY-MM-DD HH:MM:SS'),
          label: 'Type',
          align: 'left',
          sortable: true
        },
        { field: 'heading',
          name: 'heading',
          label: 'Heading',
          align: 'left',
          sortable: true
        },
        { field: 'amount',
          name: 'amount',
          label: 'Amount',
          align: 'left',
          sortable: true
        },
        { field: row => row.type === 'Open Reserve' && row.limit_of_cover ? 'Limit of Cover $' + row.limit_of_cover : row.expense_type,
          name: 'expense_type',
          label: 'Expense',
          sortable: true,
          align: 'left',
          autoWidth: true
        },
        { field: row => row.cheque ? row.cheque.cheque_number : undefined,
          name: 'cheque_number',
          label: 'Cheque #',
          align: 'left',
          sortable: true
        },
        { field: row => (row.cheque && row.cheque.payee) ? row.cheque.payee.full_name : undefined,
          name: 'payee',
          label: 'Payee',
          align: 'left',
          sortable: true
        },
        { field: row => row.cheque ? row.cheque.reference_number : undefined,
          name: 'reference_number',
          label: 'Reference #',
          align: 'left',
          sortable: true
        },
        { field: row => row.cheque ? row.cheque.schemes_advance_number : undefined,
          name: 'schemes_advance_number',
          label: 'Schemes Advance Number #',
          align: 'left',
          sortable: true
        }
      ]

    }
  },
  computed: {
    newTransactionStyle () {
      let width = '95%'
      return { width: width, maxWidth: '1024px' }
    },
    cardContainerClass () {
      if (this.$q.screen.gt.xs) {
        return 'grid-masonry grid-masonry--' + (this.$q.screen.gt.sm ? '3' : '2')
      }

      return void 0
    },
    transaction_menu_class () {
      let c = this.$q.screen.gt.sm ? 'absolute' : 'inline float-left'
      return c
    }
  },
  methods: {
    submitTransaction (tran) {
      this.createNewTransaction(tran)
        .then((ntran) => {
          if (ntran) {
            this.new_transaction = {}
            this.new_transaction_overlay = false
            const el = document.querySelector('[data-transaction-id="' + ntran.transaction_id + '"]')
            el.scrollIntoViewIfNeeded(true)
          }
        })
    },
    cancelTransaction () {
      this.new_transaction = {}
      this.new_transaction_overlay = false
    },
    newTransactionOverlay () {
      this.new_transaction_overlay = true
    },
    toggleThis (name) { this[name] = !this[name] },
    headingStyle () { if (this.$q.screen.lt.md) { return 'font-size: 120%' } else { return '' } },
    reveal () { this.$ecm.revealComp(this) },
    raise () { this.$ecm.raiseComp(this) },
    layBricks () { this.$ecm.layBricks() },
    sortTimeline (tl) {
      let entries = Object.entries(tl)
      for (var i = 0; i < entries.length; i++) {
        entries[i][0] = this.$ecm.humanize(entries[i][0])
        entries[i][1] = new Date(entries[i][1])
      }
      entries = entries.sort(function (a, b) { return a[1] < b[1] ? 1 : -1 })
      for (i = 0; i < entries.length; i++) {
        let obj = { name: entries[i][0], date: entries[i][1] }
        entries[i] = obj
      }
      return entries
    },
    findClaim (id) {
      this.$axios.get('/json/claim', { params: { 'id': id }, withCredentials: true })
        .then((response) => {
          this.claim = response.data
          document.title = 'Claim #' + this.id + ' - ECM'
          this.timeline = this.sortTimeline(this.claim.timeline)
          this.attachments = this.claim.attachments
          this.transactions = this.claim.transactions
          console.log(this.timeline)
        })
        .catch((e) => {
          console.log('Find Claim ERROR:'); console.log(e)
          this.$q.notify({
            color: 'negative',
            position: 'top',
            message: 'Loading failed',
            icon: 'report_problem'
          })
        })
    },
    getTransactionSelectValues () {
      let promise = this.$axios.get('/json/transaction/edit', { withCredentials: true })
        .then((res) => { this.transaction_select_values = res.data })
        .catch((e) => {
          console.log('Get Transaction Select Values Error:'); console.log(e)
          this.$q.notify({
            color: 'negative',
            position: 'top',
            message: 'Transaction Edit: Loading failed',
            icon: 'report_problem'
          })
        })

      return promise
    },
    createNewTransaction (tranny) {
      tranny.claim_id = this.claim.claim_id
      return this.$axios.post('/json/transaction/create', tranny, { withCredentials: true })
        .then((res) => {
          if (!res.data.error) {
            console.log('this is what we get:')
            console.log(res.data)
            const row = res.data
            row.highlight = true
            this.transactions.push(row)
            return res.data
          } else {
            this.$q.notify({
              color: 'negative',
              position: 'top',
              message: 'New Transaction Error: ' + res.data.error,
              icon: 'report_problem'
            })
          }
        })
        .catch((e) => {
          console.log('Get New Transaction Error:'); console.log(e)
          this.$q.notify({
            color: 'negative',
            position: 'top',
            message: 'New Transaction Error: ' + e.message,
            icon: 'report_problem'
          })
        })
    },
    foo () {
      return 'asd'
    }
  },
  created () { this.findClaim(this.id) },
  // mounted () { },
  watch: {
    $route (to, from) {
      console.log('changed oroute')
      this.findClaim(this.id)
    }
  }
}
</script>

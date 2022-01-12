<template>
 <q-card>
 <router-link v-if="backToClaim" :to="{ path: '/claim/' + backToClaim }"
              style="font-size: 150%">
   <q-icon name="arrow_back"/> Back to Claim #{{ backToClaim }}
 </router-link>
  <contract v-if="contract" v-model="contract" :back-to-claim="backToClaim" />
  </q-card>
</template>
<script>
import Contract from 'components/Contract'

export default {
  name: 'ContractPage',
  props: { id: String },
  components: {
    Contract
  },
  data () {
    return {
      contract: undefined,
      error: false,
      backToClaim: false
    }
  },
  methods: {
    findContract (id) {
      this.$axios.get('/json/contract', { params: { 'id': id } })
        .then((response) => {
          this.contract = response.data
          console.log(this.claim)
          document.title = 'Contract #' + this.contract.contract_number + ' - ECM'
        })
        .catch((e) => {
          this.error = e.message
          this.$q.notify({
            color: 'negative',
            position: 'top',
            message: 'Loading Contract failed',
            icon: 'report_problem'
          })
        })
    },
    foo () {
      return 'asd'
    }
  },
  created () {
    this.findContract(this.id)
  },
  mounted () {
    this.backToClaim = this.$route.query.backToClaim
    console.log(this.backToClaim)
  },
  watch: {
    $route (to, from) {
      this.findContract(this.id)
    }
  }
}
</script>

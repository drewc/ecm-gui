<template>
 <q-card>
 <router-link v-if="backToClaim" :to="{ path: '/claim/' + backToClaim }"
              style="font-size: 150%">
   <q-icon name="arrow_back"/> Back to Claim #{{ backToClaim }}
 </router-link>
  <policy v-if="policy" v-model="policy" :back-to-claim="backToClaim" />
  </q-card>
</template>
<script>
import Policy from 'components/Policy'

export default {
  name: 'PolicyPage',
  props: { id: String },
  components: {
    Policy
  },
  data () {
    return {
      policy: undefined,
      error: false,
      backToClaim: false
    }
  },
  methods: {
    findPolicy (id) {
      this.$axios.get('/json/policy', { params: { 'id': id } })
        .then((response) => {
          this.policy = response.data
          console.log(this.claim)
          document.title = 'Policy #' + this.policy.policy_number + ' - ECM'
        })
        .catch((e) => {
          this.error = e.message
          this.$q.notify({
            color: 'negative',
            position: 'top',
            message: 'Loading Policy failed',
            icon: 'report_problem'
          })
        })
    },
    foo () {
      return 'asd'
    }
  },
  created () {
    this.findPolicy(this.id)
  },
  mounted () {
    this.backToClaim = this.$route.query.backToClaim
    console.log(this.backToClaim)
  },
  watch: {
    $route (to, from) {
      this.findPolicy(this.id)
    }
  }
}
</script>

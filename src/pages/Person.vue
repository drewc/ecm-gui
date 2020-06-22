<template>
  <div v-if="claim" class="q-pa-md row items-start q-gutter-md full-width">

  <q-list bordered class="full-width">
    <q-expansion-item
      default-opened
    >
    <template slot="header">
     <div style="width:100%" class="text-center row items-stretch" v-if="claim.status">
       <div class="vertical-middle col-1 self-center">
         <q-icon name="local_library"
                 style="font-size: 150%" />
       </div>
        <q-card-section class="col">
           {{ person.full_name }}
        </q-card-section>
      </div>
    </template>
      <q-card>
        <q-card-section>
          <risk v-if="claim.risk" v-model="claim.risk" :back-to-claim="claim.claim_id" />
        </q-card-section>
      </q-card>

    </q-expansion-item>

    <q-separator />

    <q-expansion-item group="somegroup" icon="perm_identity" label="Second" header-class="text-teal">
    <template slot="header">
     <div style="width:100%">
       Fooo
      </div>
    </template>
      <q-card>
        <q-card-section>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
          commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
          eveniet doloribus ullam aliquid.
        </q-card-section>
      </q-card>
    </q-expansion-item>

    <q-separator />

    <q-expansion-item group="somegroup" icon="shopping_cart" label="Third" header-class="text-purple">
    <template slot="header">
     <div style="width:100%">
       Fooo
      </div>
    </template>
      <q-card>
        <q-card-section>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
          commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
          eveniet doloribus ullam aliquid.
        </q-card-section>
      </q-card>
    </q-expansion-item>

    <q-separator />

    <q-expansion-item
      group="somegroup"
      icon="bluetooth"
      label="Fourth"
      header-class="bg-teal text-white"
      expand-icon-class="text-white"
    >
    <template slot="header">
     <div style="width:100%">
       Fooo
      </div>
    </template>
      <q-card class="bg-teal-2">
        <q-card-section>
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
          commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
          eveniet doloribus ullam aliquid.
        </q-card-section>
      </q-card>
    </q-expansion-item>
  </q-list>
  </div>
</template>
<script>
// import Risk from 'components/Risk'

export default {
  name: 'PersonPage',
  props: { id: Number },
  // components: {
  //   Risk
  // },
  data () {
    return {
      person: undefined,
      error: false

    }
  },
  methods: {
    findPerson (id) {
      this.$axios.get('/json/person', { params: { 'id': id } })
        .then((response) => {
          this.person = response.data
          document.title = this.person.full_name + ' - ECM'
        })
        .catch((e) => {
          this.$q.notify({
            color: 'negative',
            position: 'top',
            message: 'Loading failed',
            icon: 'report_problem'
          })
        })
    }
  },
  created () { this.findPerson(this.id) },
  // mounted () {console.log(this.claim)},
  watch: {
    $route (to, from) {
      this.findPerson(this.id)
    }
  }
}
</script>

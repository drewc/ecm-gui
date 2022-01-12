<template>
  <q-page class="flex flex-center">
  <div class="q-pa-md">

    <q-stepper
      v-model="step"
      style="text-align:center"
      header-nav
      ref="stepper"
      color="primary"
      animated
    >
      <q-step
        :name="1"
        title="Type"
        icon="person_add"
        :done="done2"
        >
        <person-input choose_type v-model="person"/>

        <q-stepper-navigation>
          <q-btn @click="() => { done1 = true; step = 2 }" color="primary" label="Continue" />
        </q-stepper-navigation>
        </q-step>
      <q-step
        :name="2"
        title="Name"
        icon="person_add"
        :done="done2"
        >
        <person-input choose_name v-model="person"/>

        <q-stepper-navigation>
          <q-btn @click="() => { done2 = true; step = 3 }" color="primary" label="Continue" />
          <q-btn flat @click="step = 1" color="primary" label="Back" class="q-ml-sm" />
        </q-stepper-navigation>
      </q-step>

      <!-- Step 3 : Address-->

      <q-step
        :name="3"
        title="Address (optional)"
        icon="home_work"
        :done="done3"
        keep-alive
        >
        <h5 style="margin:auto"><person-display v-model="person" /></h5>
        <q-toggle v-model="has_address" icon="local_post_office" label="Has Address?"/>
        <person-input choose_address v-if="has_address" v-model="person" />

        <q-stepper-navigation>
          <q-btn @click="() => { done3 = true; step = 4 }" color="primary" label="Continue" />
          <q-btn flat @click="step = 2" color="primary" label="Back" class="q-ml-sm" />
        </q-stepper-navigation>
      </q-step>

      <!-- Step 4 : Contacts-->
      <q-step
        :name="4"
        title="Contact / Info (optional)"
        icon="add_comment"
        :done="done4"
        >
        <h5 style="margin:auto"><person-display display_address v-model="person" /></h5>
        <person-input choose_contact_info v-model="person" />

        Try out different ad text to see what brings in the most customers, and learn how to
        enhance your ads using features like ad extensions. If you run into any problems with
        your ads, find out how to tell if they're running and how to resolve approval issues.

        <q-stepper-navigation>
          <q-btn color="primary" @click="done4 = true" label="Finish" />
          <q-btn flat @click="step = 1" color="primary" label="Back" class="q-ml-sm" />
        </q-stepper-navigation>
      </q-step>
    </q-stepper>

    <q-btn label="Reset" push color="white" text-color="primary" @click="reset" class="q-mb-md" />
  </div>
  </q-page>
</template>

<script>

import PersonDisplay from 'components/PersonDisplay'
import PersonInput from 'components/PersonInput'

export default {
  name: 'CreatePerson',

  components: {
    // AddressInput,
    PersonInput,
    PersonDisplay
  },
  data () {
    return {
      model: null,
      step: 1,
      done1: false,
      done2: false,
      done3: false,
      done4: false,
      type: null,
      first_name: null,
      last_name: null,
      has_address: false,
      person: { type: undefined, name: {}, address: {}, contact: {}, info: {} }
    }
  },
  methods: {
    reset () {
      this.done1 = false
      this.done2 = false
      this.done3 = false
      this.step = 1
    },
    set_address (val) {
      if (!val) { this.person.address = {} }
    }
  }
  // data () {
  //   return {
  //     model: 'null',
  //     step: 1
  //   }
  // },
  // methods: {
  //   greet: function (val) {
  //     alert(val)
  //     this.$router.push('/create/entity/' + this.model)
  //   }
  // }
}
</script>

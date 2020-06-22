<template>
  <div>
    <div v-if="choose_type || value.type === undefined" class="q-gutter-sm justify-center">
      <q-radio v-model="value.type" val="person" label="Person" />
      <q-radio v-model="value.type" val="company" label="Company/Group/other" />
    </div>
    <!-- Person Name-->
    <template v-if="choose_name">
    <div v-if="value.type === 'person'" class="ecm-large-input q-gutter-md row items-start">
              <q-select v-model="value.name.title" :options="titles" hint="Title">
                <q-tooltip class="tooltip-style" anchor="top middle" self="bottom middle" >
                  Mr/Mrs/Mme, etc</q-tooltip>
              </q-select>
             <q-input v-model="value.name.first_name" hint="First Name" />
            <q-input  v-model="value.name.middle_name" hint="Middle Name" />
             <q-input  v-model="value.name.last_name" hint="Last Name" />
            <q-select v-model="value.name.suffix" :options="suffixes" hint="suffix" />
    </div>

    <!-- Company -->
    <div v-else-if="value.type === 'company'">
      <q-input style="font-size: x-large"
               v-model="value.name.company_name" label="Company / Group / Entity Name" />
    </div>

    </template>

    <template v-if="choose_address">
      <address-input v-model="value.address" />
    </template>

    <template v-if="choose_contact_info">
      <div class="q-gutter-md row items-start flex-center">
        <q-input v-model="value.contact.email" filled type="email" hint="Email"
                 label="Email Address"/>
        <q-input v-if="value.type === 'company'" v-model="value.contact.work_phone"
                 filled type="tel" hint="Telephone number (office)"
                 label="Office Phone"/>
        <q-input v-model="value.contact.cell_phone"
                 filled type="tel" hint="Telephone number (mobile)"
                 label="Cell Phone"/>
        <template v-if="value.type === 'person'">
        <q-input  v-model="value.contact.work_phone"
                  filled type="tel" hint="Telephone number (office)"
                  label="Work Phone" />
        <q-input  v-model="value.contact.home_phone"
                  filled type="tel" hint="Telephone number (home)"
                  label="Home Phone"/>
        <q-input v-if="value.type === 'person'"
                 filled v-model="value.info.date_of_birth" style="max-width:300px;"
                 hint="Date of Birth">
          <template v-slot:prepend>
            <q-icon name="event" class="cursor-pointer">
              <q-popup-proxy transition-show="scale" transition-hide="scale">
                <q-date v-model="value.date_of_birth" mask="YYYY-MM-DD">
                  <q-btn label="OK" color="primary" flat  v-close-popup />
                  <q-btn label="Cancel" color="primary" flat v-close-popup />
                </q-date>
              </q-popup-proxy>
            </q-icon>
          </template>
        </q-input>
    </template>
        <q-input v-model="value.contact.Fax_phone"
                 filled type="tel" hint="Facsimile number"
                 label="Fax Machine"/>
      </div>
    </template>
  </div>
</template>
<style>
  .ecm-large-input .q-field {
    font-size: x-large;
  }
</style>
<script>

import AddressInput from 'components/AddressInput'
export default {
  name: 'PersonInput',
  components: { AddressInput },
  props: {
    value: Object,
    choose_type: Boolean,
    choose_name: Boolean,
    choose_address: Boolean,
    choose_contact_info: Boolean
  },
  data () {
    return {
      titles: null,
      suffixes: null
    }
  },
  created: function () {
    this.$axios.get('/json/person/titles')
      .then((response) => {
        this.titles = [''].concat(response.data)
      })
      .catch(() => {
        this.$q.notify({
          color: 'negative',
          position: 'top',
          message: 'Loading titles failed',
          icon: 'report_problem'
        })
      })

    this.$axios.get('/json/person/suffixes')
      .then((response) => {
        this.suffixes = [''].concat(response.data)
      })
      .catch(() => {
        this.$q.notify({
          color: 'negative',
          position: 'top',
          message: 'Loading suffixes failed',
          icon: 'report_problem'
        })
      })
  }
}
</script>

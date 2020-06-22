<template>
  <div class="ecm-address-group">
  <q-input v-model="value.line1" label="Street Address" input-class="ecm-address-input" />
  <q-input v-model="value.line2" label="Line Two" input-class="ecm-address-input"/>

    <div class="row">
      <div class="col-6">
        <q-input v-model="value.city" label="City"
                 input-class="ecm-address-input"  />
      </div>
      <div class="col-4">
        <q-select v-model="province" :options="provinces" label="Province"
                  @input="new_prov"  />
      </div>
      <div class="col-2">
        <q-input v-model="value.postal_code" label="Postal Code"
                 input-class="ecm-address-input"  />
      </div>
    </div>
    <q-select v-model="value.country" :options="countries"
              label="Country"
              @input="update_provs" />
    {{ value.province }}
  </div>
</template>
<style>
  .ecm-address-group {
    max-width: 680px;
    margin:auto;
   }
</style>
<script>
console.log(process.env.API !== undefined)

function ecmMakeProvinceOption (p) {
  return { label: p.name + ' (' + p.code + ')', value: p.code }
}

function ecmFiltProv (provs, country) {
  return provs.filter((p) => p.country === country)
}
export default {
  name: 'AddressInput',
  props: ['value'],
  data () {
    return {
      province: null,
      countries: null,
      provinces: null,
      all_provinces: null
    }
  },
  created: function () {
    // `this` points to the vm instance
    console.log(this.$axios.defaults.baseURL)

    if (this.value.country === undefined) {
      this.value.country = {
        label: 'Canada',
        value: 'CA'
      }
    }
    if (this.value.province === undefined) {
      this.value.province = {
        label: 'British Columbia (BC)',
        value: 'BC'
      }
    }

    this.province = this.value.province

    this.$axios.get('/json/address/countries')
      .then((response) => {
        this.countries = response.data.map((thing) => {
          return { label: thing.name, value: thing.code }
        })
      })
      .catch(() => {
        this.$q.notify({
          color: 'negative',
          position: 'top',
          message: 'Loading countries failed',
          icon: 'report_problem'
        })
      })
    this.$axios.get('/json/address/provinces')
      .then((response) => {
        this.all_provinces = response.data
        this.make_provs(this.value.country.value)
      })
      .catch(() => {
        this.$q.notify({
          color: 'negative',
          position: 'top',
          message: 'Loading provinces failed',
          icon: 'report_problem'
        })
      })
  },
  methods: {
    new_prov (c) {
      this.value.province = c
      this.province = c
    },
    update_provs (c) {
      this.make_provs(c.value)
      this.new_prov(undefined)
    },
    make_provs: function (c) {
      this.provinces = ecmFiltProv(this.all_provinces, c)
        .map(ecmMakeProvinceOption)
    }
  }

}
</script>
  // methods: {
  //   greet: function (val) {
  //     alert(val)
  //     this.$router.push('/create/entity/' + this.model)
  //   }
  // }

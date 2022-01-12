<template>
  <div style="display: inline">
       {{ value.name.title }} {{ value.name.first_name }} {{ value.name.middle_name }}
       {{ value.name.last_name }} {{ value.name.suffix }} {{ value.name.company_name }}
       <div v-if="display_address">
         <template v-if="value.address.line1"> {{ value.address.line1 }} <br>
         </template>
         <template v-if="value.address.line2"> {{ value.address.line2 }} <br>
         </template>
         <template v-if="value.address.city"> {{ value.address.city}}</template><template v-if="value.address.province">, {{value.address.province.value }} </template>
       <template v-if="value.address.postal_code"> {{ value.address.postal_code }} <br> </template>
       <template v-if="value.address.country"> {{ value.address.country.label }} <br> </template>
       </div>
  </div>
</template>
<script>
export default {
  name: 'PersonDisplay',
  props: { value: Object, display_address: Boolean }
}
</script>

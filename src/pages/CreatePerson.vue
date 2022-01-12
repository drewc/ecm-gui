<template>
  <q-page class="flex flex-center">
    <img alt="ECM logo" width="350" height="350" src="~assets/app-icon.png">
      <div>
        <q-btn-toggle
          v-model="model"
          class="my-custom-toggle"
          no-caps
          rounded
          unelevated
          toggle-color="primary"
          color="white"
          text-color="primary"
          :options="[
                    {label: 'Person', value: 'person'},
                    {label: 'Organization', value: 'org'}
                    ]"
          />
      </div>
  </q-page>
</template>

<script>
export default {
  name: 'CreatePerson',
  data () {
    return {
      model: 'person'
    }
  }
}
</script>

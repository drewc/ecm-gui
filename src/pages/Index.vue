<template>
  <q-page class="flex flex-center">
  <div style="max-width: 800px; width: 100%;">
    <q-calendar
      v-model="selectedDate"
      view="month"
      locale="en-ca"
    ></q-calendar>
  </div>

    <router-link to="/foo">Go to bar</router-link>
  <q-item to="/admin/user" exact>
  <q-item-section avatar>
    <q-icon name="inbox" />
  </q-item-section>

  <q-item-section>
    Inbox
  </q-item-section>
  </q-item>
    <img alt="ECM logo" width="350" height="350" src="~assets/app-icon.png">
  </q-page>
</template>

<script>
export default {
  name: 'PageIndex',
  data () {
    return {
      model: 'person',
      selectedDate: '2020-01-01'
    }
  }
}
</script>

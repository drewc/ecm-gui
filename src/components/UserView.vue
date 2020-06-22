<template>
    <q-card>
    <q-btn round color="primary" icon="close" style="float:right"/>
      <q-card-section>
        <div class="text-h6">          {{ id }}</div>
        <div class="text-subtitle2">by John Doe</div>
      </q-card-section>

      <q-separator inset />

      <q-card-section>
        {{ user.name }}
      </q-card-section>
      {{ user.name }}
      This is e pluribis enumaasd
      <br>
      <hr>
    </q-card>
</template>
<script>
export default {
  name: 'UserView',
  props: { value: Object, id: String },
  mounted () {
    this.user = (this.value !== undefined) ? this.value : { name: 'asdasd' }
    console.log(this.$parent)
  },
  data () {
    return {
      user: {}
    }
  }
}
</script>

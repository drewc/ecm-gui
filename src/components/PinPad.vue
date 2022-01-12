<template>
  <div>
    <q-btn @click="handleClick">Click Me</q-btn>
  </div>
</template>

<script>
import { QBtn } from 'quasar'

export default {
  data () {
    return {
      pin: ''
    }
  },
  methods: {
    handleClick () {
      console.log('Pinpad QBtn clicked')
    }
  },
  mounted: function () {
    console.log('Mounting Pinpad')
  },
  components: { QBtn }
}
</script>

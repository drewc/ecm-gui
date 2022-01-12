<template>
  <!--
  Forked from:
  https://quasar.dev/vue-components/select#Example--Lazy-autocomplete
-->
  <div class="q-pa-md">
      <div class="q-gutter-md">
        <q-select
          filled
          v-model="model"
          use-input
          hide-selected
          fill-input
          input-debounce="0"
          :label="pLabel"
          :options="options"
          @filter="filterFn"
          @filter-abort="abortFilterFn"
          style="width: 250px"
          hint="With hide-selected and fill-input"
        >
          <template v-slot:no-option>
            <q-item>
              <q-item-section class="text-grey">
                No results
              </q-item-section>
            </q-item>
          </template>
        </q-select>

        <q-select
          filled
          v-model="model"
          use-input
          use-chips
          input-debounce="0"
          :label="pLabel"
          :options="options"
          @filter="filterFn"
          @filter-abort="abortFilterFn"
          style="width: 250px"
          hint="With use-chips"
        >
          <template v-slot:no-option>
            <q-item>
              <q-item-section class="text-grey">
                No results
              </q-item-section>
            </q-item>
          </template>
        </q-select>
      </div>
  </div>
</template>

<script>
const stringOptions = [
  'Google', 'Facebook', 'Twitter', 'Apple', 'Oracle'
]

export default {
  data () {
    return {
      model: null,
      options: stringOptions
    }
  },

  computed: {
    pLabel () {
      return this.label
    }
  },
  props: {
    label: {
      type: String,
      default: 'Choose Person'
    },
    height: {
      type: Number,
      default: 100
    }
  },
  methods: {
    filterFn (val, update, abort) {
      // call abort() at any time if you cannot retrieve data somehow
      console.log(this.$axios.get)
      setTimeout(() => {
        update(() => {
          if (val === '') {
            this.options = stringOptions
          } else {
            const needle = val.toLowerCase()
            this.options = stringOptions.filter(v => v.toLowerCase().indexOf(needle) > -1)
          }
        })
      }, 15)
    },

    abortFilterFn () {
      // console.log('delayed filter aborted')
    }
  }
}
</script>

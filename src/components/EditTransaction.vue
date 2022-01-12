<template>
  <div>
<q-spinner v-if="!select_values" color="yellow" size="10em" />
<template v-else>
  <q-input v-model="value.date" class="tranny-in"
           label="Date" placeholder="YYYY-MM-DD HH:mm">
    <template v-slot:prepend>
      <q-icon name="event" class="cursor-pointer">
        <q-popup-proxy transition-show="scale" transition-hide="scale"
                       ref="dateProxy">
          <q-date v-model="value.date" mask="YYYY-MM-DD HH:mm"
                  @input="() => $refs.dateProxy.hide()">
            <div class="row items-center justify-end q-gutter-sm">
              <q-btn label="OK" color="primary" flat v-close-popup />
            </div>
          </q-date>
        </q-popup-proxy>
      </q-icon>
    </template>
    <template v-slot:append>
      <q-icon name="access_time" class="cursor-pointer">
        <q-popup-proxy transition-show="scale" transition-hide="scale"
                    ref="timeProxy">
          <q-time v-model="value.date" mask="YYYY-MM-DD HH:mm"
                  format24h now-btn flat  @input="() => $refs.timeProxy.hide()"/>
           <div class="row items-center justify-end q-gutter-sm">
             <q-btn label="OK" color="primary" flat v-close-popup />
           </div>
        </q-popup-proxy>
      </q-icon>
    </template>
  </q-input>
  <q-select v-model="value.type" use-chips class="tranny-in"
            :options="selectTypes" label="Type" options-cover
            />
  <q-select v-model="value.heading" use-chips class="tranny-in"
            :options="selectHeadings" label="Heading"  options-cover
            />
  <div>

    <q-input v-if="isIndemnity() && value.type === 'Open Reserve'"
             v-model.number="value.limit_of_cover" type="number"
             prefix="$" label="Limit of Cover" placeholder="0.00"
             clearable class="tranny-in"
             />
    <q-select v-model="value.expense_type" v-if="isCheque() && showAmount()" use-chips
            class="tranny-in" :options="selectExpense" label="Expense Type" options-cover
            />
    <q-input v-if="showAmount()" class="tranny-in"
             v-model.number="value.amount" type="number"
             prefix="$" label="Amount" clearable
             placeholder="0.00"
             />
  </div>
  <div>
    <q-expansion-item v-if="isCheque() && showAmount()"
     expand-separator :default-opened="$q.screen.gt.sm"
     icon="add_shopping_cart"
     label="Cheque Details"
     caption="numbers, payee, etc"
   >
      <q-select
        label="Payee"
        hint="Input the name. If there are no matching results, hit Enter to create."
        option-label="full_name"
        filled

        v-model="value.payee"
        use-input
        use-chips
        input-debounce="0"
        @new-value="createValue"
        :options="payees"
        @filter="searchPayee"
          >
        <template v-slot:no-option>
          <q-item>
            <q-item-section class="text-grey">
              No results
            </q-item-section>
          </q-item>
        </template>

      </q-select>
      <q-input
        v-model="value.cheque_number" class="tranny-in"
        label="Cheque Number " clearable
        />
      <q-input
        v-model="value.reference_number" class="tranny-in"
        label="Reference Number " clearable
        />
      <q-input
        v-model="value.schemes_advance_number" class="tranny-in"
        label="Schemes Advance Number " clearable
        />
   </q-expansion-item>
 <q-separator size="1.5px" />
 </div>

</template>

<q-separator />
<q-btn color="primary"
       label="Create New"
       v-if="showAmount()"
       @click.stop="submitTransaction();" />

<q-btn color="secondary"
       label="Cancel"
       class="q-mr-sm"
       @click.stop="cancelTransaction();" />
  </div>
</template>
<style>
 .tranny-in {
    width: 300px;
    margin: 1em;
    display: inline-block;
 }
</style>
<script>
export default {
  name: 'EditTransaction',
  props: { value: { type: Object, default: () => { return { } } } },
  data () {
    return {
      et: false,
      select_values: false,
      have_exited_from_limit: false,
      payees: []
    }
  },
  computed: {
    selectExpense () {
      return !this.select_values ? []
        : this.select_values.expense.map(t => t.name)
    },
    selectHeadings () {
      return !this.select_values ? []
        : this.select_values.heading.map(t => t.name)
    },
    selectTypes () {
      return !this.select_values ? []
        : this.select_values.type.map(t => t.name)
    }
  },
  methods: {
    makeFromProp (prop = this.value) {
      return {
        claim_id: this.value.claim_id,
        date: this.value.date,
        type: this.value.type,
        heading: this.value.heading,
        expense_type: this.value.expense_type,
        amount: this.value.amount,
        limit_of_cover: this.value.limit_of_cover,
        cheque: {
          payee: this.value.payee,
          cheque_number: this.value.cheque_number,
          reference_number: this.value.reference_number,
          schemes_advance_number: this.value.schemes_advance_number
        }
      }
    },
    submitTransaction () {
      const tran = this.makeFromProp()
      this.$emit('submit', tran)
    },
    cancelTransaction () {
      const tran = this.makeFromProp()
      this.$emit('cancel', tran)
    },
    createValue (val, done) {
      // Calling done(var) when new-value-mode is not set or "add", or done(var, "add") adds "var" content to the model
      // and it resets the input textbox to empty string
      // ----
      // Calling done(var) when new-value-mode is "add-unique", or done(var, "add-unique") adds "var" content to the model
      // only if is not already set
      // and it resets the input textbox to empty string
      // ----
      // Calling done(var) when new-value-mode is "toggle", or done(var, "toggle") toggles the model with "var" content
      // (adds to model if not already in the model, removes from model if already has it)
      // and it resets the input textbox to empty string
      // ----
      // If "var" content is undefined/null, then it doesn't tampers with the model
      // and only resets the input textbox to empty string

      if (val.length > 2) {
        done(val, 'add')
      }
    },
    searchPayee (val, update, abort) {
      if (val.length > 1) {
        this.$axios.get('/json/person/autocomplete', { params: { 'q': val }, withCredentials: true })
          .then((response) => {
            console.log(response.data)
            update(() => { this.payees = response.data })
          })
          .catch((e) => {
            console.log('Search Payee ERROR:'); console.log(e)
            this.$q.notify({
              color: 'negative',
              position: 'top',
              message: 'Payee search failed',
              icon: 'report_problem'
            })
          })
      } else {
        this.payees = []
      }
    },
    abortSearchPayee () {
      console.log('payee search aborrted')
    },
    getTransactionSelectValues () {
      let promise = this.$axios.get('/json/transaction/edit', { withCredentials: true })
        .then((res) => { this.select_values = res.data })
        .catch((e) => {
          console.log('Get Transaction Select Values Error:'); console.log(e)
          this.$q.notify({
            color: 'negative',
            position: 'top',
            message: 'Transaction Edit: Loading failed',
            icon: 'report_problem'
          })
        })
      return promise
    },
    isIndemnity () {
      let ret = false
      if (!this.select_values) { return ret }
      this.select_values.heading.map(h => {
        if (h.name === this.value.heading && h.indemnity) { ret = true }
      })
      return ret
    },
    isCheque () {
      const ret = this.value.type && this.value.type.includes('Cheque ')
      if (ret && !this.value.cheque) {
        this.value.cheque = { payee: undefined }
      }
      return ret
    },
    showAmount () {
      return (this.value.type && this.value.heading && this.value.date)
    }
  },
  mounted () {
    this.getTransactionSelectValues()
  }
}
</script>

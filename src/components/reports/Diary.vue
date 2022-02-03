<script setup>
import { ref, computed, onMounted } from 'vue'
import Report from '../Report.vue'
import Datepicker from  '../../components/DateTimePicker.vue'

import SelectDiaryUser from '../widgets/SelectDiaryUser.vue'
import { useStore } from 'vuex'
const store = useStore();

const due_date = ref(new Date())
const range = ref()
const startDate = ref(new Date());
const tz = Intl.DateTimeFormat().resolvedOptions().timeZone
const st = { hours: 0, minutes: 0 }
const startTime = ref([st, st])

const processed = ref('overdue');
const select_user = ref('all');
const user = ref();
const allowRun = computed(() => processed.value && due_date.value)

const reportOn = computed(() => {
  const r = {
    timezone: tz,
    user_id: select_user.value === "select" ? user.value.user_id : false,
    overdue: processed.value === 'overdue'
  }
  if (processed.value === 'overdue') {
    return {
      deadline: due_date.value,
      start_date: '1900-01-01',
      ...r
    }
  } else {
    return {
      deadline: range.value[1],
      start_date: range.value[0],
      ...r


    }
  }

})
</script>

<template>
<div class="ecm-center-inputs">
  <Report title="Diary Report">
    <template #default="{ toggle, runReport }">
            <div class="uk-width-expand  uk-margin">
        <label><input class="uk-radio" type="radio"
                      value="all" v-model="select_user" checked>&nbsp;All Users</label>
        &nbsp;&nbsp;
        <label><input class="uk-radio" type="radio"
                      value="select" v-model="select_user">&nbsp;Select User</label>
      </div>
        <div v-if="select_user === 'select'" class="uk-margin">

          <SelectDiaryUser v-model="user"/>
        </div>
      <div class="uk-width-expand  uk-margin">
        <label><input class="uk-radio" type="radio"
                      value="overdue" v-model="processed" checked>&nbsp;Not Done/Overdue</label>
        &nbsp;&nbsp;
        <label><input class="uk-radio" type="radio"
                      value="all" v-model="processed">&nbsp;All Entries</label>
      </div>
      <div v-if="processed">

  Deadline: <Datepicker class="uk-inline" v-if="processed === 'overdue'" inputClassName="uk-input"
              format="yyyy-MM-dd" v-model="due_date"
              placeholder="Due Date (entry due before)"
              :startDate="startDate" autoApply />
 <Datepicker v-else inputClassName="uk-input"
              format="yyyy-MM-dd" v-model="range"
              placeholder="Date Range"
              range twoCalendars autoApply :startTime="startTime" />

     <div class="uk-width-expand uk-text-center uk-padding" v-if="allowRun">
     <button
       @click="runReport('/rpc/report/diary', reportOn, 'Diary')"
       class="uk-button uk-button-primary" type="button"
       >
        Run Report
      </button>
    </div>
</div>
</template>
</Report>
</div>
</template>

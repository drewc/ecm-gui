<script setup>
import { ref, computed } from 'vue'
import { get, post } from 'axios'
import { onMounted } from 'vue'
const error = ref(false);

import PMI from './reports/PMI.vue'
import Header from './Header.vue'
</script>

<template>
  <div class="uk-height-viewport uk-background-muted">
 <Header/>
 <router-view></router-view>
 </div>
</template>

<script setup>
import SimpleTypeAhead from 'vue3-simple-typeahead';
import Login from './components/Login.vue'
import HelloWorld from './components/HelloWorld.vue'
import UIkit from 'uikit'
import Icons from 'uikit/dist/js/uikit-icons';

import { computed } from 'vue'
import { useStore } from 'vuex'

import PMI from './components/reports/PMI.vue'
import Header from './components/Header.vue'

UIkit.use(Icons);

const store = useStore();

const user = computed(() => store.state.user)


</script>

<template>
  <Header/>
  user: {{ user }}
 <PMI v-if="user" />
 <Login v-else />
</template>
<style>
  .simple-typeahead-list {
     max-height: 3em;
     overflow: scroll;
 }
 </style>

<style src="uikit/dist/css/uikit.min.css"> </style>
<style src="vue3-simple-typeahead/dist/vue3-simple-typeahead.css"> </style>

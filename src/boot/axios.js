import Vue from 'vue'
import axios from 'axios'

if (process.env.DEV) { axios.defaults.baseURL = 'http://localhost:4202' }

Vue.prototype.$axios = axios

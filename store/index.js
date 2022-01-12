import { createStore } from 'vuex'

// Create a new store instance.
export default createStore({
  state () {
    return {
      user: false
    }
  },
  mutations: {
    login (state, user) {
      state.user = user
    }
  }
})

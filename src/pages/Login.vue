<template>
  <q-page class="window-height window-width row justify-center items-center">
    <div class="column">
      <div style="margin:auto 0">
        <h5>Sign in to continue to:</h5>
        <h4 style="margin:auto">Maxwell Claims ECM</h4>
        <br>
      </div>
      <div class="row">
        <q-card square bordered class="q-pa-lg shadow-1">
            <form @submit.prevent="loginUser" class="q-pa-md">
          <img class="profile-img" style="width:96px;"
               src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120"
               alt="">
            <div v-if="error" class="text-negative"> {{ error }} </div>
          <q-card-section>
            <!-- type="email" -->
              <q-input square filled clearable v-model="email"  label="email" />
              <q-input square filled clearable v-model="password" type="password" label="password" />
          </q-card-section>
          <q-card-actions class="q-px-md">
            <q-btn unelevated type="submit" :loading="submitting"
                   color="light-blue-7" size="lg" class="full-width" label="Login" />
          </q-card-actions>
          <q-card-section class="text-center q-pa-none">
            <p class="text-grey-6">Not registered? Created an Account</p>
          </q-card-section>
            </form>
        </q-card>
      </div>
    </div>
  </q-page>
</template>

<script>
export default {
  name: 'Login',
  data () {
    return {
      email: '',
      password: '',
      submitting: false,
      error: false
    }
  },
  methods: {
    emitLogin (data) {
      this.$root.$emit('login', this.$route.query.goto)
    },
    loginUser () {
      this.submitting = true
      this.$ecm.loginUserPromise(this.email, this.password)

        .then((result) => {
          console.log('login res:' + result)
          console.log(result)
          if (result.data.error === undefined) {
            this.emitLogin(result.data)
          } else {
            this.error = result.data.error
          }
        })
      // Simulating a delay here.
      // When we are done, we reset "submitting"
      // Boolean to false to restore the
      // initial state.
      setTimeout(() => {
        // delay simulated, we are done,
        // now restoring submit to its initial state
        this.submitting = false
      }, 3000)
    }
  }
}
</script>

<style>
.q-card {
    width: 360px;
}

.sep {
    margin-top: 35px;
}
.profile-img
{
    width: 96px;
    height: 96px;
    margin: 0 auto 10px;
    display: block;
    -moz-border-radius: 50%;
    -webkit-border-radius: 50%;
    border-radius: 50%;
}
</style>

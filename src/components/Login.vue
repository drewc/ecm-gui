<script setup>
  import { post, get } from 'axios'
  import { useStore } from 'vuex'
  import { ref } from 'vue'
  
  import { useCookie } from 'vue-cookie-next'
  
  const username = ref();
  const passwd = ref();
  const error = ref();
  
  const store = useStore()
  const cookie = useCookie()
  
  get('/rpc/login').then(r => { if (r.data) store.commit('login', r.data) });
  
  
  async function login (event) {
    event.preventDefault();
    error.value = undefined;
    const res = await post('/rpc/login', { u: username.value, p: passwd.value })
    const u = res.data;
    if (!u) {
      error.value = "Invalid Username/Password"
    } else {
      store.commit('login', u)
      cookie.setCookie("ecm-login-uuid", u.uuid, { expire: 'Session' })
    }
  }
  
</script>

<template>
  <div class="login uk-cover-container uk-background-secondary uk-flex uk-flex-center uk-flex-middle uk-height-viewport uk-overflow-hidden uk-light" data-uk-height-viewport>
    <!-- overlay -->
    <div class="uk-position-cover uk-overlay-primary"></div>
    <!-- /overlay -->
    <div class="uk-position-bottom-center uk-position-small uk-visible@m uk-position-z-index">
      <span class="uk-text-small uk-text-muted">© 2022 Aufin Shatranj Inc. - <a href="mailto:me@drewc.ca">Created by DrewC</a> | Built with <a href="https://cons.io/" title="Visit Gerbil site" target="_blank" data-uk-tooltip>
        <img src="../assets/gerbil.svg" width="20" alt="Gerbil Scheme">
        </a></span>
    </div>
    <div class="uk-width-medium uk-padding-small uk-position-z-index" uk-scrollspy="cls: uk-animation-fade">
  
      <div class="uk-text-center uk-margin">
        <img src="../assets/logo.jpg" alt="Logo" class="logo-img">
      </div>
  
        <div v-if="error" class="uk-alert-danger" uk-alert>
          <a class="uk-alert-close" uk-close></a>
          <p style="text-align:center"> {{ error }} </p>
        </div>
      <!-- login -->
      <form class="toggle-class" @submit="login">
        <fieldset class="uk-fieldset">
      	<div class="uk-margin-small">
      	  <div class="uk-inline uk-width-1-1">
      		<span class="uk-form-icon uk-form-icon-flip" data-uk-icon="icon: user"></span>
      		<input
                v-model="username"
                class="uk-input uk-border-pill" required placeholder="Username" type="text">
      	  </div>
      	</div>
      	<div class="uk-margin-small">
      	  <div class="uk-inline uk-width-1-1">
      		<span class="uk-form-icon uk-form-icon-flip" data-uk-icon="icon: lock"></span>
      		<input v-model="passwd" class="uk-input uk-border-pill" required placeholder="Password" type="password">
      	  </div>
      	</div>
      	<div class="uk-margin-small">
      	  <label><input class="uk-checkbox" type="checkbox"> Keep me logged in</label>
      	</div>
      	<div class="uk-margin-bottom">
      	  <button type="submit" class="uk-button uk-button-primary uk-border-pill uk-width-1-1">LOG IN</button>
      	</div>
        </fieldset>
      </form>
      <!-- /login -->
  
      <!-- recover password -->
      <form class="toggle-class" action="login-dark.html" hidden>
        <div class="uk-margin-small">
      	<div class="uk-inline uk-width-1-1">
      	  <span class="uk-form-icon uk-form-icon-flip" data-uk-icon="icon: mail"></span>
      	  <input class="uk-input uk-border-pill" placeholder="E-mail" required type="text">
      	</div>
        </div>
        <div class="uk-margin-bottom">
      	<button type="submit" class="uk-button uk-button-primary uk-border-pill uk-width-1-1">SEND PASSWORD</button>
        </div>
      </form>
      <!-- /recover password -->
  
      <!-- action buttons -->
      <div>
        <div class="uk-text-center">
      	<a class="uk-link-reset uk-text-small toggle-class" data-uk-toggle="target: .toggle-class ;animation: uk-animation-fade">Forgot your password?</a>
      	<a class="uk-link-reset uk-text-small toggle-class" data-uk-toggle="target: .toggle-class ;animation: uk-animation-fade" hidden><span data-uk-icon="arrow-left"></span> Back to Login</a>
        </div>
      </div>
      <!-- action buttons -->
    </div>
  
  </div>
</template>

<style scoped>
div.login {
	background-image: url('https://picsum.photos/640/700/?image=1044');
	background-position: center center;
	background-repeat: no-repeat;
	background-size: cover;
}
@media screen and (min-width: 640px){
	div.login {
		background-image: url('https://picsum.photos/960/700/?image=1044');
	}
}
@media screen and (min-width: 960px){
	div.login {
		background-image: url('https://picsum.photos/1200/900/?image=1044');
	}
}
@media screen and (min-width: 1200px){
	div.login {
		background-image: url('https://picsum.photos/1600/950/?image=1044');
	}
}
@media screen and (min-width: 1600px){
	div.login {
		background-image: url('https://picsum.photos/2000/1050/?image=1044');
	}
}

.logo-img {
  border: 1em solid white;
  border-radius: 1em;
  opacity: 0.9;
}

.uk-input .uk-input {
    border: none;
    padding: 0;
    margin: 0;
}
.uk-input .pgui-port{
   width: 6em;
}
</style>

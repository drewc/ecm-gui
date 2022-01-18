<script setup>
</script>
<style>
  /* -- Top navigation -- */
#top-head {
	z-index: 9;
	top: 0;
	left:0;
	right:0;
}
#top-spacer {
	margin-top: 40px;
	padding-top:0.7em;
	transition: margin 0.2s cubic-bezier(.4,0,.2,1);
}
#top-head .uk-navbar-item {
   min-height: 40px;
}
</style>
<template>
<header id="top-head" class="uk-position-fixed">
  <div class="uk-navbar-container uk-container-expand">
  <nav class="uk-navbar uk-navbar-default" data-uk-navbar="mode:click; duration: 250">
    <div class="uk-navbar-left">
    <a class="uk-navbar-item uk-logo" href="#">ECM</a>

    <div class="uk-navbar-item uk-hidden@m">
      <!-- <a class="uk-logo" href="#"><img class="custom-logo" src="img/dashboard-logo-white.svg" alt=""></a> -->
    </div>
    <!-- <ul class="uk-navbar-nav uk-visible@m"> -->
    <!--   <li><a href="#">Accounts</a></li> -->
    <!--   <li> -->
    <!--   <a href="#" aria-expanded="false">Settings <span data-uk-icon="icon: triangle-down" class="uk-icon"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><polygon points="5 7 15 7 10 12"></polygon></svg></span></a> -->
    <!--   <div class="uk-navbar-dropdown"> -->
    <!--     <ul class="uk-nav uk-navbar-dropdown-nav"> -->
    <!--     <li class="uk-nav-header">YOUR ACCOUNT</li> -->
    <!--     <li><a href="#"><span data-uk-icon="icon: info" class="uk-icon"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path d="M12.13,11.59 C11.97,12.84 10.35,14.12 9.1,14.16 C6.17,14.2 9.89,9.46 8.74,8.37 C9.3,8.16 10.62,7.83 10.62,8.81 C10.62,9.63 10.12,10.55 9.88,11.32 C8.66,15.16 12.13,11.15 12.14,11.18 C12.16,11.21 12.16,11.35 12.13,11.59 C12.08,11.95 12.16,11.35 12.13,11.59 L12.13,11.59 Z M11.56,5.67 C11.56,6.67 9.36,7.15 9.36,6.03 C9.36,5 11.56,4.54 11.56,5.67 L11.56,5.67 Z"></path><circle fill="none" stroke="#000" stroke-width="1.1" cx="10" cy="10" r="9"></circle></svg></span> Summary</a></li> -->
    <!--     <li><a href="#"><span data-uk-icon="icon: refresh" class="uk-icon"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill="none" stroke="#000" stroke-width="1.1" d="M17.08,11.15 C17.09,11.31 17.1,11.47 17.1,11.64 C17.1,15.53 13.94,18.69 10.05,18.69 C6.16,18.68 3,15.53 3,11.63 C3,7.74 6.16,4.58 10.05,4.58 C10.9,4.58 11.71,4.73 12.46,5"></path><polyline fill="none" stroke="#000" points="9.9 2 12.79 4.89 9.79 7.9"></polyline></svg></span> Edit</a></li> -->
    <!--     <li><a href="#"><span data-uk-icon="icon: settings" class="uk-icon"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><ellipse fill="none" stroke="#000" cx="6.11" cy="3.55" rx="2.11" ry="2.15"></ellipse><ellipse fill="none" stroke="#000" cx="6.11" cy="15.55" rx="2.11" ry="2.15"></ellipse><circle fill="none" stroke="#000" cx="13.15" cy="9.55" r="2.15"></circle><rect x="1" y="3" width="3" height="1"></rect><rect x="10" y="3" width="8" height="1"></rect><rect x="1" y="9" width="8" height="1"></rect><rect x="15" y="9" width="3" height="1"></rect><rect x="1" y="15" width="3" height="1"></rect><rect x="10" y="15" width="8" height="1"></rect></svg></span> Configuration</a></li> -->
    <!--     <li class="uk-nav-divider"></li> -->
    <!--     <li><a href="#"><span data-uk-icon="icon: image" class="uk-icon"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><circle cx="16.1" cy="6.1" r="1.1"></circle><rect fill="none" stroke="#000" x=".5" y="2.5" width="19" height="15"></rect><polyline fill="none" stroke="#000" stroke-width="1.01" points="4,13 8,9 13,14"></polyline><polyline fill="none" stroke="#000" stroke-width="1.01" points="11,12 12.5,10.5 16,14"></polyline></svg></span> Your Data</a></li> -->
    <!--     <li class="uk-nav-divider"></li> -->
    <!--     <li><a href="#"><span data-uk-icon="icon: sign-out" class="uk-icon"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><polygon points="13.1 13.4 12.5 12.8 15.28 10 8 10 8 9 15.28 9 12.5 6.2 13.1 5.62 17 9.5"></polygon><polygon points="13 2 3 2 3 17 13 17 13 16 4 16 4 3 13 3"></polygon></svg></span> Logout</a></li> -->
    <!--     </ul> -->
    <!--   </div> -->
    <!--   </li> -->
    <!-- </ul> -->
    <!-- <div class="uk-navbar-item uk-visible@s"> -->
    <!--   <form action="dashboard.html" class="uk-search uk-search-default"> -->
    <!--   <span data-uk-search-icon="" class="uk-icon uk-search-icon"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><circle fill="none" stroke="#000" stroke-width="1.1" cx="9" cy="9" r="7"></circle><path fill="none" stroke="#000" stroke-width="1.1" d="M14,14 L18,18 L14,14 Z"></path></svg></span> -->
    <!--   <input class="uk-search-input search-field" type="search" placeholder="Search"> -->
    <!--   </form> -->
    <!-- </div> -->
    <!-- </div> -->
    <!-- <div class="uk-navbar-right"> -->
    <!-- <ul class="uk-navbar-nav"> -->
    <!--   <li><a href="#" data-uk-icon="icon:user" title="" data-uk-tooltip="" class="uk-icon" aria-expanded="false"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><circle fill="none" stroke="#000" stroke-width="1.1" cx="9.9" cy="6.4" r="4.4"></circle><path fill="none" stroke="#000" stroke-width="1.1" d="M1.5,19 C2.3,14.5 5.8,11.2 10,11.2 C14.2,11.2 17.7,14.6 18.5,19.2"></path></svg></a></li> -->
    <!--   <li><a href="#" data-uk-icon="icon: settings" title="" data-uk-tooltip="" class="uk-icon" aria-expanded="false"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><ellipse fill="none" stroke="#000" cx="6.11" cy="3.55" rx="2.11" ry="2.15"></ellipse><ellipse fill="none" stroke="#000" cx="6.11" cy="15.55" rx="2.11" ry="2.15"></ellipse><circle fill="none" stroke="#000" cx="13.15" cy="9.55" r="2.15"></circle><rect x="1" y="3" width="3" height="1"></rect><rect x="10" y="3" width="8" height="1"></rect><rect x="1" y="9" width="8" height="1"></rect><rect x="15" y="9" width="3" height="1"></rect><rect x="1" y="15" width="3" height="1"></rect><rect x="10" y="15" width="8" height="1"></rect></svg></a></li> -->
    <!--   <li><a href="#" data-uk-icon="icon:  sign-out" title="" data-uk-tooltip="" class="uk-icon" aria-expanded="false"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><polygon points="13.1 13.4 12.5 12.8 15.28 10 8 10 8 9 15.28 9 12.5 6.2 13.1 5.62 17 9.5"></polygon><polygon points="13 2 3 2 3 17 13 17 13 16 4 16 4 3 13 3"></polygon></svg></a></li> -->
    <!--   <li><a class="uk-navbar-toggle uk-icon uk-navbar-toggle-icon" data-uk-toggle="" data-uk-navbar-toggle-icon="" href="#offcanvas-nav" title="" data-uk-tooltip="" aria-expanded="false"><svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><rect y="9" width="20" height="2"></rect><rect y="3" width="20" height="2"></rect><rect y="15" width="20" height="2"></rect></svg></a></li> -->
    <!-- </ul> -->
    </div>
  </nav>
  </div>
</header>
<div id="top-spacer"></div>
</template>

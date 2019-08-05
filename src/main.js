import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'
import VueClipboard from 'vue-clipboard2'

Vue.use(VueClipboard)
Vue.use(VueRouter);

new Vue({
  el: '#app',
  mode:'hash',
  render: h => h(App)
})

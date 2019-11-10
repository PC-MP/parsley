import Vue from 'vue'
//import Vue from 'vue/dist/vue.esm'
import App from '../my_user_table.vue'
import 'bootstrap'
import '../src/datatable.css.scss'

require( 'datatables.net-bs4' )();

import TurbolinksAdapter from 'vue-turbolinks';
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  var element = document.getElementById("my_user_table")
  if (element != null) { (new Vue(App)).$mount(element) }
})

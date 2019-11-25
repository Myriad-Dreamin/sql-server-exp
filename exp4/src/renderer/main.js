

import Vue from 'vue';
import axios from 'axios';

import App from './App';
import router from './router';
import store from './store';

import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

Vue.use(ElementUI);

import { db } from '../module/mssql';

window.db = db;

let loginData = {
    uid: 'SA',
    pwd: '<xX123456>',
}

try {
    db.connect(loginData.uid, loginData.pwd);
    // await this.$router.push({name: 'book/insert-page'});
} catch (e) {
    window.console.log('error', e);
    // this.logining = false;
}

// eslint-disable-next-line no-undef
if (!process.env.IS_WEB) Vue.use(require('vue-electron'));
Vue.http = Vue.prototype.$http = axios;
Vue.config.productionTip = false;

/* eslint-disable no-new */
new Vue({
    components: { App },
    router,
    store,
    template: '<App/>'
}).$mount('#app');

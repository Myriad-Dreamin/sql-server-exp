import Vue from 'vue';
import Vuex from 'vuex';

import { createPersistedState, createSharedMutations } from 'vuex-electron';

import modules from './modules';

Vue.use(Vuex);

export default new Vuex.Store({
    modules,
    plugins: [
        createPersistedState(),
        createSharedMutations()
    ],
    // eslint-disable-next-line no-undef
    strict: process.env.NODE_ENV !== 'production'
});

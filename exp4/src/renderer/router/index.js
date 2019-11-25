import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/',
            name: 'login-page',
            component: require('@/components/Index').default
            // component: require('@/components/Login').default
        },
        {
            path: '/index',
            name: 'index-page',
            component: require('@/components/Index').default
        },
        {
            path: '/book/index',
            name: 'book/index-page',
            component: require('@/components/Book/Index').default
        },
        {
            path: '/book/insert',
            name: 'book/insert-page',
            component: require('@/components/Book/Insert').default
        },
        {
            path: '/book/delete',
            name: 'book/delete-page',
            component: require('@/components/Book/Delete').default
        },
        {
            path: '/book/update',
            name: 'book/update-page',
            component: require('@/components/Book/Update').default
        },
        {
            path: '/book/query',
            name: 'book/query-page',
            component: require('@/components/Book/Query').default
        },
        {
            path: '*',
            redirect: '/'
        }
    ]
});

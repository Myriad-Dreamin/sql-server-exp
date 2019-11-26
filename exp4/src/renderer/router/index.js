import db from '@module/mssql';
import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

let router = new Router({
    routes: [
        {
            path: '/login',
            name: 'login-page',
            component: require('@/components/Login').default
        },
        {
            path: '/index',
            name: 'index-page',
            component: require('@/components/Index').default
        },
        {
            path: '/config',
            name: 'config-page',
            component: require('@/components/Config').default
        },
        {
            path: '/todo',
            name: 'todo-page',
            component: require('@/components/Todo').default
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
            redirect: '/index'
        }
    ]
});

router.beforeEach(function (to, from, next) {
    if (to.name === 'index-page' || to.name === 'config-page') {
        next();
        return;
    }
    if (db.isLogin === false && to.name !== 'login-page') {
        router.push({name: 'login-page'}).then();
    }
    next();
});

export default router;

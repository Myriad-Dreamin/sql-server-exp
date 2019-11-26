<template>
    <bass-line>
        <template slot="header">
            <el-row class="retain-height">
                <el-col :span="20" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-breadcrumb separator-class="el-icon-arrow-right" class="vertical-align-div">
                            <el-breadcrumb-item :to="{ path: '/index' }">管理系统</el-breadcrumb-item>
                        </el-breadcrumb>
                        <div class="vertical-align-fill-div"></div>
                    </div
                    >
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font is-link" @click="target({name: 'config-page'})">设置</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font is-link" @click="processLogin">{{loginWord}}</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
            </el-row>
        </template>
        <div v-for="(routeTo, index) in routeToX" :key="index" slot="main">
            <el-divider v-if="index!==0"></el-divider>
            <el-row :gutter="20">
                <el-col :span="2"><div class="retain-height"></div></el-col>
                <el-col :span="4">
                    <el-link :underline="false" class="m-text" type="primary" @click="target(routeTo.target)">{{routeTo.lnkDesc}}</el-link>
                </el-col>
                <el-col :span="16">
                    <div class="m-text-container">
                        <p class="m-text" style="display: block;line-height: 100px;">
                            {{routeTo.description}}
                        </p></div>
                </el-col>
                <el-col :span="2"><div class="retain-height"></div></el-col>
            </el-row>
        </div>
    </bass-line>
</template>

<script>
import db from '@module/mssql';


export default {
    name: 'index-page',
    data() {
        return {
            db: db,
            routeToX : [{
                target: {name: 'book/index-page'},
                lnkDesc: '教材信息',
                description: '对数据库进行教材信息有关的操作',
            }, {
                target: {name: 'todo-page'},
                lnkDesc: '课程信息',
                description: '对数据库进行课程信息有关的操作',
            }, {
                target: {name: 'todo-page'},
                lnkDesc: '班级信息',
                description: '对数据库进行班级信息有关的操作',
            }, {
                target: {name: 'todo-page'},
                lnkDesc: '学校部门信息',
                description: '对数据库进行学校部门信息有关的操作',
            }, {
                target: {name: 'todo-page'},
                lnkDesc: '学生信息',
                description: '对数据库进行学生信息有关的操作',
            }, {
                target: {name: 'todo-page'},
                lnkDesc: '老师信息',
                description: '对数据库进行老师信息有关的操作',
            }],
        };
    },
    computed: {
        loginWord() {
            return this.db.isLogin ? '登出' : '登录';
        },
    },
    methods: {
        target(to) {
            this.$router.push(to);
        },
        processLogin() {
            if (this.db.isLogin) {
                this.db.close();
            }
            this.$router.push({name: 'login-page'});
        }
    }
};
</script>

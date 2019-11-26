<template>
    <bass-line>
        <el-row class="retain-height" slot="header">
            <el-col :span="20" class="retain-height">
                <div class="vertical-align-container">
                    <div class="vertical-align-fill-div"></div>
                    <el-breadcrumb separator-class="el-icon-arrow-right" class="vertical-align-div">
                        <el-breadcrumb-item :to="{ path: '/index' }">管理系统</el-breadcrumb-item>
                        <el-breadcrumb-item :to="{ name: 'book/index-page' }">教材信息</el-breadcrumb-item>
                    </el-breadcrumb>
                    <div class="vertical-align-fill-div"></div>
                </div>
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
        <template slot="main">
            <el-row :gutter="20">
                <el-col :span="2"><div class="retain-height"></div></el-col>
                <el-col :span="4">
                    <el-link :underline="false" class="m-text" type="primary" @click="target({name: 'book/insert-page'})">插入教材信息</el-link>
                </el-col>
                <el-col :span="16">
                    <div class="m-text-container">
                        <p class="m-text" style="display: block;line-height: 100px;">
                            插入一条或多条教材信息，允许从excel导入。支持对单条信息的操作。
                        </p></div>
                </el-col>
                <el-col :span="2"><div class="retain-height"></div></el-col>
            </el-row>
            <el-divider></el-divider>
            <el-row :gutter="20">
                <el-col :span="2"><div class="retain-height"></div></el-col>
                <el-col :span="4">
                    <el-link :underline="false" class="m-text" type="success" @click="target({name: 'book/query-page'})">查询教材信息</el-link>
                </el-col>
                <el-col :span="16">
                    <div class="m-text-container">
                        <p class="m-text" style="display: block;line-height: 100px;">
                            查询教材信息
                        </p></div>
                </el-col>
                <el-col :span="2"><div class="retain-height"></div></el-col>
            </el-row>
            <el-divider></el-divider>
            <el-row :gutter="20">
                <el-col :span="2"><div class="retain-height"></div></el-col>
                <el-col :span="4">
                    <el-link :underline="false" class="m-text" type="warning" @click="target({name: 'book/update-page'})">批量更新教材信息</el-link>
                </el-col>
                <el-col :span="16">
                    <div class="m-text-container">
                        <p class="m-text" style="display: block;line-height: 100px;">
                            批量更新
                        </p></div>
                </el-col>
                <el-col :span="2"><div class="retain-height"></div></el-col>
            </el-row>
            <el-divider></el-divider>
            <el-row :gutter="20">
                <el-col :span="2"><div class="retain-height"></div></el-col>
                <el-col :span="4">
                    <el-link :underline="false" class="m-text" type="danger" @click="target({name: 'book/delete-page'})">批量删除教材信息</el-link>
                </el-col>
                <el-col :span="16">
                    <div class="m-text-container">
                        <p class="m-text" style="display: block;line-height: 100px;">
                            插入一条或多条教材信息，允许从excel导入。支持对单条信息的操作。
                        </p></div>
                </el-col>
                <el-col :span="2"><div class="retain-height"></div></el-col>
            </el-row>
        </template>
    </bass-line>
</template>

<script>
import db from '@module/mssql';


export default {
    name: 'book/index-page',
    data() {
        return {
            db: db,
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

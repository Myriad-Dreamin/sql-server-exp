<template>
    <bass-line>
        <template slot="header">
            <el-row class="retain-height">
                <el-col :span="22" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-breadcrumb separator-class="el-icon-arrow-right" class="vertical-align-div">
                            <el-breadcrumb-item :to="{ path: '/index' }">管理系统</el-breadcrumb-item>
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
            </el-row>
        </template>
        <template slot="main">
            <el-row :gutter="20" class="retain-height" style="margin-left: 0; margin-right: 0;">
                <el-col :span="4"><div  class="retain-height"></div></el-col>
                <el-col :span="16" class="retain-height">
                    <div class="login-container">
                        <div class="login-fill-div"></div>
                        <el-form :model="loginData" :rules="rules2"
                                 status-icon
                                 ref="loginData"
                                 label-position="left"
                                 label-width="0px"
                                 class="login-div">
                            <el-row style="width: 100%;">
                                <el-col :span="4"><div  class="retain-height"></div></el-col>
                                <el-col :span="16" style="text-align: center;"><h3 class="title">登录</h3></el-col>
                                <el-col :span="4"><div  class="retain-height"></div></el-col>
                            </el-row>
                            <el-form-item prop="username">
                                <el-input type="text"
                                          v-model="loginData.uid"
                                          auto-complete="off"
                                          placeholder="用户名"
                                ></el-input>
                            </el-form-item>
                            <el-form-item prop="password">
                                <el-input type="password"
                                          v-model="loginData.pwd"
                                          auto-complete="off"
                                          placeholder="密码"
                                ></el-input>
                            </el-form-item>
                            <el-checkbox
                                    v-model="rememberMe"
                                    class="rememberme"
                            >记住密码
                            </el-checkbox>
                            <el-form-item style="width:100%;">
                                <el-button type="primary" style="width:100%;" @click="handleSubmit" :loading="logining">冲
                                </el-button>
                            </el-form-item>
                        </el-form>
                        <div class="login-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="4">
                    <div  class="retain-height"></div>
                </el-col>
            </el-row>
        </template>
    </bass-line>
</template>

<script>
import db from '@module/mssql';
import {usrCfg} from '@module/config';
let loginData = usrCfg.get('login-pair', {
    uid: '',
    pwd: '',
});

export default {
    name: 'login-page',
    data() {
        return {
            logining: false,
            loginData: loginData,
            rules2: {
                uid: [{required: true, message: '请输入您的账户', trigger: 'blur'}],
                pwd: [{required: true, message: '请输入您的密码', trigger: 'blur'}]
            },
            rememberMe: false
        };
    },
    methods: {
        target(to) {
            this.$router.push(to);
        },
        handleSubmit() {
            this.$refs.loginData.validate(async (valid) => {
                if (valid) {
                    this.logining = true;
                    try {
                        await db.connect(this.loginData.uid, this.loginData.pwd);
                        if (this.rememberMe) {
                            usrCfg.set('login-pair', this.loginData);
                        }
                        await this.$router.push({name: 'index-page'});
                    } catch (e) {
                        window.console.log('error', e);
                        this.logining = false;
                    }
                } else {
                    console.log('error submit!');
                    return false;
                }
            });
        }
    }
};
</script>

<style scoped>

    .login-fill-div {
        flex: 2;
        min-width: 1px;
        min-height: 10px;
    }

    .login-div {
        flex: 5;
        height: 100%;
        border: 1px solid #eaeaea;
        box-shadow: 0 0 25px #cac6c6;
        padding: 0 100px;
    }

    .login-container {
        width: 100%;
        height: 100%;
        display: flex;
        flex-flow: column;
    }

    label.el-checkbox.rememberme {
        margin: 0px 0px 15px;
        text-align: left;
    }
</style>
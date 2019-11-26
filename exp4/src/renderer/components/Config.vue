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
                        <el-button type="text" class="head-font is-link" @click="saveConfig">保存</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
            </el-row>
        </template>
        <template slot="main">
            <el-row class="retain-height">
                <el-col :span="2" class="retain-height">
                </el-col>
                <el-col :span="20" class="retain-height">
                    <h2>DSN配置名</h2>
                    <el-form ref="form" :model="cfgData" label-width="120px">
                        <el-form-item label="隐私配置目录">
                            <el-input v-model="cfgData.dsn"></el-input>
                        </el-form-item>
                        <p style="color: #606266; font-size: 14px; margin-bottom: 22px;">
                            使用的ODBC配置名，默认值为stmssql</p>
                   </el-form>
                    <h2>隐私配置路径</h2>
                    <el-form ref="form" :model="cfgData" label-width="120px">
                        <el-form-item label="隐私配置目录">
                            <el-input v-model="cfgData.path"></el-input>
                        </el-form-item>
                        <p style="color: #606266; font-size: 14px; margin-bottom: 22px;">
                            隐私配置的本机文件路径，如果文件路径为/abc/def/ghi.json，那么对应应填/abc/def</p>
                        <el-form-item label="隐私配置文件名">
                            <el-input v-model="cfgData.name"></el-input>
                        </el-form-item>
                        <p style="color: #606266; font-size: 14px;">
                            隐私配置的本机文件名，如果文件路径为/abc/def/ghi.json，那么对应应填ghi.json。
                        </p>
                        <p style="color: #606266; font-size: 14px; margin-bottom: 22px;">
                            一个合法的ghi.json配置项选项示例如下：
                        </p>
                        <pre>
<code class="language-json">{
    "login-pair": {
        "uid": "SA",
        "pwd": "&lt;xX123456&gt;"
    }
}</code>
                        </pre>
                    </el-form>
                </el-col>
                <el-col :span="2" class="retain-height">
                </el-col>
            </el-row>
        </template>
    </bass-line>
</template>

<script>
import {cfg} from '../../module/config';

export default {
    name: 'config-page',
    data() {
        return {
            cfgData: cfg.get(undefined),
        };
    },
    methods: {
        target(to) {
            this.$router.push(to);
        },
        saveConfig() {
            cfg.set(this.cfgData);
        }
    }
};
</script>

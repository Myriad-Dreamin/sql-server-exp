<template>
    <el-container class="retain-height m-container">
        <el-header class="m-header">
            <el-row class="retain-height">
                <el-col :span="24" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-breadcrumb separator-class="el-icon-arrow-right" class="vertical-align-div">
                            <el-breadcrumb-item :to="{ path: '/' }">管理系统</el-breadcrumb-item>
                            <el-breadcrumb-item :to="{ name: 'book/index-page' }">教材信息</el-breadcrumb-item>
                        </el-breadcrumb>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
<!--                <el-col :span="2" class="retain-height">-->
<!--                    <div class="vertical-align-container">-->
<!--                        <div class="vertical-align-fill-div"></div>-->
<!--                        <el-button type="text" class="head-font">导入</el-button>-->
<!--                        <div class="vertical-align-fill-div"></div>-->
<!--                    </div>-->
<!--                </el-col>-->
<!--                <el-col :span="2" class="retain-height">-->
<!--                    <div class="vertical-align-container">-->
<!--                        <div class="vertical-align-fill-div"></div>-->
<!--                        <el-button type="text" class="head-font">全部提交</el-button>-->
<!--                        <div class="vertical-align-fill-div"></div>-->
<!--                    </div>-->
<!--                </el-col>-->
<!--                <el-col :span="2" class="retain-height">-->
<!--                    <div class="vertical-align-container">-->
<!--                        <div class="vertical-align-fill-div"></div>-->
<!--                        <el-button type="text" class="head-font" style="font-size: 20px;" @click="addItem()">+</el-button>-->
<!--                        <div class="vertical-align-fill-div"></div>-->
<!--                    </div>-->
<!--                </el-col>-->
            </el-row>
        </el-header>
        <el-main>
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
        </el-main>
    </el-container>
</template>

<script>
// import db from '../../../module/mssql';


export default {
    data() {
        return {

        };
    },
    methods: {
        target(to) {
            this.$router.push(to);
        }
    }
};
</script>

<style scoped>

    /deep/ .el-breadcrumb__item:last-child .el-breadcrumb__inner,
    /deep/ .el-breadcrumb__inner,
    /deep/ .el-breadcrumb__inner:hover,
    /deep/ .el-breadcrumb__inner.is-link,
    .head-font, .head-font:focus {
        color: #cccccc;
    }

    /deep/ .el-breadcrumb__item:last-child .el-breadcrumb__inner:hover,
    /deep/ .el-breadcrumb__inner.is-link:hover,
    .head-font.is-link:hover {
        color: #ffffff;
    }

    .vertical-align-container {
        width: 100%;
        height: 100%;
        display: flex;
        flex-flow: column;
    }

    .vertical-align-fill-div {
        flex: 1;
        min-width: 1px;
        min-height: 1px;
    }

    .vertical-align-div {
        min-width: 1px;
        min-height: 1px;
    }

    .m-container {
        padding: 0 0;
    }

    .m-header {
        /*border: 1px solid #eaeaea;*/
        z-index: 1;
        box-shadow: 0 0 25px #000505;
        padding: 0 0 0 8%;
        height: 5%;
        background-color: #545c64;
    }
    .m-body {
        height: 95%;
    }

    .book-item {
        width: 100%;
    }

    .m-text {
        word-wrap: break-word;
        word-break: break-all;
        font-size: 14px;
        height: 100px;
        margin: auto;
    }

    .m-text-container {
        vertical-align:middle;
    }

</style>
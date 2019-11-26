<template>
    <el-container class="retain-height m-container">
        <el-header class="m-header">
            <slot name="header"></slot>
        </el-header>
        <el-main>
            <slot name="main"></slot>
        </el-main>
    </el-container>
</template>

<script>
// import db from '../../../module/mssql';


export default {
    name: 'base-impl',
};
</script>

<style scoped>
    @import '../assets/css/base.css';
    /deep/ .el-breadcrumb__item:last-child .el-breadcrumb__inner,
    /deep/ .el-breadcrumb__inner,
    /deep/ .el-breadcrumb__inner:hover,
    /deep/ .el-breadcrumb__inner.is-link,
    /deep/ .head-font,/deep/  .head-font:focus {
        color: #cccccc;
    }
    /deep/ .el-breadcrumb__item:last-child .el-breadcrumb__inner:hover,
    /deep/ .el-breadcrumb__inner.is-link:hover,
    /deep/ .head-font.is-link:hover {
        color: #ffffff;
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
</style>

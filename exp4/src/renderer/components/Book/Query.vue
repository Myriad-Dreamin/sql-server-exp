<template>
    <el-container class="retain-height m-container">
        <el-header class="m-header">
            <el-row class="retain-height">
                <el-col :span="18" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-breadcrumb separator-class="el-icon-arrow-right" class="vertical-align-div">
                            <el-breadcrumb-item :to="{ path: '/' }">管理系统</el-breadcrumb-item>
                            <el-breadcrumb-item :to="{ name: 'book/index-page' }">教材信息</el-breadcrumb-item>
                            <el-breadcrumb-item :to="{ name: 'book/query-page' }">查看教材</el-breadcrumb-item>
                        </el-breadcrumb>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="4" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <span class="head-font" style="font-size: 10px;">总共{{bookCount}}条, 当前页{{bookInfos.length}}条结果, 用时{{timeCost}}ms</span>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <el-row class="retain-height">
                        <el-col :span="10" class="retain-height">
                            <div class="vertical-align-container">
                                <div class="vertical-align-fill-div"></div>
                                <el-button type="text" class="head-font is-link" style="font-size: 20px;" @click="prevPage()">&lt;</el-button>
                                <div class="vertical-align-fill-div"></div>
                            </div>
                        </el-col>
                        <el-col :span="4" class="retain-height">
                            <div class="vertical-align-container">
                                <div class="vertical-align-fill-div"></div>
                                <el-button type="text" class="head-font is-link">{{pageNumber}}</el-button>
                                <div class="vertical-align-fill-div"></div>
                            </div>
                        </el-col>
                        <el-col :span="10" class="retain-height">
                            <div class="vertical-align-container">
                                <div class="vertical-align-fill-div"></div>
                                <el-button type="text" class="head-font is-link" style="font-size: 20px;" @click="nextPage()">&gt;</el-button>
                                <div class="vertical-align-fill-div"></div>
                            </div>
                        </el-col>
                    </el-row>
                </el-col>
            </el-row>
        </el-header>
        <el-main>
            <el-table
                :data="bookInfos"
                style="width: 100%"
                fit>
                <el-table-column
                        prop="id"
                        label="编号">
                </el-table-column>
                <el-table-column
                        prop="name"
                        label="名称">
                </el-table-column>
                <el-table-column
                        prop="publish"
                        label="出版社">
                </el-table-column>
                <el-table-column
                        prop="author"
                        label="作者">
                </el-table-column>
                <el-table-column
                        prop="price"
                        label="价格">
                </el-table-column>
            </el-table>
        </el-main>
    </el-container>
</template>

<script>
import db from '../../../module/mssql';


export default {
    data() {
        return {
            bookInfos: [],
            pageCount: 10,
            pageNumber: 1,
            bookCount: 0,
            timeCost: 0,
        };
    },
    async mounted() {
        // sleep();
        await this.update();
    },
    methods: {
        async update() {
            let dt = Date.now();
            let result = await db.query(this.pageCount, this.pageNumber);
            this.bookCount = result.bookCount;
            this.bookInfos = result.bookInfos;
            this.timeCost = Date.now() - dt;
        },
        async prevPage() {
            if (this.pageNumber > 1) {
                this.pageNumber = this.pageNumber - 1;
            }
            await this.update();
        },
        async nextPage() {
            if (this.pageNumber * this.pageCount < this.bookCount) {
                this.pageNumber = this.pageNumber + 1;
            }
            await this.update();
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
</style>
<template>
    <bass-line>
        <template slot="header">
            <el-row class="retain-height">
                <el-col :span="18" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-breadcrumb separator-class="el-icon-arrow-right" class="vertical-align-div">
                            <el-breadcrumb-item :to="{ path: '/index' }">管理系统</el-breadcrumb-item>
                            <el-breadcrumb-item :to="{ name: 'book-index-page' }">教材信息</el-breadcrumb-item>
                            <el-breadcrumb-item :to="{ name: 'book-query-page' }">查看教材</el-breadcrumb-item>
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
        </template>
        <template slot="main">
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
        </template>
    </bass-line>
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
            try {
                let dt = Date.now();
                let result = await db.query(this.pageCount, this.pageNumber);
                this.bookCount = result.bookCount;
                this.bookInfos = result.bookInfos;
                this.timeCost = Date.now() - dt;
            }catch (e) {
                this.$message.error('查询错误：' + e.toString());
            }
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

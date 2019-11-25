<template>
    <el-container class="retain-height m-container">
        <el-header class="m-header">
            <el-row class="retain-height">
                <el-col :span="16" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-breadcrumb separator-class="el-icon-arrow-right" class="vertical-align-div">
                            <el-breadcrumb-item :to="{ path: '/' }">管理系统</el-breadcrumb-item>
                            <el-breadcrumb-item :to="{ name: 'book/index-page' }">教材信息</el-breadcrumb-item>
                            <el-breadcrumb-item :to="{ name: 'book/delete-page' }">批量删除</el-breadcrumb-item>
                        </el-breadcrumb>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="4" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <div class="head-font" style="font-size: 12px; float: right; text-align: right; padding: 0 3px;">{{matchCount}}条数据</div>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font" @click="filter">过滤！</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font" @click="removeWithFilter">删除！</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
            </el-row>
        </el-header>
        <el-main>
            <el-card style="margin: 20px 0;" class="book-item">
                <el-row  :gutter="20">
                    <el-col :xs="24" :span="4">
                        <el-input v-model="bookFilter.id" :disabled="bookFilterClosed.id" placeholder="编号">
                            <template slot="prepend">
                                <el-link class="m-refer" :underline="false" @click="switchState('id')">根据</el-link>
                            </template>
                        </el-input>
                    </el-col>
                    <el-col :xs="24" :span="5">
                        <el-input v-model="bookFilter.name" :disabled="bookFilterClosed.name" placeholder="名称">
                            <template slot="prepend">
                                <el-link class="m-refer" :underline="false" @click="switchState('name')">根据</el-link>
                            </template>
                        </el-input>
                    </el-col>
                    <el-col :xs="24" :span="5">
                        <el-input v-model="bookFilter.publish" :disabled="bookFilterClosed.publish" placeholder="出版社">
                            <template slot="prepend">
                                <el-link class="m-refer" :underline="false" @click="switchState('publish')">根据</el-link>
                            </template>
                        </el-input>
                    </el-col>
                    <el-col :xs="24" :span="5">
                        <el-input v-model="bookFilter.author" :disabled="bookFilterClosed.author" placeholder="作者">
                            <template slot="prepend">
                                <el-link class="m-refer" :underline="false" @click="switchState('author')">根据</el-link>
                            </template>
                        </el-input>
                    </el-col>
                    <el-col :xs="24" :span="5">
                        <el-input v-model="bookFilter.price" :disabled="bookFilterClosed.price" placeholder="价格">
                            <template slot="prepend">
                                <el-link class="m-refer" :underline="false" @click="switchState('price')">根据</el-link>
                            </template>
                        </el-input>
                    </el-col>
                </el-row>
            </el-card>
            <p style="text-align: center; font-size: 14px;">下面是前五条数据QAQ</p>
            <el-divider></el-divider>
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

            <el-dialog
                    title="提醒"
                    :visible.sync="removeCheckDialog"
                    width="30%">
                <span>确定要删除吗！？</span>
                    <span slot="footer" class="dialog-footer">
                    <el-button @click="removeCheckDialog = false">取消</el-button>
                    <el-button type="primary" @click="removeWithFilterCallback">确认</el-button>
              </span>
            </el-dialog>
        </el-main>
    </el-container>
</template>

<script>
import db from '../../../module/mssql';


export default {
    data() {
        return {
            bookInfos: [],
            bookFilter: {
                id: '',
                name: '',
                publish: '',
                author: '',
                price: '',
            },
            bookFilterClosed: {
                id: true,
                name: true,
                publish: true,
                author: true,
                price: true,
            },

            matchCount: 0,
            limitation: 5,
            removeCheckDialog: false,
        };
    },
    methods: {
        switchState(columnName) {
            console.log(columnName);
            this.bookFilterClosed[columnName] = !this.bookFilterClosed[columnName];
        },
        async filter() {
            let result = await db.query(this.limitation, 1, this.checkWhereStmt());
            this.matchCount = result.bookCount;
            this.bookInfos = result.bookInfos;
        },
        removeWithFilter() {
            this.removeCheckDialog = true;
        },
        async removeWithFilterCallback() {
            this.removeCheckDialog = false;
            const connection = await db.db.connect();
            const statement = await connection.createStatement();
            console.log('delete from book ' + this.checkWhereStmt());
            await statement.prepare('delete from book ' + this.checkWhereStmt());
            await statement.execute();
            await connection.close();
            this.filter();
        },
        checkWhereStmt() {
            let stmt = '';
            if (this.bookFilterClosed.id === false) {
                stmt = stmt + ((stmt === '') ? '' : ' and ') + 'id = \'' + this.bookFilter.id +'\'';
            }
            if (this.bookFilterClosed.name === false) {
                stmt = stmt + ((stmt === '') ? '' : ' and ') + 'name = N\'' + this.bookFilter.name +'\'';
            }
            if (this.bookFilterClosed.publish === false) {
                stmt = stmt + ((stmt === '') ? '' : ' and ') + 'publish = N\'' + this.bookFilter.publish +'\'';
            }
            if (this.bookFilterClosed.author === false) {
                stmt = stmt + ((stmt === '') ? '' : ' and ') + 'author = N\'' + this.bookFilter.author +'\'';
            }
            if (this.bookFilterClosed.price === false) {
                stmt = stmt + ((stmt === '') ? '' : ' and ') + 'price = ' + this.bookFilter.price;
            }
            if (stmt !== '') {
                stmt = 'where ' + stmt;
            }
            return stmt;
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

    /deep/ .m-refer .el-link--inner:hover {
        color: #cccccc;
    }
    /deep/ .m-refer .el-link--inner {
        transition: all 0.2s;
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

</style>
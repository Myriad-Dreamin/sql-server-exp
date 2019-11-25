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
                            <el-breadcrumb-item :to="{ name: 'book/insert-page' }">新的教材</el-breadcrumb-item>
                        </el-breadcrumb>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font">导入</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font">全部提交</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font" style="font-size: 20px;" @click="addItem()">+</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
            </el-row>
        </el-header>
        <el-main>
            <el-card style="margin: 20px 0;" class="book-item" v-for="(bookInfo, index) in bookInfos" :key="index">
                <div slot="header" class="clearfix">
                    <el-row :gutter="20">
                        <el-col :xs="24" :span="18">
                            <el-input v-model="bookInfo.name" placeholder="名称">
                                <template slot="prepend">书籍</template>
                            </el-input>
                        </el-col>
                        <el-col :xs="12" :span="3">
                            <div class="vertical-align-container">
                                <div class="vertical-align-fill-div"></div>
                                <el-button plain @click="submitItem(index)">提交</el-button>
                                <div class="vertical-align-fill-div"></div>
                            </div>
                        </el-col>
                        <el-col :xs="12" :span="3">
                            <div class="vertical-align-container">
                                <div class="vertical-align-fill-div"></div>
                                <el-button plain @click="removeItem(index)">删除</el-button>
                                <div class="vertical-align-fill-div"></div>
                            </div>
                        </el-col>
                    </el-row>
                </div>

                <el-row :gutter="20">
                    <el-col :xs="24" :span="6">
                        <el-input v-model="bookInfo.id" placeholder="编号"></el-input>
                    </el-col>
                    <el-col :xs="24" :span="6">
                        <el-input v-model="bookInfo.publish" placeholder="出版社"></el-input>
                    </el-col>
                    <el-col :xs="24" :span="6">
                        <el-input v-model="bookInfo.author" placeholder="作者"></el-input>
                    </el-col>
                    <el-col :xs="24" :span="6">
                        <el-input v-model="bookInfo.price" placeholder="价格"></el-input>
                    </el-col>
                </el-row>
            </el-card>
        </el-main>
    </el-container>
</template>

<script>
import db from '../../../module/mssql';


export default {
    data() {
        return {
            bookInfos: [{
                id: '',
                name: '',
                publish: '',
                author: '',
                price: '',
            }],
            isCollapse: true,
        };
    },
    methods: {
        async submitItem(index) {
            console.log(this.bookInfos);
            const connection = await db.db.connect();
            const statement = await connection.createStatement();
            await statement.prepare('insert into book values(?, ?, ?, ?, ?)');
            await statement.bind(
                [this.bookInfos[index].id, this.bookInfos[index].name,
                    this.bookInfos[index].publish, this.bookInfos[index].author,
                    parseFloat(this.bookInfos[index].price)]);
            const result = await statement.execute();
            console.log(result);
            await statement.close();
            this.removeItem(index);
        },
        async submitItems() {
            console.log(this.bookInfos);
        },
        addItem() {
            this.bookInfos.push({
                id: '',
                name: '',
                publish: '',
                author: '',
                price: '',
            });
            // console.log(this.bookInfos);
        },
        removeItem(index) {
            return this.bookInfos.splice(index, 1);
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

</style>
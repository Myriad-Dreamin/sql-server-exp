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
                            <el-breadcrumb-item :to="{ name: 'book-insert-page' }">新的教材</el-breadcrumb-item>
                        </el-breadcrumb>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font is-link" @click="importFrom">导入</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font is-link" @click="submitItems">全部提交</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
                <el-col :span="2" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-button type="text" class="head-font is-link" style="font-size: 20px;" @click="addItem()">+</el-button>
                        <div class="vertical-align-fill-div"></div>
                    </div>
                </el-col>
            </el-row>
        </template>
        <el-card slot="main" style="margin: 20px 0;" class="book-item" v-for="(bookInfo, index) in bookInfos" :key="index">
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
    </bass-line>
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
            try {
                const connection = await db.db.connect();
                const statement = await connection.createStatement();
                await statement.prepare('insert into book values(?, ?, ?, ?, ?)');
                await statement.bind(
                    [this.bookInfos[index].id, this.bookInfos[index].name,
                        this.bookInfos[index].publish, this.bookInfos[index].author,
                        parseFloat(this.bookInfos[index].price)]);
                await statement.execute();
                await statement.close();
                this.removeItem(index);
            } catch (e) {
                this.$message.error('提交错误: ' + e.toString());
            }
        },
        async submitItems() {
            try {
                const connection = await db.db.connect();
                const statement = await connection.createStatement();
                await statement.prepare('insert into book values(?, ?, ?, ?, ?)');
                for (let index = this.bookInfos.length - 1; index >= 0; index--) {
                    await statement.bind(
                        [this.bookInfos[index].id, this.bookInfos[index].name,
                            this.bookInfos[index].publish, this.bookInfos[index].author,
                            parseFloat(this.bookInfos[index].price)]);
                    await statement.execute();
                    this.removeItem(index);
                }
                await statement.close();
            } catch (e) {
                this.$message.error('提交错误: ' + e.toString());
            }
        },
        importFrom() {

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
.book-item {
    width: 100%;
}
</style>
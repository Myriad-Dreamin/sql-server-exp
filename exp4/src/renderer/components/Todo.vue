<template>
    <bass-line>
        <template slot="header">
            <el-row class="retain-height">
                <el-col :span="24" class="retain-height">
                    <div class="vertical-align-container">
                        <div class="vertical-align-fill-div"></div>
                        <el-breadcrumb separator-class="el-icon-arrow-right" class="vertical-align-div">
                            <el-breadcrumb-item :to="{ path: '/index' }">管理系统</el-breadcrumb-item>
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
        </template>
        <div slot="main">OPS! 这个页面还没编写完呢！</div>
    </bass-line>
</template>

<script>
export default {
    name: 'todo-page',
    methods: {
        target(to) {
            this.$router.push(to);
        }
    }
};
</script>






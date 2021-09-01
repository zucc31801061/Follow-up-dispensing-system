<template>
	<div class="menucontent">
		<el-menu :default-active="currentpage" class="el-menu-vertical-demo" background-color="#545c64"
			text-color="#fff" active-text-color="#ffd04b">
			<div class="avatarbox">
				<el-image class="head" :src="userinfo.avatarUrl"></el-image>
				<div>{{userinfo.doctorName}}</div>
			</div>
			<el-menu-item index="1" @click="topath1">
				<i class="el-icon-s-platform" style="font-size: 32px"></i>
				<span slot="title" class="menutitle">问诊管理</span>
			</el-menu-item>
			<el-menu-item index="2" @click="topath2">
				<i class="el-icon-s-order menuicon" style="font-size: 32px"></i>
				<span slot="title" class="menutitle">我的信息</span>
			</el-menu-item>
		</el-menu>
	</div>
</template>

<script>
	export default {
		props: ["currentpage"],
		data() {
			return {
				userinfo: this.GLOBAL.doctorinfo
			}
		},
		mounted() {
			// console.log(this.currentpage)
		},
		methods: {
			topath1() {
				this.$router.push({
					path: "/mainpage"
				});
			},
			topath2() {
				this.$router.push({
					path: "/mypage"
				});
			}
		}
	}
</script>

<style scoped>
	.menucontent {
		height: 100vh;
		background-color: #545c64;
	}

	.avatarbox {
		height: 200px;
		text-align: center;
		font-size: 20px;
		color: #ffffff
	}

	.menuicon {
		font-size: 100px;
	}

	.menutitle {
		margin-left: 20px;
	}
	
	.head{
		width: 80px; 
		height: 80px; 
		margin: 50px 0 20px 0; 
		border-radius:50px
	}
</style>

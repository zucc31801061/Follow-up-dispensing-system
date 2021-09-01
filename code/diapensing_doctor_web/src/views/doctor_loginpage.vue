<template>
	<div class="content">
		<el-row class="window">
			<el-col :model="user" :offset="15" :span="5">
				<el-card class="login-box" v-loading="$store.state.loading"
					element-loading-background="rgba(0, 0, 0, 0.8)">
					<el-form>
						<h2 class="title">欢迎使用复诊配药系统</h2>
						<el-form-item>
							<el-input type="text" v-model="user.userName" auto-complete="off" placeholder="请输入用户名"
								suffix-icon="el-icon-bell"></el-input>
						</el-form-item>
						<el-form-item>
							<el-input type="password" v-model="user.password" auto-complete="off" placeholder="请输入密码"
								suffix-icon="el-icon-edit"></el-input>
						</el-form-item>
						<el-form-item>
							<el-button type="primary" @click="login" :loading="$store.state.loading" class="pull-right"
								style="width:100%">登录</el-button>
						</el-form-item>
					</el-form>
				</el-card>
			</el-col>
		</el-row>
	</div>
</template>

<script>
	const axios = require('axios');
	export default {
		name: "Login",
		data() {
			return {
				user: {
					userName: "",
					password: ""
				}
			};
		},
		methods: {
			login() {
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/doctor/getById?id=" + this.user.userName,
				}).then((res) => {
					if (res.data.state) {
						axios({
							method: "get",
							url: "http://localhost:8888/Demo/department/getById?id=" + res.data.doctor
								.deptId,
						}).then((res1) => {
							if (res1.data.state) {
								eval("res.data.doctor." + "deptName" + "='" + res1.data.department
									.deptName + "'");
							}
							else{
								eval("res.data.doctor." + "deptName" + "='" + "'");
							}
						});
						this.$router.push({
							path: "/mainpage"
						});
						this.$message({
							showClose: true,
							type: 'success',
							message: '登录成功!'
						});
						//res.data.doctor[deptName] = res1.data.department.deptName;
						this.GLOBAL.doctorinfo = res.data.doctor;
					} else {
						this.$message({
							showClose: true,
							type: 'error',
							message: res.data.msg
						});
					}
				})
			}
		},
		mounted: function() {
			axios({
				method: "get",
				url: "http://localhost:8888/Demo/drug/findAll",
			}).then((res) => {
				this.GLOBAL.basedrug = res.data
			});
			axios({
				method: "get",
				url: "http://localhost:8888/Demo/diagnosis/findAll",
			}).then((res) => {
				this.GLOBAL.basediagnosis = res.data;
			});
			axios({
				method: "get",
				url: "http://localhost:8888/Demo/frequency/findAll",
			}).then((res) => {
				this.GLOBAL.basefrequency = res.data;
			});
			axios({
				method: "get",
				url: "http://localhost:8888/Demo/usage/findAll",
			}).then((res) => {
				this.GLOBAL.baseusage = res.data;
			});
		}
	};
</script>

<style scoped>
	.content {
		background-image: url(../assets/backgroundpic.jpg);
		height: 100%;
		width: 100%;
		background-size: 100% 100%;
		position: fixed;
	}

	.login-box {
		background: #ffffff;
		border: none;
	}

	.login-box-msg {
		color: #000000;
		text-align: center;
	}

	.login-box .title {
		color: #333333;
		text-align: center;
	}

	.window {
		top: 50%;
		transform: translateY(-50%);
		-webkit-transform: translateY(-50%);
	}
</style>

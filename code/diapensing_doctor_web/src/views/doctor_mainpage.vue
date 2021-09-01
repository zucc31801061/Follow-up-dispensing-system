<template>
	<div class="mainpage">
		<el-container>
			<el-aside width="20%">
				<navmenu :currentpage="'1'" />
			</el-aside>
			<el-container>
				<el-header>
					<el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal"
						active-text-color="#1477fe" text-color="#b9b9b9">
						<el-menu-item index="1" @click="changeto1">待处理</el-menu-item>
						<el-menu-item index="2" @click="changeto2">进行中</el-menu-item>
						<el-menu-item index="3" @click="changeto3">已完成</el-menu-item>
					</el-menu>
				</el-header>
				<el-main class="list">
					<div v-if="activeIndex=='1'">
						<el-table :data="patientlist1" border style="width: 561px" max-height="620">
							<el-table-column prop="personName" label="患者姓名" width="150">
							</el-table-column>
							<el-table-column prop="personPhoneNo" label="电话号码" width="150">
							</el-table-column>
							<el-table-column prop="personAge" label="年龄" width="80">
							</el-table-column>
							<el-table-column label="操作" width="180">
								<template slot-scope="scope">
									<el-button @click="selectConsult(scope.row)" type="text" size="medium">查看
									</el-button>
									<el-button @click="updateIng(scope.row)" type="text" size="medium">接诊</el-button>
								</template>
							</el-table-column>
						</el-table>
					</div>
					<div v-if="activeIndex=='2'">
						<el-table :data="patientlist2" border style="width: 561px" max-height="620">
							<el-table-column prop="personName" label="患者姓名" width="150">
							</el-table-column>
							<el-table-column prop="personPhoneNo" label="电话号码" width="150">
							</el-table-column>
							<el-table-column prop="personAge" label="年龄" width="80">
							</el-table-column>
							<el-table-column label="操作" width="180">
								<template slot-scope="scope">
									<el-button @click="selectConsult(scope.row)" type="text" size="medium">查看
									</el-button>
								</template>
							</el-table-column>
						</el-table>
					</div>
					<div v-if="activeIndex=='3'">
						<el-table :data="patientlist3" border style="width: 561px" max-height="620">
							<el-table-column prop="personName" label="患者姓名" width="150">
							</el-table-column>
							<el-table-column prop="personPhoneNo" label="电话号码" width="150">
							</el-table-column>
							<el-table-column prop="personAge" label="年龄" width="80">
							</el-table-column>
							<el-table-column label="操作" width="180">
								<template slot-scope="scope">
									<el-button @click="selectConsult(scope.row)" type="text" size="medium">查看
									</el-button>
								</template>
							</el-table-column>
						</el-table>
					</div>
				</el-main>
			</el-container>
		</el-container>
	</div>
</template>

<script>
	const axios = require('axios');
	import navmenu from '../components/navmenu.vue'
	export default {
		components: {
			navmenu
		},
		data() {
			return {
				activeIndex: "1",
				patientlist1: [],
				patientlist2: [],
				patientlist3: []
			}
		},
		methods: {
			changeto1() {
				this.activeIndex = "1"
			},
			changeto2() {
				this.activeIndex = "2"
			},
			changeto3() {
				this.activeIndex = "3"
			},
			selectConsult(row) {
				this.$router.push({
					path: "/dispensing/" + row.consultId
				});
			},
			updateIng(row) {
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/consult/updateIng?id=" + row.consultId,
				}).then((res) => {
					if (res.data.state) {
						this.$message({
							showClose: true,
							type: 'success',
							message: res.data.msg
						});
						this.refresh();
					} else {
						this.$message({
							showClose: true,
							type: 'error',
							message: res.data.msg
						});
					}
				});
			},
			refresh() {
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/consult/findByDoc?id=" + this.GLOBAL.doctorinfo.doctorId,
				}).then((res) => {
					this.patientlist1 = [];
					this.patientlist2 = [];
					this.patientlist3 = [];
					res.data.forEach(element => {
						if (element.consultStatus == "待接诊") {
							this.patientlist1.push(element)
						} else if (element.consultStatus == "进行中") {
							this.patientlist2.push(element)
						} else if (element.consultStatus == "已完成") {
							this.patientlist3.push(element)
						}
					});
				})
			}
		},
		mounted: function() {
			this.refresh();
		}
	}
</script>

<style scoped>
	.list {
		height: 100%;
	}
</style>

<template>
	<div class="mypage">
		<el-container>
			<el-aside width="20%">
				<navmenu :currentpage="'2'" />
			</el-aside>
			<el-container>
				<el-main>
					<div class="doctorinfo">
						<div class="avatarbox">
							<el-image class="head" :src="doctorinfo.avatarUrl"></el-image>
						</div>
						<p>姓名：&nbsp;{{doctorinfo.doctorName}}</p>
						<p>所属机构：&nbsp;{{doctorinfo.orgName}}</p>
						<p>所属科室：&nbsp;{{doctorinfo.deptName}}</p>
						<p>职位：&nbsp;{{doctorinfo.levelName}}</p>
					</div>
				</el-main>
				<el-footer class="buttonbox">
					<el-button type="primary" @click="dialog()">修改信息</el-button>
				</el-footer>
			</el-container>
		</el-container>
		<el-dialog title="修改信息" :visible.sync="updateDialog" width="30%">
			<el-form ref="updateData" :rules="rules" :model="updateData" label-width="90px">
				<el-form-item label="姓名" prop="doctorName">
					<el-input v-model="updateData.doctorName" style="width: 80%;margin-left: 15px;" placeholder="请输入姓名"></el-input>
				</el-form-item>
				<el-form-item label="所属机构" prop="orgName">
					<el-input v-model="updateData.orgName" style="width: 80%;margin-left: 15px;" placeholder="请输入所属机构">></el-input>
				</el-form-item>
				<el-form-item label="所属科室" prop="deptName">
					<el-select v-model="updateData.deptId" filterable placeholder="请选择所属科室" style="width: 80%;margin-left: 15px;">
						<el-option v-for="data in dept" :label="data.deptName" :value="data.deptId"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="职位" prop="levelName">
					<el-select v-model="updateData.levelName" placeholder="请选择职位" style="width: 80%;margin-left: 15px;">
						<el-option label="主任医师" value="主任医师"></el-option>
						<el-option label="副主任医师" value="副主任医师"></el-option>
						<el-option label="主治医师" value="主治医师"></el-option>
						<el-option label="医师" value="医师"></el-option>
						<el-option label="医士" value="医士"></el-option>
					</el-select>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button type="primary" @click="update('updateData')">确认</el-button>
				<el-button type="danger" @click="updateDialog = false">取消</el-button>
			</span>
		</el-dialog>
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
				dept: [],
				updateDialog: false,
				doctorinfo: this.GLOBAL.doctorinfo,
				updateData: {},
				rules: {
					doctorName: [{
							required: true,
							message: '请输入姓名',
							trigger: 'blur'
						}
					],
					orgName: [{
							required: true,
							message: '请选择所属机构',
							trigger: 'blur'
						}
					],
					deptName: [{
						required: true,
						message: '请选择科室',
						trigger: 'blur'
					}],
					levelName: [{
						required: true,
						message: '请选择职位',
						trigger: 'blur'
					}]
				}
			}
		},
		methods: {
			dialog() {
				this.updateData = JSON.parse(JSON.stringify(this.doctorinfo));
				console.log(this.updateData);
				this.updateDialog = true;
			},
			update(formName) {
				this.$refs[formName].validate((valid) => {
					if (valid) {
						axios({
							method: "post",
							url: "http://localhost:8888/Demo/doctor/update",
							data: {
								doctorId: this.doctorinfo.doctorId,
								doctorName: this.updateData.doctorName,
								orgName: this.updateData.orgName,
								deptId: this.updateData.deptId,
								levelName: this.updateData.levelName
							}
						}).then((res) => {
							if(res.data.state){
								this.$message({
									showClose: true,
									type: 'success',
									message: res.data.msg
								});
								axios({
									method: "get",
									url: "http://localhost:8888/Demo/doctor/getById?id=" + this.doctorinfo.doctorId,
								}).then((res1) => {
									if (res1.data.state) {
										axios({
											method: "get",
											url: "http://localhost:8888/Demo/department/getById?id=" + res1.data.doctor
												.deptId,
										}).then((res2) => {
											if (res2.data.state) {
												eval("res1.data.doctor." + "deptName" + "='" + res2.data.department
													.deptName + "'");
											}
											else{
												eval("res1.data.doctor." + "deptName" + "='" + "'");
											}
										});
										this.GLOBAL.doctorinfo = res1.data.doctor;
										this.doctorinfo = this.GLOBAL.doctorinfo;
										this.refresh()
									} else {
										this.$message({
											showClose: true,
											type: 'error',
											message: res.data.msg
										});
									}
								})
								this.updateDialog = false;
							}
							else{
								this.$message({
									showClose: true,
									type: 'error',
									message: res.data.msg
								});
							}
						});
					} else {
						this.$message({
							showClose: true,
							type: 'warning',
							message: "请输入完整信息"
						});
						return false;
					}
				});
			},
			refresh(){
				this.currentindex = this.$route.params.id;
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/department/findAll",
				}).then((res) => {
					this.dept=res.data;
				});
			}
		},
		mounted: function() {
			this.refresh();
		}
	}
</script>

<style scoped>
	.buttonbox {
		display: flex;
		justify-content: flex-end;
		box-shadow: #e4e4e4 0 -5px 5px 0;
	}

	.el-button {
		position: relative;
		top: 50%;
		transform: translateY(-50%);
		height: 40px;
	}

	.doctorinfo {
		margin-left: 5%;
		position: relative;
		top: 25%;
		transform: translateY(-50%);
		font-size: 16px;
	}

	.head {
		width: 80px;
		height: 80px;
		margin: 50px 0;
		border-radius: 50px
	}
</style>

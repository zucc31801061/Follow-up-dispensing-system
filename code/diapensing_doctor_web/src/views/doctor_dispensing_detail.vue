<template>
	<div class="dispensingdetail">
		<el-container>
			<el-aside width="20%">
				<navmenu :currentpage="'1'" />
			</el-aside>
			<el-container>
				<el-aside width="30%">
					<i class="el-icon-back" @click="back"></i>
					<div class="patientinfo">
						<p>姓名：&nbsp;{{patientinfo.personName}}</p>
						<p>证件类型：&nbsp;身份证</p>
						<p>证件号码：&nbsp;{{patientinfo.personCardId}}</p>
						<p>性别：&nbsp;{{patientinfo.personGenderName}}</p>
						<p>出生日期：&nbsp;{{patientinfo.personBirthDate}}</p>
						<p>年龄：&nbsp;{{patientinfo.personAge}}</p>
						<p>手机号码：&nbsp;{{patientinfo.personPhoneNo}}</p>
					</div>
				</el-aside>
				<el-container class="line01">
					<el-header>
						<div v-if="prescriptionids.length>0&&prescriptionids!=undefined">
							<el-tabs v-model="activeIndex" @tab-click="changepage" type="card" closable
								@tab-remove="removeTab">
								<el-tab-pane :index="indexa+1" v-for="(item,indexa) in prescriptionids" :key="indexa"
									:label="'处方'+(indexa+1)" :name="indexa+''"></el-tab-pane>
							</el-tabs>
						</div>
					</el-header>
					<div class="dispensingbox">
						<div v-if="prescriptionids.length>0&&prescriptionids!=undefined">
							<el-row>
								<el-col :offset="5" :span="4">
									处方类型：&nbsp;{{dispensinginfo[thispage].prescription.prescriptionType}}
								</el-col>
								<el-col :offset="3" :span="10" v-if="dispensinginfo[thispage].prescription!=undefined">
									创建时间：&nbsp;{{dispensinginfo[thispage].prescription.prescriptionCreateTime}}
								</el-col>
							</el-row>
							<el-table :data="dispensinginfo[thispage].drugs" border
								style="width: 90%;margin-left: 5%;margin-top: 15px;" max-height="430">
								<el-table-column prop="tradeName" label="药品名称" width="170">
								</el-table-column>
								<el-table-column prop="quantity" label="数量" width="80">
								</el-table-column>
								<el-table-column prop="frequencyName" label="频次" width="100">
								</el-table-column>
								<el-table-column prop="usageName" label="用法" width="80">
								</el-table-column>
								<el-table-column prop="takeDays" label="服用天数" width="80">
								</el-table-column>
								<el-table-column prop="remark" label="嘱托">
								</el-table-column>
								<el-table-column label="操作" width="80"
									v-if="dispensinginfo[thispage].prescription.prescriptionStatus=='未提交'">
									<template slot-scope="scope">
										<el-button @click="deletedrug(scope.row)" type="text" size="medium">删除
										</el-button>
									</template>
								</el-table-column>
							</el-table>
							<div class="adddrugbtn">
								<el-button type="primary" @click="addDialog=true"
									v-if="dispensinginfo[thispage].prescription.prescriptionStatus=='未提交'">添加药品
								</el-button>
							</div>
						</div>
					</div>
					<div class="buttonbox">
						<el-button type="primary" @click="addTab()">添加处方</el-button>
						<el-button type="primary"
							v-if="prescriptionids.length>0&&prescriptionids!=undefined&&dispensinginfo[thispage].prescription.prescriptionStatus=='未提交'"
							@click="updateSubmit()">
							提交处方</el-button>
					</div>
				</el-container>
			</el-container>
		</el-container>
		<el-dialog title="添加药品" :visible.sync="addDialog" width="30%" style="margin-top: -90px;margin-bottom: -50px;">
			<el-form ref="addData" :rules="rules" :model="addData" label-width="90px">
				<el-form-item label="药品名" prop="drugId">
					<el-select v-model="addData.drugId" style="width: 80%;margin-left: 15px;" filterable
						placeholder="请选择药品名">
						<el-option v-for="data in this.GLOBAL.basedrug" :label="data.tradeName" :value="data.drugId">
						</el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="数量" prop="quantity">
					<el-input v-model="addData.quantity" style="width: 80%;margin-left: 15px;" placeholder="请输入药品数量">
					</el-input>
				</el-form-item>
				<el-form-item label="用药频次" prop="frequencyCode">
					<el-select v-model="addData.frequencyCode" placeholder="请选择用药频次"
						style="width: 80%;margin-left: 15px;">
						<el-option v-for="data in this.GLOBAL.basefrequency" :label="data.frequencyName"
							:value="data.frequencyCode"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="药品用法" prop="usageCode">
					<el-select v-model="addData.usageCode" placeholder="请选择药品用法" style="width: 80%;margin-left: 15px;">
						<el-option v-for="data in this.GLOBAL.baseusage" :label="data.usageName"
							:value="data.usageCode"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="服用天数" prop="takeDays">
					<el-input v-model="addData.takeDays" style="width: 80%;margin-left: 15px;" placeholder="请输入服用天数">
					</el-input>
				</el-form-item>
				<el-form-item label="组号" prop="groupNumber">
					<el-input v-model="addData.groupNumber" style="width: 80%;margin-left: 15px;" placeholder="请输入组号">
					</el-input>
				</el-form-item>
				<el-form-item label="顺序号" prop="sortNumber">
					<el-input v-model="addData.sortNumber" style="width: 80%;margin-left: 15px;" placeholder="请输入顺序号">
					</el-input>
				</el-form-item>
				<el-form-item label="嘱托" prop="remark">
					<el-input v-model="addData.remark" style="width: 80%;margin-left: 15px;" placeholder="请输入嘱托">
					</el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button type="primary" @click="adddrug('addData')">确认</el-button>
				<el-button type="danger" @click="addDialog = false">取消</el-button>
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
				addDialog: false,
				thispage: 0,
				patientinfo: {},
				prescriptionids: [],
				activeIndex: '0',
				dispensinginfo: [],
				addData: {
					usageCode: "",
					drugId: "",
					frequencyCode: "",
					takeDays: "",
					quantity: "",
					groupNumber: "",
					sortNumber: "",
					remark: ""
				},
				rules: {
					usageCode: [{
						required: true,
						message: '请选择药品用法',
						trigger: 'blur'
					}],
					drugId: [{
						required: true,
						message: '请选择药品',
						trigger: 'blur'
					}],
					frequencyCode: [{
						required: true,
						message: '请选择用药频次',
						trigger: 'blur'
					}],
					takeDays: [{
							required: true,
							message: '请输入天数',
							trigger: 'blur'
						},
						{
							required: true,
							pattern: /^\d{0,}$/,
							message: '请输入数字',
							trigger: 'blur'
						}
					],
					groupNumber: [{
							required: true,
							message: '请输入组号',
							trigger: 'blur'
						},
						{
							required: true,
							pattern: /^\d{0,}$/,
							message: '请输入数字',
							trigger: 'blur'
						}
					],
					sortNumber: [{
							required: true,
							message: '请输入顺序号',
							trigger: 'blur'
						},
						{
							required: true,
							pattern: /^\d{0,}$/,
							message: '请输入数字',
							trigger: 'blur'
						}
					],
					quantity: [{
							required: true,
							message: '请输入药品数量',
							trigger: 'blur'
						},
						{
							required: true,
							pattern: /^\d{0,}$/,
							message: '请输入数字',
							trigger: 'blur'
						}
					],
					remark: [{
						required: true,
						message: '请输入嘱托',
						trigger: 'blur'
					}]
				}
			}
		},
		methods: {
			back() {
				this.$router.go(-1)
			},
			changepage(targetName, action) {
				this.thispage = targetName.paneName;
			},
			updateSubmit() {
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/preInfo/updateSubmit?id=" + this.dispensinginfo[this.thispage]
						.prescription.prescriptionId
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
			removeTab() {
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/preInfo/delete?id=" + this.dispensinginfo[this.thispage]
						.prescription.prescriptionId
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
			addTab() {
				var form = new FormData();
				form.append("consultId", this.patientinfo.consultId);
				this.$prompt('请选择处方类型', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					inputValidator: (value) => {
						if (value != "西药" && value != "中成药" && value != "中草药") {
							return '请输入“西药”、“中成药”或“中草药”';
						}
					},
				}).then(({
					value
				}) => {
					form.append("prescriptionType", value);
					axios({
						method: "post",
						url: "http://localhost:8888/Demo/preInfo/add",
						headers: {
							'content-type': 'multipart/form-data'
						},
						data: form
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
				}).catch(() => {

				});
			},
			deletedrug(row) {
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/preDrug/delete?id=" + row.prescriptionDrugId,
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
			adddrug(formName) {
				var _this = this;
				this.$refs[formName].validate((valid) => {
					if (valid) {
						axios({
							method: "post",
							url: "http://localhost:8888/Demo/preDrug/add",
							data: {
								usageCode: _this.addData.usageCode,
								drugId: _this.addData.drugId,
								prescriptionId: _this.dispensinginfo[_this.thispage].prescription
									.prescriptionId,
								frequencyCode: _this.addData.frequencyCode,
								takeDays: _this.addData.takeDays,
								quantity: _this.addData.quantity,
								groupNumber: _this.addData.groupNumber,
								sortNumber: _this.addData.sortNumber,
								remark: _this.addData.remark
							}
						}).then((res) => {
							if (res.data.state) {
								this.$message({
									showClose: true,
									type: 'success',
									message: res.data.msg
								});
								this.refresh();
								this.addDialog = false;
							} else {
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
			refresh() {
				var _this = this;
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/consult/getById?id=" + this.$route.params.id,
				}).then((res) => {
					this.patientinfo = res.data.consult
				});
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/preInfo/findByConsult?id=" + this.$route.params.id,
				}).then((res) => {
					if (res.data) {
						this.prescriptionids = [];
						res.data.forEach(element => {
							this.prescriptionids.push(element.prescriptionId);
						});
						_this.dispensinginfo = [];
						this.prescriptionids.forEach(function(temp) {
							axios({
								method: "get",
								url: "http://localhost:8888/Demo/preInfo/getById?id=" +
									temp,
							}).then((res) => {
								res.data.prescription.prescriptionCreateTime = res.data
									.prescription.prescriptionCreateTime.replace(
										".000+00:00", "").replace("T", " ");
								_this.dispensinginfo.push(res.data)
								console.log(_this.dispensinginfo);
							})
						})
					}
				})
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
		padding-top: 18px;
		padding-right: 18px;
	}

	.el-button+.el-button {
		margin-left: 15px;
	}

	.patientinfo {
		position: relative;
		margin-top: 100px;
		margin-left: 60px;
		font-size: 16px;
	}

	.line01 {
		box-shadow: #e4e4e4 0 0 5px 5px;
	}

	.dispensingbox {
		margin-top: 50px;
		font-size: 16px;
		height: 538px;
	}

	.addbutton {
		display: flex;
		justify-content: flex-end;
		margin-right: 10%;
		margin-top: 5%;
	}

	.el-icon-back {
		margin: 20px;
		font-size: 26px;
		position: absolute;
	}

	.adddrugbtn {
		margin-top: 20px;
		margin-left: 720px;
	}
</style>

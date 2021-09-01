<template>
	<div>
		<div class="cardcontent">
			<el-row class="title_area">
				<el-col :offset="6" :span="5" class="title">
					问诊记录表
				</el-col>
				<el-col :offset="0" :span="10" class="time">
					创建时间：{{patientinfo.consultCreateTime}}
				</el-col>
			</el-row>
			<el-row>
				<el-col :offset="1" :span="3">
					问题描述：
				</el-col>
				<el-col :span="5">
					{{patientinfo.question}}
				</el-col>
			</el-row>
			<el-row>
				<el-col :offset="1" :span="3">
					诊断症状：
				</el-col>
				<el-col class="mydiagnosis">
					<div v-for="(item,index) in this.diagnosis" :key="index">
						<el-checkbox v-model="item.state" class="mycheck">{{item.diseasesName}}</el-checkbox>
					</div>
				</el-col>
			</el-row>
			<el-row>
				<el-col :offset="1" :span="3">
					诊断小结：
				</el-col>
				<el-col :span="5">
					感冒
				</el-col>
			</el-row>
			<el-row>
				<el-col :offset="1" :span="3">
					提交药物：
				</el-col>
				<el-col class="mydrug">
					<div v-for="(item,index) in this.drug" :key="index">
						<el-checkbox v-model="item.state" class="mycheck">{{item.drugName}}</el-checkbox>
					</div>
				</el-col>
			</el-row>
			<el-row v-if="patientinfo.photoIds!==undefined&&patientinfo.photoIds.length>0">
				<el-col :offset="1" :span="3">
					问诊照片：
				</el-col>
				<div v-for="(item,index) in patientinfo.photoIds" :key="index">
					<el-col class="photos" :span="4">
						<el-image style="width: 143px; height: 143px" :src="item"></el-image>
					</el-col>
				</div>
			</el-row>
		</div>
		<div class="buttonbox">
			<el-button type="primary" v-if="patientinfo.consultStatus=='待接诊'" @click="updateIng">接诊</el-button>
			<el-button type="primary" v-if="patientinfo.consultStatus=='进行中'||patientinfo.consultStatus=='已完成'" @click="topath">查看处方</el-button>
			<el-button type="primary" v-if="patientinfo.consultStatus=='进行中'" @click="updateFinish">完成</el-button>
		</div>
	</div>

</template>
<script>
	const axios = require('axios');
	export default {
		props: ["patientinfo", "drug", "diagnosis"],
		data() {
			return {
				
			}
		},
		methods: {
			updateIng(){
				console.log(this.patientinfo);
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/consult/updateIng?id=" + this.patientinfo.consultId,
				}).then((res) => {
					console.log(res.data);
					if (res.data.state) {
						this.$message({
							showClose: true,
							type: 'success',
							message: res.data.msg
						});
					}
					else{
						this.$message({
							showClose: true,
							type: 'error',
							message: res.data.msg
						});
					}
				});
			},
			updateFinish(){
				console.log(this.patientinfo);
				axios({
					method: "get",
					url: "http://localhost:8888/Demo/consult/updateFinish?id=" + this.patientinfo.consultId,
				}).then((res) => {
					console.log(res.data);
					if (res.data.state) {
						this.$message({
							showClose: true,
							type: 'success',
							message: res.data.msg
						});
					}
					else{
						this.$message({
							showClose: true,
							type: 'error',
							message: res.data.msg
						});
					}
				});
			},
			topath() {
				this.$router.push({
					path: "/dispensingdetail/" + this.$route.params.id
				});
			},
			back() {
				this.$router.go(-1)
			}
		},
		mounted: function() {
			//this.druglist=this.patientinfo.drugIds;
		}
	}
</script>

<style scoped>
	.cardcontent {
		font-size: 16px;
		height: 650px;
		overflow-y: scroll;
	}

	.el-row {
		padding: 10px;
	}

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

	.title_area {
		margin: 40px 0 20px 0;
	}

	.title {
		font-size: 30px;
		font-weight: 700;
	}

	.time {
		padding-top: 15px;
	}

	.photos {
		margin-right: 40px;
	}

	.mycheck {
		float: left;
		width: 160px;
		margin-bottom: 5px;
	}

	.mydiagnosis {
		width: 80%;
	}
	
	.mydrug {
		width: 80%;
	}
</style>

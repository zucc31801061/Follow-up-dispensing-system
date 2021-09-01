<template>
	<div class="dispensing">
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
					<div class="consult">
						<recordstable :patientinfo="patientinfo" :drug="drug" :diagnosis="diagnosis" />
					</div>
				</el-container>
			</el-container>
		</el-container>
	</div>
</template>

<script>
	const axios = require('axios');
	import navmenu from '../components/navmenu.vue'
	import recordstable from '../components/redordstable.vue'
	export default {
		components: {
			navmenu,
			recordstable
		},
		data() {
			return {
				currentindex: 0,
				patientinfo: {},
				drug: [],
				diagnosis: []
			}
		},
		mounted: function() {
			this.currentindex = this.$route.params.id;
			axios({
				method: "get",
				url: "http://localhost:8888/Demo/consult/getById?id=" + this.$route.params.id,
			}).then((res) => {
				if (res.data) {
					this.patientinfo = res.data.consult;
					this.patientinfo.drugIds = this.patientinfo.drugIds.split(',');
					this.patientinfo.diagnosisIds = this.patientinfo.diagnosisIds.split(',');
					this.patientinfo.photoIds = this.patientinfo.photoIds.split(',');
					this.patientinfo.consultCreateTime = this.patientinfo.consultCreateTime.replace(
						".000+00:00", "").replace("T", " ");
					var flag = true;
					this.drug = this.GLOBAL.basedrug;
					for (var i = 0; i < this.GLOBAL.basedrug.length; i++) {
						flag = false;
						for (var j = 0; j < this.patientinfo.drugIds.length; j++) {
							if (this.GLOBAL.basedrug[i].drugId == this.patientinfo.drugIds[j]) {
								this.drug. [i].state = true;
								flag = true;
								break;
							}
						}
						if (!flag) {
							this.drug. [i].state = false;
						}
					}
					this.diagnosis = this.GLOBAL.basediagnosis;
					for (var i = 0; i < this.GLOBAL.basediagnosis.length; i++) {
						flag = false;
						for (var j = 0; j < this.patientinfo.diagnosisIds.length; j++) {
							if (this.GLOBAL.basediagnosis[i].diagnosisId == this.patientinfo.diagnosisIds[j]) {
								this.diagnosis. [i].state = true;
								flag = true;
								break;
							}
						}
						if (!flag) {
							this.diagnosis. [i].state = false;
						}
					}
				}
			});
		},
		methods: {
			back() {
				this.$router.go(-1)
			}
		}
	}
</script>

<style scoped>
	.patientinfo {
		position: relative;
		margin-top: 100px;
		margin-left: 60px;
		font-size: 16px;
	}

	.line01 {
		box-shadow: #e4e4e4 0 0 5px 5px;
	}

	.el-icon-back {
		margin: 20px;
		font-size: 26px;
		position: absolute;
	}

	.consult {
		width: 100%;
	}
</style>

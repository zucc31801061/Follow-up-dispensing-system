import Vue from 'vue'
import VueRouter from 'vue-router'
import loginpage from '../views/doctor_loginpage.vue'
import mainpage from '../views/doctor_mainpage.vue'
import dispensingdetail from '../views/doctor_dispensing_detail.vue'
import mypage from '../views/doctor_mypage.vue'
import dispensing from '../views/doctor_dispensing.vue'
Vue.use(VueRouter)

const routes = [
	{
		path: '/',
		name: '登录',
		component: loginpage
	},
	{
		path: '/mainpage',
		name: '问诊管理',
		component: mainpage
	},
	{
		path: '/dispensingdetail/:id',
		name: '记录详情',
		component: dispensingdetail
	},
	{
		path: '/dispensing/:id',
		name: '问诊记录',
		component: dispensing
	},
	{
		path: '/mypage',
		name: '我的信息',
		component: mypage
	}
]

const router = new VueRouter({
	routes
})

export default router

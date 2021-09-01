/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : dispensing1

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 21/07/2021 15:48:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account`  (
  `account_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `account_type` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户类型',
  `mini_open_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '微信小程序openid',
  `phone_no` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',
  `account_create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`account_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('uidtest1', '1', 'minitest1', '13811112222', '2021-07-13 07:23:28');
INSERT INTO `account` VALUES ('uidtest2', '1', 'minitest2', '13811112222', '2021-07-16 10:45:28');
INSERT INTO `account` VALUES ('uidtest3', '2', 'minitest3', '15833334444', '2021-07-16 11:25:31');

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `address_id` int NOT NULL AUTO_INCREMENT COMMENT '地址id',
  `account_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `address_info` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址信息',
  PRIMARY KEY (`address_id`) USING BTREE,
  INDEX `FK_live`(`account_id`) USING BTREE,
  CONSTRAINT `FK_live` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地址表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 'uidtest1', 'addtest1');
INSERT INTO `address` VALUES (2, 'uidtest1', 'addtest_update');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `admin_pwd` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('123456', 'admin1');

-- ----------------------------
-- Table structure for consult_ask
-- ----------------------------
DROP TABLE IF EXISTS `consult_ask`;
CREATE TABLE `consult_ask`  (
  `consult_id` int NOT NULL AUTO_INCREMENT COMMENT '问诊id',
  `account_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `doctor_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生id',
  `person_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配药人姓名',
  `person_card_type` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配药人证件类型，01居民身份证 02居民户口簿 03护照 04军官证 05驾驶证 06港澳居民来往内地通行证 07台湾居民来往内地通行证 11出生证明 12港澳居民身份证 13港澳居民居住证 99其他法定有效证件',
  `person_card_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配药人证件号码',
  `person_gender_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配药人性别，1男，2女',
  `person_birth_date` date NOT NULL COMMENT '配药人出生日期',
  `person_age` int NOT NULL COMMENT '配药人年龄',
  `person_phone_no` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配药人手机号码',
  `question` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '问题描述',
  `diagnosis` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '诊断小结',
  `diagnosis_ids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '诊断id，用英文逗号分隔',
  `drug_ids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '复诊提交药物id，用英文逗号分隔',
  `photo_ids` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问诊照片id，用英文逗号分隔',
  `consult_status` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '复诊配药状态，1待接诊，2进行中，3已完成，4已过期，5已撤销',
  `consult_create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `consult_accept_time` datetime NULL DEFAULT NULL COMMENT '接诊时间',
  `consult_finish_time` datetime NULL DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`consult_id`) USING BTREE,
  INDEX `FK_apply`(`account_id`) USING BTREE,
  INDEX `FK_receive`(`doctor_id`) USING BTREE,
  CONSTRAINT `FK_apply` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_receive` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '问诊记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consult_ask
-- ----------------------------
INSERT INTO `consult_ask` VALUES (1, 'uidtest1', 'doctest2', '病人测试1', '1', '330682200010074426', '女', '2021-07-16', 20, '15868815253', '问题测试1', '诊断测试1', '1', '1', NULL, '进行中', '2021-07-16 15:13:45', NULL, '2021-07-19 15:25:12');
INSERT INTO `consult_ask` VALUES (2, 'uidtest1', 'doctest1', '病人测试2_修改', '1', '330682200010074426', '女', '2021-07-16', 0, '15868815253', 'question_update', 'diagnosis_update', '1', '1', 'http://localhost:8888/Demo/9885d065-8634-4631-89fb-ae896b24d373.jpg,http://localhost:8888/Demo/6b5dcb02-5b54-4c7f-845a-f5d68a66e14c.jpg', '进行中', '2021-07-01 15:13:45', NULL, NULL);
INSERT INTO `consult_ask` VALUES (3, 'uidtest1', 'doctest1', '病人测试3', '1', '123456789', '女', '2000-02-01', 0, '123456789', 'question', 'diagnosis_update', '2,3', '5,7', 'http://localhost:8888/Demo/b2d22922-2c17-4f06-96fd-ad11778779e7.jpg,http://localhost:8888/Demo/c7f12a48-7573-4462-b792-05e7c2592767.jpg', '已完成', '2021-07-16 08:02:09', '2021-07-16 08:06:42', '2021-07-16 08:08:06');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `dept_id` int NOT NULL AUTO_INCREMENT COMMENT '科室id',
  `dept_species` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '科室种类',
  `dept_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '科室名称',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 70 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '医生科室表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '内科', '呼吸内科');
INSERT INTO `department` VALUES (2, '内科', '消化内科');
INSERT INTO `department` VALUES (3, '内科', '神经内科');
INSERT INTO `department` VALUES (4, '内科', '心血管内科');
INSERT INTO `department` VALUES (5, '内科', '肾内科');
INSERT INTO `department` VALUES (6, '内科', '免疫科');
INSERT INTO `department` VALUES (7, '内科', '内分泌科');
INSERT INTO `department` VALUES (8, '外科', '普通外科');
INSERT INTO `department` VALUES (9, '外科', '神经外科');
INSERT INTO `department` VALUES (10, '外科', '心胸外科');
INSERT INTO `department` VALUES (11, '外科', '泌尿外科');
INSERT INTO `department` VALUES (12, '外科', '心血管外科');
INSERT INTO `department` VALUES (13, '外科', '乳腺外科');
INSERT INTO `department` VALUES (14, '外科', '肝胆外科');
INSERT INTO `department` VALUES (15, '外科', '器官移植');
INSERT INTO `department` VALUES (16, '外科', '肛肠外科');
INSERT INTO `department` VALUES (17, '外科', '烧伤科');
INSERT INTO `department` VALUES (18, '外科', '骨外科');
INSERT INTO `department` VALUES (19, '妇产科', '妇科');
INSERT INTO `department` VALUES (20, '妇产科', '产科');
INSERT INTO `department` VALUES (21, '妇产科', '妇幼保健');
INSERT INTO `department` VALUES (22, '男科', '男科');
INSERT INTO `department` VALUES (23, '儿科', '儿科综合');
INSERT INTO `department` VALUES (24, '儿科', '小儿内科');
INSERT INTO `department` VALUES (25, '儿科', '小儿外科');
INSERT INTO `department` VALUES (26, '儿科', '新生儿科');
INSERT INTO `department` VALUES (27, '儿科', '儿童营养保健科');
INSERT INTO `department` VALUES (28, '五官科', '耳鼻喉科');
INSERT INTO `department` VALUES (29, '五官科', '眼科');
INSERT INTO `department` VALUES (30, '五官科', '口腔科');
INSERT INTO `department` VALUES (31, '肿瘤科', '肿瘤内科');
INSERT INTO `department` VALUES (32, '肿瘤科', '肿瘤外科');
INSERT INTO `department` VALUES (33, '肿瘤科', '肿瘤妇科');
INSERT INTO `department` VALUES (34, '肿瘤科', '骨肿瘤科');
INSERT INTO `department` VALUES (35, '肿瘤科', '放疗科');
INSERT INTO `department` VALUES (36, '肿瘤科', '肿瘤康复科');
INSERT INTO `department` VALUES (37, '肿瘤科', '肿瘤综合科');
INSERT INTO `department` VALUES (38, '皮肤性病科', '皮肤科');
INSERT INTO `department` VALUES (39, '皮肤性病科', '性病科');
INSERT INTO `department` VALUES (40, '中医科', '中医全科');
INSERT INTO `department` VALUES (41, '中医科', '中医内科');
INSERT INTO `department` VALUES (42, '中医科', '中医外科');
INSERT INTO `department` VALUES (43, '中医科', '中医妇科');
INSERT INTO `department` VALUES (44, '中医科', '中医儿科');
INSERT INTO `department` VALUES (45, '中医科', '中医保健科');
INSERT INTO `department` VALUES (46, '中医科', '针灸按摩科');
INSERT INTO `department` VALUES (47, '中医科', '中医骨伤科');
INSERT INTO `department` VALUES (48, '中医科', '中医肿瘤科');
INSERT INTO `department` VALUES (49, '传染科', '肝病科');
INSERT INTO `department` VALUES (50, '传染科', '艾滋病科');
INSERT INTO `department` VALUES (51, '传染科', '结核病科');
INSERT INTO `department` VALUES (52, '传染科', '寄生虫');
INSERT INTO `department` VALUES (53, '精神心理科', '精神科');
INSERT INTO `department` VALUES (54, '精神心理科', '心理咨询科');
INSERT INTO `department` VALUES (55, '整形美容科', '整形美容科');
INSERT INTO `department` VALUES (56, '营养科', '营养科');
INSERT INTO `department` VALUES (57, '麻醉医学科', '麻醉科');
INSERT INTO `department` VALUES (58, '麻醉医学科', '疼痛科');
INSERT INTO `department` VALUES (59, '医学影像科', '核医学科');
INSERT INTO `department` VALUES (60, '医学影像科', '放射科');
INSERT INTO `department` VALUES (61, '医学影像科', '超声科');
INSERT INTO `department` VALUES (62, '其他科室', '药剂科');
INSERT INTO `department` VALUES (63, '其他科室', '护理科');
INSERT INTO `department` VALUES (64, '其他科室', '体检科');
INSERT INTO `department` VALUES (65, '其他科室', '检验科');
INSERT INTO `department` VALUES (66, '其他科室', '急诊科');
INSERT INTO `department` VALUES (67, '其他科室', '公共卫生与预防科');
INSERT INTO `department` VALUES (68, '其他科室', '全科');
INSERT INTO `department` VALUES (69, '其他科室', '设备科');

-- ----------------------------
-- Table structure for diagnosis
-- ----------------------------
DROP TABLE IF EXISTS `diagnosis`;
CREATE TABLE `diagnosis`  (
  `diagnosis_id` int NOT NULL AUTO_INCREMENT COMMENT '诊断id',
  `diagnosis_type` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '诊断类型，1西医，2中医',
  `diseases_code` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '诊断类型为西医时为疾病代码，为中医时为中医疾病代码',
  `diseases_id` int NOT NULL COMMENT '诊断类型为西医时为疾病标识，为中医时为中医疾病标识',
  `diseases_name` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '诊断类型为西医时为疾病名称，为中医时为中医疾病名称',
  `diseases_pinyin_code` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拼音码',
  PRIMARY KEY (`diagnosis_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '诊断表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diagnosis
-- ----------------------------
INSERT INTO `diagnosis` VALUES (1, '1', 'J11.101', 10001, '流行性感冒', 'LXXGM');
INSERT INTO `diagnosis` VALUES (2, '1', 'J10.151', 10002, '流行性感冒性咽炎', 'LXXGMXYY');
INSERT INTO `diagnosis` VALUES (3, '1', 'J98.802', 10003, '呼吸道感染', 'HXDGR');
INSERT INTO `diagnosis` VALUES (4, '1', 'J06.903', 10004, '上呼吸道感染', 'SHXDGR');
INSERT INTO `diagnosis` VALUES (5, '1', 'E14.900', 10005, '糖尿病', 'TNB');
INSERT INTO `diagnosis` VALUES (6, '1', 'E13.904', 10006, '医源性糖尿病', 'YYXTNB');
INSERT INTO `diagnosis` VALUES (7, '1', 'I10.X02', 10007, '高血压', 'GXY');
INSERT INTO `diagnosis` VALUES (8, '1', 'H35.001', 10008, '高血压性视网膜病', 'GXYXSWMB');
INSERT INTO `diagnosis` VALUES (9, '1', 'A08.401', 10009, '病毒性肠炎', 'BDXCY');
INSERT INTO `diagnosis` VALUES (10, '1', 'A01.001', 10010, '伤寒', 'SH');
INSERT INTO `diagnosis` VALUES (11, '1', 'A01.052', 10011, '伤寒腹膜炎', 'SHFMY');
INSERT INTO `diagnosis` VALUES (12, '1', 'K27.503', 10012, '消化道穿孔', 'SHDCK');
INSERT INTO `diagnosis` VALUES (13, '1', 'K27.451', 10013, '消化性溃疡伴出血', 'XHDKYBCX');
INSERT INTO `diagnosis` VALUES (14, '1', 'K30', 10014, '消化不良', 'XHBL');
INSERT INTO `diagnosis` VALUES (15, '1', 'A16.305', 10015, '支气管淋巴结结核', 'ZQGLBJJH');
INSERT INTO `diagnosis` VALUES (16, '1', 'B37.805', 10016, '支气管念珠菌病', 'ZQGNZJB');
INSERT INTO `diagnosis` VALUES (17, '1', 'C34.905', 10017, '支气管恶性肿瘤', 'ZQGEXZL');
INSERT INTO `diagnosis` VALUES (18, '1', 'R22.951', 10018, '表浅(局限)肿块', 'QBJXZK');
INSERT INTO `diagnosis` VALUES (19, '1', 'R22.451', 10019, '腿部炎性肿块', 'TBYXZK');
INSERT INTO `diagnosis` VALUES (20, '1', 'A18.405', 10020, '结核性皮肤脓肿', 'JHXPFNZ');
INSERT INTO `diagnosis` VALUES (21, '1', 'A18.407', 10021, '皮肤和皮下组织结核', 'PFHPXZZJH');
INSERT INTO `diagnosis` VALUES (22, '1', 'A18.408', 10022, '皮肤结核', 'PFJH');
INSERT INTO `diagnosis` VALUES (23, '1', 'A36.301', 10023, '皮肤白喉', 'PFBH');
INSERT INTO `diagnosis` VALUES (24, '1', 'E51.101', 10024, '脚气病', 'JQB');
INSERT INTO `diagnosis` VALUES (25, '1', 'E51.152', 10025, '干性脚气病', 'GXJQB');
INSERT INTO `diagnosis` VALUES (26, '1', 'S90.351', 10026, '脚挫伤', 'JCS');
INSERT INTO `diagnosis` VALUES (27, '1', 'M54.475', 10027, '腰腿痛', 'YTT');
INSERT INTO `diagnosis` VALUES (28, '1', 'L03.104', 10028, '腿蜂窝织炎', 'TFWZY');
INSERT INTO `diagnosis` VALUES (29, '1', 'Q68.551', 10029, '腿弓形', 'TGX');
INSERT INTO `diagnosis` VALUES (30, '1', 'R22.451', 10030, '腿部炎性肿块', 'TBYXZK');
INSERT INTO `diagnosis` VALUES (31, '1', 'R60.051', 10031, '遗传性腿部水肿', 'YCXTBSZ');
INSERT INTO `diagnosis` VALUES (32, '1', 'S70.901', 10032, '大腿血肿', 'DTXZ');
INSERT INTO `diagnosis` VALUES (33, '1', 'S71.101', 10033, '大腿撕脱伤', 'DTSTS');
INSERT INTO `diagnosis` VALUES (34, '1', 'S71.102', 10034, '大腿开放性伤口', 'DTKFXSK');
INSERT INTO `diagnosis` VALUES (35, '1', 'C76.502', 10035, '小腿恶性肿瘤', 'XTEXZL');
INSERT INTO `diagnosis` VALUES (36, '1', 'B08.401', 10036, '手足口病', 'SZKB');
INSERT INTO `diagnosis` VALUES (37, '1', 'B35.201', 10037, '手癣', 'SX');
INSERT INTO `diagnosis` VALUES (38, '1', 'B35.251', 10038, '手皮真菌病', 'SPZJB');
INSERT INTO `diagnosis` VALUES (39, '1', 'B35.851', 10039, '手足癣', 'SZX');
INSERT INTO `diagnosis` VALUES (40, '1', 'E89.002', 10040, '手术后甲状腺机能减退', 'SSHJZXJNJT');
INSERT INTO `diagnosis` VALUES (41, '1', 'E89.101', 10041, '手术后低胰岛素血症', 'SSHDYDSXZ');
INSERT INTO `diagnosis` VALUES (42, '1', 'E89.301', 10042, '手术后垂体机能减退', 'SSHCTJNJT');
INSERT INTO `diagnosis` VALUES (43, '1', 'B15.902', 10043, '传染性肝炎', 'CRXGY');
INSERT INTO `diagnosis` VALUES (44, '1', 'B15.901', 10044, '甲型病毒性肝炎', 'JXBDXGY');
INSERT INTO `diagnosis` VALUES (45, '1', 'B15.907', 10045, '甲型病毒性重型肝炎', 'JXBDXZXGY');
INSERT INTO `diagnosis` VALUES (46, '1', 'A02.006', 10046, '沙门氏菌胃肠炎', 'SMSJWCY');
INSERT INTO `diagnosis` VALUES (47, '1', 'A02.004', 10047, '沙门氏菌性肠炎', 'SMSJXCY');
INSERT INTO `diagnosis` VALUES (48, '1', 'A01.057', 10048, '伤寒样小肠炎', 'SHXXCY');
INSERT INTO `diagnosis` VALUES (49, '1', 'A01.056', 10049, '肠伤寒', 'CSH');
INSERT INTO `diagnosis` VALUES (50, '1', 'A05.952', 10050, '胃肠型食物中毒', 'WCXSWZD');
INSERT INTO `diagnosis` VALUES (51, '1', 'A01.055', 10051, '伤寒性肠穿孔', 'SHXCCK');

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor`  (
  `doctor_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '医生id',
  `dept_id` int NOT NULL COMMENT '科室id',
  `doctor_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '医生姓名',
  `org_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '机构名称',
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生头像链接',
  `level_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '医生职称，1主任医师，2副主任医师，3主治医师，4医师，5医士',
  PRIMARY KEY (`doctor_id`) USING BTREE,
  INDEX `FK_work`(`dept_id`) USING BTREE,
  CONSTRAINT `FK_work` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '医生表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES ('doctest1', 4, '医生测试1', '机构测试1', '41da23f3-7ea0-4353-9bb5-c0f57c8e9706.jpg', NULL);
INSERT INTO `doctor` VALUES ('doctest2', 30, '医生测试2', '机构测试2', NULL, NULL);
INSERT INTO `doctor` VALUES ('doctest3', 29, '医生测试3', '机构测试3', NULL, NULL);
INSERT INTO `doctor` VALUES ('doctest4', 7, '医生测试4', '机构测试4', 'pathtest1', NULL);

-- ----------------------------
-- Table structure for drug
-- ----------------------------
DROP TABLE IF EXISTS `drug`;
CREATE TABLE `drug`  (
  `drug_id` int NOT NULL AUTO_INCREMENT COMMENT '药品id',
  `drug_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '药品通用名称',
  `trade_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名',
  `drug_pinyin_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '拼音码',
  `specification` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '药品规格',
  `pack_unit` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '包装单位',
  `price` decimal(10, 2) NOT NULL COMMENT '药品价格',
  `dose` decimal(10, 2) NOT NULL COMMENT '剂量',
  `dose_unit` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '剂量单位',
  `factory_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产地',
  `approval_number` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '批准文号',
  PRIMARY KEY (`drug_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '药品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drug
-- ----------------------------
INSERT INTO `drug` VALUES (1, '肠炎宁片', '[康恩贝]肠炎宁片', 'cynp', '0.42g*48片', '盒', 30.00, 0.42, 'g', '江西康恩贝中药有限公司', '国药准字Z36020518');
INSERT INTO `drug` VALUES (2, '连花清瘟胶囊', '[以岭]连花清瘟胶囊', 'lhqwjn', '0.35g*36粒', '盒', 29.10, 0.35, 'g', '石家庄以岭药业股份有限公司', '国药准字Z20040063');
INSERT INTO `drug` VALUES (3, '小柴胡颗粒', '[999]小柴胡颗粒', 'xchkl', '10g*9袋', '盒', 18.20, 10.00, 'g', '华润三九医药股份有限公司', '国药准字Z44020709');
INSERT INTO `drug` VALUES (4, '布洛芬缓释胶囊', '[芬必得]布洛芬缓释胶囊', 'blfysjn', '0.3g*20粒', '盒', 14.20, 0.30, 'g', '中美天津史克制药有限公司', '国药准字H20013062');
INSERT INTO `drug` VALUES (5, '清凉油(白色)', '[龙虎]清凉油(白色)', 'qly', '18.4g', '瓶', 23.00, 0.10, 'g', '上海中华药业有限公司', '国药准字Z20026718');
INSERT INTO `drug` VALUES (6, '曲安奈德益康唑乳膏', '[派瑞松]曲安奈德益康唑乳膏', 'qatdykzlg', '15g', '支', 21.00, 0.20, 'g', '西安杨森制药有限公司', '国药准字H20000454');
INSERT INTO `drug` VALUES (7, '卡托普利片', '[开博通]卡托普利片', 'ktplp', '12.5mg*20片', '盒', 22.00, 12.50, 'mg', '中美上海施贵宝制药有限公司', '国药准字H31022986');
INSERT INTO `drug` VALUES (8, '磷酸西格列汀片', '[捷诺维]磷酸西格列汀片', 'lsxgltp', '100mg*14片', '盒', 115.00, 100.00, 'mg', '杭州默沙东制药有限公司', '国药准字J20140095');
INSERT INTO `drug` VALUES (9, '盐酸二甲双胍片', '[格华止]盐酸二甲双胍片', 'ysejsgp', '0.85g*20片', '盒', 32.00, 0.85, 'g', '中美上海施贵宝制药有限公司', '国药准字H20023371');
INSERT INTO `drug` VALUES (10, '小儿氨酚烷胺颗粒', '[优卡丹]小儿氨酚烷胺颗粒', 'xeafwakl', '6g*16袋', '盒', 18.00, 8.00, 'g', '江西铜鼓仁和制药有限公司', '国药准字H20068170');
INSERT INTO `drug` VALUES (11, '小儿感冒口服液', '[同仁堂]小儿感冒口服液', 'xegmkfy', '10ml*10支', '盒', 19.80, 5.00, 'ml', '北京同仁堂科技发展股份有限公司制药厂', '国药准字Z10940020');
INSERT INTO `drug` VALUES (12, '炉甘石洗剂', '[信龙]炉甘石洗剂', 'lgsxj', '100ml', '瓶', 11.00, 10.00, 'ml', '上海运佳黄浦制药有限公司', '国药准字H31022790');
INSERT INTO `drug` VALUES (13, '红霉素眼膏', '[云植]红霉素眼膏', 'hmsyg', '2g', '支', 4.50, 0.01, 'g', '云南植物药业有限公司', '国药准字H53020376');
INSERT INTO `drug` VALUES (14, '呋塞米片', '[三才]呋塞米片', 'fsmp', '20mg*100片', '瓶', 8.70, 20.00, 'mg', '三才石岐制药股份有限公司', '国药准字H44023242');

-- ----------------------------
-- Table structure for drug_frequency
-- ----------------------------
DROP TABLE IF EXISTS `drug_frequency`;
CREATE TABLE `drug_frequency`  (
  `frequency_code` int NOT NULL AUTO_INCREMENT COMMENT '项目代码',
  `frequency_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `frequency_name_abbr` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称缩写',
  PRIMARY KEY (`frequency_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '药品频次表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drug_frequency
-- ----------------------------
INSERT INTO `drug_frequency` VALUES (1, '每日一次', 'qd');
INSERT INTO `drug_frequency` VALUES (2, '每日两次', 'bid');
INSERT INTO `drug_frequency` VALUES (3, '每日三次', 'tid');
INSERT INTO `drug_frequency` VALUES (4, '每日四次', 'qid');
INSERT INTO `drug_frequency` VALUES (5, '隔日一次', 'qod');
INSERT INTO `drug_frequency` VALUES (6, '每周一次', 'qw');

-- ----------------------------
-- Table structure for drug_usage
-- ----------------------------
DROP TABLE IF EXISTS `drug_usage`;
CREATE TABLE `drug_usage`  (
  `usage_code` int NOT NULL AUTO_INCREMENT COMMENT '项目代码',
  `usage_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  PRIMARY KEY (`usage_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '药品用法表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of drug_usage
-- ----------------------------
INSERT INTO `drug_usage` VALUES (1, '口服');
INSERT INTO `drug_usage` VALUES (2, '涂抹');
INSERT INTO `drug_usage` VALUES (3, '静脉注射');
INSERT INTO `drug_usage` VALUES (4, '皮下注射');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `consult_id` int NULL DEFAULT NULL COMMENT '问诊记录id',
  `address_id` int NULL DEFAULT NULL COMMENT '地址id',
  `sum_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单总价',
  `order_status` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单状态，1待支付，2配送中，3已送达',
  `order_create_time` datetime NULL DEFAULT NULL COMMENT '订单创建时间',
  `order_arrive_time` datetime NULL DEFAULT NULL COMMENT '订单到达时间',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `FK_dispatching`(`consult_id`) USING BTREE,
  INDEX `FK_use`(`address_id`) USING BTREE,
  CONSTRAINT `FK_dispatching` FOREIGN KEY (`consult_id`) REFERENCES `consult_ask` (`consult_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_use` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 2, 1, NULL, '0', NULL, NULL);
INSERT INTO `orders` VALUES (2, 1, 1, 65.50, '已取消', '2021-07-17 03:20:12', '2021-07-17 05:41:53');

-- ----------------------------
-- Table structure for prescription_drug
-- ----------------------------
DROP TABLE IF EXISTS `prescription_drug`;
CREATE TABLE `prescription_drug`  (
  `prescription_drug_id` int NOT NULL AUTO_INCREMENT COMMENT '处方药品id',
  `usage_code` int NULL DEFAULT NULL COMMENT '药品用法id',
  `drug_id` int NULL DEFAULT NULL COMMENT '药品id',
  `prescription_id` int NULL DEFAULT NULL COMMENT '处方id',
  `frequency_code` int NULL DEFAULT NULL COMMENT '药品频次id',
  `take_days` int NULL DEFAULT NULL COMMENT '用药天数',
  `quantity` int NULL DEFAULT NULL COMMENT '药品数量',
  `group_number` int NULL DEFAULT NULL COMMENT '组号',
  `sort_number` int NULL DEFAULT NULL COMMENT '顺序号',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '嘱托',
  PRIMARY KEY (`prescription_drug_id`) USING BTREE,
  INDEX `FK_drug_use`(`drug_id`) USING BTREE,
  INDEX `FK_frequency_use`(`frequency_code`) USING BTREE,
  INDEX `FK_usage_use`(`usage_code`) USING BTREE,
  INDEX `FK_list`(`prescription_id`) USING BTREE,
  CONSTRAINT `FK_list` FOREIGN KEY (`prescription_id`) REFERENCES `prescription_info` (`prescription_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_frequency_use` FOREIGN KEY (`frequency_code`) REFERENCES `drug_frequency` (`frequency_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_usage_use` FOREIGN KEY (`usage_code`) REFERENCES `drug_usage` (`usage_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_drug_use` FOREIGN KEY (`drug_id`) REFERENCES `drug` (`drug_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '处方药品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prescription_drug
-- ----------------------------
INSERT INTO `prescription_drug` VALUES (3, 1, 1, 1, 1, 7, 1, 1, 1, '嘱托');

-- ----------------------------
-- Table structure for prescription_info
-- ----------------------------
DROP TABLE IF EXISTS `prescription_info`;
CREATE TABLE `prescription_info`  (
  `prescription_id` int NOT NULL AUTO_INCREMENT COMMENT '处方id',
  `consult_id` int NOT NULL COMMENT '问诊记录id',
  `prescription_type` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处方类型，1西药，2中成药，3中草药',
  `prescription_create_time` datetime NOT NULL COMMENT '开方时间',
  `prescription_status` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '处方提交状态，1未提交 ，2已提交',
  PRIMARY KEY (`prescription_id`) USING BTREE,
  INDEX `FK_prescribe`(`consult_id`) USING BTREE,
  CONSTRAINT `FK_prescribe` FOREIGN KEY (`consult_id`) REFERENCES `consult_ask` (`consult_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '处方信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of prescription_info
-- ----------------------------
INSERT INTO `prescription_info` VALUES (1, 1, '1', '2021-07-17 09:44:05', '已提交');
INSERT INTO `prescription_info` VALUES (3, 3, '西药', '2021-07-17 12:21:01', '未提交');
INSERT INTO `prescription_info` VALUES (4, 3, '西药', '2021-07-17 12:23:43', '已提交');
INSERT INTO `prescription_info` VALUES (5, 2, '西药', '2021-07-17 20:31:24', '未提交');
INSERT INTO `prescription_info` VALUES (6, 2, '西药', '2021-07-19 15:30:19', '未提交');
INSERT INTO `prescription_info` VALUES (7, 2, '中成药', '2021-07-20 15:23:05', '未提交');

SET FOREIGN_KEY_CHECKS = 1;

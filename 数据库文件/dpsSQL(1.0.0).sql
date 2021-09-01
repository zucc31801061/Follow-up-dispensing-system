/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2021/7/14 13:51:35                           */
/*==============================================================*/


drop table if exists account;

drop table if exists address;

drop table if exists appointment;

drop table if exists consult_ask;

drop table if exists department;

drop table if exists diagnosis;

drop table if exists doctor;

drop table if exists drug;

drop table if exists drug_frequency;

drop table if exists drug_usage;

drop table if exists orders;

drop table if exists prescription_drug;

drop table if exists prescription_info;

/*==============================================================*/
/* Table: account                                               */
/*==============================================================*/
create table account
(
   account_id           varchar(36) not null comment '用户id',
   account_type         char(2) not null comment '用户类型，1居民，2医生',
   mini_open_id         varchar(36) not null comment '微信小程序openid',
   phone_no             varchar(36) not null comment '手机号码',
   account_create_time  datetime not null comment '创建时间',
   primary key (account_id)
);

alter table account comment '用户表';

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   address_id           int not null comment '地址id',
   account_id           varchar(36) comment '用户id',
   address_info         varchar(100) not null comment '地址信息',
   primary key (address_id)
);

/*==============================================================*/
/* Table: appointment                                           */
/*==============================================================*/
create table appointment
(
   account_id           varchar(36) not null comment '用户id',
   doctor_id            varchar(36) not null comment '医生id',
   primary key (account_id, doctor_id)
);

/*==============================================================*/
/* Table: consult_ask                                           */
/*==============================================================*/
create table consult_ask
(
   consult_id           int not null comment '问诊id',
   account_id           varchar(36) comment '用户id',
   doctor_id            varchar(36) comment '医生id',
   person_name          varchar(64) not null comment '配药人姓名',
   person_card_type     char(4) not null comment '配药人证件类型，01居民身份证 02居民户口簿 03护照 04军官证 05驾驶证 06港澳居民来往内地通行证 07台湾居民来往内地通行证 11出生证明 12港澳居民身份证 13港澳居民居住证 99其他法定有效证件',
   person_card_id       varchar(64) not null comment '配药人证件号码',
   person_gender_name   varchar(16) not null comment '配药人性别，1男，2女',
   person_birth_date    datetime not null comment '配药人出生日期',
   person_age           int not null comment '配药人年龄',
   person_phone_no      varchar(16) not null comment '配药人手机号码',
   question             varchar(1000) not null comment '问题描述',
   diagnosis            varchar(1000) not null comment '诊断小结',
   diagnosis_ids        varchar(100) comment '诊断id，用英文逗号分隔',
   drug_ids             varchar(100) not null comment '复诊提交药物id，用英文逗号分隔',
   photo_ids            varchar(512) comment '问诊照片id，用英文逗号分隔',
   consult_status       varchar(36) comment '复诊配药状态，1待接诊，2进行中，3已完成',
   consult_create_time  datetime comment '创建时间',
   consult_accept_time  datetime comment '接诊时间',
   consult_finish_time  datetime comment '完成时间',
   primary key (consult_id)
);

alter table consult_ask comment '问诊记录表';

/*==============================================================*/
/* Table: department                                            */
/*==============================================================*/
create table department
(
   dept_id              int not null comment '科室id',
   dept_name            varchar(64) not null comment '科室名称',
   primary key (dept_id)
);

alter table department comment '科室表';

/*==============================================================*/
/* Table: diagnosis                                             */
/*==============================================================*/
create table diagnosis
(
   diagnosis_id         int not null comment '诊断标识',
   diagnosis_type       char(2) not null comment '诊断类型，1西医，2中医',
   diseases_code        varchar(36) not null comment '诊断类型为西医时为疾病代码，为中医时为中医疾病代码',
   diseases_id          int not null comment '诊断类型为西医时为疾病标识，为中医时为中医疾病标识',
   diseases_name        varchar(36) not null comment '诊断类型为西医时为疾病名称，为中医时为中医疾病名称',
   diseases_pinyin_code varchar(36) not null comment '拼音码',
   primary key (diagnosis_id)
);

alter table diagnosis comment '基础诊断表';

/*==============================================================*/
/* Table: doctor                                                */
/*==============================================================*/
create table doctor
(
   doctor_id            varchar(36) not null comment '医生id',
   dept_id              int comment '科室id',
   doctor_name          varchar(64) not null comment '医生姓名',
   org_name             varchar(64) not null comment '机构名称',
   avatar_url           varchar(255) comment '医生头像链接',
   level_code           char(2) comment '医生职称，1主任医师，2副主任医师，3主治医师，4医师，5医士',
   level_name           varchar(32) comment '医生职称，1主任医师，2副主任医师，3主治医师，4医师，5医士',
   primary key (doctor_id)
);

alter table doctor comment '医生表';

/*==============================================================*/
/* Table: drug                                                  */
/*==============================================================*/
create table drug
(
   drug_id              int not null comment '药品id',
   drug_name            varchar(255) not null comment '药品通用名称',
   trade_name           varchar(255) not null comment '商品名',
   drug_pinyin_code     varchar(64) not null comment '拼音码',
   specification        varchar(255) not null comment '药品规格',
   pack_unit            char(4) not null comment '包装单位',
   price                decimal(10,2) not null comment '药品价格',
   dose                 decimal(10,2) not null comment '剂量',
   dose_unit            varchar(4) not null comment '剂量单位',
   factory_name         varchar(255) comment '产地',
   approval_number      varchar(64) comment '批准文号',
   primary key (drug_id)
);

alter table drug comment '基础药品表';

/*==============================================================*/
/* Table: drug_frequency                                        */
/*==============================================================*/
create table drug_frequency
(
   frequency_code       int not null comment '项目代码',
   frequency_name       varchar(32) not null comment '项目名称',
   frequency_name_abbr  varchar(32) not null comment '项目名称缩写',
   primary key (frequency_code)
);

alter table drug_frequency comment '药品频次表';

/*==============================================================*/
/* Table: drug_usage                                            */
/*==============================================================*/
create table drug_usage
(
   usage_code           int not null comment '项目代码',
   usage_name           varchar(32) not null comment '项目名称',
   primary key (usage_code)
);

alter table drug_usage comment '药品用法表';

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   order_id             int not null comment '订单id',
   consult_id           int comment '问诊id',
   order_state          varchar(36) comment '订单状态，1未配送，2配送中，3配送完成',
   primary key (order_id)
);

alter table orders comment '订单表';

/*==============================================================*/
/* Table: prescription_drug                                     */
/*==============================================================*/
create table prescription_drug
(
   prescription_drug_id int not null comment '处方药品标识',
   usage_code           int comment '项目代码',
   drug_id              int comment '药品id',
   prescription_id      int comment '处方id',
   frequency_code       int comment '项目代码',
   take_days            int comment '用药天数',
   quantity             int comment '药品数量',
   group_number         int comment '组号',
   sort_number          int comment '顺序号',
   remark               varchar(100) comment '嘱托',
   primary key (prescription_drug_id)
);

alter table prescription_drug comment '处方药品表';

/*==============================================================*/
/* Table: prescription_info                                     */
/*==============================================================*/
create table prescription_info
(
   prescription_id      int not null comment '处方id',
   consult_id           int comment '问诊id',
   prescription_type    char(2) not null comment '处方类型，1西药，2中成药，3中草药',
   prescription_create_time datetime not null comment '开方时间',
   prescription_status  char(2) not null comment '处方提交状态，0未提交 ，1已提交 ',
   primary key (prescription_id)
);

alter table address add constraint FK_live foreign key (account_id)
      references account (account_id) on delete restrict on update restrict;

alter table appointment add constraint FK_appointment foreign key (account_id)
      references account (account_id) on delete restrict on update restrict;

alter table appointment add constraint FK_appointment2 foreign key (doctor_id)
      references doctor (doctor_id) on delete restrict on update restrict;

alter table consult_ask add constraint FK_apply foreign key (account_id)
      references account (account_id) on delete restrict on update restrict;

alter table consult_ask add constraint FK_receive foreign key (doctor_id)
      references doctor (doctor_id) on delete restrict on update restrict;

alter table doctor add constraint FK_work foreign key (dept_id)
      references department (dept_id) on delete restrict on update restrict;

alter table orders add constraint FK_dispatching foreign key (consult_id)
      references consult_ask (consult_id) on delete restrict on update restrict;

alter table prescription_drug add constraint FK_drug_use foreign key (drug_id)
      references drug (drug_id) on delete restrict on update restrict;

alter table prescription_drug add constraint FK_frequency_use foreign key (frequency_code)
      references drug_frequency (frequency_code) on delete restrict on update restrict;

alter table prescription_drug add constraint FK_list foreign key (prescription_id)
      references prescription_info (prescription_id) on delete restrict on update restrict;

alter table prescription_drug add constraint FK_usage_use foreign key (usage_code)
      references drug_usage (usage_code) on delete restrict on update restrict;

alter table prescription_info add constraint FK_prescribe foreign key (consult_id)
      references consult_ask (consult_id) on delete restrict on update restrict;


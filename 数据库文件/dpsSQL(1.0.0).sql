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
   account_id           varchar(36) not null comment '�û�id',
   account_type         char(2) not null comment '�û����ͣ�1����2ҽ��',
   mini_open_id         varchar(36) not null comment '΢��С����openid',
   phone_no             varchar(36) not null comment '�ֻ�����',
   account_create_time  datetime not null comment '����ʱ��',
   primary key (account_id)
);

alter table account comment '�û���';

/*==============================================================*/
/* Table: address                                               */
/*==============================================================*/
create table address
(
   address_id           int not null comment '��ַid',
   account_id           varchar(36) comment '�û�id',
   address_info         varchar(100) not null comment '��ַ��Ϣ',
   primary key (address_id)
);

/*==============================================================*/
/* Table: appointment                                           */
/*==============================================================*/
create table appointment
(
   account_id           varchar(36) not null comment '�û�id',
   doctor_id            varchar(36) not null comment 'ҽ��id',
   primary key (account_id, doctor_id)
);

/*==============================================================*/
/* Table: consult_ask                                           */
/*==============================================================*/
create table consult_ask
(
   consult_id           int not null comment '����id',
   account_id           varchar(36) comment '�û�id',
   doctor_id            varchar(36) comment 'ҽ��id',
   person_name          varchar(64) not null comment '��ҩ������',
   person_card_type     char(4) not null comment '��ҩ��֤�����ͣ�01�������֤ 02���񻧿ڲ� 03���� 04����֤ 05��ʻ֤ 06�۰ľ��������ڵ�ͨ��֤ 07̨����������ڵ�ͨ��֤ 11����֤�� 12�۰ľ������֤ 13�۰ľ����ס֤ 99����������Ч֤��',
   person_card_id       varchar(64) not null comment '��ҩ��֤������',
   person_gender_name   varchar(16) not null comment '��ҩ���Ա�1�У�2Ů',
   person_birth_date    datetime not null comment '��ҩ�˳�������',
   person_age           int not null comment '��ҩ������',
   person_phone_no      varchar(16) not null comment '��ҩ���ֻ�����',
   question             varchar(1000) not null comment '��������',
   diagnosis            varchar(1000) not null comment '���С��',
   diagnosis_ids        varchar(100) comment '���id����Ӣ�Ķ��ŷָ�',
   drug_ids             varchar(100) not null comment '�����ύҩ��id����Ӣ�Ķ��ŷָ�',
   photo_ids            varchar(512) comment '������Ƭid����Ӣ�Ķ��ŷָ�',
   consult_status       varchar(36) comment '������ҩ״̬��1�����2�����У�3�����',
   consult_create_time  datetime comment '����ʱ��',
   consult_accept_time  datetime comment '����ʱ��',
   consult_finish_time  datetime comment '���ʱ��',
   primary key (consult_id)
);

alter table consult_ask comment '�����¼��';

/*==============================================================*/
/* Table: department                                            */
/*==============================================================*/
create table department
(
   dept_id              int not null comment '����id',
   dept_name            varchar(64) not null comment '��������',
   primary key (dept_id)
);

alter table department comment '���ұ�';

/*==============================================================*/
/* Table: diagnosis                                             */
/*==============================================================*/
create table diagnosis
(
   diagnosis_id         int not null comment '��ϱ�ʶ',
   diagnosis_type       char(2) not null comment '������ͣ�1��ҽ��2��ҽ',
   diseases_code        varchar(36) not null comment '�������Ϊ��ҽʱΪ�������룬Ϊ��ҽʱΪ��ҽ��������',
   diseases_id          int not null comment '�������Ϊ��ҽʱΪ������ʶ��Ϊ��ҽʱΪ��ҽ������ʶ',
   diseases_name        varchar(36) not null comment '�������Ϊ��ҽʱΪ�������ƣ�Ϊ��ҽʱΪ��ҽ��������',
   diseases_pinyin_code varchar(36) not null comment 'ƴ����',
   primary key (diagnosis_id)
);

alter table diagnosis comment '������ϱ�';

/*==============================================================*/
/* Table: doctor                                                */
/*==============================================================*/
create table doctor
(
   doctor_id            varchar(36) not null comment 'ҽ��id',
   dept_id              int comment '����id',
   doctor_name          varchar(64) not null comment 'ҽ������',
   org_name             varchar(64) not null comment '��������',
   avatar_url           varchar(255) comment 'ҽ��ͷ������',
   level_code           char(2) comment 'ҽ��ְ�ƣ�1����ҽʦ��2������ҽʦ��3����ҽʦ��4ҽʦ��5ҽʿ',
   level_name           varchar(32) comment 'ҽ��ְ�ƣ�1����ҽʦ��2������ҽʦ��3����ҽʦ��4ҽʦ��5ҽʿ',
   primary key (doctor_id)
);

alter table doctor comment 'ҽ����';

/*==============================================================*/
/* Table: drug                                                  */
/*==============================================================*/
create table drug
(
   drug_id              int not null comment 'ҩƷid',
   drug_name            varchar(255) not null comment 'ҩƷͨ������',
   trade_name           varchar(255) not null comment '��Ʒ��',
   drug_pinyin_code     varchar(64) not null comment 'ƴ����',
   specification        varchar(255) not null comment 'ҩƷ���',
   pack_unit            char(4) not null comment '��װ��λ',
   price                decimal(10,2) not null comment 'ҩƷ�۸�',
   dose                 decimal(10,2) not null comment '����',
   dose_unit            varchar(4) not null comment '������λ',
   factory_name         varchar(255) comment '����',
   approval_number      varchar(64) comment '��׼�ĺ�',
   primary key (drug_id)
);

alter table drug comment '����ҩƷ��';

/*==============================================================*/
/* Table: drug_frequency                                        */
/*==============================================================*/
create table drug_frequency
(
   frequency_code       int not null comment '��Ŀ����',
   frequency_name       varchar(32) not null comment '��Ŀ����',
   frequency_name_abbr  varchar(32) not null comment '��Ŀ������д',
   primary key (frequency_code)
);

alter table drug_frequency comment 'ҩƷƵ�α�';

/*==============================================================*/
/* Table: drug_usage                                            */
/*==============================================================*/
create table drug_usage
(
   usage_code           int not null comment '��Ŀ����',
   usage_name           varchar(32) not null comment '��Ŀ����',
   primary key (usage_code)
);

alter table drug_usage comment 'ҩƷ�÷���';

/*==============================================================*/
/* Table: orders                                                */
/*==============================================================*/
create table orders
(
   order_id             int not null comment '����id',
   consult_id           int comment '����id',
   order_state          varchar(36) comment '����״̬��1δ���ͣ�2�����У�3�������',
   primary key (order_id)
);

alter table orders comment '������';

/*==============================================================*/
/* Table: prescription_drug                                     */
/*==============================================================*/
create table prescription_drug
(
   prescription_drug_id int not null comment '����ҩƷ��ʶ',
   usage_code           int comment '��Ŀ����',
   drug_id              int comment 'ҩƷid',
   prescription_id      int comment '����id',
   frequency_code       int comment '��Ŀ����',
   take_days            int comment '��ҩ����',
   quantity             int comment 'ҩƷ����',
   group_number         int comment '���',
   sort_number          int comment '˳���',
   remark               varchar(100) comment '����',
   primary key (prescription_drug_id)
);

alter table prescription_drug comment '����ҩƷ��';

/*==============================================================*/
/* Table: prescription_info                                     */
/*==============================================================*/
create table prescription_info
(
   prescription_id      int not null comment '����id',
   consult_id           int comment '����id',
   prescription_type    char(2) not null comment '�������ͣ�1��ҩ��2�г�ҩ��3�в�ҩ',
   prescription_create_time datetime not null comment '����ʱ��',
   prescription_status  char(2) not null comment '�����ύ״̬��0δ�ύ ��1���ύ ',
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


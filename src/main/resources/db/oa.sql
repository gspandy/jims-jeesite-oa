
create table ACT_EVT_LOG
(
  log_nr_       NUMBER(6) not null,
  type_         VARCHAR2(64),
  proc_def_id_  VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  execution_id_ VARCHAR2(64),
  task_id_      VARCHAR2(64),
  time_stamp_   TIMESTAMP(6) default CURRENT_TIMESTAMP(3) not null,
  user_id_      VARCHAR2(255),
  data_         BLOB,
  lock_owner_   VARCHAR2(255),
  lock_time_    TIMESTAMP(6),
  is_processed_ NUMBER default 0
)
;
alter table ACT_EVT_LOG
  add constraint PK_ACT_EVT_LOG primary key (LOG_NR_);


create table ACT_RE_DEPLOYMENT
(
  id_          VARCHAR2(64) not null,
  name_        VARCHAR2(255),
  category_    VARCHAR2(255),
  tenant_id_   VARCHAR2(255),
  deploy_time_ TIMESTAMP(6)
)
;
alter table ACT_RE_DEPLOYMENT
  add constraint PK_ACT_RE_DEPLOYMENT primary key (ID_);


create table ACT_GE_BYTEARRAY
(
  id_            VARCHAR2(64) not null,
  rev_           NUMBER,
  name_          VARCHAR2(255),
  deployment_id_ VARCHAR2(64),
  bytes_         BLOB,
  generated_     NUMBER
)
;
alter table ACT_GE_BYTEARRAY
  add constraint PK_ACT_GE_BYTEARRAY primary key (ID_);
alter table ACT_GE_BYTEARRAY
  add constraint ACT_FK_BYTEARR_DEPL foreign key (DEPLOYMENT_ID_)
  references ACT_RE_DEPLOYMENT (ID_);


create table ACT_GE_PROPERTY
(
  name_  VARCHAR2(64) not null,
  value_ VARCHAR2(300),
  rev_   NUMBER
)
;
alter table ACT_GE_PROPERTY
  add constraint PK_ACT_GE_PROPERTY primary key (NAME_);


create table ACT_HI_ACTINST
(
  id_                VARCHAR2(64) not null,
  proc_def_id_       VARCHAR2(64) not null,
  proc_inst_id_      VARCHAR2(64) not null,
  execution_id_      VARCHAR2(64) not null,
  act_id_            VARCHAR2(255) not null,
  task_id_           VARCHAR2(64),
  call_proc_inst_id_ VARCHAR2(64),
  act_name_          VARCHAR2(255),
  act_type_          VARCHAR2(255) not null,
  assignee_          VARCHAR2(255),
  start_time_        DATE not null,
  end_time_          DATE,
  duration_          NUMBER,
  tenant_id_         VARCHAR2(255)
)
;
create index ACT_IDX_HI_ACT_INST_END on ACT_HI_ACTINST (END_TIME_);
create index ACT_IDX_HI_ACT_INST_START on ACT_HI_ACTINST (START_TIME_);
alter table ACT_HI_ACTINST
  add constraint PK_ACT_HI_ACTINST primary key (ID_);


create table ACT_HI_ATTACHMENT
(
  id_           VARCHAR2(64) not null,
  rev_          NUMBER,
  user_id_      VARCHAR2(255),
  name_         VARCHAR2(255),
  description_  VARCHAR2(4000),
  type_         VARCHAR2(255),
  task_id_      VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  url_          VARCHAR2(4000),
  content_id_   VARCHAR2(64),
  time_         TIMESTAMP(3)
)
;
alter table ACT_HI_ATTACHMENT
  add constraint PK_ACT_HI_ATTACHMENT primary key (ID_);


create table ACT_HI_COMMENT
(
  id_           VARCHAR2(64) not null,
  type_         VARCHAR2(255),
  time_         DATE not null,
  user_id_      VARCHAR2(255),
  task_id_      VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  action_       VARCHAR2(255),
  message_      VARCHAR2(4000),
  full_msg_     BLOB
)
;
alter table ACT_HI_COMMENT
  add constraint PK_ACT_HI_COMMENT primary key (ID_);


create table ACT_HI_DETAIL
(
  id_           VARCHAR2(64) not null,
  type_         VARCHAR2(255) not null,
  proc_inst_id_ VARCHAR2(64),
  execution_id_ VARCHAR2(64),
  task_id_      VARCHAR2(64),
  act_inst_id_  VARCHAR2(64),
  name_         VARCHAR2(255) not null,
  var_type_     VARCHAR2(255),
  rev_          NUMBER,
  time_         DATE not null,
  bytearray_id_ VARCHAR2(64),
  double_       BINARY_DOUBLE,
  long_         NUMBER,
  text_         VARCHAR2(4000),
  text2_        VARCHAR2(4000)
)
;
create index ACT_IDX_HI_DETAIL_ACT_INST on ACT_HI_DETAIL (ACT_INST_ID_);
create index ACT_IDX_HI_DETAIL_NAME on ACT_HI_DETAIL (NAME_);
create index ACT_IDX_HI_DETAIL_PROC_INST on ACT_HI_DETAIL (PROC_INST_ID_);
create index ACT_IDX_HI_DETAIL_TASK_ID on ACT_HI_DETAIL (TASK_ID_);
create index ACT_IDX_HI_DETAIL_TIME on ACT_HI_DETAIL (TIME_);
alter table ACT_HI_DETAIL
  add constraint PK_ACT_HI_DETAIL primary key (ID_);


create table ACT_HI_IDENTITYLINK
(
  id_           VARCHAR2(64) not null,
  group_id_     VARCHAR2(255),
  type_         VARCHAR2(255),
  user_id_      VARCHAR2(255),
  task_id_      VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64)
)
;
create index ACT_IDX_HI_IDENT_LNK_PROCINST on ACT_HI_IDENTITYLINK (PROC_INST_ID_);
create index ACT_IDX_HI_IDENT_LNK_TASK on ACT_HI_IDENTITYLINK (TASK_ID_);
create index ACT_IDX_HI_IDENT_LNK_USER on ACT_HI_IDENTITYLINK (USER_ID_);
alter table ACT_HI_IDENTITYLINK
  add constraint PK_ACT_HI_IDENTITYLINK primary key (ID_);


create table ACT_HI_PROCINST
(
  id_                        VARCHAR2(64) not null,
  proc_inst_id_              VARCHAR2(64) not null,
  business_key_              VARCHAR2(255),
  proc_def_id_               VARCHAR2(64) not null,
  start_time_                DATE not null,
  end_time_                  DATE,
  duration_                  NUMBER,
  start_user_id_             VARCHAR2(255),
  start_act_id_              VARCHAR2(255),
  end_act_id_                VARCHAR2(255),
  super_process_instance_id_ VARCHAR2(64),
  delete_reason_             VARCHAR2(4000),
  tenant_id_                 VARCHAR2(255),
  name_                      VARCHAR2(255)
)
;
create index ACT_IDX_HI_PRO_INST_END on ACT_HI_PROCINST (END_TIME_);
create index ACT_IDX_HI_PRO_I_BUSKEY on ACT_HI_PROCINST (BUSINESS_KEY_);
alter table ACT_HI_PROCINST
  add constraint PK_ACT_HI_PROCINST primary key (ID_);
alter table ACT_HI_PROCINST
  add constraint PROC_INST_ID_ unique (PROC_INST_ID_);


create table ACT_HI_TASKINST
(
  id_             VARCHAR2(64) not null,
  proc_def_id_    VARCHAR2(64),
  task_def_key_   VARCHAR2(255),
  proc_inst_id_   VARCHAR2(64),
  execution_id_   VARCHAR2(64),
  name_           VARCHAR2(255),
  parent_task_id_ VARCHAR2(64),
  description_    VARCHAR2(4000),
  owner_          VARCHAR2(255),
  assignee_       VARCHAR2(255),
  start_time_     DATE not null,
  claim_time_     DATE,
  end_time_       DATE,
  duration_       NUMBER,
  delete_reason_  VARCHAR2(4000),
  priority_       NUMBER,
  due_date_       DATE,
  form_key_       VARCHAR2(255),
  category_       VARCHAR2(255),
  tenant_id_      VARCHAR2(255)
)
;
create index ACT_IDX_HI_TASK_INST_PROCINST on ACT_HI_TASKINST (PROC_INST_ID_);
alter table ACT_HI_TASKINST
  add constraint PK_ACT_HI_TASKINST primary key (ID_);


create table ACT_HI_VARINST
(
  id_                VARCHAR2(64) not null,
  proc_inst_id_      VARCHAR2(64),
  execution_id_      VARCHAR2(64),
  task_id_           VARCHAR2(64),
  name_              VARCHAR2(255) not null,
  var_type_          VARCHAR2(100),
  rev_               NUMBER,
  bytearray_id_      VARCHAR2(64),
  double_            BINARY_DOUBLE,
  long_              NUMBER,
  text_              VARCHAR2(4000),
  text2_             VARCHAR2(4000),
  create_time_       DATE,
  last_updated_time_ DATE
)
;
create index ACT_IDX_HI_PROCVAR_PROC_INST on ACT_HI_VARINST (PROC_INST_ID_);
create index ACT_IDX_HI_PROCVAR_TASK_ID on ACT_HI_VARINST (TASK_ID_);
alter table ACT_HI_VARINST
  add constraint PK_ACT_HI_VARINST primary key (ID_);


create table ACT_ID_GROUP
(
  id_   VARCHAR2(64) not null,
  rev_  NUMBER,
  name_ VARCHAR2(255),
  type_ VARCHAR2(255)
)
;
alter table ACT_ID_GROUP
  add constraint PK_ACT_ID_GROUP primary key (ID_);


create table ACT_ID_INFO
(
  id_        VARCHAR2(64) not null,
  rev_       NUMBER,
  user_id_   VARCHAR2(64),
  type_      VARCHAR2(64),
  key_       VARCHAR2(255),
  value_     VARCHAR2(255),
  password_  BLOB,
  parent_id_ VARCHAR2(255)
)
;
alter table ACT_ID_INFO
  add constraint PK_ACT_ID_INFO primary key (ID_);


create table ACT_ID_USER
(
  id_         VARCHAR2(64) not null,
  rev_        NUMBER,
  first_      VARCHAR2(255),
  last_       VARCHAR2(255),
  email_      VARCHAR2(255),
  pwd_        VARCHAR2(255),
  picture_id_ VARCHAR2(64)
)
;
alter table ACT_ID_USER
  add constraint PK_ACT_ID_USER primary key (ID_);


create table ACT_ID_MEMBERSHIP
(
  user_id_  VARCHAR2(64) not null,
  group_id_ VARCHAR2(64) not null
)
;
alter table ACT_ID_MEMBERSHIP
  add constraint PK_ACT_ID_MEMBERSHIP primary key (USER_ID_, GROUP_ID_);
alter table ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_GROUP foreign key (GROUP_ID_)
  references ACT_ID_GROUP (ID_);
alter table ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_USER foreign key (USER_ID_)
  references ACT_ID_USER (ID_);

create table ACT_RE_PROCDEF
(
  id_                     VARCHAR2(64) not null,
  rev_                    NUMBER,
  category_               VARCHAR2(255),
  name_                   VARCHAR2(255),
  key_                    VARCHAR2(255) not null,
  version_                NUMBER not null,
  deployment_id_          VARCHAR2(64),
  resource_name_          VARCHAR2(4000),
  dgrm_resource_name_     VARCHAR2(4000),
  description_            VARCHAR2(4000),
  has_start_form_key_     NUMBER,
  suspension_state_       NUMBER,
  tenant_id_              VARCHAR2(255),
  has_graphical_notation_ NUMBER
)
;
alter table ACT_RE_PROCDEF
  add constraint PK_ACT_RE_PROCDEF primary key (ID_);
alter table ACT_RE_PROCDEF
  add constraint ACT_UNIQ_PROCDEF unique (KEY_, VERSION_, TENANT_ID_);


create table ACT_PROCDEF_INFO
(
  id_           VARCHAR2(64) not null,
  proc_def_id_  VARCHAR2(64) not null,
  rev_          NUMBER,
  info_json_id_ VARCHAR2(64)
)
;
alter table ACT_PROCDEF_INFO
  add constraint PK_ACT_PROCDEF_INFO primary key (ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_UNIQ_INFO_PROCDEF unique (PROC_DEF_ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_JSON_BA foreign key (INFO_JSON_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);


create table ACT_RE_MODEL
(
  id_                           VARCHAR2(64) not null,
  rev_                          NUMBER,
  name_                         VARCHAR2(255),
  key_                          VARCHAR2(255),
  category_                     VARCHAR2(255),
  create_time_                  TIMESTAMP(6),
  last_update_time_             TIMESTAMP(6),
  version_                      NUMBER,
  meta_info_                    VARCHAR2(4000),
  deployment_id_                VARCHAR2(64),
  editor_source_value_id_       VARCHAR2(64),
  editor_source_extra_value_id_ VARCHAR2(64),
  tenant_id_                    VARCHAR2(255)
)
;
alter table ACT_RE_MODEL
  add constraint PK_ACT_RE_MODEL primary key (ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_DEPLOYMENT foreign key (DEPLOYMENT_ID_)
  references ACT_RE_DEPLOYMENT (ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE foreign key (EDITOR_SOURCE_VALUE_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE_EXTRA foreign key (EDITOR_SOURCE_EXTRA_VALUE_ID_)
  references ACT_GE_BYTEARRAY (ID_);


create table ACT_RU_EXECUTION
(
  id_               VARCHAR2(64) not null,
  rev_              NUMBER,
  proc_inst_id_     VARCHAR2(64),
  business_key_     VARCHAR2(255),
  parent_id_        VARCHAR2(64),
  proc_def_id_      VARCHAR2(64),
  super_exec_       VARCHAR2(64),
  act_id_           VARCHAR2(255),
  is_active_        NUMBER,
  is_concurrent_    NUMBER,
  is_scope_         NUMBER,
  is_event_scope_   NUMBER,
  suspension_state_ NUMBER,
  cached_ent_state_ NUMBER,
  tenant_id_        VARCHAR2(255),
  name_             VARCHAR2(255),
  lock_time_        TIMESTAMP(6)
)
;
create index ACT_IDX_EXEC_BUSKEY on ACT_RU_EXECUTION (BUSINESS_KEY_);
alter table ACT_RU_EXECUTION
  add constraint PK_ACT_RU_EXECUTION primary key (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PARENT foreign key (PARENT_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_SUPER foreign key (SUPER_EXEC_)
  references ACT_RU_EXECUTION (ID_);


create table ACT_RU_EVENT_SUBSCR
(
  id_            VARCHAR2(64) not null,
  rev_           NUMBER,
  event_type_    VARCHAR2(255) not null,
  event_name_    VARCHAR2(255),
  execution_id_  VARCHAR2(64),
  proc_inst_id_  VARCHAR2(64),
  activity_id_   VARCHAR2(64),
  configuration_ VARCHAR2(255),
  created_       TIMESTAMP(6) default CURRENT_TIMESTAMP not null,
  proc_def_id_   VARCHAR2(64),
  tenant_id_     VARCHAR2(255)
)
;
create index ACT_IDX_EVENT_SUBSCR_CONFIG_ on ACT_RU_EVENT_SUBSCR (CONFIGURATION_);
alter table ACT_RU_EVENT_SUBSCR
  add constraint PK_ACT_RU_EVENT_SUBSCR primary key (ID_);
alter table ACT_RU_EVENT_SUBSCR
  add constraint ACT_FK_EVENT_EXEC foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);


create table ACT_RU_TASK
(
  id_               VARCHAR2(64) not null,
  rev_              NUMBER,
  execution_id_     VARCHAR2(64),
  proc_inst_id_     VARCHAR2(64),
  proc_def_id_      VARCHAR2(64),
  name_             VARCHAR2(255),
  parent_task_id_   VARCHAR2(64),
  description_      VARCHAR2(4000),
  task_def_key_     VARCHAR2(255),
  owner_            VARCHAR2(255),
  assignee_         VARCHAR2(255),
  delegation_       VARCHAR2(64),
  priority_         NUMBER,
  create_time_      TIMESTAMP(6),
  due_date_         DATE,
  category_         VARCHAR2(255),
  suspension_state_ NUMBER,
  tenant_id_        VARCHAR2(255),
  form_key_         VARCHAR2(255)
)
;
create index ACT_IDX_TASK_CREATE on ACT_RU_TASK (CREATE_TIME_);
alter table ACT_RU_TASK
  add constraint PK_ACT_RU_TASK primary key (ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_EXE foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);


create table ACT_RU_IDENTITYLINK
(
  id_           VARCHAR2(64) not null,
  rev_          NUMBER,
  group_id_     VARCHAR2(255),
  type_         VARCHAR2(255),
  user_id_      VARCHAR2(255),
  task_id_      VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  proc_def_id_  VARCHAR2(64)
)
;
create index ACT_IDX_IDENT_LNK_GROUP on ACT_RU_IDENTITYLINK (GROUP_ID_);
create index ACT_IDX_IDENT_LNK_USER on ACT_RU_IDENTITYLINK (USER_ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint PK_ACT_RU_IDENTITYLINK primary key (ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_ATHRZ_PROCEDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_IDL_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_TSKASS_TASK foreign key (TASK_ID_)
  references ACT_RU_TASK (ID_);


create table ACT_RU_JOB
(
  id_                  VARCHAR2(64) not null,
  rev_                 NUMBER,
  type_                VARCHAR2(255) not null,
  lock_exp_time_       TIMESTAMP(6),
  lock_owner_          VARCHAR2(255),
  exclusive_           NUMBER,
  execution_id_        VARCHAR2(64),
  process_instance_id_ VARCHAR2(64),
  proc_def_id_         VARCHAR2(64),
  retries_             NUMBER,
  exception_stack_id_  VARCHAR2(64),
  exception_msg_       VARCHAR2(4000),
  duedate_             TIMESTAMP(6),
  repeat_              VARCHAR2(255),
  handler_type_        VARCHAR2(255),
  handler_cfg_         VARCHAR2(4000),
  tenant_id_           VARCHAR2(255)
)
;
alter table ACT_RU_JOB
  add constraint PK_ACT_RU_JOB primary key (ID_);
alter table ACT_RU_JOB
  add constraint ACT_FK_JOB_EXCEPTION foreign key (EXCEPTION_STACK_ID_)
  references ACT_GE_BYTEARRAY (ID_);


create table ACT_RU_VARIABLE
(
  id_           VARCHAR2(64) not null,
  rev_          NUMBER,
  type_         VARCHAR2(255) not null,
  name_         VARCHAR2(255) not null,
  execution_id_ VARCHAR2(64),
  proc_inst_id_ VARCHAR2(64),
  task_id_      VARCHAR2(64),
  bytearray_id_ VARCHAR2(64),
  double_       BINARY_DOUBLE,
  long_         NUMBER,
  text_         VARCHAR2(4000),
  text2_        VARCHAR2(4000)
)
;
create index ACT_IDX_VARIABLE_TASK_ID on ACT_RU_VARIABLE (TASK_ID_);
alter table ACT_RU_VARIABLE
  add constraint PK_ACT_RU_VARIABLE primary key (ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_BYTEARRAY foreign key (BYTEARRAY_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_EXE foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);


create table CHENXY_TEST
(
  id   VARCHAR2(64) not null,
  name VARCHAR2(20) not null
)
;
comment on table CHENXY_TEST
  is '������ceshi';
comment on column CHENXY_TEST.id
  is '���';
comment on column CHENXY_TEST.name
  is 'name';
alter table CHENXY_TEST
  add constraint PK_CHENXY_TEST primary key (ID);


create table CHENXY_TEST3
(
  id   VARCHAR2(64) not null,
  name VARCHAR2(10) not null
)
;
comment on table CHENXY_TEST3
  is '��������';
comment on column CHENXY_TEST3.id
  is '���';
comment on column CHENXY_TEST3.name
  is '����';
alter table CHENXY_TEST3
  add constraint PK_CHENXY_TEST3 primary key (ID);


create table CHENYX_TEST22
(
  id   VARCHAR2(64) not null,
  name VARCHAR2(12) not null
)
;
comment on table CHENYX_TEST22
  is '������ceshi';
comment on column CHENYX_TEST22.id
  is '���';
comment on column CHENYX_TEST22.name
  is 'name';
alter table CHENYX_TEST22
  add constraint PK_CHENYX_TEST22 primary key (ID);


create table CMS_ARTICLE
(
  id                  VARCHAR2(64) not null,
  category_id         VARCHAR2(64) not null,
  title               VARCHAR2(255) not null,
  link                VARCHAR2(255),
  color               VARCHAR2(50),
  image               VARCHAR2(255),
  keywords            VARCHAR2(255),
  description         VARCHAR2(255),
  weight              NUMBER default 0,
  weight_date         DATE,
  hits                NUMBER default 0,
  posid               VARCHAR2(10),
  custom_content_view VARCHAR2(255),
  view_config         CLOB,
  create_by           VARCHAR2(64),
  create_date         DATE,
  update_by           VARCHAR2(64),
  update_date         DATE,
  remarks             VARCHAR2(255),
  del_flag            CHAR(1) default '0' not null
)
;
comment on table CMS_ARTICLE
  is '���±�';
comment on column CMS_ARTICLE.id
  is '���';
comment on column CMS_ARTICLE.category_id
  is '��Ŀ���';
comment on column CMS_ARTICLE.title
  is '����';
comment on column CMS_ARTICLE.link
  is '��������';
comment on column CMS_ARTICLE.color
  is '������ɫ';
comment on column CMS_ARTICLE.image
  is '����ͼƬ';
comment on column CMS_ARTICLE.keywords
  is '�ؼ���';
comment on column CMS_ARTICLE.description
  is '������ժҪ';
comment on column CMS_ARTICLE.weight
  is 'Ȩ�أ�Խ��Խ��ǰ';
comment on column CMS_ARTICLE.weight_date
  is 'Ȩ������';
comment on column CMS_ARTICLE.hits
  is '�����';
comment on column CMS_ARTICLE.posid
  is '�Ƽ�λ����ѡ';
comment on column CMS_ARTICLE.custom_content_view
  is '�Զ���������ͼ';
comment on column CMS_ARTICLE.view_config
  is '��ͼ����';
comment on column CMS_ARTICLE.create_by
  is '������';
comment on column CMS_ARTICLE.create_date
  is '����ʱ��';
comment on column CMS_ARTICLE.update_by
  is '������';
comment on column CMS_ARTICLE.update_date
  is '����ʱ��';
comment on column CMS_ARTICLE.remarks
  is '��ע��Ϣ';
comment on column CMS_ARTICLE.del_flag
  is 'ɾ�����';
create index CMS_ARTICLE_CATEGORY_ID on CMS_ARTICLE (CATEGORY_ID);
create index CMS_ARTICLE_CREATE_BY on CMS_ARTICLE (CREATE_BY);
create index CMS_ARTICLE_DEL_FLAG on CMS_ARTICLE (DEL_FLAG);
create index CMS_ARTICLE_KEYWORDS on CMS_ARTICLE (KEYWORDS);
create index CMS_ARTICLE_TITLE on CMS_ARTICLE (TITLE);
create index CMS_ARTICLE_UPDATE_DATE on CMS_ARTICLE (UPDATE_DATE);
create index CMS_ARTICLE_WEIGHT on CMS_ARTICLE (WEIGHT);
alter table CMS_ARTICLE
  add constraint PK_CMS_ARTICLE primary key (ID);


create table CMS_ARTICLE_DATA
(
  id            VARCHAR2(64) not null,
  content       CLOB,
  copyfrom      VARCHAR2(255),
  relation      VARCHAR2(255),
  allow_comment CHAR(1)
)
;
comment on table CMS_ARTICLE_DATA
  is '�������';
comment on column CMS_ARTICLE_DATA.id
  is '���';
comment on column CMS_ARTICLE_DATA.content
  is '��������';
comment on column CMS_ARTICLE_DATA.copyfrom
  is '������Դ';
comment on column CMS_ARTICLE_DATA.relation
  is '�������';
comment on column CMS_ARTICLE_DATA.allow_comment
  is '�Ƿ���������';
alter table CMS_ARTICLE_DATA
  add constraint PK_CMS_ARTICLE_DATA primary key (ID);


create table CMS_CATEGORY
(
  id                  VARCHAR2(64) not null,
  parent_id           VARCHAR2(64) not null,
  parent_ids          VARCHAR2(2000) not null,
  site_id             VARCHAR2(64) default '1',
  office_id           VARCHAR2(64),
  module              VARCHAR2(20),
  name                VARCHAR2(100) not null,
  image               VARCHAR2(255),
  href                VARCHAR2(255),
  target              VARCHAR2(20),
  description         VARCHAR2(255),
  keywords            VARCHAR2(255),
  sort                NUMBER default 30,
  in_menu             CHAR(1) default '1',
  in_list             CHAR(1) default '1',
  show_modes          CHAR(1) default '0',
  allow_comment       CHAR(1),
  is_audit            CHAR(1),
  custom_list_view    VARCHAR2(255),
  custom_content_view VARCHAR2(255),
  view_config         CLOB,
  create_by           VARCHAR2(64),
  create_date         DATE,
  update_by           VARCHAR2(64),
  update_date         DATE,
  remarks             VARCHAR2(255),
  del_flag            CHAR(1) default '0' not null
)
;
comment on table CMS_CATEGORY
  is '��Ŀ��';
comment on column CMS_CATEGORY.id
  is '���';
comment on column CMS_CATEGORY.parent_id
  is '�������';
comment on column CMS_CATEGORY.parent_ids
  is '���и������';
comment on column CMS_CATEGORY.site_id
  is 'վ����';
comment on column CMS_CATEGORY.office_id
  is '��������';
comment on column CMS_CATEGORY.module
  is '��Ŀģ��';
comment on column CMS_CATEGORY.name
  is '��Ŀ����';
comment on column CMS_CATEGORY.image
  is '��ĿͼƬ';
comment on column CMS_CATEGORY.href
  is '����';
comment on column CMS_CATEGORY.target
  is 'Ŀ��';
comment on column CMS_CATEGORY.description
  is '����';
comment on column CMS_CATEGORY.keywords
  is '�ؼ���';
comment on column CMS_CATEGORY.sort
  is '��������';
comment on column CMS_CATEGORY.in_menu
  is '�Ƿ��ڵ�������ʾ';
comment on column CMS_CATEGORY.in_list
  is '�Ƿ��ڷ���ҳ����ʾ�б�';
comment on column CMS_CATEGORY.show_modes
  is 'չ�ַ�ʽ';
comment on column CMS_CATEGORY.allow_comment
  is '�Ƿ���������';
comment on column CMS_CATEGORY.is_audit
  is '�Ƿ���Ҫ���';
comment on column CMS_CATEGORY.custom_list_view
  is '�Զ����б���ͼ';
comment on column CMS_CATEGORY.custom_content_view
  is '�Զ���������ͼ';
comment on column CMS_CATEGORY.view_config
  is '��ͼ����';
comment on column CMS_CATEGORY.create_by
  is '������';
comment on column CMS_CATEGORY.create_date
  is '����ʱ��';
comment on column CMS_CATEGORY.update_by
  is '������';
comment on column CMS_CATEGORY.update_date
  is '����ʱ��';
comment on column CMS_CATEGORY.remarks
  is '��ע��Ϣ';
comment on column CMS_CATEGORY.del_flag
  is 'ɾ�����';
create index CMS_CATEGORY_DEL_FLAG on CMS_CATEGORY (DEL_FLAG);
create index CMS_CATEGORY_MODULE on CMS_CATEGORY (MODULE);
create index CMS_CATEGORY_NAME on CMS_CATEGORY (NAME);
create index CMS_CATEGORY_OFFICE_ID on CMS_CATEGORY (OFFICE_ID);
create index CMS_CATEGORY_PARENT_ID on CMS_CATEGORY (PARENT_ID);
create index CMS_CATEGORY_SITE_ID on CMS_CATEGORY (SITE_ID);
create index CMS_CATEGORY_SORT on CMS_CATEGORY (SORT);
alter table CMS_CATEGORY
  add constraint PK_CMS_CATEGORY primary key (ID);


create table CMS_COMMENT
(
  id            VARCHAR2(64) not null,
  category_id   VARCHAR2(64) not null,
  content_id    VARCHAR2(64) not null,
  title         VARCHAR2(255),
  content       VARCHAR2(255),
  name          VARCHAR2(100),
  ip            VARCHAR2(100),
  create_date   DATE not null,
  audit_user_id VARCHAR2(64),
  audit_date    DATE,
  del_flag      CHAR(1) default '0' not null
)
;
comment on table CMS_COMMENT
  is '���۱�';
comment on column CMS_COMMENT.id
  is '���';
comment on column CMS_COMMENT.category_id
  is '��Ŀ���';
comment on column CMS_COMMENT.content_id
  is '��Ŀ���ݵı��';
comment on column CMS_COMMENT.title
  is '��Ŀ���ݵı���';
comment on column CMS_COMMENT.content
  is '��������';
comment on column CMS_COMMENT.name
  is '��������';
comment on column CMS_COMMENT.ip
  is '����IP';
comment on column CMS_COMMENT.create_date
  is '����ʱ��';
comment on column CMS_COMMENT.audit_user_id
  is '�����';
comment on column CMS_COMMENT.audit_date
  is '���ʱ��';
comment on column CMS_COMMENT.del_flag
  is 'ɾ�����';
create index CMS_COMMENT_CATEGORY_ID on CMS_COMMENT (CATEGORY_ID);
create index CMS_COMMENT_CONTENT_ID on CMS_COMMENT (CONTENT_ID);
create index CMS_COMMENT_STATUS on CMS_COMMENT (DEL_FLAG);
alter table CMS_COMMENT
  add constraint PK_CMS_COMMENT primary key (ID);


create table CMS_GUESTBOOK
(
  id          VARCHAR2(64) not null,
  type        CHAR(1) not null,
  content     VARCHAR2(255) not null,
  name        VARCHAR2(100) not null,
  email       VARCHAR2(100) not null,
  phone       VARCHAR2(100) not null,
  workunit    VARCHAR2(100) not null,
  ip          VARCHAR2(100) not null,
  create_date DATE not null,
  re_user_id  VARCHAR2(64),
  re_date     DATE,
  re_content  VARCHAR2(100),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table CMS_GUESTBOOK
  is '���԰�';
comment on column CMS_GUESTBOOK.id
  is '���';
comment on column CMS_GUESTBOOK.type
  is '���Է���';
comment on column CMS_GUESTBOOK.content
  is '��������';
comment on column CMS_GUESTBOOK.name
  is '����';
comment on column CMS_GUESTBOOK.email
  is '����';
comment on column CMS_GUESTBOOK.phone
  is '�绰';
comment on column CMS_GUESTBOOK.workunit
  is '��λ';
comment on column CMS_GUESTBOOK.ip
  is 'IP';
comment on column CMS_GUESTBOOK.create_date
  is '����ʱ��';
comment on column CMS_GUESTBOOK.re_user_id
  is '�ظ���';
comment on column CMS_GUESTBOOK.re_date
  is '�ظ�ʱ��';
comment on column CMS_GUESTBOOK.re_content
  is '�ظ�����';
comment on column CMS_GUESTBOOK.del_flag
  is 'ɾ�����';
create index CMS_GUESTBOOK_DEL_FLAG on CMS_GUESTBOOK (DEL_FLAG);
alter table CMS_GUESTBOOK
  add constraint PK_CMS_GUESTBOOK primary key (ID);


create table CMS_LINK
(
  id          VARCHAR2(64) not null,
  category_id VARCHAR2(64) not null,
  title       VARCHAR2(255) not null,
  color       VARCHAR2(50),
  image       VARCHAR2(255),
  href        VARCHAR2(255),
  weight      NUMBER default 0,
  weight_date DATE,
  create_by   VARCHAR2(64),
  create_date DATE,
  update_by   VARCHAR2(64),
  update_date DATE,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table CMS_LINK
  is '��������';
comment on column CMS_LINK.id
  is '���';
comment on column CMS_LINK.category_id
  is '��Ŀ���';
comment on column CMS_LINK.title
  is '��������';
comment on column CMS_LINK.color
  is '������ɫ';
comment on column CMS_LINK.image
  is '����ͼƬ';
comment on column CMS_LINK.href
  is '���ӵ�ַ';
comment on column CMS_LINK.weight
  is 'Ȩ�أ�Խ��Խ��ǰ';
comment on column CMS_LINK.weight_date
  is 'Ȩ������';
comment on column CMS_LINK.create_by
  is '������';
comment on column CMS_LINK.create_date
  is '����ʱ��';
comment on column CMS_LINK.update_by
  is '������';
comment on column CMS_LINK.update_date
  is '����ʱ��';
comment on column CMS_LINK.remarks
  is '��ע��Ϣ';
comment on column CMS_LINK.del_flag
  is 'ɾ�����';
create index CMS_LINK_CATEGORY_ID on CMS_LINK (CATEGORY_ID);
create index CMS_LINK_CREATE_BY on CMS_LINK (CREATE_BY);
create index CMS_LINK_DEL_FLAG on CMS_LINK (DEL_FLAG);
create index CMS_LINK_TITLE on CMS_LINK (TITLE);
create index CMS_LINK_UPDATE_DATE on CMS_LINK (UPDATE_DATE);
create index CMS_LINK_WEIGHT on CMS_LINK (WEIGHT);
alter table CMS_LINK
  add constraint PK_CMS_LINK primary key (ID);


create table CMS_SITE
(
  id                VARCHAR2(64) not null,
  name              VARCHAR2(100) not null,
  title             VARCHAR2(100) not null,
  logo              VARCHAR2(255),
  domain            VARCHAR2(255),
  description       VARCHAR2(255),
  keywords          VARCHAR2(255),
  theme             VARCHAR2(255) default 'default',
  copyright         CLOB,
  custom_index_view VARCHAR2(255),
  create_by         VARCHAR2(64),
  create_date       DATE,
  update_by         VARCHAR2(64),
  update_date       DATE,
  remarks           VARCHAR2(255),
  del_flag          CHAR(1) default '0' not null
)
;
comment on table CMS_SITE
  is 'վ���';
comment on column CMS_SITE.id
  is '���';
comment on column CMS_SITE.name
  is 'վ������';
comment on column CMS_SITE.title
  is 'վ�����';
comment on column CMS_SITE.logo
  is 'վ��Logo';
comment on column CMS_SITE.domain
  is 'վ������';
comment on column CMS_SITE.description
  is '����';
comment on column CMS_SITE.keywords
  is '�ؼ���';
comment on column CMS_SITE.theme
  is '����';
comment on column CMS_SITE.copyright
  is '��Ȩ��Ϣ';
comment on column CMS_SITE.custom_index_view
  is '�Զ���վ����ҳ��ͼ';
comment on column CMS_SITE.create_by
  is '������';
comment on column CMS_SITE.create_date
  is '����ʱ��';
comment on column CMS_SITE.update_by
  is '������';
comment on column CMS_SITE.update_date
  is '����ʱ��';
comment on column CMS_SITE.remarks
  is '��ע��Ϣ';
comment on column CMS_SITE.del_flag
  is 'ɾ�����';
create index CMS_SITE_DEL_FLAG on CMS_SITE (DEL_FLAG);
alter table CMS_SITE
  add constraint PK_CMS_SITE primary key (ID);


create table GEN_SCHEME
(
  id                   VARCHAR2(64) not null,
  name                 VARCHAR2(200),
  category             VARCHAR2(2000),
  package_name         VARCHAR2(500),
  module_name          VARCHAR2(30),
  sub_module_name      VARCHAR2(30),
  function_name        VARCHAR2(500),
  function_name_simple VARCHAR2(100),
  function_author      VARCHAR2(100),
  gen_table_id         VARCHAR2(200),
  create_by            VARCHAR2(64),
  create_date          DATE,
  update_by            VARCHAR2(64),
  update_date          DATE,
  remarks              VARCHAR2(255),
  del_flag             CHAR(1) default '0' not null
)
;
comment on table GEN_SCHEME
  is '���ɷ���';
comment on column GEN_SCHEME.id
  is '���';
comment on column GEN_SCHEME.name
  is '����';
comment on column GEN_SCHEME.category
  is '����';
comment on column GEN_SCHEME.package_name
  is '���ɰ�·��';
comment on column GEN_SCHEME.module_name
  is '����ģ����';
comment on column GEN_SCHEME.sub_module_name
  is '������ģ����';
comment on column GEN_SCHEME.function_name
  is '���ɹ�����';
comment on column GEN_SCHEME.function_name_simple
  is '���ɹ���������д��';
comment on column GEN_SCHEME.function_author
  is '���ɹ�������';
comment on column GEN_SCHEME.gen_table_id
  is '���ɱ���';
comment on column GEN_SCHEME.create_by
  is '������';
comment on column GEN_SCHEME.create_date
  is '����ʱ��';
comment on column GEN_SCHEME.update_by
  is '������';
comment on column GEN_SCHEME.update_date
  is '����ʱ��';
comment on column GEN_SCHEME.remarks
  is '��ע��Ϣ';
comment on column GEN_SCHEME.del_flag
  is 'ɾ����ǣ�0��������1��ɾ����';
create index GEN_SCHEME_DEL_FLAG on GEN_SCHEME (DEL_FLAG);
alter table GEN_SCHEME
  add constraint PK_GEN_SCHEME primary key (ID);


create table GEN_TABLE
(
  id              VARCHAR2(64) not null,
  name            VARCHAR2(200),
  comments        VARCHAR2(500),
  class_name      VARCHAR2(100),
  parent_table    VARCHAR2(200),
  parent_table_fk VARCHAR2(100),
  create_by       VARCHAR2(64),
  create_date     DATE,
  update_by       VARCHAR2(64),
  update_date     DATE,
  remarks         VARCHAR2(255),
  del_flag        CHAR(1) default '0' not null
)
;
comment on table GEN_TABLE
  is 'ҵ���';
comment on column GEN_TABLE.id
  is '���';
comment on column GEN_TABLE.name
  is '����';
comment on column GEN_TABLE.comments
  is '����';
comment on column GEN_TABLE.class_name
  is 'ʵ��������';
comment on column GEN_TABLE.parent_table
  is '��������';
comment on column GEN_TABLE.parent_table_fk
  is '�����������';
comment on column GEN_TABLE.create_by
  is '������';
comment on column GEN_TABLE.create_date
  is '����ʱ��';
comment on column GEN_TABLE.update_by
  is '������';
comment on column GEN_TABLE.update_date
  is '����ʱ��';
comment on column GEN_TABLE.remarks
  is '��ע��Ϣ';
comment on column GEN_TABLE.del_flag
  is 'ɾ����ǣ�0��������1��ɾ����';
create index GEN_TABLE_DEL_FLAG on GEN_TABLE (DEL_FLAG);
create index GEN_TABLE_NAME on GEN_TABLE (NAME);
alter table GEN_TABLE
  add constraint PK_GEN_TABLE primary key (ID);


create table GEN_TABLE_COLUMN
(
  id           VARCHAR2(64) not null,
  gen_table_id VARCHAR2(64),
  name         VARCHAR2(200),
  comments     VARCHAR2(500),
  jdbc_type    VARCHAR2(100),
  java_type    VARCHAR2(500),
  java_field   VARCHAR2(200),
  is_pk        CHAR(1),
  is_null      CHAR(1),
  is_insert    CHAR(1),
  is_edit      CHAR(1),
  is_list      CHAR(1),
  is_query     CHAR(1),
  query_type   VARCHAR2(200),
  show_type    VARCHAR2(200),
  dict_type    VARCHAR2(200),
  settings     VARCHAR2(2000),
  sort         NUMBER(10),
  create_by    VARCHAR2(64),
  create_date  DATE,
  update_by    VARCHAR2(64),
  update_date  DATE,
  remarks      VARCHAR2(255),
  del_flag     CHAR(1) default '0' not null
)
;
comment on table GEN_TABLE_COLUMN
  is 'ҵ����ֶ�';
comment on column GEN_TABLE_COLUMN.id
  is '���';
comment on column GEN_TABLE_COLUMN.gen_table_id
  is '��������';
comment on column GEN_TABLE_COLUMN.name
  is '����';
comment on column GEN_TABLE_COLUMN.comments
  is '����';
comment on column GEN_TABLE_COLUMN.jdbc_type
  is '�е��������͵��ֽڳ���';
comment on column GEN_TABLE_COLUMN.java_type
  is 'JAVA����';
comment on column GEN_TABLE_COLUMN.java_field
  is 'JAVA�ֶ���';
comment on column GEN_TABLE_COLUMN.is_pk
  is '�Ƿ�����';
comment on column GEN_TABLE_COLUMN.is_null
  is '�Ƿ��Ϊ��';
comment on column GEN_TABLE_COLUMN.is_insert
  is '�Ƿ�Ϊ�����ֶ�';
comment on column GEN_TABLE_COLUMN.is_edit
  is '�Ƿ�༭�ֶ�';
comment on column GEN_TABLE_COLUMN.is_list
  is '�Ƿ��б��ֶ�';
comment on column GEN_TABLE_COLUMN.is_query
  is '�Ƿ��ѯ�ֶ�';
comment on column GEN_TABLE_COLUMN.query_type
  is '��ѯ��ʽ�����ڡ������ڡ����ڡ�С�ڡ���Χ����LIKE����LIKE������LIKE��';
comment on column GEN_TABLE_COLUMN.show_type
  is '�ֶ����ɷ������ı����ı��������򡢸�ѡ�򡢵�ѡ���ֵ�ѡ����Աѡ�񡢲���ѡ������ѡ��';
comment on column GEN_TABLE_COLUMN.dict_type
  is '�ֵ�����';
comment on column GEN_TABLE_COLUMN.settings
  is '�������ã���չ�ֶ�JSON��';
comment on column GEN_TABLE_COLUMN.sort
  is '��������';
comment on column GEN_TABLE_COLUMN.create_by
  is '������';
comment on column GEN_TABLE_COLUMN.create_date
  is '����ʱ��';
comment on column GEN_TABLE_COLUMN.update_by
  is '������';
comment on column GEN_TABLE_COLUMN.update_date
  is '����ʱ��';
comment on column GEN_TABLE_COLUMN.remarks
  is '��ע��Ϣ';
comment on column GEN_TABLE_COLUMN.del_flag
  is 'ɾ����ǣ�0��������1��ɾ����';
create index GEN_TABLE_COLUMN_DEL_FLAG on GEN_TABLE_COLUMN (DEL_FLAG);
create index GEN_TABLE_COLUMN_NAME on GEN_TABLE_COLUMN (NAME);
create index GEN_TABLE_COLUMN_SORT on GEN_TABLE_COLUMN (SORT);
create index GEN_TABLE_COLUMN_TABLE_ID on GEN_TABLE_COLUMN (GEN_TABLE_ID);
alter table GEN_TABLE_COLUMN
  add constraint PK_GEN_TABLE_COLUMN primary key (ID);


create table GEN_TEMPLATE
(
  id          VARCHAR2(64) not null,
  name        VARCHAR2(200),
  category    VARCHAR2(2000),
  file_path   VARCHAR2(500),
  file_name   VARCHAR2(200),
  content     CLOB,
  create_by   VARCHAR2(64),
  create_date DATE,
  update_by   VARCHAR2(64),
  update_date DATE,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table GEN_TEMPLATE
  is '����ģ���';
comment on column GEN_TEMPLATE.id
  is '���';
comment on column GEN_TEMPLATE.name
  is '����';
comment on column GEN_TEMPLATE.category
  is '����';
comment on column GEN_TEMPLATE.file_path
  is '�����ļ�·��';
comment on column GEN_TEMPLATE.file_name
  is '�����ļ���';
comment on column GEN_TEMPLATE.content
  is '����';
comment on column GEN_TEMPLATE.create_by
  is '������';
comment on column GEN_TEMPLATE.create_date
  is '����ʱ��';
comment on column GEN_TEMPLATE.update_by
  is '������';
comment on column GEN_TEMPLATE.update_date
  is '����ʱ��';
comment on column GEN_TEMPLATE.remarks
  is '��ע��Ϣ';
comment on column GEN_TEMPLATE.del_flag
  is 'ɾ����ǣ�0��������1��ɾ����';
create index GEN_TEMPLATE_DEL_FALG on GEN_TEMPLATE (DEL_FLAG);
alter table GEN_TEMPLATE
  add constraint PK_GEN_TEMPLATE primary key (ID);


create table OA_AUDIT_MAN
(
  id        VARCHAR2(64) not null,
  audit_id  VARCHAR2(64),
  audit_man VARCHAR2(40),
  audit_job VARCHAR2(80) default '0'
)
;
comment on table OA_AUDIT_MAN
  is '���Ź��������';
comment on column OA_AUDIT_MAN.id
  is '���';
comment on column OA_AUDIT_MAN.audit_id
  is '�����ID';
comment on column OA_AUDIT_MAN.audit_man
  is '���������';
comment on column OA_AUDIT_MAN.audit_job
  is '�����ְλ';
alter table OA_AUDIT_MAN
  add constraint PK_OA_AUDIT_MAN primary key (ID);


create table OA_COLUMN_SHOW_STYLE
(
  id          VARCHAR2(64) not null,
  office_id   VARCHAR2(200),
  is_common   NUMBER,
  table_name  VARCHAR2(50),
  form_name   VARCHAR2(50),
  column_name VARCHAR2(200),
  column_type VARCHAR2(20),
  show_type   VARCHAR2(30),
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on column OA_COLUMN_SHOW_STYLE.id
  is '���';
comment on column OA_COLUMN_SHOW_STYLE.office_id
  is '��������ID';
comment on column OA_COLUMN_SHOW_STYLE.is_common
  is '�Ƿ���ͨ��';
comment on column OA_COLUMN_SHOW_STYLE.table_name
  is '����';
comment on column OA_COLUMN_SHOW_STYLE.form_name
  is '����';
comment on column OA_COLUMN_SHOW_STYLE.column_name
  is '�ֶ���';
comment on column OA_COLUMN_SHOW_STYLE.column_type
  is '�ֶ�����';
comment on column OA_COLUMN_SHOW_STYLE.show_type
  is '��ʾ��ʽ';
comment on column OA_COLUMN_SHOW_STYLE.create_by
  is '������';
comment on column OA_COLUMN_SHOW_STYLE.create_date
  is '����ʱ��';
comment on column OA_COLUMN_SHOW_STYLE.update_by
  is '������';
comment on column OA_COLUMN_SHOW_STYLE.update_date
  is '����ʱ��';
comment on column OA_COLUMN_SHOW_STYLE.remarks
  is '��ע��Ϣ';
comment on column OA_COLUMN_SHOW_STYLE.del_flag
  is 'ɾ�����';
alter table OA_COLUMN_SHOW_STYLE
  add constraint PK_OA_COLUMN_SHOW_STYLE primary key (ID);


create table OA_CONTROL_TYPE
(
  id             VARCHAR2(64) not null,
  controlname    VARCHAR2(200),
  controlcontent VARCHAR2(200),
  create_by      VARCHAR2(64) not null,
  create_date    DATE not null,
  update_by      VARCHAR2(64) not null,
  update_date    DATE not null,
  remarks        VARCHAR2(255),
  del_flag       CHAR(1) default '0' not null
)
;
comment on column OA_CONTROL_TYPE.id
  is '���';
comment on column OA_CONTROL_TYPE.controlname
  is '�ؼ�����';
comment on column OA_CONTROL_TYPE.controlcontent
  is '�ؼ�����';
comment on column OA_CONTROL_TYPE.create_by
  is '������';
comment on column OA_CONTROL_TYPE.create_date
  is '����ʱ��';
comment on column OA_CONTROL_TYPE.update_by
  is '������';
comment on column OA_CONTROL_TYPE.update_date
  is '����ʱ��';
comment on column OA_CONTROL_TYPE.remarks
  is '��ע��Ϣ';
comment on column OA_CONTROL_TYPE.del_flag
  is 'ɾ�����';
alter table OA_CONTROL_TYPE
  add constraint PK_OA_CONTROL_TYPE primary key (ID);


create table OA_FORM_MASTER
(
  id             VARCHAR2(64) not null,
  office_id      VARCHAR2(64) not null,
  title          VARCHAR2(100),
  alias          VARCHAR2(100),
  table_name     VARCHAR2(100),
  form_type      VARCHAR2(100),
  publish_status VARCHAR2(100),
  data_templete  VARCHAR2(100),
  design_type    VARCHAR2(10),
  content        VARCHAR2(2000),
  form_desc      VARCHAR2(100),
  create_by      VARCHAR2(64) not null,
  create_date    DATE not null,
  update_by      VARCHAR2(64) not null,
  update_date    DATE not null,
  remarks        VARCHAR2(255),
  del_flag       CHAR(1) default '0' not null
)
;
comment on column OA_FORM_MASTER.id
  is '���';
comment on column OA_FORM_MASTER.office_id
  is 'ҽԺ����Id';
comment on column OA_FORM_MASTER.title
  is '������';
comment on column OA_FORM_MASTER.alias
  is '������';
comment on column OA_FORM_MASTER.table_name
  is '��Ӧ��';
comment on column OA_FORM_MASTER.form_type
  is '������';
comment on column OA_FORM_MASTER.publish_status
  is '����״̬';
comment on column OA_FORM_MASTER.data_templete
  is '����ģ��';
comment on column OA_FORM_MASTER.design_type
  is '�������';
comment on column OA_FORM_MASTER.content
  is '����';
comment on column OA_FORM_MASTER.form_desc
  is '������';
comment on column OA_FORM_MASTER.create_by
  is '������';
comment on column OA_FORM_MASTER.create_date
  is '����ʱ��';
comment on column OA_FORM_MASTER.update_by
  is '������';
comment on column OA_FORM_MASTER.update_date
  is '����ʱ��';
comment on column OA_FORM_MASTER.remarks
  is '��ע��Ϣ';
comment on column OA_FORM_MASTER.del_flag
  is 'ɾ�����';
alter table OA_FORM_MASTER
  add constraint PK_OA_FORM_MASTER primary key (ID);


create table OA_LEAVE
(
  id                  VARCHAR2(64) not null,
  process_instance_id VARCHAR2(64),
  start_time          DATE,
  end_time            DATE,
  leave_type          VARCHAR2(20),
  reason              VARCHAR2(255),
  apply_time          DATE,
  reality_start_time  DATE,
  reality_end_time    DATE,
  create_by           VARCHAR2(64) not null,
  create_date         DATE not null,
  update_by           VARCHAR2(64) not null,
  update_date         DATE not null,
  remarks             VARCHAR2(255),
  del_flag            CHAR(1) default '0' not null
)
;
comment on table OA_LEAVE
  is '������̱�';
comment on column OA_LEAVE.id
  is '���';
comment on column OA_LEAVE.process_instance_id
  is '����ʵ�����';
comment on column OA_LEAVE.start_time
  is '��ʼʱ��';
comment on column OA_LEAVE.end_time
  is '����ʱ��';
comment on column OA_LEAVE.leave_type
  is '�������';
comment on column OA_LEAVE.reason
  is '�������';
comment on column OA_LEAVE.apply_time
  is '����ʱ��';
comment on column OA_LEAVE.reality_start_time
  is 'ʵ�ʿ�ʼʱ��';
comment on column OA_LEAVE.reality_end_time
  is 'ʵ�ʽ���ʱ��';
comment on column OA_LEAVE.create_by
  is '������';
comment on column OA_LEAVE.create_date
  is '����ʱ��';
comment on column OA_LEAVE.update_by
  is '������';
comment on column OA_LEAVE.update_date
  is '����ʱ��';
comment on column OA_LEAVE.remarks
  is '��ע��Ϣ';
comment on column OA_LEAVE.del_flag
  is 'ɾ�����';
create index OA_LEAVE_CREATE_BY on OA_LEAVE (CREATE_BY);
create index OA_LEAVE_DEL_FLAG on OA_LEAVE (DEL_FLAG);
create index OA_LEAVE_PROCESS_INSTANCE_ID on OA_LEAVE (PROCESS_INSTANCE_ID);
alter table OA_LEAVE
  add constraint PK_OA_LEAVE primary key (ID);


create table OA_NEWS
(
  id          VARCHAR2(64) not null,
  title       VARCHAR2(200),
  content     CLOB,
  files       VARCHAR2(2000),
  audit_flag  CHAR(1) default '0',
  audit_man   VARCHAR2(64),
  is_topic    CHAR(1),
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table OA_NEWS
  is '���Ź���';
comment on column OA_NEWS.id
  is '���';
comment on column OA_NEWS.title
  is '����';
comment on column OA_NEWS.content
  is '����';
comment on column OA_NEWS.files
  is '����';
comment on column OA_NEWS.audit_flag
  is '���״̬��0 δ��ˣ�1 ����ˣ�';
comment on column OA_NEWS.audit_man
  is '�����ID';
comment on column OA_NEWS.is_topic
  is '�Ƿ��ö���0���ö���1�ö���';
comment on column OA_NEWS.create_by
  is '������';
comment on column OA_NEWS.create_date
  is '����ʱ��';
comment on column OA_NEWS.update_by
  is '������';
comment on column OA_NEWS.update_date
  is '����ʱ��';
comment on column OA_NEWS.remarks
  is '��ע��Ϣ';
comment on column OA_NEWS.del_flag
  is 'ɾ�����';
alter table OA_NEWS
  add constraint PK_OA_NEWS primary key (ID);


create table OA_NOTIFY
(
  id          VARCHAR2(64) not null,
  type        CHAR(1),
  title       VARCHAR2(200),
  content     VARCHAR2(2000),
  files       VARCHAR2(2000),
  status      CHAR(1),
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table OA_NOTIFY
  is '֪ͨͨ��';
comment on column OA_NOTIFY.id
  is '���';
comment on column OA_NOTIFY.type
  is '����';
comment on column OA_NOTIFY.title
  is '����';
comment on column OA_NOTIFY.content
  is '����';
comment on column OA_NOTIFY.files
  is '����';
comment on column OA_NOTIFY.status
  is '״̬';
comment on column OA_NOTIFY.create_by
  is '������';
comment on column OA_NOTIFY.create_date
  is '����ʱ��';
comment on column OA_NOTIFY.update_by
  is '������';
comment on column OA_NOTIFY.update_date
  is '����ʱ��';
comment on column OA_NOTIFY.remarks
  is '��ע��Ϣ';
comment on column OA_NOTIFY.del_flag
  is 'ɾ�����';
create index OA_NOTIFY_DEL_FLAG on OA_NOTIFY (DEL_FLAG);
alter table OA_NOTIFY
  add constraint PK_OA_NOTIFY primary key (ID);


create table OA_NOTIFY_RECORD
(
  id           VARCHAR2(64) not null,
  oa_notify_id VARCHAR2(64),
  user_id      VARCHAR2(64),
  read_flag    CHAR(1) default '0',
  read_date    DATE
)
;
comment on table OA_NOTIFY_RECORD
  is '֪ͨͨ�淢�ͼ�¼';
comment on column OA_NOTIFY_RECORD.id
  is '���';
comment on column OA_NOTIFY_RECORD.oa_notify_id
  is '֪ͨͨ��ID';
comment on column OA_NOTIFY_RECORD.user_id
  is '������';
comment on column OA_NOTIFY_RECORD.read_flag
  is '�Ķ����';
comment on column OA_NOTIFY_RECORD.read_date
  is '�Ķ�ʱ��';
create index OA_NOTIFY_RECORD_NOTIFY_ID on OA_NOTIFY_RECORD (OA_NOTIFY_ID);
create index OA_NOTIFY_RECORD_READ_FLAG on OA_NOTIFY_RECORD (READ_FLAG);
create index OA_NOTIFY_RECORD_USER_ID on OA_NOTIFY_RECORD (USER_ID);
alter table OA_NOTIFY_RECORD
  add constraint PK_OA_NOTIFY_RECORD primary key (ID);


create table OA_PERSON_DEFINE_TABLE
(
  id              VARCHAR2(64) not null,
  office_id       VARCHAR2(200),
  table_name      VARCHAR2(200),
  table_comment   VARCHAR2(200),
  table_property  VARCHAR2(10),
  table_status    VARCHAR2(10),
  is_master       NUMBER,
  is_detail       NUMBER,
  create_by       VARCHAR2(64) not null,
  create_date     DATE not null,
  update_by       VARCHAR2(64) not null,
  update_date     DATE not null,
  remarks         VARCHAR2(255),
  del_flag        CHAR(1) default '0' not null,
  master_table_id VARCHAR2(64)
)
;
comment on column OA_PERSON_DEFINE_TABLE.id
  is '���';
comment on column OA_PERSON_DEFINE_TABLE.office_id
  is 'sys_office �������';
comment on column OA_PERSON_DEFINE_TABLE.table_name
  is '����';
comment on column OA_PERSON_DEFINE_TABLE.table_comment
  is 'ע��';
comment on column OA_PERSON_DEFINE_TABLE.table_property
  is '����';
comment on column OA_PERSON_DEFINE_TABLE.table_status
  is '״̬';
comment on column OA_PERSON_DEFINE_TABLE.is_master
  is '�Ƿ�����';
comment on column OA_PERSON_DEFINE_TABLE.is_detail
  is '�Ƿ�ӱ�';
comment on column OA_PERSON_DEFINE_TABLE.create_by
  is '������';
comment on column OA_PERSON_DEFINE_TABLE.create_date
  is '����ʱ��';
comment on column OA_PERSON_DEFINE_TABLE.update_by
  is '������';
comment on column OA_PERSON_DEFINE_TABLE.update_date
  is '����ʱ��';
comment on column OA_PERSON_DEFINE_TABLE.remarks
  is '��ע��Ϣ';
comment on column OA_PERSON_DEFINE_TABLE.del_flag
  is 'ɾ�����';
comment on column OA_PERSON_DEFINE_TABLE.master_table_id
  is '����Id';
alter table OA_PERSON_DEFINE_TABLE
  add constraint PK_OA_PERSON_DEFINE_TABLE primary key (ID);


create table OA_PERSON_DEFINE_TABLE_COLUMN
(
  id              VARCHAR2(64) not null,
  table_id        VARCHAR2(64),
  column_name     VARCHAR2(200),
  column_comment  VARCHAR2(200),
  column_type     VARCHAR2(80),
  table_status    VARCHAR2(11),
  is_required     NUMBER,
  is_show         NUMBER,
  is_process      NUMBER,
  create_by       VARCHAR2(64) not null,
  create_date     DATE not null,
  update_by       VARCHAR2(64) not null,
  update_date     DATE not null,
  remarks         VARCHAR2(255),
  del_flag        CHAR(1) default '0' not null,
  control_type_id VARCHAR2(64)
)
;
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.id
  is '���';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.table_id
  is 'oa_person_define_table �������';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.column_name
  is '����';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.column_comment
  is 'ע��';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.column_type
  is '�е�����';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.table_status
  is '�еĳ���';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.is_required
  is '�Ƿ����';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.is_show
  is '�Ƿ���ʾ���б�';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.is_process
  is '�Ƿ����̱���';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.create_by
  is '������';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.create_date
  is '����ʱ��';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.update_by
  is '������';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.update_date
  is '����ʱ��';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.remarks
  is '��ע��Ϣ';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.del_flag
  is 'ɾ�����';
comment on column OA_PERSON_DEFINE_TABLE_COLUMN.control_type_id
  is '�ؼ�����Id';
alter table OA_PERSON_DEFINE_TABLE_COLUMN
  add constraint PK_OA_PERSON_DEFINE_T_C primary key (ID);


create table OA_SCHEDULE
(
  id              VARCHAR2(64) not null,
  content         VARCHAR2(2000),
  important_level CHAR(1),
  emergency_level CHAR(1),
  schedule_date   DATE,
  flag            CHAR(1)
)
;
comment on table OA_SCHEDULE
  is '�ճ̱�';
comment on column OA_SCHEDULE.content
  is '��־����';
comment on column OA_SCHEDULE.important_level
  is '��Ҫ�ȼ�(0����Ҫ��1��Ҫ)';
comment on column OA_SCHEDULE.emergency_level
  is '�����̶ȣ�0��������1������';
comment on column OA_SCHEDULE.schedule_date
  is '��־����';
comment on column OA_SCHEDULE.flag
  is '���״̬��0δ��ɣ�1��ɣ�';
alter table OA_SCHEDULE
  add constraint PK_OA_SCHEDULE primary key (ID);


create table OA_SUMMARY
(
  id              VARCHAR2(64) not null,
  content         VARCHAR2(2000),
  type            CHAR(1),
  year            NUMBER,
  week            NUMBER,
  sum_date        DATE,
  evaluate        VARCHAR2(2000),
  evaluate_man    VARCHAR2(40),
  evaluate_man_id VARCHAR2(64)
)
;
comment on table OA_SUMMARY
  is '�ճ��ܽ��';
comment on column OA_SUMMARY.content
  is '�ܽ�';
comment on column OA_SUMMARY.type
  is '�ܽ����ͣ�1���ܽᣬ2 ���ܽᣩ';
comment on column OA_SUMMARY.year
  is '��ݣ�����Ϊ2ʱ��д��';
comment on column OA_SUMMARY.week
  is '����������Ϊ2ʱ��д��';
comment on column OA_SUMMARY.sum_date
  is '�ܽ����ڣ�����Ϊ1ʱ��д���ݣ�';
comment on column OA_SUMMARY.evaluate
  is '��������';
comment on column OA_SUMMARY.evaluate_man
  is '������';
comment on column OA_SUMMARY.evaluate_man_id
  is '������id';
alter table OA_SUMMARY
  add constraint PK_OA_SUMMARY primary key (ID);


create table OA_SUMMARY_DAY
(
  id              VARCHAR2(64) not null,
  content         VARCHAR2(2000),
  sum_date        DATE,
  evaluate        VARCHAR2(2000),
  evaluate_man    VARCHAR2(40),
  evaluate_man_id VARCHAR2(64)
)
;
comment on table OA_SUMMARY_DAY
  is '�չ����ܽ��';
comment on column OA_SUMMARY_DAY.content
  is '�ܽ�';
comment on column OA_SUMMARY_DAY.sum_date
  is '�ܽ�����';
comment on column OA_SUMMARY_DAY.evaluate
  is '��������';
comment on column OA_SUMMARY_DAY.evaluate_man
  is '������';
comment on column OA_SUMMARY_DAY.evaluate_man_id
  is '������id';
alter table OA_SUMMARY_DAY
  add constraint PK_OA_SUMMARY_DAY primary key (ID);


create table OA_SUMMARY_PERMISSION
(
  evaluate_id    VARCHAR2(64),
  evaluate_by_id VARCHAR2(64)
)
;
comment on table OA_SUMMARY_PERMISSION
  is '�ճ��ܽ�����Ȩ�ޱ�';
comment on column OA_SUMMARY_PERMISSION.evaluate_id
  is '�������û�id';
comment on column OA_SUMMARY_PERMISSION.evaluate_by_id
  is '������id';


create table OA_SUMMARY_WEEK
(
  id                VARCHAR2(64) not null,
  content           VARCHAR2(2000),
  year              NUMBER,
  week              NUMBER,
  next_plan_content VARCHAR2(2000),
  sum_date          DATE,
  next_plan_title   VARCHAR2(1000),
  evaluate          VARCHAR2(2000),
  evaluate_man      VARCHAR2(40),
  evaluate_man_id   VARCHAR2(64)
)
;
comment on table OA_SUMMARY_WEEK
  is '�ܹ����ܽ��';
comment on column OA_SUMMARY_WEEK.content
  is '�����ܽ�';
comment on column OA_SUMMARY_WEEK.year
  is '���';
comment on column OA_SUMMARY_WEEK.week
  is '����';
comment on column OA_SUMMARY_WEEK.next_plan_content
  is '���ܹ����ƻ�����';
comment on column OA_SUMMARY_WEEK.sum_date
  is '�ܽ�����';
comment on column OA_SUMMARY_WEEK.next_plan_title
  is '���ܹ����ƻ�';
comment on column OA_SUMMARY_WEEK.evaluate
  is '��������';
comment on column OA_SUMMARY_WEEK.evaluate_man
  is '������';
comment on column OA_SUMMARY_WEEK.evaluate_man_id
  is '������id';
alter table OA_SUMMARY_WEEK
  add constraint PK_OA_SUMMARY_WEEK primary key (ID);


create table OA_TABLE_TYPE
(
  id    NUMBER(6) not null,
  type  VARCHAR2(11),
  value VARCHAR2(20),
  flag  NUMBER
)
;
comment on column OA_TABLE_TYPE.id
  is '����';
alter table OA_TABLE_TYPE
  add constraint PK_OA_TABLE_TYPE primary key (ID);


create table OA_TEST_AUDIT
(
  id             VARCHAR2(64) not null,
  proc_ins_id    VARCHAR2(64),
  user_id        VARCHAR2(64),
  office_id      VARCHAR2(64),
  post           VARCHAR2(255),
  age            CHAR(1),
  edu            VARCHAR2(255),
  content        VARCHAR2(255),
  olda           VARCHAR2(255),
  oldb           VARCHAR2(255),
  oldc           VARCHAR2(255),
  newa           VARCHAR2(255),
  newb           VARCHAR2(255),
  newc           VARCHAR2(255),
  add_num        VARCHAR2(255),
  exe_date       VARCHAR2(255),
  hr_text        VARCHAR2(255),
  lead_text      VARCHAR2(255),
  main_lead_text VARCHAR2(255),
  create_by      VARCHAR2(64) not null,
  create_date    DATE not null,
  update_by      VARCHAR2(64) not null,
  update_date    DATE not null,
  remarks        VARCHAR2(255),
  del_flag       CHAR(1) default '0' not null
)
;
comment on table OA_TEST_AUDIT
  is '�������̲��Ա�';
comment on column OA_TEST_AUDIT.id
  is '���';
comment on column OA_TEST_AUDIT.proc_ins_id
  is '����ʵ��ID';
comment on column OA_TEST_AUDIT.user_id
  is '�䶯�û�';
comment on column OA_TEST_AUDIT.office_id
  is '��������';
comment on column OA_TEST_AUDIT.post
  is '��λ';
comment on column OA_TEST_AUDIT.age
  is '�Ա�';
comment on column OA_TEST_AUDIT.edu
  is 'ѧ��';
comment on column OA_TEST_AUDIT.content
  is '����ԭ��';
comment on column OA_TEST_AUDIT.olda
  is '���б�׼ н�굵��';
comment on column OA_TEST_AUDIT.oldb
  is '���б�׼ �¹��ʶ�';
comment on column OA_TEST_AUDIT.oldc
  is '���б�׼ ��н�ܶ�';
comment on column OA_TEST_AUDIT.newa
  is '�������׼ н�굵��';
comment on column OA_TEST_AUDIT.newb
  is '�������׼ �¹��ʶ�';
comment on column OA_TEST_AUDIT.newc
  is '�������׼ ��н�ܶ�';
comment on column OA_TEST_AUDIT.add_num
  is '������';
comment on column OA_TEST_AUDIT.exe_date
  is 'ִ��ʱ��';
comment on column OA_TEST_AUDIT.hr_text
  is '������Դ�������';
comment on column OA_TEST_AUDIT.lead_text
  is '�ֹ��쵼���';
comment on column OA_TEST_AUDIT.main_lead_text
  is '������Ҫ�쵼���';
comment on column OA_TEST_AUDIT.create_by
  is '������';
comment on column OA_TEST_AUDIT.create_date
  is '����ʱ��';
comment on column OA_TEST_AUDIT.update_by
  is '������';
comment on column OA_TEST_AUDIT.update_date
  is '����ʱ��';
comment on column OA_TEST_AUDIT.remarks
  is '��ע��Ϣ';
comment on column OA_TEST_AUDIT.del_flag
  is 'ɾ�����';
create index OA_TEST_AUDIT_DEL_FLAG on OA_TEST_AUDIT (DEL_FLAG);
alter table OA_TEST_AUDIT
  add constraint PK_OA_TEST_AUDIT primary key (ID);


create table ORG_TABLE_INFOS
(
  id             VARCHAR2(64) not null,
  office_id      VARCHAR2(200),
  table_name     VARCHAR2(200),
  table_comment  VARCHAR2(200),
  table_property VARCHAR2(10),
  table_status   VARCHAR2(10),
  create_by      VARCHAR2(64) not null,
  create_date    DATE not null,
  update_by      VARCHAR2(64) not null,
  update_date    DATE not null,
  remarks        VARCHAR2(255),
  del_flag       CHAR(1) default '0' not null
)
;
comment on column ORG_TABLE_INFOS.id
  is '���';
comment on column ORG_TABLE_INFOS.office_id
  is 'sys_office �������';
comment on column ORG_TABLE_INFOS.table_name
  is '����';
comment on column ORG_TABLE_INFOS.table_comment
  is 'ע��';
comment on column ORG_TABLE_INFOS.table_property
  is '����';
comment on column ORG_TABLE_INFOS.table_status
  is '״̬';
comment on column ORG_TABLE_INFOS.create_by
  is '������';
comment on column ORG_TABLE_INFOS.create_date
  is '����ʱ��';
comment on column ORG_TABLE_INFOS.update_by
  is '������';
comment on column ORG_TABLE_INFOS.update_date
  is '����ʱ��';
comment on column ORG_TABLE_INFOS.remarks
  is '��ע��Ϣ';
comment on column ORG_TABLE_INFOS.del_flag
  is 'ɾ�����';
alter table ORG_TABLE_INFOS
  add constraint PK_ORG_TABLE_INFOS primary key (ID);


create table SCHEMA_VERSION
(
  "version_rank"   INTEGER not null,
  "installed_rank" INTEGER not null,
  "version"        VARCHAR2(50) not null,
  "description"    VARCHAR2(200) not null,
  "type"           VARCHAR2(20) not null,
  "script"         VARCHAR2(1000) not null,
  "checksum"       INTEGER,
  "installed_by"   VARCHAR2(100) not null,
  "installed_on"   TIMESTAMP(6) default CURRENT_TIMESTAMP not null,
  "execution_time" INTEGER not null,
  "success"        NUMBER(1) not null
)


create table SYS_AREA
(
  id          VARCHAR2(64) not null,
  parent_id   VARCHAR2(64) not null,
  parent_ids  VARCHAR2(2000) not null,
  name        VARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  code        VARCHAR2(100),
  type        CHAR(1),
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table SYS_AREA
  is '�����';
comment on column SYS_AREA.id
  is '���';
comment on column SYS_AREA.parent_id
  is '�������';
comment on column SYS_AREA.parent_ids
  is '���и������';
comment on column SYS_AREA.name
  is '����';
comment on column SYS_AREA.sort
  is '����';
comment on column SYS_AREA.code
  is '�������';
comment on column SYS_AREA.type
  is '��������';
comment on column SYS_AREA.create_by
  is '������';
comment on column SYS_AREA.create_date
  is '����ʱ��';
comment on column SYS_AREA.update_by
  is '������';
comment on column SYS_AREA.update_date
  is '����ʱ��';
comment on column SYS_AREA.remarks
  is '��ע��Ϣ';
comment on column SYS_AREA.del_flag
  is 'ɾ�����';
create index SYS_AREA_DEL_FLAG on SYS_AREA (DEL_FLAG);
create index SYS_AREA_PARENT_ID on SYS_AREA (PARENT_ID);
alter table SYS_AREA
  add constraint PK_SYS_AREA primary key (ID);


create table SYS_DICT
(
  id          VARCHAR2(64) not null,
  value       VARCHAR2(100) not null,
  label       VARCHAR2(100) not null,
  type        VARCHAR2(100) not null,
  description VARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  parent_id   VARCHAR2(64) default '0',
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table SYS_DICT
  is '�ֵ��';
comment on column SYS_DICT.id
  is '���';
comment on column SYS_DICT.value
  is '����ֵ';
comment on column SYS_DICT.label
  is '��ǩ��';
comment on column SYS_DICT.type
  is '����';
comment on column SYS_DICT.description
  is '����';
comment on column SYS_DICT.sort
  is '��������';
comment on column SYS_DICT.parent_id
  is '�������';
comment on column SYS_DICT.create_by
  is '������';
comment on column SYS_DICT.create_date
  is '����ʱ��';
comment on column SYS_DICT.update_by
  is '������';
comment on column SYS_DICT.update_date
  is '����ʱ��';
comment on column SYS_DICT.remarks
  is '��ע��Ϣ';
comment on column SYS_DICT.del_flag
  is 'ɾ�����';
create index SYS_DICT_DEL_FLAG on SYS_DICT (DEL_FLAG);
create index SYS_DICT_LABEL on SYS_DICT (LABEL);
create index SYS_DICT_VALUE on SYS_DICT (VALUE);
alter table SYS_DICT
  add constraint PK_SYS_DICT primary key (ID);


create table SYS_LOG
(
  id          VARCHAR2(64) not null,
  type        CHAR(1) default '1',
  title       VARCHAR2(255),
  create_by   VARCHAR2(64),
  create_date DATE,
  remote_addr VARCHAR2(255),
  user_agent  VARCHAR2(255),
  request_uri VARCHAR2(255),
  method      VARCHAR2(5),
  params      CLOB,
  exception   CLOB
)
;
comment on table SYS_LOG
  is '��־��';
comment on column SYS_LOG.id
  is '���';
comment on column SYS_LOG.type
  is '��־����';
comment on column SYS_LOG.title
  is '��־����';
comment on column SYS_LOG.create_by
  is '������';
comment on column SYS_LOG.create_date
  is '����ʱ��';
comment on column SYS_LOG.remote_addr
  is '����IP��ַ';
comment on column SYS_LOG.user_agent
  is '�û�����';
comment on column SYS_LOG.request_uri
  is '����URI';
comment on column SYS_LOG.method
  is '������ʽ';
comment on column SYS_LOG.params
  is '�����ύ������';
comment on column SYS_LOG.exception
  is '�쳣��Ϣ';
create index SYS_LOG_CREATE_BY on SYS_LOG (CREATE_BY);
create index SYS_LOG_CREATE_DATE on SYS_LOG (CREATE_DATE);
create index SYS_LOG_REQUEST_URI on SYS_LOG (REQUEST_URI);
create index SYS_LOG_TYPE on SYS_LOG (TYPE);
alter table SYS_LOG
  add constraint PK_SYS_LOG primary key (ID);


create table SYS_MDICT
(
  id          VARCHAR2(64) not null,
  parent_id   VARCHAR2(64) not null,
  parent_ids  VARCHAR2(2000) not null,
  name        VARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  description VARCHAR2(100),
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table SYS_MDICT
  is '�༶�ֵ��';
comment on column SYS_MDICT.id
  is '���';
comment on column SYS_MDICT.parent_id
  is '�������';
comment on column SYS_MDICT.parent_ids
  is '���и������';
comment on column SYS_MDICT.name
  is '����';
comment on column SYS_MDICT.sort
  is '����';
comment on column SYS_MDICT.description
  is '����';
comment on column SYS_MDICT.create_by
  is '������';
comment on column SYS_MDICT.create_date
  is '����ʱ��';
comment on column SYS_MDICT.update_by
  is '������';
comment on column SYS_MDICT.update_date
  is '����ʱ��';
comment on column SYS_MDICT.remarks
  is '��ע��Ϣ';
comment on column SYS_MDICT.del_flag
  is 'ɾ�����';
create index SYS_MDICT_DEL_FLAG on SYS_MDICT (DEL_FLAG);
create index SYS_MDICT_PARENT_ID on SYS_MDICT (PARENT_ID);
alter table SYS_MDICT
  add constraint PK_SYS_MDICT primary key (ID);


create table SYS_MENU
(
  id          VARCHAR2(64) not null,
  parent_id   VARCHAR2(64) not null,
  parent_ids  VARCHAR2(2000) not null,
  name        VARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  href        VARCHAR2(2000),
  target      VARCHAR2(20),
  icon        VARCHAR2(100),
  is_show     CHAR(1) not null,
  permission  VARCHAR2(200),
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table SYS_MENU
  is '�˵���';
comment on column SYS_MENU.id
  is '���';
comment on column SYS_MENU.parent_id
  is '�������';
comment on column SYS_MENU.parent_ids
  is '���и������';
comment on column SYS_MENU.name
  is '����';
comment on column SYS_MENU.sort
  is '����';
comment on column SYS_MENU.href
  is '����';
comment on column SYS_MENU.target
  is 'Ŀ��';
comment on column SYS_MENU.icon
  is 'ͼ��';
comment on column SYS_MENU.is_show
  is '�Ƿ��ڲ˵�����ʾ';
comment on column SYS_MENU.permission
  is 'Ȩ�ޱ�ʶ';
comment on column SYS_MENU.create_by
  is '������';
comment on column SYS_MENU.create_date
  is '����ʱ��';
comment on column SYS_MENU.update_by
  is '������';
comment on column SYS_MENU.update_date
  is '����ʱ��';
comment on column SYS_MENU.remarks
  is '��ע��Ϣ';
comment on column SYS_MENU.del_flag
  is 'ɾ�����';
create index SYS_MENU_DEL_FLAG on SYS_MENU (DEL_FLAG);
create index SYS_MENU_PARENT_ID on SYS_MENU (PARENT_ID);
alter table SYS_MENU
  add constraint PK_SYS_MENU primary key (ID);


create table SYS_OFFICE
(
  id             VARCHAR2(64) not null,
  parent_id      VARCHAR2(64) not null,
  parent_ids     VARCHAR2(2000) not null,
  name           VARCHAR2(100) not null,
  sort           NUMBER(10) not null,
  area_id        VARCHAR2(64) not null,
  code           VARCHAR2(100),
  type           CHAR(1) not null,
  grade          CHAR(1) not null,
  address        VARCHAR2(255),
  zip_code       VARCHAR2(100),
  master         VARCHAR2(100),
  phone          VARCHAR2(200),
  fax            VARCHAR2(200),
  email          VARCHAR2(200),
  useable        VARCHAR2(64),
  primary_person VARCHAR2(64),
  deputy_person  VARCHAR2(64),
  create_by      VARCHAR2(64) not null,
  create_date    DATE not null,
  update_by      VARCHAR2(64) not null,
  update_date    DATE not null,
  remarks        VARCHAR2(255),
  del_flag       CHAR(1) default '0' not null
)
;
comment on table SYS_OFFICE
  is '������';
comment on column SYS_OFFICE.id
  is '���';
comment on column SYS_OFFICE.parent_id
  is '�������';
comment on column SYS_OFFICE.parent_ids
  is '���и������';
comment on column SYS_OFFICE.name
  is '����';
comment on column SYS_OFFICE.sort
  is '����';
comment on column SYS_OFFICE.area_id
  is '��������';
comment on column SYS_OFFICE.code
  is '�������';
comment on column SYS_OFFICE.type
  is '��������';
comment on column SYS_OFFICE.grade
  is '�����ȼ�';
comment on column SYS_OFFICE.address
  is '��ϵ��ַ';
comment on column SYS_OFFICE.zip_code
  is '��������';
comment on column SYS_OFFICE.master
  is '������';
comment on column SYS_OFFICE.phone
  is '�绰';
comment on column SYS_OFFICE.fax
  is '����';
comment on column SYS_OFFICE.email
  is '����';
comment on column SYS_OFFICE.useable
  is '�Ƿ�����';
comment on column SYS_OFFICE.primary_person
  is '��������';
comment on column SYS_OFFICE.deputy_person
  is '��������';
comment on column SYS_OFFICE.create_by
  is '������';
comment on column SYS_OFFICE.create_date
  is '����ʱ��';
comment on column SYS_OFFICE.update_by
  is '������';
comment on column SYS_OFFICE.update_date
  is '����ʱ��';
comment on column SYS_OFFICE.remarks
  is '��ע��Ϣ';
comment on column SYS_OFFICE.del_flag
  is 'ɾ�����';
create index SYS_OFFICE_DEL_FLAG on SYS_OFFICE (DEL_FLAG);
create index SYS_OFFICE_PARENT_ID on SYS_OFFICE (PARENT_ID);
create index SYS_OFFICE_TYPE on SYS_OFFICE (TYPE);
alter table SYS_OFFICE
  add constraint PK_SYS_OFFICE primary key (ID);


create table SYS_ROLE
(
  id          VARCHAR2(64) not null,
  office_id   VARCHAR2(64),
  name        VARCHAR2(100) not null,
  enname      VARCHAR2(255),
  role_type   VARCHAR2(255),
  data_scope  CHAR(1),
  is_sys      VARCHAR2(64),
  useable     VARCHAR2(64),
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table SYS_ROLE
  is '��ɫ��';
comment on column SYS_ROLE.id
  is '���';
comment on column SYS_ROLE.office_id
  is '��������';
comment on column SYS_ROLE.name
  is '��ɫ����';
comment on column SYS_ROLE.enname
  is 'Ӣ������';
comment on column SYS_ROLE.role_type
  is '��ɫ����';
comment on column SYS_ROLE.data_scope
  is '���ݷ�Χ';
comment on column SYS_ROLE.is_sys
  is '�Ƿ�ϵͳ����';
comment on column SYS_ROLE.useable
  is '�Ƿ����';
comment on column SYS_ROLE.create_by
  is '������';
comment on column SYS_ROLE.create_date
  is '����ʱ��';
comment on column SYS_ROLE.update_by
  is '������';
comment on column SYS_ROLE.update_date
  is '����ʱ��';
comment on column SYS_ROLE.remarks
  is '��ע��Ϣ';
comment on column SYS_ROLE.del_flag
  is 'ɾ�����';
create index SYS_ROLE_DEL_FLAG on SYS_ROLE (DEL_FLAG);
create index SYS_ROLE_ENNAME on SYS_ROLE (ENNAME);
alter table SYS_ROLE
  add constraint PK_SYS_ROLE primary key (ID);


create table SYS_ROLE_MENU
(
  role_id VARCHAR2(64) not null,
  menu_id VARCHAR2(64) not null
)
;
comment on table SYS_ROLE_MENU
  is '��ɫ-�˵�';
comment on column SYS_ROLE_MENU.role_id
  is '��ɫ���';
comment on column SYS_ROLE_MENU.menu_id
  is '�˵����';
alter table SYS_ROLE_MENU
  add constraint PK_SYS_ROLE_MENU primary key (ROLE_ID, MENU_ID);


create table SYS_ROLE_OFFICE
(
  role_id   VARCHAR2(64) not null,
  office_id VARCHAR2(64) not null
)
;
comment on table SYS_ROLE_OFFICE
  is '��ɫ-����';
comment on column SYS_ROLE_OFFICE.role_id
  is '��ɫ���';
comment on column SYS_ROLE_OFFICE.office_id
  is '�������';
alter table SYS_ROLE_OFFICE
  add constraint PK_SYS_ROLE_OFFICE primary key (ROLE_ID, OFFICE_ID);


create table SYS_USER
(
  id          VARCHAR2(64) not null,
  company_id  VARCHAR2(64) not null,
  office_id   VARCHAR2(64) not null,
  login_name  VARCHAR2(100) not null,
  password    VARCHAR2(100) not null,
  no          VARCHAR2(100),
  name        VARCHAR2(100) not null,
  email       VARCHAR2(200),
  phone       VARCHAR2(200),
  mobile      VARCHAR2(200),
  user_type   CHAR(1),
  photo       VARCHAR2(1000),
  login_ip    VARCHAR2(100),
  login_date  DATE,
  login_flag  VARCHAR2(64),
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table SYS_USER
  is '�û���';
comment on column SYS_USER.id
  is '���';
comment on column SYS_USER.company_id
  is '������˾';
comment on column SYS_USER.office_id
  is '��������';
comment on column SYS_USER.login_name
  is '��¼��';
comment on column SYS_USER.password
  is '����';
comment on column SYS_USER.no
  is '����';
comment on column SYS_USER.name
  is '����';
comment on column SYS_USER.email
  is '����';
comment on column SYS_USER.phone
  is '�绰';
comment on column SYS_USER.mobile
  is '�ֻ�';
comment on column SYS_USER.user_type
  is '�û�����';
comment on column SYS_USER.photo
  is '�û�ͷ��';
comment on column SYS_USER.login_ip
  is '����½IP';
comment on column SYS_USER.login_date
  is '����½ʱ��';
comment on column SYS_USER.login_flag
  is '�Ƿ�ɵ�¼';
comment on column SYS_USER.create_by
  is '������';
comment on column SYS_USER.create_date
  is '����ʱ��';
comment on column SYS_USER.update_by
  is '������';
comment on column SYS_USER.update_date
  is '����ʱ��';
comment on column SYS_USER.remarks
  is '��ע��Ϣ';
comment on column SYS_USER.del_flag
  is 'ɾ�����';
create index SYS_USER_COMPANY_ID on SYS_USER (COMPANY_ID);
create index SYS_USER_DEL_FLAG on SYS_USER (DEL_FLAG);
create index SYS_USER_LOGIN_NAME on SYS_USER (LOGIN_NAME);
create index SYS_USER_OFFICE_ID on SYS_USER (OFFICE_ID);
create index SYS_USER_UPDATE_DATE on SYS_USER (UPDATE_DATE);
alter table SYS_USER
  add constraint PK_SYS_USER primary key (ID);


create table SYS_USER_ROLE
(
  user_id VARCHAR2(64) not null,
  role_id VARCHAR2(64) not null
)
;
comment on table SYS_USER_ROLE
  is '�û�-��ɫ';
comment on column SYS_USER_ROLE.user_id
  is '�û����';
comment on column SYS_USER_ROLE.role_id
  is '��ɫ���';
alter table SYS_USER_ROLE
  add constraint PK_SYS_USER_ROLE primary key (USER_ID, ROLE_ID);


create table TEST_DATA
(
  id          VARCHAR2(64) not null,
  user_id     VARCHAR2(64),
  office_id   VARCHAR2(64),
  area_id     VARCHAR2(64),
  name        VARCHAR2(100),
  sex         CHAR(1),
  in_date     DATE,
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table TEST_DATA
  is 'ҵ�����ݱ�';
comment on column TEST_DATA.id
  is '���';
comment on column TEST_DATA.user_id
  is '�����û�';
comment on column TEST_DATA.office_id
  is '��������';
comment on column TEST_DATA.area_id
  is '��������';
comment on column TEST_DATA.name
  is '����';
comment on column TEST_DATA.sex
  is '�Ա�';
comment on column TEST_DATA.in_date
  is '��������';
comment on column TEST_DATA.create_by
  is '������';
comment on column TEST_DATA.create_date
  is '����ʱ��';
comment on column TEST_DATA.update_by
  is '������';
comment on column TEST_DATA.update_date
  is '����ʱ��';
comment on column TEST_DATA.remarks
  is '��ע��Ϣ';
comment on column TEST_DATA.del_flag
  is 'ɾ�����';
create index TEST_DATA_DEL_FLAG on TEST_DATA (DEL_FLAG);
alter table TEST_DATA
  add constraint PK_TEST_DATA primary key (ID);


create table TEST_DATA_CHILD
(
  id                VARCHAR2(64) not null,
  test_data_main_id VARCHAR2(64),
  name              VARCHAR2(100),
  create_by         VARCHAR2(64) not null,
  create_date       DATE not null,
  update_by         VARCHAR2(64) not null,
  update_date       DATE not null,
  remarks           VARCHAR2(255),
  del_flag          CHAR(1) default '0' not null
)
;
comment on table TEST_DATA_CHILD
  is 'ҵ�������ӱ�';
comment on column TEST_DATA_CHILD.id
  is '���';
comment on column TEST_DATA_CHILD.test_data_main_id
  is 'ҵ������ID';
comment on column TEST_DATA_CHILD.name
  is '����';
comment on column TEST_DATA_CHILD.create_by
  is '������';
comment on column TEST_DATA_CHILD.create_date
  is '����ʱ��';
comment on column TEST_DATA_CHILD.update_by
  is '������';
comment on column TEST_DATA_CHILD.update_date
  is '����ʱ��';
comment on column TEST_DATA_CHILD.remarks
  is '��ע��Ϣ';
comment on column TEST_DATA_CHILD.del_flag
  is 'ɾ�����';
create index TEST_DATA_CHILD_DEL_FLAG on TEST_DATA_CHILD (DEL_FLAG);
alter table TEST_DATA_CHILD
  add constraint PK_TEST_DATA_CHILD primary key (ID);


create table TEST_DATA_MAIN
(
  id          VARCHAR2(64) not null,
  user_id     VARCHAR2(64),
  office_id   VARCHAR2(64),
  area_id     VARCHAR2(64),
  name        VARCHAR2(100),
  sex         CHAR(1),
  in_date     DATE,
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table TEST_DATA_MAIN
  is 'ҵ�����ݱ�';
comment on column TEST_DATA_MAIN.id
  is '���';
comment on column TEST_DATA_MAIN.user_id
  is '�����û�';
comment on column TEST_DATA_MAIN.office_id
  is '��������';
comment on column TEST_DATA_MAIN.area_id
  is '��������';
comment on column TEST_DATA_MAIN.name
  is '����';
comment on column TEST_DATA_MAIN.sex
  is '�Ա�';
comment on column TEST_DATA_MAIN.in_date
  is '��������';
comment on column TEST_DATA_MAIN.create_by
  is '������';
comment on column TEST_DATA_MAIN.create_date
  is '����ʱ��';
comment on column TEST_DATA_MAIN.update_by
  is '������';
comment on column TEST_DATA_MAIN.update_date
  is '����ʱ��';
comment on column TEST_DATA_MAIN.remarks
  is '��ע��Ϣ';
comment on column TEST_DATA_MAIN.del_flag
  is 'ɾ�����';
create index TEST_DATA_MAIN_DEL_FLAG on TEST_DATA_MAIN (DEL_FLAG);
alter table TEST_DATA_MAIN
  add constraint PK_TEST_DATA_MAIN primary key (ID);


create table TEST_TREE
(
  id          VARCHAR2(64) not null,
  parent_id   VARCHAR2(64) not null,
  parent_ids  VARCHAR2(2000) not null,
  name        VARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  create_by   VARCHAR2(64) not null,
  create_date DATE not null,
  update_by   VARCHAR2(64) not null,
  update_date DATE not null,
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table TEST_TREE
  is '���ṹ��';
comment on column TEST_TREE.id
  is '���';
comment on column TEST_TREE.parent_id
  is '�������';
comment on column TEST_TREE.parent_ids
  is '���и������';
comment on column TEST_TREE.name
  is '����';
comment on column TEST_TREE.sort
  is '����';
comment on column TEST_TREE.create_by
  is '������';
comment on column TEST_TREE.create_date
  is '����ʱ��';
comment on column TEST_TREE.update_by
  is '������';
comment on column TEST_TREE.update_date
  is '����ʱ��';
comment on column TEST_TREE.remarks
  is '��ע��Ϣ';
comment on column TEST_TREE.del_flag
  is 'ɾ�����';
create index TEST_DATA_PARENT_ID on TEST_TREE (PARENT_ID);
create index TEST_TREE_DEL_FLAG on TEST_TREE (DEL_FLAG);
alter table TEST_TREE
  add constraint PK_TEST_TREE primary key (ID);


spool off

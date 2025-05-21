/*
 Navicat Premium Data Transfer

 Source Server         : 本地pg
 Source Server Type    : PostgreSQL
 Source Server Version : 120000
 Source Host           : localhost:5432
 Source Catalog        : hipy
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 120000
 File Encoding         : 65001

 Date: 21/07/2024 15:54:52
*/


-- ----------------------------
-- Sequence structure for t_config_settings_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_config_settings_id_seq";
CREATE SEQUENCE "public"."t_config_settings_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_dict_data_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_dict_data_id_seq";
CREATE SEQUENCE "public"."t_dict_data_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_dict_details_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_dict_details_id_seq";
CREATE SEQUENCE "public"."t_dict_details_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_hiker_developer_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_hiker_developer_id_seq";
CREATE SEQUENCE "public"."t_hiker_developer_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_hiker_rule_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_hiker_rule_id_seq";
CREATE SEQUENCE "public"."t_hiker_rule_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_hiker_rule_type_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_hiker_rule_type_id_seq";
CREATE SEQUENCE "public"."t_hiker_rule_type_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_job_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_job_id_seq";
CREATE SEQUENCE "public"."t_job_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_job_log_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_job_log_id_seq";
CREATE SEQUENCE "public"."t_job_log_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_login_infor_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_login_infor_id_seq";
CREATE SEQUENCE "public"."t_login_infor_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_menus_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_menus_id_seq";
CREATE SEQUENCE "public"."t_menus_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_perm_label_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_perm_label_id_seq";
CREATE SEQUENCE "public"."t_perm_label_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_perm_label_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_perm_label_role_id_seq";
CREATE SEQUENCE "public"."t_perm_label_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_role_menu_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_role_menu_id_seq";
CREATE SEQUENCE "public"."t_role_menu_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_roles_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_roles_id_seq";
CREATE SEQUENCE "public"."t_roles_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_user_role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_user_role_id_seq";
CREATE SEQUENCE "public"."t_user_role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_users_id_seq";
CREATE SEQUENCE "public"."t_users_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_vod_configs_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_vod_configs_id_seq";
CREATE SEQUENCE "public"."t_vod_configs_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_vod_rules_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_vod_rules_id_seq";
CREATE SEQUENCE "public"."t_vod_rules_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for t_vod_subs_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."t_vod_subs_id_seq";
CREATE SEQUENCE "public"."t_vod_subs_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for t_config_settings
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_config_settings";
CREATE TABLE "public"."t_config_settings" (
  "id" int4 NOT NULL DEFAULT nextval('t_config_settings_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "name" varchar(64) COLLATE "pg_catalog"."default" NOT NULL DEFAULT ''::character varying,
  "key" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "value" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "remark" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" int4 DEFAULT 0,
  "order_num" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."t_config_settings"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_config_settings"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_config_settings"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_config_settings"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_config_settings"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_config_settings"."name" IS '参数名称';
COMMENT ON COLUMN "public"."t_config_settings"."key" IS '参数键名';
COMMENT ON COLUMN "public"."t_config_settings"."value" IS '参数键值';
COMMENT ON COLUMN "public"."t_config_settings"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_config_settings"."status" IS '状态 0: 正常  1:停用';
COMMENT ON COLUMN "public"."t_config_settings"."order_num" IS '排序';

-- ----------------------------
-- Records of t_config_settings
-- ----------------------------
INSERT INTO "public"."t_config_settings" VALUES (1, '2022-11-13 02:47:53', 0, '2022-11-13 02:47:53', 0, 0, '用户初始角色', 'user_init_roles', 'general', '0', 0, 1);
INSERT INTO "public"."t_config_settings" VALUES (2, '2023-12-04 22:13:09', 1, '2023-12-09 12:29:32', 1, 0, '数据库升级密码', 'database_update_auth', 'hjdhnx', '默认密码hjdhnx', 0, 2);
INSERT INTO "public"."t_config_settings" VALUES (4, '2023-12-09 12:53:44', 0, '2024-01-02 22:14:43', 1, 0, '登录日志记录验证码错误', 'log_captcha_error', '0', '0/false不记录 1/true记录', 0, 4);
INSERT INTO "public"."t_config_settings" VALUES (5, '2023-12-10 16:19:44', 1, '2023-12-10 16:20:17', 1, 1, '定时任务启动状态', 'sys_job_status', '0', '0 暂停 1 运行', 0, 12);
INSERT INTO "public"."t_config_settings" VALUES (6, '2024-01-02 22:10:13', 1, '2024-01-02 22:14:30', 1, 0, '用户初始密码', 'default_password', '123456', '用户表导入的时候按这个密码创建用户记录', 0, 1);
INSERT INTO "public"."t_config_settings" VALUES (3, '2023-12-04 23:04:31', 1, '2024-01-31 15:52:15.209255', 1, 0, '登录需要验证码', 'login_with_captcha', 'no', 'yes 开启 no 关闭', 0, 3);

-- ----------------------------
-- Table structure for t_dict_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_dict_data";
CREATE TABLE "public"."t_dict_data" (
  "id" int4 NOT NULL DEFAULT nextval('t_dict_data_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "dict_type" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "dict_name" varchar(64) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "remark" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" int4 DEFAULT 0,
  "order_num" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."t_dict_data"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_dict_data"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_dict_data"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_dict_data"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_dict_data"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_dict_data"."dict_type" IS '字典类型';
COMMENT ON COLUMN "public"."t_dict_data"."dict_name" IS '字典名称';
COMMENT ON COLUMN "public"."t_dict_data"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_dict_data"."status" IS '状态 0: 正常  1:停用';
COMMENT ON COLUMN "public"."t_dict_data"."order_num" IS '排序';

-- ----------------------------
-- Records of t_dict_data
-- ----------------------------
INSERT INTO "public"."t_dict_data" VALUES (1, '2022-11-13 02:49:40', 0, '2022-11-13 02:49:40', 0, 0, 'permission_user_sex', '用户性别', '(0: 未知; 1: 男; 2: 女)', 0, 1);
INSERT INTO "public"."t_dict_data" VALUES (2, '2022-11-13 02:49:40', 0, '2022-11-13 02:49:40', 0, 0, 'com_default_status', '通用状态字典', '(0: 正常; 1: 停用)', 0, 2);
INSERT INTO "public"."t_dict_data" VALUES (3, '2022-11-13 02:49:40', 0, '2023-12-02 15:40:02', 1, 0, 'permission_user_status', '用户状态', NULL, 0, 1);
INSERT INTO "public"."t_dict_data" VALUES (4, '2023-12-04 19:53:00', 1, '2023-12-04 19:57:21', 1, 0, 'hiker_rule_data_type', '海阔视界规则数据类型', '[(''home_rule_url'', ''首页云规则''), (''publish'', ''提交云仓库''), (''js_url'', ''网页插件''),(''html'',''静态页面''),(''config'',''主页配置'')]', 0, 3);
INSERT INTO "public"."t_dict_data" VALUES (5, '2023-12-10 16:20:45', 1, '2023-12-10 16:20:45', 0, 0, 'sys_job_group', '定时任务分组', NULL, 0, 4);
INSERT INTO "public"."t_dict_data" VALUES (6, '2023-12-10 16:21:01', 1, '2023-12-10 16:21:01', 0, 0, 'sys_job_status', '定时任务运行状态', NULL, 0, 5);
INSERT INTO "public"."t_dict_data" VALUES (7, '2024-01-06 12:05:26', 1, '2024-01-06 12:05:26', 0, 0, 'sys_job_run_status', '定时任务调度状态', '1 正常 0 失败', 0, 7);
INSERT INTO "public"."t_dict_data" VALUES (9, '2024-01-15 15:48:43.862324', 1, '2024-01-15 15:48:43.862324', 0, 0, 'vod_rule_group', 'hipy源分组', 'groups = {
        ''hipy'': ''t4/spiders'',
        ''drpy_js'': ''t4/files/drpy_js'',
        ''json'': ''t4/files/json'',
        ''m3u'': ''t4/files/m3u'',
        ''txt'': ''t4/files/txt'',
    }', 0, 8);
INSERT INTO "public"."t_dict_data" VALUES (10, '2024-01-15 16:23:43.576457', 1, '2024-01-15 16:23:43.576457', 0, 0, 'vod_rule_status', '源状态', '1正常 0异常', 0, 9);
INSERT INTO "public"."t_dict_data" VALUES (11, '2024-01-25 14:00:03.613571', 1, '2024-01-25 14:00:03.613571', 0, 0, 'vod_configs_value_type', 'hipy配置值类型', 'str:字符串，int:数字', 0, 11);

-- ----------------------------
-- Table structure for t_dict_details
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_dict_details";
CREATE TABLE "public"."t_dict_details" (
  "id" int4 NOT NULL DEFAULT nextval('t_dict_details_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "dict_label" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "dict_disabled" bool NOT NULL DEFAULT false,
  "dict_value" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "remark" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_default" bool NOT NULL DEFAULT false,
  "status" int4 DEFAULT 0,
  "order_num" int4 DEFAULT 0,
  "dict_data_id" int4
)
;
COMMENT ON COLUMN "public"."t_dict_details"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_dict_details"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_dict_details"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_dict_details"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_dict_details"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_dict_details"."dict_label" IS '字典标签';
COMMENT ON COLUMN "public"."t_dict_details"."dict_disabled" IS '是否禁用';
COMMENT ON COLUMN "public"."t_dict_details"."dict_value" IS '字典键值';
COMMENT ON COLUMN "public"."t_dict_details"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_dict_details"."is_default" IS '是否默认值';
COMMENT ON COLUMN "public"."t_dict_details"."status" IS '状态 0: 正常  1:停用';
COMMENT ON COLUMN "public"."t_dict_details"."order_num" IS '排序';

-- ----------------------------
-- Records of t_dict_details
-- ----------------------------
INSERT INTO "public"."t_dict_details" VALUES (1, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '未知', 'f', '0', NULL, 't', 0, 1, 1);
INSERT INTO "public"."t_dict_details" VALUES (2, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '男', 'f', '1', NULL, 'f', 0, 2, 1);
INSERT INTO "public"."t_dict_details" VALUES (3, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '女', 'f', '2', NULL, 'f', 0, 3, 1);
INSERT INTO "public"."t_dict_details" VALUES (4, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '正常', 'f', '0', NULL, 't', 0, 0, 2);
INSERT INTO "public"."t_dict_details" VALUES (5, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '停用', 'f', '1', NULL, 'f', 0, 1, 2);
INSERT INTO "public"."t_dict_details" VALUES (6, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '正常', 'f', '0', NULL, 't', 0, 1, 3);
INSERT INTO "public"."t_dict_details" VALUES (7, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '停用', 'f', '1', NULL, 'f', 0, 2, 3);
INSERT INTO "public"."t_dict_details" VALUES (8, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '拉黑', 'f', '2', NULL, 'f', 0, 3, 3);
INSERT INTO "public"."t_dict_details" VALUES (9, '2023-12-04 19:53:35', 1, '2023-12-04 19:53:35', 0, 0, '首页云规则', 'f', 'home_rule_url', NULL, 't', 0, 1, 4);
INSERT INTO "public"."t_dict_details" VALUES (10, '2023-12-04 19:53:56', 1, '2023-12-04 19:58:52', 1, 0, '提交云仓库', 't', 'publish', NULL, 'f', 0, 2, 4);
INSERT INTO "public"."t_dict_details" VALUES (11, '2023-12-04 19:54:20', 1, '2023-12-04 19:54:20', 0, 0, '网页插件', 'f', 'js_url', NULL, 'f', 0, 3, 4);
INSERT INTO "public"."t_dict_details" VALUES (12, '2023-12-04 19:54:35', 1, '2023-12-04 19:54:35', 0, 0, '静态页面', 'f', 'html', NULL, 'f', 0, 4, 4);
INSERT INTO "public"."t_dict_details" VALUES (13, '2023-12-04 19:54:53', 1, '2023-12-04 19:54:53', 0, 0, '主页配置', 'f', 'config', NULL, 'f', 0, 5, 4);
INSERT INTO "public"."t_dict_details" VALUES (14, '2023-12-10 16:21:16', 1, '2023-12-10 16:21:29', 1, 0, '暂停', 'f', '0', NULL, 't', 0, 1, 6);
INSERT INTO "public"."t_dict_details" VALUES (15, '2023-12-10 16:21:22', 1, '2023-12-10 16:21:22', 0, 0, '启动', 'f', '1', NULL, 'f', 0, 2, 6);
INSERT INTO "public"."t_dict_details" VALUES (16, '2023-12-10 16:22:10', 1, '2023-12-10 16:22:43', 1, 0, '单次', 'f', 'setTimeout', NULL, 'f', 0, 1, 5);
INSERT INTO "public"."t_dict_details" VALUES (17, '2023-12-10 16:22:31', 1, '2023-12-10 16:22:58', 1, 0, '循环', 'f', 'setInterval', NULL, 't', 0, 2, 5);
INSERT INTO "public"."t_dict_details" VALUES (18, '2024-01-06 12:05:43', 1, '2024-01-06 12:05:43', 0, 0, '失败', 'f', '0', NULL, 'f', 0, 1, 7);
INSERT INTO "public"."t_dict_details" VALUES (19, '2024-01-06 12:05:52', 1, '2024-01-06 12:05:52', 0, 0, '正常', 'f', '1', NULL, 't', 0, 2, 7);
INSERT INTO "public"."t_dict_details" VALUES (25, '2024-01-15 15:52:54.626462', 1, '2024-01-15 15:52:54.626462', 0, 0, 'txt', 'f', 't4/files/txt', '一些静态文本文件', 'f', 0, 5, 9);
INSERT INTO "public"."t_dict_details" VALUES (26, '2024-01-15 16:23:54.150693', 1, '2024-01-15 16:23:54.150693', 0, 0, '正常', 'f', '1', NULL, 'f', 0, 1, 10);
INSERT INTO "public"."t_dict_details" VALUES (28, '2024-01-25 12:15:39.034565', 1, '2024-01-25 12:16:21.187196', 1, 0, 'drpy_libs', 'f', 't4/files/drpy_libs', 'drpy的依赖库放这个分组', 'f', 0, 3, 9);
INSERT INTO "public"."t_dict_details" VALUES (23, '2024-01-15 15:51:53.434961', 1, '2024-01-25 12:16:26.274722', 1, 0, 'json', 'f', 't4/files/json', '无关大雅的json放这个位置', 'f', 0, 4, 9);
INSERT INTO "public"."t_dict_details" VALUES (24, '2024-01-15 15:52:19.029403', 1, '2024-01-25 12:16:45.595673', 1, 0, 'm3u', 'f', 't4/files/m3u', '一些m3u直播类文件', 'f', 0, 6, 9);
INSERT INTO "public"."t_dict_details" VALUES (29, '2024-01-25 14:00:21.238762', 1, '2024-01-25 14:00:26.903135', 1, 0, '字符串', 'f', 'str', NULL, 't', 0, 1, 11);
INSERT INTO "public"."t_dict_details" VALUES (30, '2024-01-25 14:00:36.494561', 1, '2024-01-25 14:00:36.494561', 0, 0, '数字', 'f', 'int', NULL, 'f', 0, 2, 11);
INSERT INTO "public"."t_dict_details" VALUES (32, '2024-01-31 15:36:10.612562', 1, '2024-01-31 15:36:10.612562', 0, 0, '链接', 'f', 'url', NULL, 'f', 0, 4, 11);
INSERT INTO "public"."t_dict_details" VALUES (31, '2024-01-31 15:00:08.718797', 1, '2024-01-31 15:45:49.347612', 1, 0, '文件', 'f', 'file', NULL, 'f', 0, 3, 11);
INSERT INTO "public"."t_dict_details" VALUES (33, '2024-02-02 17:33:55.526379', 1, '2024-02-02 17:33:55.526379', 0, 0, '数据集', 'f', 'json', NULL, 'f', 0, 5, 11);
INSERT INTO "public"."t_dict_details" VALUES (27, '2024-01-15 16:24:01.16754', 1, '2024-02-04 17:13:14.059809', 1, 0, '禁用', 'f', '0', NULL, 'f', 0, 2, 10);
INSERT INTO "public"."t_dict_details" VALUES (35, '2024-02-04 17:14:42.75294', 1, '2024-02-05 09:55:00.551827', 1, 0, 'js_parse_api', 'f', 't4/files/js_parse_api', 'js实现的vip解析接口文件', 'f', 0, 8, 9);
INSERT INTO "public"."t_dict_details" VALUES (34, '2024-02-04 17:14:13.807944', 1, '2024-02-05 09:55:21.063489', 1, 0, 'jar', 'f', 't4/files/jar', 'drpy2及tvbox配置需要的外挂jar', 'f', 0, 7, 9);
INSERT INTO "public"."t_dict_details" VALUES (36, '2024-03-08 15:50:48.583918', 1, '2024-03-08 15:50:48.583918', 0, 0, 'drpy3_libs', 'f', 't4/files/drpy3_libs', 'drpy3的t4源需要的js依赖文件及模块,commonJS格式', 'f', 0, 9, 9);
INSERT INTO "public"."t_dict_details" VALUES (37, '2024-03-08 15:51:32.506584', 1, '2024-03-08 15:51:32.506584', 0, 0, 'drpy3_js', 'f', 't4/files/drpy3_js', 'drpy3的t4源在运行过程中自动缓存线上文件到此目录', 'f', 0, 10, 9);
INSERT INTO "public"."t_dict_details" VALUES (21, '2024-01-15 15:49:54.323147', 1, '2024-06-20 08:09:52.772483', 1, 0, 'hipy', 'f', 't4/spiders', 'hipy的py源放这个分组。可以放同名的json配置文件', 'f', 0, 1, 9);
INSERT INTO "public"."t_dict_details" VALUES (22, '2024-01-15 15:50:29.696713', 1, '2024-06-20 08:09:56.52545', 1, 0, 'drpy_js', 'f', 't4/files/drpy_js', 'drpy的js源放这个分组', 't', 0, 2, 9);

-- ----------------------------
-- Table structure for t_hiker_developer
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_hiker_developer";
CREATE TABLE "public"."t_hiker_developer" (
  "id" int4 NOT NULL DEFAULT nextval('t_hiker_developer_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "qq" varchar(11) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(256) COLLATE "pg_catalog"."default" NOT NULL DEFAULT '123456'::character varying,
  "status" int4 DEFAULT 0,
  "is_manager" bool DEFAULT false,
  "active" bool DEFAULT true,
  "test" varchar(10) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."t_hiker_developer"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_hiker_developer"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_hiker_developer"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_hiker_developer"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_hiker_developer"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_hiker_developer"."name" IS '开发者账号';
COMMENT ON COLUMN "public"."t_hiker_developer"."qq" IS 'QQ号';
COMMENT ON COLUMN "public"."t_hiker_developer"."password" IS '开发者密码';
COMMENT ON COLUMN "public"."t_hiker_developer"."status" IS '状态';
COMMENT ON COLUMN "public"."t_hiker_developer"."is_manager" IS '是否超管';
COMMENT ON COLUMN "public"."t_hiker_developer"."active" IS '是否启用';
COMMENT ON COLUMN "public"."t_hiker_developer"."test" IS '测试字段';

-- ----------------------------
-- Records of t_hiker_developer
-- ----------------------------
INSERT INTO "public"."t_hiker_developer" VALUES (1, '2023-12-02 18:00:37', 1, '2023-12-09 16:55:06', 1, 0, '道长', '434857005', '123456789', 0, 'f', 't', NULL);

-- ----------------------------
-- Table structure for t_hiker_rule
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_hiker_rule";
CREATE TABLE "public"."t_hiker_rule" (
  "id" int4 NOT NULL DEFAULT nextval('t_hiker_rule_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "name" varchar(256) COLLATE "pg_catalog"."default",
  "type_id" int4,
  "dev_id" int4,
  "value" text COLLATE "pg_catalog"."default",
  "url" varchar(256) COLLATE "pg_catalog"."default",
  "state" int4 DEFAULT 0,
  "auth" varchar(256) COLLATE "pg_catalog"."default",
  "auth_date_time" timestamp(6) DEFAULT now(),
  "time_over" bool DEFAULT false,
  "b64_value" text COLLATE "pg_catalog"."default",
  "home_url" varchar(256) COLLATE "pg_catalog"."default",
  "pic_url" varchar(256) COLLATE "pg_catalog"."default",
  "is_json" bool DEFAULT true,
  "is_redirect" bool DEFAULT false,
  "is_tap" bool DEFAULT false,
  "can_discuss" bool DEFAULT true,
  "is_json_list" bool DEFAULT false,
  "data_type" varchar(256) COLLATE "pg_catalog"."default" DEFAULT 'home_rule_url'::character varying,
  "version" varchar(256) COLLATE "pg_catalog"."default" DEFAULT '0'::character varying,
  "author" varchar(256) COLLATE "pg_catalog"."default",
  "note" text COLLATE "pg_catalog"."default",
  "good_num" int4 DEFAULT 0,
  "bad_num" int4 DEFAULT 0,
  "reply_num" int4 DEFAULT 0,
  "is_safe" bool DEFAULT true,
  "is_good" bool DEFAULT false,
  "is_white" bool DEFAULT false,
  "not_safe_note" text COLLATE "pg_catalog"."default",
  "last_active" timestamp(6) DEFAULT now()
)
;
COMMENT ON COLUMN "public"."t_hiker_rule"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_hiker_rule"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_hiker_rule"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_hiker_rule"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_hiker_rule"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_hiker_rule"."name" IS '规则名称';
COMMENT ON COLUMN "public"."t_hiker_rule"."type_id" IS '规则类型';
COMMENT ON COLUMN "public"."t_hiker_rule"."dev_id" IS '开发者';
COMMENT ON COLUMN "public"."t_hiker_rule"."value" IS '规则Json';
COMMENT ON COLUMN "public"."t_hiker_rule"."url" IS '地址';
COMMENT ON COLUMN "public"."t_hiker_rule"."state" IS '状态';
COMMENT ON COLUMN "public"."t_hiker_rule"."auth" IS '私有密码';
COMMENT ON COLUMN "public"."t_hiker_rule"."auth_date_time" IS '私有密码过期时间';
COMMENT ON COLUMN "public"."t_hiker_rule"."time_over" IS '私有规则过期';
COMMENT ON COLUMN "public"."t_hiker_rule"."b64_value" IS '64编码';
COMMENT ON COLUMN "public"."t_hiker_rule"."home_url" IS '规则主页链接';
COMMENT ON COLUMN "public"."t_hiker_rule"."pic_url" IS '网站图标链接';
COMMENT ON COLUMN "public"."t_hiker_rule"."is_json" IS '是否json值';
COMMENT ON COLUMN "public"."t_hiker_rule"."is_redirect" IS '是否为后端重定向';
COMMENT ON COLUMN "public"."t_hiker_rule"."is_tap" IS '是否为仓库跳转规则';
COMMENT ON COLUMN "public"."t_hiker_rule"."can_discuss" IS '是否可以互动';
COMMENT ON COLUMN "public"."t_hiker_rule"."is_json_list" IS '是否json列表';
COMMENT ON COLUMN "public"."t_hiker_rule"."data_type" IS '数据类型';
COMMENT ON COLUMN "public"."t_hiker_rule"."version" IS '版本号';
COMMENT ON COLUMN "public"."t_hiker_rule"."author" IS '作者';
COMMENT ON COLUMN "public"."t_hiker_rule"."note" IS '说明';
COMMENT ON COLUMN "public"."t_hiker_rule"."good_num" IS '点赞数';
COMMENT ON COLUMN "public"."t_hiker_rule"."bad_num" IS '踩数';
COMMENT ON COLUMN "public"."t_hiker_rule"."reply_num" IS '回复数';
COMMENT ON COLUMN "public"."t_hiker_rule"."is_safe" IS '是否安全';
COMMENT ON COLUMN "public"."t_hiker_rule"."is_good" IS '是否优质';
COMMENT ON COLUMN "public"."t_hiker_rule"."is_white" IS '是否白名单';
COMMENT ON COLUMN "public"."t_hiker_rule"."not_safe_note" IS '风险描述';
COMMENT ON COLUMN "public"."t_hiker_rule"."last_active" IS '开发者上次提交时间';

-- ----------------------------
-- Records of t_hiker_rule
-- ----------------------------
INSERT INTO "public"."t_hiker_rule" VALUES (1, '2023-12-04 20:00:34', 1, '2023-12-09 16:54:53', 1, 0, '道德经', 1, 1, '"{\"name\":\"道德经\"}"', 'hiker://empty#', 1, NULL, '2023-12-04 20:00:34', 'f', NULL, NULL, NULL, 't', 'f', 'f', 't', 'f', 'home_rule_url', '1', '道长', NULL, 1, 1, 1, 't', 't', 't', NULL, '2023-12-04 20:00:34');

-- ----------------------------
-- Table structure for t_hiker_rule_type
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_hiker_rule_type";
CREATE TABLE "public"."t_hiker_rule_type" (
  "id" int4 NOT NULL DEFAULT nextval('t_hiker_rule_type_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "count_num" int4 DEFAULT 0,
  "active" bool DEFAULT true
)
;
COMMENT ON COLUMN "public"."t_hiker_rule_type"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_hiker_rule_type"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_hiker_rule_type"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_hiker_rule_type"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_hiker_rule_type"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_hiker_rule_type"."name" IS '分类名称';
COMMENT ON COLUMN "public"."t_hiker_rule_type"."count_num" IS '数目';
COMMENT ON COLUMN "public"."t_hiker_rule_type"."active" IS '是否启用';

-- ----------------------------
-- Records of t_hiker_rule_type
-- ----------------------------
INSERT INTO "public"."t_hiker_rule_type" VALUES (1, '2023-12-04 19:55:50', 1, '2023-12-09 16:55:14', 1, 0, '影视', 2, 't');
INSERT INTO "public"."t_hiker_rule_type" VALUES (2, '2023-12-05 22:52:36', 1, '2023-12-09 16:55:12', 1, 0, '电影2', 3, 't');

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_job";
CREATE TABLE "public"."t_job" (
  "id" int4 NOT NULL DEFAULT nextval('t_job_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "job_id" varchar(256) COLLATE "pg_catalog"."default",
  "job_name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "job_group" varchar(256) COLLATE "pg_catalog"."default",
  "func_name" varchar(256) COLLATE "pg_catalog"."default",
  "func_args" varchar(256) COLLATE "pg_catalog"."default",
  "func_kwargs" varchar(256) COLLATE "pg_catalog"."default",
  "cron_model" varchar(256) COLLATE "pg_catalog"."default",
  "coalesce" int4 DEFAULT 0,
  "next_run" timestamp(6),
  "cron_expression" varchar(256) COLLATE "pg_catalog"."default",
  "status" int4 DEFAULT 0,
  "misfire_policy" int4 DEFAULT 0,
  "active" bool DEFAULT true
)
;
COMMENT ON COLUMN "public"."t_job"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_job"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_job"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_job"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_job"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_job"."job_id" IS '任务代号';
COMMENT ON COLUMN "public"."t_job"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."t_job"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."t_job"."func_name" IS '调用目标字符串';
COMMENT ON COLUMN "public"."t_job"."func_args" IS '传入位置参数';
COMMENT ON COLUMN "public"."t_job"."func_kwargs" IS '传入字典参数';
COMMENT ON COLUMN "public"."t_job"."cron_model" IS '执行模式';
COMMENT ON COLUMN "public"."t_job"."coalesce" IS '是否并发';
COMMENT ON COLUMN "public"."t_job"."next_run" IS '下次执行时间';
COMMENT ON COLUMN "public"."t_job"."cron_expression" IS 'cron执行表达式';
COMMENT ON COLUMN "public"."t_job"."status" IS '任务状态';
COMMENT ON COLUMN "public"."t_job"."misfire_policy" IS '执行策略';
COMMENT ON COLUMN "public"."t_job"."active" IS '是否启用';

-- ----------------------------
-- Records of t_job
-- ----------------------------
INSERT INTO "public"."t_job" VALUES (1, '2023-12-10 21:31:19', 1, '2024-02-20 15:51:14.280557', 1, 0, 'demo', '测试', 'setInterval', 'tasks.demo_task.demo', '[''hello world'']', '{''a'':''1'',''b'':''2''}', 'cron', 0, '2024-02-20 15:50:44.656558', '30 20 * * * ?', 0, 1, 'f');
INSERT INTO "public"."t_job" VALUES (15, '2023-12-13 00:53:05', 1, '2024-02-20 15:51:14.280557', 1, 0, 'kzz', '可转债打新查询', 'setInterval', 'tasks.kzz_spider.get_now_kzz', NULL, '{''dayeExtra'':8}', 'cron', 0, '2024-02-20 15:50:44.660541', '0 0 8 1/1 * ?', 0, 1, 'f');
INSERT INTO "public"."t_job" VALUES (14, '2023-12-13 00:26:59', 1, '2024-02-20 15:51:14.280557', 1, 0, 'demo2', '测试2', 'setInterval', 'tasks.demo_task.demo', '[''哈哈哈哈哈'']', '{''key'':''你好吗''}', 'cron', 0, '2024-02-20 15:50:44.660541', '30 10 * * * ?', 0, 1, 'f');
INSERT INTO "public"."t_job" VALUES (16, '2024-02-20 16:23:34.633837', 1, '2024-07-21 07:50:00.717784', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', 'cron', 0, '2024-07-21 15:50:10.71854', '0 0 0/4 * * ?', 1, 1, 't');

-- ----------------------------
-- Table structure for t_job_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_job_log";
CREATE TABLE "public"."t_job_log" (
  "id" int4 NOT NULL DEFAULT nextval('t_job_log_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "job_id" varchar(256) COLLATE "pg_catalog"."default",
  "job_name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "job_group" varchar(256) COLLATE "pg_catalog"."default",
  "func_name" varchar(256) COLLATE "pg_catalog"."default",
  "func_args" varchar(256) COLLATE "pg_catalog"."default",
  "func_kwargs" varchar(256) COLLATE "pg_catalog"."default",
  "run_info" text COLLATE "pg_catalog"."default",
  "run_except_info" text COLLATE "pg_catalog"."default",
  "run_status" int4 DEFAULT 0,
  "run_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."t_job_log"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_job_log"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_job_log"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_job_log"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_job_log"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_job_log"."job_id" IS '任务代号';
COMMENT ON COLUMN "public"."t_job_log"."job_name" IS '任务名称';
COMMENT ON COLUMN "public"."t_job_log"."job_group" IS '任务组名';
COMMENT ON COLUMN "public"."t_job_log"."func_name" IS '调用目标字符串';
COMMENT ON COLUMN "public"."t_job_log"."func_args" IS '传入位置参数';
COMMENT ON COLUMN "public"."t_job_log"."func_kwargs" IS '传入字典参数';
COMMENT ON COLUMN "public"."t_job_log"."run_info" IS '正常日志信息';
COMMENT ON COLUMN "public"."t_job_log"."run_except_info" IS '异常日志信息';
COMMENT ON COLUMN "public"."t_job_log"."run_status" IS '执行状态';
COMMENT ON COLUMN "public"."t_job_log"."run_time" IS '执行时间';

-- ----------------------------
-- Records of t_job_log
-- ----------------------------
INSERT INTO "public"."t_job_log" VALUES (308, '2024-02-20 16:24:53.310246', 0, '2024-02-20 16:24:53.310246', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:9618,未能获取weishi.txt等文件内容', NULL, 1, '2024-02-20 16:24:46.222442');
INSERT INTO "public"."t_job_log" VALUES (309, '2024-02-21 16:00:05.704055', 0, '2024-02-21 16:00:05.704055', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:10140,未能获取qita.txt,weishi.txt等文件内容。本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-21 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (310, '2024-02-26 16:00:08.075412', 0, '2024-02-26 16:00:08.075412', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:10914本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-26 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (311, '2024-02-28 16:00:07.589344', 0, '2024-02-28 16:00:07.589344', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:11081本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-28 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (312, '2024-02-29 12:00:08.8915', 0, '2024-02-29 12:00:08.8915', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:9511本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-29 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (313, '2024-02-29 16:00:05.471054', 0, '2024-02-29 16:00:05.471054', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:9511本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-29 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (314, '2024-03-08 12:00:10.298743', 0, '2024-03-08 12:00:10.298743', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File "D:\mypython\hipy-server\lib\site-packages\apscheduler\executors\base.py", line 125, in run_job
    retval = job.func(*job.args, **job.kwargs)
  File "E:\pywork\hipy\hipy-server\app\tasks\tv_spider.py", line 18, in main
    files = getGitContents(''ssili126/tv'', '''', '''')
  File "E:\pywork\hipy\hipy-server\app\utils\httpapi.py", line 98, in getGitContents
    r = request.request()
  File "E:\pywork\hipy\hipy-server\app\network\request.py", line 125, in request
    response = httpx.Client(proxies=proxies).request(method=self.method, url=self.url, **self.requests_kwargs)
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 821, in request
    return self.send(request, auth=auth, follow_redirects=follow_redirects)
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 922, in send
    raise exc
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 916, in send
    response.read()
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_models.py", line 805, in read
    self._content = b"".join(self.iter_bytes())
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_models.py", line 823, in iter_bytes
    for raw_bytes in self.iter_raw():
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_models.py", line 881, in iter_raw
    for raw_stream_bytes in self.stream:
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 124, in __iter__
    for chunk in self._stream:
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_transports\default.py", line 105, in __iter__
    yield part
  File "D:\Program Files\Python38\lib\contextlib.py", line 131, in __exit__
    self.gen.throw(type, value, traceback)
  File "D:\mypython\hipy-server\lib\site-packages\httpx\_transports\default.py", line 77, in map_httpcore_exceptions
    raise mapped_exc(message) from exc
', 'The read operation timed out', 0, '2024-03-08 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (315, '2024-03-10 12:00:06.000038', 0, '2024-03-10 12:00:06.000038', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:7824本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-03-10 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (316, '2024-03-17 08:00:08.432901', 0, '2024-03-17 08:00:08.432901', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File "F:\python\mypython\hipy-server\lib\site-packages\apscheduler\executors\base.py", line 125, in run_job
    retval = job.func(*job.args, **job.kwargs)
  File "F:\pywork\hipy\hipy-server\app\tasks\tv_spider.py", line 18, in main
    files = getGitContents(''ssili126/tv'', '''', '''')
  File "F:\pywork\hipy\hipy-server\app\utils\httpapi.py", line 98, in getGitContents
    r = request.request()
  File "F:\pywork\hipy\hipy-server\app\network\request.py", line 125, in request
    response = httpx.Client(proxies=proxies).request(method=self.method, url=self.url, **self.requests_kwargs)
  File "F:\python\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 821, in request
    return self.send(request, auth=auth, follow_redirects=follow_redirects)
  File "F:\python\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 908, in send
    response = self._send_handling_auth(
  File "F:\python\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 936, in _send_handling_auth
    response = self._send_handling_redirects(
  File "F:\python\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 973, in _send_handling_redirects
    response = self._send_single_request(request)
  File "F:\python\mypython\hipy-server\lib\site-packages\httpx\_client.py", line 1009, in _send_single_request
    response = transport.handle_request(request)
  File "F:\python\mypython\hipy-server\lib\site-packages\httpx\_transports\default.py", line 218, in handle_request
    resp = self._pool.handle_request(req)
  File "D:\soft\python\388\lib\contextlib.py", line 131, in __exit__
    self.gen.throw(type, value, traceback)
  File "F:\python\mypython\hipy-server\lib\site-packages\httpx\_transports\default.py", line 77, in map_httpcore_exceptions
    raise mapped_exc(message) from exc
', '_ssl.c:1108: The handshake operation timed out', 0, '2024-03-17 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (317, '2024-03-29 08:59:37.834232', 0, '2024-03-29 08:59:37.834232', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{
    "code":400,
    "msg":"传入的url不合法",
    "data":{}
}', NULL, 1, '2024-03-29 08:59:37.79044');
INSERT INTO "public"."t_job_log" VALUES (318, '2024-03-29 09:01:56.727282', 0, '2024-03-29 09:01:56.727282', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{
    "code":400,
    "msg":"传入的url不合法",
    "data":{}
}', NULL, 1, '2024-03-29 09:01:56.683371');
INSERT INTO "public"."t_job_log" VALUES (319, '2024-03-29 09:03:08.310698', 0, '2024-03-29 09:03:08.310698', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{
    "code":400,
    "msg":"传入的url不合法",
    "data":{}
}', NULL, 1, '2024-03-29 09:03:08.274155');
INSERT INTO "public"."t_job_log" VALUES (320, '2024-03-29 09:29:25.627431', 0, '2024-03-29 09:29:25.627431', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{
    "code":400,
    "msg":"传入的url不合法",
    "data":{}
}', NULL, 1, '2024-03-29 09:29:25.583786');
INSERT INTO "public"."t_job_log" VALUES (321, '2024-03-29 10:55:03.606898', 0, '2024-03-29 10:55:03.606898', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{
    "code":400,
    "msg":"传入的url不合法",
    "data":{}
}', NULL, 1, '2024-03-29 10:55:03.551282');
INSERT INTO "public"."t_job_log" VALUES (322, '2024-05-06 13:26:28.374056', 0, '2024-05-06 13:26:28.374056', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://127.0.0.1:5708"', NULL, 1, '2024-05-06 13:26:28.296143');
INSERT INTO "public"."t_job_log" VALUES (323, '2024-05-06 13:32:42.462805', 0, '2024-05-06 13:32:42.462805', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://127.0.0.1:5708"', NULL, 1, '2024-05-06 13:32:42.39067');
INSERT INTO "public"."t_job_log" VALUES (324, '2024-05-06 13:32:50.053644', 0, '2024-05-06 13:32:50.053644', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 13:32:47');
INSERT INTO "public"."t_job_log" VALUES (325, '2024-05-06 13:34:56.654494', 0, '2024-05-06 13:34:56.654494', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708/"', NULL, 1, '2024-05-06 13:34:56.570117');
INSERT INTO "public"."t_job_log" VALUES (326, '2024-05-06 13:35:04.121002', 0, '2024-05-06 13:35:04.121002', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 13:35:01');
INSERT INTO "public"."t_job_log" VALUES (327, '2024-05-06 13:42:57.316362', 0, '2024-05-06 13:42:57.316362', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708/"', NULL, 1, '2024-05-06 13:42:57.233312');
INSERT INTO "public"."t_job_log" VALUES (328, '2024-05-06 13:43:03.936883', 0, '2024-05-06 13:43:03.936883', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 13:43:02');
INSERT INTO "public"."t_job_log" VALUES (329, '2024-05-06 13:45:07.538741', 0, '2024-05-06 13:45:07.538741', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708/"', NULL, 1, '2024-05-06 13:45:07.45087');
INSERT INTO "public"."t_job_log" VALUES (330, '2024-05-06 13:45:14.198573', 0, '2024-05-06 13:45:14.198573', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 13:45:12');
INSERT INTO "public"."t_job_log" VALUES (331, '2024-05-06 14:25:42.932023', 0, '2024-05-06 14:25:42.932023', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://127.0.0.1:5708"', NULL, 1, '2024-05-06 14:25:42.769016');
INSERT INTO "public"."t_job_log" VALUES (332, '2024-05-06 14:25:48.659379', 0, '2024-05-06 14:25:48.659379', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 14:25:47');
INSERT INTO "public"."t_job_log" VALUES (333, '2024-05-06 14:35:32.035178', 0, '2024-05-06 14:35:32.035178', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708/"', NULL, 1, '2024-05-06 14:35:31.960657');
INSERT INTO "public"."t_job_log" VALUES (334, '2024-05-06 14:35:38.76513', 0, '2024-05-06 14:35:38.76513', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 14:35:37');
INSERT INTO "public"."t_job_log" VALUES (335, '2024-05-06 14:48:54.927806', 0, '2024-05-06 14:48:54.927806', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-06 14:48:54.848486');
INSERT INTO "public"."t_job_log" VALUES (336, '2024-05-06 14:49:00.809416', 0, '2024-05-06 14:49:00.809416', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 14:48:59');
INSERT INTO "public"."t_job_log" VALUES (337, '2024-05-06 16:00:02.105659', 0, '2024-05-06 16:00:02.105659', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (338, '2024-05-06 16:45:32.368373', 0, '2024-05-06 16:45:32.368373', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-06 16:45:32.301323');
INSERT INTO "public"."t_job_log" VALUES (339, '2024-05-06 16:45:39.037157', 0, '2024-05-06 16:45:39.037157', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 16:45:37');
INSERT INTO "public"."t_job_log" VALUES (340, '2024-05-06 20:00:01.664623', 0, '2024-05-06 20:00:01.664623', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (341, '2024-05-07 00:00:01.668688', 0, '2024-05-07 00:00:01.668688', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (342, '2024-05-07 03:03:45.435623', 0, '2024-05-07 03:03:45.435623', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-07 03:03:45.360502');
INSERT INTO "public"."t_job_log" VALUES (343, '2024-05-07 03:03:51.813343', 0, '2024-05-07 03:03:51.813343', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 03:03:50');
INSERT INTO "public"."t_job_log" VALUES (344, '2024-05-07 04:00:01.682933', 0, '2024-05-07 04:00:01.682933', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (345, '2024-05-07 08:00:01.847156', 0, '2024-05-07 08:00:01.847156', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (346, '2024-05-07 12:00:01.687399', 0, '2024-05-07 12:00:01.687399', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (347, '2024-05-07 16:00:01.634141', 0, '2024-05-07 16:00:01.634141', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (348, '2024-05-07 20:00:01.698406', 0, '2024-05-07 20:00:01.698406', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (349, '2024-05-08 00:00:01.556439', 0, '2024-05-08 00:00:01.556439', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (350, '2024-05-08 02:12:54.129149', 0, '2024-05-08 02:12:54.129149', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-08 02:12:54.01527');
INSERT INTO "public"."t_job_log" VALUES (351, '2024-05-08 02:13:00.655662', 0, '2024-05-08 02:13:00.655662', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 02:12:59');
INSERT INTO "public"."t_job_log" VALUES (352, '2024-05-08 04:00:01.609685', 0, '2024-05-08 04:00:01.609685', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (353, '2024-05-08 08:00:01.811153', 0, '2024-05-08 08:00:01.811153', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (358, '2024-05-09 04:00:01.823247', 0, '2024-05-09 04:00:01.823247', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (354, '2024-05-08 12:00:02.074475', 0, '2024-05-08 12:00:02.074475', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (355, '2024-05-08 16:00:01.970293', 0, '2024-05-08 16:00:01.970293', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (356, '2024-05-08 20:00:01.754998', 0, '2024-05-08 20:00:01.754998', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (357, '2024-05-09 00:00:01.6003', 0, '2024-05-09 00:00:01.6003', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (359, '2024-05-09 08:00:01.62064', 0, '2024-05-09 08:00:01.62064', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (360, '2024-05-09 12:00:01.670491', 0, '2024-05-09 12:00:01.670491', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (361, '2024-05-09 16:00:01.656248', 0, '2024-05-09 16:00:01.656248', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (362, '2024-05-09 20:00:01.660362', 0, '2024-05-09 20:00:01.660362', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (363, '2024-05-10 00:00:01.568299', 0, '2024-05-10 00:00:01.568299', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (364, '2024-05-10 04:00:01.652516', 0, '2024-05-10 04:00:01.652516', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (365, '2024-05-10 08:00:01.725595', 0, '2024-05-10 08:00:01.725595', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (366, '2024-05-10 08:47:04.306063', 0, '2024-05-10 08:47:04.306063', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-10 08:47:04.223001');
INSERT INTO "public"."t_job_log" VALUES (367, '2024-05-10 08:47:10.622079', 0, '2024-05-10 08:47:10.622079', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 08:47:09');
INSERT INTO "public"."t_job_log" VALUES (368, '2024-05-10 09:17:07.703257', 0, '2024-05-10 09:17:07.703257', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-10 09:17:07.632159');
INSERT INTO "public"."t_job_log" VALUES (369, '2024-05-10 09:17:13.723467', 0, '2024-05-10 09:17:13.723467', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 09:17:12');
INSERT INTO "public"."t_job_log" VALUES (370, '2024-05-10 12:00:01.609088', 0, '2024-05-10 12:00:01.609088', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (371, '2024-05-10 16:00:03.26278', 0, '2024-05-10 16:00:03.26278', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (372, '2024-05-10 18:00:56.435835', 0, '2024-05-10 18:00:56.435835', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-10 18:00:56.37345');
INSERT INTO "public"."t_job_log" VALUES (373, '2024-05-10 18:01:02.774328', 0, '2024-05-10 18:01:02.774328', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 18:01:01');
INSERT INTO "public"."t_job_log" VALUES (374, '2024-05-10 20:00:02.048594', 0, '2024-05-10 20:00:02.048594', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (375, '2024-05-11 00:00:01.671922', 0, '2024-05-11 00:00:01.671922', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (376, '2024-05-11 03:15:12.999003', 0, '2024-05-11 03:15:12.999003', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-11 03:15:12.914119');
INSERT INTO "public"."t_job_log" VALUES (377, '2024-05-11 03:15:18.751841', 0, '2024-05-11 03:15:18.751841', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 03:15:17');
INSERT INTO "public"."t_job_log" VALUES (378, '2024-05-11 04:00:01.69103', 0, '2024-05-11 04:00:01.69103', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (380, '2024-05-11 12:00:01.787832', 0, '2024-05-11 12:00:01.787832', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (379, '2024-05-11 08:00:00.443787', 0, '2024-05-11 08:00:00.443787', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File "/usr/local/lib/python3.8/site-packages/apscheduler/executors/base.py", line 125, in run_job
    retval = job.func(*job.args, **job.kwargs)
  File "/hipy/tasks/tv_spider.py", line 19, in main
    txt_files = [file for file in files if str(file[''name'']).endswith(''.txt'') and file[''type''] == ''file'']
  File "/hipy/tasks/tv_spider.py", line 19, in <listcomp>
    txt_files = [file for file in files if str(file[''name'']).endswith(''.txt'') and file[''type''] == ''file'']
', 'string indices must be integers', 0, '2024-05-11 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (381, '2024-05-11 14:21:53.402448', 0, '2024-05-11 14:21:53.402448', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-11 14:21:53.309827');
INSERT INTO "public"."t_job_log" VALUES (382, '2024-05-11 14:22:00.440313', 0, '2024-05-11 14:22:00.440313', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 14:21:58');
INSERT INTO "public"."t_job_log" VALUES (383, '2024-05-11 15:34:09.606707', 0, '2024-05-11 15:34:09.606707', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-11 15:34:09.538705');
INSERT INTO "public"."t_job_log" VALUES (384, '2024-05-11 15:34:16.718493', 0, '2024-05-11 15:34:16.718493', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 15:34:14');
INSERT INTO "public"."t_job_log" VALUES (385, '2024-05-11 16:00:01.876392', 0, '2024-05-11 16:00:01.876392', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (386, '2024-05-11 16:25:40.608262', 0, '2024-05-11 16:25:40.608262', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-11 16:25:40.543429');
INSERT INTO "public"."t_job_log" VALUES (387, '2024-05-11 16:25:46.825315', 0, '2024-05-11 16:25:46.825315', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 16:25:45');
INSERT INTO "public"."t_job_log" VALUES (388, '2024-05-11 18:09:54.192086', 0, '2024-05-11 18:09:54.192086', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-11 18:09:54.12142');
INSERT INTO "public"."t_job_log" VALUES (389, '2024-05-11 18:10:00.812894', 0, '2024-05-11 18:10:00.812894', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 18:09:59');
INSERT INTO "public"."t_job_log" VALUES (390, '2024-05-11 19:39:06.286648', 0, '2024-05-11 19:39:06.286648', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-11 19:39:06.2231');
INSERT INTO "public"."t_job_log" VALUES (391, '2024-05-11 19:39:12.684395', 0, '2024-05-11 19:39:12.684395', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 19:39:11');
INSERT INTO "public"."t_job_log" VALUES (392, '2024-05-11 20:00:01.575491', 0, '2024-05-11 20:00:01.575491', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (393, '2024-05-12 00:00:01.57603', 0, '2024-05-12 00:00:01.57603', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (394, '2024-05-12 04:00:01.715369', 0, '2024-05-12 04:00:01.715369', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (395, '2024-05-12 07:37:06.503316', 0, '2024-05-12 07:37:06.503316', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-12 07:37:06.439674');
INSERT INTO "public"."t_job_log" VALUES (396, '2024-05-12 07:37:14.331773', 0, '2024-05-12 07:37:14.331773', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 07:37:11');
INSERT INTO "public"."t_job_log" VALUES (397, '2024-05-12 08:00:01.895947', 0, '2024-05-12 08:00:01.895947', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (398, '2024-05-12 12:00:01.658922', 0, '2024-05-12 12:00:01.658922', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (399, '2024-05-12 16:00:01.802569', 0, '2024-05-12 16:00:01.802569', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (400, '2024-05-12 16:21:32.703111', 0, '2024-05-12 16:21:32.703111', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-12 16:21:32.617151');
INSERT INTO "public"."t_job_log" VALUES (401, '2024-05-12 16:21:38.87448', 0, '2024-05-12 16:21:38.87448', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 16:21:37');
INSERT INTO "public"."t_job_log" VALUES (402, '2024-05-12 16:30:45.963468', 0, '2024-05-12 16:30:45.963468', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-12 16:30:45.184923');
INSERT INTO "public"."t_job_log" VALUES (403, '2024-05-12 16:30:51.711962', 0, '2024-05-12 16:30:51.711962', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 16:30:50');
INSERT INTO "public"."t_job_log" VALUES (404, '2024-05-12 19:13:02.625282', 0, '2024-05-12 19:13:02.625282', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-12 19:13:02.561716');
INSERT INTO "public"."t_job_log" VALUES (405, '2024-05-12 19:13:09.062173', 0, '2024-05-12 19:13:09.062173', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 19:13:07');
INSERT INTO "public"."t_job_log" VALUES (406, '2024-05-12 20:00:01.656515', 0, '2024-05-12 20:00:01.656515', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (407, '2024-05-13 00:00:01.595565', 0, '2024-05-13 00:00:01.595565', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (408, '2024-05-13 04:00:01.653885', 0, '2024-05-13 04:00:01.653885', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (409, '2024-05-13 07:09:09.530475', 0, '2024-05-13 07:09:09.530475', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-13 07:09:09.451185');
INSERT INTO "public"."t_job_log" VALUES (410, '2024-05-13 07:09:15.590654', 0, '2024-05-13 07:09:15.590654', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 07:09:14');
INSERT INTO "public"."t_job_log" VALUES (411, '2024-05-13 08:00:01.606686', 0, '2024-05-13 08:00:01.606686', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (412, '2024-05-13 10:19:53.956664', 0, '2024-05-13 10:19:53.956664', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-13 10:19:53.884291');
INSERT INTO "public"."t_job_log" VALUES (413, '2024-05-13 10:19:59.692114', 0, '2024-05-13 10:19:59.692114', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 10:19:58');
INSERT INTO "public"."t_job_log" VALUES (414, '2024-05-13 12:00:01.714388', 0, '2024-05-13 12:00:01.714388', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (415, '2024-05-13 13:20:00.55617', 0, '2024-05-13 13:20:00.55617', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-13 13:20:00.438501');
INSERT INTO "public"."t_job_log" VALUES (416, '2024-05-13 13:20:12.697197', 0, '2024-05-13 13:20:12.697197', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 13:20:05');
INSERT INTO "public"."t_job_log" VALUES (417, '2024-05-13 16:00:01.765826', 0, '2024-05-13 16:00:01.765826', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (418, '2024-05-13 19:50:57.666965', 0, '2024-05-13 19:50:57.666965', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-13 19:50:57.601483');
INSERT INTO "public"."t_job_log" VALUES (419, '2024-05-13 19:51:03.771159', 0, '2024-05-13 19:51:03.771159', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 19:51:02');
INSERT INTO "public"."t_job_log" VALUES (420, '2024-05-13 20:00:01.831633', 0, '2024-05-13 20:00:01.831633', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (421, '2024-05-14 00:00:01.575726', 0, '2024-05-14 00:00:01.575726', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (422, '2024-05-14 04:00:01.801432', 0, '2024-05-14 04:00:01.801432', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (423, '2024-05-14 08:00:01.661515', 0, '2024-05-14 08:00:01.661515', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (424, '2024-05-14 09:26:30.967739', 0, '2024-05-14 09:26:30.967739', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-14 09:26:30.865691');
INSERT INTO "public"."t_job_log" VALUES (425, '2024-05-14 09:26:36.826002', 0, '2024-05-14 09:26:36.826002', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 09:26:35');
INSERT INTO "public"."t_job_log" VALUES (426, '2024-05-14 12:00:01.759551', 0, '2024-05-14 12:00:01.759551', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (427, '2024-05-14 16:00:02.029391', 0, '2024-05-14 16:00:02.029391', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (428, '2024-05-14 17:56:58.416039', 0, '2024-05-14 17:56:58.416039', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-14 17:56:58.336779');
INSERT INTO "public"."t_job_log" VALUES (429, '2024-05-14 17:57:04.699667', 0, '2024-05-14 17:57:04.699667', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 17:57:03');
INSERT INTO "public"."t_job_log" VALUES (430, '2024-05-14 20:00:01.70585', 0, '2024-05-14 20:00:01.70585', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (431, '2024-05-15 00:00:01.530574', 0, '2024-05-15 00:00:01.530574', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (432, '2024-05-15 02:43:59.545981', 0, '2024-05-15 02:43:59.545981', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-15 02:43:59.471903');
INSERT INTO "public"."t_job_log" VALUES (433, '2024-05-15 02:44:05.607747', 0, '2024-05-15 02:44:05.607747', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 02:44:04');
INSERT INTO "public"."t_job_log" VALUES (434, '2024-05-15 04:00:01.561445', 0, '2024-05-15 04:00:01.561445', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (435, '2024-05-15 08:00:01.692542', 0, '2024-05-15 08:00:01.692542', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (436, '2024-05-15 12:00:01.912001', 0, '2024-05-15 12:00:01.912001', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (437, '2024-05-15 14:55:32.259335', 0, '2024-05-15 14:55:32.259335', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-15 14:55:32.168302');
INSERT INTO "public"."t_job_log" VALUES (438, '2024-05-15 14:55:40.030923', 0, '2024-05-15 14:55:40.030923', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 14:55:37');
INSERT INTO "public"."t_job_log" VALUES (439, '2024-05-15 16:00:02.062367', 0, '2024-05-15 16:00:02.062367', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (440, '2024-05-15 20:00:01.691313', 0, '2024-05-15 20:00:01.691313', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (441, '2024-05-16 00:00:01.608858', 0, '2024-05-16 00:00:01.608858', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (442, '2024-05-16 04:00:01.574902', 0, '2024-05-16 04:00:01.574902', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (443, '2024-05-16 08:00:02.054159', 0, '2024-05-16 08:00:02.054159', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (444, '2024-05-16 08:22:06.160057', 0, '2024-05-16 08:22:06.160057', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-16 08:22:06.080996');
INSERT INTO "public"."t_job_log" VALUES (445, '2024-05-16 08:22:12.780026', 0, '2024-05-16 08:22:12.780026', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 08:22:11');
INSERT INTO "public"."t_job_log" VALUES (446, '2024-05-16 10:22:13.313407', 0, '2024-05-16 10:22:13.313407', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-16 10:22:13.247919');
INSERT INTO "public"."t_job_log" VALUES (447, '2024-05-16 10:22:19.68504', 0, '2024-05-16 10:22:19.68504', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 10:22:18');
INSERT INTO "public"."t_job_log" VALUES (448, '2024-05-16 12:00:01.65924', 0, '2024-05-16 12:00:01.65924', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (449, '2024-05-16 16:00:01.982968', 0, '2024-05-16 16:00:01.982968', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (450, '2024-05-16 17:25:34.665101', 0, '2024-05-16 17:25:34.665101', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-16 17:25:34.57805');
INSERT INTO "public"."t_job_log" VALUES (451, '2024-05-16 17:25:40.741596', 0, '2024-05-16 17:25:40.741596', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 17:25:39');
INSERT INTO "public"."t_job_log" VALUES (452, '2024-05-16 18:01:01.083996', 0, '2024-05-16 18:01:01.083996', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-16 18:01:01.00814');
INSERT INTO "public"."t_job_log" VALUES (453, '2024-05-16 18:01:07.757886', 0, '2024-05-16 18:01:07.757886', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 18:01:06');
INSERT INTO "public"."t_job_log" VALUES (454, '2024-05-16 18:02:21.103391', 0, '2024-05-16 18:02:21.103391', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-16 18:02:21.011778');
INSERT INTO "public"."t_job_log" VALUES (455, '2024-05-16 18:02:27.467665', 0, '2024-05-16 18:02:27.467665', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 18:02:26');
INSERT INTO "public"."t_job_log" VALUES (456, '2024-05-16 20:00:01.66235', 0, '2024-05-16 20:00:01.66235', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (457, '2024-05-16 20:05:22.935271', 0, '2024-05-16 20:05:22.935271', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-16 20:05:22.849783');
INSERT INTO "public"."t_job_log" VALUES (458, '2024-05-16 20:05:28.745197', 0, '2024-05-16 20:05:28.745197', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 20:05:27');
INSERT INTO "public"."t_job_log" VALUES (459, '2024-05-17 00:00:01.621298', 0, '2024-05-17 00:00:01.621298', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (460, '2024-05-17 03:38:30.846831', 0, '2024-05-17 03:38:30.846831', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-17 03:38:30.752328');
INSERT INTO "public"."t_job_log" VALUES (461, '2024-05-17 04:00:01.660175', 0, '2024-05-17 04:00:01.660175', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (462, '2024-05-17 08:00:01.759035', 0, '2024-05-17 08:00:01.759035', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (463, '2024-05-17 08:01:50.321367', 0, '2024-05-17 08:01:50.321367', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-17 08:01:50.204086');
INSERT INTO "public"."t_job_log" VALUES (464, '2024-05-17 08:01:56.718516', 0, '2024-05-17 08:01:56.718516', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 08:01:55');
INSERT INTO "public"."t_job_log" VALUES (465, '2024-05-17 12:00:02.07126', 0, '2024-05-17 12:00:02.07126', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (466, '2024-05-17 16:00:01.76014', 0, '2024-05-17 16:00:01.76014', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (467, '2024-05-17 20:00:01.718714', 0, '2024-05-17 20:00:01.718714', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (468, '2024-05-18 00:00:01.668176', 0, '2024-05-18 00:00:01.668176', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (469, '2024-05-18 04:00:01.605606', 0, '2024-05-18 04:00:01.605606', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (470, '2024-05-18 06:04:23.664169', 0, '2024-05-18 06:04:23.664169', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-18 06:04:23.58654');
INSERT INTO "public"."t_job_log" VALUES (471, '2024-05-18 06:04:29.967198', 0, '2024-05-18 06:04:29.967198', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 06:04:28');
INSERT INTO "public"."t_job_log" VALUES (472, '2024-05-18 06:45:45.525158', 0, '2024-05-18 06:45:45.525158', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-18 06:45:45.433004');
INSERT INTO "public"."t_job_log" VALUES (473, '2024-05-18 06:45:51.678051', 0, '2024-05-18 06:45:51.678051', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 06:45:50');
INSERT INTO "public"."t_job_log" VALUES (474, '2024-05-18 08:00:01.644282', 0, '2024-05-18 08:00:01.644282', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (475, '2024-05-18 12:00:01.575224', 0, '2024-05-18 12:00:01.575224', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (476, '2024-05-18 16:00:06.486094', 0, '2024-05-18 16:00:06.486094', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (477, '2024-05-18 20:00:02.093095', 0, '2024-05-18 20:00:02.093095', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (478, '2024-05-19 00:00:01.651354', 0, '2024-05-19 00:00:01.651354', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (479, '2024-05-19 04:00:01.603852', 0, '2024-05-19 04:00:01.603852', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (480, '2024-05-19 08:00:01.811565', 0, '2024-05-19 08:00:01.811565', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (481, '2024-05-19 12:00:01.689431', 0, '2024-05-19 12:00:01.689431', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (482, '2024-05-19 13:49:38.845754', 0, '2024-05-19 13:49:38.845754', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-19 13:49:38.758356');
INSERT INTO "public"."t_job_log" VALUES (483, '2024-05-19 13:49:44.678016', 0, '2024-05-19 13:49:44.678016', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 13:49:43');
INSERT INTO "public"."t_job_log" VALUES (484, '2024-05-19 16:00:02.191164', 0, '2024-05-19 16:00:02.191164', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (485, '2024-05-19 20:00:01.579878', 0, '2024-05-19 20:00:01.579878', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (486, '2024-05-20 00:00:01.603571', 0, '2024-05-20 00:00:01.603571', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (487, '2024-05-20 04:00:01.563987', 0, '2024-05-20 04:00:01.563987', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (599, '2024-05-30 00:00:01.576305', 0, '2024-05-30 00:00:01.576305', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (488, '2024-05-20 08:00:01.674383', 0, '2024-05-20 08:00:01.674383', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (490, '2024-05-20 16:00:01.76607', 0, '2024-05-20 16:00:01.76607', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (491, '2024-05-20 20:00:01.981432', 0, '2024-05-20 20:00:01.981432', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (489, '2024-05-20 12:00:01.653279', 0, '2024-05-20 12:00:01.653279', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (492, '2024-05-20 20:01:41.839747', 0, '2024-05-20 20:01:41.839747', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-20 20:01:41.756859');
INSERT INTO "public"."t_job_log" VALUES (493, '2024-05-20 20:01:47.427452', 0, '2024-05-20 20:01:47.427452', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 20:01:46');
INSERT INTO "public"."t_job_log" VALUES (494, '2024-05-20 21:36:59.91981', 0, '2024-05-20 21:36:59.91981', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-20 21:36:59.854412');
INSERT INTO "public"."t_job_log" VALUES (495, '2024-05-20 21:37:05.681067', 0, '2024-05-20 21:37:05.681067', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 21:37:04');
INSERT INTO "public"."t_job_log" VALUES (496, '2024-05-21 00:00:01.50331', 0, '2024-05-21 00:00:01.50331', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (497, '2024-05-21 02:55:59.711886', 0, '2024-05-21 02:55:59.711886', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-21 02:55:59.620754');
INSERT INTO "public"."t_job_log" VALUES (498, '2024-05-21 02:56:05.727925', 0, '2024-05-21 02:56:05.727925', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 02:56:04');
INSERT INTO "public"."t_job_log" VALUES (499, '2024-05-21 04:00:01.571505', 0, '2024-05-21 04:00:01.571505', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (500, '2024-05-21 06:24:56.991612', 0, '2024-05-21 06:24:56.991612', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-21 06:24:56.925963');
INSERT INTO "public"."t_job_log" VALUES (501, '2024-05-21 06:25:02.789613', 0, '2024-05-21 06:25:02.789613', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 06:25:01');
INSERT INTO "public"."t_job_log" VALUES (502, '2024-05-21 08:00:01.620456', 0, '2024-05-21 08:00:01.620456', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (503, '2024-05-21 12:00:01.705845', 0, '2024-05-21 12:00:01.705845', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (504, '2024-05-21 16:00:01.719569', 0, '2024-05-21 16:00:01.719569', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (505, '2024-05-21 20:00:01.580186', 0, '2024-05-21 20:00:01.580186', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (506, '2024-05-22 00:00:01.551865', 0, '2024-05-22 00:00:01.551865', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (507, '2024-05-22 04:00:01.811012', 0, '2024-05-22 04:00:01.811012', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (508, '2024-05-22 08:00:05.338443', 0, '2024-05-22 08:00:05.338443', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (509, '2024-05-22 12:00:01.68709', 0, '2024-05-22 12:00:01.68709', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (510, '2024-05-22 15:37:06.357417', 0, '2024-05-22 15:37:06.357417', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-22 15:37:06.281264');
INSERT INTO "public"."t_job_log" VALUES (511, '2024-05-22 15:37:16.602114', 0, '2024-05-22 15:37:16.602114', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-22 15:37:16.530468');
INSERT INTO "public"."t_job_log" VALUES (512, '2024-05-22 15:37:22.853401', 0, '2024-05-22 15:37:22.853401', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 15:37:21');
INSERT INTO "public"."t_job_log" VALUES (513, '2024-05-22 16:00:01.766455', 0, '2024-05-22 16:00:01.766455', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (514, '2024-05-22 20:00:01.555945', 0, '2024-05-22 20:00:01.555945', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (515, '2024-05-23 00:00:01.617792', 0, '2024-05-23 00:00:01.617792', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (516, '2024-05-23 04:00:01.715451', 0, '2024-05-23 04:00:01.715451', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (517, '2024-05-23 07:18:57.467495', 0, '2024-05-23 07:18:57.467495', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-23 07:18:57.370274');
INSERT INTO "public"."t_job_log" VALUES (518, '2024-05-23 07:19:03.95701', 0, '2024-05-23 07:19:03.95701', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 07:19:02');
INSERT INTO "public"."t_job_log" VALUES (519, '2024-05-23 08:00:02.92876', 0, '2024-05-23 08:00:02.92876', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (520, '2024-05-23 10:17:01.129325', 0, '2024-05-23 10:17:01.129325', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-23 10:17:01.047302');
INSERT INTO "public"."t_job_log" VALUES (521, '2024-05-23 10:17:08.000562', 0, '2024-05-23 10:17:08.000562', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 10:17:06');
INSERT INTO "public"."t_job_log" VALUES (522, '2024-05-23 12:00:03.24178', 0, '2024-05-23 12:00:03.24178', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (523, '2024-05-23 16:00:01.921802', 0, '2024-05-23 16:00:01.921802', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (524, '2024-05-23 20:00:01.654032', 0, '2024-05-23 20:00:01.654032', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (525, '2024-05-24 00:00:01.677375', 0, '2024-05-24 00:00:01.677375', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (526, '2024-05-24 00:57:08.387412', 0, '2024-05-24 00:57:08.387412', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-24 00:57:08.316777');
INSERT INTO "public"."t_job_log" VALUES (527, '2024-05-24 00:57:14.716422', 0, '2024-05-24 00:57:14.716422', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 00:57:13');
INSERT INTO "public"."t_job_log" VALUES (528, '2024-05-24 04:00:01.638103', 0, '2024-05-24 04:00:01.638103', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (529, '2024-05-24 05:42:49.934716', 0, '2024-05-24 05:42:49.934716', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-24 05:42:49.796083');
INSERT INTO "public"."t_job_log" VALUES (530, '2024-05-24 05:42:55.924192', 0, '2024-05-24 05:42:55.924192', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 05:42:54');
INSERT INTO "public"."t_job_log" VALUES (531, '2024-05-24 06:46:29.247222', 0, '2024-05-24 06:46:29.247222', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-24 06:46:29.17837');
INSERT INTO "public"."t_job_log" VALUES (532, '2024-05-24 06:46:35.829332', 0, '2024-05-24 06:46:35.829332', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 06:46:34');
INSERT INTO "public"."t_job_log" VALUES (533, '2024-05-24 08:00:01.705672', 0, '2024-05-24 08:00:01.705672', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (534, '2024-05-24 10:24:57.495422', 0, '2024-05-24 10:24:57.495422', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-24 10:24:57.418328');
INSERT INTO "public"."t_job_log" VALUES (535, '2024-05-24 10:25:03.715305', 0, '2024-05-24 10:25:03.715305', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 10:25:02');
INSERT INTO "public"."t_job_log" VALUES (536, '2024-05-24 12:00:04.061488', 0, '2024-05-24 12:00:04.061488', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (537, '2024-05-24 15:02:43.679935', 0, '2024-05-24 15:02:43.679935', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-24 15:02:43.602166');
INSERT INTO "public"."t_job_log" VALUES (538, '2024-05-24 15:02:49.76258', 0, '2024-05-24 15:02:49.76258', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 15:02:48');
INSERT INTO "public"."t_job_log" VALUES (539, '2024-05-24 16:00:02.300269', 0, '2024-05-24 16:00:02.300269', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (540, '2024-05-24 20:00:01.579343', 0, '2024-05-24 20:00:01.579343', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (541, '2024-05-25 00:00:01.457534', 0, '2024-05-25 00:00:01.457534', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (542, '2024-05-25 04:00:01.687636', 0, '2024-05-25 04:00:01.687636', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (543, '2024-05-25 08:00:02.175791', 0, '2024-05-25 08:00:02.175791', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (544, '2024-05-25 12:00:01.666876', 0, '2024-05-25 12:00:01.666876', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (545, '2024-05-25 15:44:51.142405', 0, '2024-05-25 15:44:51.142405', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-25 15:44:51.0572');
INSERT INTO "public"."t_job_log" VALUES (546, '2024-05-25 15:44:58.200498', 0, '2024-05-25 15:44:58.200498', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 15:44:56');
INSERT INTO "public"."t_job_log" VALUES (547, '2024-05-25 16:00:01.6357', 0, '2024-05-25 16:00:01.6357', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (548, '2024-05-25 17:28:42.335299', 0, '2024-05-25 17:28:42.335299', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-25 17:28:42.274189');
INSERT INTO "public"."t_job_log" VALUES (549, '2024-05-25 17:28:48.724761', 0, '2024-05-25 17:28:48.724761', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 17:28:47');
INSERT INTO "public"."t_job_log" VALUES (550, '2024-05-25 20:00:01.740283', 0, '2024-05-25 20:00:01.740283', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (551, '2024-05-26 00:00:01.660029', 0, '2024-05-26 00:00:01.660029', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (552, '2024-05-26 04:00:01.600121', 0, '2024-05-26 04:00:01.600121', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (553, '2024-05-26 08:00:01.669152', 0, '2024-05-26 08:00:01.669152', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (554, '2024-05-26 12:00:03.31564', 0, '2024-05-26 12:00:03.31564', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (555, '2024-05-26 16:00:01.699206', 0, '2024-05-26 16:00:01.699206', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (556, '2024-05-26 20:00:01.601149', 0, '2024-05-26 20:00:01.601149', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (557, '2024-05-27 00:00:01.641994', 0, '2024-05-27 00:00:01.641994', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (558, '2024-05-27 04:00:01.805772', 0, '2024-05-27 04:00:01.805772', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (559, '2024-05-27 08:00:02.943053', 0, '2024-05-27 08:00:02.943053', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (560, '2024-05-27 12:00:02.560263', 0, '2024-05-27 12:00:02.560263', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (561, '2024-05-27 16:00:01.926744', 0, '2024-05-27 16:00:01.926744', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (562, '2024-05-27 20:00:01.681775', 0, '2024-05-27 20:00:01.681775', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (563, '2024-05-28 00:00:01.661805', 0, '2024-05-28 00:00:01.661805', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (564, '2024-05-28 03:41:15.385574', 0, '2024-05-28 03:41:15.385574', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-28 03:41:15.30458');
INSERT INTO "public"."t_job_log" VALUES (565, '2024-05-28 03:41:21.862425', 0, '2024-05-28 03:41:21.862425', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 03:41:20');
INSERT INTO "public"."t_job_log" VALUES (566, '2024-05-28 04:00:01.844219', 0, '2024-05-28 04:00:01.844219', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (567, '2024-05-28 08:00:02.010069', 0, '2024-05-28 08:00:02.010069', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (568, '2024-05-28 10:10:31.204041', 0, '2024-05-28 10:10:31.204041', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-28 10:10:31.089731');
INSERT INTO "public"."t_job_log" VALUES (569, '2024-05-28 10:10:38.171552', 0, '2024-05-28 10:10:38.171552', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 10:10:36');
INSERT INTO "public"."t_job_log" VALUES (570, '2024-05-28 12:00:02.165782', 0, '2024-05-28 12:00:02.165782', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (571, '2024-05-28 15:47:49.441861', 0, '2024-05-28 15:47:49.441861', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-28 15:47:49.346494');
INSERT INTO "public"."t_job_log" VALUES (572, '2024-05-28 15:47:55.918691', 0, '2024-05-28 15:47:55.918691', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 15:47:54');
INSERT INTO "public"."t_job_log" VALUES (573, '2024-05-28 16:00:02.382312', 0, '2024-05-28 16:00:02.382312', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (574, '2024-05-28 20:00:01.673257', 0, '2024-05-28 20:00:01.673257', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (575, '2024-05-29 00:00:01.599847', 0, '2024-05-29 00:00:01.599847', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (576, '2024-05-29 04:00:01.610926', 0, '2024-05-29 04:00:01.610926', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (577, '2024-05-29 08:00:01.773919', 0, '2024-05-29 08:00:01.773919', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (578, '2024-05-29 09:42:23.722795', 0, '2024-05-29 09:42:23.722795', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-29 09:42:23.648687');
INSERT INTO "public"."t_job_log" VALUES (579, '2024-05-29 09:42:29.775271', 0, '2024-05-29 09:42:29.775271', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 09:42:28');
INSERT INTO "public"."t_job_log" VALUES (580, '2024-05-29 10:11:27.108717', 0, '2024-05-29 10:11:27.108717', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-29 10:11:27.037558');
INSERT INTO "public"."t_job_log" VALUES (581, '2024-05-29 10:11:33.800465', 0, '2024-05-29 10:11:33.800465', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 10:11:32');
INSERT INTO "public"."t_job_log" VALUES (582, '2024-05-29 10:17:21.567938', 0, '2024-05-29 10:17:21.567938', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-29 10:17:21.492888');
INSERT INTO "public"."t_job_log" VALUES (583, '2024-05-29 10:17:27.756661', 0, '2024-05-29 10:17:27.756661', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 10:17:26');
INSERT INTO "public"."t_job_log" VALUES (584, '2024-05-29 10:24:33.866995', 0, '2024-05-29 10:24:33.866995', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-29 10:24:33.776581');
INSERT INTO "public"."t_job_log" VALUES (585, '2024-05-29 10:24:39.696907', 0, '2024-05-29 10:24:39.696907', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 10:24:38');
INSERT INTO "public"."t_job_log" VALUES (586, '2024-05-29 10:38:01.077848', 0, '2024-05-29 10:38:01.077848', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-29 10:38:00.994486');
INSERT INTO "public"."t_job_log" VALUES (587, '2024-05-29 10:38:07.804543', 0, '2024-05-29 10:38:07.804543', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 10:38:06');
INSERT INTO "public"."t_job_log" VALUES (588, '2024-05-29 11:48:52.38203', 0, '2024-05-29 11:48:52.38203', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-29 11:48:52.293939');
INSERT INTO "public"."t_job_log" VALUES (589, '2024-05-29 11:49:00.115348', 0, '2024-05-29 11:49:00.115348', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 11:48:57');
INSERT INTO "public"."t_job_log" VALUES (590, '2024-05-29 12:00:04.971673', 0, '2024-05-29 12:00:04.971673', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (591, '2024-05-29 13:11:34.067785', 0, '2024-05-29 13:11:34.067785', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-29 13:11:33.959731');
INSERT INTO "public"."t_job_log" VALUES (592, '2024-05-29 13:11:40.795556', 0, '2024-05-29 13:11:40.795556', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 13:11:39');
INSERT INTO "public"."t_job_log" VALUES (593, '2024-05-29 13:12:45.603982', 0, '2024-05-29 13:12:45.603982', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 13:12:41.362896');
INSERT INTO "public"."t_job_log" VALUES (594, '2024-05-29 13:16:47.234718', 0, '2024-05-29 13:16:47.234718', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-29 13:16:47.150357');
INSERT INTO "public"."t_job_log" VALUES (595, '2024-05-29 13:16:54.537286', 0, '2024-05-29 13:16:54.537286', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-29 13:16:52');
INSERT INTO "public"."t_job_log" VALUES (596, '2024-05-29 13:17:05.519484', 0, '2024-05-29 13:17:05.519484', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-29 13:17:02.840271');
INSERT INTO "public"."t_job_log" VALUES (597, '2024-05-29 16:00:06.236016', 0, '2024-05-29 16:00:06.236016', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-05-29 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (598, '2024-05-29 20:00:01.722006', 0, '2024-05-29 20:00:01.722006', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-29 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (600, '2024-05-30 02:51:35.939129', 0, '2024-05-30 02:51:35.939129', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-30 02:51:35.829169');
INSERT INTO "public"."t_job_log" VALUES (601, '2024-05-30 02:51:47.4114', 0, '2024-05-30 02:51:47.4114', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-30 02:51:47.141953');
INSERT INTO "public"."t_job_log" VALUES (602, '2024-05-30 04:00:01.629866', 0, '2024-05-30 04:00:01.629866', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (603, '2024-05-30 08:00:01.791933', 0, '2024-05-30 08:00:01.791933', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (604, '2024-05-30 12:00:01.698592', 0, '2024-05-30 12:00:01.698592', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (605, '2024-05-30 16:00:01.657603', 0, '2024-05-30 16:00:01.657603', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (606, '2024-05-30 18:54:29.770156', 0, '2024-05-30 18:54:29.770156', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-30 18:54:29.713963');
INSERT INTO "public"."t_job_log" VALUES (607, '2024-05-30 18:54:35.753744', 0, '2024-05-30 18:54:35.753744', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 18:54:34');
INSERT INTO "public"."t_job_log" VALUES (608, '2024-05-30 20:00:01.60062', 0, '2024-05-30 20:00:01.60062', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (609, '2024-05-31 00:00:01.539853', 0, '2024-05-31 00:00:01.539853', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (610, '2024-05-31 04:00:01.569203', 0, '2024-05-31 04:00:01.569203', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (611, '2024-05-31 08:00:01.605561', 0, '2024-05-31 08:00:01.605561', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (612, '2024-05-31 12:00:01.707762', 0, '2024-05-31 12:00:01.707762', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (613, '2024-05-31 16:00:01.655598', 0, '2024-05-31 16:00:01.655598', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (614, '2024-05-31 20:00:01.718693', 0, '2024-05-31 20:00:01.718693', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (615, '2024-05-31 23:00:44.915425', 0, '2024-05-31 23:00:44.915425', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-05-31 23:00:44.826208');
INSERT INTO "public"."t_job_log" VALUES (616, '2024-06-01 00:00:02.682182', 0, '2024-06-01 00:00:02.682182', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (617, '2024-06-01 04:00:01.629946', 0, '2024-06-01 04:00:01.629946', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (618, '2024-06-01 04:49:04.309851', 0, '2024-06-01 04:49:04.309851', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-01 04:49:04.223086');
INSERT INTO "public"."t_job_log" VALUES (619, '2024-06-01 04:49:10.782657', 0, '2024-06-01 04:49:10.782657', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 04:49:09');
INSERT INTO "public"."t_job_log" VALUES (620, '2024-06-01 08:00:01.721567', 0, '2024-06-01 08:00:01.721567', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (621, '2024-06-01 10:16:32.096786', 0, '2024-06-01 10:16:32.096786', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-01 10:16:32.018008');
INSERT INTO "public"."t_job_log" VALUES (622, '2024-06-01 10:16:38.614681', 0, '2024-06-01 10:16:38.614681', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 10:16:37');
INSERT INTO "public"."t_job_log" VALUES (623, '2024-06-01 11:50:16.66379', 0, '2024-06-01 11:50:16.66379', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-01 11:50:16.581616');
INSERT INTO "public"."t_job_log" VALUES (624, '2024-06-01 11:50:22.717726', 0, '2024-06-01 11:50:22.717726', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 11:50:21');
INSERT INTO "public"."t_job_log" VALUES (625, '2024-06-01 12:00:01.616742', 0, '2024-06-01 12:00:01.616742', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (626, '2024-06-01 14:21:03.606598', 0, '2024-06-01 14:21:03.606598', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-01 14:21:03.510735');
INSERT INTO "public"."t_job_log" VALUES (627, '2024-06-01 14:21:10.467126', 0, '2024-06-01 14:21:10.467126', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 14:21:08');
INSERT INTO "public"."t_job_log" VALUES (628, '2024-06-01 16:00:02.426628', 0, '2024-06-01 16:00:02.426628', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (629, '2024-06-01 20:00:01.579517', 0, '2024-06-01 20:00:01.579517', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (630, '2024-06-02 00:00:01.628125', 0, '2024-06-02 00:00:01.628125', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (631, '2024-06-02 04:00:01.702862', 0, '2024-06-02 04:00:01.702862', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (632, '2024-06-02 08:00:01.713989', 0, '2024-06-02 08:00:01.713989', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (633, '2024-06-02 12:00:06.167596', 0, '2024-06-02 12:00:06.167596', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-02 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (634, '2024-06-02 16:00:01.671914', 0, '2024-06-02 16:00:01.671914', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (635, '2024-06-02 20:00:01.595224', 0, '2024-06-02 20:00:01.595224', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (636, '2024-06-03 00:00:01.621642', 0, '2024-06-03 00:00:01.621642', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (637, '2024-06-03 04:00:01.560919', 0, '2024-06-03 04:00:01.560919', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (638, '2024-06-03 08:00:01.547695', 0, '2024-06-03 08:00:01.547695', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (639, '2024-06-03 12:00:01.58909', 0, '2024-06-03 12:00:01.58909', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (640, '2024-06-03 13:42:13.067517', 0, '2024-06-03 13:42:13.067517', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-03 13:42:12.969188');
INSERT INTO "public"."t_job_log" VALUES (641, '2024-06-03 13:42:20.227873', 0, '2024-06-03 13:42:20.227873', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 13:42:18');
INSERT INTO "public"."t_job_log" VALUES (642, '2024-06-03 16:00:01.777756', 0, '2024-06-03 16:00:01.777756', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (643, '2024-06-03 20:00:01.588165', 0, '2024-06-03 20:00:01.588165', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (644, '2024-06-04 00:00:01.586214', 0, '2024-06-04 00:00:01.586214', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (645, '2024-06-04 04:00:01.542712', 0, '2024-06-04 04:00:01.542712', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (646, '2024-06-04 08:00:01.640345', 0, '2024-06-04 08:00:01.640345', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (647, '2024-06-04 09:03:05.481965', 0, '2024-06-04 09:03:05.481965', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-04 09:03:05.394291');
INSERT INTO "public"."t_job_log" VALUES (648, '2024-06-04 09:03:11.915814', 0, '2024-06-04 09:03:11.915814', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 09:03:10');
INSERT INTO "public"."t_job_log" VALUES (649, '2024-06-04 12:00:01.941064', 0, '2024-06-04 12:00:01.941064', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (650, '2024-06-04 16:00:01.751858', 0, '2024-06-04 16:00:01.751858', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (651, '2024-06-04 16:01:23.370601', 0, '2024-06-04 16:01:23.370601', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-04 16:01:23.275632');
INSERT INTO "public"."t_job_log" VALUES (652, '2024-06-04 16:01:29.513044', 0, '2024-06-04 16:01:29.513044', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 16:01:28');
INSERT INTO "public"."t_job_log" VALUES (653, '2024-06-04 20:00:01.644797', 0, '2024-06-04 20:00:01.644797', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (654, '2024-06-05 00:00:01.709526', 0, '2024-06-05 00:00:01.709526', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (655, '2024-06-05 04:00:01.685678', 0, '2024-06-05 04:00:01.685678', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (656, '2024-06-05 08:00:05.481153', 0, '2024-06-05 08:00:05.481153', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (657, '2024-06-05 12:00:02.650802', 0, '2024-06-05 12:00:02.650802', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (658, '2024-06-05 15:25:04.367926', 0, '2024-06-05 15:25:04.367926', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-05 15:25:04.284213');
INSERT INTO "public"."t_job_log" VALUES (659, '2024-06-05 15:42:33.993374', 0, '2024-06-05 15:42:33.993374', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-05 15:42:33.973523');
INSERT INTO "public"."t_job_log" VALUES (660, '2024-06-05 15:42:35.759455', 0, '2024-06-05 15:42:35.759455', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 15:42:34');
INSERT INTO "public"."t_job_log" VALUES (661, '2024-06-05 15:53:44.260447', 0, '2024-06-05 15:53:44.260447', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-05 15:53:44.177609');
INSERT INTO "public"."t_job_log" VALUES (662, '2024-06-05 15:53:50.731982', 0, '2024-06-05 15:53:50.731982', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 15:53:49');
INSERT INTO "public"."t_job_log" VALUES (663, '2024-06-05 16:00:01.945517', 0, '2024-06-05 16:00:01.945517', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (664, '2024-06-05 20:00:01.580503', 0, '2024-06-05 20:00:01.580503', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (665, '2024-06-06 00:00:03.066156', 0, '2024-06-06 00:00:03.066156', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (666, '2024-06-06 00:13:39.721556', 0, '2024-06-06 00:13:39.721556', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-06 00:13:39.642585');
INSERT INTO "public"."t_job_log" VALUES (667, '2024-06-06 00:13:47.143535', 0, '2024-06-06 00:13:47.143535', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 00:13:44');
INSERT INTO "public"."t_job_log" VALUES (668, '2024-06-06 00:19:50.652918', 0, '2024-06-06 00:19:50.652918', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-06 00:19:50.582547');
INSERT INTO "public"."t_job_log" VALUES (669, '2024-06-06 00:19:56.801146', 0, '2024-06-06 00:19:56.801146', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 00:19:55');
INSERT INTO "public"."t_job_log" VALUES (670, '2024-06-06 02:55:41.17679', 0, '2024-06-06 02:55:41.17679', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-06 02:55:41.109732');
INSERT INTO "public"."t_job_log" VALUES (671, '2024-06-06 02:55:47.826877', 0, '2024-06-06 02:55:47.826877', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 02:55:46');
INSERT INTO "public"."t_job_log" VALUES (672, '2024-06-06 04:00:02.58624', 0, '2024-06-06 04:00:02.58624', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (673, '2024-06-06 08:00:01.668178', 0, '2024-06-06 08:00:01.668178', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (674, '2024-06-06 09:11:00.50914', 0, '2024-06-06 09:11:00.50914', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-06 09:11:00.425286');
INSERT INTO "public"."t_job_log" VALUES (675, '2024-06-06 09:11:06.615083', 0, '2024-06-06 09:11:06.615083', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 09:11:05');
INSERT INTO "public"."t_job_log" VALUES (676, '2024-06-06 10:00:24.479839', 0, '2024-06-06 10:00:24.479839', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-06 10:00:24.406831');
INSERT INTO "public"."t_job_log" VALUES (677, '2024-06-06 10:00:30.779451', 0, '2024-06-06 10:00:30.779451', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 10:00:29');
INSERT INTO "public"."t_job_log" VALUES (678, '2024-06-06 12:00:01.891295', 0, '2024-06-06 12:00:01.891295', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (679, '2024-06-06 16:00:02.094006', 0, '2024-06-06 16:00:02.094006', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (680, '2024-06-06 20:00:01.603802', 0, '2024-06-06 20:00:01.603802', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (681, '2024-06-07 00:00:01.545829', 0, '2024-06-07 00:00:01.545829', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (682, '2024-06-07 04:00:01.582201', 0, '2024-06-07 04:00:01.582201', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (683, '2024-06-07 07:00:39.565811', 0, '2024-06-07 07:00:39.565811', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-07 07:00:39.481346');
INSERT INTO "public"."t_job_log" VALUES (684, '2024-06-07 08:00:01.619733', 0, '2024-06-07 08:00:01.619733', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (685, '2024-06-07 10:19:36.743334', 0, '2024-06-07 10:19:36.743334', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-07 10:19:36.658708');
INSERT INTO "public"."t_job_log" VALUES (686, '2024-06-07 10:19:42.750922', 0, '2024-06-07 10:19:42.750922', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 10:19:41');
INSERT INTO "public"."t_job_log" VALUES (687, '2024-06-07 12:00:10.332632', 0, '2024-06-07 12:00:10.332632', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (688, '2024-06-07 16:00:12.42686', 0, '2024-06-07 16:00:12.42686', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-07 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (689, '2024-06-07 20:00:01.626345', 0, '2024-06-07 20:00:01.626345', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (690, '2024-06-08 00:00:01.908332', 0, '2024-06-08 00:00:01.908332', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (691, '2024-06-08 01:52:25.035801', 0, '2024-06-08 01:52:25.035801', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-08 01:52:24.952734');
INSERT INTO "public"."t_job_log" VALUES (692, '2024-06-08 01:52:30.596379', 0, '2024-06-08 01:52:30.596379', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 01:52:29');
INSERT INTO "public"."t_job_log" VALUES (693, '2024-06-08 02:40:42.390827', 0, '2024-06-08 02:40:42.390827', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-08 02:40:42.30142');
INSERT INTO "public"."t_job_log" VALUES (694, '2024-06-08 02:40:48.726324', 0, '2024-06-08 02:40:48.726324', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 02:40:47');
INSERT INTO "public"."t_job_log" VALUES (695, '2024-06-08 03:27:12.493639', 0, '2024-06-08 03:27:12.493639', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-08 03:27:12.390536');
INSERT INTO "public"."t_job_log" VALUES (696, '2024-06-08 03:27:18.575022', 0, '2024-06-08 03:27:18.575022', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 03:27:17');
INSERT INTO "public"."t_job_log" VALUES (697, '2024-06-08 03:30:35.833648', 0, '2024-06-08 03:30:35.833648', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-08 03:30:35.742626');
INSERT INTO "public"."t_job_log" VALUES (698, '2024-06-08 03:30:41.6501', 0, '2024-06-08 03:30:41.6501', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 03:30:40');
INSERT INTO "public"."t_job_log" VALUES (699, '2024-06-08 04:00:01.595856', 0, '2024-06-08 04:00:01.595856', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (700, '2024-06-08 08:00:03.039319', 0, '2024-06-08 08:00:03.039319', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (701, '2024-06-08 12:00:01.724227', 0, '2024-06-08 12:00:01.724227', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (702, '2024-06-08 16:00:01.921792', 0, '2024-06-08 16:00:01.921792', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (703, '2024-06-08 20:00:01.636364', 0, '2024-06-08 20:00:01.636364', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (704, '2024-06-09 00:00:01.664079', 0, '2024-06-09 00:00:01.664079', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (705, '2024-06-09 04:00:01.643614', 0, '2024-06-09 04:00:01.643614', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (706, '2024-06-09 04:34:59.3933', 0, '2024-06-09 04:34:59.3933', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-09 04:34:59.301986');
INSERT INTO "public"."t_job_log" VALUES (707, '2024-06-09 04:35:05.72011', 0, '2024-06-09 04:35:05.72011', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 04:35:04');
INSERT INTO "public"."t_job_log" VALUES (708, '2024-06-09 08:00:02.439511', 0, '2024-06-09 08:00:02.439511', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (709, '2024-06-09 11:52:34.193471', 0, '2024-06-09 11:52:34.193471', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-09 11:52:34.118681');
INSERT INTO "public"."t_job_log" VALUES (710, '2024-06-09 11:52:40.837814', 0, '2024-06-09 11:52:40.837814', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 11:52:39');
INSERT INTO "public"."t_job_log" VALUES (711, '2024-06-09 12:00:01.674326', 0, '2024-06-09 12:00:01.674326', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (712, '2024-06-09 12:35:27.328162', 0, '2024-06-09 12:35:27.328162', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-09 12:35:27.248961');
INSERT INTO "public"."t_job_log" VALUES (713, '2024-06-09 12:35:33.706025', 0, '2024-06-09 12:35:33.706025', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 12:35:32');
INSERT INTO "public"."t_job_log" VALUES (714, '2024-06-09 16:00:02.511591', 0, '2024-06-09 16:00:02.511591', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (715, '2024-06-09 16:26:05.182989', 0, '2024-06-09 16:26:05.182989', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-09 16:26:05.099907');
INSERT INTO "public"."t_job_log" VALUES (716, '2024-06-09 16:26:12.219764', 0, '2024-06-09 16:26:12.219764', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 16:26:10');
INSERT INTO "public"."t_job_log" VALUES (717, '2024-06-09 18:52:55.253417', 0, '2024-06-09 18:52:55.253417', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-09 18:52:55.140407');
INSERT INTO "public"."t_job_log" VALUES (718, '2024-06-09 18:56:40.5323', 0, '2024-06-09 18:56:40.5323', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-09 18:56:40.459033');
INSERT INTO "public"."t_job_log" VALUES (719, '2024-06-09 18:56:46.710018', 0, '2024-06-09 18:56:46.710018', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 18:56:45');
INSERT INTO "public"."t_job_log" VALUES (720, '2024-06-09 20:00:01.666127', 0, '2024-06-09 20:00:01.666127', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (721, '2024-06-10 00:00:01.593318', 0, '2024-06-10 00:00:01.593318', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (722, '2024-06-10 02:30:00.620191', 0, '2024-06-10 02:30:00.620191', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-10 02:30:00.534211');
INSERT INTO "public"."t_job_log" VALUES (723, '2024-06-10 02:57:38.624537', 0, '2024-06-10 02:57:38.624537', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-10 02:57:38.551465');
INSERT INTO "public"."t_job_log" VALUES (724, '2024-06-10 02:57:44.944747', 0, '2024-06-10 02:57:44.944747', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 02:57:43');
INSERT INTO "public"."t_job_log" VALUES (725, '2024-06-10 04:00:02.487778', 0, '2024-06-10 04:00:02.487778', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (726, '2024-06-10 08:00:03.948393', 0, '2024-06-10 08:00:03.948393', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (727, '2024-06-10 12:00:02.570921', 0, '2024-06-10 12:00:02.570921', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (728, '2024-06-10 16:00:01.820465', 0, '2024-06-10 16:00:01.820465', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (729, '2024-06-10 20:00:01.658887', 0, '2024-06-10 20:00:01.658887', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (730, '2024-06-11 00:00:01.524798', 0, '2024-06-11 00:00:01.524798', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (731, '2024-06-11 01:56:51.690943', 0, '2024-06-11 01:56:51.690943', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-11 01:56:51.445727');
INSERT INTO "public"."t_job_log" VALUES (732, '2024-06-11 02:30:09.989589', 0, '2024-06-11 02:30:09.989589', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-11 02:30:09.915875');
INSERT INTO "public"."t_job_log" VALUES (733, '2024-06-11 02:30:17.277722', 0, '2024-06-11 02:30:17.277722', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 02:30:14');
INSERT INTO "public"."t_job_log" VALUES (734, '2024-06-11 04:00:01.675369', 0, '2024-06-11 04:00:01.675369', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (735, '2024-06-11 08:00:03.996154', 0, '2024-06-11 08:00:03.996154', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (736, '2024-06-11 10:04:57.707298', 0, '2024-06-11 10:04:57.707298', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-11 10:04:57.631493');
INSERT INTO "public"."t_job_log" VALUES (737, '2024-06-11 10:48:37.247169', 0, '2024-06-11 10:48:37.247169', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-11 10:48:37.226793');
INSERT INTO "public"."t_job_log" VALUES (738, '2024-06-11 10:48:38.624049', 0, '2024-06-11 10:48:38.624049', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 10:48:37');
INSERT INTO "public"."t_job_log" VALUES (739, '2024-06-11 12:00:08.836043', 0, '2024-06-11 12:00:08.836043', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-11 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (740, '2024-06-11 16:00:01.895004', 0, '2024-06-11 16:00:01.895004', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (741, '2024-06-11 20:00:01.651544', 0, '2024-06-11 20:00:01.651544', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (742, '2024-06-12 00:00:01.567086', 0, '2024-06-12 00:00:01.567086', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (743, '2024-06-12 02:16:23.781572', 0, '2024-06-12 02:16:23.781572', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-12 02:16:23.692402');
INSERT INTO "public"."t_job_log" VALUES (744, '2024-06-12 02:16:29.814309', 0, '2024-06-12 02:16:29.814309', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 02:16:28');
INSERT INTO "public"."t_job_log" VALUES (745, '2024-06-12 03:06:24.480019', 0, '2024-06-12 03:06:24.480019', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-12 03:06:24.399978');
INSERT INTO "public"."t_job_log" VALUES (746, '2024-06-12 03:06:30.70483', 0, '2024-06-12 03:06:30.70483', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 03:06:29');
INSERT INTO "public"."t_job_log" VALUES (747, '2024-06-12 04:00:01.592978', 0, '2024-06-12 04:00:01.592978', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (748, '2024-06-12 08:00:01.78223', 0, '2024-06-12 08:00:01.78223', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (749, '2024-06-12 10:09:47.315928', 0, '2024-06-12 10:09:47.315928', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-12 10:09:47.240502');
INSERT INTO "public"."t_job_log" VALUES (750, '2024-06-12 12:00:01.711934', 0, '2024-06-12 12:00:01.711934', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (751, '2024-06-12 16:00:02.953498', 0, '2024-06-12 16:00:02.953498', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (752, '2024-06-12 20:00:01.70377', 0, '2024-06-12 20:00:01.70377', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (753, '2024-06-13 00:00:02.490681', 0, '2024-06-13 00:00:02.490681', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (754, '2024-06-13 04:00:06.676736', 0, '2024-06-13 04:00:06.676736', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-13 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (755, '2024-06-13 04:46:35.906564', 0, '2024-06-13 04:46:35.906564', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-13 04:46:35.825492');
INSERT INTO "public"."t_job_log" VALUES (756, '2024-06-13 04:46:41.738827', 0, '2024-06-13 04:46:41.738827', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 04:46:40');
INSERT INTO "public"."t_job_log" VALUES (757, '2024-06-13 06:11:33.836563', 0, '2024-06-13 06:11:33.836563', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-13 06:11:33.755061');
INSERT INTO "public"."t_job_log" VALUES (758, '2024-06-13 08:00:01.605357', 0, '2024-06-13 08:00:01.605357', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (759, '2024-06-13 09:30:11.329107', 0, '2024-06-13 09:30:11.329107', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-13 09:30:11.254525');
INSERT INTO "public"."t_job_log" VALUES (760, '2024-06-13 09:30:18.509447', 0, '2024-06-13 09:30:18.509447', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 09:30:16');
INSERT INTO "public"."t_job_log" VALUES (761, '2024-06-13 09:57:01.649264', 0, '2024-06-13 09:57:01.649264', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-13 09:57:01.543823');
INSERT INTO "public"."t_job_log" VALUES (762, '2024-06-13 09:57:07.584675', 0, '2024-06-13 09:57:07.584675', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 09:57:06');
INSERT INTO "public"."t_job_log" VALUES (763, '2024-06-13 12:00:02.08168', 0, '2024-06-13 12:00:02.08168', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (764, '2024-06-14 00:00:01.54315', 0, '2024-06-14 00:00:01.54315', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (765, '2024-06-14 04:00:01.5964', 0, '2024-06-14 04:00:01.5964', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (766, '2024-06-14 11:27:06.563785', 0, '2024-06-14 11:27:06.563785', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-14 11:27:06.475387');
INSERT INTO "public"."t_job_log" VALUES (767, '2024-06-14 11:27:12.734968', 0, '2024-06-14 11:27:12.734968', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 11:27:11');
INSERT INTO "public"."t_job_log" VALUES (768, '2024-06-14 11:29:29.265963', 0, '2024-06-14 11:29:29.265963', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-14 11:29:29.187103');
INSERT INTO "public"."t_job_log" VALUES (769, '2024-06-14 11:29:35.661635', 0, '2024-06-14 11:29:35.661635', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 11:29:34');
INSERT INTO "public"."t_job_log" VALUES (770, '2024-06-14 12:00:01.889119', 0, '2024-06-14 12:00:01.889119', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (771, '2024-06-14 16:00:02.032879', 0, '2024-06-14 16:00:02.032879', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (772, '2024-06-14 18:03:25.603556', 0, '2024-06-14 18:03:25.603556', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-14 18:03:25.549065');
INSERT INTO "public"."t_job_log" VALUES (773, '2024-06-14 18:03:32.357727', 0, '2024-06-14 18:03:32.357727', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 18:03:30');
INSERT INTO "public"."t_job_log" VALUES (774, '2024-06-14 20:00:01.613147', 0, '2024-06-14 20:00:01.613147', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (775, '2024-06-15 00:00:01.677524', 0, '2024-06-15 00:00:01.677524', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (776, '2024-06-15 04:00:04.016458', 0, '2024-06-15 04:00:04.016458', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (777, '2024-06-15 06:37:29.818352', 0, '2024-06-15 06:37:29.818352', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-15 06:37:29.711066');
INSERT INTO "public"."t_job_log" VALUES (778, '2024-06-15 06:37:35.614153', 0, '2024-06-15 06:37:35.614153', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 06:37:34');
INSERT INTO "public"."t_job_log" VALUES (779, '2024-06-15 07:26:01.044295', 0, '2024-06-15 07:26:01.044295', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-15 07:26:00.958537');
INSERT INTO "public"."t_job_log" VALUES (780, '2024-06-15 07:26:07.620365', 0, '2024-06-15 07:26:07.620365', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 07:26:05');
INSERT INTO "public"."t_job_log" VALUES (781, '2024-06-15 08:00:05.749448', 0, '2024-06-15 08:00:05.749448', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (782, '2024-06-15 12:00:03.209309', 0, '2024-06-15 12:00:03.209309', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (783, '2024-06-15 13:15:52.883476', 0, '2024-06-15 13:15:52.883476', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-15 13:15:52.785437');
INSERT INTO "public"."t_job_log" VALUES (784, '2024-06-15 13:16:01.331391', 0, '2024-06-15 13:16:01.331391', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 13:15:57');
INSERT INTO "public"."t_job_log" VALUES (785, '2024-06-15 16:00:03.948849', 0, '2024-06-15 16:00:03.948849', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (786, '2024-06-15 20:00:01.572188', 0, '2024-06-15 20:00:01.572188', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (787, '2024-06-16 00:00:01.639735', 0, '2024-06-16 00:00:01.639735', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (788, '2024-06-16 04:00:02.555086', 0, '2024-06-16 04:00:02.555086', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (789, '2024-06-16 08:00:01.817355', 0, '2024-06-16 08:00:01.817355', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (790, '2024-06-16 09:49:26.989023', 0, '2024-06-16 09:49:26.989023', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-16 09:49:26.910248');
INSERT INTO "public"."t_job_log" VALUES (791, '2024-06-16 09:49:32.67413', 0, '2024-06-16 09:49:32.67413', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 09:49:31');
INSERT INTO "public"."t_job_log" VALUES (792, '2024-06-16 12:00:02.948613', 0, '2024-06-16 12:00:02.948613', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (793, '2024-06-16 16:00:01.629103', 0, '2024-06-16 16:00:01.629103', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (794, '2024-06-16 17:10:28.222646', 0, '2024-06-16 17:10:28.222646', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-16 17:10:28.15852');
INSERT INTO "public"."t_job_log" VALUES (795, '2024-06-16 20:00:01.547857', 0, '2024-06-16 20:00:01.547857', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (796, '2024-06-17 00:00:01.645906', 0, '2024-06-17 00:00:01.645906', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (797, '2024-06-17 04:00:02.961576', 0, '2024-06-17 04:00:02.961576', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (798, '2024-06-17 07:27:13.263114', 0, '2024-06-17 07:27:13.263114', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-17 07:27:13.191661');
INSERT INTO "public"."t_job_log" VALUES (799, '2024-06-17 07:27:19.767796', 0, '2024-06-17 07:27:19.767796', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 07:27:18');
INSERT INTO "public"."t_job_log" VALUES (800, '2024-06-17 08:00:02.507542', 0, '2024-06-17 08:00:02.507542', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (801, '2024-06-17 10:13:16.210012', 0, '2024-06-17 10:13:16.210012', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-17 10:13:16.137355');
INSERT INTO "public"."t_job_log" VALUES (802, '2024-06-17 10:13:22.942823', 0, '2024-06-17 10:13:22.942823', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 10:13:21');
INSERT INTO "public"."t_job_log" VALUES (803, '2024-06-17 12:00:04.349801', 0, '2024-06-17 12:00:04.349801', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (804, '2024-06-17 15:01:50.536057', 0, '2024-06-17 15:01:50.536057', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-17 15:01:50.468977');
INSERT INTO "public"."t_job_log" VALUES (805, '2024-06-17 16:00:02.932887', 0, '2024-06-17 16:00:02.932887', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (806, '2024-06-17 16:02:16.037076', 0, '2024-06-17 16:02:16.037076', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-17 16:02:15.958253');
INSERT INTO "public"."t_job_log" VALUES (807, '2024-06-17 16:35:34.734744', 0, '2024-06-17 16:35:34.734744', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-17 16:35:34.665436');
INSERT INTO "public"."t_job_log" VALUES (808, '2024-06-17 16:35:41.025172', 0, '2024-06-17 16:35:41.025172', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 16:35:39');
INSERT INTO "public"."t_job_log" VALUES (809, '2024-06-17 16:45:29.603149', 0, '2024-06-17 16:45:29.603149', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-17 16:45:29.533854');
INSERT INTO "public"."t_job_log" VALUES (810, '2024-06-17 20:00:01.602328', 0, '2024-06-17 20:00:01.602328', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (811, '2024-06-18 00:00:01.582821', 0, '2024-06-18 00:00:01.582821', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (812, '2024-06-18 04:00:02.880349', 0, '2024-06-18 04:00:02.880349', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (813, '2024-06-18 08:00:01.645068', 0, '2024-06-18 08:00:01.645068', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (815, '2024-06-18 16:00:01.707177', 0, '2024-06-18 16:00:01.707177', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (814, '2024-06-18 12:00:01.622409', 0, '2024-06-18 12:00:01.622409', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (816, '2024-06-18 16:02:52.609628', 0, '2024-06-18 16:02:52.609628', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-18 16:02:52.522013');
INSERT INTO "public"."t_job_log" VALUES (817, '2024-06-18 16:02:58.797993', 0, '2024-06-18 16:02:58.797993', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 16:02:57');
INSERT INTO "public"."t_job_log" VALUES (818, '2024-06-18 17:46:30.566878', 0, '2024-06-18 17:46:30.566878', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-18 17:46:30.508354');
INSERT INTO "public"."t_job_log" VALUES (819, '2024-06-18 17:46:37.376289', 0, '2024-06-18 17:46:37.376289', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 17:46:35');
INSERT INTO "public"."t_job_log" VALUES (820, '2024-06-18 20:00:02.134277', 0, '2024-06-18 20:00:02.134277', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (821, '2024-06-19 00:00:01.734097', 0, '2024-06-19 00:00:01.734097', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (822, '2024-06-19 03:44:45.884399', 0, '2024-06-19 03:44:45.884399', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-19 03:44:45.798581');
INSERT INTO "public"."t_job_log" VALUES (823, '2024-06-19 03:44:51.568964', 0, '2024-06-19 03:44:51.568964', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 03:44:50');
INSERT INTO "public"."t_job_log" VALUES (824, '2024-06-19 04:00:01.657719', 0, '2024-06-19 04:00:01.657719', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (825, '2024-06-19 08:00:06.113479', 0, '2024-06-19 08:00:06.113479', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (826, '2024-06-19 09:46:31.847209', 0, '2024-06-19 09:46:31.847209', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-19 09:46:31.775253');
INSERT INTO "public"."t_job_log" VALUES (827, '2024-06-19 09:46:40.657746', 0, '2024-06-19 09:46:40.657746', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 09:46:36');
INSERT INTO "public"."t_job_log" VALUES (828, '2024-06-19 09:51:15.27693', 0, '2024-06-19 09:51:15.27693', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-19 09:51:15.195294');
INSERT INTO "public"."t_job_log" VALUES (829, '2024-06-19 09:51:21.695216', 0, '2024-06-19 09:51:21.695216', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 09:51:20');
INSERT INTO "public"."t_job_log" VALUES (830, '2024-06-19 11:58:27.031107', 0, '2024-06-19 11:58:27.031107', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-19 11:58:26.952452');
INSERT INTO "public"."t_job_log" VALUES (831, '2024-06-19 11:58:32.623479', 0, '2024-06-19 11:58:32.623479', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 11:58:31');
INSERT INTO "public"."t_job_log" VALUES (832, '2024-06-19 12:00:01.513656', 0, '2024-06-19 12:00:01.513656', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (833, '2024-06-19 16:00:01.787593', 0, '2024-06-19 16:00:01.787593', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (834, '2024-06-19 20:00:01.581884', 0, '2024-06-19 20:00:01.581884', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (835, '2024-06-20 00:00:01.511389', 0, '2024-06-20 00:00:01.511389', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (836, '2024-06-20 03:07:12.974617', 0, '2024-06-20 03:07:12.974617', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-20 03:07:12.870189');
INSERT INTO "public"."t_job_log" VALUES (837, '2024-06-20 03:07:26.851203', 0, '2024-06-20 03:07:26.851203', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708"', NULL, 1, '2024-06-20 03:07:26.745528');
INSERT INTO "public"."t_job_log" VALUES (838, '2024-06-20 03:07:32.362547', 0, '2024-06-20 03:07:32.362547', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 03:07:31');
INSERT INTO "public"."t_job_log" VALUES (839, '2024-06-20 04:01:56.872141', 0, '2024-06-20 04:01:56.872141', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 04:01:56.784782');
INSERT INTO "public"."t_job_log" VALUES (840, '2024-06-20 04:02:01.521224', 0, '2024-06-20 04:02:01.521224', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File "/usr/local/lib/python3.8/site-packages/apscheduler/executors/base.py", line 125, in run_job
    retval = job.func(*job.args, **job.kwargs)
  File "/hipy/tasks/tv_spider.py", line 19, in main
    txt_files = [file for file in files if str(file[''name'']).endswith(''.txt'') and file[''type''] == ''file'']
  File "/hipy/tasks/tv_spider.py", line 19, in <listcomp>
    txt_files = [file for file in files if str(file[''name'']).endswith(''.txt'') and file[''type''] == ''file'']
', 'string indices must be integers', 0, '2024-06-20 04:02:01');
INSERT INTO "public"."t_job_log" VALUES (841, '2024-06-20 04:02:14.771497', 0, '2024-06-20 04:02:14.771497', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 04:02:14.689261');
INSERT INTO "public"."t_job_log" VALUES (868, '2024-06-21 08:12:24.50659', 0, '2024-06-21 08:12:24.50659', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 08:12:24.411199');
INSERT INTO "public"."t_job_log" VALUES (869, '2024-06-21 09:20:17.055473', 0, '2024-06-21 09:20:17.055473', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 09:20:16.96199');
INSERT INTO "public"."t_job_log" VALUES (842, '2024-06-20 04:02:19.443159', 0, '2024-06-20 04:02:19.443159', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File "/usr/local/lib/python3.8/site-packages/apscheduler/executors/base.py", line 125, in run_job
    retval = job.func(*job.args, **job.kwargs)
  File "/hipy/tasks/tv_spider.py", line 19, in main
    txt_files = [file for file in files if str(file[''name'']).endswith(''.txt'') and file[''type''] == ''file'']
  File "/hipy/tasks/tv_spider.py", line 19, in <listcomp>
    txt_files = [file for file in files if str(file[''name'']).endswith(''.txt'') and file[''type''] == ''file'']
', 'string indices must be integers', 0, '2024-06-20 04:02:19');
INSERT INTO "public"."t_job_log" VALUES (843, '2024-06-20 04:03:41.333031', 0, '2024-06-20 04:03:41.333031', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 04:03:41.260027');
INSERT INTO "public"."t_job_log" VALUES (844, '2024-06-20 04:03:46.425526', 0, '2024-06-20 04:03:46.425526', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File "/usr/local/lib/python3.8/site-packages/apscheduler/executors/base.py", line 125, in run_job
    retval = job.func(*job.args, **job.kwargs)
  File "/hipy/tasks/tv_spider.py", line 19, in main
    txt_files = [file for file in files if str(file[''name'']).endswith(''.txt'') and file[''type''] == ''file'']
  File "/hipy/tasks/tv_spider.py", line 19, in <listcomp>
    txt_files = [file for file in files if str(file[''name'']).endswith(''.txt'') and file[''type''] == ''file'']
', 'string indices must be integers', 0, '2024-06-20 04:03:46');
INSERT INTO "public"."t_job_log" VALUES (845, '2024-06-20 05:29:59.785982', 0, '2024-06-20 05:29:59.785982', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 05:29:59.712587');
INSERT INTO "public"."t_job_log" VALUES (846, '2024-06-20 05:30:06.396293', 0, '2024-06-20 05:30:06.396293', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 05:30:04');
INSERT INTO "public"."t_job_log" VALUES (847, '2024-06-20 05:52:29.080989', 0, '2024-06-20 05:52:29.080989', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 05:52:28.953965');
INSERT INTO "public"."t_job_log" VALUES (848, '2024-06-20 05:52:34.624264', 0, '2024-06-20 05:52:34.624264', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 05:52:33');
INSERT INTO "public"."t_job_log" VALUES (849, '2024-06-20 06:01:35.017189', 0, '2024-06-20 06:01:35.017189', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 06:01:34.922919');
INSERT INTO "public"."t_job_log" VALUES (850, '2024-06-20 06:01:40.57405', 0, '2024-06-20 06:01:40.57405', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 06:01:39');
INSERT INTO "public"."t_job_log" VALUES (851, '2024-06-20 08:00:01.621647', 0, '2024-06-20 08:00:01.621647', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (852, '2024-06-20 08:09:23.60236', 0, '2024-06-20 08:09:23.60236', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 08:09:23.537369');
INSERT INTO "public"."t_job_log" VALUES (853, '2024-06-20 08:09:29.641466', 0, '2024-06-20 08:09:29.641466', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 08:09:28');
INSERT INTO "public"."t_job_log" VALUES (854, '2024-06-20 08:33:44.407772', 0, '2024-06-20 08:33:44.407772', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 08:33:44.32175');
INSERT INTO "public"."t_job_log" VALUES (855, '2024-06-20 08:33:50.614775', 0, '2024-06-20 08:33:50.614775', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 08:33:49');
INSERT INTO "public"."t_job_log" VALUES (856, '2024-06-20 09:14:41.078104', 0, '2024-06-20 09:14:41.078104', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-20 09:14:41.005089');
INSERT INTO "public"."t_job_log" VALUES (857, '2024-06-20 09:14:47.654657', 0, '2024-06-20 09:14:47.654657', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 09:14:46');
INSERT INTO "public"."t_job_log" VALUES (858, '2024-06-20 12:00:01.601594', 0, '2024-06-20 12:00:01.601594', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (859, '2024-06-20 16:00:01.901094', 0, '2024-06-20 16:00:01.901094', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (860, '2024-06-20 20:00:01.531739', 0, '2024-06-20 20:00:01.531739', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (861, '2024-06-21 00:00:01.608078', 0, '2024-06-21 00:00:01.608078', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (862, '2024-06-21 03:08:01.492979', 0, '2024-06-21 03:08:01.492979', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 03:08:01.406292');
INSERT INTO "public"."t_job_log" VALUES (863, '2024-06-21 03:08:07.718416', 0, '2024-06-21 03:08:07.718416', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 03:08:06');
INSERT INTO "public"."t_job_log" VALUES (864, '2024-06-21 03:37:06.235053', 0, '2024-06-21 03:37:06.235053', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 03:37:06.156746');
INSERT INTO "public"."t_job_log" VALUES (865, '2024-06-21 03:37:12.638029', 0, '2024-06-21 03:37:12.638029', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 03:37:11');
INSERT INTO "public"."t_job_log" VALUES (866, '2024-06-21 04:00:01.573223', 0, '2024-06-21 04:00:01.573223', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (867, '2024-06-21 08:00:11.734771', 0, '2024-06-21 08:00:11.734771', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-21 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (870, '2024-06-21 09:20:24.051197', 0, '2024-06-21 09:20:24.051197', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 09:20:22');
INSERT INTO "public"."t_job_log" VALUES (871, '2024-06-21 09:37:57.585547', 0, '2024-06-21 09:37:57.585547', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 09:37:57.497819');
INSERT INTO "public"."t_job_log" VALUES (872, '2024-06-21 09:38:05.656847', 0, '2024-06-21 09:38:05.656847', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 09:38:02');
INSERT INTO "public"."t_job_log" VALUES (873, '2024-06-21 09:53:07.773303', 0, '2024-06-21 09:53:07.773303', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 09:53:07.690574');
INSERT INTO "public"."t_job_log" VALUES (874, '2024-06-21 09:53:13.707607', 0, '2024-06-21 09:53:13.707607', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 09:53:12');
INSERT INTO "public"."t_job_log" VALUES (875, '2024-06-21 10:10:41.962029', 0, '2024-06-21 10:10:41.962029', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 10:10:41.892592');
INSERT INTO "public"."t_job_log" VALUES (876, '2024-06-21 12:00:01.649175', 0, '2024-06-21 12:00:01.649175', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (877, '2024-06-21 16:00:02.744252', 0, '2024-06-21 16:00:02.744252', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (878, '2024-06-21 16:29:20.018061', 0, '2024-06-21 16:29:20.018061', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 16:29:19.935003');
INSERT INTO "public"."t_job_log" VALUES (879, '2024-06-21 18:04:25.219854', 0, '2024-06-21 18:04:25.219854', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-21 18:04:25.147591');
INSERT INTO "public"."t_job_log" VALUES (880, '2024-06-21 20:00:01.527206', 0, '2024-06-21 20:00:01.527206', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (881, '2024-06-22 00:00:01.596701', 0, '2024-06-22 00:00:01.596701', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (882, '2024-06-22 04:00:01.577504', 0, '2024-06-22 04:00:01.577504', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (883, '2024-06-22 08:00:02.772502', 0, '2024-06-22 08:00:02.772502', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (884, '2024-06-22 11:02:16.77103', 0, '2024-06-22 11:02:16.77103', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-22 11:02:16.695186');
INSERT INTO "public"."t_job_log" VALUES (885, '2024-06-22 12:00:01.735027', 0, '2024-06-22 12:00:01.735027', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (886, '2024-06-22 13:52:27.881181', 0, '2024-06-22 13:52:27.881181', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-22 13:52:27.859538');
INSERT INTO "public"."t_job_log" VALUES (887, '2024-06-22 13:52:28.792611', 0, '2024-06-22 13:52:28.792611', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 13:52:27');
INSERT INTO "public"."t_job_log" VALUES (888, '2024-06-22 14:19:59.217805', 0, '2024-06-22 14:19:59.217805', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-22 14:19:59.129117');
INSERT INTO "public"."t_job_log" VALUES (889, '2024-06-22 14:20:06.056677', 0, '2024-06-22 14:20:06.056677', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 14:20:04');
INSERT INTO "public"."t_job_log" VALUES (890, '2024-06-22 16:00:03.755962', 0, '2024-06-22 16:00:03.755962', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (891, '2024-06-22 20:00:02.581173', 0, '2024-06-22 20:00:02.581173', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (892, '2024-06-23 00:00:01.603579', 0, '2024-06-23 00:00:01.603579', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (893, '2024-06-23 04:00:01.616728', 0, '2024-06-23 04:00:01.616728', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (894, '2024-06-23 07:44:43.142071', 0, '2024-06-23 07:44:43.142071', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-23 07:44:43.058374');
INSERT INTO "public"."t_job_log" VALUES (895, '2024-06-23 07:44:49.811481', 0, '2024-06-23 07:44:49.811481', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 07:44:48');
INSERT INTO "public"."t_job_log" VALUES (896, '2024-06-23 08:00:02.167509', 0, '2024-06-23 08:00:02.167509', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (897, '2024-06-23 12:00:01.893782', 0, '2024-06-23 12:00:01.893782', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (898, '2024-06-23 16:00:03.069743', 0, '2024-06-23 16:00:03.069743', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (899, '2024-06-23 20:00:01.932325', 0, '2024-06-23 20:00:01.932325', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (900, '2024-06-24 00:00:01.65945', 0, '2024-06-24 00:00:01.65945', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (901, '2024-06-24 02:16:54.713648', 0, '2024-06-24 02:16:54.713648', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-24 02:16:54.594848');
INSERT INTO "public"."t_job_log" VALUES (902, '2024-06-24 02:17:00.709344', 0, '2024-06-24 02:17:00.709344', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 02:16:59');
INSERT INTO "public"."t_job_log" VALUES (903, '2024-06-24 03:44:01.570731', 0, '2024-06-24 03:44:01.570731', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-24 03:44:01.127718');
INSERT INTO "public"."t_job_log" VALUES (904, '2024-06-24 04:00:01.679736', 0, '2024-06-24 04:00:01.679736', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (905, '2024-06-24 07:41:58.884007', 0, '2024-06-24 07:41:58.884007', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-24 07:41:58.808667');
INSERT INTO "public"."t_job_log" VALUES (906, '2024-06-24 07:42:06.696401', 0, '2024-06-24 07:42:06.696401', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 07:42:03');
INSERT INTO "public"."t_job_log" VALUES (907, '2024-06-24 08:00:03.617015', 0, '2024-06-24 08:00:03.617015', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (908, '2024-06-24 12:00:01.651428', 0, '2024-06-24 12:00:01.651428', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (909, '2024-06-24 16:00:01.642173', 0, '2024-06-24 16:00:01.642173', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (910, '2024-06-24 20:00:01.749319', 0, '2024-06-24 20:00:01.749319', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (911, '2024-06-25 00:00:02.679412', 0, '2024-06-25 00:00:02.679412', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (912, '2024-06-25 04:00:01.70515', 0, '2024-06-25 04:00:01.70515', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (913, '2024-06-25 05:34:01.842147', 0, '2024-06-25 05:34:01.842147', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-25 05:34:01.748131');
INSERT INTO "public"."t_job_log" VALUES (914, '2024-06-25 05:34:07.844783', 0, '2024-06-25 05:34:07.844783', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 05:34:06');
INSERT INTO "public"."t_job_log" VALUES (915, '2024-06-25 08:00:01.576378', 0, '2024-06-25 08:00:01.576378', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (916, '2024-06-25 12:00:02.775309', 0, '2024-06-25 12:00:02.775309', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (917, '2024-06-25 16:00:09.234289', 0, '2024-06-25 16:00:09.234289', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-25 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (918, '2024-06-25 20:00:03.70031', 0, '2024-06-25 20:00:03.70031', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (919, '2024-06-26 00:00:01.70192', 0, '2024-06-26 00:00:01.70192', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (920, '2024-06-26 04:00:05.061073', 0, '2024-06-26 04:00:05.061073', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (921, '2024-06-26 08:00:01.646054', 0, '2024-06-26 08:00:01.646054', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (922, '2024-06-26 12:00:02.796888', 0, '2024-06-26 12:00:02.796888', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (923, '2024-06-26 16:00:01.641321', 0, '2024-06-26 16:00:01.641321', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (924, '2024-06-26 20:00:01.606547', 0, '2024-06-26 20:00:01.606547', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (925, '2024-06-27 00:00:01.548979', 0, '2024-06-27 00:00:01.548979', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (926, '2024-06-27 04:00:01.549271', 0, '2024-06-27 04:00:01.549271', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (927, '2024-06-27 06:14:23.135606', 0, '2024-06-27 06:14:23.135606', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-27 06:14:23.046576');
INSERT INTO "public"."t_job_log" VALUES (928, '2024-06-27 06:24:14.779511', 0, '2024-06-27 06:24:14.779511', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-27 06:24:14.693665');
INSERT INTO "public"."t_job_log" VALUES (929, '2024-06-27 06:24:20.631664', 0, '2024-06-27 06:24:20.631664', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 06:24:19');
INSERT INTO "public"."t_job_log" VALUES (930, '2024-06-27 06:37:36.764617', 0, '2024-06-27 06:37:36.764617', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-27 06:37:36.602325');
INSERT INTO "public"."t_job_log" VALUES (931, '2024-06-27 06:37:42.631257', 0, '2024-06-27 06:37:42.631257', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 06:37:41');
INSERT INTO "public"."t_job_log" VALUES (932, '2024-06-27 08:00:01.566036', 0, '2024-06-27 08:00:01.566036', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (933, '2024-06-27 09:50:14.263733', 0, '2024-06-27 09:50:14.263733', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-27 09:50:14.176442');
INSERT INTO "public"."t_job_log" VALUES (934, '2024-06-27 09:50:20.686652', 0, '2024-06-27 09:50:20.686652', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 09:50:19');
INSERT INTO "public"."t_job_log" VALUES (935, '2024-06-27 12:00:01.619376', 0, '2024-06-27 12:00:01.619376', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (936, '2024-06-27 12:52:23.120298', 0, '2024-06-27 12:52:23.120298', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-27 12:52:23.024298');
INSERT INTO "public"."t_job_log" VALUES (937, '2024-06-27 12:52:29.698138', 0, '2024-06-27 12:52:29.698138', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 12:52:28');
INSERT INTO "public"."t_job_log" VALUES (938, '2024-06-27 12:53:09.749489', 0, '2024-06-27 12:53:09.749489', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-27 12:53:09.663631');
INSERT INTO "public"."t_job_log" VALUES (939, '2024-06-27 12:53:15.607385', 0, '2024-06-27 12:53:15.607385', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 12:53:14');
INSERT INTO "public"."t_job_log" VALUES (940, '2024-06-27 12:58:09.291166', 0, '2024-06-27 12:58:09.291166', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-27 12:58:09.198353');
INSERT INTO "public"."t_job_log" VALUES (941, '2024-06-27 12:58:15.719092', 0, '2024-06-27 12:58:15.719092', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 12:58:14');
INSERT INTO "public"."t_job_log" VALUES (942, '2024-06-27 16:00:01.825418', 0, '2024-06-27 16:00:01.825418', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (943, '2024-06-27 20:00:01.859699', 0, '2024-06-27 20:00:01.859699', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (944, '2024-06-28 00:00:01.522917', 0, '2024-06-28 00:00:01.522917', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (945, '2024-06-28 03:59:46.33907', 0, '2024-06-28 03:59:46.33907', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 03:59:46.268867');
INSERT INTO "public"."t_job_log" VALUES (946, '2024-06-28 04:00:01.57214', 0, '2024-06-28 04:00:01.57214', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (947, '2024-06-28 07:24:55.908724', 0, '2024-06-28 07:24:55.908724', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 07:24:55.798929');
INSERT INTO "public"."t_job_log" VALUES (948, '2024-06-28 07:25:01.998966', 0, '2024-06-28 07:25:01.998966', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 07:25:00');
INSERT INTO "public"."t_job_log" VALUES (949, '2024-06-28 08:00:01.558746', 0, '2024-06-28 08:00:01.558746', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (950, '2024-06-28 08:22:21.293798', 0, '2024-06-28 08:22:21.293798', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 08:22:21.210102');
INSERT INTO "public"."t_job_log" VALUES (951, '2024-06-28 08:22:27.613073', 0, '2024-06-28 08:22:27.613073', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 08:22:26');
INSERT INTO "public"."t_job_log" VALUES (952, '2024-06-28 08:33:45.217063', 0, '2024-06-28 08:33:45.217063', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 08:33:45.123675');
INSERT INTO "public"."t_job_log" VALUES (953, '2024-06-28 08:33:56.276157', 0, '2024-06-28 08:33:56.276157', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 08:33:56.195848');
INSERT INTO "public"."t_job_log" VALUES (954, '2024-06-28 08:40:59.518717', 0, '2024-06-28 08:40:59.518717', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 08:40:59.445331');
INSERT INTO "public"."t_job_log" VALUES (955, '2024-06-28 11:25:46.325122', 0, '2024-06-28 11:25:46.325122', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 11:25:46.244793');
INSERT INTO "public"."t_job_log" VALUES (956, '2024-06-28 11:25:52.657534', 0, '2024-06-28 11:25:52.657534', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 11:25:51');
INSERT INTO "public"."t_job_log" VALUES (957, '2024-06-28 12:00:01.699488', 0, '2024-06-28 12:00:01.699488', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (958, '2024-06-28 16:00:02.662207', 0, '2024-06-28 16:00:02.662207', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (959, '2024-06-28 17:28:20.308088', 0, '2024-06-28 17:28:20.308088', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 17:28:20.249605');
INSERT INTO "public"."t_job_log" VALUES (960, '2024-06-28 17:28:26.62715', 0, '2024-06-28 17:28:26.62715', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 17:28:25');
INSERT INTO "public"."t_job_log" VALUES (961, '2024-06-28 17:36:32.503012', 0, '2024-06-28 17:36:32.503012', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-28 17:36:32.435572');
INSERT INTO "public"."t_job_log" VALUES (962, '2024-06-28 17:36:38.770767', 0, '2024-06-28 17:36:38.770767', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 17:36:37');
INSERT INTO "public"."t_job_log" VALUES (963, '2024-06-28 20:00:01.587911', 0, '2024-06-28 20:00:01.587911', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (964, '2024-06-29 00:00:01.540518', 0, '2024-06-29 00:00:01.540518', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (965, '2024-06-29 04:00:01.5632', 0, '2024-06-29 04:00:01.5632', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (966, '2024-06-29 08:00:01.991131', 0, '2024-06-29 08:00:01.991131', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (967, '2024-06-29 12:00:01.639598', 0, '2024-06-29 12:00:01.639598', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (968, '2024-06-29 16:00:01.656283', 0, '2024-06-29 16:00:01.656283', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (969, '2024-06-29 18:48:11.80228', 0, '2024-06-29 18:48:11.80228', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-29 18:48:11.74028');
INSERT INTO "public"."t_job_log" VALUES (970, '2024-06-29 20:00:01.668921', 0, '2024-06-29 20:00:01.668921', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (971, '2024-06-30 00:00:01.572357', 0, '2024-06-30 00:00:01.572357', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (972, '2024-06-30 01:54:26.26875', 0, '2024-06-30 01:54:26.26875', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-30 01:54:26.177075');
INSERT INTO "public"."t_job_log" VALUES (973, '2024-06-30 01:54:32.601405', 0, '2024-06-30 01:54:32.601405', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 01:54:31');
INSERT INTO "public"."t_job_log" VALUES (974, '2024-06-30 02:17:44.115434', 0, '2024-06-30 02:17:44.115434', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-30 02:17:44.047059');
INSERT INTO "public"."t_job_log" VALUES (975, '2024-06-30 02:17:50.639614', 0, '2024-06-30 02:17:50.639614', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 02:17:49');
INSERT INTO "public"."t_job_log" VALUES (976, '2024-06-30 04:00:01.5611', 0, '2024-06-30 04:00:01.5611', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (977, '2024-06-30 08:00:02.376818', 0, '2024-06-30 08:00:02.376818', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (978, '2024-06-30 11:28:07.626739', 0, '2024-06-30 11:28:07.626739', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-06-30 11:28:07.553221');
INSERT INTO "public"."t_job_log" VALUES (979, '2024-06-30 11:28:13.748175', 0, '2024-06-30 11:28:13.748175', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 11:28:12');
INSERT INTO "public"."t_job_log" VALUES (980, '2024-06-30 12:00:01.609087', 0, '2024-06-30 12:00:01.609087', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (981, '2024-06-30 16:00:01.679199', 0, '2024-06-30 16:00:01.679199', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (982, '2024-06-30 20:00:01.752856', 0, '2024-06-30 20:00:01.752856', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (983, '2024-07-01 00:00:01.662325', 0, '2024-07-01 00:00:01.662325', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (984, '2024-07-01 01:07:39.46735', 0, '2024-07-01 01:07:39.46735', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-01 01:07:39.394874');
INSERT INTO "public"."t_job_log" VALUES (985, '2024-07-01 01:07:45.582801', 0, '2024-07-01 01:07:45.582801', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 01:07:44');
INSERT INTO "public"."t_job_log" VALUES (986, '2024-07-01 02:14:18.360804', 0, '2024-07-01 02:14:18.360804', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-01 02:14:18.288032');
INSERT INTO "public"."t_job_log" VALUES (987, '2024-07-01 02:14:24.576098', 0, '2024-07-01 02:14:24.576098', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 02:14:23');
INSERT INTO "public"."t_job_log" VALUES (988, '2024-07-01 02:49:17.718303', 0, '2024-07-01 02:49:17.718303', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-01 02:49:17.65704');
INSERT INTO "public"."t_job_log" VALUES (989, '2024-07-01 03:04:23.320434', 0, '2024-07-01 03:04:23.320434', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-01 03:04:23.233602');
INSERT INTO "public"."t_job_log" VALUES (990, '2024-07-01 03:04:29.597138', 0, '2024-07-01 03:04:29.597138', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 03:04:28');
INSERT INTO "public"."t_job_log" VALUES (991, '2024-07-01 03:18:10.626694', 0, '2024-07-01 03:18:10.626694', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-01 03:18:10.551305');
INSERT INTO "public"."t_job_log" VALUES (992, '2024-07-01 03:18:16.595274', 0, '2024-07-01 03:18:16.595274', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 03:18:15');
INSERT INTO "public"."t_job_log" VALUES (993, '2024-07-01 04:00:01.56299', 0, '2024-07-01 04:00:01.56299', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (994, '2024-07-01 06:17:59.634048', 0, '2024-07-01 06:17:59.634048', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-01 06:17:59.569283');
INSERT INTO "public"."t_job_log" VALUES (995, '2024-07-01 06:18:07.405162', 0, '2024-07-01 06:18:07.405162', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 06:18:04');
INSERT INTO "public"."t_job_log" VALUES (996, '2024-07-01 08:00:01.646325', 0, '2024-07-01 08:00:01.646325', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (997, '2024-07-01 08:45:49.246176', 0, '2024-07-01 08:45:49.246176', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-01 08:45:49.169914');
INSERT INTO "public"."t_job_log" VALUES (998, '2024-07-01 12:00:01.586961', 0, '2024-07-01 12:00:01.586961', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (999, '2024-07-01 16:00:01.71125', 0, '2024-07-01 16:00:01.71125', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (1000, '2024-07-01 20:00:01.646336', 0, '2024-07-01 20:00:01.646336', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (1001, '2024-07-01 23:13:23.959717', 0, '2024-07-01 23:13:23.959717', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-01 23:13:23.895647');
INSERT INTO "public"."t_job_log" VALUES (1002, '2024-07-02 00:00:01.577731', 0, '2024-07-02 00:00:01.577731', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (1003, '2024-07-02 03:38:03.103954', 0, '2024-07-02 03:38:03.103954', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-02 03:38:03.015864');
INSERT INTO "public"."t_job_log" VALUES (1004, '2024-07-02 03:38:09.625088', 0, '2024-07-02 03:38:09.625088', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 03:38:08');
INSERT INTO "public"."t_job_log" VALUES (1005, '2024-07-02 04:00:01.547288', 0, '2024-07-02 04:00:01.547288', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (1006, '2024-07-02 08:00:01.616954', 0, '2024-07-02 08:00:01.616954', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (1007, '2024-07-02 09:16:31.661079', 0, '2024-07-02 09:16:31.661079', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-02 09:16:31.585232');
INSERT INTO "public"."t_job_log" VALUES (1008, '2024-07-02 12:00:01.615914', 0, '2024-07-02 12:00:01.615914', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (1009, '2024-07-02 16:00:02.684986', 0, '2024-07-02 16:00:02.684986', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (1010, '2024-07-02 20:00:01.588949', 0, '2024-07-02 20:00:01.588949', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (1011, '2024-07-03 00:00:01.588296', 0, '2024-07-03 00:00:01.588296', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (1012, '2024-07-03 03:39:54.340265', 0, '2024-07-03 03:39:54.340265', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-03 03:39:54.251199');
INSERT INTO "public"."t_job_log" VALUES (1013, '2024-07-03 03:40:00.624744', 0, '2024-07-03 03:40:00.624744', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 03:39:59');
INSERT INTO "public"."t_job_log" VALUES (1014, '2024-07-03 04:00:01.972678', 0, '2024-07-03 04:00:01.972678', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (1015, '2024-07-03 08:00:01.617601', 0, '2024-07-03 08:00:01.617601', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (1016, '2024-07-03 09:40:07.526981', 0, '2024-07-03 09:40:07.526981', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-03 09:40:07.444407');
INSERT INTO "public"."t_job_log" VALUES (1017, '2024-07-03 10:04:33.811147', 0, '2024-07-03 10:04:33.811147', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-03 10:04:33.740976');
INSERT INTO "public"."t_job_log" VALUES (1018, '2024-07-03 10:04:40.147411', 0, '2024-07-03 10:04:40.147411', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 10:04:38');
INSERT INTO "public"."t_job_log" VALUES (1019, '2024-07-03 12:00:02.004615', 0, '2024-07-03 12:00:02.004615', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (1020, '2024-07-03 16:00:01.692919', 0, '2024-07-03 16:00:01.692919', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (1021, '2024-07-03 20:00:01.583413', 0, '2024-07-03 20:00:01.583413', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (1022, '2024-07-04 00:00:01.559324', 0, '2024-07-04 00:00:01.559324', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (1023, '2024-07-04 04:00:01.708352', 0, '2024-07-04 04:00:01.708352', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (1024, '2024-07-04 07:36:24.101289', 0, '2024-07-04 07:36:24.101289', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-04 07:36:24.031298');
INSERT INTO "public"."t_job_log" VALUES (1025, '2024-07-04 07:36:30.620037', 0, '2024-07-04 07:36:30.620037', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 07:36:29');
INSERT INTO "public"."t_job_log" VALUES (1026, '2024-07-04 08:00:01.57008', 0, '2024-07-04 08:00:01.57008', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (1027, '2024-07-04 08:13:05.434939', 0, '2024-07-04 08:13:05.434939', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-04 08:13:05.32429');
INSERT INTO "public"."t_job_log" VALUES (1028, '2024-07-04 08:13:12.524992', 0, '2024-07-04 08:13:12.524992', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 08:13:10');
INSERT INTO "public"."t_job_log" VALUES (1029, '2024-07-04 12:00:01.598359', 0, '2024-07-04 12:00:01.598359', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (1030, '2024-07-04 16:00:02.398778', 0, '2024-07-04 16:00:02.398778', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (1031, '2024-07-04 20:00:01.601977', 0, '2024-07-04 20:00:01.601977', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (1032, '2024-07-05 00:00:02.320709', 0, '2024-07-05 00:00:02.320709', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (1033, '2024-07-05 03:42:28.665655', 0, '2024-07-05 03:42:28.665655', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-05 03:42:28.582645');
INSERT INTO "public"."t_job_log" VALUES (1034, '2024-07-05 03:48:55.35474', 0, '2024-07-05 03:48:55.35474', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-05 03:48:55.273107');
INSERT INTO "public"."t_job_log" VALUES (1035, '2024-07-05 03:49:01.604105', 0, '2024-07-05 03:49:01.604105', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 03:49:00');
INSERT INTO "public"."t_job_log" VALUES (1036, '2024-07-05 04:00:01.604749', 0, '2024-07-05 04:00:01.604749', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (1037, '2024-07-05 08:00:01.583482', 0, '2024-07-05 08:00:01.583482', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 08:00:00');
INSERT INTO "public"."t_job_log" VALUES (1038, '2024-07-05 10:04:50.968279', 0, '2024-07-05 10:04:50.968279', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-05 10:04:50.898851');
INSERT INTO "public"."t_job_log" VALUES (1039, '2024-07-05 12:00:01.646585', 0, '2024-07-05 12:00:01.646585', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 12:00:00');
INSERT INTO "public"."t_job_log" VALUES (1040, '2024-07-05 13:59:56.99604', 0, '2024-07-05 13:59:56.99604', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-05 13:59:56.904355');
INSERT INTO "public"."t_job_log" VALUES (1041, '2024-07-05 14:00:02.799729', 0, '2024-07-05 14:00:02.799729', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 14:00:01');
INSERT INTO "public"."t_job_log" VALUES (1042, '2024-07-05 15:16:02.305774', 0, '2024-07-05 15:16:02.305774', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-05 15:16:02.232344');
INSERT INTO "public"."t_job_log" VALUES (1043, '2024-07-05 15:16:08.582847', 0, '2024-07-05 15:16:08.582847', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 15:16:07');
INSERT INTO "public"."t_job_log" VALUES (1044, '2024-07-05 15:23:10.656151', 0, '2024-07-05 15:23:10.656151', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-05 15:23:10.577168');
INSERT INTO "public"."t_job_log" VALUES (1045, '2024-07-05 15:23:16.755132', 0, '2024-07-05 15:23:16.755132', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 15:23:15');
INSERT INTO "public"."t_job_log" VALUES (1046, '2024-07-05 16:00:02.023738', 0, '2024-07-05 16:00:02.023738', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 16:00:00');
INSERT INTO "public"."t_job_log" VALUES (1047, '2024-07-05 20:00:01.619857', 0, '2024-07-05 20:00:01.619857', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 20:00:00');
INSERT INTO "public"."t_job_log" VALUES (1048, '2024-07-05 22:54:14.346174', 0, '2024-07-05 22:54:14.346174', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-05 22:54:14.291403');
INSERT INTO "public"."t_job_log" VALUES (1049, '2024-07-05 22:54:20.712299', 0, '2024-07-05 22:54:20.712299', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:454本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 22:54:19');
INSERT INTO "public"."t_job_log" VALUES (1050, '2024-07-06 00:00:01.587566', 0, '2024-07-06 00:00:01.587566', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:454本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-06 00:00:00');
INSERT INTO "public"."t_job_log" VALUES (1051, '2024-07-06 00:15:08.243204', 0, '2024-07-06 00:15:08.243204', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-06 00:15:08.163414');
INSERT INTO "public"."t_job_log" VALUES (1052, '2024-07-06 00:15:14.575976', 0, '2024-07-06 00:15:14.575976', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:454本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-06 00:15:13');
INSERT INTO "public"."t_job_log" VALUES (1053, '2024-07-06 04:00:01.596838', 0, '2024-07-06 04:00:01.596838', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:454本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-06 04:00:00');
INSERT INTO "public"."t_job_log" VALUES (1054, '2024-07-06 07:52:11.43211', 0, '2024-07-06 07:52:11.43211', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-06 07:52:11.350683');
INSERT INTO "public"."t_job_log" VALUES (1055, '2024-07-11 04:24:44.356008', 0, '2024-07-11 04:24:44.356008', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-11 04:24:44.249179');
INSERT INTO "public"."t_job_log" VALUES (1056, '2024-07-13 13:28:48.75602', 0, '2024-07-13 13:28:48.75602', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-13 13:28:48.718606');
INSERT INTO "public"."t_job_log" VALUES (1057, '2024-07-13 13:28:51.489264', 0, '2024-07-13 13:28:51.489264', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:472本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-13 13:28:48');
INSERT INTO "public"."t_job_log" VALUES (1058, '2024-07-13 13:30:38.374661', 0, '2024-07-13 13:30:38.374661', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-13 13:30:38.290478');
INSERT INTO "public"."t_job_log" VALUES (1059, '2024-07-17 12:33:19.335402', 0, '2024-07-17 12:33:19.335402', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-17 12:33:19.269639');
INSERT INTO "public"."t_job_log" VALUES (1060, '2024-07-17 12:59:26.281071', 0, '2024-07-17 12:59:26.281071', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-17 12:59:26.248602');
INSERT INTO "public"."t_job_log" VALUES (1061, '2024-07-18 02:44:45.636203', 0, '2024-07-18 02:44:45.636203', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-18 02:44:45.597648');
INSERT INTO "public"."t_job_log" VALUES (1062, '2024-07-21 04:09:28.137132', 0, '2024-07-21 04:09:28.137132', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-21 04:09:28.081845');
INSERT INTO "public"."t_job_log" VALUES (1063, '2024-07-21 07:50:10.924738', 0, '2024-07-21 07:50:10.924738', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708"', NULL, 1, '2024-07-21 07:50:10.692611');
INSERT INTO "public"."t_job_log" VALUES (1064, '2024-07-21 07:50:12.883061', 0, '2024-07-21 07:50:12.883061', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:471本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-21 07:50:10');

-- ----------------------------
-- Table structure for t_login_infor
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_login_infor";
CREATE TABLE "public"."t_login_infor" (
  "id" int4 NOT NULL DEFAULT nextval('t_login_infor_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "user_name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "ipaddr" varchar(256) COLLATE "pg_catalog"."default",
  "login_location" varchar(256) COLLATE "pg_catalog"."default",
  "browser" varchar(256) COLLATE "pg_catalog"."default",
  "os" varchar(256) COLLATE "pg_catalog"."default",
  "status" int4 DEFAULT 0,
  "msg" varchar(256) COLLATE "pg_catalog"."default",
  "login_time" timestamp(6) DEFAULT now()
)
;
COMMENT ON COLUMN "public"."t_login_infor"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_login_infor"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_login_infor"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_login_infor"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_login_infor"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_login_infor"."user_name" IS '用户名称';
COMMENT ON COLUMN "public"."t_login_infor"."ipaddr" IS '登录地址';
COMMENT ON COLUMN "public"."t_login_infor"."login_location" IS '登录地点';
COMMENT ON COLUMN "public"."t_login_infor"."browser" IS '浏览器';
COMMENT ON COLUMN "public"."t_login_infor"."os" IS '操作系统';
COMMENT ON COLUMN "public"."t_login_infor"."status" IS '登录状态';
COMMENT ON COLUMN "public"."t_login_infor"."msg" IS '操作信息';
COMMENT ON COLUMN "public"."t_login_infor"."login_time" IS '登录日期';

-- ----------------------------
-- Records of t_login_infor
-- ----------------------------
INSERT INTO "public"."t_login_infor" VALUES (1, '2024-07-17 12:40:11.265834', 0, '2024-07-17 12:40:11.265834', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-17 12:40:11.265834');
INSERT INTO "public"."t_login_infor" VALUES (2, '2024-07-21 06:28:29.841578', 0, '2024-07-21 06:28:29.841578', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 06:28:29.841578');
INSERT INTO "public"."t_login_infor" VALUES (3, '2024-07-21 07:04:08.517884', 0, '2024-07-21 07:04:08.517884', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:04:08.517884');
INSERT INTO "public"."t_login_infor" VALUES (4, '2024-07-21 07:07:52.748589', 0, '2024-07-21 07:07:52.748589', 0, 0, 'hjdhnx', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:07:52.748589');
INSERT INTO "public"."t_login_infor" VALUES (5, '2024-07-21 07:14:19.326917', 0, '2024-07-21 07:14:19.326917', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:14:19.326917');
INSERT INTO "public"."t_login_infor" VALUES (6, '2024-07-21 07:14:34.29844', 0, '2024-07-21 07:14:34.29844', 0, 0, 'hjdhnx', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:14:34.29844');
INSERT INTO "public"."t_login_infor" VALUES (7, '2024-07-21 07:30:42.073277', 0, '2024-07-21 07:30:42.073277', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:30:42.073277');
INSERT INTO "public"."t_login_infor" VALUES (8, '2024-07-21 07:32:46.502615', 0, '2024-07-21 07:32:46.502615', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:32:46.502615');
INSERT INTO "public"."t_login_infor" VALUES (9, '2024-07-21 07:33:46.776439', 0, '2024-07-21 07:33:46.776439', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:33:46.776439');
INSERT INTO "public"."t_login_infor" VALUES (10, '2024-07-21 07:36:04.015579', 0, '2024-07-21 07:36:04.015579', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:36:04.015579');
INSERT INTO "public"."t_login_infor" VALUES (11, '2024-07-21 07:36:54.961758', 0, '2024-07-21 07:36:54.961758', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:36:54.961758');
INSERT INTO "public"."t_login_infor" VALUES (12, '2024-07-21 07:43:00.365038', 0, '2024-07-21 07:43:00.365038', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:43:00.365038');
INSERT INTO "public"."t_login_infor" VALUES (13, '2024-07-21 07:43:41.730074', 0, '2024-07-21 07:43:41.730074', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:43:41.730074');
INSERT INTO "public"."t_login_infor" VALUES (14, '2024-07-21 07:43:58.942074', 0, '2024-07-21 07:43:58.942074', 0, 0, 'hjdhnx', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:43:58.942074');
INSERT INTO "public"."t_login_infor" VALUES (15, '2024-07-21 07:45:11.036047', 0, '2024-07-21 07:45:11.036047', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:45:11.036047');

-- ----------------------------
-- Table structure for t_menus
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_menus";
CREATE TABLE "public"."t_menus" (
  "id" int4 NOT NULL DEFAULT nextval('t_menus_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "path" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "component" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "is_frame" bool DEFAULT false,
  "hidden" bool DEFAULT false,
  "status" int4 DEFAULT 0,
  "order_num" int4 DEFAULT 0,
  "name" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "title" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "icon" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "no_cache" bool DEFAULT false,
  "parent_id" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."t_menus"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_menus"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_menus"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_menus"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_menus"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_menus"."path" IS '路由';
COMMENT ON COLUMN "public"."t_menus"."component" IS '组件';
COMMENT ON COLUMN "public"."t_menus"."is_frame" IS '是否外链';
COMMENT ON COLUMN "public"."t_menus"."hidden" IS '是否隐藏';
COMMENT ON COLUMN "public"."t_menus"."status" IS '菜单状态';
COMMENT ON COLUMN "public"."t_menus"."order_num" IS '显示排序';
COMMENT ON COLUMN "public"."t_menus"."name" IS '唯一标识用于页面缓存，否则keep-alive会出问题';
COMMENT ON COLUMN "public"."t_menus"."title" IS '标题';
COMMENT ON COLUMN "public"."t_menus"."icon" IS '图标';
COMMENT ON COLUMN "public"."t_menus"."no_cache" IS '是否缓存';
COMMENT ON COLUMN "public"."t_menus"."parent_id" IS '上级菜单';

-- ----------------------------
-- Records of t_menus
-- ----------------------------
INSERT INTO "public"."t_menus" VALUES (1, '2022-07-14 03:56:19', 0, '2022-07-19 15:40:51', 0, 0, 'role', '/permission/role/index', 'f', 'f', 0, 3, 'PermissionRole', '角色管理', 'peoples', 't', 7);
INSERT INTO "public"."t_menus" VALUES (2, '2022-07-14 03:56:19', 0, '2022-07-20 10:25:17', 0, 0, '/system', '', 'f', 'f', 0, 2, '', '系统管理', 'system', 'f', 0);
INSERT INTO "public"."t_menus" VALUES (3, '2022-07-14 03:56:19', 0, '2022-07-19 16:03:40', 0, 0, 'menu', '/permission/menu/index', 'f', 'f', 0, 2, 'PermissionMenu', '菜单管理', 'tree-table', 'f', 7);
INSERT INTO "public"."t_menus" VALUES (4, '2022-07-14 03:56:19', 0, '2022-07-14 03:56:19', 0, 0, 'dict', '/system/dict/index', 'f', 'f', 0, 4, 'SystemDictType', '字典管理', 'dict', 'f', 2);
INSERT INTO "public"."t_menus" VALUES (5, '2022-07-14 03:56:19', 0, '2022-07-14 03:56:19', 0, 0, 'parameter', '/system/parameter/index', 'f', 'f', 0, 3, 'SystemParameter', '参数管理', 'tree', 'f', 2);
INSERT INTO "public"."t_menus" VALUES (6, '2022-07-14 03:56:19', 0, '2022-07-19 16:03:33', 0, 0, 'user', '/permission/user/index', 'f', 'f', 0, 1, 'PermissionUser', '用户管理', 'user', 'f', 7);
INSERT INTO "public"."t_menus" VALUES (7, '2022-07-14 03:56:19', 0, '2022-07-20 10:25:24', 0, 0, '/permission', '', 'f', 'f', 0, 1, '', '权限管理', 'monitor', 'f', 0);
INSERT INTO "public"."t_menus" VALUES (8, '2022-07-14 03:56:19', 0, '2022-07-14 03:56:19', 0, 0, 'dict/detail/:id(\d+)', '/system/dict/detail/index', 'f', 't', 0, 1, 'SystemDictDetail', '字典参数', 'dashboard', 'f', 2);
INSERT INTO "public"."t_menus" VALUES (9, '2022-10-29 23:57:16', 0, '2022-10-29 23:57:16', 0, 0, 'label', '/permission/label/index', 'f', 'f', 0, 4, 'PermissionLabel', '权限标签', 'icon', 't', 7);
INSERT INTO "public"."t_menus" VALUES (11, '2023-12-02 18:06:51', 0, '2023-12-07 22:10:46', 1, 0, 'developer', '/hiker/developer/index', 'f', 'f', 0, 1, 'HikerDeveloper', '开发者', 'peoples', 't', 10);
INSERT INTO "public"."t_menus" VALUES (10, '2023-12-02 18:05:43', 0, '2023-12-02 18:05:43', 0, 0, '/hiker', '', 'f', 'f', 0, 3, '', '海阔视界', 'international', 't', 0);
INSERT INTO "public"."t_menus" VALUES (12, '2023-12-02 23:23:55', 1, '2023-12-07 22:10:55', 1, 0, 'rule_type', '/hiker/rule_type/index', 'f', 'f', 0, 2, 'HikerRuleType', '规则类型', 'component', 't', 10);
INSERT INTO "public"."t_menus" VALUES (13, '2023-12-03 19:03:50', 1, '2023-12-07 22:11:07', 1, 0, 'rule', '/hiker/rule/index', 'f', 'f', 0, 3, 'HikerRule', '规则', 'list', 't', 10);
INSERT INTO "public"."t_menus" VALUES (14, '2023-12-04 21:49:25', 1, '2023-12-04 21:49:25', 0, 0, 'control_panel', '/control_panel/index', 'f', 'f', 0, 4, 'ControlPanel', '控制面板', 'swagger', 't', 2);
INSERT INTO "public"."t_menus" VALUES (15, '2023-12-05 08:49:37', 1, '2023-12-05 08:50:03', 1, 0, '/tool', '', 'f', 'f', 0, 4, '', '工具', 'bug', 't', 0);
INSERT INTO "public"."t_menus" VALUES (16, '2023-12-05 08:51:06', 1, '2023-12-05 08:52:00', 1, 0, 'swagger', '/tool/swagger/index', 'f', 'f', 0, 1, 'Swagger', 'swagger', 'swagger', 't', 15);
INSERT INTO "public"."t_menus" VALUES (17, '2023-12-05 09:08:13', 1, '2023-12-06 22:50:59', 1, 0, '/monitor', '', 'f', 'f', 0, 4, '', '系统监控', 'monitor', 't', 0);
INSERT INTO "public"."t_menus" VALUES (18, '2023-12-05 09:09:57', 1, '2023-12-07 00:03:28', 1, 0, 'job', '/monitor/job/index', 'f', 'f', 0, 2, 'Job', '定时任务', 'time-range', 't', 17);
INSERT INTO "public"."t_menus" VALUES (19, '2023-12-05 09:11:12', 1, '2023-12-07 00:03:23', 1, 0, 'server', '/monitor/server/index', 'f', 'f', 0, 1, 'Server', '服务监控', 'server', 't', 17);
INSERT INTO "public"."t_menus" VALUES (20, '2023-12-06 22:49:09', 1, '2023-12-06 22:49:09', 0, 0, 'blog', '/tool/blog/index', 'f', 'f', 0, 2, 'Blog', '博客', 'log', 't', 15);
INSERT INTO "public"."t_menus" VALUES (21, '2023-12-06 22:53:25', 1, '2023-12-15 00:17:28', 1, 0, 'online', '/monitor/online/index', 'f', 't', 0, 6, 'Online', '在线用户', 'online', 't', 17);
INSERT INTO "public"."t_menus" VALUES (22, '2023-12-06 22:55:02', 1, '2023-12-15 00:17:17', 1, 0, 'cache', ' /monitor/cache/index', 'f', 't', 0, 5, '', '缓存监控', 'redis', 't', 17);
INSERT INTO "public"."t_menus" VALUES (23, '2023-12-06 22:56:00', 1, '2023-12-15 00:17:23', 1, 0, 'cacheList', '/monitor/cache/list', 'f', 'f', 0, 5, 'cacheList', '缓存列表', 'redis-list', 't', 17);
INSERT INTO "public"."t_menus" VALUES (24, '2023-12-06 23:22:16', 1, '2023-12-06 23:22:16', 0, 0, 'icons', '/components/icons/index', 'f', 'f', 0, 3, 'Icons', '图标组件', 'icon', 't', 15);
INSERT INTO "public"."t_menus" VALUES (25, '2023-12-06 23:33:18', 1, '2023-12-06 23:37:20', 1, 0, 'build', '/tool/build/index', 'f', 'f', 0, 1, 'Build', '表单构建', 'build', 't', 15);
INSERT INTO "public"."t_menus" VALUES (26, '2023-12-07 22:06:50', 1, '2023-12-07 22:16:07', 1, 0, 'developer/:id(\d+)', '/hiker/developer/index', 'f', 't', 0, 1, 'DeveloperDetail', '开发者详情', 'peoples', 't', 10);
INSERT INTO "public"."t_menus" VALUES (27, '2023-12-07 22:09:16', 1, '2023-12-07 22:16:02', 1, 0, 'rule_type/:id(\d+)', '/hiker/rule_type/index', 'f', 't', 0, 2, 'RuleTypeDetail', '规则类型详情', 'component', 't', 10);
INSERT INTO "public"."t_menus" VALUES (28, '2023-12-07 22:56:42', 1, '2023-12-15 00:16:45', 1, 0, 'logininfor', '/monitor/logininfor/index', 'f', 'f', 0, 3, 'LoginInfor', '登录日志', 'people', 't', 17);
INSERT INTO "public"."t_menus" VALUES (29, '2023-12-11 20:39:10', 1, '2023-12-11 20:42:25', 1, 1, 'control_panel1', '/hello', 'f', 'f', 0, 1, '', 'hello world', 'clipboard', 't', 7);
INSERT INTO "public"."t_menus" VALUES (30, '2023-12-13 22:44:56', 1, '2023-12-15 00:16:50', 1, 0, 'pip', '/monitor/pip/index', 'f', 'f', 0, 4, 'Pip', '依赖管理', 'list', 't', 17);
INSERT INTO "public"."t_menus" VALUES (31, '2023-12-15 00:11:11', 1, '2023-12-15 00:17:03', 1, 0, 'job-log/:id(\d+)', '/monitor/job/log', 'f', 't', 0, 2, 'JobLog', '定时任务执行日志', 'log', 't', 17);
INSERT INTO "public"."t_menus" VALUES (32, '2023-12-15 00:36:18', 1, '2023-12-15 00:36:18', 0, 0, 'xfgpt', '/tool/xfgpt/index', 'f', 'f', 0, 4, 'XfGpt', '讯飞GPT', 'example', 't', 15);
INSERT INTO "public"."t_menus" VALUES (34, '2024-01-14 16:22:36.889797', 1, '2024-01-14 16:22:53.497814', 1, 0, '/vod', '', 'f', 'f', 0, 3, '', 'hipy源', 'education', 't', 0);
INSERT INTO "public"."t_menus" VALUES (35, '2024-01-14 16:23:36.380029', 1, '2024-01-14 16:24:07.355086', 1, 0, 'rules', '/vod/rules/index', 'f', 'f', 0, 1, 'VodRules', '源管理', 'list', 't', 34);
INSERT INTO "public"."t_menus" VALUES (41, '2024-02-27 16:24:14.004865', 1, '2024-02-27 16:24:14.004865', 0, 0, 'index', '/vod/web/home/category', 'f', 't', 0, 1, 'VodWebIndex', 'CMS首页', 'international', 't', 39);
INSERT INTO "public"."t_menus" VALUES (42, '2024-02-27 16:24:59.465788', 1, '2024-02-27 16:24:59.465788', 0, 0, 'category', '/vod/web/home/category', 'f', 't', 0, 2, 'VodWebCategory', 'CMS分类页', 'nested', 't', 39);
INSERT INTO "public"."t_menus" VALUES (43, '2024-02-27 16:25:29.078335', 1, '2024-02-27 16:25:29.078335', 0, 0, 'detail', '/vod/web/home/detail', 'f', 't', 0, 3, 'VodWebDetail', 'CMS详情页', 'form', 't', 39);
INSERT INTO "public"."t_menus" VALUES (40, '2024-02-21 17:46:55.221369', 1, '2024-02-27 16:25:55.403831', 1, 0, 'search', '/vod/web/home/search', 'f', 't', 0, 4, 'VodWebSearch', 'CMS搜索页', 'search', 't', 39);
INSERT INTO "public"."t_menus" VALUES (44, '2024-06-19 09:52:46.034162', 1, '2024-06-19 09:52:46.034162', 0, 0, 'subs', '/vod/subs/index', 'f', 'f', 0, 2, 'VodSubs', '订阅管理', 'chart', 't', 34);
INSERT INTO "public"."t_menus" VALUES (36, '2024-01-14 16:44:59.020793', 1, '2024-06-19 09:52:55.717516', 1, 0, 'configs', '/vod/configs/index', 'f', 'f', 0, 3, 'VodConfigs', '配置中心', 'table', 't', 34);
INSERT INTO "public"."t_menus" VALUES (37, '2024-01-21 08:39:35.602841', 1, '2024-06-19 09:52:59.28837', 1, 0, 'rules_edit/:id(\d+)', '/vod/rules/edit', 'f', 't', 0, 4, 'VodRulesEdit', '在线编辑源', 'code', 't', 34);
INSERT INTO "public"."t_menus" VALUES (38, '2024-02-19 13:58:41.826335', 1, '2024-06-19 09:53:08.519928', 1, 0, 'houses', '/vod/houses/index', 'f', 'f', 0, 5, 'VodHouses', '源仓库', 'shopping', 't', 34);
INSERT INTO "public"."t_menus" VALUES (39, '2024-02-21 17:21:06.123879', 1, '2024-06-19 09:53:12.201774', 1, 0, 'web', '/vod/web/index', 'f', 'f', 0, 6, 'VodWeb', '在线预览', 'international', 't', 34);
INSERT INTO "public"."t_menus" VALUES (45, '2024-07-06 00:16:58.3738', 1, '2024-07-06 00:16:58.3738', 0, 0, 'liveTool', '/tool/liveTool/index', 'f', 'f', 0, 10, 'liveTool', '直播工具', 'form', 't', 34);

-- ----------------------------
-- Table structure for t_perm_label
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_perm_label";
CREATE TABLE "public"."t_perm_label" (
  "id" int4 NOT NULL DEFAULT nextval('t_perm_label_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "label" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "remark" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."t_perm_label"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_perm_label"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_perm_label"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_perm_label"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_perm_label"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_perm_label"."label" IS '标签';
COMMENT ON COLUMN "public"."t_perm_label"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_perm_label"."status" IS '状态';

-- ----------------------------
-- Records of t_perm_label
-- ----------------------------
INSERT INTO "public"."t_perm_label" VALUES (4, '2023-12-02 15:33:26', 0, '2023-12-02 15:33:26', 0, 0, 'perm:user:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (5, '2023-12-02 15:36:42', 0, '2023-12-02 15:36:42', 0, 0, 'perm:user:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (11, '2023-12-02 18:00:37', 0, '2023-12-02 18:00:37', 0, 0, 'hiker:developer:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (12, '2023-12-02 18:05:43', 0, '2023-12-02 18:05:43', 0, 0, 'perm:menu:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (13, '2023-12-02 18:08:24', 0, '2023-12-02 18:08:24', 0, 0, 'perm:menu:gut', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (14, '2023-12-02 18:09:28', 0, '2023-12-02 18:09:28', 0, 0, 'perm:menu:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (15, '2023-12-02 19:15:42', 0, '2023-12-02 19:15:42', 0, 0, 'hiker:developer:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (21, '2023-12-04 19:55:50', 0, '2023-12-04 19:55:50', 0, 0, 'hiker:rule_type:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (22, '2023-12-04 20:00:34', 0, '2023-12-04 20:00:34', 0, 0, 'hiker:rule:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (23, '2023-12-04 20:00:59', 0, '2023-12-04 20:00:59', 0, 0, 'hiker:rule:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (25, '2023-12-05 19:44:23', 0, '2023-12-05 19:44:23', 0, 0, 'monitor:server:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (27, '2023-12-05 22:52:40', 0, '2023-12-05 22:52:40', 0, 0, 'hiker:rule_type:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (28, '2023-12-05 22:52:46', 0, '2023-12-05 22:52:46', 0, 0, 'hiker:rule_type:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (29, '2023-12-07 00:00:33', 0, '2023-12-07 00:00:33', 0, 0, 'perm:user:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (31, '2023-12-07 21:39:27', 0, '2023-12-07 21:39:27', 0, 0, 'report:excel_generate:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (32, '2023-12-09 02:27:25', 0, '2023-12-09 02:27:25', 0, 0, 'system:config_setting:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (33, '2023-12-09 16:20:03', 0, '2023-12-09 16:20:03', 0, 0, 'monitor:logininfor:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (34, '2023-12-09 16:50:10', 0, '2023-12-09 16:50:10', 0, 0, 'hiker:developer:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (35, '2023-12-09 16:54:11', 0, '2023-12-09 16:54:11', 0, 0, 'hiker:rule:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (36, '2023-12-10 17:41:10', 0, '2023-12-10 17:41:10', 0, 0, 'monitor:job:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (37, '2023-12-10 18:16:32', 0, '2023-12-10 18:16:32', 0, 0, 'monitor:job:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (38, '2023-12-10 18:25:10', 0, '2023-12-10 18:25:10', 0, 0, 'monitor:job:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (39, '2023-12-11 20:42:25', 0, '2023-12-11 20:42:25', 0, 0, 'perm:menu:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (41, '2023-12-13 23:12:13', 0, '2023-12-13 23:12:13', 0, 0, 'monitor:pip:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (42, '2023-12-13 23:21:20', 0, '2023-12-13 23:21:20', 0, 0, 'monitor:pip:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (43, '2023-12-13 23:28:11', 0, '2023-12-13 23:28:11', 0, 0, 'monitor:pip:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (44, '2023-12-16 11:36:07', 0, '2023-12-16 11:36:07', 0, 0, 'perm:role:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (45, '2023-12-16 11:38:40', 0, '2023-12-16 11:38:40', 0, 0, 'perm:label:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (46, '2023-12-16 12:28:44', 0, '2023-12-16 12:28:44', 0, 0, 'report:excel_generate:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (47, '2023-12-17 14:13:25', 0, '2023-12-17 14:45:14', 1, 1, 'report:excel_generate:exports', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (48, '2023-12-17 14:38:50', 0, '2023-12-17 14:44:57', 1, 1, 'system_user:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (49, '2023-12-17 14:44:45', 0, '2023-12-17 14:44:45', 0, 0, 'perm:user:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (50, '2023-12-17 14:44:57', 0, '2023-12-17 14:44:57', 0, 0, 'perm:label:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (54, '2023-12-17 16:47:58', 0, '2023-12-17 16:47:58', 0, 0, 'monitor:cache:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (55, '2024-01-02 20:24:36', 0, '2024-01-02 20:24:36', 0, 0, 'system:user:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (56, '2024-01-06 12:37:09', 0, '2024-01-06 12:37:09', 0, 0, 'monitor:job-log:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (57, '2024-01-06 13:24:14', 0, '2024-01-06 13:24:14', 0, 0, '/monitor/jobLog/export:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (58, '2024-01-06 13:36:05', 0, '2024-01-06 13:36:05', 0, 0, 'monitor:job:log:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (72, '2024-06-19 09:53:59.733701', 0, '2024-06-19 09:53:59.733701', 0, 0, 'vod:subs:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (73, '2024-06-19 10:06:39.924957', 0, '2024-06-19 10:06:39.924957', 0, 0, 'vod:subs:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (74, '2024-06-25 15:13:01.9195', 0, '2024-06-25 15:13:01.9195', 0, 0, 'vod:subs:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (30, '2023-12-07 19:50:07', 0, '2024-07-21 07:42:32.156802', 1, 0, 'report:excel_generate:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (71, '2024-02-19 16:30:39.854378', 0, '2024-07-21 07:16:19.269607', 1, 0, 'vod:houses:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (70, '2024-02-19 15:22:23.097785', 0, '2024-07-21 07:16:16.388379', 1, 0, 'vod:houses:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (60, '2024-01-14 16:38:44.050973', 0, '2024-07-21 07:17:29.409656', 1, 0, 'vod:rules:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (61, '2024-01-14 17:26:01.12343', 0, '2024-07-21 07:17:34.098611', 1, 0, 'vod:rules:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (63, '2024-01-15 17:03:56.811658', 0, '2024-07-21 07:17:38.567518', 1, 0, 'vod:rules:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (62, '2024-01-14 17:48:29.445349', 0, '2024-07-21 07:17:57.391119', 1, 0, 'vod:rules:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (51, '2023-12-17 14:47:51', 0, '2024-07-21 07:21:46.915416', 1, 0, 'monitor:logininfor:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (52, '2023-12-17 14:47:58', 0, '2024-07-21 07:21:58.026663', 1, 0, 'monitor:job:export', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (53, '2023-12-17 16:00:22', 0, '2024-07-21 07:23:01.081638', 1, 0, 'monitor:cache:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (67, '2024-01-25 13:54:21.800597', 0, '2024-07-21 07:24:29.46238', 1, 0, 'vod:configs:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (65, '2024-01-25 13:22:05.803287', 0, '2024-07-21 07:25:21.831916', 1, 0, 'vod:configs:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (66, '2024-01-25 13:42:15.230753', 0, '2024-07-21 07:26:18.36727', 1, 0, 'vod:configs:delete', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (2, '2023-12-02 15:30:57', 0, '2024-07-21 07:31:34.326672', 1, 0, 'system:dict:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (17, '2023-12-04 19:53:00', 0, '2024-07-21 07:38:34.088209', 1, 0, 'system:dict:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (19, '2023-12-04 19:53:35', 0, '2024-07-21 07:38:43.914336', 1, 0, 'system:dict:detail:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (18, '2023-12-04 19:53:04', 0, '2024-07-21 07:31:48.420575', 1, 0, 'system:dict:detail:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (20, '2023-12-04 19:54:59', 0, '2024-07-21 07:38:49.454487', 1, 0, 'system:dict:detail:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (64, '2024-01-25 13:06:52.800978', 0, '2024-07-21 07:40:12.712378', 1, 0, 'vod:configs:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (3, '2023-12-02 15:31:25', 0, '2024-07-21 07:35:22.504912', 1, 0, 'system:config-setting:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (10, '2023-12-02 15:39:26', 0, '2024-07-21 07:38:30.504223', 1, 0, 'system:dict:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (24, '2023-12-04 22:13:09', 0, '2024-07-21 07:37:28.555841', 1, 0, 'system:config-setting:post', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (9, '2023-12-02 15:39:04', 0, '2024-07-21 07:37:15.380865', 1, 0, 'system:config-setting:put', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (1, '2023-12-02 15:30:37', 0, '2024-07-21 07:41:59.858172', 1, 0, 'perm:user:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (6, '2023-12-02 15:37:45', 0, '2024-07-21 07:42:04.003372', 1, 0, 'perm:menu:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (7, '2023-12-02 15:38:12', 0, '2024-07-21 07:42:07.567275', 1, 0, 'perm:role:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (8, '2023-12-02 15:38:46', 0, '2024-07-21 07:42:11.293805', 1, 0, 'perm:label:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (16, '2023-12-02 19:19:35', 0, '2024-07-21 07:42:15.00952', 1, 0, 'hiker:developer:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (26, '2023-12-05 20:08:50', 0, '2024-07-21 07:42:18.708298', 1, 0, 'monitor:server:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (40, '2023-12-13 22:29:05', 0, '2024-07-21 07:42:21.972927', 1, 0, 'monitor:pip:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (68, '2024-01-25 14:11:49.030614', 0, '2024-07-21 07:42:25.143815', 1, 0, 'vod:rules:get', NULL, 0);
INSERT INTO "public"."t_perm_label" VALUES (69, '2024-02-19 14:30:49.512688', 0, '2024-07-21 07:42:28.330101', 1, 0, 'vod:houses:get', NULL, 0);

-- ----------------------------
-- Table structure for t_perm_label_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_perm_label_role";
CREATE TABLE "public"."t_perm_label_role" (
  "id" int4 NOT NULL DEFAULT nextval('t_perm_label_role_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "label_id" int4,
  "role_id" int4
)
;
COMMENT ON COLUMN "public"."t_perm_label_role"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_perm_label_role"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_perm_label_role"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_perm_label_role"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_perm_label_role"."is_deleted" IS '逻辑删除:0=未删除,1=删除';

-- ----------------------------
-- Records of t_perm_label_role
-- ----------------------------
INSERT INTO "public"."t_perm_label_role" VALUES (1, '2023-12-06 22:37:39', 0, '2023-12-06 22:37:39', 0, 0, NULL, NULL);
INSERT INTO "public"."t_perm_label_role" VALUES (33, '2024-07-21 07:23:01.097611', 1, '2024-07-21 07:23:01.097611', 0, 0, 53, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (34, '2024-07-21 07:31:34.343065', 1, '2024-07-21 07:31:34.343065', 0, 0, 2, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (35, '2024-07-21 07:31:34.343065', 1, '2024-07-21 07:31:34.343065', 0, 0, 2, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (38, '2024-07-21 07:31:48.43597', 1, '2024-07-21 07:31:48.43597', 0, 0, 18, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (39, '2024-07-21 07:31:48.43597', 1, '2024-07-21 07:31:48.43597', 0, 0, 18, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (42, '2024-07-21 07:35:22.521005', 1, '2024-07-21 07:35:22.521005', 0, 0, 3, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (43, '2024-07-21 07:35:22.521005', 1, '2024-07-21 07:35:22.521005', 0, 0, 3, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (47, '2024-07-21 07:40:12.727764', 1, '2024-07-21 07:40:12.727764', 0, 0, 64, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (48, '2024-07-21 07:40:12.727764', 1, '2024-07-21 07:40:12.727764', 0, 0, 64, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (49, '2024-07-21 07:41:59.863154', 1, '2024-07-21 07:41:59.863154', 0, 0, 1, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (50, '2024-07-21 07:41:59.863154', 1, '2024-07-21 07:41:59.863154', 0, 0, 1, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (51, '2024-07-21 07:42:04.019646', 1, '2024-07-21 07:42:04.019646', 0, 0, 6, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (52, '2024-07-21 07:42:04.019646', 1, '2024-07-21 07:42:04.019646', 0, 0, 6, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (53, '2024-07-21 07:42:07.583249', 1, '2024-07-21 07:42:07.583249', 0, 0, 7, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (54, '2024-07-21 07:42:07.583249', 1, '2024-07-21 07:42:07.583249', 0, 0, 7, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (55, '2024-07-21 07:42:11.309496', 1, '2024-07-21 07:42:11.309496', 0, 0, 8, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (56, '2024-07-21 07:42:11.309496', 1, '2024-07-21 07:42:11.309496', 0, 0, 8, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (57, '2024-07-21 07:42:15.024895', 1, '2024-07-21 07:42:15.024895', 0, 0, 16, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (58, '2024-07-21 07:42:15.024895', 1, '2024-07-21 07:42:15.024895', 0, 0, 16, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (59, '2024-07-21 07:42:18.714466', 1, '2024-07-21 07:42:18.714466', 0, 0, 26, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (60, '2024-07-21 07:42:18.714466', 1, '2024-07-21 07:42:18.714466', 0, 0, 26, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (61, '2024-07-21 07:42:21.989884', 1, '2024-07-21 07:42:21.989884', 0, 0, 40, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (62, '2024-07-21 07:42:21.989884', 1, '2024-07-21 07:42:21.989884', 0, 0, 40, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (63, '2024-07-21 07:42:25.150154', 1, '2024-07-21 07:42:25.150154', 0, 0, 68, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (64, '2024-07-21 07:42:25.150154', 1, '2024-07-21 07:42:25.150154', 0, 0, 68, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (65, '2024-07-21 07:42:28.345135', 1, '2024-07-21 07:42:28.345135', 0, 0, 69, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (66, '2024-07-21 07:42:28.345135', 1, '2024-07-21 07:42:28.345135', 0, 0, 69, 3);
INSERT INTO "public"."t_perm_label_role" VALUES (67, '2024-07-21 07:42:32.172788', 1, '2024-07-21 07:42:32.172788', 0, 0, 30, 2);
INSERT INTO "public"."t_perm_label_role" VALUES (68, '2024-07-21 07:42:32.172788', 1, '2024-07-21 07:42:32.172788', 0, 0, 30, 3);

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_role_menu";
CREATE TABLE "public"."t_role_menu" (
  "id" int4 NOT NULL DEFAULT nextval('t_role_menu_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "role_id" int4,
  "menu_id" int4
)
;
COMMENT ON COLUMN "public"."t_role_menu"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_role_menu"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_role_menu"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_role_menu"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_role_menu"."is_deleted" IS '逻辑删除:0=未删除,1=删除';

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO "public"."t_role_menu" VALUES (217, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 2);
INSERT INTO "public"."t_role_menu" VALUES (218, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 8);
INSERT INTO "public"."t_role_menu" VALUES (219, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 5);
INSERT INTO "public"."t_role_menu" VALUES (220, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 14);
INSERT INTO "public"."t_role_menu" VALUES (221, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 4);
INSERT INTO "public"."t_role_menu" VALUES (222, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 10);
INSERT INTO "public"."t_role_menu" VALUES (223, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 26);
INSERT INTO "public"."t_role_menu" VALUES (224, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 11);
INSERT INTO "public"."t_role_menu" VALUES (225, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 27);
INSERT INTO "public"."t_role_menu" VALUES (226, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 12);
INSERT INTO "public"."t_role_menu" VALUES (227, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 13);
INSERT INTO "public"."t_role_menu" VALUES (228, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 34);
INSERT INTO "public"."t_role_menu" VALUES (229, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 35);
INSERT INTO "public"."t_role_menu" VALUES (230, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 38);
INSERT INTO "public"."t_role_menu" VALUES (231, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 45);
INSERT INTO "public"."t_role_menu" VALUES (232, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 17);
INSERT INTO "public"."t_role_menu" VALUES (233, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 19);
INSERT INTO "public"."t_role_menu" VALUES (234, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 31);
INSERT INTO "public"."t_role_menu" VALUES (235, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 18);
INSERT INTO "public"."t_role_menu" VALUES (236, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 30);
INSERT INTO "public"."t_role_menu" VALUES (237, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 15);
INSERT INTO "public"."t_role_menu" VALUES (238, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 25);
INSERT INTO "public"."t_role_menu" VALUES (239, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 16);
INSERT INTO "public"."t_role_menu" VALUES (240, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 20);
INSERT INTO "public"."t_role_menu" VALUES (241, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 24);
INSERT INTO "public"."t_role_menu" VALUES (242, '2024-07-21 07:28:38.035412', 1, '2024-07-21 07:28:38.035412', 0, 0, 2, 32);
INSERT INTO "public"."t_role_menu" VALUES (264, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 2);
INSERT INTO "public"."t_role_menu" VALUES (265, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 8);
INSERT INTO "public"."t_role_menu" VALUES (266, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 5);
INSERT INTO "public"."t_role_menu" VALUES (267, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 14);
INSERT INTO "public"."t_role_menu" VALUES (268, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 4);
INSERT INTO "public"."t_role_menu" VALUES (269, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 34);
INSERT INTO "public"."t_role_menu" VALUES (270, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 35);
INSERT INTO "public"."t_role_menu" VALUES (271, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 36);
INSERT INTO "public"."t_role_menu" VALUES (272, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 45);
INSERT INTO "public"."t_role_menu" VALUES (273, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 17);
INSERT INTO "public"."t_role_menu" VALUES (274, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 19);
INSERT INTO "public"."t_role_menu" VALUES (275, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 31);
INSERT INTO "public"."t_role_menu" VALUES (276, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 18);
INSERT INTO "public"."t_role_menu" VALUES (277, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 28);
INSERT INTO "public"."t_role_menu" VALUES (278, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 30);
INSERT INTO "public"."t_role_menu" VALUES (279, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 21);
INSERT INTO "public"."t_role_menu" VALUES (280, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 15);
INSERT INTO "public"."t_role_menu" VALUES (281, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 25);
INSERT INTO "public"."t_role_menu" VALUES (282, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 16);
INSERT INTO "public"."t_role_menu" VALUES (283, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 20);
INSERT INTO "public"."t_role_menu" VALUES (284, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 24);
INSERT INTO "public"."t_role_menu" VALUES (285, '2024-07-21 07:45:01.427983', 1, '2024-07-21 07:45:01.427983', 0, 0, 3, 32);

-- ----------------------------
-- Table structure for t_roles
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_roles";
CREATE TABLE "public"."t_roles" (
  "id" int4 NOT NULL DEFAULT nextval('t_roles_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "key" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(256) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "order_num" int4 DEFAULT 0,
  "status" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."t_roles"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_roles"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_roles"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_roles"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_roles"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_roles"."key" IS '权限标识';
COMMENT ON COLUMN "public"."t_roles"."name" IS '权限名称';
COMMENT ON COLUMN "public"."t_roles"."order_num" IS '顺序';
COMMENT ON COLUMN "public"."t_roles"."status" IS '状态(0: 正常, 1: 停用)';

-- ----------------------------
-- Records of t_roles
-- ----------------------------
INSERT INTO "public"."t_roles" VALUES (1, '2022-11-13 02:44:13', 0, '2022-11-13 02:44:13', 0, 0, 'admin', '超级管理员', 1, 0);
INSERT INTO "public"."t_roles" VALUES (2, '2022-11-13 02:46:33', 0, '2024-07-21 07:28:37.925231', 1, 0, 'general', '一般用户', 2, 0);
INSERT INTO "public"."t_roles" VALUES (3, '2022-11-22 00:55:04', 1, '2024-07-21 07:45:01.369412', 1, 0, 'Operation', '管理员', 3, 0);

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_user_role";
CREATE TABLE "public"."t_user_role" (
  "id" int4 NOT NULL DEFAULT nextval('t_user_role_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "user_id" int4,
  "role_id" int4
)
;
COMMENT ON COLUMN "public"."t_user_role"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_user_role"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_user_role"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_user_role"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_user_role"."is_deleted" IS '逻辑删除:0=未删除,1=删除';

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO "public"."t_user_role" VALUES (1, '2022-11-13 02:58:19', 0, '2022-11-13 02:58:19', 0, 0, 1, 1);
INSERT INTO "public"."t_user_role" VALUES (3, '2022-11-22 00:50:26', 0, '2022-11-22 00:50:26', 0, 0, 3, 2);
INSERT INTO "public"."t_user_role" VALUES (4, '2022-11-22 00:55:57', 1, '2022-11-22 00:55:57', 0, 0, 2, 3);
INSERT INTO "public"."t_user_role" VALUES (10, '2023-12-16 11:35:26', 1, '2023-12-16 11:35:26', 0, 0, 4, 2);

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_users";
CREATE TABLE "public"."t_users" (
  "id" int4 NOT NULL DEFAULT nextval('t_users_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "username" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "nickname" varchar(32) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "sex" int4 DEFAULT 0,
  "phone" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "hashed_password" varchar(128) COLLATE "pg_catalog"."default" NOT NULL,
  "avatar" varchar(128) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "status" int4 NOT NULL DEFAULT 0,
  "is_active" bool DEFAULT false,
  "is_superuser" bool DEFAULT false
)
;
COMMENT ON COLUMN "public"."t_users"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_users"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_users"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_users"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_users"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_users"."username" IS '用户名';
COMMENT ON COLUMN "public"."t_users"."nickname" IS '姓名';
COMMENT ON COLUMN "public"."t_users"."sex" IS '性别';
COMMENT ON COLUMN "public"."t_users"."phone" IS '手机号';
COMMENT ON COLUMN "public"."t_users"."email" IS '邮箱';
COMMENT ON COLUMN "public"."t_users"."hashed_password" IS '密码';
COMMENT ON COLUMN "public"."t_users"."avatar" IS '头像';
COMMENT ON COLUMN "public"."t_users"."status" IS '状态';
COMMENT ON COLUMN "public"."t_users"."is_active" IS '是否已经验证用户';
COMMENT ON COLUMN "public"."t_users"."is_superuser" IS '是否超级管理员';

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO "public"."t_users" VALUES (2, '2022-11-22 00:48:34', 0, '2022-11-22 00:55:57', 1, 0, 'opt', 'opt', 0, '12345678911', 'opt@beginner2020.top', '$2b$12$EbJD0X5U0LwAvf5EVvYxZO20Jyv2xLKU1quekOyX3SwhdVepz1RFu', NULL, 0, 't', 'f');
INSERT INTO "public"."t_users" VALUES (4, '2023-12-02 15:36:42', 1, '2023-12-16 13:16:49', 4, 0, 'hjdhnx', '道长', 2, '13154671296', '434857005@qq.com', '$2b$12$X3LQ2VXThey.YB/WGlwYq.35CKOeKkBgmA6TTR91q/VYe6hGDAWRO', 'images/avatar/f84e9577-9047-470e-bcde-16173ca1811c.jpg', 0, 't', 'f');
INSERT INTO "public"."t_users" VALUES (1, '2022-11-13 02:58:19', 0, '2024-03-17 09:41:24.829004', 1, 0, 'admin', '超级管理员', 0, '12345678910', 'admin@beginner2020.top', '$2b$12$nlyWZAzu4C9cgbHV/FE1X.nwBKiGemATgCxikPQEQVznMqBCrDw/e', 'images/avatar/cad832e9-e7e5-4b4c-a898-0a64ca9ea2f4.png', 0, 't', 't');
INSERT INTO "public"."t_users" VALUES (3, '2022-11-22 00:50:26', 0, '2023-12-09 16:47:45', 1, 0, 'user', 'user', 0, '12345678912', 'user@beginner2020.top', '$2b$12$Wov4niPCoLOeBcRNgGDNhekSZBgB/GAhYs25CLHfJG.me1KbFP0am', NULL, 0, 't', 'f');

-- ----------------------------
-- Table structure for t_vod_configs
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_vod_configs";
CREATE TABLE "public"."t_vod_configs" (
  "id" int4 NOT NULL DEFAULT nextval('t_vod_configs_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "key" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "value" text COLLATE "pg_catalog"."default",
  "value_type" varchar(256) COLLATE "pg_catalog"."default",
  "remark" varchar(256) COLLATE "pg_catalog"."default",
  "status" int4 DEFAULT 0,
  "order_num" int4 DEFAULT 0
)
;
COMMENT ON COLUMN "public"."t_vod_configs"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_vod_configs"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_vod_configs"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_vod_configs"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_vod_configs"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_vod_configs"."name" IS '参数名称';
COMMENT ON COLUMN "public"."t_vod_configs"."key" IS '参数键';
COMMENT ON COLUMN "public"."t_vod_configs"."value" IS '参数值';
COMMENT ON COLUMN "public"."t_vod_configs"."value_type" IS '值类型';
COMMENT ON COLUMN "public"."t_vod_configs"."remark" IS '备注';
COMMENT ON COLUMN "public"."t_vod_configs"."status" IS '参数状态';
COMMENT ON COLUMN "public"."t_vod_configs"."order_num" IS '显示排序';

-- ----------------------------
-- Records of t_vod_configs
-- ----------------------------
INSERT INTO "public"."t_vod_configs" VALUES (14, '2024-02-19 13:52:29.123947', 1, '2024-05-29 13:11:46.050462', 1, 0, 'drpy源仓库1', 'vod_drpy_house1', 'hjdhnx/dr_py|js', 'str', 'drpy源的github仓库。repo|path', 1, 14);
INSERT INTO "public"."t_vod_configs" VALUES (15, '2024-02-19 13:52:29.128959', 1, '2024-05-29 13:11:46.060169', 1, 0, 'drpy源仓库2', 'vod_drpy_house2', 'heroaku/TVboxo|Js', 'str', 'drpy源的github仓库。repo|path', 1, 15);
INSERT INTO "public"."t_vod_configs" VALUES (16, '2024-03-10 11:05:05.154723', 1, '2024-05-29 13:11:46.072912', 1, 0, 'drpy源仓库3', 'vod_drpy_house3', 'gaotianliuyun/gao|js', 'str', 'drpy源的github仓库(高天流云)。repo|path', 1, 16);
INSERT INTO "public"."t_vod_configs" VALUES (4, '2024-02-01 13:15:53.620216', 1, '2024-05-29 13:11:56.507803', 1, 0, '自定义配置模板文件', 'vod_config_custom', 'txt/pg.conf', 'file', 'hipy的自动生成在线配置将使用此文件作为个性化配置', 1, 4);
INSERT INTO "public"."t_vod_configs" VALUES (1, '2024-02-01 13:15:53.558712', 1, '2024-05-29 13:11:45.933782', 1, 0, 'drpy接口文件', 'vod_drpy_api', 'drpy_libs/drpy2.min.js', 'file', '自动生成配置中的drpy的api将会使用此文件', 1, 1);
INSERT INTO "public"."t_vod_configs" VALUES (2, '2024-02-01 13:15:53.589862', 1, '2024-05-29 13:11:45.94833', 1, 0, '接口密码', 'vod_passwd', 'dzyyds', 'str', 'hipy的t4接口将使用此密码作为参数验证', 1, 2);
INSERT INTO "public"."t_vod_configs" VALUES (3, '2024-02-01 13:15:53.60785', 1, '2024-05-29 13:11:45.955541', 1, 0, '生成配置模板文件', 'vod_config_base', 'txt/config.txt', 'file', 'hipy的自动生成在线配置将使用此文件作为渲染模板', 1, 3);
INSERT INTO "public"."t_vod_configs" VALUES (5, '2024-02-01 13:15:53.637165', 1, '2024-05-29 13:11:45.971142', 1, 0, '自定义解析文件', 'vod_vip_parse', 'txt/vip_parse.conf', 'file', 'hipy的自定义视频解析配置文件', 1, 5);
INSERT INTO "public"."t_vod_configs" VALUES (6, '2024-02-01 13:15:53.649765', 1, '2024-05-29 13:11:45.980396', 1, 0, '自定义直播外链', 'vod_zb_url', 'http://hiker.nokia.press/hikerule/zyw_data/43', 'url', 'hipy的自定义直播外链文件', 1, 6);
INSERT INTO "public"."t_vod_configs" VALUES (10, '2024-02-04 14:21:12.74512', 1, '2024-05-29 13:11:45.987393', 1, 0, '自定义直播本地文件', 'vod_zb_file', 'txt/mytv.txt', 'file', 'hipy的自定义直播本地文件', 1, 10);
INSERT INTO "public"."t_vod_configs" VALUES (11, '2024-02-04 14:21:12.748985', 1, '2024-05-29 13:11:46.004131', 1, 0, '自定义直播使用', 'vod_zb_use', 'file', 'str', 'hipy的直播使用外链或文件|file:使用文件,url:使用外链', 1, 11);
INSERT INTO "public"."t_vod_configs" VALUES (7, '2024-02-01 13:15:53.665355', 1, '2024-05-29 13:11:46.012589', 1, 0, '自定义挂载jar', 'vod_custom_jar', 'jar/custom_spider_dz1201.jar', 'file', 'hipy的自定义外挂jar文件,用于直播解析和视频解析轮询', 1, 7);
INSERT INTO "public"."t_vod_configs" VALUES (8, '2024-02-01 13:15:53.686778', 1, '2024-05-29 13:11:46.021512', 1, 0, '自定义壁纸', 'vod_wall_paper', 'https://tuapi.eees.cc/api.php?category=fengjing&type=302', 'url', 'hipy的自定义壁纸，可以是文件或着链接', 1, 8);
INSERT INTO "public"."t_vod_configs" VALUES (9, '2024-02-02 17:36:29.83668', 1, '2024-05-29 13:11:46.029454', 1, 0, '环境变量', 'vod_hipy_env', '{"ali_token":"682c41720d6d4c9d8ded00bcdd712870","bili_cookie":"SESSDATA=93f1b89c%2C1685503124%2C760e0%2Ac1; bili_jct=5e0a1e65979f4d9f48fd9c158362b573; DedeUserID=253592508","douban":"264291961","vmid":"253592508","test_env":"测试环境变量","appkey":"1d8b6e7d45233436","access_key":"3841bf63f94a8e8d0181e59470167aa1CjCup6x6MSEv8rLctbAuWLQs0ra3Ej09EJhjMBrgAsaVt3ALYteyfxjvizVqWrnlR0ESVmlucDVmcHBycjZDVk9KMDFucTRmMEcwMUlHWWhQZkVvUnRqeTdMWTNjU2phSkdpRkZFTGJPQUZ6NEVmcVVMUUx2WjZBTl8wb0lsTjhLbmp6SHVxRjdRIIEC"}', 'json', 'hipy的环境变量，json数据', 1, 9);
INSERT INTO "public"."t_vod_configs" VALUES (12, '2024-02-19 11:22:58.438504', 1, '2024-05-29 13:11:46.036377', 1, 0, 'git访问代理', 'vod_git_proxy', 'https://ghproxy.liuzhicong.com/', 'url', '代理加速git访问，解决被墙问题', 1, 12);
INSERT INTO "public"."t_vod_configs" VALUES (13, '2024-02-19 11:22:58.455035', 1, '2024-05-29 13:11:46.042839', 1, 0, 'git访问令牌', 'vod_git_token', ' ', 'str', '从 http://github.com/settings/tokens 获取的token，可以操作api以及破解git访问次数限制每小时60次提升至5000次', 1, 13);

-- ----------------------------
-- Table structure for t_vod_rules
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_vod_rules";
CREATE TABLE "public"."t_vod_rules" (
  "id" int4 NOT NULL DEFAULT nextval('t_vod_rules_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "group" varchar(256) COLLATE "pg_catalog"."default",
  "path" varchar(256) COLLATE "pg_catalog"."default",
  "is_exist" bool DEFAULT true,
  "order_num" int4 DEFAULT 0,
  "file_type" varchar(256) COLLATE "pg_catalog"."default",
  "ext" text COLLATE "pg_catalog"."default",
  "status" int4 DEFAULT 0,
  "searchable" int4 DEFAULT 0,
  "filterable" int4 DEFAULT 0,
  "quickSearch" int4 DEFAULT 0,
  "active" bool DEFAULT true
)
;
COMMENT ON COLUMN "public"."t_vod_rules"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_vod_rules"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_vod_rules"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_vod_rules"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_vod_rules"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_vod_rules"."name" IS '源名称';
COMMENT ON COLUMN "public"."t_vod_rules"."group" IS '源分组';
COMMENT ON COLUMN "public"."t_vod_rules"."path" IS '文件路径';
COMMENT ON COLUMN "public"."t_vod_rules"."is_exist" IS '是否存在';
COMMENT ON COLUMN "public"."t_vod_rules"."order_num" IS '显示排序';
COMMENT ON COLUMN "public"."t_vod_rules"."file_type" IS '文件类型';
COMMENT ON COLUMN "public"."t_vod_rules"."ext" IS 'ext扩展';
COMMENT ON COLUMN "public"."t_vod_rules"."status" IS '源状态';
COMMENT ON COLUMN "public"."t_vod_rules"."searchable" IS '可搜索';
COMMENT ON COLUMN "public"."t_vod_rules"."filterable" IS '可筛选';
COMMENT ON COLUMN "public"."t_vod_rules"."quickSearch" IS '可快速搜索';
COMMENT ON COLUMN "public"."t_vod_rules"."active" IS '是否显示';

-- ----------------------------
-- Records of t_vod_rules
-- ----------------------------
INSERT INTO "public"."t_vod_rules" VALUES (11, '2024-02-01 14:31:22.082471', 1, '2024-07-21 07:00:46.437177', 1, 0, '喵次元', 't4/spiders', 't4/spiders/喵次元.py', 't', 11, '.py', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (12, '2024-02-01 14:31:22.085792', 1, '2024-07-21 07:00:46.445319', 1, 0, '新浪资源', 't4/spiders', 't4/spiders/新浪资源.py', 't', 12, '.py', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (13, '2024-02-01 14:31:22.089587', 1, '2024-07-21 07:00:46.449095', 1, 0, '樱花动漫', 't4/spiders', 't4/spiders/樱花动漫.json', 't', 9999, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (320, '2024-05-25 15:45:01.74015', 1, '2024-07-21 07:00:46.581214', 1, 0, 'iFun', 't4/files/drpy_js', 't4/files/drpy_js/iFun.js', 't', 314, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (285, '2024-05-16 08:22:11.90766', 1, '2024-07-21 07:00:46.974882', 1, 0, '孜然影视', 't4/files/drpy_js', 't4/files/drpy_js/孜然影视.js', 't', 279, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (287, '2024-05-16 08:22:12.153112', 1, '2024-07-21 07:00:47.050026', 1, 0, '快看影视', 't4/files/drpy_js', 't4/files/drpy_js/快看影视.js', 't', 281, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (267, '2024-05-15 06:21:15.245255', 1, '2024-07-21 07:00:47.053733', 1, 0, '思古影视[V2]', 't4/files/drpy_js', 't4/files/drpy_js/思古影视[V2].js', 't', 261, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (344, '2024-05-30 18:55:04.441384', 1, '2024-07-21 07:00:47.140238', 1, 0, '易搜[搜]', 't4/files/drpy_js', 't4/files/drpy_js/易搜[搜].js', 't', 338, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (283, '2024-05-16 08:22:11.800032', 1, '2024-07-21 07:00:47.153693', 1, 0, '星云影视', 't4/files/drpy_js', 't4/files/drpy_js/星云影视.js', 't', 277, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (332, '2024-05-28 03:41:22.842135', 1, '2024-07-21 07:00:47.316534', 1, 0, '爱看hd', 't4/files/drpy_js', 't4/files/drpy_js/爱看hd.js', 't', 326, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (354, '2024-06-05 15:25:08.439074', 1, '2024-07-21 07:00:47.378952', 1, 0, '番茄小说[书]', 't4/files/drpy_js', 't4/files/drpy_js/番茄小说[书].js', 't', 348, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (319, '2024-05-25 15:45:01.602023', 1, '2024-07-21 07:00:47.414653', 1, 0, '看客影院', 't4/files/drpy_js', 't4/files/drpy_js/看客影院.js', 't', 313, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (279, '2024-05-16 08:22:11.695928', 1, '2024-07-21 07:00:47.426519', 1, 0, '看看影视', 't4/files/drpy_js', 't4/files/drpy_js/看看影视.js', 't', 273, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (362, '2024-06-08 01:52:31.762835', 1, '2024-07-21 07:00:47.790446', 1, 0, '黑料不打烊-z', 't4/files/drpy_js', 't4/files/drpy_js/黑料不打烊-z.js', 't', 356, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (318, '2024-05-25 15:45:01.302243', 1, '2024-07-21 07:00:47.800045', 1, 0, '黑木耳资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/黑木耳资源[资].js', 't', 312, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (25, '2024-02-01 14:31:22.131846', 1, '2024-07-21 07:00:47.807414', 1, 0, 'alist', 't4/files/drpy_libs', 't4/files/drpy_libs/alist.js', 't', 25, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (27, '2024-02-01 14:31:22.138315', 1, '2024-07-21 07:00:47.815884', 1, 0, 'atob', 't4/files/drpy_libs', 't4/files/drpy_libs/atob.js', 't', 27, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (28, '2024-02-01 14:31:22.141613', 1, '2024-07-21 07:00:47.819497', 1, 0, 'base64', 't4/files/drpy_libs', 't4/files/drpy_libs/base64.js', 't', 28, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (29, '2024-02-01 14:31:22.144645', 1, '2024-07-21 07:00:47.823781', 1, 0, 'cheerio.min', 't4/files/drpy_libs', 't4/files/drpy_libs/cheerio.min.js', 't', 29, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (30, '2024-02-01 14:31:22.147509', 1, '2024-07-21 07:00:47.828761', 1, 0, 'crypto-hiker', 't4/files/drpy_libs', 't4/files/drpy_libs/crypto-hiker.js', 't', 30, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (31, '2024-02-01 14:31:22.150591', 1, '2024-07-21 07:00:47.832698', 1, 0, 'crypto-js', 't4/files/drpy_libs', 't4/files/drpy_libs/crypto-js.js', 't', 31, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (33, '2024-02-01 14:31:22.158067', 1, '2024-07-21 07:00:47.836449', 1, 0, 'drpy2', 't4/files/drpy_libs', 't4/files/drpy_libs/drpy2.js', 't', 33, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (34, '2024-02-01 14:31:22.161255', 1, '2024-07-21 07:00:47.840372', 1, 0, 'drpy2.min', 't4/files/drpy_libs', 't4/files/drpy_libs/drpy2.min.js', 't', 34, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (35, '2024-02-01 14:31:22.164177', 1, '2024-07-21 07:00:47.84916', 1, 0, 'drT', 't4/files/drpy_libs', 't4/files/drpy_libs/drT.js', 't', 35, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (36, '2024-02-01 14:31:22.167772', 1, '2024-07-21 07:00:47.852876', 1, 0, 'es6py', 't4/files/drpy_libs', 't4/files/drpy_libs/es6py.js', 't', 36, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (37, '2024-02-01 14:31:22.171107', 1, '2024-07-21 07:00:47.856727', 1, 0, 'exRegExp', 't4/files/drpy_libs', 't4/files/drpy_libs/exRegExp.js', 't', 37, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (38, '2024-02-01 14:31:22.174162', 1, '2024-07-21 07:00:47.861554', 1, 0, 'gbk', 't4/files/drpy_libs', 't4/files/drpy_libs/gbk.js', 't', 38, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (39, '2024-02-01 14:31:22.177056', 1, '2024-07-21 07:00:47.892983', 1, 0, 'live2cms', 't4/files/drpy_libs', 't4/files/drpy_libs/live2cms.js', 't', 39, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (40, '2024-02-01 14:31:22.179776', 1, '2024-07-21 07:00:47.897236', 1, 0, 'mod', 't4/files/drpy_libs', 't4/files/drpy_libs/mod.js', 't', 40, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (64, '2024-02-05 09:48:57.436728', 1, '2024-07-21 07:00:47.913883', 1, 0, 'qjs_env', 't4/files/drpy_libs', 't4/files/drpy_libs/qjs_env.js', 't', 64, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (41, '2024-02-01 14:31:22.183051', 1, '2024-07-21 07:00:47.91776', 1, 0, 'rsa', 't4/files/drpy_libs', 't4/files/drpy_libs/rsa.js', 't', 41, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (42, '2024-02-01 14:31:22.187826', 1, '2024-07-21 07:00:47.921995', 1, 0, 'searchFilter', 't4/files/drpy_libs', 't4/files/drpy_libs/searchFilter.js', 't', 42, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (43, '2024-02-01 14:31:22.191456', 1, '2024-07-21 07:00:47.926501', 1, 0, 'sortName', 't4/files/drpy_libs', 't4/files/drpy_libs/sortName.js', 't', 43, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (44, '2024-02-01 14:31:22.194524', 1, '2024-07-21 07:00:47.939298', 1, 0, '模板', 't4/files/drpy_libs', 't4/files/drpy_libs/模板.js', 't', 44, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (45, '2024-02-01 14:31:22.197684', 1, '2024-07-21 07:00:47.956661', 1, 0, 'alist', 't4/files/json', 't4/files/json/alist.json', 't', 45, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (49, '2024-02-01 14:31:22.214129', 1, '2024-07-21 07:00:48.103143', 1, 0, 'douyu', 't4/files/txt', 't4/files/txt/douyu.txt', 't', 49, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (50, '2024-02-01 14:31:22.217894', 1, '2024-07-21 07:00:48.107409', 1, 0, 'huya', 't4/files/txt', 't4/files/txt/huya.txt', 't', 50, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (76, '2024-02-20 16:25:29.526731', 1, '2024-07-21 07:00:48.125163', 1, 0, 'tv', 't4/files/txt', 't4/files/txt/tv.txt', 't', 70, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (62, '2024-02-04 14:21:09.849102', 1, '2024-07-21 07:00:48.133651', 1, 0, 'zb', 't4/files/txt', 't4/files/txt/zb.txt', 't', 62, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (80, '2024-03-08 15:53:21.072166', 1, '2024-07-21 07:00:48.199155', 1, 0, 'drpy3', 't4/files/drpy3_libs', 't4/files/drpy3_libs/drpy3.js', 't', 74, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (92, '2024-03-10 11:22:54.436023', 1, '2024-07-21 07:00:48.25469', 1, 0, 'banan', 't4/files/drpy3_js', 't4/files/drpy3_js/banan.js', 't', 86, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (54, '2024-02-02 15:59:25.736026', 1, '2024-07-21 07:08:44.36176', 4, 0, '在线之家', 't4/files/drpy_js', 't4/files/drpy_js/在线之家.js', 't', 54, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (4, '2024-02-01 14:31:22.05337', 1, '2024-07-21 07:00:46.3978', 1, 0, 'base_spider', 't4/spiders', 't4/spiders/base_spider.py', 't', 0, '.py', NULL, 1, 1, 1, 0, 'f');
INSERT INTO "public"."t_vod_rules" VALUES (6, '2024-02-01 14:31:22.061431', 1, '2024-07-21 07:00:46.405578', 1, 0, 'cntv央视', 't4/spiders', 't4/spiders/cntv央视.py', 't', 0, '.py', '{{host}}/files/hipy/cntv央视.json', 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (7, '2024-02-01 14:31:22.066253', 1, '2024-07-21 07:00:46.417563', 1, 0, 'test_1', 't4/spiders', 't4/spiders/test_1.txt', 't', 9999, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (8, '2024-02-01 14:31:22.0695', 1, '2024-07-21 07:00:46.421415', 1, 0, '两个BT', 't4/spiders', 't4/spiders/两个BT.json', 't', 9999, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (9, '2024-02-01 14:31:22.073461', 1, '2024-07-21 07:00:46.425423', 1, 0, '两个BT', 't4/spiders', 't4/spiders/两个BT.py', 't', 9, '.py', '{{host}}/files/hipy/两个BT.json', 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (381, '2024-06-09 18:53:00.718922', 1, '2024-07-21 07:00:47.747322', 1, 0, '飞翔鸟[书]', 't4/files/drpy_js', 't4/files/drpy_js/飞翔鸟[书].js', 't', 375, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (60, '2024-02-04 14:21:09.834304', 1, '2024-07-21 07:00:47.969542', 1, 0, 'E8plus', 't4/files/json', 't4/files/json/E8plus.json', 't', 60, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (46, '2024-02-01 14:31:22.201442', 1, '2024-07-21 07:00:48.09004', 1, 0, 'bili', 't4/files/txt', 't4/files/txt/bili.txt', 't', 46, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (47, '2024-02-01 14:31:22.206951', 1, '2024-07-21 07:00:48.094441', 1, 0, 'config', 't4/files/txt', 't4/files/txt/config.txt', 't', 47, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (48, '2024-02-01 14:31:22.210714', 1, '2024-07-21 07:00:48.098659', 1, 0, 'custom', 't4/files/txt', 't4/files/txt/custom.conf', 't', 48, '.conf', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (77, '2024-03-08 15:53:20.98301', 1, '2024-07-21 07:00:48.111879', 1, 0, 'mytv', 't4/files/txt', 't4/files/txt/mytv.txt', 't', 71, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (65, '2024-02-05 09:48:57.517131', 1, '2024-07-21 07:00:48.137486', 1, 0, 'custom_jsapi', 't4/files/jar', 't4/files/jar/custom_jsapi.jar', 't', 65, '.jar', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (66, '2024-02-05 09:48:57.524729', 1, '2024-07-21 07:00:48.142165', 1, 0, 'custom_spider_dz1201', 't4/files/jar', 't4/files/jar/custom_spider_dz1201.jar', 't', 66, '.jar', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (67, '2024-02-05 09:56:10.488387', 1, '2024-07-21 07:00:48.160241', 1, 0, '哔哩', 't4/files/js_parse_api', 't4/files/js_parse_api/哔哩.js', 't', 67, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (131, '2024-03-29 09:09:21.210231', 1, '2024-07-21 07:00:48.168408', 1, 0, '杰森', 't4/files/js_parse_api', 't4/files/js_parse_api/杰森.js', 't', 125, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (78, '2024-03-08 15:53:21.065726', 1, '2024-07-21 07:00:48.185312', 1, 0, 'cheerio.min', 't4/files/drpy3_libs', 't4/files/drpy3_libs/cheerio.min.js', 't', 72, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (79, '2024-03-08 15:53:21.070369', 1, '2024-07-21 07:00:48.189257', 1, 0, 'crypto-js', 't4/files/drpy3_libs', 't4/files/drpy3_libs/crypto-js.js', 't', 73, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (125, '2024-03-19 11:00:53.11513', 1, '2024-07-21 07:00:48.194414', 1, 0, 'drpy3.hiker', 't4/files/drpy3_libs', 't4/files/drpy3_libs/drpy3.hiker.js', 't', 119, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (82, '2024-03-08 15:53:21.07716', 1, '2024-07-21 07:00:48.203103', 1, 0, 'gbk', 't4/files/drpy3_libs', 't4/files/drpy3_libs/gbk.js', 't', 76, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (83, '2024-03-08 15:53:21.079211', 1, '2024-07-21 07:00:48.219731', 1, 0, '模板', 't4/files/drpy3_libs', 't4/files/drpy3_libs/模板.js', 't', 77, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (85, '2024-03-10 11:22:54.396452', 1, '2024-07-21 07:00:48.223479', 1, 0, '1080P', 't4/files/drpy3_js', 't4/files/drpy3_js/1080P.js', 't', 79, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (86, '2024-03-10 11:22:54.404715', 1, '2024-07-21 07:00:48.227933', 1, 0, '18av', 't4/files/drpy3_js', 't4/files/drpy3_js/18av.js', 't', 80, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (87, '2024-03-10 11:22:54.410304', 1, '2024-07-21 07:00:48.231679', 1, 0, '369影视', 't4/files/drpy3_js', 't4/files/drpy3_js/369影视.js', 't', 81, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (88, '2024-03-10 11:22:54.415189', 1, '2024-07-21 07:00:48.235582', 1, 0, '4khdr', 't4/files/drpy3_js', 't4/files/drpy3_js/4khdr.js', 't', 82, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (89, '2024-03-10 11:22:54.420127', 1, '2024-07-21 07:00:48.239179', 1, 0, '97tvs', 't4/files/drpy3_js', 't4/files/drpy3_js/97tvs.js', 't', 83, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (90, '2024-03-10 11:22:54.425029', 1, '2024-07-21 07:00:48.247258', 1, 0, 'aipanso', 't4/files/drpy3_js', 't4/files/drpy3_js/aipanso.js', 't', 84, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (91, '2024-03-10 11:22:54.431043', 1, '2024-07-21 07:00:48.25106', 1, 0, 'alist', 't4/files/drpy3_js', 't4/files/drpy3_js/alist.json', 't', 85, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (93, '2024-03-10 11:22:54.441055', 1, '2024-07-21 07:00:48.258687', 1, 0, 'cilixiong', 't4/files/drpy3_js', 't4/files/drpy3_js/cilixiong.js', 't', 87, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (95, '2024-03-10 11:22:54.451334', 1, '2024-07-21 07:00:48.267958', 1, 0, 'ddys_d', 't4/files/drpy3_js', 't4/files/drpy3_js/ddys_d.js', 't', 89, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (96, '2024-03-10 11:22:54.456638', 1, '2024-07-21 07:00:48.271957', 1, 0, 'dydhhy', 't4/files/drpy3_js', 't4/files/drpy3_js/dydhhy.js', 't', 90, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (97, '2024-03-10 11:22:54.461295', 1, '2024-07-21 07:00:48.275967', 1, 0, 'dygang', 't4/files/drpy3_js', 't4/files/drpy3_js/dygang.js', 't', 91, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (98, '2024-03-10 11:22:54.466196', 1, '2024-07-21 07:00:48.279793', 1, 0, 'funletu', 't4/files/drpy3_js', 't4/files/drpy3_js/funletu.js', 't', 92, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (99, '2024-03-10 11:22:54.471919', 1, '2024-07-21 07:00:48.287118', 1, 0, 'huya', 't4/files/drpy3_js', 't4/files/drpy3_js/huya.js', 't', 93, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (100, '2024-03-10 11:22:54.476378', 1, '2024-07-21 07:00:48.290774', 1, 0, 'jianpian', 't4/files/drpy3_js', 't4/files/drpy3_js/jianpian.js', 't', 94, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (101, '2024-03-10 11:22:54.48102', 1, '2024-07-21 07:00:48.295335', 1, 0, 'jiyingw', 't4/files/drpy3_js', 't4/files/drpy3_js/jiyingw.js', 't', 95, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (102, '2024-03-10 11:22:54.485559', 1, '2024-07-21 07:00:48.299683', 1, 0, 'jiyingwp', 't4/files/drpy3_js', 't4/files/drpy3_js/jiyingwp.js', 't', 96, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (103, '2024-03-10 11:22:54.489716', 1, '2024-07-21 07:00:48.303587', 1, 0, 'kkpans', 't4/files/drpy3_js', 't4/files/drpy3_js/kkpans.js', 't', 97, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (104, '2024-03-10 11:22:54.494281', 1, '2024-07-21 07:00:48.307654', 1, 0, 'kuba', 't4/files/drpy3_js', 't4/files/drpy3_js/kuba.js', 't', 98, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (105, '2024-03-10 11:22:54.499477', 1, '2024-07-21 07:00:48.312386', 1, 0, 'lf_live', 't4/files/drpy3_js', 't4/files/drpy3_js/lf_live.txt', 't', 99, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (106, '2024-03-10 11:22:54.504301', 1, '2024-07-21 07:00:48.316264', 1, 0, 'lf_live1', 't4/files/drpy3_js', 't4/files/drpy3_js/lf_live1.txt', 't', 100, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (114, '2024-03-10 11:22:54.541045', 1, '2024-07-21 07:00:48.350578', 1, 0, 'rrdyw', 't4/files/drpy3_js', 't4/files/drpy3_js/rrdyw.js', 't', 108, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (116, '2024-03-10 11:22:54.551052', 1, '2024-07-21 07:00:48.354377', 1, 0, 'tzfile', 't4/files/drpy3_js', 't4/files/drpy3_js/tzfile.js', 't', 110, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (118, '2024-03-10 11:22:54.561607', 1, '2024-07-21 07:00:48.36328', 1, 0, 'xzys', 't4/files/drpy3_js', 't4/files/drpy3_js/xzys.js', 't', 112, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (119, '2024-03-10 11:22:54.566374', 1, '2024-07-21 07:00:48.367057', 1, 0, 'yyets', 't4/files/drpy3_js', 't4/files/drpy3_js/yyets.js', 't', 113, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (120, '2024-03-10 11:22:54.570699', 1, '2024-07-21 07:00:48.371235', 1, 0, 'yyetsp', 't4/files/drpy3_js', 't4/files/drpy3_js/yyetsp.js', 't', 114, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (121, '2024-03-10 11:22:54.575765', 1, '2024-07-21 07:00:48.376131', 1, 0, '养端', 't4/files/drpy3_js', 't4/files/drpy3_js/养端.js', 't', 115, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (122, '2024-03-10 11:22:54.581446', 1, '2024-07-21 07:00:48.401902', 1, 0, '吸瓜', 't4/files/drpy3_js', 't4/files/drpy3_js/吸瓜.js', 't', 116, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (135, '2024-05-06 13:28:59.334848', 1, '2024-07-21 07:00:46.429661', 1, 0, '厂长资源', 't4/spiders', 't4/spiders/厂长资源.py', 't', 129, '.py', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (441, '2024-06-17 16:35:37.502432', 1, '2024-07-21 07:00:46.532782', 1, 0, '88看球[球]', 't4/files/drpy_js', 't4/files/drpy_js/88看球[球].js', 't', 435, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (330, '2024-05-27 10:10:44.903811', 1, '2024-07-21 07:00:47.325712', 1, 0, '爱看农民[优]', 't4/files/drpy_js', 't4/files/drpy_js/爱看农民[优].js', 't', 324, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (282, '2024-05-16 08:22:11.775273', 1, '2024-07-21 07:00:47.591805', 1, 0, '蓝光影视', 't4/files/drpy_js', 't4/files/drpy_js/蓝光影视.js', 't', 276, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (284, '2024-05-16 08:22:11.811528', 1, '2024-07-21 07:00:47.625444', 1, 0, '西屋影视', 't4/files/drpy_js', 't4/files/drpy_js/西屋影视.js', 't', 278, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (457, '2024-06-17 16:35:38.014082', 1, '2024-07-21 07:00:46.597712', 1, 0, 'MuteFun[漫]', 't4/files/drpy_js', 't4/files/drpy_js/MuteFun[漫].js', 't', 451, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (395, '2024-06-12 10:09:51.875734', 1, '2024-07-21 07:00:46.81291', 1, 0, '千百视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/千百视频[密].js', 't', 389, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (127, '2024-03-29 09:09:21.022291', 1, '2024-07-21 07:00:46.836108', 1, 0, '厂长资源', 't4/files/drpy_js', 't4/files/drpy_js/厂长资源.js', 't', 121, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (155, '2024-05-06 13:28:59.628363', 1, '2024-07-21 07:00:46.925547', 1, 0, '大米星球', 't4/files/drpy_js', 't4/files/drpy_js/大米星球.js', 't', 149, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (429, '2024-06-17 16:35:36.919229', 1, '2024-07-21 07:00:46.961342', 1, 0, '好趣网[播]', 't4/files/drpy_js', 't4/files/drpy_js/好趣网[播].js', 't', 423, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (389, '2024-06-11 10:05:03.445614', 1, '2024-07-21 07:00:46.970245', 1, 0, '子子影视', 't4/files/drpy_js', 't4/files/drpy_js/子子影视.js', 't', 383, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (446, '2024-06-17 16:35:37.585434', 1, '2024-07-21 07:00:47.108638', 1, 0, '斗鱼直播[官]', 't4/files/drpy_js', 't4/files/drpy_js/斗鱼直播[官].js', 't', 440, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (288, '2024-05-16 08:22:12.282205', 1, '2024-07-21 07:00:47.158421', 1, 0, '星空影院', 't4/files/drpy_js', 't4/files/drpy_js/星空影院.js', 't', 282, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (439, '2024-06-17 16:35:37.289358', 1, '2024-07-21 07:00:47.236231', 1, 0, '樱花动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/樱花动漫[漫].js', 't', 433, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (430, '2024-06-17 16:35:36.951309', 1, '2024-07-21 07:00:47.277191', 1, 0, '漫小肆[画]', 't4/files/drpy_js', 't4/files/drpy_js/漫小肆[画].js', 't', 424, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (388, '2024-06-11 10:05:03.303369', 1, '2024-07-21 07:00:47.294387', 1, 0, '热片网', 't4/files/drpy_js', 't4/files/drpy_js/热片网.js', 't', 382, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (322, '2024-05-25 15:45:01.962292', 1, '2024-07-21 07:00:47.370024', 1, 0, '电影天堂', 't4/files/drpy_js', 't4/files/drpy_js/电影天堂.js', 't', 316, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (153, '2024-05-06 13:28:59.61497', 1, '2024-07-21 07:00:47.38334', 1, 0, '白嫖者联盟', 't4/files/drpy_js', 't4/files/drpy_js/白嫖者联盟.js', 't', 147, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (433, '2024-06-17 16:35:37.007061', 1, '2024-07-21 07:00:47.475086', 1, 0, '第一韩漫[画]', 't4/files/drpy_js', 't4/files/drpy_js/第一韩漫[画].js', 't', 427, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (440, '2024-06-17 16:35:37.397274', 1, '2024-07-21 07:00:47.49687', 1, 0, '维奇动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/维奇动漫[漫].js', 't', 434, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (333, '2024-05-28 10:11:14.082974', 1, '2024-07-21 07:00:47.541838', 1, 0, '胖虎影视', 't4/files/drpy_js', 't4/files/drpy_js/胖虎影视.js', 't', 327, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (270, '2024-05-15 06:21:15.433748', 1, '2024-07-21 07:00:47.608878', 1, 0, '蛋蛋剧', 't4/files/drpy_js', 't4/files/drpy_js/蛋蛋剧.js', 't', 264, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (271, '2024-05-15 06:21:15.45228', 1, '2024-07-21 07:00:47.613512', 1, 0, '蛋蛋赞', 't4/files/drpy_js', 't4/files/drpy_js/蛋蛋赞.js', 't', 265, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (432, '2024-06-17 16:35:36.983571', 1, '2024-07-21 07:00:47.786492', 1, 0, '麻雀视频[优]', 't4/files/drpy_js', 't4/files/drpy_js/麻雀视频[优].js', 't', 426, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (59, '2024-02-04 14:21:09.832085', 1, '2024-07-21 07:00:47.96149', 1, 0, 'bili', 't4/files/json', 't4/files/json/bili.json', 't', 59, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (75, '2024-02-19 18:15:01.925873', 1, '2024-07-21 07:00:47.965551', 1, 0, 'drpy_rules', 't4/files/json', 't4/files/json/drpy_rules.json', 't', 69, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (186, '2024-05-06 13:29:00.117259', 1, '2024-07-21 07:00:47.999531', 1, 0, 'moli', 't4/files/json', 't4/files/json/moli.json', 't', 180, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (188, '2024-05-06 13:29:00.130646', 1, '2024-07-21 07:00:48.036003', 1, 0, 'wgcf', 't4/files/json', 't4/files/json/wgcf.json', 't', 182, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (51, '2024-02-01 14:31:22.221119', 1, '2024-07-21 07:00:48.129732', 1, 0, 'vip_parse', 't4/files/txt', 't4/files/txt/vip_parse.conf', 't', 51, '.conf', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (191, '2024-05-06 13:29:00.22327', 1, '2024-07-21 07:00:48.146565', 1, 0, 'pg', 't4/files/jar', 't4/files/jar/pg.jar', 't', 185, '.jar', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (129, '2024-03-29 09:09:21.199069', 1, '2024-07-21 07:00:48.154919', 1, 0, 'CK', 't4/files/js_parse_api', 't4/files/js_parse_api/CK.js', 't', 123, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (130, '2024-03-29 09:09:21.206493', 1, '2024-07-21 07:00:48.164312', 1, 0, '夜幕', 't4/files/js_parse_api', 't4/files/js_parse_api/夜幕.js', 't', 124, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (132, '2024-03-29 09:09:21.213665', 1, '2024-07-21 07:00:48.172372', 1, 0, '盘古', 't4/files/js_parse_api', 't4/files/js_parse_api/盘古.js', 't', 126, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (133, '2024-03-29 09:09:21.21701', 1, '2024-07-21 07:00:48.177164', 1, 0, '虾米', 't4/files/js_parse_api', 't4/files/js_parse_api/虾米.js', 't', 127, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (134, '2024-03-29 09:09:21.220463', 1, '2024-07-21 07:00:48.181164', 1, 0, '阳途', 't4/files/js_parse_api', 't4/files/js_parse_api/阳途.js', 't', 128, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (192, '2024-05-06 13:29:00.323252', 1, '2024-07-21 07:00:48.215878', 1, 0, 'pako.min', 't4/files/drpy3_libs', 't4/files/drpy3_libs/pako.min.js', 't', 186, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (107, '2024-03-10 11:22:54.508952', 1, '2024-07-21 07:00:48.320139', 1, 0, 'live2mv_data', 't4/files/drpy3_js', 't4/files/drpy3_js/live2mv_data.json', 't', 101, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (108, '2024-03-10 11:22:54.5137', 1, '2024-07-21 07:00:48.324027', 1, 0, 'meijumi', 't4/files/drpy3_js', 't4/files/drpy3_js/meijumi.js', 't', 102, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (109, '2024-03-10 11:22:54.518066', 1, '2024-07-21 07:00:48.329143', 1, 0, 'meijumip', 't4/files/drpy3_js', 't4/files/drpy3_js/meijumip.js', 't', 103, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (110, '2024-03-10 11:22:54.522405', 1, '2024-07-21 07:00:48.333045', 1, 0, 'meow', 't4/files/drpy3_js', 't4/files/drpy3_js/meow.js', 't', 104, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (111, '2024-03-10 11:22:54.526879', 1, '2024-07-21 07:00:48.336828', 1, 0, 'Missav', 't4/files/drpy3_js', 't4/files/drpy3_js/Missav.js', 't', 105, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (112, '2024-03-10 11:22:54.531894', 1, '2024-07-21 07:00:48.3417', 1, 0, 'mp4us', 't4/files/drpy3_js', 't4/files/drpy3_js/mp4us.js', 't', 106, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (113, '2024-03-10 11:22:54.53651', 1, '2024-07-21 07:00:48.346731', 1, 0, 'qimiao', 't4/files/drpy3_js', 't4/files/drpy3_js/qimiao.js', 't', 107, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (117, '2024-03-10 11:22:54.556124', 1, '2024-07-21 07:00:48.359109', 1, 0, 'xb6v', 't4/files/drpy3_js', 't4/files/drpy3_js/xb6v.js', 't', 111, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (124, '2024-03-10 11:22:54.592597', 1, '2024-07-21 07:00:48.418687', 1, 0, '玩偶姐姐', 't4/files/drpy3_js', 't4/files/drpy3_js/玩偶姐姐.js', 't', 118, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (81, '2024-03-08 15:53:21.075372', 1, '2024-07-21 07:00:48.431304', 1, 0, 'drpy3.min', 't4/files/drpy3_libs', 't4/files/drpy3_libs/drpy3.min.js', 'f', 75, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (5, '2024-02-01 14:31:22.05774', 1, '2024-07-21 07:00:46.401558', 1, 0, 'cntv央视', 't4/spiders', 't4/spiders/cntv央视.json', 't', 9999, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (10, '2024-02-01 14:31:22.077409', 1, '2024-07-21 07:00:46.433324', 1, 0, '哔滴影视', 't4/spiders', 't4/spiders/哔滴影视.py', 't', 10, '.py', '{{host}}/files/hipy/jars/bidi.jar', 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (136, '2024-05-06 13:28:59.370606', 1, '2024-07-21 07:00:46.440986', 1, 0, '在线之家', 't4/spiders', 't4/spiders/在线之家.py', 't', 130, '.py', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (410, '2024-06-14 18:03:33.410059', 1, '2024-07-21 07:00:46.551223', 1, 0, 'bilfun(自动)', 't4/files/drpy_js', 't4/files/drpy_js/bilfun(自动).js', 't', 404, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (126, '2024-03-29 09:09:20.999119', 1, '2024-07-21 07:00:46.564562', 1, 0, 'freeok', 't4/files/drpy_js', 't4/files/drpy_js/freeok.js', 't', 120, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (162, '2024-05-06 13:28:59.724194', 1, '2024-07-21 07:00:46.636867', 1, 0, 'voflix', 't4/files/drpy_js', 't4/files/drpy_js/voflix.js', 't', 156, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (202, '2024-05-09 11:39:58.476424', 1, '2024-07-21 07:00:46.665454', 1, 0, '七年影视', 't4/files/drpy_js', 't4/files/drpy_js/七年影视.js', 't', 196, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (442, '2024-06-17 16:35:37.508464', 1, '2024-07-21 07:00:46.714618', 1, 0, '云盘资源网[盘]', 't4/files/drpy_js', 't4/files/drpy_js/云盘资源网[盘].js', 't', 436, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (200, '2024-05-08 14:08:15.453814', 1, '2024-07-21 07:00:46.73731', 1, 0, '侠客影视', 't4/files/drpy_js', 't4/files/drpy_js/侠客影视.js', 't', 194, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (437, '2024-06-17 16:35:37.271622', 1, '2024-07-21 07:00:46.796985', 1, 0, '动漫巴士[漫]', 't4/files/drpy_js', 't4/files/drpy_js/动漫巴士[漫].js', 't', 431, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (445, '2024-06-17 16:35:37.532546', 1, '2024-07-21 07:00:46.80092', 1, 0, '动漫网[漫]', 't4/files/drpy_js', 't4/files/drpy_js/动漫网[漫].js', 't', 439, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (451, '2024-06-17 16:35:37.760122', 1, '2024-07-21 07:00:46.903473', 1, 0, '多多追剧[优]', 't4/files/drpy_js', 't4/files/drpy_js/多多追剧[优].js', 't', 445, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (438, '2024-06-17 16:35:37.283601', 1, '2024-07-21 07:00:46.920683', 1, 0, '大米动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/大米动漫[漫].js', 't', 432, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (161, '2024-05-06 13:28:59.717584', 1, '2024-07-21 07:00:46.929893', 1, 0, '大米星球[V2]', 't4/files/drpy_js', 't4/files/drpy_js/大米星球[V2].js', 't', 155, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (390, '2024-06-11 10:05:04.084003', 1, '2024-07-21 07:00:46.933847', 1, 0, '天启', 't4/files/drpy_js', 't4/files/drpy_js/天启.js', 't', 384, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (453, '2024-06-17 16:35:37.820317', 1, '2024-07-21 07:00:47.008992', 1, 0, '广播迷FM[听]', 't4/files/drpy_js', 't4/files/drpy_js/广播迷FM[听].js', 't', 447, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (447, '2024-06-17 16:35:37.654708', 1, '2024-07-21 07:00:47.057883', 1, 0, '恒大影视[密]', 't4/files/drpy_js', 't4/files/drpy_js/恒大影视[密].js', 't', 441, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (367, '2024-06-09 11:52:40.197544', 1, '2024-07-21 07:00:47.09505', 1, 0, '播客[听]', 't4/files/drpy_js', 't4/files/drpy_js/播客[听].js', 't', 361, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (424, '2024-06-17 07:27:22.591333', 1, '2024-07-21 07:00:47.19484', 1, 0, '最新4K', 't4/files/drpy_js', 't4/files/drpy_js/最新4K.js', 't', 418, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (160, '2024-05-06 13:28:59.710465', 1, '2024-07-21 07:00:47.232578', 1, 0, '榜一短剧', 't4/files/drpy_js', 't4/files/drpy_js/榜一短剧.js', 't', 154, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (434, '2024-06-17 16:35:37.061611', 1, '2024-07-21 07:00:47.252276', 1, 0, '次元城动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/次元城动漫[漫].js', 't', 428, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (431, '2024-06-17 16:35:36.977455', 1, '2024-07-21 07:00:47.267846', 1, 0, '清风DJ[听]', 't4/files/drpy_js', 't4/files/drpy_js/清风DJ[听].js', 't', 425, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (448, '2024-06-17 16:35:37.669656', 1, '2024-07-21 07:00:47.343217', 1, 0, '爱车MV[听]', 't4/files/drpy_js', 't4/files/drpy_js/爱车MV[听].js', 't', 442, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (452, '2024-06-17 16:35:37.783857', 1, '2024-07-21 07:00:47.402361', 1, 0, '相声随身听[听]', 't4/files/drpy_js', 't4/files/drpy_js/相声随身听[听].js', 't', 446, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (396, '2024-06-12 10:09:52.379917', 1, '2024-07-21 07:00:47.528735', 1, 0, '老司视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/老司视频[密].js', 't', 390, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (128, '2024-03-29 09:09:21.048809', 1, '2024-07-21 07:00:47.536664', 1, 0, '耐看', 't4/files/drpy_js', 't4/files/drpy_js/耐看.js', 't', 122, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (444, '2024-06-17 16:35:37.520877', 1, '2024-07-21 07:00:47.596373', 1, 0, '虎牙直播[官]', 't4/files/drpy_js', 't4/files/drpy_js/虎牙直播[官].js', 't', 438, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (449, '2024-06-17 16:35:37.696774', 1, '2024-07-21 07:00:47.769013', 1, 0, '驴番[漫]', 't4/files/drpy_js', 't4/files/drpy_js/驴番[漫].js', 't', 443, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (415, '2024-06-15 06:37:46.151277', 1, '2024-07-21 07:00:47.803718', 1, 0, '黑狐影院', 't4/files/drpy_js', 't4/files/drpy_js/黑狐影院.js', 't', 409, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (171, '2024-05-06 13:28:59.913485', 1, '2024-07-21 07:00:47.888264', 1, 0, 'jsrsa.min', 't4/files/drpy_libs', 't4/files/drpy_libs/jsrsa.min.js', 't', 165, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (170, '2024-05-06 13:28:59.904969', 1, '2024-07-21 07:00:47.935133', 1, 0, 'test_rsa', 't4/files/drpy_libs', 't4/files/drpy_libs/test_rsa.mjs', 't', 164, '.mjs', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (180, '2024-05-06 13:29:00.057574', 1, '2024-07-21 07:00:47.944034', 1, 0, 'aliproxy', 't4/files/json', 't4/files/json/aliproxy.gz', 't', 174, '.gz', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (176, '2024-05-06 13:29:00.020434', 1, '2024-07-21 07:00:47.973571', 1, 0, 'geoip.dat', 't4/files/json', 't4/files/json/geoip.dat.gz', 't', 170, '.gz', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (61, '2024-02-04 14:21:09.836048', 1, '2024-07-21 07:00:47.982701', 1, 0, 'live2mv_data', 't4/files/json', 't4/files/json/live2mv_data.json', 't', 61, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (179, '2024-05-06 13:29:00.049625', 1, '2024-07-21 07:00:48.003357', 1, 0, 'pikpakclass', 't4/files/json', 't4/files/json/pikpakclass.json', 't', 173, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (182, '2024-05-06 13:29:00.072149', 1, '2024-07-21 07:00:48.007122', 1, 0, 'pikpakclass.json.db', 't4/files/json', 't4/files/json/pikpakclass.json.db.gz', 't', 176, '.gz', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (185, '2024-05-06 13:29:00.109933', 1, '2024-07-21 07:00:48.012669', 1, 0, 'pushshare', 't4/files/json', 't4/files/json/pushshare.txt', 't', 179, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (178, '2024-05-06 13:29:00.042172', 1, '2024-07-21 07:00:48.023874', 1, 0, 'thundershare', 't4/files/json', 't4/files/json/thundershare.txt', 't', 172, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (174, '2024-05-06 13:28:59.990672', 1, '2024-07-21 07:00:48.028721', 1, 0, 'tokenm', 't4/files/json', 't4/files/json/tokenm.json', 't', 168, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (183, '2024-05-06 13:29:00.07901', 1, '2024-07-21 07:00:48.039718', 1, 0, 'wogg', 't4/files/json', 't4/files/json/wogg.json', 't', 177, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (190, '2024-05-06 13:29:00.152364', 1, '2024-07-21 07:00:48.116037', 1, 0, 'pg', 't4/files/txt', 't4/files/txt/pg.conf', 't', 184, '.conf', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (207, '2024-05-10 10:26:49.612448', 1, '2024-07-21 07:00:48.212006', 1, 0, 'node-rsa', 't4/files/drpy3_libs', 't4/files/drpy3_libs/node-rsa.js', 't', 201, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (212, '2024-05-10 10:26:49.886989', 1, '2024-07-21 07:00:48.283522', 1, 0, 'heiliao', 't4/files/drpy3_js', 't4/files/drpy3_js/heiliao.js', 't', 206, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (366, '2024-06-09 11:52:39.898976', 1, '2024-07-21 07:00:46.577214', 1, 0, 'i275听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/i275听书[听].js', 't', 360, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (211, '2024-05-10 10:26:49.84609', 1, '2024-07-21 07:00:48.384548', 1, 0, '农民影视2', 't4/files/drpy3_js', 't4/files/drpy3_js/农民影视2.js', 't', 205, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (175, '2024-05-06 13:29:00.00549', 1, '2024-07-21 07:00:48.431304', 1, 0, '小学教育', 't4/files/json', 't4/files/json/小学教育.json', 'f', 169, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (156, '2024-05-06 13:28:59.643767', 1, '2024-07-21 07:00:46.519303', 1, 0, '6V新版[磁]', 't4/files/drpy_js', 't4/files/drpy_js/6V新版[磁].js', 't', 150, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (459, '2024-06-17 16:35:38.08813', 1, '2024-07-21 07:00:46.601487', 1, 0, 'NT动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/NT动漫[漫].js', 't', 453, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (435, '2024-06-17 16:35:37.20086', 1, '2024-07-21 07:00:46.609383', 1, 0, 'OmoFun[漫]', 't4/files/drpy_js', 't4/files/drpy_js/OmoFun[漫].js', 't', 429, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (436, '2024-06-17 16:35:37.235152', 1, '2024-07-21 07:00:46.625294', 1, 0, 'R18撸[密]', 't4/files/drpy_js', 't4/files/drpy_js/R18撸[密].js', 't', 430, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (237, '2024-05-15 01:58:31.411685', 1, '2024-07-21 07:00:46.828625', 1, 0, '卧龙资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/卧龙资源[资].js', 't', 231, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (242, '2024-05-15 01:58:31.476547', 1, '2024-07-21 07:00:46.947391', 1, 0, '奇珍异兽[官]', 't4/files/drpy_js', 't4/files/drpy_js/奇珍异兽[官].js', 't', 236, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (229, '2024-05-14 08:53:58.667963', 1, '2024-07-21 07:00:46.983506', 1, 0, '宝片视频', 't4/files/drpy_js', 't4/files/drpy_js/宝片视频.js', 't', 223, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (335, '2024-05-28 13:59:41.437055', 1, '2024-07-21 07:00:46.996552', 1, 0, '小站盘[搜]', 't4/files/drpy_js', 't4/files/drpy_js/小站盘[搜].js', 't', 329, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (231, '2024-05-14 08:53:58.961908', 1, '2024-07-21 07:00:47.113598', 1, 0, '新茶杯狐', 't4/files/drpy_js', 't4/files/drpy_js/新茶杯狐.js', 't', 225, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (256, '2024-05-15 01:58:31.595797', 1, '2024-07-21 07:00:47.189753', 1, 0, '暴风资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/暴风资源[资].js', 't', 250, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (234, '2024-05-15 01:58:31.384629', 1, '2024-07-21 07:00:47.220529', 1, 0, '极客资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/极客资源[资].js', 't', 228, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (385, '2024-06-10 02:30:06.616497', 1, '2024-07-21 07:00:47.244739', 1, 0, '橘子柚[盘]', 't4/files/drpy_js', 't4/files/drpy_js/橘子柚[盘].js', 't', 379, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (220, '2024-05-11 14:54:31.110198', 1, '2024-07-21 07:00:47.260312', 1, 0, '海外剧汇', 't4/files/drpy_js', 't4/files/drpy_js/海外剧汇.js', 't', 214, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (369, '2024-06-09 11:52:40.550088', 1, '2024-07-21 07:00:47.264179', 1, 0, '海洋听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/海洋听书[听].js', 't', 363, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (281, '2024-05-16 08:22:11.767275', 1, '2024-07-21 07:00:47.289084', 1, 0, '热播之家', 't4/files/drpy_js', 't4/files/drpy_js/热播之家.js', 't', 275, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (336, '2024-05-28 13:59:41.473983', 1, '2024-07-21 07:00:47.351237', 1, 0, '狗狗盘[搜]', 't4/files/drpy_js', 't4/files/drpy_js/狗狗盘[搜].js', 't', 330, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (203, '2024-05-10 10:26:49.00574', 1, '2024-07-21 07:00:47.442943', 1, 0, '磁力熊[磁]', 't4/files/drpy_js', 't4/files/drpy_js/磁力熊[磁].js', 't', 197, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (240, '2024-05-15 01:58:31.449202', 1, '2024-07-21 07:00:47.546303', 1, 0, '腾云驾雾[官]', 't4/files/drpy_js', 't4/files/drpy_js/腾云驾雾[官].js', 't', 234, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (257, '2024-05-15 01:58:31.601263', 1, '2024-07-21 07:00:47.633923', 1, 0, '豆瓣[官]', 't4/files/drpy_js', 't4/files/drpy_js/豆瓣[官].js', 't', 251, '.js', '?render=1', 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (255, '2024-05-15 01:58:31.584287', 1, '2024-07-21 07:00:47.689845', 1, 0, '量子影视[资]', 't4/files/drpy_js', 't4/files/drpy_js/量子影视[资].js', 't', 249, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (26, '2024-02-01 14:31:22.13501', 1, '2024-07-21 07:00:47.812061', 1, 0, 'alist.min', 't4/files/drpy_libs', 't4/files/drpy_libs/alist.min.js', 't', 26, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (206, '2024-05-10 10:26:49.243402', 1, '2024-07-21 07:00:47.905104', 1, 0, 'node-rsa', 't4/files/drpy_libs', 't4/files/drpy_libs/node-rsa.js', 't', 200, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (168, '2024-05-06 13:28:59.871728', 1, '2024-07-21 07:00:47.909759', 1, 0, 'pako.min', 't4/files/drpy_libs', 't4/files/drpy_libs/pako.min.js', 't', 162, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (189, '2024-05-06 13:29:00.139073', 1, '2024-07-21 07:00:47.952864', 1, 0, 'alishare', 't4/files/json', 't4/files/json/alishare.txt', 't', 183, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (181, '2024-05-06 13:29:00.065029', 1, '2024-07-21 07:00:48.016417', 1, 0, 'quarkshare', 't4/files/json', 't4/files/json/quarkshare.txt', 't', 175, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (177, '2024-05-06 13:29:00.035163', 1, '2024-07-21 07:00:48.02007', 1, 0, 'sambashare', 't4/files/json', 't4/files/json/sambashare.txt', 't', 171, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (184, '2024-05-06 13:29:00.093585', 1, '2024-07-21 07:00:48.043926', 1, 0, 'xray', 't4/files/json', 't4/files/json/xray.gz', 't', 178, '.gz', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (187, '2024-05-06 13:29:00.12408', 1, '2024-07-21 07:00:48.0555', 1, 0, '白嫖筛选', 't4/files/json', 't4/files/json/白嫖筛选.json', 't', 181, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (193, '2024-05-06 13:29:00.329209', 1, '2024-07-21 07:00:48.207163', 1, 0, 'jsencrypt', 't4/files/drpy3_libs', 't4/files/drpy3_libs/jsencrypt.js', 't', 187, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (208, '2024-05-10 10:26:49.659263', 1, '2024-07-21 07:00:48.243307', 1, 0, '996影视', 't4/files/drpy3_js', 't4/files/drpy3_js/996影视.js', 't', 202, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (213, '2024-05-10 10:26:49.893219', 1, '2024-07-21 07:00:48.380325', 1, 0, '农民影视', 't4/files/drpy3_js', 't4/files/drpy3_js/农民影视.js', 't', 207, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (210, '2024-05-10 10:26:49.819937', 1, '2024-07-21 07:00:48.388802', 1, 0, '农民影视新', 't4/files/drpy3_js', 't4/files/drpy3_js/农民影视新.js', 't', 204, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (194, '2024-05-06 13:29:00.551685', 1, '2024-07-21 07:00:48.393535', 1, 0, '去广告测试源', 't4/files/drpy3_js', 't4/files/drpy3_js/去广告测试源.js', 't', 188, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (195, '2024-05-06 13:29:00.58218', 1, '2024-07-21 07:00:48.39774', 1, 0, '去广告测试源1', 't4/files/drpy3_js', 't4/files/drpy3_js/去广告测试源1.js', 't', 189, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (209, '2024-05-10 10:26:49.697753', 1, '2024-07-21 07:00:48.405888', 1, 0, '小蚂蚁资源', 't4/files/drpy3_js', 't4/files/drpy3_js/小蚂蚁资源.js', 't', 203, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (214, '2024-05-10 10:26:49.905089', 1, '2024-07-21 07:00:48.410594', 1, 0, '小蚂蚁资源2', 't4/files/drpy3_js', 't4/files/drpy3_js/小蚂蚁资源2.js', 't', 208, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (123, '2024-03-10 11:22:54.586467', 1, '2024-07-21 07:00:48.414818', 1, 0, '朱古力', 't4/files/drpy3_js', 't4/files/drpy3_js/朱古力.js', 't', 117, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (215, '2024-05-10 10:26:50.005235', 1, '2024-07-21 07:00:48.427357', 1, 0, '酷云77', 't4/files/drpy3_js', 't4/files/drpy3_js/酷云77.js', 't', 209, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (198, '2024-05-07 03:06:28.970657', 1, '2024-07-21 07:00:46.633091', 1, 0, 'TVB云播', 't4/files/drpy_js', 't4/files/drpy_js/TVB云播.js', 't', 192, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (289, '2024-05-16 08:22:12.301865', 1, '2024-07-21 07:00:46.572622', 1, 0, 'HDmoli', 't4/files/drpy_js', 't4/files/drpy_js/HDmoli.js', 't', 283, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (364, '2024-06-09 11:52:39.67463', 1, '2024-07-21 07:00:46.750368', 1, 0, '六月听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/六月听书[听].js', 't', 358, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (253, '2024-05-15 01:58:31.572212', 1, '2024-07-21 07:00:46.75435', 1, 0, '农民影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/农民影视[优].js', 't', 247, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (219, '2024-05-11 14:54:30.82851', 1, '2024-07-21 07:00:46.816821', 1, 0, '千神影视', 't4/files/drpy_js', 't4/files/drpy_js/千神影视.js', 't', 213, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (295, '2024-05-18 06:05:14.450418', 1, '2024-07-21 07:00:46.899526', 1, 0, '夕云影视', 't4/files/drpy_js', 't4/files/drpy_js/夕云影视.js', 't', 289, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (248, '2024-05-15 01:58:31.52131', 1, '2024-07-21 07:00:46.820472', 1, 0, '南瓜影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/南瓜影视[优].js', 't', 242, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (371, '2024-06-09 11:52:40.670239', 1, '2024-07-21 07:00:46.824247', 1, 0, '博看听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/博看听书[听].js', 't', 365, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (294, '2024-05-18 06:05:14.243261', 1, '2024-07-21 07:00:46.832409', 1, 0, '即看影视', 't4/files/drpy_js', 't4/files/drpy_js/即看影视.js', 't', 288, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (251, '2024-05-15 01:58:31.560381', 1, '2024-07-21 07:00:46.844351', 1, 0, '可可影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/可可影视[优].js', 't', 245, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (492, '2024-06-28 17:29:38.577123', 1, '2024-07-21 07:00:46.955732', 1, 0, '奶狗影视[慢]', 't4/files/drpy_js', 't4/files/drpy_js/奶狗影视[慢].js', 't', 486, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (327, '2024-05-26 11:05:14.471144', 1, '2024-07-21 07:00:47.000357', 1, 0, '小鱼影视', 't4/files/drpy_js', 't4/files/drpy_js/小鱼影视.js', 't', 321, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (494, '2024-06-28 17:29:38.816699', 1, '2024-07-21 07:00:47.013831', 1, 0, '影剧星球', 't4/files/drpy_js', 't4/files/drpy_js/影剧星球.js', 't', 488, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (495, '2024-06-28 17:29:38.854474', 1, '2024-07-21 07:00:47.025515', 1, 0, '影视大全', 't4/files/drpy_js', 't4/files/drpy_js/影视大全.js', 't', 489, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (496, '2024-06-28 17:29:38.92205', 1, '2024-07-21 07:00:47.037486', 1, 0, '影视控', 't4/files/drpy_js', 't4/files/drpy_js/影视控.js', 't', 490, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (326, '2024-05-26 11:05:14.399292', 1, '2024-07-21 07:00:47.0667', 1, 0, '想看影院', 't4/files/drpy_js', 't4/files/drpy_js/想看影院.js', 't', 320, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (246, '2024-05-15 01:58:31.507728', 1, '2024-07-21 07:00:47.080689', 1, 0, '我的哔哩[官]', 't4/files/drpy_js', 't4/files/drpy_js/我的哔哩[官].js', 't', 240, '.js', '?render=1&type=url&params=../json/小学教育.json@哔哩教育[官]
?render=1&type=url&params=../json/哔哩大全.json@哔哩大全[官]', 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (391, '2024-06-11 10:48:33.764903', 1, '2024-07-21 07:00:47.085502', 1, 0, '我看书斋[书]', 't4/files/drpy_js', 't4/files/drpy_js/我看书斋[书].js', 't', 385, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (275, '2024-05-15 10:03:27.285611', 1, '2024-07-21 07:00:47.131859', 1, 0, '时光影院', 't4/files/drpy_js', 't4/files/drpy_js/时光影院.js', 't', 269, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (460, '2024-06-17 16:35:38.153135', 1, '2024-07-21 07:00:47.171502', 1, 0, '星辰[优]', 't4/files/drpy_js', 't4/files/drpy_js/星辰[优].js', 't', 454, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (222, '2024-05-11 18:12:59.678594', 1, '2024-07-21 07:00:47.248568', 1, 0, '橙汁影视', 't4/files/drpy_js', 't4/files/drpy_js/橙汁影视.js', 't', 216, '.js', NULL, 1, 0, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (250, '2024-05-15 01:58:31.553866', 1, '2024-07-21 07:00:47.285169', 1, 0, '烧火影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/烧火影视[优].js', 't', 244, '.js', NULL, 1, 0, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (368, '2024-06-09 11:52:40.396283', 1, '2024-07-21 07:00:47.298514', 1, 0, '爱上你听书网[听]', 't4/files/drpy_js', 't4/files/drpy_js/爱上你听书网[听].js', 't', 362, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (254, '2024-05-15 01:58:31.578394', 1, '2024-07-21 07:00:47.333909', 1, 0, '爱看机器人[虫]', 't4/files/drpy_js', 't4/files/drpy_js/爱看机器人[虫].js', 't', 248, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (243, '2024-05-15 01:58:31.482593', 1, '2024-07-21 07:00:47.387402', 1, 0, '百忙无果[官]', 't4/files/drpy_js', 't4/files/drpy_js/百忙无果[官].js', 't', 237, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (232, '2024-05-14 17:57:11.82607', 1, '2024-07-21 07:00:47.40624', 1, 0, '看57', 't4/files/drpy_js', 't4/files/drpy_js/看57.js', 't', 226, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (323, '2024-05-26 11:05:14.16099', 1, '2024-07-21 07:00:47.438409', 1, 0, '短剧天堂', 't4/files/drpy_js', 't4/files/drpy_js/短剧天堂.js', 't', 317, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (474, '2024-06-21 08:12:29.763727', 1, '2024-07-21 07:00:47.479576', 1, 0, '策驰影院(自动)', 't4/files/drpy_js', 't4/files/drpy_js/策驰影院(自动).js', 't', 468, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (239, '2024-05-15 01:58:31.435847', 1, '2024-07-21 07:00:47.487512', 1, 0, '素白白[优]', 't4/files/drpy_js', 't4/files/drpy_js/素白白[优].js', 't', 233, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (236, '2024-05-15 01:58:31.405593', 1, '2024-07-21 07:00:47.492518', 1, 0, '索尼资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/索尼资源[资].js', 't', 230, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (245, '2024-05-15 01:58:31.499947', 1, '2024-07-21 07:00:47.515055', 1, 0, '网飞猫[优]', 't4/files/drpy_js', 't4/files/drpy_js/网飞猫[优].js', 't', 239, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (221, '2024-05-11 14:54:31.185329', 1, '2024-07-21 07:00:47.519043', 1, 0, '美剧星球', 't4/files/drpy_js', 't4/files/drpy_js/美剧星球.js', 't', 215, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (292, '2024-05-16 17:25:50.916046', 1, '2024-07-21 07:00:47.523535', 1, 0, '美益达', 't4/files/drpy_js', 't4/files/drpy_js/美益达.js', 't', 286, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (475, '2024-06-21 08:12:29.967062', 1, '2024-07-21 07:00:47.637679', 1, 0, '豆角网', 't4/files/drpy_js', 't4/files/drpy_js/豆角网.js', 't', 469, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (481, '2024-06-22 11:02:20.111866', 1, '2024-07-21 07:00:47.641634', 1, 0, '贝乐虎[儿]', 't4/files/drpy_js', 't4/files/drpy_js/贝乐虎[儿].js', 't', 475, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (249, '2024-05-15 01:58:31.534817', 1, '2024-07-21 07:00:47.694791', 1, 0, '量子资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/量子资源[资].js', 't', 243, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (244, '2024-05-15 01:58:31.489285', 1, '2024-07-21 07:00:47.715975', 1, 0, '阿里土豆[盘]', 't4/files/drpy_js', 't4/files/drpy_js/阿里土豆[盘].js', 't', 238, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (238, '2024-05-15 01:58:31.429988', 1, '2024-07-21 07:00:47.720692', 1, 0, '非凡资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/非凡资源[资].js', 't', 232, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (382, '2024-06-09 18:53:00.907928', 1, '2024-07-21 07:00:47.725304', 1, 0, '顶点小说2[书]', 't4/files/drpy_js', 't4/files/drpy_js/顶点小说2[书].js', 't', 376, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (324, '2024-05-26 11:05:14.239308', 1, '2024-07-21 07:00:47.733799', 1, 0, '飘花影院', 't4/files/drpy_js', 't4/files/drpy_js/飘花影院.js', 't', 318, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (205, '2024-05-10 10:26:49.188664', 1, '2024-07-21 07:00:47.930471', 1, 0, 'test_node_rsa', 't4/files/drpy_libs', 't4/files/drpy_libs/test_node_rsa.mjs', 't', 199, '.mjs', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (488, '2024-06-27 06:14:29.889753', 1, '2024-07-21 07:00:47.978451', 1, 0, 'live2cms', 't4/files/json', 't4/files/json/live2cms.json', 't', 482, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (477, '2024-06-21 08:12:31.526624', 1, '2024-07-21 07:00:48.074819', 1, 0, '采集[密]静态', 't4/files/json', 't4/files/json/采集[密]静态.json', 't', 471, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (259, '2024-05-15 01:58:31.644751', 1, '2024-07-21 07:00:46.593557', 1, 0, 'LIBVIO[优]', 't4/files/drpy_js', 't4/files/drpy_js/LIBVIO[优].js', 't', 253, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (235, '2024-05-15 01:58:31.392104', 1, '2024-07-21 07:00:46.605295', 1, 0, 'ok资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/ok资源[资].js', 't', 229, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (286, '2024-05-16 08:22:11.958736', 1, '2024-07-21 07:00:46.718793', 1, 0, '人人影视', 't4/files/drpy_js', 't4/files/drpy_js/人人影视.js', 't', 280, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (473, '2024-06-21 08:12:29.62317', 1, '2024-07-21 07:00:46.776182', 1, 0, '剧哥哥', 't4/files/drpy_js', 't4/files/drpy_js/剧哥哥.js', 't', 467, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (397, '2024-06-13 04:47:01.21362', 1, '2024-07-21 07:00:46.784131', 1, 0, '剧圈圈[自动]', 't4/files/drpy_js', 't4/files/drpy_js/剧圈圈[自动].js', 't', 391, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (456, '2024-06-17 16:35:37.95316', 1, '2024-07-21 07:00:46.673303', 1, 0, '七色番[漫]', 't4/files/drpy_js', 't4/files/drpy_js/七色番[漫].js', 't', 450, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (262, '2024-05-15 01:58:31.742532', 1, '2024-07-21 07:00:46.723145', 1, 0, '优酷[官]', 't4/files/drpy_js', 't4/files/drpy_js/优酷[官].js', 't', 256, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (501, '2024-06-28 17:29:39.07885', 1, '2024-07-21 07:00:46.758816', 1, 0, '冠建影视', 't4/files/drpy_js', 't4/files/drpy_js/冠建影视.js', 't', 495, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (465, '2024-06-18 16:03:22.70325', 1, '2024-07-21 07:00:46.771437', 1, 0, '刺猬影视', 't4/files/drpy_js', 't4/files/drpy_js/刺猬影视.js', 't', 459, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (416, '2024-06-15 06:37:46.295242', 1, '2024-07-21 07:00:46.792514', 1, 0, '剧集TV', 't4/files/drpy_js', 't4/files/drpy_js/剧集TV.js', 't', 410, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (454, '2024-06-17 16:35:37.847294', 1, '2024-07-21 07:00:46.804584', 1, 0, '包子漫画[画]', 't4/files/drpy_js', 't4/files/drpy_js/包子漫画[画].js', 't', 448, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (455, '2024-06-17 16:35:37.940256', 1, '2024-07-21 07:00:46.839741', 1, 0, '古风漫画[画]', 't4/files/drpy_js', 't4/files/drpy_js/古风漫画[画].js', 't', 449, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (218, '2024-05-10 18:07:08.078221', 1, '2024-07-21 07:00:46.848473', 1, 0, '可达影视', 't4/files/drpy_js', 't4/files/drpy_js/可达影视.js', 't', 212, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (263, '2024-05-15 01:58:31.767816', 1, '2024-07-21 07:00:46.864388', 1, 0, '哔哩影视[官]', 't4/files/drpy_js', 't4/files/drpy_js/哔哩影视[官].js', 't', 257, '.js', '?render=1', 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (443, '2024-06-17 16:35:37.514011', 1, '2024-07-21 07:00:46.868689', 1, 0, '哔哩直播[官]', 't4/files/drpy_js', 't4/files/drpy_js/哔哩直播[官].js', 't', 437, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (413, '2024-06-15 06:37:45.717468', 1, '2024-07-21 07:00:46.916757', 1, 0, '大师兄影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/大师兄影视[优].js', 't', 407, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (321, '2024-05-25 15:45:01.805493', 1, '2024-07-21 07:00:46.966118', 1, 0, '如意影视', 't4/files/drpy_js', 't4/files/drpy_js/如意影视.js', 't', 315, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (497, '2024-06-28 17:29:38.943632', 1, '2024-07-21 07:00:47.062641', 1, 0, '悠悠影视', 't4/files/drpy_js', 't4/files/drpy_js/悠悠影视.js', 't', 491, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (227, '2024-05-12 19:13:04.299039', 1, '2024-07-21 07:00:47.089839', 1, 0, '掌心世界', 't4/files/drpy_js', 't4/files/drpy_js/掌心世界.js', 't', 221, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (466, '2024-06-19 03:46:08.104083', 1, '2024-07-21 07:00:47.103789', 1, 0, '文才[资]', 't4/files/drpy_js', 't4/files/drpy_js/文才[资].js', 't', 460, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (503, '2024-06-28 17:29:39.13154', 1, '2024-07-21 07:00:47.136021', 1, 0, '旺旺影视', 't4/files/drpy_js', 't4/files/drpy_js/旺旺影视.js', 't', 497, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (458, '2024-06-17 16:35:38.067755', 1, '2024-07-21 07:00:47.199558', 1, 0, '有声听书网[听]', 't4/files/drpy_js', 't4/files/drpy_js/有声听书网[听].js', 't', 452, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (370, '2024-06-09 11:52:40.571796', 1, '2024-07-21 07:00:47.208234', 1, 0, '有声绘本网[听]', 't4/files/drpy_js', 't4/files/drpy_js/有声绘本网[听].js', 't', 364, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (265, '2024-05-15 01:58:31.787494', 1, '2024-07-21 07:00:47.224338', 1, 0, '极速资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/极速资源[资].js', 't', 259, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (498, '2024-06-28 17:29:39.005533', 1, '2024-07-21 07:00:47.307281', 1, 0, '爱你短剧', 't4/files/drpy_js', 't4/files/drpy_js/爱你短剧.js', 't', 492, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (399, '2024-06-13 09:30:12.582083', 1, '2024-07-21 07:00:47.312313', 1, 0, '爱爱影院[密]', 't4/files/drpy_js', 't4/files/drpy_js/爱爱影院[密].js', 't', 393, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (258, '2024-05-15 01:58:31.63836', 1, '2024-07-21 07:00:47.361322', 1, 0, '玩偶哥哥[盘]', 't4/files/drpy_js', 't4/files/drpy_js/玩偶哥哥[盘].js', 't', 252, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (277, '2024-05-15 10:03:27.706182', 1, '2024-07-21 07:00:47.39215', 1, 0, '皮皮影视', 't4/files/drpy_js', 't4/files/drpy_js/皮皮影视.js', 't', 271, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (527, '2024-06-29 18:48:15.322043', 1, '2024-07-21 07:00:47.410744', 1, 0, '看了么', 't4/files/drpy_js', 't4/files/drpy_js/看了么.js', 't', 521, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (414, '2024-06-15 06:37:45.820416', 1, '2024-07-21 07:00:47.422067', 1, 0, '看戏网', 't4/files/drpy_js', 't4/files/drpy_js/看戏网.js', 't', 408, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (402, '2024-06-13 09:30:13.440049', 1, '2024-07-21 07:00:47.500804', 1, 0, '绿色仓库[密]', 't4/files/drpy_js', 't4/files/drpy_js/绿色仓库[密].js', 't', 396, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (531, '2024-06-30 11:28:13.490823', 1, '2024-07-21 07:00:47.53265', 1, 0, '老白故事[听]', 't4/files/drpy_js', 't4/files/drpy_js/老白故事[听].js', 't', 525, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (300, '2024-05-22 15:37:30.49207', 1, '2024-07-21 07:00:47.568156', 1, 0, '茶语资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/茶语资源[资].js', 't', 294, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (341, '2024-05-29 09:43:51.239377', 1, '2024-07-21 07:00:47.60457', 1, 0, '蚂蚁影视', 't4/files/drpy_js', 't4/files/drpy_js/蚂蚁影视.js', 't', 335, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (359, '2024-06-07 10:19:39.557702', 1, '2024-07-21 07:00:47.617562', 1, 0, '蜡笔[盘]', 't4/files/drpy_js', 't4/files/drpy_js/蜡笔[盘].js', 't', 353, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (476, '2024-06-21 08:12:30.792126', 1, '2024-07-21 07:00:47.630131', 1, 0, '西瓜影院', 't4/files/drpy_js', 't4/files/drpy_js/西瓜影院.js', 't', 470, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (419, '2024-06-15 06:37:46.712731', 1, '2024-07-21 07:00:47.661421', 1, 0, '速播小屋', 't4/files/drpy_js', 't4/files/drpy_js/速播小屋.js', 't', 413, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (247, '2024-05-15 01:58:31.514489', 1, '2024-07-21 07:00:47.704942', 1, 0, '金鹰资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/金鹰资源[资].js', 't', 241, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (535, '2024-07-03 09:40:12.393191', 1, '2024-07-21 07:00:47.751297', 1, 0, '飞鱼影视', 't4/files/drpy_js', 't4/files/drpy_js/飞鱼影视.js', 't', 529, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (493, '2024-06-28 17:29:38.773312', 1, '2024-07-21 07:00:47.755734', 1, 0, '饭团影视', 't4/files/drpy_js', 't4/files/drpy_js/饭团影视.js', 't', 487, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (252, '2024-05-15 01:58:31.566244', 1, '2024-07-21 07:00:47.777813', 1, 0, '魔都资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/魔都资源[资].js', 't', 246, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (169, '2024-05-06 13:28:59.8786', 1, '2024-07-21 07:00:47.884374', 1, 0, 'jsrsa', 't4/files/drpy_libs', 't4/files/drpy_libs/jsrsa.js', 't', 163, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (487, '2024-06-27 06:14:29.819792', 1, '2024-07-21 07:00:47.995478', 1, 0, 'live_cntv', 't4/files/json', 't4/files/json/live_cntv.txt', 't', 481, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (298, '2024-05-19 02:54:49.850996', 1, '2024-07-21 07:00:48.1503', 1, 0, 'pg.jar', 't4/files/jar', 't4/files/jar/pg.jar.md5', 't', 292, '.md5', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (450, '2024-06-17 16:35:37.714918', 1, '2024-07-21 07:00:46.515283', 1, 0, '58动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/58动漫[漫].js', 't', 444, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (158, '2024-05-06 13:28:59.675887', 1, '2024-07-21 07:00:46.523263', 1, 0, '777影视', 't4/files/drpy_js', 't4/files/drpy_js/777影视.js', 't', 152, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (508, '2024-06-28 17:29:39.323715', 1, '2024-07-21 07:00:46.546843', 1, 0, 'auete', 't4/files/drpy_js', 't4/files/drpy_js/auete.js', 't', 502, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (392, '2024-06-12 02:16:52.993479', 1, '2024-07-21 07:00:46.652313', 1, 0, '一点视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/一点视频[密].js', 't', 386, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (417, '2024-06-15 06:37:46.302582', 1, '2024-07-21 07:00:46.661054', 1, 0, '一起看[优]', 't4/files/drpy_js', 't4/files/drpy_js/一起看[优].js', 't', 411, '.js', NULL, 1, 0, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (482, '2024-06-22 13:52:23.449453', 1, '2024-07-21 07:00:46.589045', 1, 0, 'KTV歌厅[听]', 't4/files/drpy_js', 't4/files/drpy_js/KTV歌厅[听].js', 't', 476, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (403, '2024-06-13 09:30:13.629543', 1, '2024-07-21 07:00:46.613227', 1, 0, 'Pornhub[密]', 't4/files/drpy_js', 't4/files/drpy_js/Pornhub[密].js', 't', 397, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (479, '2024-06-21 09:37:59.801453', 1, '2024-07-21 07:00:46.629222', 1, 0, 'script直播[飞]', 't4/files/drpy_js', 't4/files/drpy_js/script直播[飞].js', 't', 473, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (533, '2024-07-01 03:04:35.73384', 1, '2024-07-21 07:00:46.682364', 1, 0, '世纪DJ音乐网[听]', 't4/files/drpy_js', 't4/files/drpy_js/世纪DJ音乐网[听].js', 't', 527, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (404, '2024-06-13 09:30:13.762238', 1, '2024-07-21 07:00:46.700603', 1, 0, '乐草TV[密]', 't4/files/drpy_js', 't4/files/drpy_js/乐草TV[密].js', 't', 398, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (514, '2024-06-28 17:29:39.601902', 1, '2024-07-21 07:00:46.732685', 1, 0, '你好帅影院', 't4/files/drpy_js', 't4/files/drpy_js/你好帅影院.js', 't', 508, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (260, '2024-05-15 01:58:31.64995', 1, '2024-07-21 07:00:46.746121', 1, 0, '兔小贝[儿]', 't4/files/drpy_js', 't4/files/drpy_js/兔小贝[儿].js', 't', 254, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (507, '2024-06-28 17:29:39.297144', 1, '2024-07-21 07:00:46.767407', 1, 0, '刷剧网', 't4/files/drpy_js', 't4/files/drpy_js/刷剧网.js', 't', 501, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (484, '2024-06-23 07:44:50.447461', 1, '2024-07-21 07:00:46.87736', 1, 0, '啊哈DJ[听]', 't4/files/drpy_js', 't4/files/drpy_js/啊哈DJ[听].js', 't', 478, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (408, '2024-06-14 11:29:46.04784', 1, '2024-07-21 07:00:46.895376', 1, 0, '地瓜视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/地瓜视频[密].js', 't', 402, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (421, '2024-06-15 07:26:03.613655', 1, '2024-07-21 07:00:46.938205', 1, 0, '天天影视', 't4/files/drpy_js', 't4/files/drpy_js/天天影视.js', 't', 415, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (293, '2024-05-17 03:38:35.402028', 1, '2024-07-21 07:00:47.004299', 1, 0, '干饭影视', 't4/files/drpy_js', 't4/files/drpy_js/干饭影视.js', 't', 287, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (278, '2024-05-15 14:55:44.720454', 1, '2024-07-21 07:00:47.04164', 1, 0, '影视看吧', 't4/files/drpy_js', 't4/files/drpy_js/影视看吧.js', 't', 272, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (310, '2024-05-24 11:27:11.37969', 1, '2024-07-21 07:00:47.046267', 1, 0, '往往影视[慢]', 't4/files/drpy_js', 't4/files/drpy_js/往往影视[慢].js', 't', 304, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (325, '2024-05-26 11:05:14.346694', 1, '2024-07-21 07:00:47.070911', 1, 0, '我播', 't4/files/drpy_js', 't4/files/drpy_js/我播.js', 't', 319, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (306, '2024-05-23 10:17:08.251026', 1, '2024-07-21 07:00:47.118139', 1, 0, '新视觉', 't4/files/drpy_js', 't4/files/drpy_js/新视觉.js', 't', 300, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (373, '2024-06-09 11:52:40.785964', 1, '2024-07-21 07:00:47.203812', 1, 0, '有声小说吧[听]', 't4/files/drpy_js', 't4/files/drpy_js/有声小说吧[听].js', 't', 367, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (511, '2024-06-28 17:29:39.454136', 1, '2024-07-21 07:00:47.255993', 1, 0, '毒蛇电影[优]', 't4/files/drpy_js', 't4/files/drpy_js/毒蛇电影[优].js', 't', 505, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (311, '2024-05-24 11:27:11.451805', 1, '2024-07-21 07:00:47.329999', 1, 0, '爱看影院', 't4/files/drpy_js', 't4/files/drpy_js/爱看影院.js', 't', 305, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (301, '2024-05-22 15:37:30.714152', 1, '2024-07-21 07:00:47.365247', 1, 0, '电影先生', 't4/files/drpy_js', 't4/files/drpy_js/电影先生.js', 't', 295, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (351, '2024-06-04 16:02:34.463798', 1, '2024-07-21 07:00:47.434708', 1, 0, '短剧在线', 't4/files/drpy_js', 't4/files/drpy_js/短剧在线.js', 't', 345, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (409, '2024-06-14 11:29:46.086636', 1, '2024-07-21 07:00:47.447237', 1, 0, '神仙影视', 't4/files/drpy_js', 't4/files/drpy_js/神仙影视.js', 't', 403, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (528, '2024-06-29 18:48:15.728118', 1, '2024-07-21 07:00:47.463186', 1, 0, '童趣[儿]', 't4/files/drpy_js', 't4/files/drpy_js/童趣[儿].js', 't', 522, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (525, '2024-06-29 18:48:15.115202', 1, '2024-07-21 07:00:47.466895', 1, 0, '笔趣阁13[书]', 't4/files/drpy_js', 't4/files/drpy_js/笔趣阁13[书].js', 't', 519, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (483, '2024-06-23 07:44:50.005863', 1, '2024-07-21 07:00:47.504797', 1, 0, '网飞.TV', 't4/files/drpy_js', 't4/files/drpy_js/网飞.TV.js', 't', 477, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (505, '2024-06-28 17:29:39.177992', 1, '2024-07-21 07:00:47.511018', 1, 0, '网飞啦[自动]', 't4/files/drpy_js', 't4/files/drpy_js/网飞啦[自动].js', 't', 499, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (261, '2024-05-15 01:58:31.674151', 1, '2024-07-21 07:00:47.564109', 1, 0, '花子动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/花子动漫[漫].js', 't', 255, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (401, '2024-06-13 09:30:13.409227', 1, '2024-07-21 07:00:47.572719', 1, 0, '草莓秒播[密]', 't4/files/drpy_js', 't4/files/drpy_js/草莓秒播[密].js', 't', 395, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (264, '2024-05-15 01:58:31.781694', 1, '2024-07-21 07:00:47.581984', 1, 0, '菜狗[官]', 't4/files/drpy_js', 't4/files/drpy_js/菜狗[官].js', 't', 258, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (340, '2024-05-29 09:43:51.225532', 1, '2024-07-21 07:00:47.62124', 1, 0, '被窝电影', 't4/files/drpy_js', 't4/files/drpy_js/被窝电影.js', 't', 334, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (426, '2024-06-17 10:13:18.768409', 1, '2024-07-21 07:00:47.657021', 1, 0, '追剧兔', 't4/files/drpy_js', 't4/files/drpy_js/追剧兔.js', 't', 420, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (313, '2024-05-24 11:27:11.648413', 1, '2024-07-21 07:00:47.764697', 1, 0, '首发网', 't4/files/drpy_js', 't4/files/drpy_js/首发网.js', 't', 307, '.js', NULL, 1, 0, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (309, '2024-05-24 11:27:11.179552', 1, '2024-07-21 07:00:47.772983', 1, 0, '魔方影视', 't4/files/drpy_js', 't4/files/drpy_js/魔方影视.js', 't', 303, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (305, '2024-05-22 15:37:31.081034', 1, '2024-07-21 07:00:47.880714', 1, 0, 'jsonpathplus.min', 't4/files/drpy_libs', 't4/files/drpy_libs/jsonpathplus.min.js', 't', 299, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (489, '2024-06-28 03:59:52.919927', 1, '2024-07-21 07:00:47.990377', 1, 0, 'live_1905', 't4/files/json', 't4/files/json/live_1905.txt', 't', 483, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (297, '2024-05-19 02:54:49.604439', 1, '2024-07-21 07:00:48.032414', 1, 0, 'tokenm.readme', 't4/files/json', 't4/files/json/tokenm.readme.txt', 't', 291, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (470, '2024-06-20 08:09:36.824176', 1, '2024-07-21 07:00:48.059624', 1, 0, '采集', 't4/files/json', 't4/files/json/采集.json', 't', 464, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (478, '2024-06-21 08:12:31.667313', 1, '2024-07-21 07:00:48.071021', 1, 0, '采集[密]', 't4/files/json', 't4/files/json/采集[密].json', 't', 472, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (471, '2024-06-21 03:08:09.106307', 1, '2024-07-21 07:00:48.086423', 1, 0, '采集静态', 't4/files/json', 't4/files/json/采集静态.json', 't', 465, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (526, '2024-06-29 18:48:15.204415', 1, '2024-07-21 07:00:46.475857', 1, 0, '360吧[球]', 't4/files/drpy_js', 't4/files/drpy_js/360吧[球].js', 't', 520, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (290, '2024-05-16 10:22:36.277247', 1, '2024-07-21 07:00:46.497646', 1, 0, '4khdr', 't4/files/drpy_js', 't4/files/drpy_js/4khdr.js', 't', 284, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (307, '2024-05-24 05:50:49.019486', 1, '2024-07-21 07:00:46.501765', 1, 0, '4k剧院', 't4/files/drpy_js', 't4/files/drpy_js/4k剧院.js', 't', 301, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (299, '2024-05-22 15:37:30.45444', 1, '2024-07-21 07:00:46.536711', 1, 0, '8号影院', 't4/files/drpy_js', 't4/files/drpy_js/8号影院.js', 't', 293, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (485, '2024-06-23 07:44:50.681434', 1, '2024-07-21 07:00:46.541659', 1, 0, 'ASMR[听]', 't4/files/drpy_js', 't4/files/drpy_js/ASMR[听].js', 't', 479, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (524, '2024-06-28 17:29:40.143397', 1, '2024-07-21 07:00:46.855826', 1, 0, '咖啡影视', 't4/files/drpy_js', 't4/files/drpy_js/咖啡影视.js', 't', 518, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (352, '2024-06-04 16:02:34.722625', 1, '2024-07-21 07:00:46.86021', 1, 0, '哈皮影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/哈皮影视[优].js', 't', 346, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (315, '2024-05-24 15:02:58.934514', 1, '2024-07-21 07:00:46.907765', 1, 0, '大中国', 't4/files/drpy_js', 't4/files/drpy_js/大中国.js', 't', 309, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (517, '2024-06-28 17:29:39.706881', 1, '2024-07-21 07:00:46.912831', 1, 0, '大千视界', 't4/files/drpy_js', 't4/files/drpy_js/大千视界.js', 't', 511, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (536, '2024-07-03 09:40:13.539701', 1, '2024-07-21 07:00:46.943339', 1, 0, '天龙影院', 't4/files/drpy_js', 't4/files/drpy_js/天龙影院.js', 't', 530, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (521, '2024-06-28 17:29:39.9288', 1, '2024-07-21 07:00:46.951658', 1, 0, '奈飞中文[自动]', 't4/files/drpy_js', 't4/files/drpy_js/奈飞中文[自动].js', 't', 515, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (512, '2024-06-28 17:29:39.521892', 1, '2024-07-21 07:00:46.987924', 1, 0, '小女18[密]', 't4/files/drpy_js', 't4/files/drpy_js/小女18[密].js', 't', 506, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (342, '2024-05-29 16:32:00.072648', 1, '2024-07-21 07:00:47.017614', 1, 0, '影搜[搜]', 't4/files/drpy_js', 't4/files/drpy_js/影搜[搜].js', 't', 336, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (502, '2024-06-28 17:29:39.085555', 1, '2024-07-21 07:00:47.021316', 1, 0, '影渣渣影视', 't4/files/drpy_js', 't4/files/drpy_js/影渣渣影视.js', 't', 496, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (513, '2024-06-28 17:29:39.596409', 1, '2024-07-21 07:00:47.14507', 1, 0, '易点看影院[自动]', 't4/files/drpy_js', 't4/files/drpy_js/易点看影院[自动].js', 't', 507, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (230, '2024-05-14 08:53:58.895365', 1, '2024-07-21 07:00:47.149423', 1, 0, '易看影视', 't4/files/drpy_js', 't4/files/drpy_js/易看影视.js', 't', 224, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (406, '2024-06-14 11:29:44.98418', 1, '2024-07-21 07:00:47.167553', 1, 0, '星辰CT', 't4/files/drpy_js', 't4/files/drpy_js/星辰CT.js', 't', 400, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (314, '2024-05-24 15:02:58.712225', 1, '2024-07-21 07:00:47.176158', 1, 0, '星辰影视', 't4/files/drpy_js', 't4/files/drpy_js/星辰影视.js', 't', 308, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (510, '2024-06-28 17:29:39.437184', 1, '2024-07-21 07:00:47.18071', 1, 0, '映播TV', 't4/files/drpy_js', 't4/files/drpy_js/映播TV.js', 't', 504, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (339, '2024-05-29 09:43:50.994075', 1, '2024-07-21 07:00:47.185384', 1, 0, '暖光影视', 't4/files/drpy_js', 't4/files/drpy_js/暖光影视.js', 't', 333, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (500, '2024-06-28 17:29:39.030817', 1, '2024-07-21 07:00:47.216458', 1, 0, '来看点播[自动]', 't4/files/drpy_js', 't4/files/drpy_js/来看点播[自动].js', 't', 494, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (486, '2024-06-27 06:14:27.794168', 1, '2024-07-21 07:00:47.397146', 1, 0, '直播转点播[合]', 't4/files/drpy_js', 't4/files/drpy_js/直播转点播[合].js', 't', 480, '.js', '?type=url&params=../json/live2cms.json', 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (317, '2024-05-24 15:02:59.308858', 1, '2024-07-21 07:00:47.430713', 1, 0, '短剧TV网', 't4/files/drpy_js', 't4/files/drpy_js/短剧TV网.js', 't', 311, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (504, '2024-06-28 17:29:39.137449', 1, '2024-07-21 07:00:47.451054', 1, 0, '神马影院[自动]', 't4/files/drpy_js', 't4/files/drpy_js/神马影院[自动].js', 't', 498, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (233, '2024-05-15 01:58:31.371139', 1, '2024-07-21 07:00:47.454841', 1, 0, '神马电影[搜]', 't4/files/drpy_js', 't4/files/drpy_js/神马电影[搜].js', 't', 227, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (266, '2024-05-15 01:58:31.798737', 1, '2024-07-21 07:00:47.577533', 1, 0, '荐片[优]', 't4/files/drpy_js', 't4/files/drpy_js/荐片[优].js', 't', 260, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (360, '2024-06-07 11:27:00.043484', 1, '2024-07-21 07:00:47.60057', 1, 0, '虾酱追剧', 't4/files/drpy_js', 't4/files/drpy_js/虾酱追剧.js', 't', 354, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (530, '2024-06-29 18:48:15.984977', 1, '2024-07-21 07:00:47.645832', 1, 0, '路漫漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/路漫漫[漫].js', 't', 524, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (464, '2024-06-18 16:03:22.408803', 1, '2024-07-21 07:00:47.64959', 1, 0, '路视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/路视频[密].js', 't', 458, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (405, '2024-06-13 09:57:03.147083', 1, '2024-07-21 07:00:47.672915', 1, 0, '酷云影视', 't4/files/drpy_js', 't4/files/drpy_js/酷云影视.js', 't', 399, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (375, '2024-06-09 16:28:15.749009', 1, '2024-07-21 07:00:47.729853', 1, 0, '顶点小说[书]', 't4/files/drpy_js', 't4/files/drpy_js/顶点小说[书].js', 't', 369, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (461, '2024-06-17 16:45:34.704071', 1, '2024-07-21 07:00:47.738279', 1, 0, '飞刀资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/飞刀资源[资].js', 't', 455, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (522, '2024-06-28 17:29:40.100944', 1, '2024-07-21 07:00:47.760661', 1, 0, '饺子影院', 't4/files/drpy_js', 't4/files/drpy_js/饺子影院.js', 't', 516, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (302, '2024-05-22 15:37:30.839785', 1, '2024-07-21 07:00:47.782064', 1, 0, '鸭奈飞影视', 't4/files/drpy_js', 't4/files/drpy_js/鸭奈飞影视.js', 't', 296, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (304, '2024-05-22 15:37:30.945724', 1, '2024-07-21 07:00:47.865325', 1, 0, 'jinja', 't4/files/drpy_libs', 't4/files/drpy_libs/jinja.js', 't', 298, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (303, '2024-05-22 15:37:30.92702', 1, '2024-07-21 07:00:47.868991', 1, 0, 'jinja.min', 't4/files/drpy_libs', 't4/files/drpy_libs/jinja.min.js', 't', 297, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (532, '2024-07-01 01:07:47.899313', 1, '2024-07-21 07:00:47.901032', 1, 0, 'node-rsa-new', 't4/files/drpy_libs', 't4/files/drpy_libs/node-rsa-new.js', 't', 526, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (490, '2024-06-28 08:41:05.127187', 1, '2024-07-21 07:00:47.986544', 1, 0, 'lives', 't4/files/json', 't4/files/json/lives.jpg', 't', 484, '.jpg', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (537, '2024-07-04 07:36:34.080705', 1, '2024-07-21 07:00:48.067191', 1, 0, '采集[zy]静态', 't4/files/json', 't4/files/json/采集[zy]静态.json', 't', 531, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (472, '2024-06-21 03:08:09.177447', 1, '2024-07-21 07:00:48.078808', 1, 0, '采集分类生成器', 't4/files/json', 't4/files/json/采集分类生成器.py', 't', 466, '.py', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (217, '2024-05-10 18:07:08.061654', 1, '2024-07-21 07:00:46.656238', 1, 0, '一起看', 't4/files/drpy_js', 't4/files/drpy_js/一起看.js', 't', 211, '.js', NULL, 1, 0, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (378, '2024-06-09 18:53:00.029263', 1, '2024-07-21 07:00:46.690427', 1, 0, '丫丫电子书[书]', 't4/files/drpy_js', 't4/files/drpy_js/丫丫电子书[书].js', 't', 372, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (394, '2024-06-12 02:16:53.640653', 1, '2024-07-21 07:00:46.704988', 1, 0, '九妖仓库[密]', 't4/files/drpy_js', 't4/files/drpy_js/九妖仓库[密].js', 't', 388, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (316, '2024-05-24 15:02:59.295906', 1, '2024-07-21 07:00:46.780384', 1, 0, '剧圈圈', 't4/files/drpy_js', 't4/files/drpy_js/剧圈圈.js', 't', 310, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (509, '2024-06-28 17:29:39.421704', 1, '2024-07-21 07:00:46.787849', 1, 0, '剧迷', 't4/files/drpy_js', 't4/files/drpy_js/剧迷.js', 't', 503, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (550, '2024-07-11 04:24:58.012583', 1, '2024-07-21 07:00:46.741805', 1, 0, '兄弟影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/兄弟影视[优].js', 't', 544, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (480, '2024-06-21 18:04:29.776016', 1, '2024-07-21 07:00:46.763157', 1, 0, '分享短视频', 't4/files/drpy_js', 't4/files/drpy_js/分享短视频.js', 't', 474, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (552, '2024-07-11 04:24:58.146698', 1, '2024-07-21 07:00:46.872597', 1, 0, '哔嘀影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/哔嘀影视[优].js', 't', 546, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (554, '2024-07-11 04:24:58.259928', 1, '2024-07-21 07:00:46.992364', 1, 0, '小白菜电影', 't4/files/drpy_js', 't4/files/drpy_js/小白菜电影.js', 't', 548, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (557, '2024-07-11 04:24:58.346753', 1, '2024-07-21 07:00:47.075742', 1, 0, '我爱跟剧', 't4/files/drpy_js', 't4/files/drpy_js/我爱跟剧.js', 't', 551, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (468, '2024-06-20 05:33:14.918191', 1, '2024-07-21 07:00:47.845157', 1, 0, 'drpy_libs', 't4/files/drpy_libs', 't4/files/drpy_libs/drpy_libs.zip', 't', 462, '.zip', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (539, '2024-07-04 07:36:34.264364', 1, '2024-07-21 07:00:48.063497', 1, 0, '采集[zy]', 't4/files/json', 't4/files/json/采集[zy].json', 't', 533, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (538, '2024-07-04 07:36:34.200843', 1, '2024-07-21 07:00:48.08273', 1, 0, '采集转换器', 't4/files/json', 't4/files/json/采集转换器.py', 't', 532, '.py', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (1, '2024-02-01 14:31:22.022744', 1, '2024-07-21 07:00:45.411996', 1, 0, 'ad', 't4/spiders', 't4/spiders/ad.m3u8', 't', 9999, '.m3u8', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (2, '2024-02-01 14:31:22.043862', 1, '2024-07-21 07:00:46.388575', 1, 0, 'base_java_loader', 't4/spiders', 't4/spiders/base_java_loader.py', 't', 0, '.py', NULL, 1, 1, 1, 0, 'f');
INSERT INTO "public"."t_vod_rules" VALUES (3, '2024-02-01 14:31:22.048522', 1, '2024-07-21 07:00:46.3934', 1, 0, 'base_spider', 't4/spiders', 't4/spiders/base_spider.json', 't', 9999, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (14, '2024-02-01 14:31:22.093364', 1, '2024-07-21 07:00:46.453644', 1, 0, '樱花动漫', 't4/spiders', 't4/spiders/樱花动漫.py', 't', 14, '.py', 'https://jihulab.com/qiaoji/open/-/raw/main/yinghua', 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (400, '2024-06-13 09:30:12.734734', 1, '2024-07-21 07:00:46.462108', 1, 0, '29片库[密]', 't4/files/drpy_js', 't4/files/drpy_js/29片库[密].js', 't', 394, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (540, '2024-07-11 04:24:57.751284', 1, '2024-07-21 07:00:46.471139', 1, 0, '348电影网', 't4/files/drpy_js', 't4/files/drpy_js/348电影网.js', 't', 534, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (241, '2024-05-15 01:58:31.470023', 1, '2024-07-21 07:00:46.480404', 1, 0, '360影视[官]', 't4/files/drpy_js', 't4/files/drpy_js/360影视[官].js', 't', 235, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (529, '2024-06-29 18:48:15.739336', 1, '2024-07-21 07:00:46.484481', 1, 0, '36直播[密]', 't4/files/drpy_js', 't4/files/drpy_js/36直播[密].js', 't', 523, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (541, '2024-07-11 04:24:57.773781', 1, '2024-07-21 07:00:46.488361', 1, 0, '420电影院', 't4/files/drpy_js', 't4/files/drpy_js/420电影院.jsd', 't', 535, '.jsd', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (542, '2024-07-11 04:24:57.778047', 1, '2024-07-21 07:00:46.492869', 1, 0, '4K-AV', 't4/files/drpy_js', 't4/files/drpy_js/4K-AV.js', 't', 536, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (543, '2024-07-11 04:24:57.791103', 1, '2024-07-21 07:00:46.505832', 1, 0, '539影视', 't4/files/drpy_js', 't4/files/drpy_js/539影视.js', 't', 537, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (56, '2024-02-02 16:38:12.276321', 1, '2024-07-21 07:00:46.511131', 1, 0, '555影视[飞]', 't4/files/drpy_js', 't4/files/drpy_js/555影视[飞].js', 't', 56, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (356, '2024-06-06 09:12:14.548884', 1, '2024-07-21 07:00:46.5287', 1, 0, '7猫小说[书]', 't4/files/drpy_js', 't4/files/drpy_js/7猫小说[书].js', 't', 350, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (544, '2024-07-11 04:24:57.83843', 1, '2024-07-21 07:00:46.555317', 1, 0, 'B站影视', 't4/files/drpy_js', 't4/files/drpy_js/B站影视.js', 't', 538, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (545, '2024-07-11 04:24:57.84695', 1, '2024-07-21 07:00:46.56833', 1, 0, 'FreeOKLOL', 't4/files/drpy_js', 't4/files/drpy_js/FreeOKLOL.js', 't', 539, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (420, '2024-06-15 06:37:46.76684', 1, '2024-07-21 07:00:46.585193', 1, 0, 'iku喵[资]', 't4/files/drpy_js', 't4/files/drpy_js/iku喵[资].js', 't', 414, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (546, '2024-07-11 04:24:57.897755', 1, '2024-07-21 07:00:46.617051', 1, 0, 'PTT[优]', 't4/files/drpy_js', 't4/files/drpy_js/PTT[优].js', 't', 540, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (547, '2024-07-11 04:24:57.902316', 1, '2024-07-21 07:00:46.621238', 1, 0, 'PTT追剧大师', 't4/files/drpy_js', 't4/files/drpy_js/PTT追剧大师.js', 't', 541, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (312, '2024-05-24 11:27:11.56854', 1, '2024-07-21 07:00:46.640493', 1, 0, '一号影院[搜]', 't4/files/drpy_js', 't4/files/drpy_js/一号影院[搜].js', 't', 306, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (463, '2024-06-18 16:03:22.235527', 1, '2024-07-21 07:00:46.669285', 1, 0, '七新电影网', 't4/files/drpy_js', 't4/files/drpy_js/七新电影网.js', 't', 457, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (499, '2024-06-28 17:29:39.012694', 1, '2024-07-21 07:00:46.67835', 1, 0, '三集电影[自动]', 't4/files/drpy_js', 't4/files/drpy_js/三集电影[自动].js', 't', 493, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (548, '2024-07-11 04:24:57.964545', 1, '2024-07-21 07:00:46.686166', 1, 0, '两个BT', 't4/files/drpy_js', 't4/files/drpy_js/两个BT.js', 't', 542, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (422, '2024-06-15 07:26:04.357302', 1, '2024-07-21 07:00:46.710462', 1, 0, '九牛电影', 't4/files/drpy_js', 't4/files/drpy_js/九牛电影.js', 't', 416, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (549, '2024-07-11 04:24:57.999153', 1, '2024-07-21 07:00:46.728615', 1, 0, '低端', 't4/files/drpy_js', 't4/files/drpy_js/低端.js', 't', 543, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (551, '2024-07-11 04:24:58.080321', 1, '2024-07-21 07:00:46.808479', 1, 0, '北川影视', 't4/files/drpy_js', 't4/files/drpy_js/北川影视.js', 't', 545, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (506, '2024-06-28 17:29:39.273349', 1, '2024-07-21 07:00:46.885994', 1, 0, '嘀哩嘀哩', 't4/files/drpy_js', 't4/files/drpy_js/嘀哩嘀哩.js', 't', 500, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (553, '2024-07-11 04:24:58.246918', 1, '2024-07-21 07:00:46.979301', 1, 0, '宇航影视', 't4/files/drpy_js', 't4/files/drpy_js/宇航影视.js', 't', 547, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (555, '2024-07-11 04:24:58.298195', 1, '2024-07-21 07:00:47.030086', 1, 0, '影视工厂', 't4/files/drpy_js', 't4/files/drpy_js/影视工厂.js', 't', 549, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (556, '2024-07-11 04:24:58.302616', 1, '2024-07-21 07:00:47.033817', 1, 0, '影视工场', 't4/files/drpy_js', 't4/files/drpy_js/影视工场.js', 't', 550, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (563, '2024-07-11 04:24:58.55803', 1, '2024-07-21 07:00:47.302427', 1, 0, '爱优影视[自动]', 't4/files/drpy_js', 't4/files/drpy_js/爱优影视[自动].js', 't', 557, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (520, '2024-06-28 17:29:39.901488', 1, '2024-07-21 07:00:47.418344', 1, 0, '看客视频', 't4/files/drpy_js', 't4/files/drpy_js/看客视频.js', 't', 514, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (353, '2024-06-04 16:02:34.734751', 1, '2024-07-21 07:00:47.470891', 1, 0, '笔趣阁[书]', 't4/files/drpy_js', 't4/files/drpy_js/笔趣阁[书].js', 't', 347, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (534, '2024-07-02 09:37:40.061626', 1, '2024-07-21 07:00:47.710814', 1, 0, '闪雷电', 't4/files/drpy_js', 't4/files/drpy_js/闪雷电.js', 't', 528, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (491, '2024-06-28 17:29:38.486352', 1, '2024-07-21 07:00:47.742928', 1, 0, '飞狗影院[密]', 't4/files/drpy_js', 't4/files/drpy_js/飞狗影院[密].js', 't', 485, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (398, '2024-06-13 09:30:12.352712', 1, '2024-07-21 07:00:47.795457', 1, 0, '黑料不打烊[密]', 't4/files/drpy_js', 't4/files/drpy_js/黑料不打烊[密].js', 't', 392, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (523, '2024-06-28 17:29:40.121992', 1, '2024-07-21 07:00:47.127655', 1, 0, '无忧影视', 't4/files/drpy_js', 't4/files/drpy_js/无忧影视.js', 't', 517, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (558, '2024-07-11 04:24:58.424822', 1, '2024-07-21 07:00:47.163162', 1, 0, '星芽短剧[优]', 't4/files/drpy_js', 't4/files/drpy_js/星芽短剧[优].js', 't', 552, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (562, '2024-07-11 04:24:58.538079', 1, '2024-07-21 07:00:47.281234', 1, 0, '火狐影视', 't4/files/drpy_js', 't4/files/drpy_js/火狐影视.js', 't', 556, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (567, '2024-07-11 04:24:58.778672', 1, '2024-07-21 07:00:47.554789', 1, 0, '至臻[盘]', 't4/files/drpy_js', 't4/files/drpy_js/至臻[盘].js', 't', 561, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (172, '2024-05-06 13:28:59.919464', 1, '2024-07-21 07:00:47.872694', 1, 0, 'jsencrypt', 't4/files/drpy_libs', 't4/files/drpy_libs/jsencrypt.js', 't', 166, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (559, '2024-07-11 04:24:58.470372', 1, '2024-07-21 07:00:47.212648', 1, 0, '朴樱影视', 't4/files/drpy_js', 't4/files/drpy_js/朴樱影视.js', 't', 553, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (560, '2024-07-11 04:24:58.48638', 1, '2024-07-21 07:00:47.228773', 1, 0, '桃子影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/桃子影视[优].js', 't', 554, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (565, '2024-07-11 04:24:58.597063', 1, '2024-07-21 07:00:47.34731', 1, 0, '爱迪影视', 't4/files/drpy_js', 't4/files/drpy_js/爱迪影视.js', 't', 559, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (94, '2024-03-10 11:22:54.446128', 1, '2024-07-21 07:00:48.263612', 1, 0, 'cilixiongp', 't4/files/drpy3_js', 't4/files/drpy3_js/cilixiongp.js', 't', 88, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (115, '2024-03-10 11:22:54.545975', 1, '2024-07-21 07:00:48.431304', 1, 0, 'template', 't4/files/drpy3_js', 't4/files/drpy3_js/template.js', 'f', 109, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (561, '2024-07-11 04:24:58.499122', 1, '2024-07-21 07:00:47.240114', 1, 0, '樱花影视', 't4/files/drpy_js', 't4/files/drpy_js/樱花影视.jsd', 't', 555, '.jsd', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (518, '2024-06-28 17:29:39.813248', 1, '2024-07-21 07:00:47.271533', 1, 0, '游子视频', 't4/files/drpy_js', 't4/files/drpy_js/游子视频.js', 't', 512, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (469, '2024-06-20 08:09:35.210993', 1, '2024-07-21 07:00:47.685462', 1, 0, '采集之王[合]', 't4/files/drpy_js', 't4/files/drpy_js/采集之王[合].js', 't', 463, '.js', '?type=url&params=../json/采集静态.json$1@采王道长[合]
?type=url&params=../json/采集[zy]静态.json$1@采王zy[密]
?type=url&params=../json/采集[密]静态.json@采王成人[密]', 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (588, '2024-07-21 06:28:38.224492', 1, '2024-07-21 07:00:47.586558', 1, 0, '萌番[漫]', 't4/files/drpy_js', 't4/files/drpy_js/萌番[漫].js', 't', 582, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (593, '2024-07-21 06:28:38.72619', 1, '2024-07-21 07:00:48.120101', 1, 0, 'robots', 't4/files/txt', 't4/files/txt/robots.txt', 't', 587, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (224, '2024-05-11 18:13:00.525395', 1, '2024-07-21 07:00:48.422781', 1, 0, '白嫖影视', 't4/files/drpy3_js', 't4/files/drpy3_js/白嫖影视.js', 't', 218, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (582, '2024-07-21 06:28:37.782445', 1, '2024-07-21 07:00:47.099577', 1, 0, '文才2[资]', 't4/files/drpy_js', 't4/files/drpy_js/文才2[资].js', 't', 576, '.js', NULL, 1, 1, 0, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (583, '2024-07-21 06:28:37.802406', 1, '2024-07-21 07:00:47.12271', 1, 0, '旋风视频', 't4/files/drpy_js', 't4/files/drpy_js/旋风视频.js', 't', 577, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (331, '2024-05-27 12:03:03.995243', 1, '2024-07-21 07:00:47.32078', 1, 0, '爱看农民2[优]', 't4/files/drpy_js', 't4/files/drpy_js/爱看农民2[优].js', 't', 325, '.js', NULL, 1, 1, 1, 1, 't');
INSERT INTO "public"."t_vod_rules" VALUES (564, '2024-07-11 04:24:58.589462', 1, '2024-07-21 07:00:47.338412', 1, 0, '爱看短剧[盘]', 't4/files/drpy_js', 't4/files/drpy_js/爱看短剧[盘].js', 't', 558, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (428, '2024-06-17 16:02:19.755238', 1, '2024-07-21 07:00:47.356383', 1, 0, '猫视界', 't4/files/drpy_js', 't4/files/drpy_js/猫视界.js', 't', 422, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (584, '2024-07-21 06:28:38.030974', 1, '2024-07-21 07:00:47.374064', 1, 0, '番号资源[密]', 't4/files/drpy_js', 't4/files/drpy_js/番号资源[密].js', 't', 578, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (585, '2024-07-21 06:28:38.108911', 1, '2024-07-21 07:00:47.459086', 1, 0, '种子音乐[听]', 't4/files/drpy_js', 't4/files/drpy_js/种子音乐[听].js', 't', 579, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (566, '2024-07-11 04:24:58.715716', 1, '2024-07-21 07:00:47.48354', 1, 0, '米爱影视', 't4/files/drpy_js', 't4/files/drpy_js/米爱影视.js', 't', 560, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (586, '2024-07-21 06:28:38.191581', 1, '2024-07-21 07:00:47.550678', 1, 0, '臭蛋蛋', 't4/files/drpy_js', 't4/files/drpy_js/臭蛋蛋.js', 't', 580, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (587, '2024-07-21 06:28:38.19963', 1, '2024-07-21 07:00:47.559958', 1, 0, '色库[密]', 't4/files/drpy_js', 't4/files/drpy_js/色库[密].js', 't', 581, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (568, '2024-07-11 04:24:58.86395', 1, '2024-07-21 07:00:47.653275', 1, 0, '达达龟', 't4/files/drpy_js', 't4/files/drpy_js/达达龟.js', 't', 562, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (589, '2024-07-21 06:28:38.299581', 1, '2024-07-21 07:00:47.665446', 1, 0, '速讯影院', 't4/files/drpy_js', 't4/files/drpy_js/速讯影院.js', 't', 583, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (590, '2024-07-21 06:28:38.303646', 1, '2024-07-21 07:00:47.669178', 1, 0, '那兔视频', 't4/files/drpy_js', 't4/files/drpy_js/那兔视频.js', 't', 584, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (280, '2024-05-16 08:22:11.751243', 1, '2024-07-21 07:00:47.677232', 1, 0, '酷客影视', 't4/files/drpy_js', 't4/files/drpy_js/酷客影视.js', 't', 274, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (572, '2024-07-13 13:30:35.90288', 1, '2024-07-21 07:00:47.681105', 1, 0, '酷我听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/酷我听书[听].js', 't', 566, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (569, '2024-07-13 13:30:34.544697', 1, '2024-07-21 07:00:46.409831', 1, 0, 'emby', 't4/spiders', 't4/spiders/emby.json', 't', 563, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (570, '2024-07-13 13:30:34.553157', 1, '2024-07-21 07:00:46.413851', 1, 0, 'emby', 't4/spiders', 't4/spiders/emby.py', 't', 564, '.py', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (577, '2024-07-21 06:28:37.170209', 1, '2024-07-21 07:00:46.457724', 1, 0, '01看球[球]', 't4/files/drpy_js', 't4/files/drpy_js/01看球[球].js', 't', 571, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (578, '2024-07-21 06:28:37.184299', 1, '2024-07-21 07:00:46.467053', 1, 0, '310直播[球]', 't4/files/drpy_js', 't4/files/drpy_js/310直播[球].js', 't', 572, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (574, '2024-07-17 12:40:20.7292', 1, '2024-07-21 07:00:46.56046', 1, 0, 'cally66', 't4/files/drpy_js', 't4/files/drpy_js/cally66.js', 't', 568, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (591, '2024-07-21 06:28:38.332042', 1, '2024-07-21 07:00:47.699728', 1, 0, '金牌影院', 't4/files/drpy_js', 't4/files/drpy_js/金牌影院.js', 't', 585, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (573, '2024-07-13 13:30:36.111061', 1, '2024-07-21 07:00:47.876906', 1, 0, 'json5', 't4/files/drpy_libs', 't4/files/drpy_libs/json5.js', 't', 567, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (173, '2024-05-06 13:28:59.982973', 1, '2024-07-21 07:00:47.948038', 1, 0, 'alishare.ebook', 't4/files/json', 't4/files/json/alishare.ebook.txt', 't', 167, '.txt', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (576, '2024-07-17 12:40:23.455546', 1, '2024-07-21 07:00:48.047915', 1, 0, '哔哩大全', 't4/files/json', 't4/files/json/哔哩大全.json', 't', 570, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (592, '2024-07-21 06:28:38.659476', 1, '2024-07-21 07:00:48.051573', 1, 0, '哔哩教育', 't4/files/json', 't4/files/json/哔哩教育.json', 't', 586, '.json', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (579, '2024-07-21 06:28:37.356525', 1, '2024-07-21 07:00:46.64469', 1, 0, '一支穿云箭', 't4/files/drpy_js', 't4/files/drpy_js/一支穿云箭.js', 't', 573, '.js', NULL, 1, 1, 1, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (575, '2024-07-17 12:40:20.893283', 1, '2024-07-21 07:00:46.648558', 1, 0, '一曲肝肠断', 't4/files/drpy_js', 't4/files/drpy_js/一曲肝肠断.js', 't', 569, '.js', NULL, 1, 0, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (580, '2024-07-21 06:28:37.404862', 1, '2024-07-21 07:00:46.696115', 1, 0, '中华听书网[听]', 't4/files/drpy_js', 't4/files/drpy_js/中华听书网[听].js', 't', 574, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (581, '2024-07-21 06:28:37.55591', 1, '2024-07-21 07:00:46.852139', 1, 0, '咕咕番[漫]', 't4/files/drpy_js', 't4/files/drpy_js/咕咕番[漫].js', 't', 575, '.js', NULL, 1, 1, 0, 0, 't');
INSERT INTO "public"."t_vod_rules" VALUES (571, '2024-07-13 13:30:35.039236', 1, '2024-07-21 07:00:46.881774', 1, 0, '喜马拉雅[听]', 't4/files/drpy_js', 't4/files/drpy_js/喜马拉雅[听].js', 't', 565, '.js', NULL, 1, 1, 0, 0, 't');

-- ----------------------------
-- Table structure for t_vod_subs
-- ----------------------------
DROP TABLE IF EXISTS "public"."t_vod_subs";
CREATE TABLE "public"."t_vod_subs" (
  "id" int4 NOT NULL DEFAULT nextval('t_vod_subs_id_seq'::regclass),
  "created_time" timestamp(6) DEFAULT now(),
  "creator_id" int4 DEFAULT 0,
  "modified_time" timestamp(6) DEFAULT now(),
  "modifier_id" int4 DEFAULT 0,
  "is_deleted" int4 DEFAULT 0,
  "name" varchar(256) COLLATE "pg_catalog"."default" NOT NULL,
  "code" varchar(256) COLLATE "pg_catalog"."default",
  "reg" text COLLATE "pg_catalog"."default",
  "status" int4 DEFAULT 0,
  "mode" int4 DEFAULT 0,
  "due_time" timestamp(6)
)
;
COMMENT ON COLUMN "public"."t_vod_subs"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."t_vod_subs"."creator_id" IS '创建人id';
COMMENT ON COLUMN "public"."t_vod_subs"."modified_time" IS '更新时间';
COMMENT ON COLUMN "public"."t_vod_subs"."modifier_id" IS '修改人id';
COMMENT ON COLUMN "public"."t_vod_subs"."is_deleted" IS '逻辑删除:0=未删除,1=删除';
COMMENT ON COLUMN "public"."t_vod_subs"."name" IS '订阅名称';
COMMENT ON COLUMN "public"."t_vod_subs"."code" IS '订阅代码';
COMMENT ON COLUMN "public"."t_vod_subs"."reg" IS '正则表达式';
COMMENT ON COLUMN "public"."t_vod_subs"."status" IS '状态';
COMMENT ON COLUMN "public"."t_vod_subs"."mode" IS '匹配模式:0正向匹配 1逆向排除';
COMMENT ON COLUMN "public"."t_vod_subs"."due_time" IS '到期时间';

-- ----------------------------
-- Records of t_vod_subs
-- ----------------------------
INSERT INTO "public"."t_vod_subs" VALUES (1, '2024-06-19 09:53:59.764772', 1, '2024-06-19 09:53:59.764772', 0, 0, '全部', 'dzyyds', '.*', 1, 0, NULL);
INSERT INTO "public"."t_vod_subs" VALUES (3, '2024-06-19 10:06:27.433109', 1, '2024-06-19 10:58:42.805524', 1, 0, '不含18+', 'green1', '密', 1, 1, NULL);
INSERT INTO "public"."t_vod_subs" VALUES (2, '2024-06-19 09:54:38.332997', 1, '2024-06-19 10:59:24.230045', 1, 0, '18+', 'yellow1', '密', 1, 0, '2024-12-16 17:54:36');
INSERT INTO "public"."t_vod_subs" VALUES (4, '2024-06-20 02:08:06.290099', 1, '2024-06-20 02:08:06.290099', 0, 0, '官源', 'luNhHy', '官', 1, 0, NULL);
INSERT INTO "public"."t_vod_subs" VALUES (5, '2024-06-25 15:12:57.392772', 1, '2024-06-25 15:13:01.936418', 1, 1, '测的', 'hkdYBC', '荐片', 1, 0, NULL);
INSERT INTO "public"."t_vod_subs" VALUES (6, '2024-06-25 15:13:17.422701', 1, '2024-06-25 15:13:23.065618', 1, 1, '测的', '2ZkutD', '荐片', 1, 0, NULL);
INSERT INTO "public"."t_vod_subs" VALUES (7, '2024-06-29 00:21:53.300619', 1, '2024-06-29 01:32:13.528635', 1, 0, '电视用', 'tv0001', '\[[画书密慢盘搜]\]|jsapi|原始|直播转点播v2', 1, 1, NULL);
INSERT INTO "public"."t_vod_subs" VALUES (8, '2024-06-30 02:35:37.6322', 1, '2024-07-02 03:16:07.979125', 1, 0, 't4体验', 'wf4Hyy', '.*', 1, 0, '2024-07-04 00:00:00');
INSERT INTO "public"."t_vod_subs" VALUES (9, '2024-07-03 04:24:34.376468', 1, '2024-07-03 04:24:38.955186', 1, 1, '测采集', 'qrlYm6', '.*', 1, 0, NULL);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_config_settings_id_seq"
OWNED BY "public"."t_config_settings"."id";
SELECT setval('"public"."t_config_settings_id_seq"', 8, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_dict_data_id_seq"
OWNED BY "public"."t_dict_data"."id";
SELECT setval('"public"."t_dict_data_id_seq"', 13, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_dict_details_id_seq"
OWNED BY "public"."t_dict_details"."id";
SELECT setval('"public"."t_dict_details_id_seq"', 39, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_hiker_developer_id_seq"
OWNED BY "public"."t_hiker_developer"."id";
SELECT setval('"public"."t_hiker_developer_id_seq"', 3, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_hiker_rule_id_seq"
OWNED BY "public"."t_hiker_rule"."id";
SELECT setval('"public"."t_hiker_rule_id_seq"', 3, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_hiker_rule_type_id_seq"
OWNED BY "public"."t_hiker_rule_type"."id";
SELECT setval('"public"."t_hiker_rule_type_id_seq"', 4, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_job_id_seq"
OWNED BY "public"."t_job"."id";
SELECT setval('"public"."t_job_id_seq"', 18, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_job_log_id_seq"
OWNED BY "public"."t_job_log"."id";
SELECT setval('"public"."t_job_log_id_seq"', 1066, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_login_infor_id_seq"
OWNED BY "public"."t_login_infor"."id";
SELECT setval('"public"."t_login_infor_id_seq"', 17, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_menus_id_seq"
OWNED BY "public"."t_menus"."id";
SELECT setval('"public"."t_menus_id_seq"', 47, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_perm_label_id_seq"
OWNED BY "public"."t_perm_label"."id";
SELECT setval('"public"."t_perm_label_id_seq"', 76, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_perm_label_role_id_seq"
OWNED BY "public"."t_perm_label_role"."id";
SELECT setval('"public"."t_perm_label_role_id_seq"', 70, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_role_menu_id_seq"
OWNED BY "public"."t_role_menu"."id";
SELECT setval('"public"."t_role_menu_id_seq"', 287, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_roles_id_seq"
OWNED BY "public"."t_roles"."id";
SELECT setval('"public"."t_roles_id_seq"', 5, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_user_role_id_seq"
OWNED BY "public"."t_user_role"."id";
SELECT setval('"public"."t_user_role_id_seq"', 12, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_users_id_seq"
OWNED BY "public"."t_users"."id";
SELECT setval('"public"."t_users_id_seq"', 6, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_vod_configs_id_seq"
OWNED BY "public"."t_vod_configs"."id";
SELECT setval('"public"."t_vod_configs_id_seq"', 18, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_vod_rules_id_seq"
OWNED BY "public"."t_vod_rules"."id";
SELECT setval('"public"."t_vod_rules_id_seq"', 595, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."t_vod_subs_id_seq"
OWNED BY "public"."t_vod_subs"."id";
SELECT setval('"public"."t_vod_subs_id_seq"', 11, false);

-- ----------------------------
-- Indexes structure for table t_config_settings
-- ----------------------------
CREATE INDEX "ix_t_config_settings_id" ON "public"."t_config_settings" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "ix_t_config_settings_name" ON "public"."t_config_settings" USING btree (
  "name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_config_settings
-- ----------------------------
ALTER TABLE "public"."t_config_settings" ADD CONSTRAINT "t_config_settings_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_dict_data
-- ----------------------------
CREATE UNIQUE INDEX "ix_t_dict_data_dict_type" ON "public"."t_dict_data" USING btree (
  "dict_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "ix_t_dict_data_id" ON "public"."t_dict_data" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_dict_data
-- ----------------------------
ALTER TABLE "public"."t_dict_data" ADD CONSTRAINT "t_dict_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_dict_details
-- ----------------------------
CREATE INDEX "ix_t_dict_details_id" ON "public"."t_dict_details" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_dict_details
-- ----------------------------
ALTER TABLE "public"."t_dict_details" ADD CONSTRAINT "t_dict_details_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_hiker_developer
-- ----------------------------
CREATE INDEX "ix_t_hiker_developer_id" ON "public"."t_hiker_developer" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_hiker_developer
-- ----------------------------
ALTER TABLE "public"."t_hiker_developer" ADD CONSTRAINT "t_hiker_developer_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_hiker_rule
-- ----------------------------
CREATE INDEX "ix_t_hiker_rule_id" ON "public"."t_hiker_rule" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_hiker_rule
-- ----------------------------
ALTER TABLE "public"."t_hiker_rule" ADD CONSTRAINT "t_hiker_rule_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_hiker_rule_type
-- ----------------------------
CREATE INDEX "ix_t_hiker_rule_type_id" ON "public"."t_hiker_rule_type" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_hiker_rule_type
-- ----------------------------
ALTER TABLE "public"."t_hiker_rule_type" ADD CONSTRAINT "t_hiker_rule_type_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_job
-- ----------------------------
CREATE INDEX "ix_t_job_id" ON "public"."t_job" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_job
-- ----------------------------
ALTER TABLE "public"."t_job" ADD CONSTRAINT "t_job_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_job_log
-- ----------------------------
CREATE INDEX "ix_t_job_log_id" ON "public"."t_job_log" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_job_log
-- ----------------------------
ALTER TABLE "public"."t_job_log" ADD CONSTRAINT "t_job_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_login_infor
-- ----------------------------
CREATE INDEX "ix_t_login_infor_id" ON "public"."t_login_infor" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_login_infor
-- ----------------------------
ALTER TABLE "public"."t_login_infor" ADD CONSTRAINT "t_login_infor_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_menus
-- ----------------------------
CREATE INDEX "ix_t_menus_id" ON "public"."t_menus" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_menus
-- ----------------------------
ALTER TABLE "public"."t_menus" ADD CONSTRAINT "t_menus_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_perm_label
-- ----------------------------
CREATE INDEX "ix_t_perm_label_id" ON "public"."t_perm_label" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_perm_label
-- ----------------------------
ALTER TABLE "public"."t_perm_label" ADD CONSTRAINT "t_perm_label_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_perm_label_role
-- ----------------------------
CREATE INDEX "ix_t_perm_label_role_id" ON "public"."t_perm_label_role" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_perm_label_role
-- ----------------------------
ALTER TABLE "public"."t_perm_label_role" ADD CONSTRAINT "t_perm_label_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_role_menu
-- ----------------------------
CREATE INDEX "ix_t_role_menu_id" ON "public"."t_role_menu" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_role_menu
-- ----------------------------
ALTER TABLE "public"."t_role_menu" ADD CONSTRAINT "t_role_menu_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_roles
-- ----------------------------
CREATE INDEX "ix_t_roles_id" ON "public"."t_roles" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "ix_t_roles_key" ON "public"."t_roles" USING btree (
  "key" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_roles
-- ----------------------------
ALTER TABLE "public"."t_roles" ADD CONSTRAINT "t_roles_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_user_role
-- ----------------------------
CREATE INDEX "ix_t_user_role_id" ON "public"."t_user_role" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_user_role
-- ----------------------------
ALTER TABLE "public"."t_user_role" ADD CONSTRAINT "t_user_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_users
-- ----------------------------
CREATE INDEX "ix_t_users_id" ON "public"."t_users" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE UNIQUE INDEX "ix_t_users_username" ON "public"."t_users" USING btree (
  "username" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_users
-- ----------------------------
ALTER TABLE "public"."t_users" ADD CONSTRAINT "t_users_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_vod_configs
-- ----------------------------
CREATE INDEX "ix_t_vod_configs_id" ON "public"."t_vod_configs" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_vod_configs
-- ----------------------------
ALTER TABLE "public"."t_vod_configs" ADD CONSTRAINT "t_vod_configs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_vod_rules
-- ----------------------------
CREATE INDEX "ix_t_vod_rules_id" ON "public"."t_vod_rules" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_vod_rules
-- ----------------------------
ALTER TABLE "public"."t_vod_rules" ADD CONSTRAINT "t_vod_rules_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table t_vod_subs
-- ----------------------------
CREATE INDEX "ix_t_vod_subs_id" ON "public"."t_vod_subs" USING btree (
  "id" "pg_catalog"."int4_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table t_vod_subs
-- ----------------------------
ALTER TABLE "public"."t_vod_subs" ADD CONSTRAINT "t_vod_subs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table t_dict_details
-- ----------------------------
ALTER TABLE "public"."t_dict_details" ADD CONSTRAINT "t_dict_details_dict_data_id_fkey" FOREIGN KEY ("dict_data_id") REFERENCES "public"."t_dict_data" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table t_hiker_rule
-- ----------------------------
ALTER TABLE "public"."t_hiker_rule" ADD CONSTRAINT "t_hiker_rule_dev_id_fkey" FOREIGN KEY ("dev_id") REFERENCES "public"."t_hiker_developer" ("id") ON DELETE SET NULL ON UPDATE NO ACTION;
ALTER TABLE "public"."t_hiker_rule" ADD CONSTRAINT "t_hiker_rule_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "public"."t_hiker_rule_type" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table t_perm_label_role
-- ----------------------------
ALTER TABLE "public"."t_perm_label_role" ADD CONSTRAINT "t_perm_label_role_label_id_fkey" FOREIGN KEY ("label_id") REFERENCES "public"."t_perm_label" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;
ALTER TABLE "public"."t_perm_label_role" ADD CONSTRAINT "t_perm_label_role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."t_roles" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table t_role_menu
-- ----------------------------
ALTER TABLE "public"."t_role_menu" ADD CONSTRAINT "t_role_menu_menu_id_fkey" FOREIGN KEY ("menu_id") REFERENCES "public"."t_menus" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."t_role_menu" ADD CONSTRAINT "t_role_menu_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."t_roles" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table t_user_role
-- ----------------------------
ALTER TABLE "public"."t_user_role" ADD CONSTRAINT "t_user_role_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "public"."t_roles" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."t_user_role" ADD CONSTRAINT "t_user_role_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."t_users" ("id") ON DELETE CASCADE ON UPDATE NO ACTION;

/*
 Navicat Premium Data Transfer

 Source Server         : 本地mysql
 Source Server Type    : MySQL
 Source Server Version : 100318
 Source Host           : localhost:3306
 Source Schema         : hipy

 Target Server Type    : MySQL
 Target Server Version : 100318
 File Encoding         : 65001

 Date: 21/07/2024 15:55:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_config_settings
-- ----------------------------
DROP TABLE IF EXISTS `t_config_settings`;
CREATE TABLE `t_config_settings`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '参数名称',
  `key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数键名',
  `value` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数键值',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态 0: 正常  1:停用',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_t_config_settings_name`(`name`) USING BTREE,
  INDEX `ix_t_config_settings_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_config_settings
-- ----------------------------
INSERT INTO `t_config_settings` VALUES (1, '2022-11-13 02:47:53', 0, '2022-11-13 02:47:53', 0, 0, '用户初始角色', 'user_init_roles', 'general', '0', 0, 1);
INSERT INTO `t_config_settings` VALUES (2, '2023-12-04 22:13:09', 1, '2023-12-09 12:29:32', 1, 0, '数据库升级密码', 'database_update_auth', 'hjdhnx', '默认密码hjdhnx', 0, 2);
INSERT INTO `t_config_settings` VALUES (4, '2023-12-09 12:53:44', 0, '2024-01-02 22:14:43', 1, 0, '登录日志记录验证码错误', 'log_captcha_error', '0', '0/false不记录 1/true记录', 0, 4);
INSERT INTO `t_config_settings` VALUES (5, '2023-12-10 16:19:44', 1, '2023-12-10 16:20:17', 1, 1, '定时任务启动状态', 'sys_job_status', '0', '0 暂停 1 运行', 0, 12);
INSERT INTO `t_config_settings` VALUES (6, '2024-01-02 22:10:13', 1, '2024-01-02 22:14:30', 1, 0, '用户初始密码', 'default_password', '123456', '用户表导入的时候按这个密码创建用户记录', 0, 1);
INSERT INTO `t_config_settings` VALUES (3, '2023-12-04 23:04:31', 1, '2024-01-31 15:52:15', 1, 0, '登录需要验证码', 'login_with_captcha', 'no', 'yes 开启 no 关闭', 0, 3);

-- ----------------------------
-- Table structure for t_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_data`;
CREATE TABLE `t_dict_data`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `dict_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典类型',
  `dict_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态 0: 正常  1:停用',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_t_dict_data_dict_type`(`dict_type`) USING BTREE,
  INDEX `ix_t_dict_data_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dict_data
-- ----------------------------
INSERT INTO `t_dict_data` VALUES (1, '2022-11-13 02:49:40', 0, '2022-11-13 02:49:40', 0, 0, 'permission_user_sex', '用户性别', '(0: 未知; 1: 男; 2: 女)', 0, 1);
INSERT INTO `t_dict_data` VALUES (2, '2022-11-13 02:49:40', 0, '2022-11-13 02:49:40', 0, 0, 'com_default_status', '通用状态字典', '(0: 正常; 1: 停用)', 0, 2);
INSERT INTO `t_dict_data` VALUES (3, '2022-11-13 02:49:40', 0, '2023-12-02 15:40:02', 1, 0, 'permission_user_status', '用户状态', NULL, 0, 1);
INSERT INTO `t_dict_data` VALUES (4, '2023-12-04 19:53:00', 1, '2023-12-04 19:57:21', 1, 0, 'hiker_rule_data_type', '海阔视界规则数据类型', '[(\'home_rule_url\', \'首页云规则\'), (\'publish\', \'提交云仓库\'), (\'js_url\', \'网页插件\'),(\'html\',\'静态页面\'),(\'config\',\'主页配置\')]', 0, 3);
INSERT INTO `t_dict_data` VALUES (5, '2023-12-10 16:20:45', 1, '2023-12-10 16:20:45', 0, 0, 'sys_job_group', '定时任务分组', NULL, 0, 4);
INSERT INTO `t_dict_data` VALUES (6, '2023-12-10 16:21:01', 1, '2023-12-10 16:21:01', 0, 0, 'sys_job_status', '定时任务运行状态', NULL, 0, 5);
INSERT INTO `t_dict_data` VALUES (7, '2024-01-06 12:05:26', 1, '2024-01-06 12:05:26', 0, 0, 'sys_job_run_status', '定时任务调度状态', '1 正常 0 失败', 0, 7);
INSERT INTO `t_dict_data` VALUES (9, '2024-01-15 15:48:43', 1, '2024-01-15 15:48:43', 0, 0, 'vod_rule_group', 'hipy源分组', 'groups = {\n        \'hipy\': \'t4/spiders\',\n        \'drpy_js\': \'t4/files/drpy_js\',\n        \'json\': \'t4/files/json\',\n        \'m3u\': \'t4/files/m3u\',\n        \'txt\': \'t4/files/txt\',\n    }', 0, 8);
INSERT INTO `t_dict_data` VALUES (10, '2024-01-15 16:23:43', 1, '2024-01-15 16:23:43', 0, 0, 'vod_rule_status', '源状态', '1正常 0异常', 0, 9);
INSERT INTO `t_dict_data` VALUES (11, '2024-01-25 14:00:03', 1, '2024-01-25 14:00:03', 0, 0, 'vod_configs_value_type', 'hipy配置值类型', 'str:字符串，int:数字', 0, 11);

-- ----------------------------
-- Table structure for t_dict_details
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_details`;
CREATE TABLE `t_dict_details`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `dict_label` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典标签',
  `dict_disabled` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用',
  `dict_value` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典键值',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认值',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态 0: 正常  1:停用',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '排序',
  `dict_data_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dict_data_id`(`dict_data_id`) USING BTREE,
  INDEX `ix_t_dict_details_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_dict_details
-- ----------------------------
INSERT INTO `t_dict_details` VALUES (1, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '未知', 0, '0', NULL, 1, 0, 1, 1);
INSERT INTO `t_dict_details` VALUES (2, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '男', 0, '1', NULL, 0, 0, 2, 1);
INSERT INTO `t_dict_details` VALUES (3, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '女', 0, '2', NULL, 0, 0, 3, 1);
INSERT INTO `t_dict_details` VALUES (4, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '正常', 0, '0', NULL, 1, 0, 0, 2);
INSERT INTO `t_dict_details` VALUES (5, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '停用', 0, '1', NULL, 0, 0, 1, 2);
INSERT INTO `t_dict_details` VALUES (6, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '正常', 0, '0', NULL, 1, 0, 1, 3);
INSERT INTO `t_dict_details` VALUES (7, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '停用', 0, '1', NULL, 0, 0, 2, 3);
INSERT INTO `t_dict_details` VALUES (8, '2022-11-13 02:52:55', 0, '2022-11-13 02:52:55', 0, 0, '拉黑', 0, '2', NULL, 0, 0, 3, 3);
INSERT INTO `t_dict_details` VALUES (9, '2023-12-04 19:53:35', 1, '2023-12-04 19:53:35', 0, 0, '首页云规则', 0, 'home_rule_url', NULL, 1, 0, 1, 4);
INSERT INTO `t_dict_details` VALUES (10, '2023-12-04 19:53:56', 1, '2023-12-04 19:58:52', 1, 0, '提交云仓库', 1, 'publish', NULL, 0, 0, 2, 4);
INSERT INTO `t_dict_details` VALUES (11, '2023-12-04 19:54:20', 1, '2023-12-04 19:54:20', 0, 0, '网页插件', 0, 'js_url', NULL, 0, 0, 3, 4);
INSERT INTO `t_dict_details` VALUES (12, '2023-12-04 19:54:35', 1, '2023-12-04 19:54:35', 0, 0, '静态页面', 0, 'html', NULL, 0, 0, 4, 4);
INSERT INTO `t_dict_details` VALUES (13, '2023-12-04 19:54:53', 1, '2023-12-04 19:54:53', 0, 0, '主页配置', 0, 'config', NULL, 0, 0, 5, 4);
INSERT INTO `t_dict_details` VALUES (14, '2023-12-10 16:21:16', 1, '2023-12-10 16:21:29', 1, 0, '暂停', 0, '0', NULL, 1, 0, 1, 6);
INSERT INTO `t_dict_details` VALUES (15, '2023-12-10 16:21:22', 1, '2023-12-10 16:21:22', 0, 0, '启动', 0, '1', NULL, 0, 0, 2, 6);
INSERT INTO `t_dict_details` VALUES (16, '2023-12-10 16:22:10', 1, '2023-12-10 16:22:43', 1, 0, '单次', 0, 'setTimeout', NULL, 0, 0, 1, 5);
INSERT INTO `t_dict_details` VALUES (17, '2023-12-10 16:22:31', 1, '2023-12-10 16:22:58', 1, 0, '循环', 0, 'setInterval', NULL, 1, 0, 2, 5);
INSERT INTO `t_dict_details` VALUES (18, '2024-01-06 12:05:43', 1, '2024-01-06 12:05:43', 0, 0, '失败', 0, '0', NULL, 0, 0, 1, 7);
INSERT INTO `t_dict_details` VALUES (19, '2024-01-06 12:05:52', 1, '2024-01-06 12:05:52', 0, 0, '正常', 0, '1', NULL, 1, 0, 2, 7);
INSERT INTO `t_dict_details` VALUES (25, '2024-01-15 15:52:54', 1, '2024-01-15 15:52:54', 0, 0, 'txt', 0, 't4/files/txt', '一些静态文本文件', 0, 0, 5, 9);
INSERT INTO `t_dict_details` VALUES (26, '2024-01-15 16:23:54', 1, '2024-01-15 16:23:54', 0, 0, '正常', 0, '1', NULL, 0, 0, 1, 10);
INSERT INTO `t_dict_details` VALUES (28, '2024-01-25 12:15:39', 1, '2024-01-25 12:16:21', 1, 0, 'drpy_libs', 0, 't4/files/drpy_libs', 'drpy的依赖库放这个分组', 0, 0, 3, 9);
INSERT INTO `t_dict_details` VALUES (23, '2024-01-15 15:51:53', 1, '2024-01-25 12:16:26', 1, 0, 'json', 0, 't4/files/json', '无关大雅的json放这个位置', 0, 0, 4, 9);
INSERT INTO `t_dict_details` VALUES (24, '2024-01-15 15:52:19', 1, '2024-01-25 12:16:45', 1, 0, 'm3u', 0, 't4/files/m3u', '一些m3u直播类文件', 0, 0, 6, 9);
INSERT INTO `t_dict_details` VALUES (29, '2024-01-25 14:00:21', 1, '2024-01-25 14:00:26', 1, 0, '字符串', 0, 'str', NULL, 1, 0, 1, 11);
INSERT INTO `t_dict_details` VALUES (30, '2024-01-25 14:00:36', 1, '2024-01-25 14:00:36', 0, 0, '数字', 0, 'int', NULL, 0, 0, 2, 11);
INSERT INTO `t_dict_details` VALUES (32, '2024-01-31 15:36:10', 1, '2024-01-31 15:36:10', 0, 0, '链接', 0, 'url', NULL, 0, 0, 4, 11);
INSERT INTO `t_dict_details` VALUES (31, '2024-01-31 15:00:08', 1, '2024-01-31 15:45:49', 1, 0, '文件', 0, 'file', NULL, 0, 0, 3, 11);
INSERT INTO `t_dict_details` VALUES (33, '2024-02-02 17:33:55', 1, '2024-02-02 17:33:55', 0, 0, '数据集', 0, 'json', NULL, 0, 0, 5, 11);
INSERT INTO `t_dict_details` VALUES (27, '2024-01-15 16:24:01', 1, '2024-02-04 17:13:14', 1, 0, '禁用', 0, '0', NULL, 0, 0, 2, 10);
INSERT INTO `t_dict_details` VALUES (35, '2024-02-04 17:14:42', 1, '2024-02-05 09:55:00', 1, 0, 'js_parse_api', 0, 't4/files/js_parse_api', 'js实现的vip解析接口文件', 0, 0, 8, 9);
INSERT INTO `t_dict_details` VALUES (34, '2024-02-04 17:14:13', 1, '2024-02-05 09:55:21', 1, 0, 'jar', 0, 't4/files/jar', 'drpy2及tvbox配置需要的外挂jar', 0, 0, 7, 9);
INSERT INTO `t_dict_details` VALUES (36, '2024-03-08 15:50:48', 1, '2024-03-08 15:50:48', 0, 0, 'drpy3_libs', 0, 't4/files/drpy3_libs', 'drpy3的t4源需要的js依赖文件及模块,commonJS格式', 0, 0, 9, 9);
INSERT INTO `t_dict_details` VALUES (37, '2024-03-08 15:51:32', 1, '2024-03-08 15:51:32', 0, 0, 'drpy3_js', 0, 't4/files/drpy3_js', 'drpy3的t4源在运行过程中自动缓存线上文件到此目录', 0, 0, 10, 9);
INSERT INTO `t_dict_details` VALUES (21, '2024-01-15 15:49:54', 1, '2024-06-20 08:09:52', 1, 0, 'hipy', 0, 't4/spiders', 'hipy的py源放这个分组。可以放同名的json配置文件', 0, 0, 1, 9);
INSERT INTO `t_dict_details` VALUES (22, '2024-01-15 15:50:29', 1, '2024-06-20 08:09:56', 1, 0, 'drpy_js', 0, 't4/files/drpy_js', 'drpy的js源放这个分组', 1, 0, 2, 9);

-- ----------------------------
-- Table structure for t_hiker_developer
-- ----------------------------
DROP TABLE IF EXISTS `t_hiker_developer`;
CREATE TABLE `t_hiker_developer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开发者账号',
  `qq` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'QQ号',
  `password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '123456' COMMENT '开发者密码',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态',
  `is_manager` tinyint(1) NULL DEFAULT 0 COMMENT '是否超管',
  `active` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  `test` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '测试字段',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_hiker_developer_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_hiker_developer
-- ----------------------------
INSERT INTO `t_hiker_developer` VALUES (1, '2023-12-02 18:00:37', 1, '2023-12-09 16:55:06', 1, 0, '道长', '434857005', '123456789', 0, 0, 1, NULL);

-- ----------------------------
-- Table structure for t_hiker_rule
-- ----------------------------
DROP TABLE IF EXISTS `t_hiker_rule`;
CREATE TABLE `t_hiker_rule`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则名称',
  `type_id` int(11) NULL DEFAULT NULL COMMENT '规则类型',
  `dev_id` int(11) NULL DEFAULT NULL COMMENT '开发者',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '规则Json',
  `url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `state` int(11) NULL DEFAULT 0 COMMENT '状态',
  `auth` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '私有密码',
  `auth_date_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '私有密码过期时间',
  `time_over` tinyint(1) NULL DEFAULT 0 COMMENT '私有规则过期',
  `b64_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '64编码',
  `home_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则主页链接',
  `pic_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网站图标链接',
  `is_json` tinyint(1) NULL DEFAULT 1 COMMENT '是否json值',
  `is_redirect` tinyint(1) NULL DEFAULT 0 COMMENT '是否为后端重定向',
  `is_tap` tinyint(1) NULL DEFAULT 0 COMMENT '是否为仓库跳转规则',
  `can_discuss` tinyint(1) NULL DEFAULT 1 COMMENT '是否可以互动',
  `is_json_list` tinyint(1) NULL DEFAULT 0 COMMENT '是否json列表',
  `data_type` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'home_rule_url' COMMENT '数据类型',
  `version` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '版本号',
  `author` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '说明',
  `good_num` int(11) NULL DEFAULT 0 COMMENT '点赞数',
  `bad_num` int(11) NULL DEFAULT 0 COMMENT '踩数',
  `reply_num` int(11) NULL DEFAULT 0 COMMENT '回复数',
  `is_safe` tinyint(1) NULL DEFAULT 1 COMMENT '是否安全',
  `is_good` tinyint(1) NULL DEFAULT 0 COMMENT '是否优质',
  `is_white` tinyint(1) NULL DEFAULT 0 COMMENT '是否白名单',
  `not_safe_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '风险描述',
  `last_active` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '开发者上次提交时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  INDEX `dev_id`(`dev_id`) USING BTREE,
  INDEX `ix_t_hiker_rule_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_hiker_rule
-- ----------------------------
INSERT INTO `t_hiker_rule` VALUES (1, '2023-12-04 20:00:34', 1, '2023-12-09 16:54:53', 1, 0, '道德经', 1, 1, '\"{\\\"name\\\":\\\"道德经\\\"}\"', 'hiker://empty#', 1, NULL, '2023-12-04 20:00:34', 0, NULL, NULL, NULL, 1, 0, 0, 1, 0, 'home_rule_url', '1', '道长', NULL, 1, 1, 1, 1, 1, 1, NULL, '2023-12-04 20:00:34');

-- ----------------------------
-- Table structure for t_hiker_rule_type
-- ----------------------------
DROP TABLE IF EXISTS `t_hiker_rule_type`;
CREATE TABLE `t_hiker_rule_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `count_num` int(11) NULL DEFAULT 0 COMMENT '数目',
  `active` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_hiker_rule_type_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_hiker_rule_type
-- ----------------------------
INSERT INTO `t_hiker_rule_type` VALUES (1, '2023-12-04 19:55:50', 1, '2023-12-09 16:55:14', 1, 0, '影视', 2, 1);
INSERT INTO `t_hiker_rule_type` VALUES (2, '2023-12-05 22:52:36', 1, '2023-12-09 16:55:12', 1, 0, '电影2', 3, 1);

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `job_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务代号',
  `job_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `func_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调用目标字符串',
  `func_args` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '传入位置参数',
  `func_kwargs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '传入字典参数',
  `cron_model` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '执行模式',
  `coalesce` int(11) NULL DEFAULT 0 COMMENT '是否并发',
  `next_run` datetime(0) NULL DEFAULT NULL COMMENT '下次执行时间',
  `cron_expression` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'cron执行表达式',
  `status` int(11) NULL DEFAULT 0 COMMENT '任务状态',
  `misfire_policy` int(11) NULL DEFAULT 0 COMMENT '执行策略',
  `active` tinyint(1) NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_job_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_job
-- ----------------------------
INSERT INTO `t_job` VALUES (1, '2023-12-10 21:31:19', 1, '2024-02-20 15:51:14', 1, 0, 'demo', '测试', 'setInterval', 'tasks.demo_task.demo', '[\'hello world\']', '{\'a\':\'1\',\'b\':\'2\'}', 'cron', 0, '2024-02-20 15:50:44', '30 20 * * * ?', 0, 1, 0);
INSERT INTO `t_job` VALUES (15, '2023-12-13 00:53:05', 1, '2024-02-20 15:51:14', 1, 0, 'kzz', '可转债打新查询', 'setInterval', 'tasks.kzz_spider.get_now_kzz', NULL, '{\'dayeExtra\':8}', 'cron', 0, '2024-02-20 15:50:44', '0 0 8 1/1 * ?', 0, 1, 0);
INSERT INTO `t_job` VALUES (14, '2023-12-13 00:26:59', 1, '2024-02-20 15:51:14', 1, 0, 'demo2', '测试2', 'setInterval', 'tasks.demo_task.demo', '[\'哈哈哈哈哈\']', '{\'key\':\'你好吗\'}', 'cron', 0, '2024-02-20 15:50:44', '30 10 * * * ?', 0, 1, 0);
INSERT INTO `t_job` VALUES (16, '2024-02-20 16:23:34', 1, '2024-07-21 07:50:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', 'cron', 0, '2024-07-21 15:50:10', '0 0 0/4 * * ?', 1, 1, 1);

-- ----------------------------
-- Table structure for t_job_log
-- ----------------------------
DROP TABLE IF EXISTS `t_job_log`;
CREATE TABLE `t_job_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `job_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务代号',
  `job_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `func_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调用目标字符串',
  `func_args` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '传入位置参数',
  `func_kwargs` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '传入字典参数',
  `run_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正常日志信息',
  `run_except_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常日志信息',
  `run_status` int(11) NULL DEFAULT 0 COMMENT '执行状态',
  `run_time` datetime(0) NULL DEFAULT NULL COMMENT '执行时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_job_log_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1065 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_job_log
-- ----------------------------
INSERT INTO `t_job_log` VALUES (308, '2024-02-20 16:24:53', 0, '2024-02-20 16:24:53', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:9618,未能获取weishi.txt等文件内容', NULL, 1, '2024-02-20 16:24:46');
INSERT INTO `t_job_log` VALUES (309, '2024-02-21 16:00:05', 0, '2024-02-21 16:00:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:10140,未能获取qita.txt,weishi.txt等文件内容。本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-21 16:00:00');
INSERT INTO `t_job_log` VALUES (310, '2024-02-26 16:00:08', 0, '2024-02-26 16:00:08', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:10914本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-26 16:00:00');
INSERT INTO `t_job_log` VALUES (311, '2024-02-28 16:00:07', 0, '2024-02-28 16:00:07', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:11081本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-28 16:00:00');
INSERT INTO `t_job_log` VALUES (312, '2024-02-29 12:00:08', 0, '2024-02-29 12:00:08', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:9511本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-29 12:00:00');
INSERT INTO `t_job_log` VALUES (313, '2024-02-29 16:00:05', 0, '2024-02-29 16:00:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:9511本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-02-29 16:00:00');
INSERT INTO `t_job_log` VALUES (314, '2024-03-08 12:00:10', 0, '2024-03-08 12:00:10', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"E:\\pywork\\hipy\\hipy-server\\app\\tasks\\tv_spider.py\", line 18, in main\n    files = getGitContents(\'ssili126/tv\', \'\', \'\')\n  File \"E:\\pywork\\hipy\\hipy-server\\app\\utils\\httpapi.py\", line 98, in getGitContents\n    r = request.request()\n  File \"E:\\pywork\\hipy\\hipy-server\\app\\network\\request.py\", line 125, in request\n    response = httpx.Client(proxies=proxies).request(method=self.method, url=self.url, **self.requests_kwargs)\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 821, in request\n    return self.send(request, auth=auth, follow_redirects=follow_redirects)\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 922, in send\n    raise exc\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 916, in send\n    response.read()\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_models.py\", line 805, in read\n    self._content = b\"\".join(self.iter_bytes())\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_models.py\", line 823, in iter_bytes\n    for raw_bytes in self.iter_raw():\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_models.py\", line 881, in iter_raw\n    for raw_stream_bytes in self.stream:\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 124, in __iter__\n    for chunk in self._stream:\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_transports\\default.py\", line 105, in __iter__\n    yield part\n  File \"D:\\Program Files\\Python38\\lib\\contextlib.py\", line 131, in __exit__\n    self.gen.throw(type, value, traceback)\n  File \"D:\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_transports\\default.py\", line 77, in map_httpcore_exceptions\n    raise mapped_exc(message) from exc\n', 'The read operation timed out', 0, '2024-03-08 12:00:00');
INSERT INTO `t_job_log` VALUES (315, '2024-03-10 12:00:06', 0, '2024-03-10 12:00:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:7824本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-03-10 12:00:00');
INSERT INTO `t_job_log` VALUES (316, '2024-03-17 08:00:08', 0, '2024-03-17 08:00:08', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File \"F:\\python\\mypython\\hipy-server\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"F:\\pywork\\hipy\\hipy-server\\app\\tasks\\tv_spider.py\", line 18, in main\n    files = getGitContents(\'ssili126/tv\', \'\', \'\')\n  File \"F:\\pywork\\hipy\\hipy-server\\app\\utils\\httpapi.py\", line 98, in getGitContents\n    r = request.request()\n  File \"F:\\pywork\\hipy\\hipy-server\\app\\network\\request.py\", line 125, in request\n    response = httpx.Client(proxies=proxies).request(method=self.method, url=self.url, **self.requests_kwargs)\n  File \"F:\\python\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 821, in request\n    return self.send(request, auth=auth, follow_redirects=follow_redirects)\n  File \"F:\\python\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 908, in send\n    response = self._send_handling_auth(\n  File \"F:\\python\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 936, in _send_handling_auth\n    response = self._send_handling_redirects(\n  File \"F:\\python\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 973, in _send_handling_redirects\n    response = self._send_single_request(request)\n  File \"F:\\python\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_client.py\", line 1009, in _send_single_request\n    response = transport.handle_request(request)\n  File \"F:\\python\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_transports\\default.py\", line 218, in handle_request\n    resp = self._pool.handle_request(req)\n  File \"D:\\soft\\python\\388\\lib\\contextlib.py\", line 131, in __exit__\n    self.gen.throw(type, value, traceback)\n  File \"F:\\python\\mypython\\hipy-server\\lib\\site-packages\\httpx\\_transports\\default.py\", line 77, in map_httpcore_exceptions\n    raise mapped_exc(message) from exc\n', '_ssl.c:1108: The handshake operation timed out', 0, '2024-03-17 08:00:00');
INSERT INTO `t_job_log` VALUES (317, '2024-03-29 08:59:37', 0, '2024-03-29 08:59:37', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{\n    \"code\":400,\n    \"msg\":\"传入的url不合法\",\n    \"data\":{}\n}', NULL, 1, '2024-03-29 08:59:37');
INSERT INTO `t_job_log` VALUES (318, '2024-03-29 09:01:56', 0, '2024-03-29 09:01:56', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{\n    \"code\":400,\n    \"msg\":\"传入的url不合法\",\n    \"data\":{}\n}', NULL, 1, '2024-03-29 09:01:56');
INSERT INTO `t_job_log` VALUES (319, '2024-03-29 09:03:08', 0, '2024-03-29 09:03:08', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{\n    \"code\":400,\n    \"msg\":\"传入的url不合法\",\n    \"data\":{}\n}', NULL, 1, '2024-03-29 09:03:08');
INSERT INTO `t_job_log` VALUES (320, '2024-03-29 09:29:25', 0, '2024-03-29 09:29:25', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{\n    \"code\":400,\n    \"msg\":\"传入的url不合法\",\n    \"data\":{}\n}', NULL, 1, '2024-03-29 09:29:25');
INSERT INTO `t_job_log` VALUES (321, '2024-03-29 10:55:03', 0, '2024-03-29 10:55:03', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------{\n    \"code\":400,\n    \"msg\":\"传入的url不合法\",\n    \"data\":{}\n}', NULL, 1, '2024-03-29 10:55:03');
INSERT INTO `t_job_log` VALUES (322, '2024-05-06 13:26:28', 0, '2024-05-06 13:26:28', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://127.0.0.1:5708\"', NULL, 1, '2024-05-06 13:26:28');
INSERT INTO `t_job_log` VALUES (323, '2024-05-06 13:32:42', 0, '2024-05-06 13:32:42', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://127.0.0.1:5708\"', NULL, 1, '2024-05-06 13:32:42');
INSERT INTO `t_job_log` VALUES (324, '2024-05-06 13:32:50', 0, '2024-05-06 13:32:50', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 13:32:47');
INSERT INTO `t_job_log` VALUES (325, '2024-05-06 13:34:56', 0, '2024-05-06 13:34:56', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708/\"', NULL, 1, '2024-05-06 13:34:56');
INSERT INTO `t_job_log` VALUES (326, '2024-05-06 13:35:04', 0, '2024-05-06 13:35:04', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 13:35:01');
INSERT INTO `t_job_log` VALUES (327, '2024-05-06 13:42:57', 0, '2024-05-06 13:42:57', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708/\"', NULL, 1, '2024-05-06 13:42:57');
INSERT INTO `t_job_log` VALUES (328, '2024-05-06 13:43:03', 0, '2024-05-06 13:43:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 13:43:02');
INSERT INTO `t_job_log` VALUES (329, '2024-05-06 13:45:07', 0, '2024-05-06 13:45:07', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708/\"', NULL, 1, '2024-05-06 13:45:07');
INSERT INTO `t_job_log` VALUES (330, '2024-05-06 13:45:14', 0, '2024-05-06 13:45:14', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 13:45:12');
INSERT INTO `t_job_log` VALUES (331, '2024-05-06 14:25:42', 0, '2024-05-06 14:25:42', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://127.0.0.1:5708\"', NULL, 1, '2024-05-06 14:25:42');
INSERT INTO `t_job_log` VALUES (332, '2024-05-06 14:25:48', 0, '2024-05-06 14:25:48', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 14:25:47');
INSERT INTO `t_job_log` VALUES (333, '2024-05-06 14:35:32', 0, '2024-05-06 14:35:32', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708/\"', NULL, 1, '2024-05-06 14:35:31');
INSERT INTO `t_job_log` VALUES (334, '2024-05-06 14:35:38', 0, '2024-05-06 14:35:38', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 14:35:37');
INSERT INTO `t_job_log` VALUES (335, '2024-05-06 14:48:54', 0, '2024-05-06 14:48:54', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-06 14:48:54');
INSERT INTO `t_job_log` VALUES (336, '2024-05-06 14:49:00', 0, '2024-05-06 14:49:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 14:48:59');
INSERT INTO `t_job_log` VALUES (337, '2024-05-06 16:00:02', 0, '2024-05-06 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 16:00:00');
INSERT INTO `t_job_log` VALUES (338, '2024-05-06 16:45:32', 0, '2024-05-06 16:45:32', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-06 16:45:32');
INSERT INTO `t_job_log` VALUES (339, '2024-05-06 16:45:39', 0, '2024-05-06 16:45:39', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 16:45:37');
INSERT INTO `t_job_log` VALUES (340, '2024-05-06 20:00:01', 0, '2024-05-06 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:209本次未写入本地文件tv.txt[内容行数209不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数209不够300或不含cctv或卫视]', NULL, 1, '2024-05-06 20:00:00');
INSERT INTO `t_job_log` VALUES (341, '2024-05-07 00:00:01', 0, '2024-05-07 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 00:00:00');
INSERT INTO `t_job_log` VALUES (342, '2024-05-07 03:03:45', 0, '2024-05-07 03:03:45', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-07 03:03:45');
INSERT INTO `t_job_log` VALUES (343, '2024-05-07 03:03:51', 0, '2024-05-07 03:03:51', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 03:03:50');
INSERT INTO `t_job_log` VALUES (344, '2024-05-07 04:00:01', 0, '2024-05-07 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 04:00:00');
INSERT INTO `t_job_log` VALUES (345, '2024-05-07 08:00:01', 0, '2024-05-07 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 08:00:00');
INSERT INTO `t_job_log` VALUES (346, '2024-05-07 12:00:01', 0, '2024-05-07 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 12:00:00');
INSERT INTO `t_job_log` VALUES (347, '2024-05-07 16:00:01', 0, '2024-05-07 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 16:00:00');
INSERT INTO `t_job_log` VALUES (348, '2024-05-07 20:00:01', 0, '2024-05-07 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:257本次未写入本地文件tv.txt[内容行数257不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数257不够300或不含cctv或卫视]', NULL, 1, '2024-05-07 20:00:00');
INSERT INTO `t_job_log` VALUES (349, '2024-05-08 00:00:01', 0, '2024-05-08 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 00:00:00');
INSERT INTO `t_job_log` VALUES (350, '2024-05-08 02:12:54', 0, '2024-05-08 02:12:54', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-08 02:12:54');
INSERT INTO `t_job_log` VALUES (351, '2024-05-08 02:13:00', 0, '2024-05-08 02:13:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 02:12:59');
INSERT INTO `t_job_log` VALUES (352, '2024-05-08 04:00:01', 0, '2024-05-08 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 04:00:00');
INSERT INTO `t_job_log` VALUES (353, '2024-05-08 08:00:01', 0, '2024-05-08 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 08:00:00');
INSERT INTO `t_job_log` VALUES (358, '2024-05-09 04:00:01', 0, '2024-05-09 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 04:00:00');
INSERT INTO `t_job_log` VALUES (354, '2024-05-08 12:00:02', 0, '2024-05-08 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 12:00:00');
INSERT INTO `t_job_log` VALUES (355, '2024-05-08 16:00:01', 0, '2024-05-08 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 16:00:00');
INSERT INTO `t_job_log` VALUES (356, '2024-05-08 20:00:01', 0, '2024-05-08 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次未写入本地文件tv.txt[内容行数268不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数268不够300或不含cctv或卫视]', NULL, 1, '2024-05-08 20:00:00');
INSERT INTO `t_job_log` VALUES (357, '2024-05-09 00:00:01', 0, '2024-05-09 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 00:00:00');
INSERT INTO `t_job_log` VALUES (359, '2024-05-09 08:00:01', 0, '2024-05-09 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 08:00:00');
INSERT INTO `t_job_log` VALUES (360, '2024-05-09 12:00:01', 0, '2024-05-09 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 12:00:00');
INSERT INTO `t_job_log` VALUES (361, '2024-05-09 16:00:01', 0, '2024-05-09 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 16:00:00');
INSERT INTO `t_job_log` VALUES (362, '2024-05-09 20:00:01', 0, '2024-05-09 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:296本次未写入本地文件tv.txt[内容行数296不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数296不够300或不含cctv或卫视]', NULL, 1, '2024-05-09 20:00:00');
INSERT INTO `t_job_log` VALUES (363, '2024-05-10 00:00:01', 0, '2024-05-10 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 00:00:00');
INSERT INTO `t_job_log` VALUES (364, '2024-05-10 04:00:01', 0, '2024-05-10 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 04:00:00');
INSERT INTO `t_job_log` VALUES (365, '2024-05-10 08:00:01', 0, '2024-05-10 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 08:00:00');
INSERT INTO `t_job_log` VALUES (366, '2024-05-10 08:47:04', 0, '2024-05-10 08:47:04', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-10 08:47:04');
INSERT INTO `t_job_log` VALUES (367, '2024-05-10 08:47:10', 0, '2024-05-10 08:47:10', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 08:47:09');
INSERT INTO `t_job_log` VALUES (368, '2024-05-10 09:17:07', 0, '2024-05-10 09:17:07', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-10 09:17:07');
INSERT INTO `t_job_log` VALUES (369, '2024-05-10 09:17:13', 0, '2024-05-10 09:17:13', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 09:17:12');
INSERT INTO `t_job_log` VALUES (370, '2024-05-10 12:00:01', 0, '2024-05-10 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 12:00:00');
INSERT INTO `t_job_log` VALUES (371, '2024-05-10 16:00:03', 0, '2024-05-10 16:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 16:00:00');
INSERT INTO `t_job_log` VALUES (372, '2024-05-10 18:00:56', 0, '2024-05-10 18:00:56', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-10 18:00:56');
INSERT INTO `t_job_log` VALUES (373, '2024-05-10 18:01:02', 0, '2024-05-10 18:01:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 18:01:01');
INSERT INTO `t_job_log` VALUES (374, '2024-05-10 20:00:02', 0, '2024-05-10 20:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:342本次未写入本地文件tv.txt[内容行数342不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-10 20:00:00');
INSERT INTO `t_job_log` VALUES (375, '2024-05-11 00:00:01', 0, '2024-05-11 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 00:00:00');
INSERT INTO `t_job_log` VALUES (376, '2024-05-11 03:15:12', 0, '2024-05-11 03:15:12', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-11 03:15:12');
INSERT INTO `t_job_log` VALUES (377, '2024-05-11 03:15:18', 0, '2024-05-11 03:15:18', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 03:15:17');
INSERT INTO `t_job_log` VALUES (378, '2024-05-11 04:00:01', 0, '2024-05-11 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 04:00:00');
INSERT INTO `t_job_log` VALUES (380, '2024-05-11 12:00:01', 0, '2024-05-11 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 12:00:00');
INSERT INTO `t_job_log` VALUES (379, '2024-05-11 08:00:00', 0, '2024-05-11 08:00:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File \"/usr/local/lib/python3.8/site-packages/apscheduler/executors/base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"/hipy/tasks/tv_spider.py\", line 19, in main\n    txt_files = [file for file in files if str(file[\'name\']).endswith(\'.txt\') and file[\'type\'] == \'file\']\n  File \"/hipy/tasks/tv_spider.py\", line 19, in <listcomp>\n    txt_files = [file for file in files if str(file[\'name\']).endswith(\'.txt\') and file[\'type\'] == \'file\']\n', 'string indices must be integers', 0, '2024-05-11 08:00:00');
INSERT INTO `t_job_log` VALUES (381, '2024-05-11 14:21:53', 0, '2024-05-11 14:21:53', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-11 14:21:53');
INSERT INTO `t_job_log` VALUES (382, '2024-05-11 14:22:00', 0, '2024-05-11 14:22:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 14:21:58');
INSERT INTO `t_job_log` VALUES (383, '2024-05-11 15:34:09', 0, '2024-05-11 15:34:09', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-11 15:34:09');
INSERT INTO `t_job_log` VALUES (384, '2024-05-11 15:34:16', 0, '2024-05-11 15:34:16', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 15:34:14');
INSERT INTO `t_job_log` VALUES (385, '2024-05-11 16:00:01', 0, '2024-05-11 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 16:00:00');
INSERT INTO `t_job_log` VALUES (386, '2024-05-11 16:25:40', 0, '2024-05-11 16:25:40', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-11 16:25:40');
INSERT INTO `t_job_log` VALUES (387, '2024-05-11 16:25:46', 0, '2024-05-11 16:25:46', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 16:25:45');
INSERT INTO `t_job_log` VALUES (388, '2024-05-11 18:09:54', 0, '2024-05-11 18:09:54', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-11 18:09:54');
INSERT INTO `t_job_log` VALUES (389, '2024-05-11 18:10:00', 0, '2024-05-11 18:10:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 18:09:59');
INSERT INTO `t_job_log` VALUES (390, '2024-05-11 19:39:06', 0, '2024-05-11 19:39:06', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-11 19:39:06');
INSERT INTO `t_job_log` VALUES (391, '2024-05-11 19:39:12', 0, '2024-05-11 19:39:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 19:39:11');
INSERT INTO `t_job_log` VALUES (392, '2024-05-11 20:00:01', 0, '2024-05-11 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:328本次未写入本地文件tv.txt[内容行数328不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-11 20:00:00');
INSERT INTO `t_job_log` VALUES (393, '2024-05-12 00:00:01', 0, '2024-05-12 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 00:00:00');
INSERT INTO `t_job_log` VALUES (394, '2024-05-12 04:00:01', 0, '2024-05-12 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 04:00:00');
INSERT INTO `t_job_log` VALUES (395, '2024-05-12 07:37:06', 0, '2024-05-12 07:37:06', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-12 07:37:06');
INSERT INTO `t_job_log` VALUES (396, '2024-05-12 07:37:14', 0, '2024-05-12 07:37:14', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 07:37:11');
INSERT INTO `t_job_log` VALUES (397, '2024-05-12 08:00:01', 0, '2024-05-12 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 08:00:00');
INSERT INTO `t_job_log` VALUES (398, '2024-05-12 12:00:01', 0, '2024-05-12 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 12:00:00');
INSERT INTO `t_job_log` VALUES (399, '2024-05-12 16:00:01', 0, '2024-05-12 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 16:00:00');
INSERT INTO `t_job_log` VALUES (400, '2024-05-12 16:21:32', 0, '2024-05-12 16:21:32', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-12 16:21:32');
INSERT INTO `t_job_log` VALUES (401, '2024-05-12 16:21:38', 0, '2024-05-12 16:21:38', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 16:21:37');
INSERT INTO `t_job_log` VALUES (402, '2024-05-12 16:30:45', 0, '2024-05-12 16:30:45', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-12 16:30:45');
INSERT INTO `t_job_log` VALUES (403, '2024-05-12 16:30:51', 0, '2024-05-12 16:30:51', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 16:30:50');
INSERT INTO `t_job_log` VALUES (404, '2024-05-12 19:13:02', 0, '2024-05-12 19:13:02', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-12 19:13:02');
INSERT INTO `t_job_log` VALUES (405, '2024-05-12 19:13:09', 0, '2024-05-12 19:13:09', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 19:13:07');
INSERT INTO `t_job_log` VALUES (406, '2024-05-12 20:00:01', 0, '2024-05-12 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-12 20:00:00');
INSERT INTO `t_job_log` VALUES (407, '2024-05-13 00:00:01', 0, '2024-05-13 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 00:00:00');
INSERT INTO `t_job_log` VALUES (408, '2024-05-13 04:00:01', 0, '2024-05-13 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 04:00:00');
INSERT INTO `t_job_log` VALUES (409, '2024-05-13 07:09:09', 0, '2024-05-13 07:09:09', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-13 07:09:09');
INSERT INTO `t_job_log` VALUES (410, '2024-05-13 07:09:15', 0, '2024-05-13 07:09:15', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 07:09:14');
INSERT INTO `t_job_log` VALUES (411, '2024-05-13 08:00:01', 0, '2024-05-13 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 08:00:00');
INSERT INTO `t_job_log` VALUES (412, '2024-05-13 10:19:53', 0, '2024-05-13 10:19:53', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-13 10:19:53');
INSERT INTO `t_job_log` VALUES (413, '2024-05-13 10:19:59', 0, '2024-05-13 10:19:59', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 10:19:58');
INSERT INTO `t_job_log` VALUES (414, '2024-05-13 12:00:01', 0, '2024-05-13 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 12:00:00');
INSERT INTO `t_job_log` VALUES (415, '2024-05-13 13:20:00', 0, '2024-05-13 13:20:00', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-13 13:20:00');
INSERT INTO `t_job_log` VALUES (416, '2024-05-13 13:20:12', 0, '2024-05-13 13:20:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 13:20:05');
INSERT INTO `t_job_log` VALUES (417, '2024-05-13 16:00:01', 0, '2024-05-13 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 16:00:00');
INSERT INTO `t_job_log` VALUES (418, '2024-05-13 19:50:57', 0, '2024-05-13 19:50:57', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-13 19:50:57');
INSERT INTO `t_job_log` VALUES (419, '2024-05-13 19:51:03', 0, '2024-05-13 19:51:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 19:51:02');
INSERT INTO `t_job_log` VALUES (420, '2024-05-13 20:00:01', 0, '2024-05-13 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-13 20:00:00');
INSERT INTO `t_job_log` VALUES (421, '2024-05-14 00:00:01', 0, '2024-05-14 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 00:00:00');
INSERT INTO `t_job_log` VALUES (422, '2024-05-14 04:00:01', 0, '2024-05-14 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 04:00:00');
INSERT INTO `t_job_log` VALUES (423, '2024-05-14 08:00:01', 0, '2024-05-14 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 08:00:00');
INSERT INTO `t_job_log` VALUES (424, '2024-05-14 09:26:30', 0, '2024-05-14 09:26:30', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-14 09:26:30');
INSERT INTO `t_job_log` VALUES (425, '2024-05-14 09:26:36', 0, '2024-05-14 09:26:36', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 09:26:35');
INSERT INTO `t_job_log` VALUES (426, '2024-05-14 12:00:01', 0, '2024-05-14 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 12:00:00');
INSERT INTO `t_job_log` VALUES (427, '2024-05-14 16:00:02', 0, '2024-05-14 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 16:00:00');
INSERT INTO `t_job_log` VALUES (428, '2024-05-14 17:56:58', 0, '2024-05-14 17:56:58', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-14 17:56:58');
INSERT INTO `t_job_log` VALUES (429, '2024-05-14 17:57:04', 0, '2024-05-14 17:57:04', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 17:57:03');
INSERT INTO `t_job_log` VALUES (430, '2024-05-14 20:00:01', 0, '2024-05-14 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-14 20:00:00');
INSERT INTO `t_job_log` VALUES (431, '2024-05-15 00:00:01', 0, '2024-05-15 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 00:00:00');
INSERT INTO `t_job_log` VALUES (432, '2024-05-15 02:43:59', 0, '2024-05-15 02:43:59', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-15 02:43:59');
INSERT INTO `t_job_log` VALUES (433, '2024-05-15 02:44:05', 0, '2024-05-15 02:44:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 02:44:04');
INSERT INTO `t_job_log` VALUES (434, '2024-05-15 04:00:01', 0, '2024-05-15 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 04:00:00');
INSERT INTO `t_job_log` VALUES (435, '2024-05-15 08:00:01', 0, '2024-05-15 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 08:00:00');
INSERT INTO `t_job_log` VALUES (436, '2024-05-15 12:00:01', 0, '2024-05-15 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 12:00:00');
INSERT INTO `t_job_log` VALUES (437, '2024-05-15 14:55:32', 0, '2024-05-15 14:55:32', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-15 14:55:32');
INSERT INTO `t_job_log` VALUES (438, '2024-05-15 14:55:40', 0, '2024-05-15 14:55:40', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 14:55:37');
INSERT INTO `t_job_log` VALUES (439, '2024-05-15 16:00:02', 0, '2024-05-15 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 16:00:00');
INSERT INTO `t_job_log` VALUES (440, '2024-05-15 20:00:01', 0, '2024-05-15 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-15 20:00:00');
INSERT INTO `t_job_log` VALUES (441, '2024-05-16 00:00:01', 0, '2024-05-16 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 00:00:00');
INSERT INTO `t_job_log` VALUES (442, '2024-05-16 04:00:01', 0, '2024-05-16 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 04:00:00');
INSERT INTO `t_job_log` VALUES (443, '2024-05-16 08:00:02', 0, '2024-05-16 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 08:00:00');
INSERT INTO `t_job_log` VALUES (444, '2024-05-16 08:22:06', 0, '2024-05-16 08:22:06', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-16 08:22:06');
INSERT INTO `t_job_log` VALUES (445, '2024-05-16 08:22:12', 0, '2024-05-16 08:22:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 08:22:11');
INSERT INTO `t_job_log` VALUES (446, '2024-05-16 10:22:13', 0, '2024-05-16 10:22:13', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-16 10:22:13');
INSERT INTO `t_job_log` VALUES (447, '2024-05-16 10:22:19', 0, '2024-05-16 10:22:19', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 10:22:18');
INSERT INTO `t_job_log` VALUES (448, '2024-05-16 12:00:01', 0, '2024-05-16 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 12:00:00');
INSERT INTO `t_job_log` VALUES (449, '2024-05-16 16:00:01', 0, '2024-05-16 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 16:00:00');
INSERT INTO `t_job_log` VALUES (450, '2024-05-16 17:25:34', 0, '2024-05-16 17:25:34', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-16 17:25:34');
INSERT INTO `t_job_log` VALUES (451, '2024-05-16 17:25:40', 0, '2024-05-16 17:25:40', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 17:25:39');
INSERT INTO `t_job_log` VALUES (452, '2024-05-16 18:01:01', 0, '2024-05-16 18:01:01', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-16 18:01:01');
INSERT INTO `t_job_log` VALUES (453, '2024-05-16 18:01:07', 0, '2024-05-16 18:01:07', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 18:01:06');
INSERT INTO `t_job_log` VALUES (454, '2024-05-16 18:02:21', 0, '2024-05-16 18:02:21', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-16 18:02:21');
INSERT INTO `t_job_log` VALUES (455, '2024-05-16 18:02:27', 0, '2024-05-16 18:02:27', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 18:02:26');
INSERT INTO `t_job_log` VALUES (456, '2024-05-16 20:00:01', 0, '2024-05-16 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 20:00:00');
INSERT INTO `t_job_log` VALUES (457, '2024-05-16 20:05:22', 0, '2024-05-16 20:05:22', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-16 20:05:22');
INSERT INTO `t_job_log` VALUES (458, '2024-05-16 20:05:28', 0, '2024-05-16 20:05:28', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-16 20:05:27');
INSERT INTO `t_job_log` VALUES (459, '2024-05-17 00:00:01', 0, '2024-05-17 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 00:00:00');
INSERT INTO `t_job_log` VALUES (460, '2024-05-17 03:38:30', 0, '2024-05-17 03:38:30', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-17 03:38:30');
INSERT INTO `t_job_log` VALUES (461, '2024-05-17 04:00:01', 0, '2024-05-17 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 04:00:00');
INSERT INTO `t_job_log` VALUES (462, '2024-05-17 08:00:01', 0, '2024-05-17 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 08:00:00');
INSERT INTO `t_job_log` VALUES (463, '2024-05-17 08:01:50', 0, '2024-05-17 08:01:50', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-17 08:01:50');
INSERT INTO `t_job_log` VALUES (464, '2024-05-17 08:01:56', 0, '2024-05-17 08:01:56', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 08:01:55');
INSERT INTO `t_job_log` VALUES (465, '2024-05-17 12:00:02', 0, '2024-05-17 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 12:00:00');
INSERT INTO `t_job_log` VALUES (466, '2024-05-17 16:00:01', 0, '2024-05-17 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 16:00:00');
INSERT INTO `t_job_log` VALUES (467, '2024-05-17 20:00:01', 0, '2024-05-17 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-17 20:00:00');
INSERT INTO `t_job_log` VALUES (468, '2024-05-18 00:00:01', 0, '2024-05-18 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 00:00:00');
INSERT INTO `t_job_log` VALUES (469, '2024-05-18 04:00:01', 0, '2024-05-18 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 04:00:00');
INSERT INTO `t_job_log` VALUES (470, '2024-05-18 06:04:23', 0, '2024-05-18 06:04:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-18 06:04:23');
INSERT INTO `t_job_log` VALUES (471, '2024-05-18 06:04:29', 0, '2024-05-18 06:04:29', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 06:04:28');
INSERT INTO `t_job_log` VALUES (472, '2024-05-18 06:45:45', 0, '2024-05-18 06:45:45', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-18 06:45:45');
INSERT INTO `t_job_log` VALUES (473, '2024-05-18 06:45:51', 0, '2024-05-18 06:45:51', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 06:45:50');
INSERT INTO `t_job_log` VALUES (474, '2024-05-18 08:00:01', 0, '2024-05-18 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 08:00:00');
INSERT INTO `t_job_log` VALUES (475, '2024-05-18 12:00:01', 0, '2024-05-18 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 12:00:00');
INSERT INTO `t_job_log` VALUES (476, '2024-05-18 16:00:06', 0, '2024-05-18 16:00:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 16:00:00');
INSERT INTO `t_job_log` VALUES (477, '2024-05-18 20:00:02', 0, '2024-05-18 20:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-18 20:00:00');
INSERT INTO `t_job_log` VALUES (478, '2024-05-19 00:00:01', 0, '2024-05-19 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 00:00:00');
INSERT INTO `t_job_log` VALUES (479, '2024-05-19 04:00:01', 0, '2024-05-19 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 04:00:00');
INSERT INTO `t_job_log` VALUES (480, '2024-05-19 08:00:01', 0, '2024-05-19 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 08:00:00');
INSERT INTO `t_job_log` VALUES (481, '2024-05-19 12:00:01', 0, '2024-05-19 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 12:00:00');
INSERT INTO `t_job_log` VALUES (482, '2024-05-19 13:49:38', 0, '2024-05-19 13:49:38', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-19 13:49:38');
INSERT INTO `t_job_log` VALUES (483, '2024-05-19 13:49:44', 0, '2024-05-19 13:49:44', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 13:49:43');
INSERT INTO `t_job_log` VALUES (484, '2024-05-19 16:00:02', 0, '2024-05-19 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 16:00:00');
INSERT INTO `t_job_log` VALUES (485, '2024-05-19 20:00:01', 0, '2024-05-19 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-19 20:00:00');
INSERT INTO `t_job_log` VALUES (486, '2024-05-20 00:00:01', 0, '2024-05-20 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 00:00:00');
INSERT INTO `t_job_log` VALUES (487, '2024-05-20 04:00:01', 0, '2024-05-20 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 04:00:00');
INSERT INTO `t_job_log` VALUES (599, '2024-05-30 00:00:01', 0, '2024-05-30 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 00:00:00');
INSERT INTO `t_job_log` VALUES (488, '2024-05-20 08:00:01', 0, '2024-05-20 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 08:00:00');
INSERT INTO `t_job_log` VALUES (490, '2024-05-20 16:00:01', 0, '2024-05-20 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 16:00:00');
INSERT INTO `t_job_log` VALUES (491, '2024-05-20 20:00:01', 0, '2024-05-20 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 20:00:00');
INSERT INTO `t_job_log` VALUES (489, '2024-05-20 12:00:01', 0, '2024-05-20 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 12:00:00');
INSERT INTO `t_job_log` VALUES (492, '2024-05-20 20:01:41', 0, '2024-05-20 20:01:41', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-20 20:01:41');
INSERT INTO `t_job_log` VALUES (493, '2024-05-20 20:01:47', 0, '2024-05-20 20:01:47', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 20:01:46');
INSERT INTO `t_job_log` VALUES (494, '2024-05-20 21:36:59', 0, '2024-05-20 21:36:59', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-20 21:36:59');
INSERT INTO `t_job_log` VALUES (495, '2024-05-20 21:37:05', 0, '2024-05-20 21:37:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-20 21:37:04');
INSERT INTO `t_job_log` VALUES (496, '2024-05-21 00:00:01', 0, '2024-05-21 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 00:00:00');
INSERT INTO `t_job_log` VALUES (497, '2024-05-21 02:55:59', 0, '2024-05-21 02:55:59', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-21 02:55:59');
INSERT INTO `t_job_log` VALUES (498, '2024-05-21 02:56:05', 0, '2024-05-21 02:56:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 02:56:04');
INSERT INTO `t_job_log` VALUES (499, '2024-05-21 04:00:01', 0, '2024-05-21 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 04:00:00');
INSERT INTO `t_job_log` VALUES (500, '2024-05-21 06:24:56', 0, '2024-05-21 06:24:56', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-21 06:24:56');
INSERT INTO `t_job_log` VALUES (501, '2024-05-21 06:25:02', 0, '2024-05-21 06:25:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 06:25:01');
INSERT INTO `t_job_log` VALUES (502, '2024-05-21 08:00:01', 0, '2024-05-21 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 08:00:00');
INSERT INTO `t_job_log` VALUES (503, '2024-05-21 12:00:01', 0, '2024-05-21 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 12:00:00');
INSERT INTO `t_job_log` VALUES (504, '2024-05-21 16:00:01', 0, '2024-05-21 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 16:00:00');
INSERT INTO `t_job_log` VALUES (505, '2024-05-21 20:00:01', 0, '2024-05-21 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-21 20:00:00');
INSERT INTO `t_job_log` VALUES (506, '2024-05-22 00:00:01', 0, '2024-05-22 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 00:00:00');
INSERT INTO `t_job_log` VALUES (507, '2024-05-22 04:00:01', 0, '2024-05-22 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 04:00:00');
INSERT INTO `t_job_log` VALUES (508, '2024-05-22 08:00:05', 0, '2024-05-22 08:00:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 08:00:00');
INSERT INTO `t_job_log` VALUES (509, '2024-05-22 12:00:01', 0, '2024-05-22 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 12:00:00');
INSERT INTO `t_job_log` VALUES (510, '2024-05-22 15:37:06', 0, '2024-05-22 15:37:06', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-22 15:37:06');
INSERT INTO `t_job_log` VALUES (511, '2024-05-22 15:37:16', 0, '2024-05-22 15:37:16', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-22 15:37:16');
INSERT INTO `t_job_log` VALUES (512, '2024-05-22 15:37:22', 0, '2024-05-22 15:37:22', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 15:37:21');
INSERT INTO `t_job_log` VALUES (513, '2024-05-22 16:00:01', 0, '2024-05-22 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 16:00:00');
INSERT INTO `t_job_log` VALUES (514, '2024-05-22 20:00:01', 0, '2024-05-22 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-22 20:00:00');
INSERT INTO `t_job_log` VALUES (515, '2024-05-23 00:00:01', 0, '2024-05-23 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 00:00:00');
INSERT INTO `t_job_log` VALUES (516, '2024-05-23 04:00:01', 0, '2024-05-23 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 04:00:00');
INSERT INTO `t_job_log` VALUES (517, '2024-05-23 07:18:57', 0, '2024-05-23 07:18:57', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-23 07:18:57');
INSERT INTO `t_job_log` VALUES (518, '2024-05-23 07:19:03', 0, '2024-05-23 07:19:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 07:19:02');
INSERT INTO `t_job_log` VALUES (519, '2024-05-23 08:00:02', 0, '2024-05-23 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 08:00:00');
INSERT INTO `t_job_log` VALUES (520, '2024-05-23 10:17:01', 0, '2024-05-23 10:17:01', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-23 10:17:01');
INSERT INTO `t_job_log` VALUES (521, '2024-05-23 10:17:08', 0, '2024-05-23 10:17:08', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 10:17:06');
INSERT INTO `t_job_log` VALUES (522, '2024-05-23 12:00:03', 0, '2024-05-23 12:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 12:00:00');
INSERT INTO `t_job_log` VALUES (523, '2024-05-23 16:00:01', 0, '2024-05-23 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 16:00:00');
INSERT INTO `t_job_log` VALUES (524, '2024-05-23 20:00:01', 0, '2024-05-23 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-23 20:00:00');
INSERT INTO `t_job_log` VALUES (525, '2024-05-24 00:00:01', 0, '2024-05-24 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 00:00:00');
INSERT INTO `t_job_log` VALUES (526, '2024-05-24 00:57:08', 0, '2024-05-24 00:57:08', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-24 00:57:08');
INSERT INTO `t_job_log` VALUES (527, '2024-05-24 00:57:14', 0, '2024-05-24 00:57:14', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 00:57:13');
INSERT INTO `t_job_log` VALUES (528, '2024-05-24 04:00:01', 0, '2024-05-24 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 04:00:00');
INSERT INTO `t_job_log` VALUES (529, '2024-05-24 05:42:49', 0, '2024-05-24 05:42:49', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-24 05:42:49');
INSERT INTO `t_job_log` VALUES (530, '2024-05-24 05:42:55', 0, '2024-05-24 05:42:55', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 05:42:54');
INSERT INTO `t_job_log` VALUES (531, '2024-05-24 06:46:29', 0, '2024-05-24 06:46:29', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-24 06:46:29');
INSERT INTO `t_job_log` VALUES (532, '2024-05-24 06:46:35', 0, '2024-05-24 06:46:35', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 06:46:34');
INSERT INTO `t_job_log` VALUES (533, '2024-05-24 08:00:01', 0, '2024-05-24 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 08:00:00');
INSERT INTO `t_job_log` VALUES (534, '2024-05-24 10:24:57', 0, '2024-05-24 10:24:57', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-24 10:24:57');
INSERT INTO `t_job_log` VALUES (535, '2024-05-24 10:25:03', 0, '2024-05-24 10:25:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 10:25:02');
INSERT INTO `t_job_log` VALUES (536, '2024-05-24 12:00:04', 0, '2024-05-24 12:00:04', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 12:00:00');
INSERT INTO `t_job_log` VALUES (537, '2024-05-24 15:02:43', 0, '2024-05-24 15:02:43', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-24 15:02:43');
INSERT INTO `t_job_log` VALUES (538, '2024-05-24 15:02:49', 0, '2024-05-24 15:02:49', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 15:02:48');
INSERT INTO `t_job_log` VALUES (539, '2024-05-24 16:00:02', 0, '2024-05-24 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 16:00:00');
INSERT INTO `t_job_log` VALUES (540, '2024-05-24 20:00:01', 0, '2024-05-24 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-24 20:00:00');
INSERT INTO `t_job_log` VALUES (541, '2024-05-25 00:00:01', 0, '2024-05-25 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 00:00:00');
INSERT INTO `t_job_log` VALUES (542, '2024-05-25 04:00:01', 0, '2024-05-25 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 04:00:00');
INSERT INTO `t_job_log` VALUES (543, '2024-05-25 08:00:02', 0, '2024-05-25 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 08:00:00');
INSERT INTO `t_job_log` VALUES (544, '2024-05-25 12:00:01', 0, '2024-05-25 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 12:00:00');
INSERT INTO `t_job_log` VALUES (545, '2024-05-25 15:44:51', 0, '2024-05-25 15:44:51', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-25 15:44:51');
INSERT INTO `t_job_log` VALUES (546, '2024-05-25 15:44:58', 0, '2024-05-25 15:44:58', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 15:44:56');
INSERT INTO `t_job_log` VALUES (547, '2024-05-25 16:00:01', 0, '2024-05-25 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 16:00:00');
INSERT INTO `t_job_log` VALUES (548, '2024-05-25 17:28:42', 0, '2024-05-25 17:28:42', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-25 17:28:42');
INSERT INTO `t_job_log` VALUES (549, '2024-05-25 17:28:48', 0, '2024-05-25 17:28:48', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 17:28:47');
INSERT INTO `t_job_log` VALUES (550, '2024-05-25 20:00:01', 0, '2024-05-25 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-25 20:00:00');
INSERT INTO `t_job_log` VALUES (551, '2024-05-26 00:00:01', 0, '2024-05-26 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 00:00:00');
INSERT INTO `t_job_log` VALUES (552, '2024-05-26 04:00:01', 0, '2024-05-26 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 04:00:00');
INSERT INTO `t_job_log` VALUES (553, '2024-05-26 08:00:01', 0, '2024-05-26 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 08:00:00');
INSERT INTO `t_job_log` VALUES (554, '2024-05-26 12:00:03', 0, '2024-05-26 12:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 12:00:00');
INSERT INTO `t_job_log` VALUES (555, '2024-05-26 16:00:01', 0, '2024-05-26 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 16:00:00');
INSERT INTO `t_job_log` VALUES (556, '2024-05-26 20:00:01', 0, '2024-05-26 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-26 20:00:00');
INSERT INTO `t_job_log` VALUES (557, '2024-05-27 00:00:01', 0, '2024-05-27 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 00:00:00');
INSERT INTO `t_job_log` VALUES (558, '2024-05-27 04:00:01', 0, '2024-05-27 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 04:00:00');
INSERT INTO `t_job_log` VALUES (559, '2024-05-27 08:00:02', 0, '2024-05-27 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 08:00:00');
INSERT INTO `t_job_log` VALUES (560, '2024-05-27 12:00:02', 0, '2024-05-27 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 12:00:00');
INSERT INTO `t_job_log` VALUES (561, '2024-05-27 16:00:01', 0, '2024-05-27 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 16:00:00');
INSERT INTO `t_job_log` VALUES (562, '2024-05-27 20:00:01', 0, '2024-05-27 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-27 20:00:00');
INSERT INTO `t_job_log` VALUES (563, '2024-05-28 00:00:01', 0, '2024-05-28 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 00:00:00');
INSERT INTO `t_job_log` VALUES (564, '2024-05-28 03:41:15', 0, '2024-05-28 03:41:15', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-28 03:41:15');
INSERT INTO `t_job_log` VALUES (565, '2024-05-28 03:41:21', 0, '2024-05-28 03:41:21', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 03:41:20');
INSERT INTO `t_job_log` VALUES (566, '2024-05-28 04:00:01', 0, '2024-05-28 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 04:00:00');
INSERT INTO `t_job_log` VALUES (567, '2024-05-28 08:00:02', 0, '2024-05-28 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 08:00:00');
INSERT INTO `t_job_log` VALUES (568, '2024-05-28 10:10:31', 0, '2024-05-28 10:10:31', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-28 10:10:31');
INSERT INTO `t_job_log` VALUES (569, '2024-05-28 10:10:38', 0, '2024-05-28 10:10:38', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 10:10:36');
INSERT INTO `t_job_log` VALUES (570, '2024-05-28 12:00:02', 0, '2024-05-28 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 12:00:00');
INSERT INTO `t_job_log` VALUES (571, '2024-05-28 15:47:49', 0, '2024-05-28 15:47:49', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-28 15:47:49');
INSERT INTO `t_job_log` VALUES (572, '2024-05-28 15:47:55', 0, '2024-05-28 15:47:55', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 15:47:54');
INSERT INTO `t_job_log` VALUES (573, '2024-05-28 16:00:02', 0, '2024-05-28 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 16:00:00');
INSERT INTO `t_job_log` VALUES (574, '2024-05-28 20:00:01', 0, '2024-05-28 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次未写入本地文件tv.txt[内容行数373不够3000或不含cctv或卫视] 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-28 20:00:00');
INSERT INTO `t_job_log` VALUES (575, '2024-05-29 00:00:01', 0, '2024-05-29 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 00:00:00');
INSERT INTO `t_job_log` VALUES (576, '2024-05-29 04:00:01', 0, '2024-05-29 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 04:00:00');
INSERT INTO `t_job_log` VALUES (577, '2024-05-29 08:00:01', 0, '2024-05-29 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 08:00:00');
INSERT INTO `t_job_log` VALUES (578, '2024-05-29 09:42:23', 0, '2024-05-29 09:42:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-29 09:42:23');
INSERT INTO `t_job_log` VALUES (579, '2024-05-29 09:42:29', 0, '2024-05-29 09:42:29', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 09:42:28');
INSERT INTO `t_job_log` VALUES (580, '2024-05-29 10:11:27', 0, '2024-05-29 10:11:27', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-29 10:11:27');
INSERT INTO `t_job_log` VALUES (581, '2024-05-29 10:11:33', 0, '2024-05-29 10:11:33', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 10:11:32');
INSERT INTO `t_job_log` VALUES (582, '2024-05-29 10:17:21', 0, '2024-05-29 10:17:21', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-29 10:17:21');
INSERT INTO `t_job_log` VALUES (583, '2024-05-29 10:17:27', 0, '2024-05-29 10:17:27', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 10:17:26');
INSERT INTO `t_job_log` VALUES (584, '2024-05-29 10:24:33', 0, '2024-05-29 10:24:33', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-29 10:24:33');
INSERT INTO `t_job_log` VALUES (585, '2024-05-29 10:24:39', 0, '2024-05-29 10:24:39', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 10:24:38');
INSERT INTO `t_job_log` VALUES (586, '2024-05-29 10:38:01', 0, '2024-05-29 10:38:01', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-29 10:38:00');
INSERT INTO `t_job_log` VALUES (587, '2024-05-29 10:38:07', 0, '2024-05-29 10:38:07', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 10:38:06');
INSERT INTO `t_job_log` VALUES (588, '2024-05-29 11:48:52', 0, '2024-05-29 11:48:52', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-29 11:48:52');
INSERT INTO `t_job_log` VALUES (589, '2024-05-29 11:49:00', 0, '2024-05-29 11:49:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 11:48:57');
INSERT INTO `t_job_log` VALUES (590, '2024-05-29 12:00:04', 0, '2024-05-29 12:00:04', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 12:00:00');
INSERT INTO `t_job_log` VALUES (591, '2024-05-29 13:11:34', 0, '2024-05-29 13:11:34', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-29 13:11:33');
INSERT INTO `t_job_log` VALUES (592, '2024-05-29 13:11:40', 0, '2024-05-29 13:11:40', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 13:11:39');
INSERT INTO `t_job_log` VALUES (593, '2024-05-29 13:12:45', 0, '2024-05-29 13:12:45', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次未写入本地文件tv.txt[内容行数250不够3000或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数250不够300或不含cctv或卫视]', NULL, 1, '2024-05-29 13:12:41');
INSERT INTO `t_job_log` VALUES (594, '2024-05-29 13:16:47', 0, '2024-05-29 13:16:47', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-29 13:16:47');
INSERT INTO `t_job_log` VALUES (595, '2024-05-29 13:16:54', 0, '2024-05-29 13:16:54', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-29 13:16:52');
INSERT INTO `t_job_log` VALUES (596, '2024-05-29 13:17:05', 0, '2024-05-29 13:17:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-29 13:17:02');
INSERT INTO `t_job_log` VALUES (597, '2024-05-29 16:00:06', 0, '2024-05-29 16:00:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-05-29 16:00:00');
INSERT INTO `t_job_log` VALUES (598, '2024-05-29 20:00:01', 0, '2024-05-29 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-29 20:00:00');
INSERT INTO `t_job_log` VALUES (600, '2024-05-30 02:51:35', 0, '2024-05-30 02:51:35', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-30 02:51:35');
INSERT INTO `t_job_log` VALUES (601, '2024-05-30 02:51:47', 0, '2024-05-30 02:51:47', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-30 02:51:47');
INSERT INTO `t_job_log` VALUES (602, '2024-05-30 04:00:01', 0, '2024-05-30 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 04:00:00');
INSERT INTO `t_job_log` VALUES (603, '2024-05-30 08:00:01', 0, '2024-05-30 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 08:00:00');
INSERT INTO `t_job_log` VALUES (604, '2024-05-30 12:00:01', 0, '2024-05-30 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 12:00:00');
INSERT INTO `t_job_log` VALUES (605, '2024-05-30 16:00:01', 0, '2024-05-30 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 16:00:00');
INSERT INTO `t_job_log` VALUES (606, '2024-05-30 18:54:29', 0, '2024-05-30 18:54:29', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-30 18:54:29');
INSERT INTO `t_job_log` VALUES (607, '2024-05-30 18:54:35', 0, '2024-05-30 18:54:35', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 18:54:34');
INSERT INTO `t_job_log` VALUES (608, '2024-05-30 20:00:01', 0, '2024-05-30 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-30 20:00:00');
INSERT INTO `t_job_log` VALUES (609, '2024-05-31 00:00:01', 0, '2024-05-31 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 00:00:00');
INSERT INTO `t_job_log` VALUES (610, '2024-05-31 04:00:01', 0, '2024-05-31 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 04:00:00');
INSERT INTO `t_job_log` VALUES (611, '2024-05-31 08:00:01', 0, '2024-05-31 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 08:00:00');
INSERT INTO `t_job_log` VALUES (612, '2024-05-31 12:00:01', 0, '2024-05-31 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 12:00:00');
INSERT INTO `t_job_log` VALUES (613, '2024-05-31 16:00:01', 0, '2024-05-31 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 16:00:00');
INSERT INTO `t_job_log` VALUES (614, '2024-05-31 20:00:01', 0, '2024-05-31 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-05-31 20:00:00');
INSERT INTO `t_job_log` VALUES (615, '2024-05-31 23:00:44', 0, '2024-05-31 23:00:44', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-05-31 23:00:44');
INSERT INTO `t_job_log` VALUES (616, '2024-06-01 00:00:02', 0, '2024-06-01 00:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 00:00:00');
INSERT INTO `t_job_log` VALUES (617, '2024-06-01 04:00:01', 0, '2024-06-01 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 04:00:00');
INSERT INTO `t_job_log` VALUES (618, '2024-06-01 04:49:04', 0, '2024-06-01 04:49:04', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-01 04:49:04');
INSERT INTO `t_job_log` VALUES (619, '2024-06-01 04:49:10', 0, '2024-06-01 04:49:10', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 04:49:09');
INSERT INTO `t_job_log` VALUES (620, '2024-06-01 08:00:01', 0, '2024-06-01 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 08:00:00');
INSERT INTO `t_job_log` VALUES (621, '2024-06-01 10:16:32', 0, '2024-06-01 10:16:32', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-01 10:16:32');
INSERT INTO `t_job_log` VALUES (622, '2024-06-01 10:16:38', 0, '2024-06-01 10:16:38', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 10:16:37');
INSERT INTO `t_job_log` VALUES (623, '2024-06-01 11:50:16', 0, '2024-06-01 11:50:16', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-01 11:50:16');
INSERT INTO `t_job_log` VALUES (624, '2024-06-01 11:50:22', 0, '2024-06-01 11:50:22', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 11:50:21');
INSERT INTO `t_job_log` VALUES (625, '2024-06-01 12:00:01', 0, '2024-06-01 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 12:00:00');
INSERT INTO `t_job_log` VALUES (626, '2024-06-01 14:21:03', 0, '2024-06-01 14:21:03', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-01 14:21:03');
INSERT INTO `t_job_log` VALUES (627, '2024-06-01 14:21:10', 0, '2024-06-01 14:21:10', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 14:21:08');
INSERT INTO `t_job_log` VALUES (628, '2024-06-01 16:00:02', 0, '2024-06-01 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 16:00:00');
INSERT INTO `t_job_log` VALUES (629, '2024-06-01 20:00:01', 0, '2024-06-01 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-01 20:00:00');
INSERT INTO `t_job_log` VALUES (630, '2024-06-02 00:00:01', 0, '2024-06-02 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 00:00:00');
INSERT INTO `t_job_log` VALUES (631, '2024-06-02 04:00:01', 0, '2024-06-02 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 04:00:00');
INSERT INTO `t_job_log` VALUES (632, '2024-06-02 08:00:01', 0, '2024-06-02 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 08:00:00');
INSERT INTO `t_job_log` VALUES (633, '2024-06-02 12:00:06', 0, '2024-06-02 12:00:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-02 12:00:00');
INSERT INTO `t_job_log` VALUES (634, '2024-06-02 16:00:01', 0, '2024-06-02 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 16:00:00');
INSERT INTO `t_job_log` VALUES (635, '2024-06-02 20:00:01', 0, '2024-06-02 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-02 20:00:00');
INSERT INTO `t_job_log` VALUES (636, '2024-06-03 00:00:01', 0, '2024-06-03 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 00:00:00');
INSERT INTO `t_job_log` VALUES (637, '2024-06-03 04:00:01', 0, '2024-06-03 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 04:00:00');
INSERT INTO `t_job_log` VALUES (638, '2024-06-03 08:00:01', 0, '2024-06-03 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 08:00:00');
INSERT INTO `t_job_log` VALUES (639, '2024-06-03 12:00:01', 0, '2024-06-03 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 12:00:00');
INSERT INTO `t_job_log` VALUES (640, '2024-06-03 13:42:13', 0, '2024-06-03 13:42:13', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-03 13:42:12');
INSERT INTO `t_job_log` VALUES (641, '2024-06-03 13:42:20', 0, '2024-06-03 13:42:20', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 13:42:18');
INSERT INTO `t_job_log` VALUES (642, '2024-06-03 16:00:01', 0, '2024-06-03 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 16:00:00');
INSERT INTO `t_job_log` VALUES (643, '2024-06-03 20:00:01', 0, '2024-06-03 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-03 20:00:00');
INSERT INTO `t_job_log` VALUES (644, '2024-06-04 00:00:01', 0, '2024-06-04 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 00:00:00');
INSERT INTO `t_job_log` VALUES (645, '2024-06-04 04:00:01', 0, '2024-06-04 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 04:00:00');
INSERT INTO `t_job_log` VALUES (646, '2024-06-04 08:00:01', 0, '2024-06-04 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 08:00:00');
INSERT INTO `t_job_log` VALUES (647, '2024-06-04 09:03:05', 0, '2024-06-04 09:03:05', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-04 09:03:05');
INSERT INTO `t_job_log` VALUES (648, '2024-06-04 09:03:11', 0, '2024-06-04 09:03:11', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 09:03:10');
INSERT INTO `t_job_log` VALUES (649, '2024-06-04 12:00:01', 0, '2024-06-04 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 12:00:00');
INSERT INTO `t_job_log` VALUES (650, '2024-06-04 16:00:01', 0, '2024-06-04 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 16:00:00');
INSERT INTO `t_job_log` VALUES (651, '2024-06-04 16:01:23', 0, '2024-06-04 16:01:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-04 16:01:23');
INSERT INTO `t_job_log` VALUES (652, '2024-06-04 16:01:29', 0, '2024-06-04 16:01:29', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 16:01:28');
INSERT INTO `t_job_log` VALUES (653, '2024-06-04 20:00:01', 0, '2024-06-04 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-04 20:00:00');
INSERT INTO `t_job_log` VALUES (654, '2024-06-05 00:00:01', 0, '2024-06-05 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 00:00:00');
INSERT INTO `t_job_log` VALUES (655, '2024-06-05 04:00:01', 0, '2024-06-05 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 04:00:00');
INSERT INTO `t_job_log` VALUES (656, '2024-06-05 08:00:05', 0, '2024-06-05 08:00:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 08:00:00');
INSERT INTO `t_job_log` VALUES (657, '2024-06-05 12:00:02', 0, '2024-06-05 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 12:00:00');
INSERT INTO `t_job_log` VALUES (658, '2024-06-05 15:25:04', 0, '2024-06-05 15:25:04', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-05 15:25:04');
INSERT INTO `t_job_log` VALUES (659, '2024-06-05 15:42:33', 0, '2024-06-05 15:42:33', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-05 15:42:33');
INSERT INTO `t_job_log` VALUES (660, '2024-06-05 15:42:35', 0, '2024-06-05 15:42:35', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 15:42:34');
INSERT INTO `t_job_log` VALUES (661, '2024-06-05 15:53:44', 0, '2024-06-05 15:53:44', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-05 15:53:44');
INSERT INTO `t_job_log` VALUES (662, '2024-06-05 15:53:50', 0, '2024-06-05 15:53:50', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 15:53:49');
INSERT INTO `t_job_log` VALUES (663, '2024-06-05 16:00:01', 0, '2024-06-05 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 16:00:00');
INSERT INTO `t_job_log` VALUES (664, '2024-06-05 20:00:01', 0, '2024-06-05 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-05 20:00:00');
INSERT INTO `t_job_log` VALUES (665, '2024-06-06 00:00:03', 0, '2024-06-06 00:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 00:00:00');
INSERT INTO `t_job_log` VALUES (666, '2024-06-06 00:13:39', 0, '2024-06-06 00:13:39', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-06 00:13:39');
INSERT INTO `t_job_log` VALUES (667, '2024-06-06 00:13:47', 0, '2024-06-06 00:13:47', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 00:13:44');
INSERT INTO `t_job_log` VALUES (668, '2024-06-06 00:19:50', 0, '2024-06-06 00:19:50', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-06 00:19:50');
INSERT INTO `t_job_log` VALUES (669, '2024-06-06 00:19:56', 0, '2024-06-06 00:19:56', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 00:19:55');
INSERT INTO `t_job_log` VALUES (670, '2024-06-06 02:55:41', 0, '2024-06-06 02:55:41', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-06 02:55:41');
INSERT INTO `t_job_log` VALUES (671, '2024-06-06 02:55:47', 0, '2024-06-06 02:55:47', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 02:55:46');
INSERT INTO `t_job_log` VALUES (672, '2024-06-06 04:00:02', 0, '2024-06-06 04:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 04:00:00');
INSERT INTO `t_job_log` VALUES (673, '2024-06-06 08:00:01', 0, '2024-06-06 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 08:00:00');
INSERT INTO `t_job_log` VALUES (674, '2024-06-06 09:11:00', 0, '2024-06-06 09:11:00', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-06 09:11:00');
INSERT INTO `t_job_log` VALUES (675, '2024-06-06 09:11:06', 0, '2024-06-06 09:11:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 09:11:05');
INSERT INTO `t_job_log` VALUES (676, '2024-06-06 10:00:24', 0, '2024-06-06 10:00:24', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-06 10:00:24');
INSERT INTO `t_job_log` VALUES (677, '2024-06-06 10:00:30', 0, '2024-06-06 10:00:30', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 10:00:29');
INSERT INTO `t_job_log` VALUES (678, '2024-06-06 12:00:01', 0, '2024-06-06 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 12:00:00');
INSERT INTO `t_job_log` VALUES (679, '2024-06-06 16:00:02', 0, '2024-06-06 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 16:00:00');
INSERT INTO `t_job_log` VALUES (680, '2024-06-06 20:00:01', 0, '2024-06-06 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-06 20:00:00');
INSERT INTO `t_job_log` VALUES (681, '2024-06-07 00:00:01', 0, '2024-06-07 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 00:00:00');
INSERT INTO `t_job_log` VALUES (682, '2024-06-07 04:00:01', 0, '2024-06-07 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 04:00:00');
INSERT INTO `t_job_log` VALUES (683, '2024-06-07 07:00:39', 0, '2024-06-07 07:00:39', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-07 07:00:39');
INSERT INTO `t_job_log` VALUES (684, '2024-06-07 08:00:01', 0, '2024-06-07 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 08:00:00');
INSERT INTO `t_job_log` VALUES (685, '2024-06-07 10:19:36', 0, '2024-06-07 10:19:36', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-07 10:19:36');
INSERT INTO `t_job_log` VALUES (686, '2024-06-07 10:19:42', 0, '2024-06-07 10:19:42', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 10:19:41');
INSERT INTO `t_job_log` VALUES (687, '2024-06-07 12:00:10', 0, '2024-06-07 12:00:10', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 12:00:00');
INSERT INTO `t_job_log` VALUES (688, '2024-06-07 16:00:12', 0, '2024-06-07 16:00:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-07 16:00:00');
INSERT INTO `t_job_log` VALUES (689, '2024-06-07 20:00:01', 0, '2024-06-07 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-07 20:00:00');
INSERT INTO `t_job_log` VALUES (690, '2024-06-08 00:00:01', 0, '2024-06-08 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 00:00:00');
INSERT INTO `t_job_log` VALUES (691, '2024-06-08 01:52:25', 0, '2024-06-08 01:52:25', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-08 01:52:24');
INSERT INTO `t_job_log` VALUES (692, '2024-06-08 01:52:30', 0, '2024-06-08 01:52:30', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 01:52:29');
INSERT INTO `t_job_log` VALUES (693, '2024-06-08 02:40:42', 0, '2024-06-08 02:40:42', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-08 02:40:42');
INSERT INTO `t_job_log` VALUES (694, '2024-06-08 02:40:48', 0, '2024-06-08 02:40:48', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 02:40:47');
INSERT INTO `t_job_log` VALUES (695, '2024-06-08 03:27:12', 0, '2024-06-08 03:27:12', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-08 03:27:12');
INSERT INTO `t_job_log` VALUES (696, '2024-06-08 03:27:18', 0, '2024-06-08 03:27:18', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 03:27:17');
INSERT INTO `t_job_log` VALUES (697, '2024-06-08 03:30:35', 0, '2024-06-08 03:30:35', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-08 03:30:35');
INSERT INTO `t_job_log` VALUES (698, '2024-06-08 03:30:41', 0, '2024-06-08 03:30:41', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 03:30:40');
INSERT INTO `t_job_log` VALUES (699, '2024-06-08 04:00:01', 0, '2024-06-08 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 04:00:00');
INSERT INTO `t_job_log` VALUES (700, '2024-06-08 08:00:03', 0, '2024-06-08 08:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 08:00:00');
INSERT INTO `t_job_log` VALUES (701, '2024-06-08 12:00:01', 0, '2024-06-08 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 12:00:00');
INSERT INTO `t_job_log` VALUES (702, '2024-06-08 16:00:01', 0, '2024-06-08 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 16:00:00');
INSERT INTO `t_job_log` VALUES (703, '2024-06-08 20:00:01', 0, '2024-06-08 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-08 20:00:00');
INSERT INTO `t_job_log` VALUES (704, '2024-06-09 00:00:01', 0, '2024-06-09 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 00:00:00');
INSERT INTO `t_job_log` VALUES (705, '2024-06-09 04:00:01', 0, '2024-06-09 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 04:00:00');
INSERT INTO `t_job_log` VALUES (706, '2024-06-09 04:34:59', 0, '2024-06-09 04:34:59', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-09 04:34:59');
INSERT INTO `t_job_log` VALUES (707, '2024-06-09 04:35:05', 0, '2024-06-09 04:35:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 04:35:04');
INSERT INTO `t_job_log` VALUES (708, '2024-06-09 08:00:02', 0, '2024-06-09 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 08:00:00');
INSERT INTO `t_job_log` VALUES (709, '2024-06-09 11:52:34', 0, '2024-06-09 11:52:34', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-09 11:52:34');
INSERT INTO `t_job_log` VALUES (710, '2024-06-09 11:52:40', 0, '2024-06-09 11:52:40', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 11:52:39');
INSERT INTO `t_job_log` VALUES (711, '2024-06-09 12:00:01', 0, '2024-06-09 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 12:00:00');
INSERT INTO `t_job_log` VALUES (712, '2024-06-09 12:35:27', 0, '2024-06-09 12:35:27', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-09 12:35:27');
INSERT INTO `t_job_log` VALUES (713, '2024-06-09 12:35:33', 0, '2024-06-09 12:35:33', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 12:35:32');
INSERT INTO `t_job_log` VALUES (714, '2024-06-09 16:00:02', 0, '2024-06-09 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 16:00:00');
INSERT INTO `t_job_log` VALUES (715, '2024-06-09 16:26:05', 0, '2024-06-09 16:26:05', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-09 16:26:05');
INSERT INTO `t_job_log` VALUES (716, '2024-06-09 16:26:12', 0, '2024-06-09 16:26:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 16:26:10');
INSERT INTO `t_job_log` VALUES (717, '2024-06-09 18:52:55', 0, '2024-06-09 18:52:55', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-09 18:52:55');
INSERT INTO `t_job_log` VALUES (718, '2024-06-09 18:56:40', 0, '2024-06-09 18:56:40', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-09 18:56:40');
INSERT INTO `t_job_log` VALUES (719, '2024-06-09 18:56:46', 0, '2024-06-09 18:56:46', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 18:56:45');
INSERT INTO `t_job_log` VALUES (720, '2024-06-09 20:00:01', 0, '2024-06-09 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-09 20:00:00');
INSERT INTO `t_job_log` VALUES (721, '2024-06-10 00:00:01', 0, '2024-06-10 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 00:00:00');
INSERT INTO `t_job_log` VALUES (722, '2024-06-10 02:30:00', 0, '2024-06-10 02:30:00', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-10 02:30:00');
INSERT INTO `t_job_log` VALUES (723, '2024-06-10 02:57:38', 0, '2024-06-10 02:57:38', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-10 02:57:38');
INSERT INTO `t_job_log` VALUES (724, '2024-06-10 02:57:44', 0, '2024-06-10 02:57:44', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 02:57:43');
INSERT INTO `t_job_log` VALUES (725, '2024-06-10 04:00:02', 0, '2024-06-10 04:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 04:00:00');
INSERT INTO `t_job_log` VALUES (726, '2024-06-10 08:00:03', 0, '2024-06-10 08:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 08:00:00');
INSERT INTO `t_job_log` VALUES (727, '2024-06-10 12:00:02', 0, '2024-06-10 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 12:00:00');
INSERT INTO `t_job_log` VALUES (728, '2024-06-10 16:00:01', 0, '2024-06-10 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 16:00:00');
INSERT INTO `t_job_log` VALUES (729, '2024-06-10 20:00:01', 0, '2024-06-10 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-10 20:00:00');
INSERT INTO `t_job_log` VALUES (730, '2024-06-11 00:00:01', 0, '2024-06-11 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 00:00:00');
INSERT INTO `t_job_log` VALUES (731, '2024-06-11 01:56:51', 0, '2024-06-11 01:56:51', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-11 01:56:51');
INSERT INTO `t_job_log` VALUES (732, '2024-06-11 02:30:09', 0, '2024-06-11 02:30:09', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-11 02:30:09');
INSERT INTO `t_job_log` VALUES (733, '2024-06-11 02:30:17', 0, '2024-06-11 02:30:17', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 02:30:14');
INSERT INTO `t_job_log` VALUES (734, '2024-06-11 04:00:01', 0, '2024-06-11 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 04:00:00');
INSERT INTO `t_job_log` VALUES (735, '2024-06-11 08:00:03', 0, '2024-06-11 08:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 08:00:00');
INSERT INTO `t_job_log` VALUES (736, '2024-06-11 10:04:57', 0, '2024-06-11 10:04:57', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-11 10:04:57');
INSERT INTO `t_job_log` VALUES (737, '2024-06-11 10:48:37', 0, '2024-06-11 10:48:37', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-11 10:48:37');
INSERT INTO `t_job_log` VALUES (738, '2024-06-11 10:48:38', 0, '2024-06-11 10:48:38', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 10:48:37');
INSERT INTO `t_job_log` VALUES (739, '2024-06-11 12:00:08', 0, '2024-06-11 12:00:08', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-11 12:00:00');
INSERT INTO `t_job_log` VALUES (740, '2024-06-11 16:00:01', 0, '2024-06-11 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 16:00:00');
INSERT INTO `t_job_log` VALUES (741, '2024-06-11 20:00:01', 0, '2024-06-11 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-11 20:00:00');
INSERT INTO `t_job_log` VALUES (742, '2024-06-12 00:00:01', 0, '2024-06-12 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 00:00:00');
INSERT INTO `t_job_log` VALUES (743, '2024-06-12 02:16:23', 0, '2024-06-12 02:16:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-12 02:16:23');
INSERT INTO `t_job_log` VALUES (744, '2024-06-12 02:16:29', 0, '2024-06-12 02:16:29', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 02:16:28');
INSERT INTO `t_job_log` VALUES (745, '2024-06-12 03:06:24', 0, '2024-06-12 03:06:24', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-12 03:06:24');
INSERT INTO `t_job_log` VALUES (746, '2024-06-12 03:06:30', 0, '2024-06-12 03:06:30', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 03:06:29');
INSERT INTO `t_job_log` VALUES (747, '2024-06-12 04:00:01', 0, '2024-06-12 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 04:00:00');
INSERT INTO `t_job_log` VALUES (748, '2024-06-12 08:00:01', 0, '2024-06-12 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 08:00:00');
INSERT INTO `t_job_log` VALUES (749, '2024-06-12 10:09:47', 0, '2024-06-12 10:09:47', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-12 10:09:47');
INSERT INTO `t_job_log` VALUES (750, '2024-06-12 12:00:01', 0, '2024-06-12 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 12:00:00');
INSERT INTO `t_job_log` VALUES (751, '2024-06-12 16:00:02', 0, '2024-06-12 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 16:00:00');
INSERT INTO `t_job_log` VALUES (752, '2024-06-12 20:00:01', 0, '2024-06-12 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-12 20:00:00');
INSERT INTO `t_job_log` VALUES (753, '2024-06-13 00:00:02', 0, '2024-06-13 00:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 00:00:00');
INSERT INTO `t_job_log` VALUES (754, '2024-06-13 04:00:06', 0, '2024-06-13 04:00:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-13 04:00:00');
INSERT INTO `t_job_log` VALUES (755, '2024-06-13 04:46:35', 0, '2024-06-13 04:46:35', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-13 04:46:35');
INSERT INTO `t_job_log` VALUES (756, '2024-06-13 04:46:41', 0, '2024-06-13 04:46:41', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 04:46:40');
INSERT INTO `t_job_log` VALUES (757, '2024-06-13 06:11:33', 0, '2024-06-13 06:11:33', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-13 06:11:33');
INSERT INTO `t_job_log` VALUES (758, '2024-06-13 08:00:01', 0, '2024-06-13 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 08:00:00');
INSERT INTO `t_job_log` VALUES (759, '2024-06-13 09:30:11', 0, '2024-06-13 09:30:11', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-13 09:30:11');
INSERT INTO `t_job_log` VALUES (760, '2024-06-13 09:30:18', 0, '2024-06-13 09:30:18', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 09:30:16');
INSERT INTO `t_job_log` VALUES (761, '2024-06-13 09:57:01', 0, '2024-06-13 09:57:01', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-13 09:57:01');
INSERT INTO `t_job_log` VALUES (762, '2024-06-13 09:57:07', 0, '2024-06-13 09:57:07', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 09:57:06');
INSERT INTO `t_job_log` VALUES (763, '2024-06-13 12:00:02', 0, '2024-06-13 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-13 12:00:00');
INSERT INTO `t_job_log` VALUES (764, '2024-06-14 00:00:01', 0, '2024-06-14 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 00:00:00');
INSERT INTO `t_job_log` VALUES (765, '2024-06-14 04:00:01', 0, '2024-06-14 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 04:00:00');
INSERT INTO `t_job_log` VALUES (766, '2024-06-14 11:27:06', 0, '2024-06-14 11:27:06', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-14 11:27:06');
INSERT INTO `t_job_log` VALUES (767, '2024-06-14 11:27:12', 0, '2024-06-14 11:27:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 11:27:11');
INSERT INTO `t_job_log` VALUES (768, '2024-06-14 11:29:29', 0, '2024-06-14 11:29:29', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-14 11:29:29');
INSERT INTO `t_job_log` VALUES (769, '2024-06-14 11:29:35', 0, '2024-06-14 11:29:35', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 11:29:34');
INSERT INTO `t_job_log` VALUES (770, '2024-06-14 12:00:01', 0, '2024-06-14 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 12:00:00');
INSERT INTO `t_job_log` VALUES (771, '2024-06-14 16:00:02', 0, '2024-06-14 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 16:00:00');
INSERT INTO `t_job_log` VALUES (772, '2024-06-14 18:03:25', 0, '2024-06-14 18:03:25', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-14 18:03:25');
INSERT INTO `t_job_log` VALUES (773, '2024-06-14 18:03:32', 0, '2024-06-14 18:03:32', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 18:03:30');
INSERT INTO `t_job_log` VALUES (774, '2024-06-14 20:00:01', 0, '2024-06-14 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:250本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-14 20:00:00');
INSERT INTO `t_job_log` VALUES (775, '2024-06-15 00:00:01', 0, '2024-06-15 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 00:00:00');
INSERT INTO `t_job_log` VALUES (776, '2024-06-15 04:00:04', 0, '2024-06-15 04:00:04', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 04:00:00');
INSERT INTO `t_job_log` VALUES (777, '2024-06-15 06:37:29', 0, '2024-06-15 06:37:29', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-15 06:37:29');
INSERT INTO `t_job_log` VALUES (778, '2024-06-15 06:37:35', 0, '2024-06-15 06:37:35', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 06:37:34');
INSERT INTO `t_job_log` VALUES (779, '2024-06-15 07:26:01', 0, '2024-06-15 07:26:01', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-15 07:26:00');
INSERT INTO `t_job_log` VALUES (780, '2024-06-15 07:26:07', 0, '2024-06-15 07:26:07', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 07:26:05');
INSERT INTO `t_job_log` VALUES (781, '2024-06-15 08:00:05', 0, '2024-06-15 08:00:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 08:00:00');
INSERT INTO `t_job_log` VALUES (782, '2024-06-15 12:00:03', 0, '2024-06-15 12:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 12:00:00');
INSERT INTO `t_job_log` VALUES (783, '2024-06-15 13:15:52', 0, '2024-06-15 13:15:52', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-15 13:15:52');
INSERT INTO `t_job_log` VALUES (784, '2024-06-15 13:16:01', 0, '2024-06-15 13:16:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 13:15:57');
INSERT INTO `t_job_log` VALUES (785, '2024-06-15 16:00:03', 0, '2024-06-15 16:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 16:00:00');
INSERT INTO `t_job_log` VALUES (786, '2024-06-15 20:00:01', 0, '2024-06-15 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:324本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-15 20:00:00');
INSERT INTO `t_job_log` VALUES (787, '2024-06-16 00:00:01', 0, '2024-06-16 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 00:00:00');
INSERT INTO `t_job_log` VALUES (788, '2024-06-16 04:00:02', 0, '2024-06-16 04:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 04:00:00');
INSERT INTO `t_job_log` VALUES (789, '2024-06-16 08:00:01', 0, '2024-06-16 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 08:00:00');
INSERT INTO `t_job_log` VALUES (790, '2024-06-16 09:49:26', 0, '2024-06-16 09:49:26', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-16 09:49:26');
INSERT INTO `t_job_log` VALUES (791, '2024-06-16 09:49:32', 0, '2024-06-16 09:49:32', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 09:49:31');
INSERT INTO `t_job_log` VALUES (792, '2024-06-16 12:00:02', 0, '2024-06-16 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 12:00:00');
INSERT INTO `t_job_log` VALUES (793, '2024-06-16 16:00:01', 0, '2024-06-16 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 16:00:00');
INSERT INTO `t_job_log` VALUES (794, '2024-06-16 17:10:28', 0, '2024-06-16 17:10:28', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-16 17:10:28');
INSERT INTO `t_job_log` VALUES (795, '2024-06-16 20:00:01', 0, '2024-06-16 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:317本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-16 20:00:00');
INSERT INTO `t_job_log` VALUES (796, '2024-06-17 00:00:01', 0, '2024-06-17 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 00:00:00');
INSERT INTO `t_job_log` VALUES (797, '2024-06-17 04:00:02', 0, '2024-06-17 04:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 04:00:00');
INSERT INTO `t_job_log` VALUES (798, '2024-06-17 07:27:13', 0, '2024-06-17 07:27:13', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-17 07:27:13');
INSERT INTO `t_job_log` VALUES (799, '2024-06-17 07:27:19', 0, '2024-06-17 07:27:19', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 07:27:18');
INSERT INTO `t_job_log` VALUES (800, '2024-06-17 08:00:02', 0, '2024-06-17 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 08:00:00');
INSERT INTO `t_job_log` VALUES (801, '2024-06-17 10:13:16', 0, '2024-06-17 10:13:16', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-17 10:13:16');
INSERT INTO `t_job_log` VALUES (802, '2024-06-17 10:13:22', 0, '2024-06-17 10:13:22', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 10:13:21');
INSERT INTO `t_job_log` VALUES (803, '2024-06-17 12:00:04', 0, '2024-06-17 12:00:04', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 12:00:00');
INSERT INTO `t_job_log` VALUES (804, '2024-06-17 15:01:50', 0, '2024-06-17 15:01:50', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-17 15:01:50');
INSERT INTO `t_job_log` VALUES (805, '2024-06-17 16:00:02', 0, '2024-06-17 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 16:00:00');
INSERT INTO `t_job_log` VALUES (806, '2024-06-17 16:02:16', 0, '2024-06-17 16:02:16', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-17 16:02:15');
INSERT INTO `t_job_log` VALUES (807, '2024-06-17 16:35:34', 0, '2024-06-17 16:35:34', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-17 16:35:34');
INSERT INTO `t_job_log` VALUES (808, '2024-06-17 16:35:41', 0, '2024-06-17 16:35:41', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 16:35:39');
INSERT INTO `t_job_log` VALUES (809, '2024-06-17 16:45:29', 0, '2024-06-17 16:45:29', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-17 16:45:29');
INSERT INTO `t_job_log` VALUES (810, '2024-06-17 20:00:01', 0, '2024-06-17 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:432本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-17 20:00:00');
INSERT INTO `t_job_log` VALUES (811, '2024-06-18 00:00:01', 0, '2024-06-18 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 00:00:00');
INSERT INTO `t_job_log` VALUES (812, '2024-06-18 04:00:02', 0, '2024-06-18 04:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 04:00:00');
INSERT INTO `t_job_log` VALUES (813, '2024-06-18 08:00:01', 0, '2024-06-18 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 08:00:00');
INSERT INTO `t_job_log` VALUES (815, '2024-06-18 16:00:01', 0, '2024-06-18 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 16:00:00');
INSERT INTO `t_job_log` VALUES (814, '2024-06-18 12:00:01', 0, '2024-06-18 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 12:00:00');
INSERT INTO `t_job_log` VALUES (816, '2024-06-18 16:02:52', 0, '2024-06-18 16:02:52', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-18 16:02:52');
INSERT INTO `t_job_log` VALUES (817, '2024-06-18 16:02:58', 0, '2024-06-18 16:02:58', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 16:02:57');
INSERT INTO `t_job_log` VALUES (818, '2024-06-18 17:46:30', 0, '2024-06-18 17:46:30', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-18 17:46:30');
INSERT INTO `t_job_log` VALUES (819, '2024-06-18 17:46:37', 0, '2024-06-18 17:46:37', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 17:46:35');
INSERT INTO `t_job_log` VALUES (820, '2024-06-18 20:00:02', 0, '2024-06-18 20:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:399本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-18 20:00:00');
INSERT INTO `t_job_log` VALUES (821, '2024-06-19 00:00:01', 0, '2024-06-19 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 00:00:00');
INSERT INTO `t_job_log` VALUES (822, '2024-06-19 03:44:45', 0, '2024-06-19 03:44:45', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-19 03:44:45');
INSERT INTO `t_job_log` VALUES (823, '2024-06-19 03:44:51', 0, '2024-06-19 03:44:51', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 03:44:50');
INSERT INTO `t_job_log` VALUES (824, '2024-06-19 04:00:01', 0, '2024-06-19 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 04:00:00');
INSERT INTO `t_job_log` VALUES (825, '2024-06-19 08:00:06', 0, '2024-06-19 08:00:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 08:00:00');
INSERT INTO `t_job_log` VALUES (826, '2024-06-19 09:46:31', 0, '2024-06-19 09:46:31', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-19 09:46:31');
INSERT INTO `t_job_log` VALUES (827, '2024-06-19 09:46:40', 0, '2024-06-19 09:46:40', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 09:46:36');
INSERT INTO `t_job_log` VALUES (828, '2024-06-19 09:51:15', 0, '2024-06-19 09:51:15', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-19 09:51:15');
INSERT INTO `t_job_log` VALUES (829, '2024-06-19 09:51:21', 0, '2024-06-19 09:51:21', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 09:51:20');
INSERT INTO `t_job_log` VALUES (830, '2024-06-19 11:58:27', 0, '2024-06-19 11:58:27', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-19 11:58:26');
INSERT INTO `t_job_log` VALUES (831, '2024-06-19 11:58:32', 0, '2024-06-19 11:58:32', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 11:58:31');
INSERT INTO `t_job_log` VALUES (832, '2024-06-19 12:00:01', 0, '2024-06-19 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 12:00:00');
INSERT INTO `t_job_log` VALUES (833, '2024-06-19 16:00:01', 0, '2024-06-19 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 16:00:00');
INSERT INTO `t_job_log` VALUES (834, '2024-06-19 20:00:01', 0, '2024-06-19 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:282本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-19 20:00:00');
INSERT INTO `t_job_log` VALUES (835, '2024-06-20 00:00:01', 0, '2024-06-20 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 00:00:00');
INSERT INTO `t_job_log` VALUES (836, '2024-06-20 03:07:12', 0, '2024-06-20 03:07:12', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-20 03:07:12');
INSERT INTO `t_job_log` VALUES (837, '2024-06-20 03:07:26', 0, '2024-06-20 03:07:26', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://172.23.0.6:5708\"', NULL, 1, '2024-06-20 03:07:26');
INSERT INTO `t_job_log` VALUES (838, '2024-06-20 03:07:32', 0, '2024-06-20 03:07:32', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 03:07:31');
INSERT INTO `t_job_log` VALUES (839, '2024-06-20 04:01:56', 0, '2024-06-20 04:01:56', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 04:01:56');
INSERT INTO `t_job_log` VALUES (840, '2024-06-20 04:02:01', 0, '2024-06-20 04:02:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File \"/usr/local/lib/python3.8/site-packages/apscheduler/executors/base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"/hipy/tasks/tv_spider.py\", line 19, in main\n    txt_files = [file for file in files if str(file[\'name\']).endswith(\'.txt\') and file[\'type\'] == \'file\']\n  File \"/hipy/tasks/tv_spider.py\", line 19, in <listcomp>\n    txt_files = [file for file in files if str(file[\'name\']).endswith(\'.txt\') and file[\'type\'] == \'file\']\n', 'string indices must be integers', 0, '2024-06-20 04:02:01');
INSERT INTO `t_job_log` VALUES (841, '2024-06-20 04:02:14', 0, '2024-06-20 04:02:14', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 04:02:14');
INSERT INTO `t_job_log` VALUES (868, '2024-06-21 08:12:24', 0, '2024-06-21 08:12:24', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 08:12:24');
INSERT INTO `t_job_log` VALUES (869, '2024-06-21 09:20:17', 0, '2024-06-21 09:20:17', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 09:20:16');
INSERT INTO `t_job_log` VALUES (842, '2024-06-20 04:02:19', 0, '2024-06-20 04:02:19', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File \"/usr/local/lib/python3.8/site-packages/apscheduler/executors/base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"/hipy/tasks/tv_spider.py\", line 19, in main\n    txt_files = [file for file in files if str(file[\'name\']).endswith(\'.txt\') and file[\'type\'] == \'file\']\n  File \"/hipy/tasks/tv_spider.py\", line 19, in <listcomp>\n    txt_files = [file for file in files if str(file[\'name\']).endswith(\'.txt\') and file[\'type\'] == \'file\']\n', 'string indices must be integers', 0, '2024-06-20 04:02:19');
INSERT INTO `t_job_log` VALUES (843, '2024-06-20 04:03:41', 0, '2024-06-20 04:03:41', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 04:03:41');
INSERT INTO `t_job_log` VALUES (844, '2024-06-20 04:03:46', 0, '2024-06-20 04:03:46', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '  File \"/usr/local/lib/python3.8/site-packages/apscheduler/executors/base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"/hipy/tasks/tv_spider.py\", line 19, in main\n    txt_files = [file for file in files if str(file[\'name\']).endswith(\'.txt\') and file[\'type\'] == \'file\']\n  File \"/hipy/tasks/tv_spider.py\", line 19, in <listcomp>\n    txt_files = [file for file in files if str(file[\'name\']).endswith(\'.txt\') and file[\'type\'] == \'file\']\n', 'string indices must be integers', 0, '2024-06-20 04:03:46');
INSERT INTO `t_job_log` VALUES (845, '2024-06-20 05:29:59', 0, '2024-06-20 05:29:59', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 05:29:59');
INSERT INTO `t_job_log` VALUES (846, '2024-06-20 05:30:06', 0, '2024-06-20 05:30:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 05:30:04');
INSERT INTO `t_job_log` VALUES (847, '2024-06-20 05:52:29', 0, '2024-06-20 05:52:29', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 05:52:28');
INSERT INTO `t_job_log` VALUES (848, '2024-06-20 05:52:34', 0, '2024-06-20 05:52:34', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 05:52:33');
INSERT INTO `t_job_log` VALUES (849, '2024-06-20 06:01:35', 0, '2024-06-20 06:01:35', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 06:01:34');
INSERT INTO `t_job_log` VALUES (850, '2024-06-20 06:01:40', 0, '2024-06-20 06:01:40', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 06:01:39');
INSERT INTO `t_job_log` VALUES (851, '2024-06-20 08:00:01', 0, '2024-06-20 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 08:00:00');
INSERT INTO `t_job_log` VALUES (852, '2024-06-20 08:09:23', 0, '2024-06-20 08:09:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 08:09:23');
INSERT INTO `t_job_log` VALUES (853, '2024-06-20 08:09:29', 0, '2024-06-20 08:09:29', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 08:09:28');
INSERT INTO `t_job_log` VALUES (854, '2024-06-20 08:33:44', 0, '2024-06-20 08:33:44', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 08:33:44');
INSERT INTO `t_job_log` VALUES (855, '2024-06-20 08:33:50', 0, '2024-06-20 08:33:50', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 08:33:49');
INSERT INTO `t_job_log` VALUES (856, '2024-06-20 09:14:41', 0, '2024-06-20 09:14:41', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-20 09:14:41');
INSERT INTO `t_job_log` VALUES (857, '2024-06-20 09:14:47', 0, '2024-06-20 09:14:47', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 09:14:46');
INSERT INTO `t_job_log` VALUES (858, '2024-06-20 12:00:01', 0, '2024-06-20 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 12:00:00');
INSERT INTO `t_job_log` VALUES (859, '2024-06-20 16:00:01', 0, '2024-06-20 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 16:00:00');
INSERT INTO `t_job_log` VALUES (860, '2024-06-20 20:00:01', 0, '2024-06-20 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-20 20:00:00');
INSERT INTO `t_job_log` VALUES (861, '2024-06-21 00:00:01', 0, '2024-06-21 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 00:00:00');
INSERT INTO `t_job_log` VALUES (862, '2024-06-21 03:08:01', 0, '2024-06-21 03:08:01', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 03:08:01');
INSERT INTO `t_job_log` VALUES (863, '2024-06-21 03:08:07', 0, '2024-06-21 03:08:07', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 03:08:06');
INSERT INTO `t_job_log` VALUES (864, '2024-06-21 03:37:06', 0, '2024-06-21 03:37:06', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 03:37:06');
INSERT INTO `t_job_log` VALUES (865, '2024-06-21 03:37:12', 0, '2024-06-21 03:37:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 03:37:11');
INSERT INTO `t_job_log` VALUES (866, '2024-06-21 04:00:01', 0, '2024-06-21 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 04:00:00');
INSERT INTO `t_job_log` VALUES (867, '2024-06-21 08:00:11', 0, '2024-06-21 08:00:11', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-21 08:00:00');
INSERT INTO `t_job_log` VALUES (870, '2024-06-21 09:20:24', 0, '2024-06-21 09:20:24', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 09:20:22');
INSERT INTO `t_job_log` VALUES (871, '2024-06-21 09:37:57', 0, '2024-06-21 09:37:57', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 09:37:57');
INSERT INTO `t_job_log` VALUES (872, '2024-06-21 09:38:05', 0, '2024-06-21 09:38:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 09:38:02');
INSERT INTO `t_job_log` VALUES (873, '2024-06-21 09:53:07', 0, '2024-06-21 09:53:07', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 09:53:07');
INSERT INTO `t_job_log` VALUES (874, '2024-06-21 09:53:13', 0, '2024-06-21 09:53:13', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 09:53:12');
INSERT INTO `t_job_log` VALUES (875, '2024-06-21 10:10:41', 0, '2024-06-21 10:10:41', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 10:10:41');
INSERT INTO `t_job_log` VALUES (876, '2024-06-21 12:00:01', 0, '2024-06-21 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 12:00:00');
INSERT INTO `t_job_log` VALUES (877, '2024-06-21 16:00:02', 0, '2024-06-21 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 16:00:00');
INSERT INTO `t_job_log` VALUES (878, '2024-06-21 16:29:20', 0, '2024-06-21 16:29:20', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 16:29:19');
INSERT INTO `t_job_log` VALUES (879, '2024-06-21 18:04:25', 0, '2024-06-21 18:04:25', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-21 18:04:25');
INSERT INTO `t_job_log` VALUES (880, '2024-06-21 20:00:01', 0, '2024-06-21 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:272本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-21 20:00:00');
INSERT INTO `t_job_log` VALUES (881, '2024-06-22 00:00:01', 0, '2024-06-22 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 00:00:00');
INSERT INTO `t_job_log` VALUES (882, '2024-06-22 04:00:01', 0, '2024-06-22 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 04:00:00');
INSERT INTO `t_job_log` VALUES (883, '2024-06-22 08:00:02', 0, '2024-06-22 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 08:00:00');
INSERT INTO `t_job_log` VALUES (884, '2024-06-22 11:02:16', 0, '2024-06-22 11:02:16', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-22 11:02:16');
INSERT INTO `t_job_log` VALUES (885, '2024-06-22 12:00:01', 0, '2024-06-22 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 12:00:00');
INSERT INTO `t_job_log` VALUES (886, '2024-06-22 13:52:27', 0, '2024-06-22 13:52:27', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-22 13:52:27');
INSERT INTO `t_job_log` VALUES (887, '2024-06-22 13:52:28', 0, '2024-06-22 13:52:28', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 13:52:27');
INSERT INTO `t_job_log` VALUES (888, '2024-06-22 14:19:59', 0, '2024-06-22 14:19:59', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-22 14:19:59');
INSERT INTO `t_job_log` VALUES (889, '2024-06-22 14:20:06', 0, '2024-06-22 14:20:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 14:20:04');
INSERT INTO `t_job_log` VALUES (890, '2024-06-22 16:00:03', 0, '2024-06-22 16:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 16:00:00');
INSERT INTO `t_job_log` VALUES (891, '2024-06-22 20:00:02', 0, '2024-06-22 20:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:373本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-22 20:00:00');
INSERT INTO `t_job_log` VALUES (892, '2024-06-23 00:00:01', 0, '2024-06-23 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 00:00:00');
INSERT INTO `t_job_log` VALUES (893, '2024-06-23 04:00:01', 0, '2024-06-23 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 04:00:00');
INSERT INTO `t_job_log` VALUES (894, '2024-06-23 07:44:43', 0, '2024-06-23 07:44:43', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-23 07:44:43');
INSERT INTO `t_job_log` VALUES (895, '2024-06-23 07:44:49', 0, '2024-06-23 07:44:49', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 07:44:48');
INSERT INTO `t_job_log` VALUES (896, '2024-06-23 08:00:02', 0, '2024-06-23 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 08:00:00');
INSERT INTO `t_job_log` VALUES (897, '2024-06-23 12:00:01', 0, '2024-06-23 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 12:00:00');
INSERT INTO `t_job_log` VALUES (898, '2024-06-23 16:00:03', 0, '2024-06-23 16:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 16:00:00');
INSERT INTO `t_job_log` VALUES (899, '2024-06-23 20:00:01', 0, '2024-06-23 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:365本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-23 20:00:00');
INSERT INTO `t_job_log` VALUES (900, '2024-06-24 00:00:01', 0, '2024-06-24 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 00:00:00');
INSERT INTO `t_job_log` VALUES (901, '2024-06-24 02:16:54', 0, '2024-06-24 02:16:54', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-24 02:16:54');
INSERT INTO `t_job_log` VALUES (902, '2024-06-24 02:17:00', 0, '2024-06-24 02:17:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 02:16:59');
INSERT INTO `t_job_log` VALUES (903, '2024-06-24 03:44:01', 0, '2024-06-24 03:44:01', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-24 03:44:01');
INSERT INTO `t_job_log` VALUES (904, '2024-06-24 04:00:01', 0, '2024-06-24 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 04:00:00');
INSERT INTO `t_job_log` VALUES (905, '2024-06-24 07:41:58', 0, '2024-06-24 07:41:58', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-24 07:41:58');
INSERT INTO `t_job_log` VALUES (906, '2024-06-24 07:42:06', 0, '2024-06-24 07:42:06', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 07:42:03');
INSERT INTO `t_job_log` VALUES (907, '2024-06-24 08:00:03', 0, '2024-06-24 08:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 08:00:00');
INSERT INTO `t_job_log` VALUES (908, '2024-06-24 12:00:01', 0, '2024-06-24 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 12:00:00');
INSERT INTO `t_job_log` VALUES (909, '2024-06-24 16:00:01', 0, '2024-06-24 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 16:00:00');
INSERT INTO `t_job_log` VALUES (910, '2024-06-24 20:00:01', 0, '2024-06-24 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:268本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-24 20:00:00');
INSERT INTO `t_job_log` VALUES (911, '2024-06-25 00:00:02', 0, '2024-06-25 00:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 00:00:00');
INSERT INTO `t_job_log` VALUES (912, '2024-06-25 04:00:01', 0, '2024-06-25 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 04:00:00');
INSERT INTO `t_job_log` VALUES (913, '2024-06-25 05:34:01', 0, '2024-06-25 05:34:01', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-25 05:34:01');
INSERT INTO `t_job_log` VALUES (914, '2024-06-25 05:34:07', 0, '2024-06-25 05:34:07', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 05:34:06');
INSERT INTO `t_job_log` VALUES (915, '2024-06-25 08:00:01', 0, '2024-06-25 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 08:00:00');
INSERT INTO `t_job_log` VALUES (916, '2024-06-25 12:00:02', 0, '2024-06-25 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 12:00:00');
INSERT INTO `t_job_log` VALUES (917, '2024-06-25 16:00:09', 0, '2024-06-25 16:00:09', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:1,未能获取itvlist.txt等文件内容。本次未写入本地文件tv.txt[内容行数1不够200或不含cctv或卫视] 本次未写入本地文件mytv.txt[内容行数1不够200或不含cctv或卫视]', NULL, 1, '2024-06-25 16:00:00');
INSERT INTO `t_job_log` VALUES (918, '2024-06-25 20:00:03', 0, '2024-06-25 20:00:03', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:417本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-25 20:00:00');
INSERT INTO `t_job_log` VALUES (919, '2024-06-26 00:00:01', 0, '2024-06-26 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 00:00:00');
INSERT INTO `t_job_log` VALUES (920, '2024-06-26 04:00:05', 0, '2024-06-26 04:00:05', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 04:00:00');
INSERT INTO `t_job_log` VALUES (921, '2024-06-26 08:00:01', 0, '2024-06-26 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 08:00:00');
INSERT INTO `t_job_log` VALUES (922, '2024-06-26 12:00:02', 0, '2024-06-26 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 12:00:00');
INSERT INTO `t_job_log` VALUES (923, '2024-06-26 16:00:01', 0, '2024-06-26 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 16:00:00');
INSERT INTO `t_job_log` VALUES (924, '2024-06-26 20:00:01', 0, '2024-06-26 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:333本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-26 20:00:00');
INSERT INTO `t_job_log` VALUES (925, '2024-06-27 00:00:01', 0, '2024-06-27 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 00:00:00');
INSERT INTO `t_job_log` VALUES (926, '2024-06-27 04:00:01', 0, '2024-06-27 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 04:00:00');
INSERT INTO `t_job_log` VALUES (927, '2024-06-27 06:14:23', 0, '2024-06-27 06:14:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-27 06:14:23');
INSERT INTO `t_job_log` VALUES (928, '2024-06-27 06:24:14', 0, '2024-06-27 06:24:14', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-27 06:24:14');
INSERT INTO `t_job_log` VALUES (929, '2024-06-27 06:24:20', 0, '2024-06-27 06:24:20', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 06:24:19');
INSERT INTO `t_job_log` VALUES (930, '2024-06-27 06:37:36', 0, '2024-06-27 06:37:36', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-27 06:37:36');
INSERT INTO `t_job_log` VALUES (931, '2024-06-27 06:37:42', 0, '2024-06-27 06:37:42', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 06:37:41');
INSERT INTO `t_job_log` VALUES (932, '2024-06-27 08:00:01', 0, '2024-06-27 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 08:00:00');
INSERT INTO `t_job_log` VALUES (933, '2024-06-27 09:50:14', 0, '2024-06-27 09:50:14', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-27 09:50:14');
INSERT INTO `t_job_log` VALUES (934, '2024-06-27 09:50:20', 0, '2024-06-27 09:50:20', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 09:50:19');
INSERT INTO `t_job_log` VALUES (935, '2024-06-27 12:00:01', 0, '2024-06-27 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 12:00:00');
INSERT INTO `t_job_log` VALUES (936, '2024-06-27 12:52:23', 0, '2024-06-27 12:52:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-27 12:52:23');
INSERT INTO `t_job_log` VALUES (937, '2024-06-27 12:52:29', 0, '2024-06-27 12:52:29', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 12:52:28');
INSERT INTO `t_job_log` VALUES (938, '2024-06-27 12:53:09', 0, '2024-06-27 12:53:09', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-27 12:53:09');
INSERT INTO `t_job_log` VALUES (939, '2024-06-27 12:53:15', 0, '2024-06-27 12:53:15', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 12:53:14');
INSERT INTO `t_job_log` VALUES (940, '2024-06-27 12:58:09', 0, '2024-06-27 12:58:09', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-27 12:58:09');
INSERT INTO `t_job_log` VALUES (941, '2024-06-27 12:58:15', 0, '2024-06-27 12:58:15', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 12:58:14');
INSERT INTO `t_job_log` VALUES (942, '2024-06-27 16:00:01', 0, '2024-06-27 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 16:00:00');
INSERT INTO `t_job_log` VALUES (943, '2024-06-27 20:00:01', 0, '2024-06-27 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:367本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-27 20:00:00');
INSERT INTO `t_job_log` VALUES (944, '2024-06-28 00:00:01', 0, '2024-06-28 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 00:00:00');
INSERT INTO `t_job_log` VALUES (945, '2024-06-28 03:59:46', 0, '2024-06-28 03:59:46', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 03:59:46');
INSERT INTO `t_job_log` VALUES (946, '2024-06-28 04:00:01', 0, '2024-06-28 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 04:00:00');
INSERT INTO `t_job_log` VALUES (947, '2024-06-28 07:24:55', 0, '2024-06-28 07:24:55', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 07:24:55');
INSERT INTO `t_job_log` VALUES (948, '2024-06-28 07:25:01', 0, '2024-06-28 07:25:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 07:25:00');
INSERT INTO `t_job_log` VALUES (949, '2024-06-28 08:00:01', 0, '2024-06-28 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 08:00:00');
INSERT INTO `t_job_log` VALUES (950, '2024-06-28 08:22:21', 0, '2024-06-28 08:22:21', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 08:22:21');
INSERT INTO `t_job_log` VALUES (951, '2024-06-28 08:22:27', 0, '2024-06-28 08:22:27', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 08:22:26');
INSERT INTO `t_job_log` VALUES (952, '2024-06-28 08:33:45', 0, '2024-06-28 08:33:45', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 08:33:45');
INSERT INTO `t_job_log` VALUES (953, '2024-06-28 08:33:56', 0, '2024-06-28 08:33:56', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 08:33:56');
INSERT INTO `t_job_log` VALUES (954, '2024-06-28 08:40:59', 0, '2024-06-28 08:40:59', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 08:40:59');
INSERT INTO `t_job_log` VALUES (955, '2024-06-28 11:25:46', 0, '2024-06-28 11:25:46', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 11:25:46');
INSERT INTO `t_job_log` VALUES (956, '2024-06-28 11:25:52', 0, '2024-06-28 11:25:52', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 11:25:51');
INSERT INTO `t_job_log` VALUES (957, '2024-06-28 12:00:01', 0, '2024-06-28 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 12:00:00');
INSERT INTO `t_job_log` VALUES (958, '2024-06-28 16:00:02', 0, '2024-06-28 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 16:00:00');
INSERT INTO `t_job_log` VALUES (959, '2024-06-28 17:28:20', 0, '2024-06-28 17:28:20', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 17:28:20');
INSERT INTO `t_job_log` VALUES (960, '2024-06-28 17:28:26', 0, '2024-06-28 17:28:26', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 17:28:25');
INSERT INTO `t_job_log` VALUES (961, '2024-06-28 17:36:32', 0, '2024-06-28 17:36:32', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-28 17:36:32');
INSERT INTO `t_job_log` VALUES (962, '2024-06-28 17:36:38', 0, '2024-06-28 17:36:38', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 17:36:37');
INSERT INTO `t_job_log` VALUES (963, '2024-06-28 20:00:01', 0, '2024-06-28 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:386本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-28 20:00:00');
INSERT INTO `t_job_log` VALUES (964, '2024-06-29 00:00:01', 0, '2024-06-29 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 00:00:00');
INSERT INTO `t_job_log` VALUES (965, '2024-06-29 04:00:01', 0, '2024-06-29 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 04:00:00');
INSERT INTO `t_job_log` VALUES (966, '2024-06-29 08:00:01', 0, '2024-06-29 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 08:00:00');
INSERT INTO `t_job_log` VALUES (967, '2024-06-29 12:00:01', 0, '2024-06-29 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 12:00:00');
INSERT INTO `t_job_log` VALUES (968, '2024-06-29 16:00:01', 0, '2024-06-29 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 16:00:00');
INSERT INTO `t_job_log` VALUES (969, '2024-06-29 18:48:11', 0, '2024-06-29 18:48:11', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-29 18:48:11');
INSERT INTO `t_job_log` VALUES (970, '2024-06-29 20:00:01', 0, '2024-06-29 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:418本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-29 20:00:00');
INSERT INTO `t_job_log` VALUES (971, '2024-06-30 00:00:01', 0, '2024-06-30 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 00:00:00');
INSERT INTO `t_job_log` VALUES (972, '2024-06-30 01:54:26', 0, '2024-06-30 01:54:26', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-30 01:54:26');
INSERT INTO `t_job_log` VALUES (973, '2024-06-30 01:54:32', 0, '2024-06-30 01:54:32', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 01:54:31');
INSERT INTO `t_job_log` VALUES (974, '2024-06-30 02:17:44', 0, '2024-06-30 02:17:44', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-30 02:17:44');
INSERT INTO `t_job_log` VALUES (975, '2024-06-30 02:17:50', 0, '2024-06-30 02:17:50', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 02:17:49');
INSERT INTO `t_job_log` VALUES (976, '2024-06-30 04:00:01', 0, '2024-06-30 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 04:00:00');
INSERT INTO `t_job_log` VALUES (977, '2024-06-30 08:00:02', 0, '2024-06-30 08:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 08:00:00');
INSERT INTO `t_job_log` VALUES (978, '2024-06-30 11:28:07', 0, '2024-06-30 11:28:07', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-06-30 11:28:07');
INSERT INTO `t_job_log` VALUES (979, '2024-06-30 11:28:13', 0, '2024-06-30 11:28:13', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 11:28:12');
INSERT INTO `t_job_log` VALUES (980, '2024-06-30 12:00:01', 0, '2024-06-30 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 12:00:00');
INSERT INTO `t_job_log` VALUES (981, '2024-06-30 16:00:01', 0, '2024-06-30 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 16:00:00');
INSERT INTO `t_job_log` VALUES (982, '2024-06-30 20:00:01', 0, '2024-06-30 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:371本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-06-30 20:00:00');
INSERT INTO `t_job_log` VALUES (983, '2024-07-01 00:00:01', 0, '2024-07-01 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 00:00:00');
INSERT INTO `t_job_log` VALUES (984, '2024-07-01 01:07:39', 0, '2024-07-01 01:07:39', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-01 01:07:39');
INSERT INTO `t_job_log` VALUES (985, '2024-07-01 01:07:45', 0, '2024-07-01 01:07:45', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 01:07:44');
INSERT INTO `t_job_log` VALUES (986, '2024-07-01 02:14:18', 0, '2024-07-01 02:14:18', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-01 02:14:18');
INSERT INTO `t_job_log` VALUES (987, '2024-07-01 02:14:24', 0, '2024-07-01 02:14:24', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 02:14:23');
INSERT INTO `t_job_log` VALUES (988, '2024-07-01 02:49:17', 0, '2024-07-01 02:49:17', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-01 02:49:17');
INSERT INTO `t_job_log` VALUES (989, '2024-07-01 03:04:23', 0, '2024-07-01 03:04:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-01 03:04:23');
INSERT INTO `t_job_log` VALUES (990, '2024-07-01 03:04:29', 0, '2024-07-01 03:04:29', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 03:04:28');
INSERT INTO `t_job_log` VALUES (991, '2024-07-01 03:18:10', 0, '2024-07-01 03:18:10', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-01 03:18:10');
INSERT INTO `t_job_log` VALUES (992, '2024-07-01 03:18:16', 0, '2024-07-01 03:18:16', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 03:18:15');
INSERT INTO `t_job_log` VALUES (993, '2024-07-01 04:00:01', 0, '2024-07-01 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 04:00:00');
INSERT INTO `t_job_log` VALUES (994, '2024-07-01 06:17:59', 0, '2024-07-01 06:17:59', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-01 06:17:59');
INSERT INTO `t_job_log` VALUES (995, '2024-07-01 06:18:07', 0, '2024-07-01 06:18:07', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 06:18:04');
INSERT INTO `t_job_log` VALUES (996, '2024-07-01 08:00:01', 0, '2024-07-01 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 08:00:00');
INSERT INTO `t_job_log` VALUES (997, '2024-07-01 08:45:49', 0, '2024-07-01 08:45:49', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-01 08:45:49');
INSERT INTO `t_job_log` VALUES (998, '2024-07-01 12:00:01', 0, '2024-07-01 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 12:00:00');
INSERT INTO `t_job_log` VALUES (999, '2024-07-01 16:00:01', 0, '2024-07-01 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 16:00:00');
INSERT INTO `t_job_log` VALUES (1000, '2024-07-01 20:00:01', 0, '2024-07-01 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:438本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-01 20:00:00');
INSERT INTO `t_job_log` VALUES (1001, '2024-07-01 23:13:23', 0, '2024-07-01 23:13:23', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-01 23:13:23');
INSERT INTO `t_job_log` VALUES (1002, '2024-07-02 00:00:01', 0, '2024-07-02 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 00:00:00');
INSERT INTO `t_job_log` VALUES (1003, '2024-07-02 03:38:03', 0, '2024-07-02 03:38:03', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-02 03:38:03');
INSERT INTO `t_job_log` VALUES (1004, '2024-07-02 03:38:09', 0, '2024-07-02 03:38:09', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 03:38:08');
INSERT INTO `t_job_log` VALUES (1005, '2024-07-02 04:00:01', 0, '2024-07-02 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 04:00:00');
INSERT INTO `t_job_log` VALUES (1006, '2024-07-02 08:00:01', 0, '2024-07-02 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 08:00:00');
INSERT INTO `t_job_log` VALUES (1007, '2024-07-02 09:16:31', 0, '2024-07-02 09:16:31', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-02 09:16:31');
INSERT INTO `t_job_log` VALUES (1008, '2024-07-02 12:00:01', 0, '2024-07-02 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 12:00:00');
INSERT INTO `t_job_log` VALUES (1009, '2024-07-02 16:00:02', 0, '2024-07-02 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 16:00:00');
INSERT INTO `t_job_log` VALUES (1010, '2024-07-02 20:00:01', 0, '2024-07-02 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:228本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-02 20:00:00');
INSERT INTO `t_job_log` VALUES (1011, '2024-07-03 00:00:01', 0, '2024-07-03 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 00:00:00');
INSERT INTO `t_job_log` VALUES (1012, '2024-07-03 03:39:54', 0, '2024-07-03 03:39:54', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-03 03:39:54');
INSERT INTO `t_job_log` VALUES (1013, '2024-07-03 03:40:00', 0, '2024-07-03 03:40:00', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 03:39:59');
INSERT INTO `t_job_log` VALUES (1014, '2024-07-03 04:00:01', 0, '2024-07-03 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 04:00:00');
INSERT INTO `t_job_log` VALUES (1015, '2024-07-03 08:00:01', 0, '2024-07-03 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 08:00:00');
INSERT INTO `t_job_log` VALUES (1016, '2024-07-03 09:40:07', 0, '2024-07-03 09:40:07', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-03 09:40:07');
INSERT INTO `t_job_log` VALUES (1017, '2024-07-03 10:04:33', 0, '2024-07-03 10:04:33', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-03 10:04:33');
INSERT INTO `t_job_log` VALUES (1018, '2024-07-03 10:04:40', 0, '2024-07-03 10:04:40', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 10:04:38');
INSERT INTO `t_job_log` VALUES (1019, '2024-07-03 12:00:02', 0, '2024-07-03 12:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 12:00:00');
INSERT INTO `t_job_log` VALUES (1020, '2024-07-03 16:00:01', 0, '2024-07-03 16:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 16:00:00');
INSERT INTO `t_job_log` VALUES (1021, '2024-07-03 20:00:01', 0, '2024-07-03 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:430本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-03 20:00:00');
INSERT INTO `t_job_log` VALUES (1022, '2024-07-04 00:00:01', 0, '2024-07-04 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 00:00:00');
INSERT INTO `t_job_log` VALUES (1023, '2024-07-04 04:00:01', 0, '2024-07-04 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 04:00:00');
INSERT INTO `t_job_log` VALUES (1024, '2024-07-04 07:36:24', 0, '2024-07-04 07:36:24', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-04 07:36:24');
INSERT INTO `t_job_log` VALUES (1025, '2024-07-04 07:36:30', 0, '2024-07-04 07:36:30', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 07:36:29');
INSERT INTO `t_job_log` VALUES (1026, '2024-07-04 08:00:01', 0, '2024-07-04 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 08:00:00');
INSERT INTO `t_job_log` VALUES (1027, '2024-07-04 08:13:05', 0, '2024-07-04 08:13:05', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-04 08:13:05');
INSERT INTO `t_job_log` VALUES (1028, '2024-07-04 08:13:12', 0, '2024-07-04 08:13:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 08:13:10');
INSERT INTO `t_job_log` VALUES (1029, '2024-07-04 12:00:01', 0, '2024-07-04 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 12:00:00');
INSERT INTO `t_job_log` VALUES (1030, '2024-07-04 16:00:02', 0, '2024-07-04 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 16:00:00');
INSERT INTO `t_job_log` VALUES (1031, '2024-07-04 20:00:01', 0, '2024-07-04 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:377本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-04 20:00:00');
INSERT INTO `t_job_log` VALUES (1032, '2024-07-05 00:00:02', 0, '2024-07-05 00:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 00:00:00');
INSERT INTO `t_job_log` VALUES (1033, '2024-07-05 03:42:28', 0, '2024-07-05 03:42:28', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-05 03:42:28');
INSERT INTO `t_job_log` VALUES (1034, '2024-07-05 03:48:55', 0, '2024-07-05 03:48:55', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-05 03:48:55');
INSERT INTO `t_job_log` VALUES (1035, '2024-07-05 03:49:01', 0, '2024-07-05 03:49:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 03:49:00');
INSERT INTO `t_job_log` VALUES (1036, '2024-07-05 04:00:01', 0, '2024-07-05 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 04:00:00');
INSERT INTO `t_job_log` VALUES (1037, '2024-07-05 08:00:01', 0, '2024-07-05 08:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 08:00:00');
INSERT INTO `t_job_log` VALUES (1038, '2024-07-05 10:04:50', 0, '2024-07-05 10:04:50', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-05 10:04:50');
INSERT INTO `t_job_log` VALUES (1039, '2024-07-05 12:00:01', 0, '2024-07-05 12:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 12:00:00');
INSERT INTO `t_job_log` VALUES (1040, '2024-07-05 13:59:56', 0, '2024-07-05 13:59:56', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-05 13:59:56');
INSERT INTO `t_job_log` VALUES (1041, '2024-07-05 14:00:02', 0, '2024-07-05 14:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 14:00:01');
INSERT INTO `t_job_log` VALUES (1042, '2024-07-05 15:16:02', 0, '2024-07-05 15:16:02', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-05 15:16:02');
INSERT INTO `t_job_log` VALUES (1043, '2024-07-05 15:16:08', 0, '2024-07-05 15:16:08', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 15:16:07');
INSERT INTO `t_job_log` VALUES (1044, '2024-07-05 15:23:10', 0, '2024-07-05 15:23:10', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-05 15:23:10');
INSERT INTO `t_job_log` VALUES (1045, '2024-07-05 15:23:16', 0, '2024-07-05 15:23:16', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 15:23:15');
INSERT INTO `t_job_log` VALUES (1046, '2024-07-05 16:00:02', 0, '2024-07-05 16:00:02', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 16:00:00');
INSERT INTO `t_job_log` VALUES (1047, '2024-07-05 20:00:01', 0, '2024-07-05 20:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:455本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 20:00:00');
INSERT INTO `t_job_log` VALUES (1048, '2024-07-05 22:54:14', 0, '2024-07-05 22:54:14', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-05 22:54:14');
INSERT INTO `t_job_log` VALUES (1049, '2024-07-05 22:54:20', 0, '2024-07-05 22:54:20', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:454本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-05 22:54:19');
INSERT INTO `t_job_log` VALUES (1050, '2024-07-06 00:00:01', 0, '2024-07-06 00:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:454本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-06 00:00:00');
INSERT INTO `t_job_log` VALUES (1051, '2024-07-06 00:15:08', 0, '2024-07-06 00:15:08', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-06 00:15:08');
INSERT INTO `t_job_log` VALUES (1052, '2024-07-06 00:15:14', 0, '2024-07-06 00:15:14', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:454本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-06 00:15:13');
INSERT INTO `t_job_log` VALUES (1053, '2024-07-06 04:00:01', 0, '2024-07-06 04:00:01', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:454本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-06 04:00:00');
INSERT INTO `t_job_log` VALUES (1054, '2024-07-06 07:52:11', 0, '2024-07-06 07:52:11', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-06 07:52:11');
INSERT INTO `t_job_log` VALUES (1055, '2024-07-11 04:24:44', 0, '2024-07-11 04:24:44', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-11 04:24:44');
INSERT INTO `t_job_log` VALUES (1056, '2024-07-13 13:28:48', 0, '2024-07-13 13:28:48', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-13 13:28:48');
INSERT INTO `t_job_log` VALUES (1057, '2024-07-13 13:28:51', 0, '2024-07-13 13:28:51', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:472本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-13 13:28:48');
INSERT INTO `t_job_log` VALUES (1058, '2024-07-13 13:30:38', 0, '2024-07-13 13:30:38', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-13 13:30:38');
INSERT INTO `t_job_log` VALUES (1059, '2024-07-17 12:33:19', 0, '2024-07-17 12:33:19', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-17 12:33:19');
INSERT INTO `t_job_log` VALUES (1060, '2024-07-17 12:59:26', 0, '2024-07-17 12:59:26', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-17 12:59:26');
INSERT INTO `t_job_log` VALUES (1061, '2024-07-18 02:44:45', 0, '2024-07-18 02:44:45', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-18 02:44:45');
INSERT INTO `t_job_log` VALUES (1062, '2024-07-21 04:09:28', 0, '2024-07-21 04:09:28', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-21 04:09:28');
INSERT INTO `t_job_log` VALUES (1063, '2024-07-21 07:50:10', 0, '2024-07-21 07:50:10', 0, 0, NULL, 'active_sniffer_after_run', NULL, NULL, NULL, NULL, '----------------task_id:active_sniffer_after_run,args:(),kwargs:{}----------------\"嗅探器激活成功,当前使用的嗅探器为:http://hipy.nokia.press:5708\"', NULL, 1, '2024-07-21 07:50:10');
INSERT INTO `t_job_log` VALUES (1064, '2024-07-21 07:50:12', 0, '2024-07-21 07:50:12', 0, 0, 'tv_spider', 'tv源爬虫', 'setInterval', 'tasks.tv_spider.main', '[]', '{}', '爬取直播文件行数:471本次成功写入本地文件tv.txt 本次成功写入本地文件mytv.txt', NULL, 1, '2024-07-21 07:50:10');

-- ----------------------------
-- Table structure for t_login_infor
-- ----------------------------
DROP TABLE IF EXISTS `t_login_infor`;
CREATE TABLE `t_login_infor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `user_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名称',
  `ipaddr` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录地址',
  `login_location` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录地点',
  `browser` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `os` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作系统',
  `status` int(11) NULL DEFAULT 0 COMMENT '登录状态',
  `msg` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作信息',
  `login_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '登录日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_login_infor_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_login_infor
-- ----------------------------
INSERT INTO `t_login_infor` VALUES (1, '2024-07-17 12:40:11', 0, '2024-07-17 12:40:11', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-17 12:40:11');
INSERT INTO `t_login_infor` VALUES (2, '2024-07-21 06:28:29', 0, '2024-07-21 06:28:29', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 06:28:29');
INSERT INTO `t_login_infor` VALUES (3, '2024-07-21 07:04:08', 0, '2024-07-21 07:04:08', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:04:08');
INSERT INTO `t_login_infor` VALUES (4, '2024-07-21 07:07:52', 0, '2024-07-21 07:07:52', 0, 0, 'hjdhnx', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:07:52');
INSERT INTO `t_login_infor` VALUES (5, '2024-07-21 07:14:19', 0, '2024-07-21 07:14:19', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:14:19');
INSERT INTO `t_login_infor` VALUES (6, '2024-07-21 07:14:34', 0, '2024-07-21 07:14:34', 0, 0, 'hjdhnx', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:14:34');
INSERT INTO `t_login_infor` VALUES (7, '2024-07-21 07:30:42', 0, '2024-07-21 07:30:42', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:30:42');
INSERT INTO `t_login_infor` VALUES (8, '2024-07-21 07:32:46', 0, '2024-07-21 07:32:46', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:32:46');
INSERT INTO `t_login_infor` VALUES (9, '2024-07-21 07:33:46', 0, '2024-07-21 07:33:46', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:33:46');
INSERT INTO `t_login_infor` VALUES (10, '2024-07-21 07:36:04', 0, '2024-07-21 07:36:04', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:36:04');
INSERT INTO `t_login_infor` VALUES (11, '2024-07-21 07:36:54', 0, '2024-07-21 07:36:54', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:36:54');
INSERT INTO `t_login_infor` VALUES (12, '2024-07-21 07:43:00', 0, '2024-07-21 07:43:00', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:43:00');
INSERT INTO `t_login_infor` VALUES (13, '2024-07-21 07:43:41', 0, '2024-07-21 07:43:41', 0, 0, 'admin', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:43:41');
INSERT INTO `t_login_infor` VALUES (14, '2024-07-21 07:43:58', 0, '2024-07-21 07:43:58', 0, 0, 'hjdhnx', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:43:58');
INSERT INTO `t_login_infor` VALUES (15, '2024-07-21 07:45:11', 0, '2024-07-21 07:45:11', 0, 0, 'opt', '127.0.0.1', NULL, 'Chrome 126.0.0', 'Windows 10', 0, '登录成功', '2024-07-21 07:45:11');

-- ----------------------------
-- Table structure for t_menus
-- ----------------------------
DROP TABLE IF EXISTS `t_menus`;
CREATE TABLE `t_menus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由',
  `component` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '组件',
  `is_frame` tinyint(1) NULL DEFAULT 0 COMMENT '是否外链',
  `hidden` tinyint(1) NULL DEFAULT 0 COMMENT '是否隐藏',
  `status` int(11) NULL DEFAULT 0 COMMENT '菜单状态',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示排序',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '唯一标识用于页面缓存，否则keep-alive会出问题',
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标题',
  `icon` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '图标',
  `no_cache` tinyint(1) NULL DEFAULT 0 COMMENT '是否缓存',
  `parent_id` int(11) NULL DEFAULT 0 COMMENT '上级菜单',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_menus_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 46 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_menus
-- ----------------------------
INSERT INTO `t_menus` VALUES (1, '2022-07-14 03:56:19', 0, '2022-07-19 15:40:51', 0, 0, 'role', '/permission/role/index', 0, 0, 0, 3, 'PermissionRole', '角色管理', 'peoples', 1, 7);
INSERT INTO `t_menus` VALUES (2, '2022-07-14 03:56:19', 0, '2022-07-20 10:25:17', 0, 0, '/system', '', 0, 0, 0, 2, '', '系统管理', 'system', 0, 0);
INSERT INTO `t_menus` VALUES (3, '2022-07-14 03:56:19', 0, '2022-07-19 16:03:40', 0, 0, 'menu', '/permission/menu/index', 0, 0, 0, 2, 'PermissionMenu', '菜单管理', 'tree-table', 0, 7);
INSERT INTO `t_menus` VALUES (4, '2022-07-14 03:56:19', 0, '2022-07-14 03:56:19', 0, 0, 'dict', '/system/dict/index', 0, 0, 0, 4, 'SystemDictType', '字典管理', 'dict', 0, 2);
INSERT INTO `t_menus` VALUES (5, '2022-07-14 03:56:19', 0, '2022-07-14 03:56:19', 0, 0, 'parameter', '/system/parameter/index', 0, 0, 0, 3, 'SystemParameter', '参数管理', 'tree', 0, 2);
INSERT INTO `t_menus` VALUES (6, '2022-07-14 03:56:19', 0, '2022-07-19 16:03:33', 0, 0, 'user', '/permission/user/index', 0, 0, 0, 1, 'PermissionUser', '用户管理', 'user', 0, 7);
INSERT INTO `t_menus` VALUES (7, '2022-07-14 03:56:19', 0, '2022-07-20 10:25:24', 0, 0, '/permission', '', 0, 0, 0, 1, '', '权限管理', 'monitor', 0, 0);
INSERT INTO `t_menus` VALUES (8, '2022-07-14 03:56:19', 0, '2022-07-14 03:56:19', 0, 0, 'dict/detail/:id(\\d+)', '/system/dict/detail/index', 0, 1, 0, 1, 'SystemDictDetail', '字典参数', 'dashboard', 0, 2);
INSERT INTO `t_menus` VALUES (9, '2022-10-29 23:57:16', 0, '2022-10-29 23:57:16', 0, 0, 'label', '/permission/label/index', 0, 0, 0, 4, 'PermissionLabel', '权限标签', 'icon', 1, 7);
INSERT INTO `t_menus` VALUES (11, '2023-12-02 18:06:51', 0, '2023-12-07 22:10:46', 1, 0, 'developer', '/hiker/developer/index', 0, 0, 0, 1, 'HikerDeveloper', '开发者', 'peoples', 1, 10);
INSERT INTO `t_menus` VALUES (10, '2023-12-02 18:05:43', 0, '2023-12-02 18:05:43', 0, 0, '/hiker', '', 0, 0, 0, 3, '', '海阔视界', 'international', 1, 0);
INSERT INTO `t_menus` VALUES (12, '2023-12-02 23:23:55', 1, '2023-12-07 22:10:55', 1, 0, 'rule_type', '/hiker/rule_type/index', 0, 0, 0, 2, 'HikerRuleType', '规则类型', 'component', 1, 10);
INSERT INTO `t_menus` VALUES (13, '2023-12-03 19:03:50', 1, '2023-12-07 22:11:07', 1, 0, 'rule', '/hiker/rule/index', 0, 0, 0, 3, 'HikerRule', '规则', 'list', 1, 10);
INSERT INTO `t_menus` VALUES (14, '2023-12-04 21:49:25', 1, '2023-12-04 21:49:25', 0, 0, 'control_panel', '/control_panel/index', 0, 0, 0, 4, 'ControlPanel', '控制面板', 'swagger', 1, 2);
INSERT INTO `t_menus` VALUES (15, '2023-12-05 08:49:37', 1, '2023-12-05 08:50:03', 1, 0, '/tool', '', 0, 0, 0, 4, '', '工具', 'bug', 1, 0);
INSERT INTO `t_menus` VALUES (16, '2023-12-05 08:51:06', 1, '2023-12-05 08:52:00', 1, 0, 'swagger', '/tool/swagger/index', 0, 0, 0, 1, 'Swagger', 'swagger', 'swagger', 1, 15);
INSERT INTO `t_menus` VALUES (17, '2023-12-05 09:08:13', 1, '2023-12-06 22:50:59', 1, 0, '/monitor', '', 0, 0, 0, 4, '', '系统监控', 'monitor', 1, 0);
INSERT INTO `t_menus` VALUES (18, '2023-12-05 09:09:57', 1, '2023-12-07 00:03:28', 1, 0, 'job', '/monitor/job/index', 0, 0, 0, 2, 'Job', '定时任务', 'time-range', 1, 17);
INSERT INTO `t_menus` VALUES (19, '2023-12-05 09:11:12', 1, '2023-12-07 00:03:23', 1, 0, 'server', '/monitor/server/index', 0, 0, 0, 1, 'Server', '服务监控', 'server', 1, 17);
INSERT INTO `t_menus` VALUES (20, '2023-12-06 22:49:09', 1, '2023-12-06 22:49:09', 0, 0, 'blog', '/tool/blog/index', 0, 0, 0, 2, 'Blog', '博客', 'log', 1, 15);
INSERT INTO `t_menus` VALUES (21, '2023-12-06 22:53:25', 1, '2023-12-15 00:17:28', 1, 0, 'online', '/monitor/online/index', 0, 1, 0, 6, 'Online', '在线用户', 'online', 1, 17);
INSERT INTO `t_menus` VALUES (22, '2023-12-06 22:55:02', 1, '2023-12-15 00:17:17', 1, 0, 'cache', ' /monitor/cache/index', 0, 1, 0, 5, '', '缓存监控', 'redis', 1, 17);
INSERT INTO `t_menus` VALUES (23, '2023-12-06 22:56:00', 1, '2023-12-15 00:17:23', 1, 0, 'cacheList', '/monitor/cache/list', 0, 0, 0, 5, 'cacheList', '缓存列表', 'redis-list', 1, 17);
INSERT INTO `t_menus` VALUES (24, '2023-12-06 23:22:16', 1, '2023-12-06 23:22:16', 0, 0, 'icons', '/components/icons/index', 0, 0, 0, 3, 'Icons', '图标组件', 'icon', 1, 15);
INSERT INTO `t_menus` VALUES (25, '2023-12-06 23:33:18', 1, '2023-12-06 23:37:20', 1, 0, 'build', '/tool/build/index', 0, 0, 0, 1, 'Build', '表单构建', 'build', 1, 15);
INSERT INTO `t_menus` VALUES (26, '2023-12-07 22:06:50', 1, '2023-12-07 22:16:07', 1, 0, 'developer/:id(\\d+)', '/hiker/developer/index', 0, 1, 0, 1, 'DeveloperDetail', '开发者详情', 'peoples', 1, 10);
INSERT INTO `t_menus` VALUES (27, '2023-12-07 22:09:16', 1, '2023-12-07 22:16:02', 1, 0, 'rule_type/:id(\\d+)', '/hiker/rule_type/index', 0, 1, 0, 2, 'RuleTypeDetail', '规则类型详情', 'component', 1, 10);
INSERT INTO `t_menus` VALUES (28, '2023-12-07 22:56:42', 1, '2023-12-15 00:16:45', 1, 0, 'logininfor', '/monitor/logininfor/index', 0, 0, 0, 3, 'LoginInfor', '登录日志', 'people', 1, 17);
INSERT INTO `t_menus` VALUES (29, '2023-12-11 20:39:10', 1, '2023-12-11 20:42:25', 1, 1, 'control_panel1', '/hello', 0, 0, 0, 1, '', 'hello world', 'clipboard', 1, 7);
INSERT INTO `t_menus` VALUES (30, '2023-12-13 22:44:56', 1, '2023-12-15 00:16:50', 1, 0, 'pip', '/monitor/pip/index', 0, 0, 0, 4, 'Pip', '依赖管理', 'list', 1, 17);
INSERT INTO `t_menus` VALUES (31, '2023-12-15 00:11:11', 1, '2023-12-15 00:17:03', 1, 0, 'job-log/:id(\\d+)', '/monitor/job/log', 0, 1, 0, 2, 'JobLog', '定时任务执行日志', 'log', 1, 17);
INSERT INTO `t_menus` VALUES (32, '2023-12-15 00:36:18', 1, '2023-12-15 00:36:18', 0, 0, 'xfgpt', '/tool/xfgpt/index', 0, 0, 0, 4, 'XfGpt', '讯飞GPT', 'example', 1, 15);
INSERT INTO `t_menus` VALUES (34, '2024-01-14 16:22:36', 1, '2024-01-14 16:22:53', 1, 0, '/vod', '', 0, 0, 0, 3, '', 'hipy源', 'education', 1, 0);
INSERT INTO `t_menus` VALUES (35, '2024-01-14 16:23:36', 1, '2024-01-14 16:24:07', 1, 0, 'rules', '/vod/rules/index', 0, 0, 0, 1, 'VodRules', '源管理', 'list', 1, 34);
INSERT INTO `t_menus` VALUES (41, '2024-02-27 16:24:14', 1, '2024-02-27 16:24:14', 0, 0, 'index', '/vod/web/home/category', 0, 1, 0, 1, 'VodWebIndex', 'CMS首页', 'international', 1, 39);
INSERT INTO `t_menus` VALUES (42, '2024-02-27 16:24:59', 1, '2024-02-27 16:24:59', 0, 0, 'category', '/vod/web/home/category', 0, 1, 0, 2, 'VodWebCategory', 'CMS分类页', 'nested', 1, 39);
INSERT INTO `t_menus` VALUES (43, '2024-02-27 16:25:29', 1, '2024-02-27 16:25:29', 0, 0, 'detail', '/vod/web/home/detail', 0, 1, 0, 3, 'VodWebDetail', 'CMS详情页', 'form', 1, 39);
INSERT INTO `t_menus` VALUES (40, '2024-02-21 17:46:55', 1, '2024-02-27 16:25:55', 1, 0, 'search', '/vod/web/home/search', 0, 1, 0, 4, 'VodWebSearch', 'CMS搜索页', 'search', 1, 39);
INSERT INTO `t_menus` VALUES (44, '2024-06-19 09:52:46', 1, '2024-06-19 09:52:46', 0, 0, 'subs', '/vod/subs/index', 0, 0, 0, 2, 'VodSubs', '订阅管理', 'chart', 1, 34);
INSERT INTO `t_menus` VALUES (36, '2024-01-14 16:44:59', 1, '2024-06-19 09:52:55', 1, 0, 'configs', '/vod/configs/index', 0, 0, 0, 3, 'VodConfigs', '配置中心', 'table', 1, 34);
INSERT INTO `t_menus` VALUES (37, '2024-01-21 08:39:35', 1, '2024-06-19 09:52:59', 1, 0, 'rules_edit/:id(\\d+)', '/vod/rules/edit', 0, 1, 0, 4, 'VodRulesEdit', '在线编辑源', 'code', 1, 34);
INSERT INTO `t_menus` VALUES (38, '2024-02-19 13:58:41', 1, '2024-06-19 09:53:08', 1, 0, 'houses', '/vod/houses/index', 0, 0, 0, 5, 'VodHouses', '源仓库', 'shopping', 1, 34);
INSERT INTO `t_menus` VALUES (39, '2024-02-21 17:21:06', 1, '2024-06-19 09:53:12', 1, 0, 'web', '/vod/web/index', 0, 0, 0, 6, 'VodWeb', '在线预览', 'international', 1, 34);
INSERT INTO `t_menus` VALUES (45, '2024-07-06 00:16:58', 1, '2024-07-06 00:16:58', 0, 0, 'liveTool', '/tool/liveTool/index', 0, 0, 0, 10, 'liveTool', '直播工具', 'form', 1, 34);

-- ----------------------------
-- Table structure for t_perm_label
-- ----------------------------
DROP TABLE IF EXISTS `t_perm_label`;
CREATE TABLE `t_perm_label`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `label` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '标签',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_perm_label_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_perm_label
-- ----------------------------
INSERT INTO `t_perm_label` VALUES (4, '2023-12-02 15:33:26', 0, '2023-12-02 15:33:26', 0, 0, 'perm:user:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (5, '2023-12-02 15:36:42', 0, '2023-12-02 15:36:42', 0, 0, 'perm:user:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (11, '2023-12-02 18:00:37', 0, '2023-12-02 18:00:37', 0, 0, 'hiker:developer:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (12, '2023-12-02 18:05:43', 0, '2023-12-02 18:05:43', 0, 0, 'perm:menu:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (13, '2023-12-02 18:08:24', 0, '2023-12-02 18:08:24', 0, 0, 'perm:menu:gut', NULL, 0);
INSERT INTO `t_perm_label` VALUES (14, '2023-12-02 18:09:28', 0, '2023-12-02 18:09:28', 0, 0, 'perm:menu:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (15, '2023-12-02 19:15:42', 0, '2023-12-02 19:15:42', 0, 0, 'hiker:developer:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (21, '2023-12-04 19:55:50', 0, '2023-12-04 19:55:50', 0, 0, 'hiker:rule_type:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (22, '2023-12-04 20:00:34', 0, '2023-12-04 20:00:34', 0, 0, 'hiker:rule:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (23, '2023-12-04 20:00:59', 0, '2023-12-04 20:00:59', 0, 0, 'hiker:rule:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (25, '2023-12-05 19:44:23', 0, '2023-12-05 19:44:23', 0, 0, 'monitor:server:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (27, '2023-12-05 22:52:40', 0, '2023-12-05 22:52:40', 0, 0, 'hiker:rule_type:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (28, '2023-12-05 22:52:46', 0, '2023-12-05 22:52:46', 0, 0, 'hiker:rule_type:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (29, '2023-12-07 00:00:33', 0, '2023-12-07 00:00:33', 0, 0, 'perm:user:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (31, '2023-12-07 21:39:27', 0, '2023-12-07 21:39:27', 0, 0, 'report:excel_generate:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (32, '2023-12-09 02:27:25', 0, '2023-12-09 02:27:25', 0, 0, 'system:config_setting:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (33, '2023-12-09 16:20:03', 0, '2023-12-09 16:20:03', 0, 0, 'monitor:logininfor:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (34, '2023-12-09 16:50:10', 0, '2023-12-09 16:50:10', 0, 0, 'hiker:developer:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (35, '2023-12-09 16:54:11', 0, '2023-12-09 16:54:11', 0, 0, 'hiker:rule:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (36, '2023-12-10 17:41:10', 0, '2023-12-10 17:41:10', 0, 0, 'monitor:job:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (37, '2023-12-10 18:16:32', 0, '2023-12-10 18:16:32', 0, 0, 'monitor:job:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (38, '2023-12-10 18:25:10', 0, '2023-12-10 18:25:10', 0, 0, 'monitor:job:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (39, '2023-12-11 20:42:25', 0, '2023-12-11 20:42:25', 0, 0, 'perm:menu:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (41, '2023-12-13 23:12:13', 0, '2023-12-13 23:12:13', 0, 0, 'monitor:pip:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (42, '2023-12-13 23:21:20', 0, '2023-12-13 23:21:20', 0, 0, 'monitor:pip:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (43, '2023-12-13 23:28:11', 0, '2023-12-13 23:28:11', 0, 0, 'monitor:pip:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (44, '2023-12-16 11:36:07', 0, '2023-12-16 11:36:07', 0, 0, 'perm:role:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (45, '2023-12-16 11:38:40', 0, '2023-12-16 11:38:40', 0, 0, 'perm:label:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (46, '2023-12-16 12:28:44', 0, '2023-12-16 12:28:44', 0, 0, 'report:excel_generate:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (47, '2023-12-17 14:13:25', 0, '2023-12-17 14:45:14', 1, 1, 'report:excel_generate:exports', NULL, 0);
INSERT INTO `t_perm_label` VALUES (48, '2023-12-17 14:38:50', 0, '2023-12-17 14:44:57', 1, 1, 'system_user:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (49, '2023-12-17 14:44:45', 0, '2023-12-17 14:44:45', 0, 0, 'perm:user:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (50, '2023-12-17 14:44:57', 0, '2023-12-17 14:44:57', 0, 0, 'perm:label:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (54, '2023-12-17 16:47:58', 0, '2023-12-17 16:47:58', 0, 0, 'monitor:cache:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (55, '2024-01-02 20:24:36', 0, '2024-01-02 20:24:36', 0, 0, 'system:user:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (56, '2024-01-06 12:37:09', 0, '2024-01-06 12:37:09', 0, 0, 'monitor:job-log:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (57, '2024-01-06 13:24:14', 0, '2024-01-06 13:24:14', 0, 0, '/monitor/jobLog/export:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (58, '2024-01-06 13:36:05', 0, '2024-01-06 13:36:05', 0, 0, 'monitor:job:log:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (72, '2024-06-19 09:53:59', 0, '2024-06-19 09:53:59', 0, 0, 'vod:subs:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (73, '2024-06-19 10:06:39', 0, '2024-06-19 10:06:39', 0, 0, 'vod:subs:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (74, '2024-06-25 15:13:01', 0, '2024-06-25 15:13:01', 0, 0, 'vod:subs:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (30, '2023-12-07 19:50:07', 0, '2024-07-21 07:42:32', 1, 0, 'report:excel_generate:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (71, '2024-02-19 16:30:39', 0, '2024-07-21 07:16:19', 1, 0, 'vod:houses:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (70, '2024-02-19 15:22:23', 0, '2024-07-21 07:16:16', 1, 0, 'vod:houses:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (60, '2024-01-14 16:38:44', 0, '2024-07-21 07:17:29', 1, 0, 'vod:rules:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (61, '2024-01-14 17:26:01', 0, '2024-07-21 07:17:34', 1, 0, 'vod:rules:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (63, '2024-01-15 17:03:56', 0, '2024-07-21 07:17:38', 1, 0, 'vod:rules:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (62, '2024-01-14 17:48:29', 0, '2024-07-21 07:17:57', 1, 0, 'vod:rules:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (51, '2023-12-17 14:47:51', 0, '2024-07-21 07:21:46', 1, 0, 'monitor:logininfor:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (52, '2023-12-17 14:47:58', 0, '2024-07-21 07:21:58', 1, 0, 'monitor:job:export', NULL, 0);
INSERT INTO `t_perm_label` VALUES (53, '2023-12-17 16:00:22', 0, '2024-07-21 07:23:01', 1, 0, 'monitor:cache:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (67, '2024-01-25 13:54:21', 0, '2024-07-21 07:24:29', 1, 0, 'vod:configs:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (65, '2024-01-25 13:22:05', 0, '2024-07-21 07:25:21', 1, 0, 'vod:configs:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (66, '2024-01-25 13:42:15', 0, '2024-07-21 07:26:18', 1, 0, 'vod:configs:delete', NULL, 0);
INSERT INTO `t_perm_label` VALUES (2, '2023-12-02 15:30:57', 0, '2024-07-21 07:31:34', 1, 0, 'system:dict:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (17, '2023-12-04 19:53:00', 0, '2024-07-21 07:38:34', 1, 0, 'system:dict:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (19, '2023-12-04 19:53:35', 0, '2024-07-21 07:38:43', 1, 0, 'system:dict:detail:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (18, '2023-12-04 19:53:04', 0, '2024-07-21 07:31:48', 1, 0, 'system:dict:detail:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (20, '2023-12-04 19:54:59', 0, '2024-07-21 07:38:49', 1, 0, 'system:dict:detail:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (64, '2024-01-25 13:06:52', 0, '2024-07-21 07:40:12', 1, 0, 'vod:configs:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (3, '2023-12-02 15:31:25', 0, '2024-07-21 07:35:22', 1, 0, 'system:config-setting:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (10, '2023-12-02 15:39:26', 0, '2024-07-21 07:38:30', 1, 0, 'system:dict:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (24, '2023-12-04 22:13:09', 0, '2024-07-21 07:37:28', 1, 0, 'system:config-setting:post', NULL, 0);
INSERT INTO `t_perm_label` VALUES (9, '2023-12-02 15:39:04', 0, '2024-07-21 07:37:15', 1, 0, 'system:config-setting:put', NULL, 0);
INSERT INTO `t_perm_label` VALUES (1, '2023-12-02 15:30:37', 0, '2024-07-21 07:41:59', 1, 0, 'perm:user:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (6, '2023-12-02 15:37:45', 0, '2024-07-21 07:42:04', 1, 0, 'perm:menu:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (7, '2023-12-02 15:38:12', 0, '2024-07-21 07:42:07', 1, 0, 'perm:role:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (8, '2023-12-02 15:38:46', 0, '2024-07-21 07:42:11', 1, 0, 'perm:label:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (16, '2023-12-02 19:19:35', 0, '2024-07-21 07:42:15', 1, 0, 'hiker:developer:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (26, '2023-12-05 20:08:50', 0, '2024-07-21 07:42:18', 1, 0, 'monitor:server:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (40, '2023-12-13 22:29:05', 0, '2024-07-21 07:42:21', 1, 0, 'monitor:pip:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (68, '2024-01-25 14:11:49', 0, '2024-07-21 07:42:25', 1, 0, 'vod:rules:get', NULL, 0);
INSERT INTO `t_perm_label` VALUES (69, '2024-02-19 14:30:49', 0, '2024-07-21 07:42:28', 1, 0, 'vod:houses:get', NULL, 0);

-- ----------------------------
-- Table structure for t_perm_label_role
-- ----------------------------
DROP TABLE IF EXISTS `t_perm_label_role`;
CREATE TABLE `t_perm_label_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `label_id` int(11) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `label_id`(`label_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `ix_t_perm_label_role_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of t_perm_label_role
-- ----------------------------
INSERT INTO `t_perm_label_role` VALUES (1, '2023-12-06 22:37:39', 0, '2023-12-06 22:37:39', 0, 0, NULL, NULL);
INSERT INTO `t_perm_label_role` VALUES (33, '2024-07-21 07:23:01', 1, '2024-07-21 07:23:01', 0, 0, 53, 2);
INSERT INTO `t_perm_label_role` VALUES (34, '2024-07-21 07:31:34', 1, '2024-07-21 07:31:34', 0, 0, 2, 2);
INSERT INTO `t_perm_label_role` VALUES (35, '2024-07-21 07:31:34', 1, '2024-07-21 07:31:34', 0, 0, 2, 3);
INSERT INTO `t_perm_label_role` VALUES (38, '2024-07-21 07:31:48', 1, '2024-07-21 07:31:48', 0, 0, 18, 2);
INSERT INTO `t_perm_label_role` VALUES (39, '2024-07-21 07:31:48', 1, '2024-07-21 07:31:48', 0, 0, 18, 3);
INSERT INTO `t_perm_label_role` VALUES (42, '2024-07-21 07:35:22', 1, '2024-07-21 07:35:22', 0, 0, 3, 2);
INSERT INTO `t_perm_label_role` VALUES (43, '2024-07-21 07:35:22', 1, '2024-07-21 07:35:22', 0, 0, 3, 3);
INSERT INTO `t_perm_label_role` VALUES (47, '2024-07-21 07:40:12', 1, '2024-07-21 07:40:12', 0, 0, 64, 2);
INSERT INTO `t_perm_label_role` VALUES (48, '2024-07-21 07:40:12', 1, '2024-07-21 07:40:12', 0, 0, 64, 3);
INSERT INTO `t_perm_label_role` VALUES (49, '2024-07-21 07:41:59', 1, '2024-07-21 07:41:59', 0, 0, 1, 2);
INSERT INTO `t_perm_label_role` VALUES (50, '2024-07-21 07:41:59', 1, '2024-07-21 07:41:59', 0, 0, 1, 3);
INSERT INTO `t_perm_label_role` VALUES (51, '2024-07-21 07:42:04', 1, '2024-07-21 07:42:04', 0, 0, 6, 2);
INSERT INTO `t_perm_label_role` VALUES (52, '2024-07-21 07:42:04', 1, '2024-07-21 07:42:04', 0, 0, 6, 3);
INSERT INTO `t_perm_label_role` VALUES (53, '2024-07-21 07:42:07', 1, '2024-07-21 07:42:07', 0, 0, 7, 2);
INSERT INTO `t_perm_label_role` VALUES (54, '2024-07-21 07:42:07', 1, '2024-07-21 07:42:07', 0, 0, 7, 3);
INSERT INTO `t_perm_label_role` VALUES (55, '2024-07-21 07:42:11', 1, '2024-07-21 07:42:11', 0, 0, 8, 2);
INSERT INTO `t_perm_label_role` VALUES (56, '2024-07-21 07:42:11', 1, '2024-07-21 07:42:11', 0, 0, 8, 3);
INSERT INTO `t_perm_label_role` VALUES (57, '2024-07-21 07:42:15', 1, '2024-07-21 07:42:15', 0, 0, 16, 2);
INSERT INTO `t_perm_label_role` VALUES (58, '2024-07-21 07:42:15', 1, '2024-07-21 07:42:15', 0, 0, 16, 3);
INSERT INTO `t_perm_label_role` VALUES (59, '2024-07-21 07:42:18', 1, '2024-07-21 07:42:18', 0, 0, 26, 2);
INSERT INTO `t_perm_label_role` VALUES (60, '2024-07-21 07:42:18', 1, '2024-07-21 07:42:18', 0, 0, 26, 3);
INSERT INTO `t_perm_label_role` VALUES (61, '2024-07-21 07:42:21', 1, '2024-07-21 07:42:21', 0, 0, 40, 2);
INSERT INTO `t_perm_label_role` VALUES (62, '2024-07-21 07:42:21', 1, '2024-07-21 07:42:21', 0, 0, 40, 3);
INSERT INTO `t_perm_label_role` VALUES (63, '2024-07-21 07:42:25', 1, '2024-07-21 07:42:25', 0, 0, 68, 2);
INSERT INTO `t_perm_label_role` VALUES (64, '2024-07-21 07:42:25', 1, '2024-07-21 07:42:25', 0, 0, 68, 3);
INSERT INTO `t_perm_label_role` VALUES (65, '2024-07-21 07:42:28', 1, '2024-07-21 07:42:28', 0, 0, 69, 2);
INSERT INTO `t_perm_label_role` VALUES (66, '2024-07-21 07:42:28', 1, '2024-07-21 07:42:28', 0, 0, 69, 3);
INSERT INTO `t_perm_label_role` VALUES (67, '2024-07-21 07:42:32', 1, '2024-07-21 07:42:32', 0, 0, 30, 2);
INSERT INTO `t_perm_label_role` VALUES (68, '2024-07-21 07:42:32', 1, '2024-07-21 07:42:32', 0, 0, 30, 3);

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `role_id` int(11) NULL DEFAULT NULL,
  `menu_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `menu_id`(`menu_id`) USING BTREE,
  INDEX `ix_t_role_menu_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 286 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES (217, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 2);
INSERT INTO `t_role_menu` VALUES (218, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 8);
INSERT INTO `t_role_menu` VALUES (219, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 5);
INSERT INTO `t_role_menu` VALUES (220, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 14);
INSERT INTO `t_role_menu` VALUES (221, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 4);
INSERT INTO `t_role_menu` VALUES (222, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 10);
INSERT INTO `t_role_menu` VALUES (223, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 26);
INSERT INTO `t_role_menu` VALUES (224, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 11);
INSERT INTO `t_role_menu` VALUES (225, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 27);
INSERT INTO `t_role_menu` VALUES (226, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 12);
INSERT INTO `t_role_menu` VALUES (227, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 13);
INSERT INTO `t_role_menu` VALUES (228, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 34);
INSERT INTO `t_role_menu` VALUES (229, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 35);
INSERT INTO `t_role_menu` VALUES (230, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 38);
INSERT INTO `t_role_menu` VALUES (231, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 45);
INSERT INTO `t_role_menu` VALUES (232, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 17);
INSERT INTO `t_role_menu` VALUES (233, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 19);
INSERT INTO `t_role_menu` VALUES (234, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 31);
INSERT INTO `t_role_menu` VALUES (235, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 18);
INSERT INTO `t_role_menu` VALUES (236, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 30);
INSERT INTO `t_role_menu` VALUES (237, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 15);
INSERT INTO `t_role_menu` VALUES (238, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 25);
INSERT INTO `t_role_menu` VALUES (239, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 16);
INSERT INTO `t_role_menu` VALUES (240, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 20);
INSERT INTO `t_role_menu` VALUES (241, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 24);
INSERT INTO `t_role_menu` VALUES (242, '2024-07-21 07:28:38', 1, '2024-07-21 07:28:38', 0, 0, 2, 32);
INSERT INTO `t_role_menu` VALUES (264, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 2);
INSERT INTO `t_role_menu` VALUES (265, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 8);
INSERT INTO `t_role_menu` VALUES (266, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 5);
INSERT INTO `t_role_menu` VALUES (267, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 14);
INSERT INTO `t_role_menu` VALUES (268, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 4);
INSERT INTO `t_role_menu` VALUES (269, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 34);
INSERT INTO `t_role_menu` VALUES (270, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 35);
INSERT INTO `t_role_menu` VALUES (271, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 36);
INSERT INTO `t_role_menu` VALUES (272, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 45);
INSERT INTO `t_role_menu` VALUES (273, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 17);
INSERT INTO `t_role_menu` VALUES (274, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 19);
INSERT INTO `t_role_menu` VALUES (275, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 31);
INSERT INTO `t_role_menu` VALUES (276, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 18);
INSERT INTO `t_role_menu` VALUES (277, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 28);
INSERT INTO `t_role_menu` VALUES (278, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 30);
INSERT INTO `t_role_menu` VALUES (279, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 21);
INSERT INTO `t_role_menu` VALUES (280, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 15);
INSERT INTO `t_role_menu` VALUES (281, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 25);
INSERT INTO `t_role_menu` VALUES (282, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 16);
INSERT INTO `t_role_menu` VALUES (283, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 20);
INSERT INTO `t_role_menu` VALUES (284, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 24);
INSERT INTO `t_role_menu` VALUES (285, '2024-07-21 07:45:01', 1, '2024-07-21 07:45:01', 0, 0, 3, 32);

-- ----------------------------
-- Table structure for t_roles
-- ----------------------------
DROP TABLE IF EXISTS `t_roles`;
CREATE TABLE `t_roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限标识',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '权限名称',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '顺序',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态(0: 正常, 1: 停用)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_t_roles_key`(`key`) USING BTREE,
  INDEX `ix_t_roles_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_roles
-- ----------------------------
INSERT INTO `t_roles` VALUES (1, '2022-11-13 02:44:13', 0, '2022-11-13 02:44:13', 0, 0, 'admin', '超级管理员', 1, 0);
INSERT INTO `t_roles` VALUES (2, '2022-11-13 02:46:33', 0, '2024-07-21 07:28:37', 1, 0, 'general', '一般用户', 2, 0);
INSERT INTO `t_roles` VALUES (3, '2022-11-22 00:55:04', 1, '2024-07-21 07:45:01', 1, 0, 'Operation', '管理员', 3, 0);

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `user_id` int(11) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `ix_t_user_role_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES (1, '2022-11-13 02:58:19', 0, '2022-11-13 02:58:19', 0, 0, 1, 1);
INSERT INTO `t_user_role` VALUES (3, '2022-11-22 00:50:26', 0, '2022-11-22 00:50:26', 0, 0, 3, 2);
INSERT INTO `t_user_role` VALUES (4, '2022-11-22 00:55:57', 1, '2022-11-22 00:55:57', 0, 0, 2, 3);
INSERT INTO `t_user_role` VALUES (10, '2023-12-16 11:35:26', 1, '2023-12-16 11:35:26', 0, 0, 4, 2);

-- ----------------------------
-- Table structure for t_users
-- ----------------------------
DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '姓名',
  `sex` int(11) NULL DEFAULT 0 COMMENT '性别',
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `hashed_password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `avatar` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '状态',
  `is_active` tinyint(1) NULL DEFAULT 0 COMMENT '是否已经验证用户',
  `is_superuser` tinyint(1) NULL DEFAULT 0 COMMENT '是否超级管理员',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_t_users_username`(`username`) USING BTREE,
  INDEX `ix_t_users_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_users
-- ----------------------------
INSERT INTO `t_users` VALUES (2, '2022-11-22 00:48:34', 0, '2022-11-22 00:55:57', 1, 0, 'opt', 'opt', 0, '12345678911', 'opt@beginner2020.top', '$2b$12$EbJD0X5U0LwAvf5EVvYxZO20Jyv2xLKU1quekOyX3SwhdVepz1RFu', NULL, 0, 1, 0);
INSERT INTO `t_users` VALUES (4, '2023-12-02 15:36:42', 1, '2023-12-16 13:16:49', 4, 0, 'hjdhnx', '道长', 2, '13154671296', '434857005@qq.com', '$2b$12$X3LQ2VXThey.YB/WGlwYq.35CKOeKkBgmA6TTR91q/VYe6hGDAWRO', 'images/avatar/f84e9577-9047-470e-bcde-16173ca1811c.jpg', 0, 1, 0);
INSERT INTO `t_users` VALUES (1, '2022-11-13 02:58:19', 0, '2024-03-17 09:41:24', 1, 0, 'admin', '超级管理员', 0, '12345678910', 'admin@beginner2020.top', '$2b$12$nlyWZAzu4C9cgbHV/FE1X.nwBKiGemATgCxikPQEQVznMqBCrDw/e', 'images/avatar/cad832e9-e7e5-4b4c-a898-0a64ca9ea2f4.png', 0, 1, 1);
INSERT INTO `t_users` VALUES (3, '2022-11-22 00:50:26', 0, '2023-12-09 16:47:45', 1, 0, 'user', 'user', 0, '12345678912', 'user@beginner2020.top', '$2b$12$Wov4niPCoLOeBcRNgGDNhekSZBgB/GAhYs25CLHfJG.me1KbFP0am', NULL, 0, 1, 0);

-- ----------------------------
-- Table structure for t_vod_configs
-- ----------------------------
DROP TABLE IF EXISTS `t_vod_configs`;
CREATE TABLE `t_vod_configs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数名称',
  `key` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数键',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '参数值',
  `value_type` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '值类型',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `status` int(11) NULL DEFAULT 0 COMMENT '参数状态',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示排序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_vod_configs_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_vod_configs
-- ----------------------------
INSERT INTO `t_vod_configs` VALUES (14, '2024-02-19 13:52:29', 1, '2024-05-29 13:11:46', 1, 0, 'drpy源仓库1', 'vod_drpy_house1', 'hjdhnx/dr_py|js', 'str', 'drpy源的github仓库。repo|path', 1, 14);
INSERT INTO `t_vod_configs` VALUES (15, '2024-02-19 13:52:29', 1, '2024-05-29 13:11:46', 1, 0, 'drpy源仓库2', 'vod_drpy_house2', 'heroaku/TVboxo|Js', 'str', 'drpy源的github仓库。repo|path', 1, 15);
INSERT INTO `t_vod_configs` VALUES (16, '2024-03-10 11:05:05', 1, '2024-05-29 13:11:46', 1, 0, 'drpy源仓库3', 'vod_drpy_house3', 'gaotianliuyun/gao|js', 'str', 'drpy源的github仓库(高天流云)。repo|path', 1, 16);
INSERT INTO `t_vod_configs` VALUES (4, '2024-02-01 13:15:53', 1, '2024-05-29 13:11:56', 1, 0, '自定义配置模板文件', 'vod_config_custom', 'txt/pg.conf', 'file', 'hipy的自动生成在线配置将使用此文件作为个性化配置', 1, 4);
INSERT INTO `t_vod_configs` VALUES (1, '2024-02-01 13:15:53', 1, '2024-05-29 13:11:45', 1, 0, 'drpy接口文件', 'vod_drpy_api', 'drpy_libs/drpy2.min.js', 'file', '自动生成配置中的drpy的api将会使用此文件', 1, 1);
INSERT INTO `t_vod_configs` VALUES (2, '2024-02-01 13:15:53', 1, '2024-05-29 13:11:45', 1, 0, '接口密码', 'vod_passwd', 'dzyyds', 'str', 'hipy的t4接口将使用此密码作为参数验证', 1, 2);
INSERT INTO `t_vod_configs` VALUES (3, '2024-02-01 13:15:53', 1, '2024-05-29 13:11:45', 1, 0, '生成配置模板文件', 'vod_config_base', 'txt/config.txt', 'file', 'hipy的自动生成在线配置将使用此文件作为渲染模板', 1, 3);
INSERT INTO `t_vod_configs` VALUES (5, '2024-02-01 13:15:53', 1, '2024-05-29 13:11:45', 1, 0, '自定义解析文件', 'vod_vip_parse', 'txt/vip_parse.conf', 'file', 'hipy的自定义视频解析配置文件', 1, 5);
INSERT INTO `t_vod_configs` VALUES (6, '2024-02-01 13:15:53', 1, '2024-05-29 13:11:45', 1, 0, '自定义直播外链', 'vod_zb_url', 'http://hiker.nokia.press/hikerule/zyw_data/43', 'url', 'hipy的自定义直播外链文件', 1, 6);
INSERT INTO `t_vod_configs` VALUES (10, '2024-02-04 14:21:12', 1, '2024-05-29 13:11:45', 1, 0, '自定义直播本地文件', 'vod_zb_file', 'txt/mytv.txt', 'file', 'hipy的自定义直播本地文件', 1, 10);
INSERT INTO `t_vod_configs` VALUES (11, '2024-02-04 14:21:12', 1, '2024-05-29 13:11:46', 1, 0, '自定义直播使用', 'vod_zb_use', 'file', 'str', 'hipy的直播使用外链或文件|file:使用文件,url:使用外链', 1, 11);
INSERT INTO `t_vod_configs` VALUES (7, '2024-02-01 13:15:53', 1, '2024-05-29 13:11:46', 1, 0, '自定义挂载jar', 'vod_custom_jar', 'jar/custom_spider_dz1201.jar', 'file', 'hipy的自定义外挂jar文件,用于直播解析和视频解析轮询', 1, 7);
INSERT INTO `t_vod_configs` VALUES (8, '2024-02-01 13:15:53', 1, '2024-05-29 13:11:46', 1, 0, '自定义壁纸', 'vod_wall_paper', 'https://tuapi.eees.cc/api.php?category=fengjing&type=302', 'url', 'hipy的自定义壁纸，可以是文件或着链接', 1, 8);
INSERT INTO `t_vod_configs` VALUES (9, '2024-02-02 17:36:29', 1, '2024-05-29 13:11:46', 1, 0, '环境变量', 'vod_hipy_env', '{\"ali_token\":\"682c41720d6d4c9d8ded00bcdd712870\",\"bili_cookie\":\"SESSDATA=93f1b89c%2C1685503124%2C760e0%2Ac1; bili_jct=5e0a1e65979f4d9f48fd9c158362b573; DedeUserID=253592508\",\"douban\":\"264291961\",\"vmid\":\"253592508\",\"test_env\":\"测试环境变量\",\"appkey\":\"1d8b6e7d45233436\",\"access_key\":\"3841bf63f94a8e8d0181e59470167aa1CjCup6x6MSEv8rLctbAuWLQs0ra3Ej09EJhjMBrgAsaVt3ALYteyfxjvizVqWrnlR0ESVmlucDVmcHBycjZDVk9KMDFucTRmMEcwMUlHWWhQZkVvUnRqeTdMWTNjU2phSkdpRkZFTGJPQUZ6NEVmcVVMUUx2WjZBTl8wb0lsTjhLbmp6SHVxRjdRIIEC\"}', 'json', 'hipy的环境变量，json数据', 1, 9);
INSERT INTO `t_vod_configs` VALUES (12, '2024-02-19 11:22:58', 1, '2024-05-29 13:11:46', 1, 0, 'git访问代理', 'vod_git_proxy', 'https://ghproxy.liuzhicong.com/', 'url', '代理加速git访问，解决被墙问题', 1, 12);
INSERT INTO `t_vod_configs` VALUES (13, '2024-02-19 11:22:58', 1, '2024-05-29 13:11:46', 1, 0, 'git访问令牌', 'vod_git_token', ' ', 'str', '从 http://github.com/settings/tokens 获取的token，可以操作api以及破解git访问次数限制每小时60次提升至5000次', 1, 13);

-- ----------------------------
-- Table structure for t_vod_rules
-- ----------------------------
DROP TABLE IF EXISTS `t_vod_rules`;
CREATE TABLE `t_vod_rules`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源名称',
  `group` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '源分组',
  `path` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `is_exist` tinyint(1) NULL DEFAULT 1 COMMENT '是否存在',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示排序',
  `file_type` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `ext` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'ext扩展',
  `status` int(11) NULL DEFAULT 0 COMMENT '源状态',
  `searchable` int(11) NULL DEFAULT 0 COMMENT '可搜索',
  `filterable` int(11) NULL DEFAULT 0 COMMENT '可筛选',
  `quickSearch` int(11) NULL DEFAULT 0 COMMENT '可快速搜索',
  `active` tinyint(1) NULL DEFAULT 1 COMMENT '是否显示',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_vod_rules_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 594 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_vod_rules
-- ----------------------------
INSERT INTO `t_vod_rules` VALUES (11, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, '喵次元', 't4/spiders', 't4/spiders/喵次元.py', 1, 11, '.py', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (12, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, '新浪资源', 't4/spiders', 't4/spiders/新浪资源.py', 1, 12, '.py', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (13, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, '樱花动漫', 't4/spiders', 't4/spiders/樱花动漫.json', 1, 9999, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (320, '2024-05-25 15:45:01', 1, '2024-07-21 07:00:46', 1, 0, 'iFun', 't4/files/drpy_js', 't4/files/drpy_js/iFun.js', 1, 314, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (285, '2024-05-16 08:22:11', 1, '2024-07-21 07:00:46', 1, 0, '孜然影视', 't4/files/drpy_js', 't4/files/drpy_js/孜然影视.js', 1, 279, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (287, '2024-05-16 08:22:12', 1, '2024-07-21 07:00:47', 1, 0, '快看影视', 't4/files/drpy_js', 't4/files/drpy_js/快看影视.js', 1, 281, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (267, '2024-05-15 06:21:15', 1, '2024-07-21 07:00:47', 1, 0, '思古影视[V2]', 't4/files/drpy_js', 't4/files/drpy_js/思古影视[V2].js', 1, 261, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (344, '2024-05-30 18:55:04', 1, '2024-07-21 07:00:47', 1, 0, '易搜[搜]', 't4/files/drpy_js', 't4/files/drpy_js/易搜[搜].js', 1, 338, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (283, '2024-05-16 08:22:11', 1, '2024-07-21 07:00:47', 1, 0, '星云影视', 't4/files/drpy_js', 't4/files/drpy_js/星云影视.js', 1, 277, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (332, '2024-05-28 03:41:22', 1, '2024-07-21 07:00:47', 1, 0, '爱看hd', 't4/files/drpy_js', 't4/files/drpy_js/爱看hd.js', 1, 326, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (354, '2024-06-05 15:25:08', 1, '2024-07-21 07:00:47', 1, 0, '番茄小说[书]', 't4/files/drpy_js', 't4/files/drpy_js/番茄小说[书].js', 1, 348, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (319, '2024-05-25 15:45:01', 1, '2024-07-21 07:00:47', 1, 0, '看客影院', 't4/files/drpy_js', 't4/files/drpy_js/看客影院.js', 1, 313, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (279, '2024-05-16 08:22:11', 1, '2024-07-21 07:00:47', 1, 0, '看看影视', 't4/files/drpy_js', 't4/files/drpy_js/看看影视.js', 1, 273, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (362, '2024-06-08 01:52:31', 1, '2024-07-21 07:00:47', 1, 0, '黑料不打烊-z', 't4/files/drpy_js', 't4/files/drpy_js/黑料不打烊-z.js', 1, 356, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (318, '2024-05-25 15:45:01', 1, '2024-07-21 07:00:47', 1, 0, '黑木耳资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/黑木耳资源[资].js', 1, 312, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (25, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'alist', 't4/files/drpy_libs', 't4/files/drpy_libs/alist.js', 1, 25, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (27, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'atob', 't4/files/drpy_libs', 't4/files/drpy_libs/atob.js', 1, 27, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (28, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'base64', 't4/files/drpy_libs', 't4/files/drpy_libs/base64.js', 1, 28, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (29, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'cheerio.min', 't4/files/drpy_libs', 't4/files/drpy_libs/cheerio.min.js', 1, 29, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (30, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'crypto-hiker', 't4/files/drpy_libs', 't4/files/drpy_libs/crypto-hiker.js', 1, 30, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (31, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'crypto-js', 't4/files/drpy_libs', 't4/files/drpy_libs/crypto-js.js', 1, 31, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (33, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'drpy2', 't4/files/drpy_libs', 't4/files/drpy_libs/drpy2.js', 1, 33, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (34, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'drpy2.min', 't4/files/drpy_libs', 't4/files/drpy_libs/drpy2.min.js', 1, 34, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (35, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'drT', 't4/files/drpy_libs', 't4/files/drpy_libs/drT.js', 1, 35, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (36, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'es6py', 't4/files/drpy_libs', 't4/files/drpy_libs/es6py.js', 1, 36, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (37, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'exRegExp', 't4/files/drpy_libs', 't4/files/drpy_libs/exRegExp.js', 1, 37, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (38, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'gbk', 't4/files/drpy_libs', 't4/files/drpy_libs/gbk.js', 1, 38, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (39, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'live2cms', 't4/files/drpy_libs', 't4/files/drpy_libs/live2cms.js', 1, 39, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (40, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'mod', 't4/files/drpy_libs', 't4/files/drpy_libs/mod.js', 1, 40, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (64, '2024-02-05 09:48:57', 1, '2024-07-21 07:00:47', 1, 0, 'qjs_env', 't4/files/drpy_libs', 't4/files/drpy_libs/qjs_env.js', 1, 64, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (41, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'rsa', 't4/files/drpy_libs', 't4/files/drpy_libs/rsa.js', 1, 41, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (42, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'searchFilter', 't4/files/drpy_libs', 't4/files/drpy_libs/searchFilter.js', 1, 42, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (43, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'sortName', 't4/files/drpy_libs', 't4/files/drpy_libs/sortName.js', 1, 43, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (44, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, '模板', 't4/files/drpy_libs', 't4/files/drpy_libs/模板.js', 1, 44, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (45, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'alist', 't4/files/json', 't4/files/json/alist.json', 1, 45, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (49, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:48', 1, 0, 'douyu', 't4/files/txt', 't4/files/txt/douyu.txt', 1, 49, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (50, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:48', 1, 0, 'huya', 't4/files/txt', 't4/files/txt/huya.txt', 1, 50, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (76, '2024-02-20 16:25:29', 1, '2024-07-21 07:00:48', 1, 0, 'tv', 't4/files/txt', 't4/files/txt/tv.txt', 1, 70, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (62, '2024-02-04 14:21:09', 1, '2024-07-21 07:00:48', 1, 0, 'zb', 't4/files/txt', 't4/files/txt/zb.txt', 1, 62, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (80, '2024-03-08 15:53:21', 1, '2024-07-21 07:00:48', 1, 0, 'drpy3', 't4/files/drpy3_libs', 't4/files/drpy3_libs/drpy3.js', 1, 74, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (92, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'banan', 't4/files/drpy3_js', 't4/files/drpy3_js/banan.js', 1, 86, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (54, '2024-02-02 15:59:25', 1, '2024-07-21 07:08:44', 4, 0, '在线之家', 't4/files/drpy_js', 't4/files/drpy_js/在线之家.js', 1, 54, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (4, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, 'base_spider', 't4/spiders', 't4/spiders/base_spider.py', 1, 0, '.py', NULL, 1, 1, 1, 0, 0);
INSERT INTO `t_vod_rules` VALUES (6, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, 'cntv央视', 't4/spiders', 't4/spiders/cntv央视.py', 1, 0, '.py', '{{host}}/files/hipy/cntv央视.json', 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (7, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, 'test_1', 't4/spiders', 't4/spiders/test_1.txt', 1, 9999, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (8, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, '两个BT', 't4/spiders', 't4/spiders/两个BT.json', 1, 9999, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (9, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, '两个BT', 't4/spiders', 't4/spiders/两个BT.py', 1, 9, '.py', '{{host}}/files/hipy/两个BT.json', 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (381, '2024-06-09 18:53:00', 1, '2024-07-21 07:00:47', 1, 0, '飞翔鸟[书]', 't4/files/drpy_js', 't4/files/drpy_js/飞翔鸟[书].js', 1, 375, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (60, '2024-02-04 14:21:09', 1, '2024-07-21 07:00:47', 1, 0, 'E8plus', 't4/files/json', 't4/files/json/E8plus.json', 1, 60, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (46, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:48', 1, 0, 'bili', 't4/files/txt', 't4/files/txt/bili.txt', 1, 46, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (47, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:48', 1, 0, 'config', 't4/files/txt', 't4/files/txt/config.txt', 1, 47, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (48, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:48', 1, 0, 'custom', 't4/files/txt', 't4/files/txt/custom.conf', 1, 48, '.conf', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (77, '2024-03-08 15:53:20', 1, '2024-07-21 07:00:48', 1, 0, 'mytv', 't4/files/txt', 't4/files/txt/mytv.txt', 1, 71, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (65, '2024-02-05 09:48:57', 1, '2024-07-21 07:00:48', 1, 0, 'custom_jsapi', 't4/files/jar', 't4/files/jar/custom_jsapi.jar', 1, 65, '.jar', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (66, '2024-02-05 09:48:57', 1, '2024-07-21 07:00:48', 1, 0, 'custom_spider_dz1201', 't4/files/jar', 't4/files/jar/custom_spider_dz1201.jar', 1, 66, '.jar', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (67, '2024-02-05 09:56:10', 1, '2024-07-21 07:00:48', 1, 0, '哔哩', 't4/files/js_parse_api', 't4/files/js_parse_api/哔哩.js', 1, 67, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (131, '2024-03-29 09:09:21', 1, '2024-07-21 07:00:48', 1, 0, '杰森', 't4/files/js_parse_api', 't4/files/js_parse_api/杰森.js', 1, 125, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (78, '2024-03-08 15:53:21', 1, '2024-07-21 07:00:48', 1, 0, 'cheerio.min', 't4/files/drpy3_libs', 't4/files/drpy3_libs/cheerio.min.js', 1, 72, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (79, '2024-03-08 15:53:21', 1, '2024-07-21 07:00:48', 1, 0, 'crypto-js', 't4/files/drpy3_libs', 't4/files/drpy3_libs/crypto-js.js', 1, 73, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (125, '2024-03-19 11:00:53', 1, '2024-07-21 07:00:48', 1, 0, 'drpy3.hiker', 't4/files/drpy3_libs', 't4/files/drpy3_libs/drpy3.hiker.js', 1, 119, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (82, '2024-03-08 15:53:21', 1, '2024-07-21 07:00:48', 1, 0, 'gbk', 't4/files/drpy3_libs', 't4/files/drpy3_libs/gbk.js', 1, 76, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (83, '2024-03-08 15:53:21', 1, '2024-07-21 07:00:48', 1, 0, '模板', 't4/files/drpy3_libs', 't4/files/drpy3_libs/模板.js', 1, 77, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (85, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '1080P', 't4/files/drpy3_js', 't4/files/drpy3_js/1080P.js', 1, 79, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (86, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '18av', 't4/files/drpy3_js', 't4/files/drpy3_js/18av.js', 1, 80, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (87, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '369影视', 't4/files/drpy3_js', 't4/files/drpy3_js/369影视.js', 1, 81, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (88, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '4khdr', 't4/files/drpy3_js', 't4/files/drpy3_js/4khdr.js', 1, 82, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (89, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '97tvs', 't4/files/drpy3_js', 't4/files/drpy3_js/97tvs.js', 1, 83, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (90, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'aipanso', 't4/files/drpy3_js', 't4/files/drpy3_js/aipanso.js', 1, 84, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (91, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'alist', 't4/files/drpy3_js', 't4/files/drpy3_js/alist.json', 1, 85, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (93, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'cilixiong', 't4/files/drpy3_js', 't4/files/drpy3_js/cilixiong.js', 1, 87, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (95, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'ddys_d', 't4/files/drpy3_js', 't4/files/drpy3_js/ddys_d.js', 1, 89, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (96, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'dydhhy', 't4/files/drpy3_js', 't4/files/drpy3_js/dydhhy.js', 1, 90, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (97, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'dygang', 't4/files/drpy3_js', 't4/files/drpy3_js/dygang.js', 1, 91, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (98, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'funletu', 't4/files/drpy3_js', 't4/files/drpy3_js/funletu.js', 1, 92, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (99, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'huya', 't4/files/drpy3_js', 't4/files/drpy3_js/huya.js', 1, 93, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (100, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'jianpian', 't4/files/drpy3_js', 't4/files/drpy3_js/jianpian.js', 1, 94, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (101, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'jiyingw', 't4/files/drpy3_js', 't4/files/drpy3_js/jiyingw.js', 1, 95, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (102, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'jiyingwp', 't4/files/drpy3_js', 't4/files/drpy3_js/jiyingwp.js', 1, 96, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (103, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'kkpans', 't4/files/drpy3_js', 't4/files/drpy3_js/kkpans.js', 1, 97, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (104, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'kuba', 't4/files/drpy3_js', 't4/files/drpy3_js/kuba.js', 1, 98, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (105, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'lf_live', 't4/files/drpy3_js', 't4/files/drpy3_js/lf_live.txt', 1, 99, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (106, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'lf_live1', 't4/files/drpy3_js', 't4/files/drpy3_js/lf_live1.txt', 1, 100, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (114, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'rrdyw', 't4/files/drpy3_js', 't4/files/drpy3_js/rrdyw.js', 1, 108, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (116, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'tzfile', 't4/files/drpy3_js', 't4/files/drpy3_js/tzfile.js', 1, 110, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (118, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'xzys', 't4/files/drpy3_js', 't4/files/drpy3_js/xzys.js', 1, 112, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (119, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'yyets', 't4/files/drpy3_js', 't4/files/drpy3_js/yyets.js', 1, 113, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (120, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'yyetsp', 't4/files/drpy3_js', 't4/files/drpy3_js/yyetsp.js', 1, 114, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (121, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '养端', 't4/files/drpy3_js', 't4/files/drpy3_js/养端.js', 1, 115, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (122, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '吸瓜', 't4/files/drpy3_js', 't4/files/drpy3_js/吸瓜.js', 1, 116, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (135, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:46', 1, 0, '厂长资源', 't4/spiders', 't4/spiders/厂长资源.py', 1, 129, '.py', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (441, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '88看球[球]', 't4/files/drpy_js', 't4/files/drpy_js/88看球[球].js', 1, 435, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (330, '2024-05-27 10:10:44', 1, '2024-07-21 07:00:47', 1, 0, '爱看农民[优]', 't4/files/drpy_js', 't4/files/drpy_js/爱看农民[优].js', 1, 324, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (282, '2024-05-16 08:22:11', 1, '2024-07-21 07:00:47', 1, 0, '蓝光影视', 't4/files/drpy_js', 't4/files/drpy_js/蓝光影视.js', 1, 276, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (284, '2024-05-16 08:22:11', 1, '2024-07-21 07:00:47', 1, 0, '西屋影视', 't4/files/drpy_js', 't4/files/drpy_js/西屋影视.js', 1, 278, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (457, '2024-06-17 16:35:38', 1, '2024-07-21 07:00:46', 1, 0, 'MuteFun[漫]', 't4/files/drpy_js', 't4/files/drpy_js/MuteFun[漫].js', 1, 451, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (395, '2024-06-12 10:09:51', 1, '2024-07-21 07:00:46', 1, 0, '千百视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/千百视频[密].js', 1, 389, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (127, '2024-03-29 09:09:21', 1, '2024-07-21 07:00:46', 1, 0, '厂长资源', 't4/files/drpy_js', 't4/files/drpy_js/厂长资源.js', 1, 121, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (155, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:46', 1, 0, '大米星球', 't4/files/drpy_js', 't4/files/drpy_js/大米星球.js', 1, 149, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (429, '2024-06-17 16:35:36', 1, '2024-07-21 07:00:46', 1, 0, '好趣网[播]', 't4/files/drpy_js', 't4/files/drpy_js/好趣网[播].js', 1, 423, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (389, '2024-06-11 10:05:03', 1, '2024-07-21 07:00:46', 1, 0, '子子影视', 't4/files/drpy_js', 't4/files/drpy_js/子子影视.js', 1, 383, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (446, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '斗鱼直播[官]', 't4/files/drpy_js', 't4/files/drpy_js/斗鱼直播[官].js', 1, 440, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (288, '2024-05-16 08:22:12', 1, '2024-07-21 07:00:47', 1, 0, '星空影院', 't4/files/drpy_js', 't4/files/drpy_js/星空影院.js', 1, 282, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (439, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '樱花动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/樱花动漫[漫].js', 1, 433, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (430, '2024-06-17 16:35:36', 1, '2024-07-21 07:00:47', 1, 0, '漫小肆[画]', 't4/files/drpy_js', 't4/files/drpy_js/漫小肆[画].js', 1, 424, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (388, '2024-06-11 10:05:03', 1, '2024-07-21 07:00:47', 1, 0, '热片网', 't4/files/drpy_js', 't4/files/drpy_js/热片网.js', 1, 382, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (322, '2024-05-25 15:45:01', 1, '2024-07-21 07:00:47', 1, 0, '电影天堂', 't4/files/drpy_js', 't4/files/drpy_js/电影天堂.js', 1, 316, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (153, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:47', 1, 0, '白嫖者联盟', 't4/files/drpy_js', 't4/files/drpy_js/白嫖者联盟.js', 1, 147, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (433, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '第一韩漫[画]', 't4/files/drpy_js', 't4/files/drpy_js/第一韩漫[画].js', 1, 427, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (440, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '维奇动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/维奇动漫[漫].js', 1, 434, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (333, '2024-05-28 10:11:14', 1, '2024-07-21 07:00:47', 1, 0, '胖虎影视', 't4/files/drpy_js', 't4/files/drpy_js/胖虎影视.js', 1, 327, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (270, '2024-05-15 06:21:15', 1, '2024-07-21 07:00:47', 1, 0, '蛋蛋剧', 't4/files/drpy_js', 't4/files/drpy_js/蛋蛋剧.js', 1, 264, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (271, '2024-05-15 06:21:15', 1, '2024-07-21 07:00:47', 1, 0, '蛋蛋赞', 't4/files/drpy_js', 't4/files/drpy_js/蛋蛋赞.js', 1, 265, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (432, '2024-06-17 16:35:36', 1, '2024-07-21 07:00:47', 1, 0, '麻雀视频[优]', 't4/files/drpy_js', 't4/files/drpy_js/麻雀视频[优].js', 1, 426, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (59, '2024-02-04 14:21:09', 1, '2024-07-21 07:00:47', 1, 0, 'bili', 't4/files/json', 't4/files/json/bili.json', 1, 59, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (75, '2024-02-19 18:15:01', 1, '2024-07-21 07:00:47', 1, 0, 'drpy_rules', 't4/files/json', 't4/files/json/drpy_rules.json', 1, 69, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (186, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:47', 1, 0, 'moli', 't4/files/json', 't4/files/json/moli.json', 1, 180, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (188, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'wgcf', 't4/files/json', 't4/files/json/wgcf.json', 1, 182, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (51, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:48', 1, 0, 'vip_parse', 't4/files/txt', 't4/files/txt/vip_parse.conf', 1, 51, '.conf', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (191, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'pg', 't4/files/jar', 't4/files/jar/pg.jar', 1, 185, '.jar', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (129, '2024-03-29 09:09:21', 1, '2024-07-21 07:00:48', 1, 0, 'CK', 't4/files/js_parse_api', 't4/files/js_parse_api/CK.js', 1, 123, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (130, '2024-03-29 09:09:21', 1, '2024-07-21 07:00:48', 1, 0, '夜幕', 't4/files/js_parse_api', 't4/files/js_parse_api/夜幕.js', 1, 124, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (132, '2024-03-29 09:09:21', 1, '2024-07-21 07:00:48', 1, 0, '盘古', 't4/files/js_parse_api', 't4/files/js_parse_api/盘古.js', 1, 126, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (133, '2024-03-29 09:09:21', 1, '2024-07-21 07:00:48', 1, 0, '虾米', 't4/files/js_parse_api', 't4/files/js_parse_api/虾米.js', 1, 127, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (134, '2024-03-29 09:09:21', 1, '2024-07-21 07:00:48', 1, 0, '阳途', 't4/files/js_parse_api', 't4/files/js_parse_api/阳途.js', 1, 128, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (192, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'pako.min', 't4/files/drpy3_libs', 't4/files/drpy3_libs/pako.min.js', 1, 186, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (107, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'live2mv_data', 't4/files/drpy3_js', 't4/files/drpy3_js/live2mv_data.json', 1, 101, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (108, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'meijumi', 't4/files/drpy3_js', 't4/files/drpy3_js/meijumi.js', 1, 102, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (109, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'meijumip', 't4/files/drpy3_js', 't4/files/drpy3_js/meijumip.js', 1, 103, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (110, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'meow', 't4/files/drpy3_js', 't4/files/drpy3_js/meow.js', 1, 104, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (111, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'Missav', 't4/files/drpy3_js', 't4/files/drpy3_js/Missav.js', 1, 105, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (112, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'mp4us', 't4/files/drpy3_js', 't4/files/drpy3_js/mp4us.js', 1, 106, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (113, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'qimiao', 't4/files/drpy3_js', 't4/files/drpy3_js/qimiao.js', 1, 107, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (117, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'xb6v', 't4/files/drpy3_js', 't4/files/drpy3_js/xb6v.js', 1, 111, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (124, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '玩偶姐姐', 't4/files/drpy3_js', 't4/files/drpy3_js/玩偶姐姐.js', 1, 118, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (81, '2024-03-08 15:53:21', 1, '2024-07-21 07:00:48', 1, 0, 'drpy3.min', 't4/files/drpy3_libs', 't4/files/drpy3_libs/drpy3.min.js', 0, 75, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (5, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, 'cntv央视', 't4/spiders', 't4/spiders/cntv央视.json', 1, 9999, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (10, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, '哔滴影视', 't4/spiders', 't4/spiders/哔滴影视.py', 1, 10, '.py', '{{host}}/files/hipy/jars/bidi.jar', 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (136, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:46', 1, 0, '在线之家', 't4/spiders', 't4/spiders/在线之家.py', 1, 130, '.py', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (410, '2024-06-14 18:03:33', 1, '2024-07-21 07:00:46', 1, 0, 'bilfun(自动)', 't4/files/drpy_js', 't4/files/drpy_js/bilfun(自动).js', 1, 404, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (126, '2024-03-29 09:09:20', 1, '2024-07-21 07:00:46', 1, 0, 'freeok', 't4/files/drpy_js', 't4/files/drpy_js/freeok.js', 1, 120, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (162, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:46', 1, 0, 'voflix', 't4/files/drpy_js', 't4/files/drpy_js/voflix.js', 1, 156, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (202, '2024-05-09 11:39:58', 1, '2024-07-21 07:00:46', 1, 0, '七年影视', 't4/files/drpy_js', 't4/files/drpy_js/七年影视.js', 1, 196, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (442, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '云盘资源网[盘]', 't4/files/drpy_js', 't4/files/drpy_js/云盘资源网[盘].js', 1, 436, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (200, '2024-05-08 14:08:15', 1, '2024-07-21 07:00:46', 1, 0, '侠客影视', 't4/files/drpy_js', 't4/files/drpy_js/侠客影视.js', 1, 194, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (437, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '动漫巴士[漫]', 't4/files/drpy_js', 't4/files/drpy_js/动漫巴士[漫].js', 1, 431, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (445, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '动漫网[漫]', 't4/files/drpy_js', 't4/files/drpy_js/动漫网[漫].js', 1, 439, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (451, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '多多追剧[优]', 't4/files/drpy_js', 't4/files/drpy_js/多多追剧[优].js', 1, 445, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (438, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '大米动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/大米动漫[漫].js', 1, 432, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (161, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:46', 1, 0, '大米星球[V2]', 't4/files/drpy_js', 't4/files/drpy_js/大米星球[V2].js', 1, 155, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (390, '2024-06-11 10:05:04', 1, '2024-07-21 07:00:46', 1, 0, '天启', 't4/files/drpy_js', 't4/files/drpy_js/天启.js', 1, 384, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (453, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '广播迷FM[听]', 't4/files/drpy_js', 't4/files/drpy_js/广播迷FM[听].js', 1, 447, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (447, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '恒大影视[密]', 't4/files/drpy_js', 't4/files/drpy_js/恒大影视[密].js', 1, 441, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (367, '2024-06-09 11:52:40', 1, '2024-07-21 07:00:47', 1, 0, '播客[听]', 't4/files/drpy_js', 't4/files/drpy_js/播客[听].js', 1, 361, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (424, '2024-06-17 07:27:22', 1, '2024-07-21 07:00:47', 1, 0, '最新4K', 't4/files/drpy_js', 't4/files/drpy_js/最新4K.js', 1, 418, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (160, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:47', 1, 0, '榜一短剧', 't4/files/drpy_js', 't4/files/drpy_js/榜一短剧.js', 1, 154, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (434, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '次元城动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/次元城动漫[漫].js', 1, 428, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (431, '2024-06-17 16:35:36', 1, '2024-07-21 07:00:47', 1, 0, '清风DJ[听]', 't4/files/drpy_js', 't4/files/drpy_js/清风DJ[听].js', 1, 425, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (448, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '爱车MV[听]', 't4/files/drpy_js', 't4/files/drpy_js/爱车MV[听].js', 1, 442, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (452, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '相声随身听[听]', 't4/files/drpy_js', 't4/files/drpy_js/相声随身听[听].js', 1, 446, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (396, '2024-06-12 10:09:52', 1, '2024-07-21 07:00:47', 1, 0, '老司视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/老司视频[密].js', 1, 390, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (128, '2024-03-29 09:09:21', 1, '2024-07-21 07:00:47', 1, 0, '耐看', 't4/files/drpy_js', 't4/files/drpy_js/耐看.js', 1, 122, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (444, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '虎牙直播[官]', 't4/files/drpy_js', 't4/files/drpy_js/虎牙直播[官].js', 1, 438, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (449, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:47', 1, 0, '驴番[漫]', 't4/files/drpy_js', 't4/files/drpy_js/驴番[漫].js', 1, 443, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (415, '2024-06-15 06:37:46', 1, '2024-07-21 07:00:47', 1, 0, '黑狐影院', 't4/files/drpy_js', 't4/files/drpy_js/黑狐影院.js', 1, 409, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (171, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:47', 1, 0, 'jsrsa.min', 't4/files/drpy_libs', 't4/files/drpy_libs/jsrsa.min.js', 1, 165, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (170, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:47', 1, 0, 'test_rsa', 't4/files/drpy_libs', 't4/files/drpy_libs/test_rsa.mjs', 1, 164, '.mjs', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (180, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:47', 1, 0, 'aliproxy', 't4/files/json', 't4/files/json/aliproxy.gz', 1, 174, '.gz', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (176, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:47', 1, 0, 'geoip.dat', 't4/files/json', 't4/files/json/geoip.dat.gz', 1, 170, '.gz', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (61, '2024-02-04 14:21:09', 1, '2024-07-21 07:00:47', 1, 0, 'live2mv_data', 't4/files/json', 't4/files/json/live2mv_data.json', 1, 61, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (179, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'pikpakclass', 't4/files/json', 't4/files/json/pikpakclass.json', 1, 173, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (182, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'pikpakclass.json.db', 't4/files/json', 't4/files/json/pikpakclass.json.db.gz', 1, 176, '.gz', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (185, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'pushshare', 't4/files/json', 't4/files/json/pushshare.txt', 1, 179, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (178, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'thundershare', 't4/files/json', 't4/files/json/thundershare.txt', 1, 172, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (174, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:48', 1, 0, 'tokenm', 't4/files/json', 't4/files/json/tokenm.json', 1, 168, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (183, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'wogg', 't4/files/json', 't4/files/json/wogg.json', 1, 177, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (190, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'pg', 't4/files/txt', 't4/files/txt/pg.conf', 1, 184, '.conf', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (207, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:48', 1, 0, 'node-rsa', 't4/files/drpy3_libs', 't4/files/drpy3_libs/node-rsa.js', 1, 201, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (212, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:48', 1, 0, 'heiliao', 't4/files/drpy3_js', 't4/files/drpy3_js/heiliao.js', 1, 206, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (366, '2024-06-09 11:52:39', 1, '2024-07-21 07:00:46', 1, 0, 'i275听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/i275听书[听].js', 1, 360, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (211, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:48', 1, 0, '农民影视2', 't4/files/drpy3_js', 't4/files/drpy3_js/农民影视2.js', 1, 205, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (175, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, '小学教育', 't4/files/json', 't4/files/json/小学教育.json', 0, 169, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (156, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:46', 1, 0, '6V新版[磁]', 't4/files/drpy_js', 't4/files/drpy_js/6V新版[磁].js', 1, 150, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (459, '2024-06-17 16:35:38', 1, '2024-07-21 07:00:46', 1, 0, 'NT动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/NT动漫[漫].js', 1, 453, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (435, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, 'OmoFun[漫]', 't4/files/drpy_js', 't4/files/drpy_js/OmoFun[漫].js', 1, 429, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (436, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, 'R18撸[密]', 't4/files/drpy_js', 't4/files/drpy_js/R18撸[密].js', 1, 430, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (237, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '卧龙资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/卧龙资源[资].js', 1, 231, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (242, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '奇珍异兽[官]', 't4/files/drpy_js', 't4/files/drpy_js/奇珍异兽[官].js', 1, 236, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (229, '2024-05-14 08:53:58', 1, '2024-07-21 07:00:46', 1, 0, '宝片视频', 't4/files/drpy_js', 't4/files/drpy_js/宝片视频.js', 1, 223, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (335, '2024-05-28 13:59:41', 1, '2024-07-21 07:00:46', 1, 0, '小站盘[搜]', 't4/files/drpy_js', 't4/files/drpy_js/小站盘[搜].js', 1, 329, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (231, '2024-05-14 08:53:58', 1, '2024-07-21 07:00:47', 1, 0, '新茶杯狐', 't4/files/drpy_js', 't4/files/drpy_js/新茶杯狐.js', 1, 225, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (256, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '暴风资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/暴风资源[资].js', 1, 250, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (234, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '极客资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/极客资源[资].js', 1, 228, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (385, '2024-06-10 02:30:06', 1, '2024-07-21 07:00:47', 1, 0, '橘子柚[盘]', 't4/files/drpy_js', 't4/files/drpy_js/橘子柚[盘].js', 1, 379, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (220, '2024-05-11 14:54:31', 1, '2024-07-21 07:00:47', 1, 0, '海外剧汇', 't4/files/drpy_js', 't4/files/drpy_js/海外剧汇.js', 1, 214, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (369, '2024-06-09 11:52:40', 1, '2024-07-21 07:00:47', 1, 0, '海洋听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/海洋听书[听].js', 1, 363, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (281, '2024-05-16 08:22:11', 1, '2024-07-21 07:00:47', 1, 0, '热播之家', 't4/files/drpy_js', 't4/files/drpy_js/热播之家.js', 1, 275, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (336, '2024-05-28 13:59:41', 1, '2024-07-21 07:00:47', 1, 0, '狗狗盘[搜]', 't4/files/drpy_js', 't4/files/drpy_js/狗狗盘[搜].js', 1, 330, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (203, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:47', 1, 0, '磁力熊[磁]', 't4/files/drpy_js', 't4/files/drpy_js/磁力熊[磁].js', 1, 197, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (240, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '腾云驾雾[官]', 't4/files/drpy_js', 't4/files/drpy_js/腾云驾雾[官].js', 1, 234, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (257, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '豆瓣[官]', 't4/files/drpy_js', 't4/files/drpy_js/豆瓣[官].js', 1, 251, '.js', '?render=1', 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (255, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '量子影视[资]', 't4/files/drpy_js', 't4/files/drpy_js/量子影视[资].js', 1, 249, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (26, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:47', 1, 0, 'alist.min', 't4/files/drpy_libs', 't4/files/drpy_libs/alist.min.js', 1, 26, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (206, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:47', 1, 0, 'node-rsa', 't4/files/drpy_libs', 't4/files/drpy_libs/node-rsa.js', 1, 200, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (168, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:47', 1, 0, 'pako.min', 't4/files/drpy_libs', 't4/files/drpy_libs/pako.min.js', 1, 162, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (189, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:47', 1, 0, 'alishare', 't4/files/json', 't4/files/json/alishare.txt', 1, 183, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (181, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'quarkshare', 't4/files/json', 't4/files/json/quarkshare.txt', 1, 175, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (177, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'sambashare', 't4/files/json', 't4/files/json/sambashare.txt', 1, 171, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (184, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'xray', 't4/files/json', 't4/files/json/xray.gz', 1, 178, '.gz', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (187, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, '白嫖筛选', 't4/files/json', 't4/files/json/白嫖筛选.json', 1, 181, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (193, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, 'jsencrypt', 't4/files/drpy3_libs', 't4/files/drpy3_libs/jsencrypt.js', 1, 187, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (208, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:48', 1, 0, '996影视', 't4/files/drpy3_js', 't4/files/drpy3_js/996影视.js', 1, 202, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (213, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:48', 1, 0, '农民影视', 't4/files/drpy3_js', 't4/files/drpy3_js/农民影视.js', 1, 207, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (210, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:48', 1, 0, '农民影视新', 't4/files/drpy3_js', 't4/files/drpy3_js/农民影视新.js', 1, 204, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (194, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, '去广告测试源', 't4/files/drpy3_js', 't4/files/drpy3_js/去广告测试源.js', 1, 188, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (195, '2024-05-06 13:29:00', 1, '2024-07-21 07:00:48', 1, 0, '去广告测试源1', 't4/files/drpy3_js', 't4/files/drpy3_js/去广告测试源1.js', 1, 189, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (209, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:48', 1, 0, '小蚂蚁资源', 't4/files/drpy3_js', 't4/files/drpy3_js/小蚂蚁资源.js', 1, 203, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (214, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:48', 1, 0, '小蚂蚁资源2', 't4/files/drpy3_js', 't4/files/drpy3_js/小蚂蚁资源2.js', 1, 208, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (123, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, '朱古力', 't4/files/drpy3_js', 't4/files/drpy3_js/朱古力.js', 1, 117, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (215, '2024-05-10 10:26:50', 1, '2024-07-21 07:00:48', 1, 0, '酷云77', 't4/files/drpy3_js', 't4/files/drpy3_js/酷云77.js', 1, 209, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (198, '2024-05-07 03:06:28', 1, '2024-07-21 07:00:46', 1, 0, 'TVB云播', 't4/files/drpy_js', 't4/files/drpy_js/TVB云播.js', 1, 192, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (289, '2024-05-16 08:22:12', 1, '2024-07-21 07:00:46', 1, 0, 'HDmoli', 't4/files/drpy_js', 't4/files/drpy_js/HDmoli.js', 1, 283, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (364, '2024-06-09 11:52:39', 1, '2024-07-21 07:00:46', 1, 0, '六月听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/六月听书[听].js', 1, 358, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (253, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '农民影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/农民影视[优].js', 1, 247, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (219, '2024-05-11 14:54:30', 1, '2024-07-21 07:00:46', 1, 0, '千神影视', 't4/files/drpy_js', 't4/files/drpy_js/千神影视.js', 1, 213, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (295, '2024-05-18 06:05:14', 1, '2024-07-21 07:00:46', 1, 0, '夕云影视', 't4/files/drpy_js', 't4/files/drpy_js/夕云影视.js', 1, 289, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (248, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '南瓜影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/南瓜影视[优].js', 1, 242, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (371, '2024-06-09 11:52:40', 1, '2024-07-21 07:00:46', 1, 0, '博看听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/博看听书[听].js', 1, 365, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (294, '2024-05-18 06:05:14', 1, '2024-07-21 07:00:46', 1, 0, '即看影视', 't4/files/drpy_js', 't4/files/drpy_js/即看影视.js', 1, 288, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (251, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '可可影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/可可影视[优].js', 1, 245, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (492, '2024-06-28 17:29:38', 1, '2024-07-21 07:00:46', 1, 0, '奶狗影视[慢]', 't4/files/drpy_js', 't4/files/drpy_js/奶狗影视[慢].js', 1, 486, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (327, '2024-05-26 11:05:14', 1, '2024-07-21 07:00:47', 1, 0, '小鱼影视', 't4/files/drpy_js', 't4/files/drpy_js/小鱼影视.js', 1, 321, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (494, '2024-06-28 17:29:38', 1, '2024-07-21 07:00:47', 1, 0, '影剧星球', 't4/files/drpy_js', 't4/files/drpy_js/影剧星球.js', 1, 488, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (495, '2024-06-28 17:29:38', 1, '2024-07-21 07:00:47', 1, 0, '影视大全', 't4/files/drpy_js', 't4/files/drpy_js/影视大全.js', 1, 489, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (496, '2024-06-28 17:29:38', 1, '2024-07-21 07:00:47', 1, 0, '影视控', 't4/files/drpy_js', 't4/files/drpy_js/影视控.js', 1, 490, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (326, '2024-05-26 11:05:14', 1, '2024-07-21 07:00:47', 1, 0, '想看影院', 't4/files/drpy_js', 't4/files/drpy_js/想看影院.js', 1, 320, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (246, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '我的哔哩[官]', 't4/files/drpy_js', 't4/files/drpy_js/我的哔哩[官].js', 1, 240, '.js', '?render=1&type=url&params=../json/小学教育.json@哔哩教育[官]\n?render=1&type=url&params=../json/哔哩大全.json@哔哩大全[官]', 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (391, '2024-06-11 10:48:33', 1, '2024-07-21 07:00:47', 1, 0, '我看书斋[书]', 't4/files/drpy_js', 't4/files/drpy_js/我看书斋[书].js', 1, 385, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (275, '2024-05-15 10:03:27', 1, '2024-07-21 07:00:47', 1, 0, '时光影院', 't4/files/drpy_js', 't4/files/drpy_js/时光影院.js', 1, 269, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (460, '2024-06-17 16:35:38', 1, '2024-07-21 07:00:47', 1, 0, '星辰[优]', 't4/files/drpy_js', 't4/files/drpy_js/星辰[优].js', 1, 454, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (222, '2024-05-11 18:12:59', 1, '2024-07-21 07:00:47', 1, 0, '橙汁影视', 't4/files/drpy_js', 't4/files/drpy_js/橙汁影视.js', 1, 216, '.js', NULL, 1, 0, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (250, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '烧火影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/烧火影视[优].js', 1, 244, '.js', NULL, 1, 0, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (368, '2024-06-09 11:52:40', 1, '2024-07-21 07:00:47', 1, 0, '爱上你听书网[听]', 't4/files/drpy_js', 't4/files/drpy_js/爱上你听书网[听].js', 1, 362, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (254, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '爱看机器人[虫]', 't4/files/drpy_js', 't4/files/drpy_js/爱看机器人[虫].js', 1, 248, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (243, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '百忙无果[官]', 't4/files/drpy_js', 't4/files/drpy_js/百忙无果[官].js', 1, 237, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (232, '2024-05-14 17:57:11', 1, '2024-07-21 07:00:47', 1, 0, '看57', 't4/files/drpy_js', 't4/files/drpy_js/看57.js', 1, 226, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (323, '2024-05-26 11:05:14', 1, '2024-07-21 07:00:47', 1, 0, '短剧天堂', 't4/files/drpy_js', 't4/files/drpy_js/短剧天堂.js', 1, 317, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (474, '2024-06-21 08:12:29', 1, '2024-07-21 07:00:47', 1, 0, '策驰影院(自动)', 't4/files/drpy_js', 't4/files/drpy_js/策驰影院(自动).js', 1, 468, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (239, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '素白白[优]', 't4/files/drpy_js', 't4/files/drpy_js/素白白[优].js', 1, 233, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (236, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '索尼资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/索尼资源[资].js', 1, 230, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (245, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '网飞猫[优]', 't4/files/drpy_js', 't4/files/drpy_js/网飞猫[优].js', 1, 239, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (221, '2024-05-11 14:54:31', 1, '2024-07-21 07:00:47', 1, 0, '美剧星球', 't4/files/drpy_js', 't4/files/drpy_js/美剧星球.js', 1, 215, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (292, '2024-05-16 17:25:50', 1, '2024-07-21 07:00:47', 1, 0, '美益达', 't4/files/drpy_js', 't4/files/drpy_js/美益达.js', 1, 286, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (475, '2024-06-21 08:12:29', 1, '2024-07-21 07:00:47', 1, 0, '豆角网', 't4/files/drpy_js', 't4/files/drpy_js/豆角网.js', 1, 469, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (481, '2024-06-22 11:02:20', 1, '2024-07-21 07:00:47', 1, 0, '贝乐虎[儿]', 't4/files/drpy_js', 't4/files/drpy_js/贝乐虎[儿].js', 1, 475, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (249, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '量子资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/量子资源[资].js', 1, 243, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (244, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '阿里土豆[盘]', 't4/files/drpy_js', 't4/files/drpy_js/阿里土豆[盘].js', 1, 238, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (238, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '非凡资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/非凡资源[资].js', 1, 232, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (382, '2024-06-09 18:53:00', 1, '2024-07-21 07:00:47', 1, 0, '顶点小说2[书]', 't4/files/drpy_js', 't4/files/drpy_js/顶点小说2[书].js', 1, 376, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (324, '2024-05-26 11:05:14', 1, '2024-07-21 07:00:47', 1, 0, '飘花影院', 't4/files/drpy_js', 't4/files/drpy_js/飘花影院.js', 1, 318, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (205, '2024-05-10 10:26:49', 1, '2024-07-21 07:00:47', 1, 0, 'test_node_rsa', 't4/files/drpy_libs', 't4/files/drpy_libs/test_node_rsa.mjs', 1, 199, '.mjs', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (488, '2024-06-27 06:14:29', 1, '2024-07-21 07:00:47', 1, 0, 'live2cms', 't4/files/json', 't4/files/json/live2cms.json', 1, 482, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (477, '2024-06-21 08:12:31', 1, '2024-07-21 07:00:48', 1, 0, '采集[密]静态', 't4/files/json', 't4/files/json/采集[密]静态.json', 1, 471, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (259, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, 'LIBVIO[优]', 't4/files/drpy_js', 't4/files/drpy_js/LIBVIO[优].js', 1, 253, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (235, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, 'ok资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/ok资源[资].js', 1, 229, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (286, '2024-05-16 08:22:11', 1, '2024-07-21 07:00:46', 1, 0, '人人影视', 't4/files/drpy_js', 't4/files/drpy_js/人人影视.js', 1, 280, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (473, '2024-06-21 08:12:29', 1, '2024-07-21 07:00:46', 1, 0, '剧哥哥', 't4/files/drpy_js', 't4/files/drpy_js/剧哥哥.js', 1, 467, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (397, '2024-06-13 04:47:01', 1, '2024-07-21 07:00:46', 1, 0, '剧圈圈[自动]', 't4/files/drpy_js', 't4/files/drpy_js/剧圈圈[自动].js', 1, 391, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (456, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '七色番[漫]', 't4/files/drpy_js', 't4/files/drpy_js/七色番[漫].js', 1, 450, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (262, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '优酷[官]', 't4/files/drpy_js', 't4/files/drpy_js/优酷[官].js', 1, 256, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (501, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '冠建影视', 't4/files/drpy_js', 't4/files/drpy_js/冠建影视.js', 1, 495, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (465, '2024-06-18 16:03:22', 1, '2024-07-21 07:00:46', 1, 0, '刺猬影视', 't4/files/drpy_js', 't4/files/drpy_js/刺猬影视.js', 1, 459, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (416, '2024-06-15 06:37:46', 1, '2024-07-21 07:00:46', 1, 0, '剧集TV', 't4/files/drpy_js', 't4/files/drpy_js/剧集TV.js', 1, 410, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (454, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '包子漫画[画]', 't4/files/drpy_js', 't4/files/drpy_js/包子漫画[画].js', 1, 448, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (455, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '古风漫画[画]', 't4/files/drpy_js', 't4/files/drpy_js/古风漫画[画].js', 1, 449, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (218, '2024-05-10 18:07:08', 1, '2024-07-21 07:00:46', 1, 0, '可达影视', 't4/files/drpy_js', 't4/files/drpy_js/可达影视.js', 1, 212, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (263, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '哔哩影视[官]', 't4/files/drpy_js', 't4/files/drpy_js/哔哩影视[官].js', 1, 257, '.js', '?render=1', 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (443, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '哔哩直播[官]', 't4/files/drpy_js', 't4/files/drpy_js/哔哩直播[官].js', 1, 437, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (413, '2024-06-15 06:37:45', 1, '2024-07-21 07:00:46', 1, 0, '大师兄影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/大师兄影视[优].js', 1, 407, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (321, '2024-05-25 15:45:01', 1, '2024-07-21 07:00:46', 1, 0, '如意影视', 't4/files/drpy_js', 't4/files/drpy_js/如意影视.js', 1, 315, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (497, '2024-06-28 17:29:38', 1, '2024-07-21 07:00:47', 1, 0, '悠悠影视', 't4/files/drpy_js', 't4/files/drpy_js/悠悠影视.js', 1, 491, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (227, '2024-05-12 19:13:04', 1, '2024-07-21 07:00:47', 1, 0, '掌心世界', 't4/files/drpy_js', 't4/files/drpy_js/掌心世界.js', 1, 221, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (466, '2024-06-19 03:46:08', 1, '2024-07-21 07:00:47', 1, 0, '文才[资]', 't4/files/drpy_js', 't4/files/drpy_js/文才[资].js', 1, 460, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (503, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '旺旺影视', 't4/files/drpy_js', 't4/files/drpy_js/旺旺影视.js', 1, 497, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (458, '2024-06-17 16:35:38', 1, '2024-07-21 07:00:47', 1, 0, '有声听书网[听]', 't4/files/drpy_js', 't4/files/drpy_js/有声听书网[听].js', 1, 452, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (370, '2024-06-09 11:52:40', 1, '2024-07-21 07:00:47', 1, 0, '有声绘本网[听]', 't4/files/drpy_js', 't4/files/drpy_js/有声绘本网[听].js', 1, 364, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (265, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '极速资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/极速资源[资].js', 1, 259, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (498, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '爱你短剧', 't4/files/drpy_js', 't4/files/drpy_js/爱你短剧.js', 1, 492, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (399, '2024-06-13 09:30:12', 1, '2024-07-21 07:00:47', 1, 0, '爱爱影院[密]', 't4/files/drpy_js', 't4/files/drpy_js/爱爱影院[密].js', 1, 393, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (258, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '玩偶哥哥[盘]', 't4/files/drpy_js', 't4/files/drpy_js/玩偶哥哥[盘].js', 1, 252, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (277, '2024-05-15 10:03:27', 1, '2024-07-21 07:00:47', 1, 0, '皮皮影视', 't4/files/drpy_js', 't4/files/drpy_js/皮皮影视.js', 1, 271, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (527, '2024-06-29 18:48:15', 1, '2024-07-21 07:00:47', 1, 0, '看了么', 't4/files/drpy_js', 't4/files/drpy_js/看了么.js', 1, 521, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (414, '2024-06-15 06:37:45', 1, '2024-07-21 07:00:47', 1, 0, '看戏网', 't4/files/drpy_js', 't4/files/drpy_js/看戏网.js', 1, 408, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (402, '2024-06-13 09:30:13', 1, '2024-07-21 07:00:47', 1, 0, '绿色仓库[密]', 't4/files/drpy_js', 't4/files/drpy_js/绿色仓库[密].js', 1, 396, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (531, '2024-06-30 11:28:13', 1, '2024-07-21 07:00:47', 1, 0, '老白故事[听]', 't4/files/drpy_js', 't4/files/drpy_js/老白故事[听].js', 1, 525, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (300, '2024-05-22 15:37:30', 1, '2024-07-21 07:00:47', 1, 0, '茶语资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/茶语资源[资].js', 1, 294, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (341, '2024-05-29 09:43:51', 1, '2024-07-21 07:00:47', 1, 0, '蚂蚁影视', 't4/files/drpy_js', 't4/files/drpy_js/蚂蚁影视.js', 1, 335, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (359, '2024-06-07 10:19:39', 1, '2024-07-21 07:00:47', 1, 0, '蜡笔[盘]', 't4/files/drpy_js', 't4/files/drpy_js/蜡笔[盘].js', 1, 353, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (476, '2024-06-21 08:12:30', 1, '2024-07-21 07:00:47', 1, 0, '西瓜影院', 't4/files/drpy_js', 't4/files/drpy_js/西瓜影院.js', 1, 470, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (419, '2024-06-15 06:37:46', 1, '2024-07-21 07:00:47', 1, 0, '速播小屋', 't4/files/drpy_js', 't4/files/drpy_js/速播小屋.js', 1, 413, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (247, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '金鹰资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/金鹰资源[资].js', 1, 241, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (535, '2024-07-03 09:40:12', 1, '2024-07-21 07:00:47', 1, 0, '飞鱼影视', 't4/files/drpy_js', 't4/files/drpy_js/飞鱼影视.js', 1, 529, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (493, '2024-06-28 17:29:38', 1, '2024-07-21 07:00:47', 1, 0, '饭团影视', 't4/files/drpy_js', 't4/files/drpy_js/饭团影视.js', 1, 487, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (252, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '魔都资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/魔都资源[资].js', 1, 246, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (169, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:47', 1, 0, 'jsrsa', 't4/files/drpy_libs', 't4/files/drpy_libs/jsrsa.js', 1, 163, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (487, '2024-06-27 06:14:29', 1, '2024-07-21 07:00:47', 1, 0, 'live_cntv', 't4/files/json', 't4/files/json/live_cntv.txt', 1, 481, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (298, '2024-05-19 02:54:49', 1, '2024-07-21 07:00:48', 1, 0, 'pg.jar', 't4/files/jar', 't4/files/jar/pg.jar.md5', 1, 292, '.md5', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (450, '2024-06-17 16:35:37', 1, '2024-07-21 07:00:46', 1, 0, '58动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/58动漫[漫].js', 1, 444, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (158, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:46', 1, 0, '777影视', 't4/files/drpy_js', 't4/files/drpy_js/777影视.js', 1, 152, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (508, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, 'auete', 't4/files/drpy_js', 't4/files/drpy_js/auete.js', 1, 502, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (392, '2024-06-12 02:16:52', 1, '2024-07-21 07:00:46', 1, 0, '一点视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/一点视频[密].js', 1, 386, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (417, '2024-06-15 06:37:46', 1, '2024-07-21 07:00:46', 1, 0, '一起看[优]', 't4/files/drpy_js', 't4/files/drpy_js/一起看[优].js', 1, 411, '.js', NULL, 1, 0, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (482, '2024-06-22 13:52:23', 1, '2024-07-21 07:00:46', 1, 0, 'KTV歌厅[听]', 't4/files/drpy_js', 't4/files/drpy_js/KTV歌厅[听].js', 1, 476, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (403, '2024-06-13 09:30:13', 1, '2024-07-21 07:00:46', 1, 0, 'Pornhub[密]', 't4/files/drpy_js', 't4/files/drpy_js/Pornhub[密].js', 1, 397, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (479, '2024-06-21 09:37:59', 1, '2024-07-21 07:00:46', 1, 0, 'script直播[飞]', 't4/files/drpy_js', 't4/files/drpy_js/script直播[飞].js', 1, 473, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (533, '2024-07-01 03:04:35', 1, '2024-07-21 07:00:46', 1, 0, '世纪DJ音乐网[听]', 't4/files/drpy_js', 't4/files/drpy_js/世纪DJ音乐网[听].js', 1, 527, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (404, '2024-06-13 09:30:13', 1, '2024-07-21 07:00:46', 1, 0, '乐草TV[密]', 't4/files/drpy_js', 't4/files/drpy_js/乐草TV[密].js', 1, 398, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (514, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '你好帅影院', 't4/files/drpy_js', 't4/files/drpy_js/你好帅影院.js', 1, 508, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (260, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '兔小贝[儿]', 't4/files/drpy_js', 't4/files/drpy_js/兔小贝[儿].js', 1, 254, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (507, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '刷剧网', 't4/files/drpy_js', 't4/files/drpy_js/刷剧网.js', 1, 501, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (484, '2024-06-23 07:44:50', 1, '2024-07-21 07:00:46', 1, 0, '啊哈DJ[听]', 't4/files/drpy_js', 't4/files/drpy_js/啊哈DJ[听].js', 1, 478, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (408, '2024-06-14 11:29:46', 1, '2024-07-21 07:00:46', 1, 0, '地瓜视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/地瓜视频[密].js', 1, 402, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (421, '2024-06-15 07:26:03', 1, '2024-07-21 07:00:46', 1, 0, '天天影视', 't4/files/drpy_js', 't4/files/drpy_js/天天影视.js', 1, 415, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (293, '2024-05-17 03:38:35', 1, '2024-07-21 07:00:47', 1, 0, '干饭影视', 't4/files/drpy_js', 't4/files/drpy_js/干饭影视.js', 1, 287, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (278, '2024-05-15 14:55:44', 1, '2024-07-21 07:00:47', 1, 0, '影视看吧', 't4/files/drpy_js', 't4/files/drpy_js/影视看吧.js', 1, 272, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (310, '2024-05-24 11:27:11', 1, '2024-07-21 07:00:47', 1, 0, '往往影视[慢]', 't4/files/drpy_js', 't4/files/drpy_js/往往影视[慢].js', 1, 304, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (325, '2024-05-26 11:05:14', 1, '2024-07-21 07:00:47', 1, 0, '我播', 't4/files/drpy_js', 't4/files/drpy_js/我播.js', 1, 319, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (306, '2024-05-23 10:17:08', 1, '2024-07-21 07:00:47', 1, 0, '新视觉', 't4/files/drpy_js', 't4/files/drpy_js/新视觉.js', 1, 300, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (373, '2024-06-09 11:52:40', 1, '2024-07-21 07:00:47', 1, 0, '有声小说吧[听]', 't4/files/drpy_js', 't4/files/drpy_js/有声小说吧[听].js', 1, 367, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (511, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '毒蛇电影[优]', 't4/files/drpy_js', 't4/files/drpy_js/毒蛇电影[优].js', 1, 505, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (311, '2024-05-24 11:27:11', 1, '2024-07-21 07:00:47', 1, 0, '爱看影院', 't4/files/drpy_js', 't4/files/drpy_js/爱看影院.js', 1, 305, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (301, '2024-05-22 15:37:30', 1, '2024-07-21 07:00:47', 1, 0, '电影先生', 't4/files/drpy_js', 't4/files/drpy_js/电影先生.js', 1, 295, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (351, '2024-06-04 16:02:34', 1, '2024-07-21 07:00:47', 1, 0, '短剧在线', 't4/files/drpy_js', 't4/files/drpy_js/短剧在线.js', 1, 345, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (409, '2024-06-14 11:29:46', 1, '2024-07-21 07:00:47', 1, 0, '神仙影视', 't4/files/drpy_js', 't4/files/drpy_js/神仙影视.js', 1, 403, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (528, '2024-06-29 18:48:15', 1, '2024-07-21 07:00:47', 1, 0, '童趣[儿]', 't4/files/drpy_js', 't4/files/drpy_js/童趣[儿].js', 1, 522, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (525, '2024-06-29 18:48:15', 1, '2024-07-21 07:00:47', 1, 0, '笔趣阁13[书]', 't4/files/drpy_js', 't4/files/drpy_js/笔趣阁13[书].js', 1, 519, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (483, '2024-06-23 07:44:50', 1, '2024-07-21 07:00:47', 1, 0, '网飞.TV', 't4/files/drpy_js', 't4/files/drpy_js/网飞.TV.js', 1, 477, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (505, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '网飞啦[自动]', 't4/files/drpy_js', 't4/files/drpy_js/网飞啦[自动].js', 1, 499, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (261, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '花子动漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/花子动漫[漫].js', 1, 255, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (401, '2024-06-13 09:30:13', 1, '2024-07-21 07:00:47', 1, 0, '草莓秒播[密]', 't4/files/drpy_js', 't4/files/drpy_js/草莓秒播[密].js', 1, 395, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (264, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '菜狗[官]', 't4/files/drpy_js', 't4/files/drpy_js/菜狗[官].js', 1, 258, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (340, '2024-05-29 09:43:51', 1, '2024-07-21 07:00:47', 1, 0, '被窝电影', 't4/files/drpy_js', 't4/files/drpy_js/被窝电影.js', 1, 334, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (426, '2024-06-17 10:13:18', 1, '2024-07-21 07:00:47', 1, 0, '追剧兔', 't4/files/drpy_js', 't4/files/drpy_js/追剧兔.js', 1, 420, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (313, '2024-05-24 11:27:11', 1, '2024-07-21 07:00:47', 1, 0, '首发网', 't4/files/drpy_js', 't4/files/drpy_js/首发网.js', 1, 307, '.js', NULL, 1, 0, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (309, '2024-05-24 11:27:11', 1, '2024-07-21 07:00:47', 1, 0, '魔方影视', 't4/files/drpy_js', 't4/files/drpy_js/魔方影视.js', 1, 303, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (305, '2024-05-22 15:37:31', 1, '2024-07-21 07:00:47', 1, 0, 'jsonpathplus.min', 't4/files/drpy_libs', 't4/files/drpy_libs/jsonpathplus.min.js', 1, 299, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (489, '2024-06-28 03:59:52', 1, '2024-07-21 07:00:47', 1, 0, 'live_1905', 't4/files/json', 't4/files/json/live_1905.txt', 1, 483, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (297, '2024-05-19 02:54:49', 1, '2024-07-21 07:00:48', 1, 0, 'tokenm.readme', 't4/files/json', 't4/files/json/tokenm.readme.txt', 1, 291, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (470, '2024-06-20 08:09:36', 1, '2024-07-21 07:00:48', 1, 0, '采集', 't4/files/json', 't4/files/json/采集.json', 1, 464, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (478, '2024-06-21 08:12:31', 1, '2024-07-21 07:00:48', 1, 0, '采集[密]', 't4/files/json', 't4/files/json/采集[密].json', 1, 472, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (471, '2024-06-21 03:08:09', 1, '2024-07-21 07:00:48', 1, 0, '采集静态', 't4/files/json', 't4/files/json/采集静态.json', 1, 465, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (526, '2024-06-29 18:48:15', 1, '2024-07-21 07:00:46', 1, 0, '360吧[球]', 't4/files/drpy_js', 't4/files/drpy_js/360吧[球].js', 1, 520, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (290, '2024-05-16 10:22:36', 1, '2024-07-21 07:00:46', 1, 0, '4khdr', 't4/files/drpy_js', 't4/files/drpy_js/4khdr.js', 1, 284, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (307, '2024-05-24 05:50:49', 1, '2024-07-21 07:00:46', 1, 0, '4k剧院', 't4/files/drpy_js', 't4/files/drpy_js/4k剧院.js', 1, 301, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (299, '2024-05-22 15:37:30', 1, '2024-07-21 07:00:46', 1, 0, '8号影院', 't4/files/drpy_js', 't4/files/drpy_js/8号影院.js', 1, 293, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (485, '2024-06-23 07:44:50', 1, '2024-07-21 07:00:46', 1, 0, 'ASMR[听]', 't4/files/drpy_js', 't4/files/drpy_js/ASMR[听].js', 1, 479, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (524, '2024-06-28 17:29:40', 1, '2024-07-21 07:00:46', 1, 0, '咖啡影视', 't4/files/drpy_js', 't4/files/drpy_js/咖啡影视.js', 1, 518, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (352, '2024-06-04 16:02:34', 1, '2024-07-21 07:00:46', 1, 0, '哈皮影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/哈皮影视[优].js', 1, 346, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (315, '2024-05-24 15:02:58', 1, '2024-07-21 07:00:46', 1, 0, '大中国', 't4/files/drpy_js', 't4/files/drpy_js/大中国.js', 1, 309, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (517, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '大千视界', 't4/files/drpy_js', 't4/files/drpy_js/大千视界.js', 1, 511, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (536, '2024-07-03 09:40:13', 1, '2024-07-21 07:00:46', 1, 0, '天龙影院', 't4/files/drpy_js', 't4/files/drpy_js/天龙影院.js', 1, 530, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (521, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '奈飞中文[自动]', 't4/files/drpy_js', 't4/files/drpy_js/奈飞中文[自动].js', 1, 515, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (512, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '小女18[密]', 't4/files/drpy_js', 't4/files/drpy_js/小女18[密].js', 1, 506, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (342, '2024-05-29 16:32:00', 1, '2024-07-21 07:00:47', 1, 0, '影搜[搜]', 't4/files/drpy_js', 't4/files/drpy_js/影搜[搜].js', 1, 336, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (502, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '影渣渣影视', 't4/files/drpy_js', 't4/files/drpy_js/影渣渣影视.js', 1, 496, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (513, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '易点看影院[自动]', 't4/files/drpy_js', 't4/files/drpy_js/易点看影院[自动].js', 1, 507, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (230, '2024-05-14 08:53:58', 1, '2024-07-21 07:00:47', 1, 0, '易看影视', 't4/files/drpy_js', 't4/files/drpy_js/易看影视.js', 1, 224, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (406, '2024-06-14 11:29:44', 1, '2024-07-21 07:00:47', 1, 0, '星辰CT', 't4/files/drpy_js', 't4/files/drpy_js/星辰CT.js', 1, 400, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (314, '2024-05-24 15:02:58', 1, '2024-07-21 07:00:47', 1, 0, '星辰影视', 't4/files/drpy_js', 't4/files/drpy_js/星辰影视.js', 1, 308, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (510, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '映播TV', 't4/files/drpy_js', 't4/files/drpy_js/映播TV.js', 1, 504, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (339, '2024-05-29 09:43:50', 1, '2024-07-21 07:00:47', 1, 0, '暖光影视', 't4/files/drpy_js', 't4/files/drpy_js/暖光影视.js', 1, 333, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (500, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '来看点播[自动]', 't4/files/drpy_js', 't4/files/drpy_js/来看点播[自动].js', 1, 494, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (486, '2024-06-27 06:14:27', 1, '2024-07-21 07:00:47', 1, 0, '直播转点播[合]', 't4/files/drpy_js', 't4/files/drpy_js/直播转点播[合].js', 1, 480, '.js', '?type=url&params=../json/live2cms.json', 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (317, '2024-05-24 15:02:59', 1, '2024-07-21 07:00:47', 1, 0, '短剧TV网', 't4/files/drpy_js', 't4/files/drpy_js/短剧TV网.js', 1, 311, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (504, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '神马影院[自动]', 't4/files/drpy_js', 't4/files/drpy_js/神马影院[自动].js', 1, 498, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (233, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '神马电影[搜]', 't4/files/drpy_js', 't4/files/drpy_js/神马电影[搜].js', 1, 227, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (266, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:47', 1, 0, '荐片[优]', 't4/files/drpy_js', 't4/files/drpy_js/荐片[优].js', 1, 260, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (360, '2024-06-07 11:27:00', 1, '2024-07-21 07:00:47', 1, 0, '虾酱追剧', 't4/files/drpy_js', 't4/files/drpy_js/虾酱追剧.js', 1, 354, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (530, '2024-06-29 18:48:15', 1, '2024-07-21 07:00:47', 1, 0, '路漫漫[漫]', 't4/files/drpy_js', 't4/files/drpy_js/路漫漫[漫].js', 1, 524, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (464, '2024-06-18 16:03:22', 1, '2024-07-21 07:00:47', 1, 0, '路视频[密]', 't4/files/drpy_js', 't4/files/drpy_js/路视频[密].js', 1, 458, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (405, '2024-06-13 09:57:03', 1, '2024-07-21 07:00:47', 1, 0, '酷云影视', 't4/files/drpy_js', 't4/files/drpy_js/酷云影视.js', 1, 399, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (375, '2024-06-09 16:28:15', 1, '2024-07-21 07:00:47', 1, 0, '顶点小说[书]', 't4/files/drpy_js', 't4/files/drpy_js/顶点小说[书].js', 1, 369, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (461, '2024-06-17 16:45:34', 1, '2024-07-21 07:00:47', 1, 0, '飞刀资源[资]', 't4/files/drpy_js', 't4/files/drpy_js/飞刀资源[资].js', 1, 455, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (522, '2024-06-28 17:29:40', 1, '2024-07-21 07:00:47', 1, 0, '饺子影院', 't4/files/drpy_js', 't4/files/drpy_js/饺子影院.js', 1, 516, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (302, '2024-05-22 15:37:30', 1, '2024-07-21 07:00:47', 1, 0, '鸭奈飞影视', 't4/files/drpy_js', 't4/files/drpy_js/鸭奈飞影视.js', 1, 296, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (304, '2024-05-22 15:37:30', 1, '2024-07-21 07:00:47', 1, 0, 'jinja', 't4/files/drpy_libs', 't4/files/drpy_libs/jinja.js', 1, 298, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (303, '2024-05-22 15:37:30', 1, '2024-07-21 07:00:47', 1, 0, 'jinja.min', 't4/files/drpy_libs', 't4/files/drpy_libs/jinja.min.js', 1, 297, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (532, '2024-07-01 01:07:47', 1, '2024-07-21 07:00:47', 1, 0, 'node-rsa-new', 't4/files/drpy_libs', 't4/files/drpy_libs/node-rsa-new.js', 1, 526, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (490, '2024-06-28 08:41:05', 1, '2024-07-21 07:00:47', 1, 0, 'lives', 't4/files/json', 't4/files/json/lives.jpg', 1, 484, '.jpg', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (537, '2024-07-04 07:36:34', 1, '2024-07-21 07:00:48', 1, 0, '采集[zy]静态', 't4/files/json', 't4/files/json/采集[zy]静态.json', 1, 531, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (472, '2024-06-21 03:08:09', 1, '2024-07-21 07:00:48', 1, 0, '采集分类生成器', 't4/files/json', 't4/files/json/采集分类生成器.py', 1, 466, '.py', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (217, '2024-05-10 18:07:08', 1, '2024-07-21 07:00:46', 1, 0, '一起看', 't4/files/drpy_js', 't4/files/drpy_js/一起看.js', 1, 211, '.js', NULL, 1, 0, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (378, '2024-06-09 18:53:00', 1, '2024-07-21 07:00:46', 1, 0, '丫丫电子书[书]', 't4/files/drpy_js', 't4/files/drpy_js/丫丫电子书[书].js', 1, 372, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (394, '2024-06-12 02:16:53', 1, '2024-07-21 07:00:46', 1, 0, '九妖仓库[密]', 't4/files/drpy_js', 't4/files/drpy_js/九妖仓库[密].js', 1, 388, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (316, '2024-05-24 15:02:59', 1, '2024-07-21 07:00:46', 1, 0, '剧圈圈', 't4/files/drpy_js', 't4/files/drpy_js/剧圈圈.js', 1, 310, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (509, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '剧迷', 't4/files/drpy_js', 't4/files/drpy_js/剧迷.js', 1, 503, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (550, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:46', 1, 0, '兄弟影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/兄弟影视[优].js', 1, 544, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (480, '2024-06-21 18:04:29', 1, '2024-07-21 07:00:46', 1, 0, '分享短视频', 't4/files/drpy_js', 't4/files/drpy_js/分享短视频.js', 1, 474, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (552, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:46', 1, 0, '哔嘀影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/哔嘀影视[优].js', 1, 546, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (554, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:46', 1, 0, '小白菜电影', 't4/files/drpy_js', 't4/files/drpy_js/小白菜电影.js', 1, 548, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (557, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '我爱跟剧', 't4/files/drpy_js', 't4/files/drpy_js/我爱跟剧.js', 1, 551, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (468, '2024-06-20 05:33:14', 1, '2024-07-21 07:00:47', 1, 0, 'drpy_libs', 't4/files/drpy_libs', 't4/files/drpy_libs/drpy_libs.zip', 1, 462, '.zip', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (539, '2024-07-04 07:36:34', 1, '2024-07-21 07:00:48', 1, 0, '采集[zy]', 't4/files/json', 't4/files/json/采集[zy].json', 1, 533, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (538, '2024-07-04 07:36:34', 1, '2024-07-21 07:00:48', 1, 0, '采集转换器', 't4/files/json', 't4/files/json/采集转换器.py', 1, 532, '.py', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (1, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:45', 1, 0, 'ad', 't4/spiders', 't4/spiders/ad.m3u8', 1, 9999, '.m3u8', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (2, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, 'base_java_loader', 't4/spiders', 't4/spiders/base_java_loader.py', 1, 0, '.py', NULL, 1, 1, 1, 0, 0);
INSERT INTO `t_vod_rules` VALUES (3, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, 'base_spider', 't4/spiders', 't4/spiders/base_spider.json', 1, 9999, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (14, '2024-02-01 14:31:22', 1, '2024-07-21 07:00:46', 1, 0, '樱花动漫', 't4/spiders', 't4/spiders/樱花动漫.py', 1, 14, '.py', 'https://jihulab.com/qiaoji/open/-/raw/main/yinghua', 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (400, '2024-06-13 09:30:12', 1, '2024-07-21 07:00:46', 1, 0, '29片库[密]', 't4/files/drpy_js', 't4/files/drpy_js/29片库[密].js', 1, 394, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (540, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, '348电影网', 't4/files/drpy_js', 't4/files/drpy_js/348电影网.js', 1, 534, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (241, '2024-05-15 01:58:31', 1, '2024-07-21 07:00:46', 1, 0, '360影视[官]', 't4/files/drpy_js', 't4/files/drpy_js/360影视[官].js', 1, 235, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (529, '2024-06-29 18:48:15', 1, '2024-07-21 07:00:46', 1, 0, '36直播[密]', 't4/files/drpy_js', 't4/files/drpy_js/36直播[密].js', 1, 523, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (541, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, '420电影院', 't4/files/drpy_js', 't4/files/drpy_js/420电影院.jsd', 1, 535, '.jsd', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (542, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, '4K-AV', 't4/files/drpy_js', 't4/files/drpy_js/4K-AV.js', 1, 536, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (543, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, '539影视', 't4/files/drpy_js', 't4/files/drpy_js/539影视.js', 1, 537, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (56, '2024-02-02 16:38:12', 1, '2024-07-21 07:00:46', 1, 0, '555影视[飞]', 't4/files/drpy_js', 't4/files/drpy_js/555影视[飞].js', 1, 56, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (356, '2024-06-06 09:12:14', 1, '2024-07-21 07:00:46', 1, 0, '7猫小说[书]', 't4/files/drpy_js', 't4/files/drpy_js/7猫小说[书].js', 1, 350, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (544, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, 'B站影视', 't4/files/drpy_js', 't4/files/drpy_js/B站影视.js', 1, 538, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (545, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, 'FreeOKLOL', 't4/files/drpy_js', 't4/files/drpy_js/FreeOKLOL.js', 1, 539, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (420, '2024-06-15 06:37:46', 1, '2024-07-21 07:00:46', 1, 0, 'iku喵[资]', 't4/files/drpy_js', 't4/files/drpy_js/iku喵[资].js', 1, 414, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (546, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, 'PTT[优]', 't4/files/drpy_js', 't4/files/drpy_js/PTT[优].js', 1, 540, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (547, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, 'PTT追剧大师', 't4/files/drpy_js', 't4/files/drpy_js/PTT追剧大师.js', 1, 541, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (312, '2024-05-24 11:27:11', 1, '2024-07-21 07:00:46', 1, 0, '一号影院[搜]', 't4/files/drpy_js', 't4/files/drpy_js/一号影院[搜].js', 1, 306, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (463, '2024-06-18 16:03:22', 1, '2024-07-21 07:00:46', 1, 0, '七新电影网', 't4/files/drpy_js', 't4/files/drpy_js/七新电影网.js', 1, 457, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (499, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '三集电影[自动]', 't4/files/drpy_js', 't4/files/drpy_js/三集电影[自动].js', 1, 493, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (548, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, '两个BT', 't4/files/drpy_js', 't4/files/drpy_js/两个BT.js', 1, 542, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (422, '2024-06-15 07:26:04', 1, '2024-07-21 07:00:46', 1, 0, '九牛电影', 't4/files/drpy_js', 't4/files/drpy_js/九牛电影.js', 1, 416, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (549, '2024-07-11 04:24:57', 1, '2024-07-21 07:00:46', 1, 0, '低端', 't4/files/drpy_js', 't4/files/drpy_js/低端.js', 1, 543, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (551, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:46', 1, 0, '北川影视', 't4/files/drpy_js', 't4/files/drpy_js/北川影视.js', 1, 545, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (506, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:46', 1, 0, '嘀哩嘀哩', 't4/files/drpy_js', 't4/files/drpy_js/嘀哩嘀哩.js', 1, 500, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (553, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:46', 1, 0, '宇航影视', 't4/files/drpy_js', 't4/files/drpy_js/宇航影视.js', 1, 547, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (555, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '影视工厂', 't4/files/drpy_js', 't4/files/drpy_js/影视工厂.js', 1, 549, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (556, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '影视工场', 't4/files/drpy_js', 't4/files/drpy_js/影视工场.js', 1, 550, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (563, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '爱优影视[自动]', 't4/files/drpy_js', 't4/files/drpy_js/爱优影视[自动].js', 1, 557, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (520, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '看客视频', 't4/files/drpy_js', 't4/files/drpy_js/看客视频.js', 1, 514, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (353, '2024-06-04 16:02:34', 1, '2024-07-21 07:00:47', 1, 0, '笔趣阁[书]', 't4/files/drpy_js', 't4/files/drpy_js/笔趣阁[书].js', 1, 347, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (534, '2024-07-02 09:37:40', 1, '2024-07-21 07:00:47', 1, 0, '闪雷电', 't4/files/drpy_js', 't4/files/drpy_js/闪雷电.js', 1, 528, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (491, '2024-06-28 17:29:38', 1, '2024-07-21 07:00:47', 1, 0, '飞狗影院[密]', 't4/files/drpy_js', 't4/files/drpy_js/飞狗影院[密].js', 1, 485, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (398, '2024-06-13 09:30:12', 1, '2024-07-21 07:00:47', 1, 0, '黑料不打烊[密]', 't4/files/drpy_js', 't4/files/drpy_js/黑料不打烊[密].js', 1, 392, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (523, '2024-06-28 17:29:40', 1, '2024-07-21 07:00:47', 1, 0, '无忧影视', 't4/files/drpy_js', 't4/files/drpy_js/无忧影视.js', 1, 517, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (558, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '星芽短剧[优]', 't4/files/drpy_js', 't4/files/drpy_js/星芽短剧[优].js', 1, 552, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (562, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '火狐影视', 't4/files/drpy_js', 't4/files/drpy_js/火狐影视.js', 1, 556, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (567, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '至臻[盘]', 't4/files/drpy_js', 't4/files/drpy_js/至臻[盘].js', 1, 561, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (172, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:47', 1, 0, 'jsencrypt', 't4/files/drpy_libs', 't4/files/drpy_libs/jsencrypt.js', 1, 166, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (559, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '朴樱影视', 't4/files/drpy_js', 't4/files/drpy_js/朴樱影视.js', 1, 553, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (560, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '桃子影视[优]', 't4/files/drpy_js', 't4/files/drpy_js/桃子影视[优].js', 1, 554, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (565, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '爱迪影视', 't4/files/drpy_js', 't4/files/drpy_js/爱迪影视.js', 1, 559, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (94, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'cilixiongp', 't4/files/drpy3_js', 't4/files/drpy3_js/cilixiongp.js', 1, 88, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (115, '2024-03-10 11:22:54', 1, '2024-07-21 07:00:48', 1, 0, 'template', 't4/files/drpy3_js', 't4/files/drpy3_js/template.js', 0, 109, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (561, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '樱花影视', 't4/files/drpy_js', 't4/files/drpy_js/樱花影视.jsd', 1, 555, '.jsd', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (518, '2024-06-28 17:29:39', 1, '2024-07-21 07:00:47', 1, 0, '游子视频', 't4/files/drpy_js', 't4/files/drpy_js/游子视频.js', 1, 512, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (469, '2024-06-20 08:09:35', 1, '2024-07-21 07:00:47', 1, 0, '采集之王[合]', 't4/files/drpy_js', 't4/files/drpy_js/采集之王[合].js', 1, 463, '.js', '?type=url&params=../json/采集静态.json$1@采王道长[合]\n?type=url&params=../json/采集[zy]静态.json$1@采王zy[密]\n?type=url&params=../json/采集[密]静态.json@采王成人[密]', 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (588, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:47', 1, 0, '萌番[漫]', 't4/files/drpy_js', 't4/files/drpy_js/萌番[漫].js', 1, 582, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (593, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:48', 1, 0, 'robots', 't4/files/txt', 't4/files/txt/robots.txt', 1, 587, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (224, '2024-05-11 18:13:00', 1, '2024-07-21 07:00:48', 1, 0, '白嫖影视', 't4/files/drpy3_js', 't4/files/drpy3_js/白嫖影视.js', 1, 218, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (582, '2024-07-21 06:28:37', 1, '2024-07-21 07:00:47', 1, 0, '文才2[资]', 't4/files/drpy_js', 't4/files/drpy_js/文才2[资].js', 1, 576, '.js', NULL, 1, 1, 0, 1, 1);
INSERT INTO `t_vod_rules` VALUES (583, '2024-07-21 06:28:37', 1, '2024-07-21 07:00:47', 1, 0, '旋风视频', 't4/files/drpy_js', 't4/files/drpy_js/旋风视频.js', 1, 577, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (331, '2024-05-27 12:03:03', 1, '2024-07-21 07:00:47', 1, 0, '爱看农民2[优]', 't4/files/drpy_js', 't4/files/drpy_js/爱看农民2[优].js', 1, 325, '.js', NULL, 1, 1, 1, 1, 1);
INSERT INTO `t_vod_rules` VALUES (564, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '爱看短剧[盘]', 't4/files/drpy_js', 't4/files/drpy_js/爱看短剧[盘].js', 1, 558, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (428, '2024-06-17 16:02:19', 1, '2024-07-21 07:00:47', 1, 0, '猫视界', 't4/files/drpy_js', 't4/files/drpy_js/猫视界.js', 1, 422, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (584, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:47', 1, 0, '番号资源[密]', 't4/files/drpy_js', 't4/files/drpy_js/番号资源[密].js', 1, 578, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (585, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:47', 1, 0, '种子音乐[听]', 't4/files/drpy_js', 't4/files/drpy_js/种子音乐[听].js', 1, 579, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (566, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '米爱影视', 't4/files/drpy_js', 't4/files/drpy_js/米爱影视.js', 1, 560, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (586, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:47', 1, 0, '臭蛋蛋', 't4/files/drpy_js', 't4/files/drpy_js/臭蛋蛋.js', 1, 580, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (587, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:47', 1, 0, '色库[密]', 't4/files/drpy_js', 't4/files/drpy_js/色库[密].js', 1, 581, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (568, '2024-07-11 04:24:58', 1, '2024-07-21 07:00:47', 1, 0, '达达龟', 't4/files/drpy_js', 't4/files/drpy_js/达达龟.js', 1, 562, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (589, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:47', 1, 0, '速讯影院', 't4/files/drpy_js', 't4/files/drpy_js/速讯影院.js', 1, 583, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (590, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:47', 1, 0, '那兔视频', 't4/files/drpy_js', 't4/files/drpy_js/那兔视频.js', 1, 584, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (280, '2024-05-16 08:22:11', 1, '2024-07-21 07:00:47', 1, 0, '酷客影视', 't4/files/drpy_js', 't4/files/drpy_js/酷客影视.js', 1, 274, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (572, '2024-07-13 13:30:35', 1, '2024-07-21 07:00:47', 1, 0, '酷我听书[听]', 't4/files/drpy_js', 't4/files/drpy_js/酷我听书[听].js', 1, 566, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (569, '2024-07-13 13:30:34', 1, '2024-07-21 07:00:46', 1, 0, 'emby', 't4/spiders', 't4/spiders/emby.json', 1, 563, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (570, '2024-07-13 13:30:34', 1, '2024-07-21 07:00:46', 1, 0, 'emby', 't4/spiders', 't4/spiders/emby.py', 1, 564, '.py', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (577, '2024-07-21 06:28:37', 1, '2024-07-21 07:00:46', 1, 0, '01看球[球]', 't4/files/drpy_js', 't4/files/drpy_js/01看球[球].js', 1, 571, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (578, '2024-07-21 06:28:37', 1, '2024-07-21 07:00:46', 1, 0, '310直播[球]', 't4/files/drpy_js', 't4/files/drpy_js/310直播[球].js', 1, 572, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (574, '2024-07-17 12:40:20', 1, '2024-07-21 07:00:46', 1, 0, 'cally66', 't4/files/drpy_js', 't4/files/drpy_js/cally66.js', 1, 568, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (591, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:47', 1, 0, '金牌影院', 't4/files/drpy_js', 't4/files/drpy_js/金牌影院.js', 1, 585, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (573, '2024-07-13 13:30:36', 1, '2024-07-21 07:00:47', 1, 0, 'json5', 't4/files/drpy_libs', 't4/files/drpy_libs/json5.js', 1, 567, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (173, '2024-05-06 13:28:59', 1, '2024-07-21 07:00:47', 1, 0, 'alishare.ebook', 't4/files/json', 't4/files/json/alishare.ebook.txt', 1, 167, '.txt', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (576, '2024-07-17 12:40:23', 1, '2024-07-21 07:00:48', 1, 0, '哔哩大全', 't4/files/json', 't4/files/json/哔哩大全.json', 1, 570, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (592, '2024-07-21 06:28:38', 1, '2024-07-21 07:00:48', 1, 0, '哔哩教育', 't4/files/json', 't4/files/json/哔哩教育.json', 1, 586, '.json', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (579, '2024-07-21 06:28:37', 1, '2024-07-21 07:00:46', 1, 0, '一支穿云箭', 't4/files/drpy_js', 't4/files/drpy_js/一支穿云箭.js', 1, 573, '.js', NULL, 1, 1, 1, 0, 1);
INSERT INTO `t_vod_rules` VALUES (575, '2024-07-17 12:40:20', 1, '2024-07-21 07:00:46', 1, 0, '一曲肝肠断', 't4/files/drpy_js', 't4/files/drpy_js/一曲肝肠断.js', 1, 569, '.js', NULL, 1, 0, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (580, '2024-07-21 06:28:37', 1, '2024-07-21 07:00:46', 1, 0, '中华听书网[听]', 't4/files/drpy_js', 't4/files/drpy_js/中华听书网[听].js', 1, 574, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (581, '2024-07-21 06:28:37', 1, '2024-07-21 07:00:46', 1, 0, '咕咕番[漫]', 't4/files/drpy_js', 't4/files/drpy_js/咕咕番[漫].js', 1, 575, '.js', NULL, 1, 1, 0, 0, 1);
INSERT INTO `t_vod_rules` VALUES (571, '2024-07-13 13:30:35', 1, '2024-07-21 07:00:46', 1, 0, '喜马拉雅[听]', 't4/files/drpy_js', 't4/files/drpy_js/喜马拉雅[听].js', 1, 565, '.js', NULL, 1, 1, 0, 0, 1);

-- ----------------------------
-- Table structure for t_vod_subs
-- ----------------------------
DROP TABLE IF EXISTS `t_vod_subs`;
CREATE TABLE `t_vod_subs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '创建时间',
  `creator_id` int(11) NULL DEFAULT 0 COMMENT '创建人id',
  `modified_time` datetime(0) NULL DEFAULT current_timestamp(0) COMMENT '更新时间',
  `modifier_id` int(11) NULL DEFAULT 0 COMMENT '修改人id',
  `is_deleted` int(11) NULL DEFAULT 0 COMMENT '逻辑删除:0=未删除,1=删除',
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订阅名称',
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订阅代码',
  `reg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正则表达式',
  `status` int(11) NULL DEFAULT 0 COMMENT '状态',
  `mode` int(11) NULL DEFAULT 0 COMMENT '匹配模式:0正向匹配 1逆向排除',
  `due_time` datetime(0) NULL DEFAULT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ix_t_vod_subs_id`(`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_vod_subs
-- ----------------------------
INSERT INTO `t_vod_subs` VALUES (1, '2024-06-19 09:53:59', 1, '2024-06-19 09:53:59', 0, 0, '全部', 'dzyyds', '.*', 1, 0, NULL);
INSERT INTO `t_vod_subs` VALUES (3, '2024-06-19 10:06:27', 1, '2024-06-19 10:58:42', 1, 0, '不含18+', 'green1', '密', 1, 1, NULL);
INSERT INTO `t_vod_subs` VALUES (2, '2024-06-19 09:54:38', 1, '2024-06-19 10:59:24', 1, 0, '18+', 'yellow1', '密', 1, 0, '2024-12-16 17:54:36');
INSERT INTO `t_vod_subs` VALUES (4, '2024-06-20 02:08:06', 1, '2024-06-20 02:08:06', 0, 0, '官源', 'luNhHy', '官', 1, 0, NULL);
INSERT INTO `t_vod_subs` VALUES (5, '2024-06-25 15:12:57', 1, '2024-06-25 15:13:01', 1, 1, '测的', 'hkdYBC', '荐片', 1, 0, NULL);
INSERT INTO `t_vod_subs` VALUES (6, '2024-06-25 15:13:17', 1, '2024-06-25 15:13:23', 1, 1, '测的', '2ZkutD', '荐片', 1, 0, NULL);
INSERT INTO `t_vod_subs` VALUES (7, '2024-06-29 00:21:53', 1, '2024-06-29 01:32:13', 1, 0, '电视用', 'tv0001', '\\[[画书密慢盘搜]\\]|jsapi|原始|直播转点播v2', 1, 1, NULL);
INSERT INTO `t_vod_subs` VALUES (8, '2024-06-30 02:35:37', 1, '2024-07-02 03:16:07', 1, 0, 't4体验', 'wf4Hyy', '.*', 1, 0, '2024-07-04 00:00:00');
INSERT INTO `t_vod_subs` VALUES (9, '2024-07-03 04:24:34', 1, '2024-07-03 04:24:38', 1, 1, '测采集', 'qrlYm6', '.*', 1, 0, NULL);

SET FOREIGN_KEY_CHECKS = 1;

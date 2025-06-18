/*
 Navicat Premium Data Transfer

 Source Server         : aa
 Source Server Type    : MySQL
 Source Server Version : 50540 (5.5.40)
 Source Host           : localhost:3306
 Source Schema         : elem

 Target Server Type    : MySQL
 Target Server Version : 50540 (5.5.40)
 File Encoding         : 65001

 Date: 27/05/2025 10:48:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`
(
    `aid`               int(4)                                                 NOT NULL AUTO_INCREMENT COMMENT '用户id',
    `username`          varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
    `password`          varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
    `security_question` text CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL COMMENT '密保问题',
    `security_answer`   text CHARACTER SET utf8 COLLATE utf8_general_ci        NOT NULL COMMENT '密保答题',
    PRIMARY KEY (`aid`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 3
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin`
VALUES (1, 'admin', '1234567', '天王盖地虎', '宝塔镇河妖');
INSERT INTO `admin`
VALUES (2, 'admin2', '666666', '忘记密码了', '天王盖地虎');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`
(
    `cid`       int(4)                                                  NOT NULL AUTO_INCREMENT COMMENT '菜品种类编号',
    `kind_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜品种类名',
    PRIMARY KEY (`cid`) USING BTREE,
    INDEX `kind_name` (`kind_name`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 9
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category`
VALUES (3, '凉菜');
INSERT INTO `category`
VALUES (5, '小吃');
INSERT INTO `category`
VALUES (8, '早餐');
INSERT INTO `category`
VALUES (4, '汤羹');
INSERT INTO `category`
VALUES (2, '热菜');
INSERT INTO `category`
VALUES (1, '特色菜');
INSERT INTO `category`
VALUES (6, '饮品');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`
(
    `comment_id` int(8)                                                  NOT NULL AUTO_INCREMENT COMMENT '评论编号',
    `order_id`   int(8)                                                  NOT NULL COMMENT '订单编号',
    `openid`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户openid',
    `nickname`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
    `comment`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
    `table_id`   int(4)                                                  NOT NULL COMMENT '餐桌编号',
    `score`      int(11)                                                 NOT NULL COMMENT '评分',
    `createtime` datetime                                                NOT NULL COMMENT '评论时间',
    PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 10
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment`
VALUES (1, 14, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', '生生', '鸡爪很香，电视剧啊合肥市，啥时候，的哈市，打哈集合', 1, 5,
        '2025-05-08 11:35:04');
INSERT INTO `comment`
VALUES (2, 15, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', '生生', '鸡爪不好吃，我屋亲打哈进去结算单时间的话 记得', 1, 5,
        '2025-05-03 11:35:12');
INSERT INTO `comment`
VALUES (3, 18, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', '生生', 'fsff打哈暗红色的，点击爱好，大家好就', 1, 5,
        '2025-05-06 11:35:17');
INSERT INTO `comment`
VALUES (4, 21, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', '生生', 'vv，卡进度好的，档卡户，阿昆达 ，卡点按季度', 1, 5,
        '2025-05-05 11:35:21');
INSERT INTO `comment`
VALUES (5, 22, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 'dulewe', '和嘀嘀咕咕的关系', 2, 5, '2025-05-21 11:35:26');
INSERT INTO `comment`
VALUES (6, 88, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', '小童', '好吃！', 1, 5, '2025-05-11 11:35:30');
INSERT INTO `comment`
VALUES (7, 96, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', '小童呀', '客家话客家话空间', 1, 5, '2025-05-14 11:35:33');
INSERT INTO `comment`
VALUES (8, 97, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 'dulzor', '好吃', 5, 5, '2025-05-02 11:35:37');
INSERT INTO `comment`
VALUES (9, 2, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', '2', '2', 2, 5, '2025-05-07 11:35:40');

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon`
(
    `id`         int(11)                                                 NOT NULL,
    `cname`      varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `cvalue`     int(11)                                                 NULL DEFAULT NULL,
    `ccondition` int(11)                                                 NULL DEFAULT NULL,
    `startTime`  date                                                    NULL DEFAULT NULL,
    `endTime`    date                                                    NULL DEFAULT NULL,
    `status`     varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Compact;

-- ----------------------------
-- Records of coupon
-- ----------------------------
INSERT INTO `coupon`
VALUES (1, '新用户专享券', 10, 50, '2025-05-28', '2025-06-07', 'available');
INSERT INTO `coupon`
VALUES (2, '夏日特惠券', 20, 100, '2025-05-28', '2025-06-07', 'available');
INSERT INTO `coupon`
VALUES (3, '会员专享券', 30, 200, '2025-05-28', '2025-06-07', 'available');
INSERT INTO `coupon`
VALUES (4, '限时折扣券', 50, 300, '2025-05-14', '2025-05-18', 'available');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`
(
    `openid`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '顾客的openid作为主键',
    `nickname`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '顾客昵称',
    `phone_number` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL COMMENT '顾客手机号',
    `avatar_url`   varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '顾客头像地址',
    `money`        double(11, 2)                                           NOT NULL COMMENT '顾客钱包余额',
    PRIMARY KEY (`openid`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer`
VALUES ('', 'AmberKuo', '18888888888',
        'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep9WFDR6e0NDuLHoAYTsDwQgjXLWeaYySibnlpuVxjsNppnDLP6ibnVWk00aCpXZcIC4ypUPf4AoCbw/132',
        0.00);
INSERT INTO `customer`
VALUES ('1', '1', '18812345678', '1', 0.00);
INSERT INTO `customer`
VALUES ('o21eg5E3h_SWptO8a_dKfFmVQV_I', 'AmberKuo', '13333333333',
        'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep9WFDR6e0NDuLHoAYTsDwQgjXLWeaYySibnlpuVxjsNppnDLP6ibnVWk00aCpXZcIC4ypUPf4AoCbw/132',
        55.00);
INSERT INTO `customer`
VALUES ('undefined', 'AmberKuo', '18888888888',
        'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep9WFDR6e0NDuLHoAYTsDwQgjXLWeaYySibnlpuVxjsNppnDLP6ibnVWk00aCpXZcIC4ypUPf4AoCbw/132',
        0.00);
INSERT INTO `customer`
VALUES ('wx37feb74ee1078484', 'AmberKuo', '11111111111',
        'https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83ep9WFDR6e0NDuLHoAYTsDwQgjXLWeaYySibnlpuVxjsNppnDLP6ibnVWk00aCpXZcIC4ypUPf4AoCbw/132',
        0.00);

-- ----------------------------
-- Table structure for detail
-- ----------------------------
DROP TABLE IF EXISTS `detail`;
CREATE TABLE `detail`
(
    `did`           int(11)                                                 NOT NULL AUTO_INCREMENT COMMENT '订单详细表编号',
    `order_id`      int(8)                                                  NOT NULL COMMENT '订单编号',
    `food_name`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '餐品名称',
    `food_quantity` int(4)                                                  NOT NULL COMMENT '餐品数量',
    `price`         int(4)                                                  NOT NULL COMMENT '餐品单价',
    `food_icon`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '餐品图标',
    PRIMARY KEY (`did`) USING BTREE,
    INDEX `订单编号` (`order_id`) USING BTREE,
    INDEX `餐品编号` (`food_name`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 246
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of detail
-- ----------------------------
INSERT INTO `detail`
VALUES (20, 12, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (21, 12, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (22, 12, '芥菜炒红萝卜丝', 1, 18,
        'http://localhost:8081/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg');
INSERT INTO `detail`
VALUES (23, 12, '茄汁鸡蛋龙须面', 1, 20,
        'http://localhost:8081/images/%E8%8C%84%E6%B1%81%E9%B8%A1%E8%9B%8B%E9%BE%99%E9%A1%BB%E9%9D%A2.jpeg');
INSERT INTO `detail`
VALUES (24, 12, '玉米排骨汤', 1, 30, 'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (25, 12, '麻辣拌', 1, 8, 'http://localhost:8081/images/%E9%BA%BB%E8%BE%A3%E6%8B%8C.jpeg');
INSERT INTO `detail`
VALUES (26, 12, '葱油粑粑', 2, 10, 'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `detail`
VALUES (27, 13, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (28, 13, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (29, 14, '秘制蒜香鸡爪', 1, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (30, 15, '秘制蒜香鸡爪', 1, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (31, 15, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (32, 16, '牛尾罗宋汤', 1, 25, 'http://localhost:8081/images/%E7%89%9B%E5%B0%BE%E7%BD%97%E5%AE%8B%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (33, 16, '香肚虾仁酸汤粉', 1, 15,
        'http://localhost:8081/images/%E9%A6%99%E8%82%9A%E8%99%BE%E4%BB%81%E9%85%B8%E6%B1%A4%E7%B2%89.jpeg');
INSERT INTO `detail`
VALUES (34, 16, '腌笃鲜', 1, 40, 'http://localhost:8081/images/%E8%85%8C%E7%AC%83%E9%B2%9C.jpg');
INSERT INTO `detail`
VALUES (35, 17, '香肚虾仁酸汤粉', 1, 15,
        'http://localhost:8081/images/%E9%A6%99%E8%82%9A%E8%99%BE%E4%BB%81%E9%85%B8%E6%B1%A4%E7%B2%89.jpeg');
INSERT INTO `detail`
VALUES (36, 17, '腌笃鲜', 1, 40, 'http://localhost:8081/images/%E8%85%8C%E7%AC%83%E9%B2%9C.jpg');
INSERT INTO `detail`
VALUES (37, 17, '鱼尾炖豆腐', 1, 30, 'http://localhost:8081/images/%E9%B1%BC%E5%B0%BE%E7%82%96%E8%B1%86%E8%85%90.jpeg');
INSERT INTO `detail`
VALUES (38, 18, '秘制蒜香鸡爪', 1, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (39, 18, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (40, 18, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (41, 21, '秘制蒜香鸡爪', 2, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (42, 21, '糖醋腌萝卜 ', 3, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (43, 21, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (44, 21, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (45, 22, '秘制蒜香鸡爪', 1, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (46, 22, '腌笃鲜', 1, 40, 'http://localhost:8081/images/%E8%85%8C%E7%AC%83%E9%B2%9C.jpg');
INSERT INTO `detail`
VALUES (47, 22, '玉米排骨汤', 1, 30, 'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (48, 22, '香肚虾仁酸汤粉', 1, 15,
        'http://localhost:8081/images/%E9%A6%99%E8%82%9A%E8%99%BE%E4%BB%81%E9%85%B8%E6%B1%A4%E7%B2%89.jpeg');
INSERT INTO `detail`
VALUES (49, 23, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (50, 23, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (51, 24, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (52, 24, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (53, 25, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (54, 25, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (55, 26, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (56, 26, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (57, 26, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (58, 27, '秘制蒜香鸡爪', 1, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (59, 27, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (60, 28, '秘制蒜香鸡爪', 84, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (61, 29, '秘制蒜香鸡爪', 1, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (66, 42, '秘制蒜香鸡爪', 1, 20,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `detail`
VALUES (67, 43, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (68, 43, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (69, 44, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (70, 45, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (71, 46, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (72, 47, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (73, 48, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (74, 49, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (75, 50, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (76, 51, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (77, 52, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (78, 53, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (79, 54, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (80, 55, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (81, 56, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (82, 57, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (83, 58, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (84, 59, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (85, 60, '玉米排骨汤', 1, 30, 'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (86, 60, '冬瓜橙汁', 1, 15, 'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `detail`
VALUES (87, 61, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (88, 62, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (89, 63, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (90, 64, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (91, 65, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (92, 66, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (93, 66, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (94, 67, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (95, 67, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (96, 68, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (97, 68, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (98, 69, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (99, 69, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (100, 70, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (101, 70, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (102, 71, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (103, 71, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (104, 72, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (105, 72, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (106, 73, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (107, 73, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (108, 74, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (109, 74, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (110, 75, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (111, 75, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (112, 76, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (113, 76, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (114, 77, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (115, 77, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (116, 78, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (117, 78, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (118, 79, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (119, 79, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (120, 80, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (121, 80, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (122, 81, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (123, 81, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (124, 82, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (125, 82, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (126, 83, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (127, 83, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (128, 84, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (129, 84, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (130, 85, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (131, 86, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (132, 86, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (133, 86, '玉米排骨汤', 1, 30,
        'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (134, 87, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (135, 87, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (136, 87, '玉米排骨汤', 1, 30,
        'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (137, 88, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (138, 88, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (139, 88, '麻辣拌', 1, 8, 'http://localhost:8081/images/%E9%BA%BB%E8%BE%A3%E6%8B%8C.jpeg');
INSERT INTO `detail`
VALUES (140, 88, '玉米排骨汤', 1, 30,
        'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (141, 88, '麻辣香锅', 1, 35, 'http://localhost:8081/images/%E9%BA%BB%E8%BE%A3%E9%A6%99%E9%94%85.jpeg');
INSERT INTO `detail`
VALUES (142, 88, '蒜香辣子鸡 ', 1, 35,
        'http://localhost:8081/images/%E8%92%9C%E9%A6%99%E8%BE%A3%E5%AD%90%E9%B8%A1.jpeg');
INSERT INTO `detail`
VALUES (143, 89, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (144, 90, '芥菜炒红萝卜丝', 1, 18,
        'http://localhost:8081/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg');
INSERT INTO `detail`
VALUES (145, 90, '番茄土豆焖排骨', 1, 33,
        'http://localhost:8081/images/%E7%95%AA%E8%8C%84%E5%9C%9F%E8%B1%86%E7%84%96%E6%8E%92%E9%AA%A8.jpeg');
INSERT INTO `detail`
VALUES (146, 91, '芥菜炒红萝卜丝', 1, 18,
        'http://localhost:8081/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg');
INSERT INTO `detail`
VALUES (147, 91, '番茄土豆焖排骨', 1, 33,
        'http://localhost:8081/images/%E7%95%AA%E8%8C%84%E5%9C%9F%E8%B1%86%E7%84%96%E6%8E%92%E9%AA%A8.jpeg');
INSERT INTO `detail`
VALUES (148, 92, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (149, 93, '茄汁鸡蛋龙须面', 1, 20,
        'http://localhost:8081/images/%E8%8C%84%E6%B1%81%E9%B8%A1%E8%9B%8B%E9%BE%99%E9%A1%BB%E9%9D%A2.jpeg');
INSERT INTO `detail`
VALUES (150, 93, '番茄土豆焖排骨', 1, 33,
        'http://localhost:8081/images/%E7%95%AA%E8%8C%84%E5%9C%9F%E8%B1%86%E7%84%96%E6%8E%92%E9%AA%A8.jpeg');
INSERT INTO `detail`
VALUES (151, 94, '牛尾罗宋汤', 1, 25,
        'http://localhost:8081/images/%E7%89%9B%E5%B0%BE%E7%BD%97%E5%AE%8B%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (152, 94, '冬瓜橙汁', 1, 15, 'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `detail`
VALUES (153, 95, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (154, 96, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (155, 96, '腌笃鲜', 1, 40, 'http://localhost:8081/images/%E8%85%8C%E7%AC%83%E9%B2%9C.jpg');
INSERT INTO `detail`
VALUES (156, 97, '芥菜炒红萝卜丝', 1, 18,
        'http://localhost:8081/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg');
INSERT INTO `detail`
VALUES (157, 98, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (158, 98, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (159, 99, '糖醋腌萝卜 ', 1, 8, 'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (160, 99, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (161, 99, '冬瓜橙汁', 1, 15, 'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `detail`
VALUES (162, 100, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (163, 100, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (164, 100, '冬瓜橙汁', 1, 15, 'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `detail`
VALUES (165, 101, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (166, 101, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (167, 101, '冬瓜橙汁', 1, 15, 'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `detail`
VALUES (168, 102, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (169, 102, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (170, 102, '冬瓜橙汁', 1, 15, 'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `detail`
VALUES (171, 103, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (172, 103, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (173, 103, '冬瓜橙汁', 1, 15, 'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `detail`
VALUES (174, 104, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (175, 104, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (176, 105, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (177, 105, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (181, 114, '糖醋腌萝卜 ', 2, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (182, 114, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (183, 114, '葱油粑粑', 1, 10, 'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `detail`
VALUES (184, 115, '糖醋腌萝卜 ', 2, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (185, 115, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (186, 115, '葱油粑粑', 1, 10, 'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `detail`
VALUES (187, 116, '糖醋腌萝卜 ', 2, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (188, 116, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (189, 116, '葱油粑粑', 1, 10, 'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `detail`
VALUES (190, 117, '糖醋腌萝卜 ', 2, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (191, 117, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (192, 117, '葱油粑粑', 1, 10, 'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `detail`
VALUES (193, 118, '糖醋腌萝卜 ', 2, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (194, 118, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (195, 118, '葱油粑粑', 1, 10, 'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `detail`
VALUES (196, 119, '糖醋腌萝卜 ', 2, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (197, 119, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (198, 119, '麻辣拌', 2, 8, 'http://localhost:8081/images/%E9%BA%BB%E8%BE%A3%E6%8B%8C.jpeg');
INSERT INTO `detail`
VALUES (199, 120, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (200, 120, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (201, 120, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (202, 120, '麻辣拌', 1, 8, 'http://localhost:8081/images/%E9%BA%BB%E8%BE%A3%E6%8B%8C.jpeg');
INSERT INTO `detail`
VALUES (203, 120, '香肚虾仁酸汤粉', 1, 15,
        'http://localhost:8081/images/%E9%A6%99%E8%82%9A%E8%99%BE%E4%BB%81%E9%85%B8%E6%B1%A4%E7%B2%89.jpeg');
INSERT INTO `detail`
VALUES (204, 121, '香肚虾仁酸汤粉', 1, 15,
        'http://localhost:8081/images/%E9%A6%99%E8%82%9A%E8%99%BE%E4%BB%81%E9%85%B8%E6%B1%A4%E7%B2%89.jpeg');
INSERT INTO `detail`
VALUES (205, 122, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (206, 122, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (207, 123, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (208, 123, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (209, 124, '麻辣拌', 1, 8, 'http://localhost:8081/images/%E9%BA%BB%E8%BE%A3%E6%8B%8C.jpeg');
INSERT INTO `detail`
VALUES (210, 124, '葱油粑粑', 1, 10, 'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `detail`
VALUES (211, 125, '芥菜炒红萝卜丝', 1, 18,
        'http://localhost:8081/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg');
INSERT INTO `detail`
VALUES (212, 126, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (213, 127, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (214, 128, '芥菜炒红萝卜丝', 1, 18,
        'http://localhost:8081/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg');
INSERT INTO `detail`
VALUES (215, 128, '豌豆炒肉沫', 1, 26,
        'http://localhost:8081/images/%E8%B1%8C%E8%B1%86%E7%82%92%E8%82%89%E6%B2%AB.jpeg');
INSERT INTO `detail`
VALUES (216, 129, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (217, 130, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (218, 130, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (219, 130, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (220, 130, '茄汁鸡蛋龙须面', 1, 20,
        'http://localhost:8081/images/%E8%8C%84%E6%B1%81%E9%B8%A1%E8%9B%8B%E9%BE%99%E9%A1%BB%E9%9D%A2.jpeg');
INSERT INTO `detail`
VALUES (221, 131, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (222, 131, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (223, 131, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (224, 131, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (225, 131, '冬瓜橙汁', 1, 15, 'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `detail`
VALUES (226, 132, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (227, 133, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (228, 134, '葱油粑粑', 1, 10, 'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `detail`
VALUES (229, 134, '香肚虾仁酸汤粉', 1, 15,
        'http://localhost:8081/images/%E9%A6%99%E8%82%9A%E8%99%BE%E4%BB%81%E9%85%B8%E6%B1%A4%E7%B2%89.jpeg');
INSERT INTO `detail`
VALUES (230, 134, '芥菜炒红萝卜丝', 1, 18,
        'http://localhost:8081/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg');
INSERT INTO `detail`
VALUES (231, 134, '豌豆炒肉沫', 1, 26,
        'http://localhost:8081/images/%E8%B1%8C%E8%B1%86%E7%82%92%E8%82%89%E6%B2%AB.jpeg');
INSERT INTO `detail`
VALUES (232, 135, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (233, 135, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (234, 135, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (235, 135, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (236, 135, '玉米排骨汤', 1, 30,
        'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (237, 136, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (238, 136, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (239, 136, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (240, 136, '玉米排骨汤', 1, 30,
        'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `detail`
VALUES (241, 137, '凉拌马兰头虫草花', 1, 15,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `detail`
VALUES (242, 137, '糖醋腌萝卜 ', 1, 8,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `detail`
VALUES (243, 137, '醋泡花生', 1, 10, 'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `detail`
VALUES (244, 137, '豆芽菜拌海带', 1, 10,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `detail`
VALUES (245, 137, '玉米排骨汤', 1, 30,
        'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food`
(
    `fid`      int(4)                                                  NOT NULL AUTO_INCREMENT COMMENT '餐品编号',
    `fname`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '餐品名称',
    `fkind`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '餐品种类',
    `price`    int(4)                                                  NOT NULL COMMENT '餐品价格',
    `intro`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '餐品介绍',
    `storage`  int(4)                                                  NOT NULL COMMENT '存储量',
    `img_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '图片存储路径',
    PRIMARY KEY (`fid`) USING BTREE,
    INDEX `种类名` (`fkind`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 23
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food`
VALUES (1, '豌豆炒肉沫', '热菜', 26, '超级下饭的家常小炒。', 88,
        'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%B1%8C%E8%B1%86%E7%82%92%E8%82%89%E6%B2%AB.jpeg');
INSERT INTO `food`
VALUES (2, '芥菜炒红萝卜丝', '热菜', 18, '简单美味，健康营养快手菜。', 144,
        'http://localhost:8081/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg');
INSERT INTO `food`
VALUES (3, '茄汁鸡蛋龙须面', '热菜', 20,
        '成品鲜美可口，入味十足！二月二龙抬头，北方有吃龙须面的习俗，细如发丝的面条宛如龙须，来碗香喷喷的龙须面，祈祷新的一年里风调雨顺，好运连连！',
        78, 'http://localhost:8081/images/%E8%8C%84%E6%B1%81%E9%B8%A1%E8%9B%8B%E9%BE%99%E9%A1%BB%E9%9D%A2.jpeg');
INSERT INTO `food`
VALUES (4, '蒜香辣子鸡', '特色菜', 35,
        '超多鸡肉的蒜香辣子鸡，这样吃起来既解馋又过瘾，肉的外皮非常有嚼劲，里面的肉质又非常鲜嫩，口感很紧实。', 64,
        'http://localhost:8081/images/%E8%92%9C%E9%A6%99%E8%BE%A3%E5%AD%90%E9%B8%A1.jpeg');
INSERT INTO `food`
VALUES (5, '腌笃鲜', '特色菜', 40,
        '甜嫩的春笋加入新鲜的猪肉或鸡肉和淡淡的咸肉，放入砂锅，小火慢笃，满屋的春日气息扑鼻而来。', 69,
        'http://localhost:8081/images/%E8%85%8C%E7%AC%83%E9%B2%9C.jpg');
INSERT INTO `food`
VALUES (6, '番茄土豆焖排骨', '热菜', 33, '很清淡的一个焖排骨，作为一个无辣不欢的人来说，做个不辣的菜好难得。', 27,
        'http://localhost:8081/images/%E7%95%AA%E8%8C%84%E5%9C%9F%E8%B1%86%E7%84%96%E6%8E%92%E9%AA%A8.jpeg');
INSERT INTO `food`
VALUES (7, '时蔬炒粉条 ', '热菜', 15, '时蔬可以指定选择，粉条晶莹剔透！', 100,
        'http://localhost:8081/images/%E6%97%B6%E8%94%AC%E7%82%92%E7%B2%89%E6%9D%A1.jpeg');
INSERT INTO `food`
VALUES (8, '鱼尾炖豆腐', '特色菜', 30, '豆腐和鱼搭配是完美的组合！', 50,
        'http://localhost:8081/images/%E9%B1%BC%E5%B0%BE%E7%82%96%E8%B1%86%E8%85%90.jpeg');
INSERT INTO `food`
VALUES (9, '秘制蒜香鸡爪', '凉菜', 20, '秘制蒜香鸡爪，超级Q弹，又超级入味。', 0,
        'http://localhost:8081/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg');
INSERT INTO `food`
VALUES (10, '糖醋腌萝卜 ', '凉菜', 8, '初春的水萝卜又水又嫩，可以直接生吃，加些许糖，口感棒极了', 147,
        'http://localhost:8081/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg');
INSERT INTO `food`
VALUES (11, '凉拌马兰头虫草花', '凉菜', 15, '又补又降火', 141,
        'http://localhost:8081/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg');
INSERT INTO `food`
VALUES (12, '醋泡花生', '凉菜', 10, '必备下酒菜', 96,
        'http://localhost:8081/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg');
INSERT INTO `food`
VALUES (13, '豆芽菜拌海带', '凉菜', 10, '清清爽爽的豆芽菜与海带搭配，用炒制过是虾蓉酱拌一拌，很健康的一道养生美味。', 186,
        'http://localhost:8081/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg');
INSERT INTO `food`
VALUES (14, '牛尾罗宋汤', '汤羹', 25, '这是南美洲国家很受欢迎的一款汤，营养丰富，味道香浓。', 59,
        'http://localhost:8081/images/%E7%89%9B%E5%B0%BE%E7%BD%97%E5%AE%8B%E6%B1%A4.jpeg');
INSERT INTO `food`
VALUES (15, '玉米排骨汤', '汤羹', 30, '汤鲜味美，排骨软烂、山药粉糯、胡萝卜清甜、一餐吃光光！', 43,
        'http://localhost:8081/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg');
INSERT INTO `food`
VALUES (16, '西红柿肉丸豆腐汤', '汤羹', 28, '吃起来酸甜美味、色泽红润、加入肉丸更好吃～', 80,
        'http://localhost:8081/images/%E8%A5%BF%E7%BA%A2%E6%9F%BF%E8%82%89%E4%B8%B8%E8%B1%86%E8%85%90%E6%B1%A4.jpeg');
INSERT INTO `food`
VALUES (17, '麻辣拌', '小吃', 8,
        '整体来说，麻辣拌比麻辣烫吃起来更过瘾，也更重口味，尤其是满满的芝麻香，每一口吃起来都超级过瘾。', 85,
        'http://localhost:8081/images/%E9%BA%BB%E8%BE%A3%E6%8B%8C.jpeg');
INSERT INTO `food`
VALUES (18, '葱油粑粑', '小吃', 10, '外酥里嫩，香脆软嫩', 46,
        'http://localhost:8081/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg');
INSERT INTO `food`
VALUES (19, '香肚虾仁酸汤粉', '小吃', 15, '大青菜成菜薹，而小的青菜秧则成新贵，鲜嫩又好吃。', 67,
        'http://localhost:8081/images/%E9%A6%99%E8%82%9A%E8%99%BE%E4%BB%81%E9%85%B8%E6%B1%A4%E7%B2%89.jpeg');
INSERT INTO `food`
VALUES (20, '孜然排骨 ', '热菜', 35, '香辣，孜然味浓郁。', 60,
        'http://localhost:8081/images/%E5%AD%9C%E7%84%B6%E6%8E%92%E9%AA%A8.jpeg');
INSERT INTO `food`
VALUES (21, '冬瓜橙汁', '饮品', 15, '水果直接加水搅拌后得到的“果汁”，其营养成分跟直接吃水果是一样的，但是口感更好', 22,
        'http://localhost:8081/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg');
INSERT INTO `food`
VALUES (22, '麻辣香锅', '特色菜', 35, '有虾！速速来碗米饭，麻辣香锅，最受食物之一', 59,
        'http://localhost:8081/images/%E9%BA%BB%E8%BE%A3%E9%A6%99%E9%94%85.jpeg');

-- ----------------------------
-- Table structure for mycoupon
-- ----------------------------
DROP TABLE IF EXISTS `mycoupon`;
CREATE TABLE `mycoupon`
(
    `id`       int(11)                                                 NOT NULL AUTO_INCREMENT,
    `openid`   varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `couid`    int(11)                                                 NOT NULL,
    `status`   varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL     DEFAULT NULL,
    `collTime` timestamp                                               NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `useTime`  datetime                                                NULL     DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 4
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mycoupon
-- ----------------------------
INSERT INTO `mycoupon`
VALUES (1, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, 'used', '2025-05-26 15:10:05', NULL);
INSERT INTO `mycoupon`
VALUES (2, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, 'used', '2025-05-24 15:11:49', '2025-05-26 15:11:54');
INSERT INTO `mycoupon`
VALUES (3, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 4, 'expired', '2025-05-16 15:40:04', NULL);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`
(
    `oid`         int(8)                                                  NOT NULL AUTO_INCREMENT COMMENT '订单编号',
    `table_id`    int(4)                                                  NOT NULL COMMENT '餐桌编号',
    `create_time` timestamp                                               NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
    `total_price` int(4)                                                  NOT NULL COMMENT '总价格',
    `openid`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户的openid',
    `eat_number`  int(4)                                                  NOT NULL COMMENT '用餐人数',
    `remark`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
    `status`      int(4)                                                  NOT NULL COMMENT '订单状态：1-待上餐；2-已取消；3-待评价；4-已完成',
    `payway`      varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '支付方式',
    PRIMARY KEY (`oid`) USING BTREE,
    INDEX `餐桌编号` (`table_id`) USING BTREE,
    INDEX `用户openid` (`openid`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 138
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders`
VALUES (12, 1, '2024-06-25 16:21:26', 116, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 4, '生生');
INSERT INTO `orders`
VALUES (13, 3, '2024-06-20 13:53:33', 20, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '否', 3, '生生');
INSERT INTO `orders`
VALUES (14, 1, '2024-06-20 13:53:33', 20, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '辣一些', 4, '生生');
INSERT INTO `orders`
VALUES (15, 1, '2024-06-20 13:53:33', 28, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '而我却', 4, '生生');
INSERT INTO `orders`
VALUES (16, 1, '2024-06-20 13:53:33', 80, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '', 2, '生生');
INSERT INTO `orders`
VALUES (17, 1, '2024-06-20 13:53:33', 85, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 4, '', 1, '生生');
INSERT INTO `orders`
VALUES (18, 6, '2024-06-20 13:53:33', 40, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 4, '生生');
INSERT INTO `orders`
VALUES (21, 1, '2024-06-20 13:53:33', 89, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '多喝水客家话', 4, '生生');
INSERT INTO `orders`
VALUES (22, 2, '2024-06-20 13:53:33', 105, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '', 4, '生生');
INSERT INTO `orders`
VALUES (23, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '饭多打一些', 3, '生生');
INSERT INTO `orders`
VALUES (24, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '', 3, '生生');
INSERT INTO `orders`
VALUES (25, 2, '2024-06-20 13:53:33', 25, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 1, '生生');
INSERT INTO `orders`
VALUES (26, 5, '2024-06-20 13:53:33', 33, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, 'sdfsd', 3, '生生');
INSERT INTO `orders`
VALUES (27, 2, '2024-06-20 13:53:33', 28, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 2, '生生');
INSERT INTO `orders`
VALUES (29, 5, '2024-06-20 13:53:33', 20, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, 'dsf', 1, '生生');
INSERT INTO `orders`
VALUES (42, 5, '2024-06-20 13:53:33', 20, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 1, '生生');
INSERT INTO `orders`
VALUES (43, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '恢诡谲怪', 1, '生生');
INSERT INTO `orders`
VALUES (44, 5, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '222', 1, '生生');
INSERT INTO `orders`
VALUES (45, 5, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '222', 1, '生生');
INSERT INTO `orders`
VALUES (46, 5, '2024-06-20 13:53:33', 15, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '订单', 1, '生生');
INSERT INTO `orders`
VALUES (47, 6, '2024-06-20 13:53:33', 15, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '2131', 1, '生生');
INSERT INTO `orders`
VALUES (48, 6, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '胜多负少的', 1, '生生');
INSERT INTO `orders`
VALUES (49, 6, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '3erect', 1, '生生');
INSERT INTO `orders`
VALUES (50, 2, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '鼎折覆餗', 1, '生生');
INSERT INTO `orders`
VALUES (51, 2, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '我去', 1, '生生');
INSERT INTO `orders`
VALUES (52, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '是否是', 1, '生生');
INSERT INTO `orders`
VALUES (53, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '王企鹅无', 1, '生生');
INSERT INTO `orders`
VALUES (54, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '是否是', 1, '生生');
INSERT INTO `orders`
VALUES (55, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '而威尔', 1, '生生');
INSERT INTO `orders`
VALUES (56, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '而威尔', 1, '生生');
INSERT INTO `orders`
VALUES (57, 2, '2024-06-20 13:53:33', 15, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '快上餐', 1, '生生');
INSERT INTO `orders`
VALUES (58, 2, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '是否', 1, '生生');
INSERT INTO `orders`
VALUES (59, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '发多少', 1, '生生');
INSERT INTO `orders`
VALUES (60, 2, '2024-06-20 13:53:33', 45, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '是分散分', 1, '生生');
INSERT INTO `orders`
VALUES (61, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '大头头真大', 1, '生生');
INSERT INTO `orders`
VALUES (62, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '大头头真大', 1, '生生');
INSERT INTO `orders`
VALUES (63, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '大头头真大', 1, '生生');
INSERT INTO `orders`
VALUES (64, 2, '2025-05-20 16:27:05', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 0, '生生');
INSERT INTO `orders`
VALUES (65, 2, '2024-06-20 13:53:33', 15, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '大师傅似的', 1, '生生');
INSERT INTO `orders`
VALUES (66, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (67, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (68, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (69, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (70, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (71, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (72, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (73, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (74, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (75, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (76, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (77, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (78, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (79, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (80, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (81, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'ffds ', 1, '生生');
INSERT INTO `orders`
VALUES (82, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 0, 'ffsdf', 1, '生生');
INSERT INTO `orders`
VALUES (83, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 0, '', 1, '生生');
INSERT INTO `orders`
VALUES (84, 2, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 0, '', 1, '生生');
INSERT INTO `orders`
VALUES (85, 2, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, 'sfsdf', 1, 'dulewe');
INSERT INTO `orders`
VALUES (86, 1, '2024-06-20 13:53:33', 50, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 0, '手机点餐', 1, 'dulewe');
INSERT INTO `orders`
VALUES (87, 1, '2024-06-20 13:53:33', 50, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '手机点餐', 1, 'dulewe');
INSERT INTO `orders`
VALUES (88, 1, '2024-06-20 13:53:33', 126, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 4, '小童');
INSERT INTO `orders`
VALUES (89, 1, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 3, '小童');
INSERT INTO `orders`
VALUES (90, 3, '2024-06-20 13:53:33', 51, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '的法国三国', 2, '小童');
INSERT INTO `orders`
VALUES (91, 3, '2024-06-20 13:53:33', 51, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '的法国三国', 3, '小童');
INSERT INTO `orders`
VALUES (92, 2, '2024-06-20 13:53:33', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, 'dsfsd', 1, '小童呀');
INSERT INTO `orders`
VALUES (93, 2, '2024-06-20 13:53:33', 53, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 0, 'sdfsf', 1, '小童呀');
INSERT INTO `orders`
VALUES (94, 6, '2024-06-20 13:53:33', 40, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, 'chi', 3, '小童呀');
INSERT INTO `orders`
VALUES (95, 6, '2024-06-20 13:53:33', 8, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, 'sf', 3, '小童呀');
INSERT INTO `orders`
VALUES (96, 1, '2024-06-20 13:53:33', 50, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 9, '士大夫十分', 4, '小童呀');
INSERT INTO `orders`
VALUES (97, 5, '2024-06-20 13:53:33', 18, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, 'dfdsdgf ', 4, 'dulzor');
INSERT INTO `orders`
VALUES (98, 4, '2024-06-20 13:53:33', 18, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, 'gfg', 1, 'dulzor');
INSERT INTO `orders`
VALUES (99, 6, '2024-06-20 13:53:33', 33, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (100, 6, '2024-06-20 13:53:33', 33, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (101, 6, '2024-06-20 13:53:33', 33, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (102, 6, '2024-06-20 13:53:33', 33, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (103, 6, '2024-06-20 13:53:33', 33, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (104, 6, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 0, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (105, 6, '2024-06-20 13:53:33', 23, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (116, 4, '2024-06-25 10:52:17', 41, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 1, '');
INSERT INTO `orders`
VALUES (117, 4, '2024-06-25 11:24:38', 41, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (118, 4, '2024-06-25 13:41:28', 41, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 1, '');
INSERT INTO `orders`
VALUES (119, 2, '2024-06-25 13:55:37', 47, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 4, '麻烦上餐速度快一点', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (120, 3, '2024-06-25 13:59:22', 56, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 4, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (121, 1, '2025-03-07 15:11:03', 15, 'undefined', 2, '', 1, 'AmberKuo');
INSERT INTO `orders`
VALUES (126, 5, '2025-05-26 10:09:22', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '', 1, '余额支付');
INSERT INTO `orders`
VALUES (128, 3, '2025-05-26 10:15:40', 44, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 1, '余额支付');
INSERT INTO `orders`
VALUES (129, 1, '2025-05-26 11:22:09', 15, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 1, '少辣', 1, '余额支付');
INSERT INTO `orders`
VALUES (131, 1, '2025-05-27 09:15:33', 48, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '少辣', 0, 'wechat');
INSERT INTO `orders`
VALUES (132, 2, '2025-05-27 09:31:00', 15, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '少辣', 0, 'alipay');
INSERT INTO `orders`
VALUES (133, 2, '2025-05-27 09:49:15', 10, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 0, 'wechat');
INSERT INTO `orders`
VALUES (134, 4, '2025-05-27 09:59:14', 59, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '少辣', 0, 'wechat');
INSERT INTO `orders`
VALUES (135, 2, '2025-05-27 10:10:23', 63, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '少辣', 0, 'wechat');
INSERT INTO `orders`
VALUES (136, 3, '2025-05-27 10:12:52', 55, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 2, '', 0, 'balance');
INSERT INTO `orders`
VALUES (137, 6, '2025-05-27 10:18:47', 63, 'o21eg5E3h_SWptO8a_dKfFmVQV_I', 3, '少辣', 0, 'wechat');

-- ----------------------------
-- Table structure for tables
-- ----------------------------
DROP TABLE IF EXISTS `tables`;
CREATE TABLE `tables`
(
    `table_id`   int(4)  NOT NULL AUTO_INCREMENT COMMENT '餐桌编号',
    `use_number` int(11) NOT NULL COMMENT '使用次数',
    PRIMARY KEY (`table_id`) USING BTREE,
    INDEX `tid` (`table_id`, `use_number`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 7
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of tables
-- ----------------------------
INSERT INTO `tables`
VALUES (1, 12);
INSERT INTO `tables`
VALUES (2, 52);
INSERT INTO `tables`
VALUES (3, 4);
INSERT INTO `tables`
VALUES (4, 3);
INSERT INTO `tables`
VALUES (5, 8);
INSERT INTO `tables`
VALUES (6, 7);

SET FOREIGN_KEY_CHECKS = 1;

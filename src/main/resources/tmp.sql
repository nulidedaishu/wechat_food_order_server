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

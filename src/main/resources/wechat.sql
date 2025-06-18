-- 用户表
DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    id            BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '自增主键，留作内部业务用',
    openid        VARCHAR(64)  NOT NULL UNIQUE COMMENT '微信给的 openid，在小程序内唯一',
    session_token VARCHAR(128) NULL COMMENT '可选：存最新一次的 session_token（用于验证）',
    nickname      VARCHAR(64)  NULL COMMENT '可选：用户微信昵称',
    avatar_url    VARCHAR(256) NULL COMMENT '可选：用户微信头像 URL',
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    isDeleted     TINYINT      NOT NULL DEFAULT 0 COMMENT '软删除标志：0=未删，1=已删'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
    COMMENT ='用户表：存储微信小程序用户基本信息';

-- 商品表
DROP TABLE IF EXISTS products;
CREATE TABLE products
(
    id          BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '商品内部自增主键',
    sku         VARCHAR(64)  NOT NULL UNIQUE COMMENT '商品 SKU，业务层面唯一编码',
    name        VARCHAR(128) NOT NULL COMMENT '商品名称',
    description TEXT         NULL COMMENT '商品描述',
    price_cents INT          NOT NULL COMMENT '商品单价，单位:分',
    stock       INT          NOT NULL DEFAULT 999999 COMMENT '库存数量',
    sold_count  INT          NOT NULL DEFAULT 0 COMMENT '累计已售数量',
    category_id BIGINT NULL COMMENT '关联 categories.id',
    image_url   VARCHAR(256) NULL COMMENT '商品图片 URL',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    isDeleted   TINYINT      NOT NULL DEFAULT 0 COMMENT '软删除标志：0=未删，1=已删'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
    COMMENT ='商品表：存储菜品或商品信息';

-- 订单表
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
    id           BIGINT PRIMARY KEY COMMENT '订单自增主键',
    user_id      BIGINT   NOT NULL COMMENT '关联 users.id',
    total_amount INT      NOT NULL COMMENT '订单总金额，单位:分',
    status       TINYINT  NOT NULL COMMENT '订单状态：0=未支付，1=进行中，2=已完成，3=已取消',
    created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    isDeleted    TINYINT  NOT NULL DEFAULT 0 COMMENT '软删除标志：0=未删，1=已删'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
    COMMENT ='订单表：存储订单头信息';

-- 订单详情表
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items
(
    id          BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '订单明细自增主键',
    order_id    BIGINT   NOT NULL COMMENT '关联 orders.id',
    product_id  BIGINT   NOT NULL COMMENT '关联 products.id',
    quantity    INT      NOT NULL DEFAULT 1 COMMENT '购买数量',
    unit_price  INT      NOT NULL COMMENT '下单时商品单价，单位分',
    total_price INT AS (quantity * unit_price) STORED COMMENT '小计，计算列',
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    isDeleted   TINYINT  NOT NULL DEFAULT 0 COMMENT '软删除标志：0=未删，1=已删'
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
    COMMENT ='订单详情表：存储每笔订单的商品明细';

-- 类别表
DROP TABLE IF EXISTS categories;
CREATE TABLE categories
(
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(64) NOT NULL COMMENT '分类名称',
    sort_order INT         NOT NULL DEFAULT 0 COMMENT '排序',
    isDeleted  TINYINT     NOT NULL DEFAULT 0
)ENGINE = InnoDB
 DEFAULT CHARSET = utf8mb4
    COMMENT ='商品类别表：存储商品类别信息';

-- 用户表：如果需要按 openid 快速查询也可建索引
ALTER TABLE users
    ADD INDEX idx_users_openid (openid);

-- 商品表：按库存、销量和创建时间查询
ALTER TABLE products
    ADD INDEX idx_products_stock (stock);
ALTER TABLE products
    ADD INDEX idx_products_sold_count (sold_count);
ALTER TABLE products
    ADD INDEX idx_products_created_at (created_at);

-- 订单表：按用户和状态查询
ALTER TABLE orders
    ADD INDEX idx_orders_user_id (user_id),
    ADD INDEX idx_orders_status (status);

-- 订单详情表：按订单和商品查询
ALTER TABLE order_items
    ADD INDEX idx_order_items_order_id (order_id),
    ADD INDEX idx_order_items_product_id (product_id);

insert into categories (name, sort_order)
values ('主食', 1),
       ('副食', 2),
       ('饮品', 3),
       ('其他', 4);

-- 迁移类别表数据（ID+4，sort_order等于新ID）
INSERT INTO categories (id, name, sort_order, isDeleted)
VALUES
    (5, '特色菜', 5, 0),  -- 原ID:1 → 新ID:5
    (6, '热菜', 6, 0),    -- 原ID:2 → 新ID:6
    (7, '凉菜', 7, 0),    -- 原ID:3 → 新ID:7
    (8, '汤羹', 8, 0),    -- 原ID:4 → 新ID:8
    (9, '小吃', 9, 0),    -- 原ID:5 → 新ID:9
    (10, '饮品', 10, 0),   -- 原ID:6 → 新ID:10
    (12, '早餐', 12, 0);   -- 原ID:8 → 新ID:12

insert into products (sku, name, price_cents, category_id)
values ('0001', '皮蛋瘦肉粥', 2899, 1),
       ('0002', '瘦肉粥', 2099, 1),
        ('0003', '鸡蛋粥', 2099, 1),
        ('0004', '香鸡蛋粥', 2899, 1),
        ('0005', '蛋炒饭', 2099, 1),
        ('0006', '香鸡蛋炒饭', 2899, 1),
        ('0007', '香肉粥', 2899, 1),
        ('0008', '鸡蛋粥', 2099, 1),
        ('0009', '香鸡蛋粥', 2899, 1),
        ('0010', '香肉粥', 2899, 1),
        ('0011', '鸡腿', 2099, 2),
        ('0012', '牛排', 2899, 2),
        ('0013', '牛腩', 2899, 2),
        ('0014', '牛柳', 2899, 2),
        ('0015', '鸡翅', 2099, 2),
        ('0016', '鸡脚', 2099, 2),
        ('0017', '鸡米花', 2099, 2),
        ('0018', '鸡排', 2899, 2),
        ('0019', '鸡腿堡', 2899, 2),
        ('0020', '牛排堡', 2899, 2),
        ('0021', '可乐', 2099, 3),
        ('0022', '雪碧', 2099, 3),
        ('0023', '芬达', 2099, 3),
        ('0024', '百事', 2099, 3),
        ('0025', '冰红茶', 2899, 3),
        ('0026', '绿茶', 2899, 3),
        ('0027', '咖啡', 2899, 3),
        ('0028', '奶茶', 2899, 3),
        ('0029', '咖啡', 2899, 3),
        ('0030', '牛奶', 2899, 3),
        ('0031', '双皮奶', 2899, 4),
        ('0032', '蚵仔煎', 2899, 4),
        ('0033', '奶昔', 2899, 4),
        ('0034', '煎饼果子', 2899, 4),
        ('0035', '大闸蟹', 2899, 4),
        ('0036', '烤乳鸽', 2899, 4),
        ('0037', '布丁', 2899, 4),
        ('0038', '小笼包', 2899, 4),
        ('0039', '煎饺', 2899, 4),
        ('0040', '烧卖', 2899, 4);


INSERT INTO products (sku, name, description, price_cents, stock, category_id, image_url, isDeleted)
VALUES
    ('FOOD1', '豌豆炒肉沫', '超级下饭的家常小炒。', 2600, 88, 6, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%B1%8C%E8%B1%86%E7%82%92%E8%82%89%E6%B2%AB.jpeg', 0),
    ('FOOD2', '芥菜炒红萝卜丝', '简单美味，健康营养快手菜。', 1800, 144, 6, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%8A%A5%E8%8F%9C%E7%82%92%E7%BA%A2%E8%90%9D%E5%8D%9C%E4%B8%9D.jpeg', 0),
    ('FOOD3', '茄汁鸡蛋龙须面', '成品鲜美可口，入味十足！二月二龙抬头，北方有吃龙须面的习俗，细如发丝的面条宛如龙须，来碗香喷喷的龙须面，祈祷新的一年里风调雨顺，好运连连！', 2000, 78, 6, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%8C%84%E6%B1%81%E9%B8%A1%E8%9B%8B%E9%BE%99%E9%A1%BB%E9%9D%A2.jpeg', 0),
    ('FOOD4', '蒜香辣子鸡', '超多鸡肉的蒜香辣子鸡，这样吃起来既解馋又过瘾，肉的外皮非常有嚼劲，里面的肉质又非常鲜嫩，口感很紧实。', 3500, 64, 5, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%92%9C%E9%A6%99%E8%BE%A3%E5%AD%90%E9%B8%A1.jpeg', 0),
    ('FOOD5', '腌笃鲜', '甜嫩的春笋加入新鲜的猪肉或鸡肉和淡淡的咸肉，放入砂锅，小火慢笃，满屋的春日气息扑鼻而来。', 4000, 69, 5, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%85%8C%E7%AC%83%E9%B2%9C.jpg', 0),
    ('FOOD6', '番茄土豆焖排骨', '很清淡的一个焖排骨，作为一个无辣不欢的人来说，做个不辣的菜好难得。', 3300, 27, 6, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E7%95%AA%E8%8C%84%E5%9C%9F%E8%B1%86%E7%84%96%E6%8E%92%E9%AA%A8.jpeg', 0),
    ('FOOD7', '时蔬炒粉条', '时蔬可以指定选择，粉条晶莹剔透！', 1500, 100, 6, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E6%97%B6%E8%94%AC%E7%82%92%E7%B2%89%E6%9D%A1.jpeg', 0),
    ('FOOD8', '鱼尾炖豆腐', '豆腐和鱼搭配是完美的组合！', 3000, 50, 5, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E9%B1%BC%E5%B0%BE%E7%82%96%E8%B1%86%E8%85%90.jpeg', 0),
    ('FOOD9', '秘制蒜香鸡爪', '秘制蒜香鸡爪，超级Q弹，又超级入味。', 2000, 0, 7, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E7%A7%98%E5%88%B6%E8%92%9C%E9%A6%99%E9%B8%A1%E7%88%AA.jpeg', 0),
    ('FOOD10', '糖醋腌萝卜', '初春的水萝卜又水又嫩，可以直接生吃，加些许糖，口感棒极了', 800, 147, 7, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E7%B3%96%E9%86%8B%E8%85%8C%E8%90%9D%E5%8D%9C.jpg', 0),
    ('FOOD11', '凉拌马兰头虫草花', '又补又降火', 1500, 141, 7, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E5%87%89%E6%8B%8C%E9%A9%AC%E5%85%B0%E5%A4%B4%E8%99%AB%E8%8D%89%E8%8A%B1.jpeg', 0),
    ('FOOD12', '醋泡花生', '必备下酒菜', 1000, 96, 7, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E9%86%8B%E6%B3%A1%E8%8A%B1%E7%94%9F.jpeg', 0),
    ('FOOD13', '豆芽菜拌海带', '清清爽爽的豆芽菜与海带搭配，用炒制过是虾蓉酱拌一拌，很健康的一道养生美味。', 1000, 186, 7, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%B1%86%E8%8A%BD%E8%8F%9C%E6%8B%8C%E6%B5%B7%E5%B8%A6.jpg', 0),
    ('FOOD14', '牛尾罗宋汤', '这是南美洲国家很受欢迎的一款汤，营养丰富，味道香浓。', 2500, 59, 8, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E7%89%9B%E5%B0%BE%E7%BD%97%E5%AE%8B%E6%B1%A4.jpeg', 0),
    ('FOOD15', '玉米排骨汤', '汤鲜味美，排骨软烂、山药粉糯、胡萝卜清甜、一餐吃光光！', 3000, 43, 8, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E7%8E%89%E7%B1%B3%E6%8E%92%E9%AA%A8%E6%B1%A4.jpeg', 0),
    ('FOOD16', '西红柿肉丸豆腐汤', '吃起来酸甜美味、色泽红润、加入肉丸更好吃～', 2800, 80, 8, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%A5%BF%E7%BA%A2%E6%9F%BF%E8%82%89%E4%B8%B8%E8%B1%86%E8%85%90%E6%B1%A4.jpeg', 0),
    ('FOOD17', '麻辣拌', '整体来说，麻辣拌比麻辣烫吃起来更过瘾，也更重口味，尤其是满满的芝麻香，每一口吃起来都超级过瘾。', 800, 85, 9, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E9%BA%BB%E8%BE%A3%E6%8B%8C.jpeg', 0),
    ('FOOD18', '葱油粑粑', '外酥里嫩，香脆软嫩', 1000, 46, 9, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E8%91%B1%E6%B2%B9%E7%B2%91%E7%B2%91.jpg', 0),
    ('FOOD19', '香肚虾仁酸汤粉', '大青菜成菜薹，而小的青菜秧则成新贵，鲜嫩又好吃。', 1500, 67, 9, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E9%A6%99%E8%82%9A%E8%99%BE%E4%BB%81%E9%85%B8%E6%B1%A4%E7%B2%89.jpeg', 0),
    ('FOOD20', '孜然排骨', '香辣，孜然味浓郁。', 3500, 60, 6, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E5%AD%9C%E7%84%B6%E6%8E%92%E9%AA%A8.jpeg', 0),
    ('FOOD21', '冬瓜橙汁', '水果直接加水搅拌后得到的"果汁"，其营养成分跟直接吃水果是一样的，但是口感更好', 1500, 22, 10, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E5%86%AC%E7%93%9C%E6%A9%99%E6%B1%81.jpeg', 0),
    ('FOOD22', '麻辣香锅', '有虾！速速来碗米饭，麻辣香锅，最受食物之一', 3500, 59, 5, 'https://trading-platform1.oss-cn-nanjing.aliyuncs.com/images/%E9%BA%BB%E8%BE%A3%E9%A6%99%E9%94%85.jpeg', 0);

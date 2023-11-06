# buaa rails 2023 final work

## 要求

管理员操作

- 添加/编辑/查看/删除产品
- 查看所有订单列表
- 处理订单（发货/删除）

买家操作

- 浏览产品列表 =>  查看单品详情
- 添加到购物车
- 购物车内容生成订单
- 查看自己的订单列表
- 订单操作（付款，确认收货，取消订单）
- 添加产品到收藏夹
- 浏览收藏夹
- 将产品从收藏夹内删除

## 逻辑模型

### 实体表

1. users
   | property | type    | constrain        |
   | -------- | ------- | ---------------- |
   | id       | integer | primary key      |
   | username | string  | not null         |
   | password | integer | min-length       |
   | role     | string  | admin or others  |
   | email    | string  | not null, unique |
   | phone    | string  | not null, unique |
2. products
   | property     | type    | constrain   |
   | ------------ | ------- | ----------- |
   | id           | integer | primary key |
   | name         | string  | not null    |
   | price        | decimal | not null    |
   | description  | text    |             |
   | img          | blob?   |             |
   | sales_volume | integer | $\ge$ 0   |
   | design_id    | integer | foreign key |
   | color_id     | integer | foreign key |
   | size_id      | integer | foreign key |
   | type_id      | integer | foreign key |
3. designs
   | property     | type    | constrain        |
   | ------------ | ------- | ---------------- |
   | id           | integer | primary key      |
   | name         | string  | not null         |
   | sales_volume | integer | virtual property |
4. colors
   | property    | type    | constrain   |
   | ----------- | ------- | ----------- |
   | id          | integer | primary key |
   | rgb         | string  | #rrggbb     |
   | description | text    |             |
5. sizes
   | property    | type    | constrain   |
   | ----------- | ------- | ----------- |
   | id          | integer | primary key |
   | name        | string  | not null    |
   | description | text    |             |
6. types
   | property | type    | constrain   |
   | -------- | ------- | ----------- |
   | id       | integer | primary key |
   | name     | string  | not null    |
7. transaction_orders
   | property          | type    | constrain                            |
   | ----------------- | ------- | ------------------------------------ |
   | id                | integer | primary key                          |
   | user_id           | integer | foreign key                          |
   | consignee         | string  | not null                             |
   | delivery_address  | string  | not null                             |
   | delivery_phone    | string  | not null                             |
   | delivery_postcode | string  | not null                             |
   | order_status      | string  | Unpaid, Unshipped, Shipped, Received |
   | total_price       | integer | virtual property                     |

### 实体关系表

1. transaction_items
   | property   | type    | constrain   |
   | ---------- | ------- | ----------- |
   | id         | integer | primary key |
   | order_id   | integer | foreign key |
   | product_id | integer | foreign key |
   | number     | integer | $\ge$ 1   |
2. cart_items
   | property | type    | constrain   |
   | -------- | ------- | ----------- |
   | user_id  | integer | foreign key |
   | product  | integer | foreign key |
   | quantity | integer | $\ge$ 1   |
3. favorites_items
   | property | type    | constrain   |
   | -------- | ------- | ----------- |
   | user_id  | integer | foreign key |
   | product  | integer | foreign key |

### 实体关系

- products 与 design, color, size, type多对一
- transaction_orders 与 user 多对一
- transaction_orders 与 products 多对多, 通过 transaction_items 联系
- users 与 products 有 "加入购物车" 多对多关系, 通过 cart_items 联系
- users 与 products 有 "收藏" 多对多关系, 通过 favorites_items 联系(或者直接隐藏联表)

## 实现

图像功能依托 active_storage 开展

```cmd
bundle install
rails active_storage:install
rails db:migrate
```

用户注册等依托 devise 开展

```cmd
bundle install
rails generate devise:install
rails generate devise User
rails db:migrate
```

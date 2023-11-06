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

users

| property | type    | constrain        |
| -------- | ------- | ---------------- |
| id       | integer | primary key      |
| username | string  | not null         |
| password | integer | min-length       |
| role     | string  | admin or others  |
| email    | string  | not null, unique |
| phone    | string  | not null, unique |

products

| property    | type    | constrain   |
| ----------- | ------- | ----------- |
| id          | integer | primary key |
| name        | string  | not null    |
| price       | decimal | not null    |
| description | text    |             |
| img         |         |             |
| design      | integer | foreign key |
| color       | integer | foreign key |
| size        | integer | foreign key |

# 福利天天领系统 - 数据库设计

## 项目概述

本项目是一个福利天天领系统的后端实现，主要功能包括用户每日签到领取书券、观看广告领取书券以及完成任务领取书券。系统通过精心设计的数据库结构支持这些功能的实现。

## 功能模块

根据页面分析，系统主要包含以下功能模块：

1. **签到领书券**：用户每天签到可以获得不同数量的书券，连续签到7天有不同的奖励。
2. **看广告领书券**：用户可以通过观看广告获得书券，有固定额度和随机额度两种。
3. **做任务领书券**：用户完成特定任务可以获得书券奖励。

## 数据库设计

### 数据表结构

系统包含以下数据表：

1. **用户表(users)**：存储用户基本信息
2. **书券表(book_vouchers)**：记录书券的发放和使用情况
3. **签到记录表(check_ins)**：记录用户签到情况和连续签到天数
4. **签到奖励配置表(check_in_rewards)**：配置不同天数的签到奖励
5. **广告记录表(ad_views)**：记录用户观看广告的情况
6. **广告奖励配置表(ad_rewards)**：配置广告奖励的类型和数量
7. **任务表(tasks)**：存储可完成的任务信息
8. **用户任务记录表(user_tasks)**：记录用户完成任务的情况
9. **系统配置表(system_configs)**：存储签到规则等全局配置

### 表关系图

```
+----------------+       +----------------+       +----------------+
|     users      |       | check_in_rewards|       |     tasks      |
+----------------+       +----------------+       +----------------+
        |                        |                       |
        |                        |                       |
        v                        v                       v
+----------------+       +----------------+       +----------------+
|   check_ins    |       |   ad_rewards   |       |   user_tasks   |
+----------------+       +----------------+       +----------------+
        |                        |                       |
        |                        |                       |
        v                        v                       v
+----------------+       +----------------+       +----------------+
| book_vouchers  | <---- |    ad_views    |       | system_configs |
+----------------+       +----------------+       +----------------+
```

## 主要业务流程

### 签到流程

1. 用户进行签到操作
2. 系统检查用户当天是否已签到
3. 如未签到，记录签到信息并计算连续签到天数
4. 根据连续签到天数从签到奖励配置表获取对应奖励
5. 生成书券记录并更新用户书券余额

### 广告奖励流程

1. 用户观看广告
2. 系统记录广告观看记录
3. 根据广告类型（固定/随机）计算奖励书券数量
4. 生成书券记录并更新用户书券余额

### 任务奖励流程

1. 用户完成任务
2. 系统更新用户任务进度和状态
3. 任务完成后，用户可领取奖励
4. 生成书券记录并更新用户书券余额

## 数据表初始化

系统已预设了以下数据：

1. 签到奖励配置：7天连续签到的奖励分别为30、100、60、70、80、100、150书券
2. 广告奖励配置：包含固定奖励和随机奖励两种类型
3. 任务配置：添加小程序至桌面、订阅消息提醒、阅读小说等任务
4. 系统配置：签到规则说明

## 使用说明

1. 数据库表结构定义在 `database/schema.sql` 文件中
2. 执行该SQL文件可创建完整的数据库结构并初始化基础数据
3. 系统使用MySQL数据库，建议版本5.7及以上

## 注意事项

1. 书券有效期为7天，过期后自动失效
2. 每日任务在次日0点重置
3. 连续签到中断后，连续天数重新从1开始计算
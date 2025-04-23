-- 用户表
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `balance` int(11) NOT NULL DEFAULT 0 COMMENT '书券余额',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `last_login` datetime DEFAULT NULL COMMENT '最后登录时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '账号状态：1-正常，0-禁用',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`),
  UNIQUE KEY `idx_email` (`email`),
  UNIQUE KEY `idx_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 书券表
CREATE TABLE `book_vouchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `amount` int(11) NOT NULL COMMENT '书券数量',
  `source` varchar(20) NOT NULL COMMENT '来源：签到、广告、任务',
  `source_id` int(11) DEFAULT NULL COMMENT '来源ID',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1-有效，0-已使用，-1-已过期',
  `expire_at` datetime NOT NULL COMMENT '过期时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `used_at` datetime DEFAULT NULL COMMENT '使用时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_source` (`source`),
  KEY `idx_status` (`status`),
  KEY `idx_expire_at` (`expire_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='书券表';

-- 签到记录表
CREATE TABLE `check_ins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `check_in_date` date NOT NULL COMMENT '签到日期',
  `consecutive_days` int(11) NOT NULL DEFAULT 1 COMMENT '当前连续签到天数',
  `reward_amount` int(11) NOT NULL COMMENT '获得的书券数量',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_date` (`user_id`, `check_in_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='签到记录表';

-- 签到奖励配置表
CREATE TABLE `check_in_rewards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `day` int(11) NOT NULL COMMENT '第几天',
  `reward_amount` int(11) NOT NULL COMMENT '奖励书券数量',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_day` (`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='签到奖励配置表';

-- 广告记录表
CREATE TABLE `ad_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `ad_id` int(11) NOT NULL COMMENT '广告ID',
  `reward_amount` int(11) NOT NULL COMMENT '获得的书券数量',
  `viewed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '观看时间',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1-已完成，0-未完成',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_ad_id` (`ad_id`),
  KEY `idx_viewed_at` (`viewed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='广告观看记录表';

-- 广告奖励配置表
CREATE TABLE `ad_rewards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '广告名称',
  `type` tinyint(1) NOT NULL COMMENT '类型：1-固定奖励，2-随机奖励',
  `min_reward` int(11) NOT NULL COMMENT '最小奖励数量',
  `max_reward` int(11) NOT NULL COMMENT '最大奖励数量',
  `daily_limit` int(11) NOT NULL DEFAULT 1 COMMENT '每日可观看次数限制',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='广告奖励配置表';

-- 任务表
CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '任务名称',
  `description` text COMMENT '任务描述',
  `reward_amount` int(11) NOT NULL COMMENT '奖励书券数量',
  `type` varchar(20) NOT NULL COMMENT '任务类型：一次性、每日、每周等',
  `requirement` text COMMENT '完成要求',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1-启用，0-禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务表';

-- 用户任务记录表
CREATE TABLE `user_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `task_id` int(11) NOT NULL COMMENT '任务ID',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态：0-进行中，1-已完成，2-已领取奖励',
  `progress` int(11) NOT NULL DEFAULT 0 COMMENT '进度',
  `completed_at` datetime DEFAULT NULL COMMENT '完成时间',
  `rewarded_at` datetime DEFAULT NULL COMMENT '领取奖励时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_user_task` (`user_id`, `task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户任务记录表';

-- 系统配置表
CREATE TABLE `system_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL COMMENT '配置键',
  `value` text NOT NULL COMMENT '配置值',
  `description` varchar(255) DEFAULT NULL COMMENT '配置描述',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- 添加外键约束
ALTER TABLE `book_vouchers` ADD CONSTRAINT `fk_book_vouchers_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `check_ins` ADD CONSTRAINT `fk_check_ins_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `ad_views` ADD CONSTRAINT `fk_ad_views_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `ad_views` ADD CONSTRAINT `fk_ad_views_ad_id` FOREIGN KEY (`ad_id`) REFERENCES `ad_rewards` (`id`) ON DELETE CASCADE;
ALTER TABLE `user_tasks` ADD CONSTRAINT `fk_user_tasks_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `user_tasks` ADD CONSTRAINT `fk_user_tasks_task_id` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE;

-- 插入签到奖励配置数据
INSERT INTO `check_in_rewards` (`day`, `reward_amount`) VALUES
(1, 30),
(2, 100),
(3, 60),
(4, 70),
(5, 80),
(6, 100),
(7, 150);

-- 插入广告奖励配置数据
INSERT INTO `ad_rewards` (`name`, `type`, `min_reward`, `max_reward`, `daily_limit`) VALUES
('固定奖励广告1', 1, 50, 50, 1),
('随机奖励广告1', 2, 50, 200, 1),
('固定奖励广告2', 1, 50, 50, 1),
('固定奖励广告3', 1, 50, 50, 1),
('随机奖励广告2', 2, 50, 200, 1),
('固定奖励广告4', 1, 50, 50, 1),
('固定奖励广告5', 1, 50, 50, 1),
('固定奖励广告6', 1, 50, 50, 1);

-- 插入任务数据
INSERT INTO `tasks` (`name`, `description`, `reward_amount`, `type`, `requirement`) VALUES
('添加小程序至桌面', '将小程序添加到手机桌面', 30, '一次性', '添加小程序到桌面'),
('订阅消息提醒', '开启订阅消息提醒功能', 30, '一次性', '开启订阅消息提醒'),
('阅读小说', '阅读小说累计15章节', 30, '每日', '每日阅读小说15章节');

-- 插入系统配置
INSERT INTO `system_configs` (`key`, `value`, `description`) VALUES
('check_in_rule', '1. 每日签到可得书券，连续签到7天每日可得150书券。
2. 每日做任务可得书券，次日0点重新任务。
3. 书券有效期为7天，过期后自动失效。', '签到规则');

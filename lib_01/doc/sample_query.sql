CREATE
CREATE TABLE automobiles(id int(4),name varchar(16),type varchar(64),displacement varchar(8),max_speed varchar(8));

INSERT
INSERT INTO `automobiles`(`id`, `name`, `displacement`, `type`, `max_speed`) VALUES (1,'karizmaZMR','223cc','4-strokesinglecylinder','129kmph');


CREATE TABLE demo(id int(4),text_flat varchar(16),text_area varchar(64),decimal_flat decimal(5,3),image varchar(8),documents varchar(8),option_single varchar(10),option_multiple varchar(10),fiben_table varchar(10),sample_date DATE,range_level varchar(10),toggle_switch tinyint(2),auto_complete varchar(20),created_at TIMESTAMP,user_id int(4));




ALTER TABLE demo CHANGE salary salary_dec decimal(5,3);

ALTER TABLE demo CHANGE option_box option_single varchar(10);


ALTER TABLE demo ADD option_multiple varchar(10);

--
-- Table structure for table `user_info_log`
--



CREATE TABLE `demo` (
  `id` int(11) NOT NULL,
  `text_flat` varchar(64) DEFAULT NULL,
  `text_area` varchar(128) DEFAULT NULL,
  `decimal_flat` decimal(5,3) DEFAULT NULL,
  `image` varchar(32) DEFAULT NULL,
  `documents` varchar(32) DEFAULT NULL,
  `option_single` varchar(32) DEFAULT NULL,
  `option_multiple` varchar(32) DEFAULT NULL,
  `fiben_table` varchar(32) DEFAULT NULL,
  `date_flat` date DEFAULT NULL,
  `range` varchar(8) DEFAULT NULL,
  `toggle_switch` tinyint(1) DEFAULT NULL,
  `autocomplete` varchar(32) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `demo`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `demo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;





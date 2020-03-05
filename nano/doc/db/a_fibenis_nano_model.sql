-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 05, 2020 at 06:47 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: fibenis_nano
--

-- --------------------------------------------------------

--
-- Table structure for table demo
--

CREATE TABLE demo (
  id int(11) NOT NULL,
  text_flat varchar(64) DEFAULT NULL,
  text_area text,
  decimal_flat decimal(5,3) DEFAULT NULL,
  image_flat varchar(32) DEFAULT NULL,
  documents varchar(32) DEFAULT NULL,
  option_single varchar(32) DEFAULT NULL,
  option_multiple varchar(256) DEFAULT NULL,
  fiben_table text,
  date_flat date DEFAULT NULL,
  range_flat varchar(64) DEFAULT NULL,
  toggle_switch tinyint(1) DEFAULT NULL,
  autocomplete varchar(64) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  left_right text,
  text_editor text,
  code_editor text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table demo_page_info
--

CREATE TABLE demo_page_info (
  id int(11) NOT NULL,
  title varchar(128) DEFAULT NULL,
  content text,
  user_id int(11) NOT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_bool
--

CREATE TABLE eav_addon_bool (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value tinyint(1) DEFAULT '0',
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_date
--

CREATE TABLE eav_addon_date (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value date DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_decimal
--

CREATE TABLE eav_addon_decimal (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value decimal(10,4) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_ecb_id
--

CREATE TABLE eav_addon_ecb_id (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ecb_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_ec_id
--

CREATE TABLE eav_addon_ec_id (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ec_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_exa_token
--

CREATE TABLE eav_addon_exa_token (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  exa_value_token varchar(32) NOT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_num
--

CREATE TABLE eav_addon_num (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value int(16) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_text
--

CREATE TABLE eav_addon_text (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value text,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_varchar
--

CREATE TABLE eav_addon_varchar (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value varchar(1024) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_vc128uniq
--

CREATE TABLE eav_addon_vc128uniq (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value varchar(128) DEFAULT NULL,
  ea_value_hash varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers eav_addon_vc128uniq
--
DELIMITER $$
CREATE TRIGGER trg_eav_addon_vc128uniq_before_ins BEFORE INSERT ON eav_addon_vc128uniq FOR EACH ROW BEGIN

 IF(LENGTH(new.ea_value)=0) THEN
        
            SET new.ea_value = new.id;
    END IF;        
            SET new.ea_value_hash=md5(concat(new.ea_code,'[C]',new.ea_value));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER trg_eav_addon_vc128uniq_before_upd BEFORE UPDATE ON eav_addon_vc128uniq FOR EACH ROW BEGIN

     IF(LENGTH(new.ea_value)=0) THEN
        
            SET new.ea_value = new.id;
    END IF;        
            SET new.ea_value_hash=md5(concat(new.ea_code,'[C]',new.ea_value));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table ecb_av_addon_text
--

CREATE TABLE ecb_av_addon_text (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value text,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table ecb_av_addon_varchar
--

CREATE TABLE ecb_av_addon_varchar (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value varchar(1024) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table ecb_parent_child_matrix
--

CREATE TABLE ecb_parent_child_matrix (
  id int(11) NOT NULL,
  ecb_parent_id int(11) DEFAULT NULL,
  ecb_child_id int(11) DEFAULT NULL,
  parent_child_hash varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table entity
--

CREATE TABLE entity (
  id int(11) NOT NULL,
  code varchar(4) DEFAULT NULL,
  sn varchar(64) DEFAULT NULL,
  ln varchar(1024) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_lib tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table entity_attribute
--

CREATE TABLE entity_attribute (
  id int(11) NOT NULL,
  entity_code varchar(4) DEFAULT NULL,
  code char(4) DEFAULT NULL,
  sn varchar(64) DEFAULT NULL,
  ln varchar(1024) DEFAULT NULL,
  line_order decimal(10,2) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table entity_child
--

CREATE TABLE entity_child (
  id int(11) NOT NULL,
  entity_code varchar(4) DEFAULT NULL,
  line_order decimal(10,2) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  is_active tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table entity_child_base
--

CREATE TABLE entity_child_base (
  id int(11) NOT NULL,
  entity_code varchar(4) DEFAULT NULL,
  token varchar(32) DEFAULT NULL,
  sn varchar(64) DEFAULT NULL,
  ln varchar(1024) DEFAULT NULL,
  note text,
  parent_id int(11) DEFAULT NULL,
  dna_code varchar(32) DEFAULT NULL,
  created_by int(11) DEFAULT NULL,
  creation datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  line_order decimal(10,2) DEFAULT NULL,
  is_active tinyint(1) DEFAULT '1',
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers entity_child_base
--
DELIMITER $$
CREATE TRIGGER trg_entity_child_base_before_ins BEFORE INSERT ON entity_child_base FOR EACH ROW BEGIN
IF(LENGTH(new.token)=0) THEN
        
            SET new.token=((SELECT id FROM entity_child_base ORDER BY id DESC LIMIT 0,1)+1);
            
            END IF;
  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER trg_entity_child_base_before_upd BEFORE UPDATE ON entity_child_base FOR EACH ROW BEGIN

    IF(LENGTH(new.token)=0) THEN        
            SET new.token = concat(new.token,'');
    END IF; 
    
END
$$
DELIMITER ;



--
-- Table structure for table entity_key_value
--

CREATE TABLE entity_key_value (
  id int(11) NOT NULL,
  coach_id int(11) DEFAULT NULL,
  entity_code varchar(4) DEFAULT NULL,
  domain_hash varchar(32) DEFAULT NULL,
  entity_key varchar(128) DEFAULT NULL,
  entity_value varchar(256) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_date
--

CREATE TABLE exav_addon_date (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value date DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_decimal
--

CREATE TABLE exav_addon_decimal (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value decimal(14,4) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_ec_id
--

CREATE TABLE exav_addon_ec_id (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  ec_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_exa_token
--

CREATE TABLE exav_addon_exa_token (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value_token varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_num
--

CREATE TABLE exav_addon_num (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value int(16) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_text
--

CREATE TABLE exav_addon_text (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value text,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_varchar
--

CREATE TABLE exav_addon_varchar (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value varchar(1024) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_vc128uniq
--

CREATE TABLE exav_addon_vc128uniq (
  id int(11) NOT NULL,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value varchar(128) DEFAULT NULL,
  exa_value_hash varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers exav_addon_vc128uniq
--
DELIMITER $$
CREATE TRIGGER trg_exav_addon_vc128uniq_before_ins BEFORE INSERT ON exav_addon_vc128uniq FOR EACH ROW BEGIN

 IF(LENGTH(new.exa_value)=0) THEN
        
            SET new.exa_value = new.id;
    END IF;        
            SET new.exa_value_hash=md5(concat(new.exa_token,'[C]',new.exa_value));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER trg_exav_addon_vc128uniq_before_upd BEFORE UPDATE ON exav_addon_vc128uniq FOR EACH ROW BEGIN

     IF(LENGTH(new.exa_value)=0) THEN
        
            SET new.exa_value = new.id;
    END IF;        
            SET new.exa_value_hash=md5(concat(new.exa_token,'[C]',new.exa_value));
END
$$
DELIMITER ;

--
-- Table structure for table status_info
--

CREATE TABLE status_info (
  id int(11) NOT NULL,
  status_code varchar(32) DEFAULT NULL,
  entity_code varchar(4) DEFAULT NULL,
  child_comm_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  note varchar(1024) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table status_map
--

CREATE TABLE status_map (
  id int(11) NOT NULL,
  entity_code varchar(4) DEFAULT NULL,
  status_code_start varchar(32) DEFAULT NULL,
  status_code_end varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table sys_log
--

CREATE TABLE sys_log (
  id int(11) NOT NULL,
  sys_access_ip varchar(32) DEFAULT NULL,
  sys_access_name varchar(32) DEFAULT NULL,
  page_code varchar(32) DEFAULT NULL,
  action varchar(512) DEFAULT NULL,
  action_type varchar(32) DEFAULT NULL,
  access_key varchar(128) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_info
--

CREATE TABLE user_info (
  id int(11) NOT NULL,
  password varchar(32) NOT NULL,
  user_role_id int(11) DEFAULT NULL,
  is_mail_check tinyint(1) DEFAULT NULL,
  is_active tinyint(1) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  is_send_mail tinyint(1) DEFAULT NULL,
  is_send_welcome_mail tinyint(1) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_login timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  is_internal int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_info_log
--

CREATE TABLE user_info_log (
  log_id int(11) NOT NULL,
  id int(11) NOT NULL,
  password varchar(32) DEFAULT NULL,
  user_role_id int(11) DEFAULT NULL,
  is_mail_check tinyint(1) DEFAULT NULL,
  is_active tinyint(1) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  is_send_mail tinyint(1) DEFAULT NULL,
  is_send_welcome_mail tinyint(1) DEFAULT NULL,
  timestamp_punch datetime DEFAULT NULL,
  last_login timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  log_type_code varchar(32) DEFAULT NULL,
  timestamp_log datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role
--

CREATE TABLE user_role (
  id int(11) NOT NULL,
  sn char(3) DEFAULT NULL,
  ln varchar(1024) DEFAULT NULL,
  home_page_url varchar(256) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role_page
--

CREATE TABLE user_role_page (
  id int(11) NOT NULL,
  user_role_id int(11) DEFAULT NULL,
  sn varchar(256) NOT NULL,
  user_page_ids text,
  line_order decimal(5,2) NOT NULL,
  creation datetime NOT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role_page_matrix
--

CREATE TABLE user_role_page_matrix (
  id int(11) NOT NULL,
  user_role_page_id int(11) DEFAULT NULL,
  user_page_id int(11) DEFAULT NULL,
  parent_id int(11) DEFAULT NULL,
  sn varchar(128) DEFAULT NULL,
  line_order decimal(5,2) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role_permission
--

CREATE TABLE user_role_permission (
  id int(11) NOT NULL,
  user_role_id int(11) DEFAULT NULL,
  user_permission_ids text,
  creation datetime NOT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role_permission_matrix
--

CREATE TABLE user_role_permission_matrix (
  id int(11) NOT NULL,
  user_role_id int(11) DEFAULT NULL,
  user_permission_id int(11) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure for view entity_count
--
DROP TABLE IF EXISTS entity_count;

CREATE  VIEW entity_count  AS  select entity_child.entity_code AS entity_code,count(0) AS count from entity_child group by entity_child.entity_code order by entity_child.entity_code ;

-- --------------------------------------------------------

--
-- Structure for view entity_ec_count
--
DROP TABLE IF EXISTS entity_ec_count;

CREATE  VIEW entity_ec_count  AS  select entity.code AS code,entity.sn AS sn,(select count(0) from entity_child where (entity_child.entity_code = entity.code)) AS count from entity group by entity.code order by entity.sn ;

-- --------------------------------------------------------

--
-- Structure for view page_view_log_by_day
--
DROP TABLE IF EXISTS page_view_log_by_day;

CREATE  VIEW page_view_log_by_day  AS  select date_format(sys_log.timestamp_punch,'%Y-%m-%d') AS date,sys_log.page_code AS page_code,count(0) AS total from sys_log group by date_format(sys_log.timestamp_punch,'%d-%b-%Y'),sys_log.page_code ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table demo
--
ALTER TABLE demo
  ADD PRIMARY KEY (id);

--
-- Indexes for table demo_page_info
--
ALTER TABLE demo_page_info
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY title (title);

--
-- Indexes for table eav_addon_bool
--
ALTER TABLE eav_addon_bool
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table eav_addon_date
--
ALTER TABLE eav_addon_date
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY ea_value (ea_value),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table eav_addon_ecb_id
--
ALTER TABLE eav_addon_ecb_id
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id),
  ADD KEY ecb_id (ecb_id);

--
-- Indexes for table eav_addon_ec_id
--
ALTER TABLE eav_addon_ec_id
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY ec_id (ec_id),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table eav_addon_exa_token
--
ALTER TABLE eav_addon_exa_token
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY exa_value_token (exa_value_token),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table eav_addon_num
--
ALTER TABLE eav_addon_num
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table eav_addon_text
--
ALTER TABLE eav_addon_text
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table eav_addon_varchar
--
ALTER TABLE eav_addon_varchar
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table eav_addon_vc128uniq
--
ALTER TABLE eav_addon_vc128uniq
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table ecb_av_addon_text
--
ALTER TABLE ecb_av_addon_text
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table ecb_av_addon_varchar
--
ALTER TABLE ecb_av_addon_varchar
  ADD PRIMARY KEY (id),
  ADD KEY ea_code (ea_code),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table ecb_parent_child_matrix
--
ALTER TABLE ecb_parent_child_matrix
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id),
  ADD KEY fk_ecb_parent_child_matrix_ecb_parent_id (ecb_parent_id);

--
-- Indexes for table entity
--
ALTER TABLE entity
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY code (code),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY fk_entity_user_id (user_id);

--
-- Indexes for table entity_attribute
--
ALTER TABLE entity_attribute
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY code (code),
  ADD KEY entity_code (entity_code),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY fk_entity_attribute_user_id (user_id);

--
-- Indexes for table entity_child
--
ALTER TABLE entity_child
  ADD PRIMARY KEY (id),
  ADD KEY entity_code (entity_code),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table entity_child_base
--
ALTER TABLE entity_child_base
  ADD PRIMARY KEY (id),
  ADD KEY entity_code (entity_code),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY token (token),
  ADD KEY fk_entity_child_base_user_id (user_id);

--
-- Indexes for table entity_key_value
--
ALTER TABLE entity_key_value
  ADD PRIMARY KEY (id),
  ADD KEY coach_id (coach_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY fk_entity_key_value_entity_code (entity_code),
  ADD KEY fk_entity_key_value_user_id (user_id);

--
-- Indexes for table exav_addon_date
--
ALTER TABLE exav_addon_date
  ADD PRIMARY KEY (id),
  ADD KEY exa_token (exa_token),
  ADD KEY exa_value (exa_value),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table exav_addon_decimal
--
ALTER TABLE exav_addon_decimal
  ADD PRIMARY KEY (id),
  ADD KEY exa_token (exa_token),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table exav_addon_ec_id
--
ALTER TABLE exav_addon_ec_id
  ADD PRIMARY KEY (id),
  ADD KEY exa_token (exa_token),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id),
  ADD KEY fk_exav_addon_ec_id_ec_id (ec_id);

--
-- Indexes for table exav_addon_exa_token
--
ALTER TABLE exav_addon_exa_token
  ADD PRIMARY KEY (id),
  ADD KEY exa_token (exa_token),
  ADD KEY exa_value_token (exa_value_token),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table exav_addon_num
--
ALTER TABLE exav_addon_num
  ADD PRIMARY KEY (id),
  ADD KEY exa_token (exa_token),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table exav_addon_text
--
ALTER TABLE exav_addon_text
  ADD PRIMARY KEY (id),
  ADD KEY exa_token (exa_token),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table exav_addon_varchar
--
ALTER TABLE exav_addon_varchar
  ADD PRIMARY KEY (id),
  ADD KEY exa_token (exa_token),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table exav_addon_vc128uniq
--
ALTER TABLE exav_addon_vc128uniq
  ADD PRIMARY KEY (id),
  ADD KEY exa_token (exa_token),
  ADD KEY parent_id (parent_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_id (user_id);

--
-- Indexes for table status_info
--
ALTER TABLE status_info
  ADD PRIMARY KEY (id),
  ADD KEY status_code (status_code),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY fk_status_info_entity_code (entity_code),
  ADD KEY fk_status_info_user_id (user_id),
  ADD KEY fk_status_info_child_comm_id (child_comm_id);

--
-- Indexes for table status_map
--
ALTER TABLE status_map
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY fk_status_map_entity_code (entity_code),
  ADD KEY fk_status_map_user_id (user_id),
  ADD KEY fk_status_map_status_code_start (status_code_start),
  ADD KEY fk_status_map_status_code_end (status_code_end);

--
-- Indexes for table sys_log
--
ALTER TABLE sys_log
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch (timestamp_punch);

--
-- Indexes for table user_info
--
ALTER TABLE user_info
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY is_internal (is_internal),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_role_id (user_role_id);

--
-- Indexes for table user_info_log
--
ALTER TABLE user_info_log
  ADD PRIMARY KEY (log_id),
  ADD KEY timestamp_punch (timestamp_punch);

--
-- Indexes for table user_role
--
ALTER TABLE user_role
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY sn (sn),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY fk_user_role_user_id (user_id);

--
-- Indexes for table user_role_page
--
ALTER TABLE user_role_page
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY fk_user_role_permission_user_id (user_id),
  ADD KEY user_role_page_ibfk_1 (user_role_id),
  ADD KEY line_order (line_order);

--
-- Indexes for table user_role_page_matrix
--
ALTER TABLE user_role_page_matrix
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_role_id (user_role_page_id),
  ADD KEY fk_user_role_permission_matrix_user_permission_id (user_page_id),
  ADD KEY parent_id (parent_id);

--
-- Indexes for table user_role_permission
--
ALTER TABLE user_role_permission
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY fk_user_role_permission_user_role_id (user_role_id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY fk_user_role_permission_user_id (user_id);

--
-- Indexes for table user_role_permission_matrix
--
ALTER TABLE user_role_permission_matrix
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch (timestamp_punch),
  ADD KEY user_role_id (user_role_id),
  ADD KEY fk_user_role_permission_matrix_user_permission_id (user_permission_id);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table demo
--
ALTER TABLE demo
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table demo_page_info
--
ALTER TABLE demo_page_info
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table eav_addon_bool
--
ALTER TABLE eav_addon_bool
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table eav_addon_date
--
ALTER TABLE eav_addon_date
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_ecb_id
--
ALTER TABLE eav_addon_ecb_id
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_ec_id
--
ALTER TABLE eav_addon_ec_id
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2894;

--
-- AUTO_INCREMENT for table eav_addon_exa_token
--
ALTER TABLE eav_addon_exa_token
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_num
--
ALTER TABLE eav_addon_num
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_text
--
ALTER TABLE eav_addon_text
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=734;

--
-- AUTO_INCREMENT for table eav_addon_varchar
--
ALTER TABLE eav_addon_varchar
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13438;

--
-- AUTO_INCREMENT for table eav_addon_vc128uniq
--
ALTER TABLE eav_addon_vc128uniq
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- AUTO_INCREMENT for table ecb_av_addon_text
--
ALTER TABLE ecb_av_addon_text
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table ecb_av_addon_varchar
--
ALTER TABLE ecb_av_addon_varchar
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28581;

--
-- AUTO_INCREMENT for table ecb_parent_child_matrix
--
ALTER TABLE ecb_parent_child_matrix
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7888;

--
-- AUTO_INCREMENT for table entity
--
ALTER TABLE entity
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT for table entity_attribute
--
ALTER TABLE entity_attribute
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=447;

--
-- AUTO_INCREMENT for table entity_child
--
ALTER TABLE entity_child
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5145;

--
-- AUTO_INCREMENT for table entity_child_base
--
ALTER TABLE entity_child_base
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4800;

--
-- AUTO_INCREMENT for table entity_key_value
--
ALTER TABLE entity_key_value
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table exav_addon_date
--
ALTER TABLE exav_addon_date
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table exav_addon_decimal
--
ALTER TABLE exav_addon_decimal
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table exav_addon_ec_id
--
ALTER TABLE exav_addon_ec_id
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table exav_addon_exa_token
--
ALTER TABLE exav_addon_exa_token
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table exav_addon_num
--
ALTER TABLE exav_addon_num
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT for table exav_addon_text
--
ALTER TABLE exav_addon_text
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1253;

--
-- AUTO_INCREMENT for table exav_addon_varchar
--
ALTER TABLE exav_addon_varchar
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=497;

--
-- AUTO_INCREMENT for table exav_addon_vc128uniq
--
ALTER TABLE exav_addon_vc128uniq
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table status_info
--
ALTER TABLE status_info
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table status_map
--
ALTER TABLE status_map
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table sys_log
--
ALTER TABLE sys_log
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53775;

--
-- AUTO_INCREMENT for table user_info
--
ALTER TABLE user_info
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table user_info_log
--
ALTER TABLE user_info_log
  MODIFY log_id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4197;

--
-- AUTO_INCREMENT for table user_role
--
ALTER TABLE user_role
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table user_role_page
--
ALTER TABLE user_role_page
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table user_role_page_matrix
--
ALTER TABLE user_role_page_matrix
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table user_role_permission
--
ALTER TABLE user_role_permission
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table user_role_permission_matrix
--
ALTER TABLE user_role_permission_matrix
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18652;

--
-- Constraints for dumped tables
--

--
-- Constraints for table eav_addon_bool
--
ALTER TABLE eav_addon_bool
  ADD CONSTRAINT eav_addon_bool_ibfk_1 FOREIGN KEY (user_id) REFERENCES user_info (id),
  ADD CONSTRAINT eav_addon_codE_fk FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON UPDATE CASCADE,
  ADD CONSTRAINT eav_addon_parent_fk FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_date
--
ALTER TABLE eav_addon_date
  ADD CONSTRAINT fk_eav_addon_date_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_date_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_date_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  ADD CONSTRAINT fk_eav_addon_decimal_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_decimal_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_decimal_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_ecb_id
--
ALTER TABLE eav_addon_ecb_id
  ADD CONSTRAINT eav_addon_ecb_id_ibfk_1 FOREIGN KEY (ecb_id) REFERENCES entity_child_base (id),
  ADD CONSTRAINT eav_addon_ecb_id_ibfk_2 FOREIGN KEY (parent_id) REFERENCES entity_child (id),
  ADD CONSTRAINT eav_addon_ecb_id_ibfk_3 FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON UPDATE CASCADE;

--
-- Constraints for table eav_addon_ec_id
--
ALTER TABLE eav_addon_ec_id
  ADD CONSTRAINT fk_eav_addon_ec_id_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_ec_id_ec_id FOREIGN KEY (ec_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_ec_id_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_ec_id_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_exa_token
--
ALTER TABLE eav_addon_exa_token
  ADD CONSTRAINT fk_eav_addon_exa_token_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_exa_token_exa_value_token FOREIGN KEY (exa_value_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_exa_token_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_exa_token_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_num
--
ALTER TABLE eav_addon_num
  ADD CONSTRAINT fk_eav_addon_num_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_num_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_num_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_text
--
ALTER TABLE eav_addon_text
  ADD CONSTRAINT fk_eav_addon_text_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_text_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_text_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_varchar
--
ALTER TABLE eav_addon_varchar
  ADD CONSTRAINT fk_eav_addon_varchar_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_varchar_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_varchar_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_vc128uniq
--
ALTER TABLE eav_addon_vc128uniq
  ADD CONSTRAINT fk_eav_addon_vc128uniq_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_vc128uniq_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_vc128uniq_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table ecb_av_addon_varchar
--
ALTER TABLE ecb_av_addon_varchar
  ADD CONSTRAINT fk_ecb_av_addon_varchar_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_ecb_av_addon_varchar_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child_base (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_ecb_av_addon_varchar_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table ecb_parent_child_matrix
--
ALTER TABLE ecb_parent_child_matrix
  ADD CONSTRAINT fk_ecb_parent_child_matrix_ecb_parent_id FOREIGN KEY (ecb_parent_id) REFERENCES entity_child_base (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_ecb_parent_child_matrix_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity
--
ALTER TABLE entity
  ADD CONSTRAINT fk_entity_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity_attribute
--
ALTER TABLE entity_attribute
  ADD CONSTRAINT fk_entity_attribute_entity_code FOREIGN KEY (entity_code) REFERENCES entity (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_entity_attribute_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity_child
--
ALTER TABLE entity_child
  ADD CONSTRAINT fk_entity_child_entity_code FOREIGN KEY (entity_code) REFERENCES entity (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_entity_child_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity_child_base
--
ALTER TABLE entity_child_base
  ADD CONSTRAINT fk_entity_child_base_entity_code FOREIGN KEY (entity_code) REFERENCES entity (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_entity_child_base_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity_key_value
--
ALTER TABLE entity_key_value
  ADD CONSTRAINT fk_entity_key_value_entity_code FOREIGN KEY (entity_code) REFERENCES entity (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_entity_key_value_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_date
--
ALTER TABLE exav_addon_date
  ADD CONSTRAINT fk_exav_addon_date_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_date_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_date_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_decimal
--
ALTER TABLE exav_addon_decimal
  ADD CONSTRAINT fk_exav_addon_decimal_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_decimal_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_decimal_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_ec_id
--
ALTER TABLE exav_addon_ec_id
  ADD CONSTRAINT fk_exav_addon_ec_id_ec_id FOREIGN KEY (ec_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_ec_id_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_ec_id_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_ec_id_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_exa_token
--
ALTER TABLE exav_addon_exa_token
  ADD CONSTRAINT fk_exav_addon_exa_token_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_exa_token_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_exa_token_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_num
--
ALTER TABLE exav_addon_num
  ADD CONSTRAINT fk_exav_addon_num_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_num_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_num_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_text
--
ALTER TABLE exav_addon_text
  ADD CONSTRAINT fk_exav_addon_text_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_text_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_text_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_varchar
--
ALTER TABLE exav_addon_varchar
  ADD CONSTRAINT fk_exav_addon_varchar_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_varchar_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_varchar_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_vc128uniq
--
ALTER TABLE exav_addon_vc128uniq
  ADD CONSTRAINT fk_exav_addon_vc128uniq_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_vc128uniq_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_vc128uniq_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table status_info
--
ALTER TABLE status_info
  ADD CONSTRAINT fk_status_info_child_comm_id FOREIGN KEY (child_comm_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_info_entity_code FOREIGN KEY (entity_code) REFERENCES entity (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_info_status_code FOREIGN KEY (status_code) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_info_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table status_map
--
ALTER TABLE status_map
  ADD CONSTRAINT fk_status_map_entity_code FOREIGN KEY (entity_code) REFERENCES entity (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_map_status_code_end FOREIGN KEY (status_code_end) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_map_status_code_start FOREIGN KEY (status_code_start) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_map_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table user_info
--
ALTER TABLE user_info
  ADD CONSTRAINT fk_user_info_is_internal FOREIGN KEY (is_internal) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_user_info_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_role (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table user_role
--
ALTER TABLE user_role
  ADD CONSTRAINT fk_user_role_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table user_role_page
--
ALTER TABLE user_role_page
  ADD CONSTRAINT user_role_page_ibfk_1 FOREIGN KEY (user_role_id) REFERENCES user_role (id) ON UPDATE CASCADE;

--
-- Constraints for table user_role_page_matrix
--
ALTER TABLE user_role_page_matrix
  ADD CONSTRAINT user_role_page_matrix_ibfk_1 FOREIGN KEY (user_role_page_id) REFERENCES user_role_page (id) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table user_role_permission
--
ALTER TABLE user_role_permission
  ADD CONSTRAINT fk_user_role_permission_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_user_role_permission_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_role (id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table user_role_permission_matrix
--
ALTER TABLE user_role_permission_matrix
  ADD CONSTRAINT fk_user_role_permission_matrix_user_permission_id FOREIGN KEY (user_permission_id) REFERENCES ecb_parent_child_matrix (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_user_role_permission_matrix_user_role_id FOREIGN KEY (user_role_id) REFERENCES user_role (id) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

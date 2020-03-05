-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 05, 2020 at 06:18 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.1

SET FOREIGN_KEY_CHECKS=0;
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

CREATE TABLE demo(
  idint(11) NOT NULL,
  text_flatvarchar(64) DEFAULT NULL,
  text_areatext,
  decimal_flatdecimal(5,3) DEFAULT NULL,
  image_flatvarchar(32) DEFAULT NULL,
  documentsvarchar(32) DEFAULT NULL,
  option_singlevarchar(32) DEFAULT NULL,
  option_multiplevarchar(256) DEFAULT NULL,
  fiben_tabletext,
  date_flatdate DEFAULT NULL,
  range_flatvarchar(64) DEFAULT NULL,
  toggle_switchtinyint(1) DEFAULT NULL,
  autocompletevarchar(64) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  creationdatetime DEFAULT CURRENT_TIMESTAMP,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  left_righttext,
  text_editortext,
  code_editortext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table demo_page_info
--

CREATE TABLE demo_page_info(
  idint(11) NOT NULL,
  titlevarchar(128) DEFAULT NULL,
  contenttext,
  user_idint(11) NOT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_bool
--

CREATE TABLE eav_addon_bool(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valuetinyint(1) DEFAULT '0',
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_date
--

CREATE TABLE eav_addon_date(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valuedate DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_decimal
--

CREATE TABLE eav_addon_decimal(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valuedecimal(10,4) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_ecb_id
--

CREATE TABLE eav_addon_ecb_id(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ecb_idint(11) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_ec_id
--

CREATE TABLE eav_addon_ec_id(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ec_idint(11) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_exa_token
--

CREATE TABLE eav_addon_exa_token(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  exa_value_tokenvarchar(32) NOT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_num
--

CREATE TABLE eav_addon_num(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valueint(16) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_text
--

CREATE TABLE eav_addon_text(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valuetext,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_varchar
--

CREATE TABLE eav_addon_varchar(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valuevarchar(1024) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_vc128uniq
--

CREATE TABLE eav_addon_vc128uniq(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valuevarchar(128) DEFAULT NULL,
  ea_value_hashvarchar(32) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers eav_addon_vc128uniq
--
DELIMITER $$
CREATE TRIGGER trg_eav_addon_vc128uniq_before_insBEFORE INSERT ON eav_addon_vc128uniqFOR EACH ROW BEGIN

 IF(LENGTH(new.ea_value)=0) THEN
        
            SET new.ea_value = new.id;
    END IF;        
            SET new.ea_value_hash=md5(concat(new.ea_code,'[C]',new.ea_value));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER trg_eav_addon_vc128uniq_before_updBEFORE UPDATE ON eav_addon_vc128uniqFOR EACH ROW BEGIN

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

CREATE TABLE ecb_av_addon_text(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valuetext,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table ecb_av_addon_varchar
--

CREATE TABLE ecb_av_addon_varchar(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  ea_codechar(4) DEFAULT NULL,
  ea_valuevarchar(1024) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table ecb_parent_child_matrix
--

CREATE TABLE ecb_parent_child_matrix(
  idint(11) NOT NULL,
  ecb_parent_idint(11) DEFAULT NULL,
  ecb_child_idint(11) DEFAULT NULL,
  parent_child_hashvarchar(32) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table entity
--

CREATE TABLE entity(
  idint(11) NOT NULL,
  codevarchar(4) DEFAULT NULL,
  snvarchar(64) DEFAULT NULL,
  lnvarchar(1024) DEFAULT NULL,
  creationdatetime DEFAULT CURRENT_TIMESTAMP,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_libtinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table entity_attribute
--

CREATE TABLE entity_attribute(
  idint(11) NOT NULL,
  entity_codevarchar(4) DEFAULT NULL,
  codechar(4) DEFAULT NULL,
  snvarchar(64) DEFAULT NULL,
  lnvarchar(1024) DEFAULT NULL,
  line_orderdecimal(10,2) DEFAULT NULL,
  creationdatetime DEFAULT CURRENT_TIMESTAMP,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table entity_child
--

CREATE TABLE entity_child(
  idint(11) NOT NULL,
  entity_codevarchar(4) DEFAULT NULL,
  line_orderdecimal(10,2) DEFAULT NULL,
  creationdatetime DEFAULT CURRENT_TIMESTAMP,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  user_idint(11) DEFAULT NULL,
  is_activetinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table entity_child_base
--

CREATE TABLE entity_child_base(
  idint(11) NOT NULL,
  entity_codevarchar(4) DEFAULT NULL,
  tokenvarchar(32) DEFAULT NULL,
  snvarchar(64) DEFAULT NULL,
  lnvarchar(1024) DEFAULT NULL,
  notetext,
  parent_idint(11) DEFAULT NULL,
  dna_codevarchar(32) DEFAULT NULL,
  created_byint(11) DEFAULT NULL,
  creationdatetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  line_orderdecimal(10,2) DEFAULT NULL,
  is_activetinyint(1) DEFAULT '1',
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers entity_child_base
--
DELIMITER $$
CREATE TRIGGER trg_entity_child_base_before_insBEFORE INSERT ON entity_child_baseFOR EACH ROW BEGIN
IF(LENGTH(new.token)=0) THEN
        
            SET new.token=((SELECT id FROM entity_child_base ORDER BY id DESC LIMIT 0,1)+1);
            
            END IF;
  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER trg_entity_child_base_before_updBEFORE UPDATE ON entity_child_baseFOR EACH ROW BEGIN

    IF(LENGTH(new.token)=0) THEN        
            SET new.token = concat(new.token,'');
    END IF; 
    
END
$$
DELIMITER ;

--
-- Table structure for table entity_key_value
--

CREATE TABLE entity_key_value(
  idint(11) NOT NULL,
  coach_idint(11) DEFAULT NULL,
  entity_codevarchar(4) DEFAULT NULL,
  domain_hashvarchar(32) DEFAULT NULL,
  entity_keyvarchar(128) DEFAULT NULL,
  entity_valuevarchar(256) DEFAULT NULL,
  creationdatetime DEFAULT CURRENT_TIMESTAMP,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_date
--

CREATE TABLE exav_addon_date(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  exa_tokenvarchar(32) DEFAULT NULL,
  exa_valuedate DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_decimal
--

CREATE TABLE exav_addon_decimal(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  exa_tokenvarchar(32) DEFAULT NULL,
  exa_valuedecimal(14,4) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_ec_id
--

CREATE TABLE exav_addon_ec_id(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  exa_tokenvarchar(32) DEFAULT NULL,
  ec_idint(11) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_exa_token
--

CREATE TABLE exav_addon_exa_token(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  exa_tokenvarchar(32) DEFAULT NULL,
  exa_value_tokenvarchar(32) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_num
--

CREATE TABLE exav_addon_num(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  exa_tokenvarchar(32) DEFAULT NULL,
  exa_valueint(16) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_text
--

CREATE TABLE exav_addon_text(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  exa_tokenvarchar(32) DEFAULT NULL,
  exa_valuetext,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_varchar
--

CREATE TABLE exav_addon_varchar(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  exa_tokenvarchar(32) DEFAULT NULL,
  exa_valuevarchar(1024) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_vc128uniq
--

CREATE TABLE exav_addon_vc128uniq(
  idint(11) NOT NULL,
  parent_idint(11) DEFAULT NULL,
  exa_tokenvarchar(32) DEFAULT NULL,
  exa_valuevarchar(128) DEFAULT NULL,
  exa_value_hashvarchar(32) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers exav_addon_vc128uniq
--
DELIMITER $$
CREATE TRIGGER trg_exav_addon_vc128uniq_before_insBEFORE INSERT ON exav_addon_vc128uniqFOR EACH ROW BEGIN

 IF(LENGTH(new.exa_value)=0) THEN
        
            SET new.exa_value = new.id;
    END IF;        
            SET new.exa_value_hash=md5(concat(new.exa_token,'[C]',new.exa_value));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER trg_exav_addon_vc128uniq_before_updBEFORE UPDATE ON exav_addon_vc128uniqFOR EACH ROW BEGIN

     IF(LENGTH(new.exa_value)=0) THEN
        
            SET new.exa_value = new.id;
    END IF;        
            SET new.exa_value_hash=md5(concat(new.exa_token,'[C]',new.exa_value));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table status_info
--

CREATE TABLE status_info(
  idint(11) NOT NULL,
  status_codevarchar(32) DEFAULT NULL,
  entity_codevarchar(4) DEFAULT NULL,
  child_comm_idint(11) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  notevarchar(1024) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table status_map
--

CREATE TABLE status_map(
  idint(11) NOT NULL,
  entity_codevarchar(4) DEFAULT NULL,
  status_code_startvarchar(32) DEFAULT NULL,
  status_code_endvarchar(32) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table sys_log
--

CREATE TABLE sys_log(
  idint(11) NOT NULL,
  sys_access_ipvarchar(32) DEFAULT NULL,
  sys_access_namevarchar(32) DEFAULT NULL,
  page_codevarchar(32) DEFAULT NULL,
  actionvarchar(512) DEFAULT NULL,
  action_typevarchar(32) DEFAULT NULL,
  access_keyvarchar(128) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_info
--

CREATE TABLE user_info(
  idint(11) NOT NULL,
  passwordvarchar(32) NOT NULL,
  user_role_idint(11) DEFAULT NULL,
  is_mail_checktinyint(1) DEFAULT NULL,
  is_activetinyint(1) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  is_send_mailtinyint(1) DEFAULT NULL,
  is_send_welcome_mailtinyint(1) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_logintimestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  is_internalint(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_info_log
--

CREATE TABLE user_info_log(
  log_idint(11) NOT NULL,
  idint(11) NOT NULL,
  passwordvarchar(32) DEFAULT NULL,
  user_role_idint(11) DEFAULT NULL,
  is_mail_checktinyint(1) DEFAULT NULL,
  is_activetinyint(1) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  is_send_mailtinyint(1) DEFAULT NULL,
  is_send_welcome_mailtinyint(1) DEFAULT NULL,
  timestamp_punchdatetime DEFAULT NULL,
  last_logintimestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  log_type_codevarchar(32) DEFAULT NULL,
  timestamp_logdatetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role
--

CREATE TABLE user_role(
  idint(11) NOT NULL,
  snchar(3) DEFAULT NULL,
  lnvarchar(1024) DEFAULT NULL,
  home_page_urlvarchar(256) DEFAULT NULL,
  user_idint(11) DEFAULT NULL,
  creationdatetime DEFAULT CURRENT_TIMESTAMP,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role_page
--

CREATE TABLE user_role_page(
  idint(11) NOT NULL,
  user_role_idint(11) DEFAULT NULL,
  snvarchar(256) NOT NULL,
  user_page_idstext,
  line_orderdecimal(5,2) NOT NULL,
  creationdatetime NOT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role_page_matrix
--

CREATE TABLE user_role_page_matrix(
  idint(11) NOT NULL,
  user_role_page_idint(11) DEFAULT NULL,
  user_page_idint(11) DEFAULT NULL,
  parent_idint(11) DEFAULT NULL,
  snvarchar(128) DEFAULT NULL,
  line_orderdecimal(5,2) DEFAULT NULL,
  creationdatetime DEFAULT CURRENT_TIMESTAMP,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role_permission
--

CREATE TABLE user_role_permission(
  idint(11) NOT NULL,
  user_role_idint(11) DEFAULT NULL,
  user_permission_idstext,
  creationdatetime NOT NULL,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table user_role_permission_matrix
--

CREATE TABLE user_role_permission_matrix(
  idint(11) NOT NULL,
  user_role_idint(11) DEFAULT NULL,
  user_permission_idint(11) DEFAULT NULL,
  creationdatetime DEFAULT CURRENT_TIMESTAMP,
  user_idint(11) DEFAULT NULL,
  timestamp_punchtimestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure for view entity_count
--
DROP TABLE IF EXISTS entity_count;

CREATE  VIEW entity_count AS  select entity_child.entity_codeAS entity_code,count(0) AS countfrom entity_childgroup by entity_child.entity_codeorder by entity_child.entity_code;

-- --------------------------------------------------------

--
-- Structure for view entity_ec_count
--
DROP TABLE IF EXISTS entity_ec_count;

CREATE  VIEW entity_ec_count AS  select entity.codeAS code,entity.snAS sn,(select count(0) from entity_childwhere (entity_child.entity_code= entity.code)) AS countfrom entitygroup by entity.codeorder by entity.sn;

-- --------------------------------------------------------

--
-- Structure for view page_view_log_by_day
--
DROP TABLE IF EXISTS page_view_log_by_day;

CREATE  VIEW page_view_log_by_day AS  select date_format(sys_log.timestamp_punch,'%Y-%m-%d') AS date,sys_log.page_codeAS page_code,count(0) AS totalfrom sys_loggroup by date_format(sys_log.timestamp_punch,'%d-%b-%Y'),sys_log.page_code;

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
  ADD UNIQUE KEY title(title);

--
-- Indexes for table eav_addon_bool
--
ALTER TABLE eav_addon_bool
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table eav_addon_date
--
ALTER TABLE eav_addon_date
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY ea_value(ea_value),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table eav_addon_ecb_id
--
ALTER TABLE eav_addon_ecb_id
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id),
  ADD KEY ecb_id(ecb_id);

--
-- Indexes for table eav_addon_ec_id
--
ALTER TABLE eav_addon_ec_id
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY ec_id(ec_id),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table eav_addon_exa_token
--
ALTER TABLE eav_addon_exa_token
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY exa_value_token(exa_value_token),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table eav_addon_num
--
ALTER TABLE eav_addon_num
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table eav_addon_text
--
ALTER TABLE eav_addon_text
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table eav_addon_varchar
--
ALTER TABLE eav_addon_varchar
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table eav_addon_vc128uniq
--
ALTER TABLE eav_addon_vc128uniq
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table ecb_av_addon_text
--
ALTER TABLE ecb_av_addon_text
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table ecb_av_addon_varchar
--
ALTER TABLE ecb_av_addon_varchar
  ADD PRIMARY KEY (id),
  ADD KEY ea_code(ea_code),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table ecb_parent_child_matrix
--
ALTER TABLE ecb_parent_child_matrix
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id),
  ADD KEY fk_ecb_parent_child_matrix_ecb_parent_id(ecb_parent_id);

--
-- Indexes for table entity
--
ALTER TABLE entity
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY code(code),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY fk_entity_user_id(user_id);

--
-- Indexes for table entity_attribute
--
ALTER TABLE entity_attribute
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY code(code),
  ADD KEY entity_code(entity_code),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY fk_entity_attribute_user_id(user_id);

--
-- Indexes for table entity_child
--
ALTER TABLE entity_child
  ADD PRIMARY KEY (id),
  ADD KEY entity_code(entity_code),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table entity_child_base
--
ALTER TABLE entity_child_base
  ADD PRIMARY KEY (id),
  ADD KEY entity_code(entity_code),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY token(token),
  ADD KEY fk_entity_child_base_user_id(user_id);

--
-- Indexes for table entity_key_value
--
ALTER TABLE entity_key_value
  ADD PRIMARY KEY (id),
  ADD KEY coach_id(coach_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY fk_entity_key_value_entity_code(entity_code),
  ADD KEY fk_entity_key_value_user_id(user_id);

--
-- Indexes for table exav_addon_date
--
ALTER TABLE exav_addon_date
  ADD PRIMARY KEY (id),
  ADD KEY exa_token(exa_token),
  ADD KEY exa_value(exa_value),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table exav_addon_decimal
--
ALTER TABLE exav_addon_decimal
  ADD PRIMARY KEY (id),
  ADD KEY exa_token(exa_token),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table exav_addon_ec_id
--
ALTER TABLE exav_addon_ec_id
  ADD PRIMARY KEY (id),
  ADD KEY exa_token(exa_token),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id),
  ADD KEY fk_exav_addon_ec_id_ec_id(ec_id);

--
-- Indexes for table exav_addon_exa_token
--
ALTER TABLE exav_addon_exa_token
  ADD PRIMARY KEY (id),
  ADD KEY exa_token(exa_token),
  ADD KEY exa_value_token(exa_value_token),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table exav_addon_num
--
ALTER TABLE exav_addon_num
  ADD PRIMARY KEY (id),
  ADD KEY exa_token(exa_token),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table exav_addon_text
--
ALTER TABLE exav_addon_text
  ADD PRIMARY KEY (id),
  ADD KEY exa_token(exa_token),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table exav_addon_varchar
--
ALTER TABLE exav_addon_varchar
  ADD PRIMARY KEY (id),
  ADD KEY exa_token(exa_token),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table exav_addon_vc128uniq
--
ALTER TABLE exav_addon_vc128uniq
  ADD PRIMARY KEY (id),
  ADD KEY exa_token(exa_token),
  ADD KEY parent_id(parent_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_id(user_id);

--
-- Indexes for table status_info
--
ALTER TABLE status_info
  ADD PRIMARY KEY (id),
  ADD KEY status_code(status_code),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY fk_status_info_entity_code(entity_code),
  ADD KEY fk_status_info_user_id(user_id),
  ADD KEY fk_status_info_child_comm_id(child_comm_id);

--
-- Indexes for table status_map
--
ALTER TABLE status_map
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY fk_status_map_entity_code(entity_code),
  ADD KEY fk_status_map_user_id(user_id),
  ADD KEY fk_status_map_status_code_start(status_code_start),
  ADD KEY fk_status_map_status_code_end(status_code_end);

--
-- Indexes for table sys_log
--
ALTER TABLE sys_log
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch(timestamp_punch);

--
-- Indexes for table user_info
--
ALTER TABLE user_info
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY is_internal(is_internal),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_role_id(user_role_id);

--
-- Indexes for table user_info_log
--
ALTER TABLE user_info_log
  ADD PRIMARY KEY (log_id),
  ADD KEY timestamp_punch(timestamp_punch);

--
-- Indexes for table user_role
--
ALTER TABLE user_role
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY sn(sn),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY fk_user_role_user_id(user_id);

--
-- Indexes for table user_role_page
--
ALTER TABLE user_role_page
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY fk_user_role_permission_user_id(user_id),
  ADD KEY user_role_page_ibfk_1(user_role_id),
  ADD KEY line_order(line_order);

--
-- Indexes for table user_role_page_matrix
--
ALTER TABLE user_role_page_matrix
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_role_id(user_role_page_id),
  ADD KEY fk_user_role_permission_matrix_user_permission_id(user_page_id),
  ADD KEY parent_id(parent_id);

--
-- Indexes for table user_role_permission
--
ALTER TABLE user_role_permission
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY fk_user_role_permission_user_role_id(user_role_id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY fk_user_role_permission_user_id(user_id);

--
-- Indexes for table user_role_permission_matrix
--
ALTER TABLE user_role_permission_matrix
  ADD PRIMARY KEY (id),
  ADD KEY timestamp_punch(timestamp_punch),
  ADD KEY user_role_id(user_role_id),
  ADD KEY fk_user_role_permission_matrix_user_permission_id(user_permission_id);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table demo
--
ALTER TABLE demo
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table demo_page_info
--
ALTER TABLE demo_page_info
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table eav_addon_bool
--
ALTER TABLE eav_addon_bool
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table eav_addon_date
--
ALTER TABLE eav_addon_date
  MODIFY idint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  MODIFY idint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_ecb_id
--
ALTER TABLE eav_addon_ecb_id
  MODIFY idint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_ec_id
--
ALTER TABLE eav_addon_ec_id
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2894;

--
-- AUTO_INCREMENT for table eav_addon_exa_token
--
ALTER TABLE eav_addon_exa_token
  MODIFY idint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_num
--
ALTER TABLE eav_addon_num
  MODIFY idint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table eav_addon_text
--
ALTER TABLE eav_addon_text
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=734;

--
-- AUTO_INCREMENT for table eav_addon_varchar
--
ALTER TABLE eav_addon_varchar
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13438;

--
-- AUTO_INCREMENT for table eav_addon_vc128uniq
--
ALTER TABLE eav_addon_vc128uniq
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=339;

--
-- AUTO_INCREMENT for table ecb_av_addon_text
--
ALTER TABLE ecb_av_addon_text
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table ecb_av_addon_varchar
--
ALTER TABLE ecb_av_addon_varchar
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28581;

--
-- AUTO_INCREMENT for table ecb_parent_child_matrix
--
ALTER TABLE ecb_parent_child_matrix
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7888;

--
-- AUTO_INCREMENT for table entity
--
ALTER TABLE entity
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT for table entity_attribute
--
ALTER TABLE entity_attribute
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=447;

--
-- AUTO_INCREMENT for table entity_child
--
ALTER TABLE entity_child
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5145;

--
-- AUTO_INCREMENT for table entity_child_base
--
ALTER TABLE entity_child_base
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4800;

--
-- AUTO_INCREMENT for table entity_key_value
--
ALTER TABLE entity_key_value
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table exav_addon_date
--
ALTER TABLE exav_addon_date
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table exav_addon_decimal
--
ALTER TABLE exav_addon_decimal
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table exav_addon_ec_id
--
ALTER TABLE exav_addon_ec_id
  MODIFY idint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table exav_addon_exa_token
--
ALTER TABLE exav_addon_exa_token
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table exav_addon_num
--
ALTER TABLE exav_addon_num
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT for table exav_addon_text
--
ALTER TABLE exav_addon_text
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1253;

--
-- AUTO_INCREMENT for table exav_addon_varchar
--
ALTER TABLE exav_addon_varchar
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=497;

--
-- AUTO_INCREMENT for table exav_addon_vc128uniq
--
ALTER TABLE exav_addon_vc128uniq
  MODIFY idint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table status_info
--
ALTER TABLE status_info
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table status_map
--
ALTER TABLE status_map
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table sys_log
--
ALTER TABLE sys_log
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53755;

--
-- AUTO_INCREMENT for table user_info
--
ALTER TABLE user_info
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table user_info_log
--
ALTER TABLE user_info_log
  MODIFY log_idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4197;

--
-- AUTO_INCREMENT for table user_role
--
ALTER TABLE user_role
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table user_role_page
--
ALTER TABLE user_role_page
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table user_role_page_matrix
--
ALTER TABLE user_role_page_matrix
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table user_role_permission
--
ALTER TABLE user_role_permission
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table user_role_permission_matrix
--
ALTER TABLE user_role_permission_matrix
  MODIFY idint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18652;

--
-- Constraints for dumped tables
--

--
-- Constraints for table eav_addon_bool
--
ALTER TABLE eav_addon_bool
  ADD CONSTRAINT eav_addon_bool_ibfk_1FOREIGN KEY (user_id) REFERENCES user_info(id),
  ADD CONSTRAINT eav_addon_codE_fkFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON UPDATE CASCADE,
  ADD CONSTRAINT eav_addon_parent_fkFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_date
--
ALTER TABLE eav_addon_date
  ADD CONSTRAINT fk_eav_addon_date_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_date_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_date_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  ADD CONSTRAINT fk_eav_addon_decimal_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_decimal_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_decimal_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_ecb_id
--
ALTER TABLE eav_addon_ecb_id
  ADD CONSTRAINT eav_addon_ecb_id_ibfk_1FOREIGN KEY (ecb_id) REFERENCES entity_child_base(id),
  ADD CONSTRAINT eav_addon_ecb_id_ibfk_2FOREIGN KEY (parent_id) REFERENCES entity_child(id),
  ADD CONSTRAINT eav_addon_ecb_id_ibfk_3FOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON UPDATE CASCADE;

--
-- Constraints for table eav_addon_ec_id
--
ALTER TABLE eav_addon_ec_id
  ADD CONSTRAINT fk_eav_addon_ec_id_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_ec_id_ec_idFOREIGN KEY (ec_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_ec_id_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_ec_id_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_exa_token
--
ALTER TABLE eav_addon_exa_token
  ADD CONSTRAINT fk_eav_addon_exa_token_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_exa_token_exa_value_tokenFOREIGN KEY (exa_value_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_exa_token_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_exa_token_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_num
--
ALTER TABLE eav_addon_num
  ADD CONSTRAINT fk_eav_addon_num_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_num_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_num_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_text
--
ALTER TABLE eav_addon_text
  ADD CONSTRAINT fk_eav_addon_text_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_text_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_text_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_varchar
--
ALTER TABLE eav_addon_varchar
  ADD CONSTRAINT fk_eav_addon_varchar_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_varchar_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_varchar_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table eav_addon_vc128uniq
--
ALTER TABLE eav_addon_vc128uniq
  ADD CONSTRAINT fk_eav_addon_vc128uniq_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_vc128uniq_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_vc128uniq_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table ecb_av_addon_varchar
--
ALTER TABLE ecb_av_addon_varchar
  ADD CONSTRAINT fk_ecb_av_addon_varchar_ea_codeFOREIGN KEY (ea_code) REFERENCES entity_attribute(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_ecb_av_addon_varchar_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child_base(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_ecb_av_addon_varchar_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table ecb_parent_child_matrix
--
ALTER TABLE ecb_parent_child_matrix
  ADD CONSTRAINT fk_ecb_parent_child_matrix_ecb_parent_idFOREIGN KEY (ecb_parent_id) REFERENCES entity_child_base(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_ecb_parent_child_matrix_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity
--
ALTER TABLE entity
  ADD CONSTRAINT fk_entity_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity_attribute
--
ALTER TABLE entity_attribute
  ADD CONSTRAINT fk_entity_attribute_entity_codeFOREIGN KEY (entity_code) REFERENCES entity(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_entity_attribute_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity_child
--
ALTER TABLE entity_child
  ADD CONSTRAINT fk_entity_child_entity_codeFOREIGN KEY (entity_code) REFERENCES entity(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_entity_child_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity_child_base
--
ALTER TABLE entity_child_base
  ADD CONSTRAINT fk_entity_child_base_entity_codeFOREIGN KEY (entity_code) REFERENCES entity(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_entity_child_base_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table entity_key_value
--
ALTER TABLE entity_key_value
  ADD CONSTRAINT fk_entity_key_value_entity_codeFOREIGN KEY (entity_code) REFERENCES entity(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_entity_key_value_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_date
--
ALTER TABLE exav_addon_date
  ADD CONSTRAINT fk_exav_addon_date_exa_tokenFOREIGN KEY (exa_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_date_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_date_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_decimal
--
ALTER TABLE exav_addon_decimal
  ADD CONSTRAINT fk_exav_addon_decimal_exa_tokenFOREIGN KEY (exa_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_decimal_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_decimal_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_ec_id
--
ALTER TABLE exav_addon_ec_id
  ADD CONSTRAINT fk_exav_addon_ec_id_ec_idFOREIGN KEY (ec_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_ec_id_exa_tokenFOREIGN KEY (exa_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_ec_id_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_ec_id_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_exa_token
--
ALTER TABLE exav_addon_exa_token
  ADD CONSTRAINT fk_exav_addon_exa_token_exa_tokenFOREIGN KEY (exa_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_exa_token_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_exa_token_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_num
--
ALTER TABLE exav_addon_num
  ADD CONSTRAINT fk_exav_addon_num_exa_tokenFOREIGN KEY (exa_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_num_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_num_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_text
--
ALTER TABLE exav_addon_text
  ADD CONSTRAINT fk_exav_addon_text_exa_tokenFOREIGN KEY (exa_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_text_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_text_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_varchar
--
ALTER TABLE exav_addon_varchar
  ADD CONSTRAINT fk_exav_addon_varchar_exa_tokenFOREIGN KEY (exa_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_varchar_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_varchar_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table exav_addon_vc128uniq
--
ALTER TABLE exav_addon_vc128uniq
  ADD CONSTRAINT fk_exav_addon_vc128uniq_exa_tokenFOREIGN KEY (exa_token) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_vc128uniq_parent_idFOREIGN KEY (parent_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_exav_addon_vc128uniq_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table status_info
--
ALTER TABLE status_info
  ADD CONSTRAINT fk_status_info_child_comm_idFOREIGN KEY (child_comm_id) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_info_entity_codeFOREIGN KEY (entity_code) REFERENCES entity(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_info_status_codeFOREIGN KEY (status_code) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_info_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table status_map
--
ALTER TABLE status_map
  ADD CONSTRAINT fk_status_map_entity_codeFOREIGN KEY (entity_code) REFERENCES entity(code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_map_status_code_endFOREIGN KEY (status_code_end) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_map_status_code_startFOREIGN KEY (status_code_start) REFERENCES entity_child_base(token) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_status_map_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table user_info
--
ALTER TABLE user_info
  ADD CONSTRAINT fk_user_info_is_internalFOREIGN KEY (is_internal) REFERENCES entity_child(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_user_info_user_role_idFOREIGN KEY (user_role_id) REFERENCES user_role(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table user_role
--
ALTER TABLE user_role
  ADD CONSTRAINT fk_user_role_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table user_role_page
--
ALTER TABLE user_role_page
  ADD CONSTRAINT user_role_page_ibfk_1FOREIGN KEY (user_role_id) REFERENCES user_role(id) ON UPDATE CASCADE;

--
-- Constraints for table user_role_page_matrix
--
ALTER TABLE user_role_page_matrix
  ADD CONSTRAINT user_role_page_matrix_ibfk_1FOREIGN KEY (user_role_page_id) REFERENCES user_role_page(id) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table user_role_permission
--
ALTER TABLE user_role_permission
  ADD CONSTRAINT fk_user_role_permission_user_idFOREIGN KEY (user_id) REFERENCES user_info(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_user_role_permission_user_role_idFOREIGN KEY (user_role_id) REFERENCES user_role(id) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table user_role_permission_matrix
--
ALTER TABLE user_role_permission_matrix
  ADD CONSTRAINT fk_user_role_permission_matrix_user_permission_idFOREIGN KEY (user_permission_id) REFERENCES ecb_parent_child_matrix(id) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_user_role_permission_matrix_user_role_idFOREIGN KEY (user_role_id) REFERENCES user_role(id) ON DELETE CASCADE ON UPDATE NO ACTION;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

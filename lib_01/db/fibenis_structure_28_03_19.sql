-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 28, 2019 at 05:58 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


DELIMITER $$
--
-- Functions
--
CREATE  FUNCTION get_coach_code(ec_id INTEGER) RETURNS varchar(32) CHARSET utf8
BEGIN
    RETURN IFNULL(get_eav_addon_vc128uniq(ec_id,'CHCD'),NULL);
END$$

CREATE  FUNCTION get_coach_id_by_code(temp_coach_name VARCHAR(64)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT parent_id FROM eav_addon_vc128uniq WHERE ea_code='CHCD' and ea_value=temp_coach_name),NULL);
END$$

CREATE  FUNCTION get_eav_addon_bool(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_bool WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_eav_addon_date(temp_ec_id INT, temp_code CHAR(4)) RETURNS date
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_date WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_eav_addon_ec_id(temp_ec_id INT, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ec_id FROM eav_addon_ec_id WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_eav_addon_exa_token(temp_ec_id INT, temp_code CHAR(4)) RETURNS varchar(32) CHARSET utf8
BEGIN
        return IFNULL((SELECT exa_value_token FROM eav_addon_exa_token WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
    END$$

CREATE  FUNCTION get_eav_addon_num(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_num WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_eav_addon_text(temp_ec_id INT, temp_code CHAR(4)) RETURNS text CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_text WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_eav_addon_varchar(ec_id INT, code VARCHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    return IFNULL((SELECT ea_value FROM eav_addon_varchar WHERE  parent_id=ec_id AND ea_code=code),NULL);
END$$

CREATE  FUNCTION get_eav_addon_vc128uniq(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS varchar(128) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_vc128uniq WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_eav_ec_id(temp_ec_id INT, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ec_id FROM eav_addon_ec_id WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_ea_sn_by_code(temp_code VARCHAR(64)) RETURNS varchar(1028) CHARSET utf8
BEGIN
        return IFNULL((SELECT sn FROM entity_attribute WHERE code=temp_code),NULL);
    END$$

CREATE  FUNCTION get_ecb_addon_varchar(ecb_id INT, temp_code CHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE  parent_id=ecb_id AND ea_code=temp_code ORDER BY id DESC LIMIT 1),NULL);
END$$

CREATE  FUNCTION get_ecb_attr(temp_token VARCHAR(16), attr_code CHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    DECLARE ecb_id int;
    
    return IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=get_ecb_id_by_token(temp_token) AND ea_code=attr_code),NULL);
END$$

CREATE  FUNCTION get_ecb_av_addon_varchar(temp_id INT(11), temp_code CHAR(4)) RETURNS text CHARSET utf8
BEGIN
    return IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE  parent_id=temp_id AND ea_code=temp_code ORDER BY id ASC),NULL);
END$$

CREATE  FUNCTION get_ecb_id_by_token(temp_token VARCHAR(32)) RETURNS text CHARSET utf8
BEGIN
    return IFNULL((SELECT id FROM entity_child_base WHERE token=temp_token),NULL);
END$$

CREATE  FUNCTION get_ecb_ln_by_token(temp_token VARCHAR(32)) RETURNS text CHARSET latin1
BEGIN
        return IFNULL((SELECT ln FROM entity_child_base WHERE token=temp_token),NULL);
    END$$

CREATE  FUNCTION get_ecb_parent_child_name(temp_id INT, glue VARCHAR(2)) RETURNS text CHARSET utf8
BEGIN

        RETURN CONCAT((SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE id=temp_id)),
                       glue,
                      (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE id=temp_id))
                      );
        
           
END$$

CREATE  FUNCTION get_ecb_parent_child_name_from_hash(temp_hash CHAR(32), glue VARCHAR(2)) RETURNS text CHARSET utf8
BEGIN

IF LENGTH(temp_hash)=32 THEN

        RETURN CONCAT((SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE parent_child_hash=temp_hash)),
                       glue,
                      (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE parent_child_hash=temp_hash))
                      );
                      ELSE
                      RETURN 'NA';
                      END IF;
        
           
END$$

CREATE  FUNCTION get_ecb_sn_by_token(temp_token varchar(32)) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((SELECT sn FROM entity_child_base WHERE token=temp_token),NULL);
    END$$

CREATE  FUNCTION get_ecsn(temp_id INT) RETURNS varchar(1024) CHARSET utf8
BEGIN
    return IFNULL((SELECT ea_value FROM eav_addon_varchar WHERE  parent_id=temp_id AND ea_code='ECSN'),NULL);
END$$

CREATE  FUNCTION get_ec_child_id(temp_ec_id INT, temp_code CHAR(4)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT id FROM entity_child WHERE parent_id=temp_ec_id AND entity_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_ec_child_id_eav(temp_ec_id INT, temp_code CHAR(4)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT id FROM entity_child WHERE get_eav_addon_num(id,'ECPR')=temp_ec_id AND entity_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_ec_id_by_code(temp_ent_code VARCHAR(4), temp_ec_code VARCHAR(32)) RETURNS int(11)
BEGIN

        RETURN (SELECT id FROM entity_child WHERE entity_code=temp_ent_code AND code=temp_ec_code);
        
           
END$$

CREATE  FUNCTION get_ec_id_by_code_eav(temp_ent_code VARCHAR(4), temp_ec_code VARCHAR(32)) RETURNS int(11)
BEGIN

        RETURN (SELECT id FROM entity_child WHERE entity_code=temp_ent_code AND get_eav_addon_varchar(id,'ECCD')=temp_ec_code);
        
           
END$$

CREATE  FUNCTION get_ec_parent_id(temp_ec_id INTEGER) RETURNS int(11)
BEGIN
    RETURN  IFNULL((SELECT parent_id FROM entity_child WHERE id=temp_ec_id),NULL);
END$$

CREATE  FUNCTION get_ec_parent_id_eav(temp_ec_id INT) RETURNS int(11)
BEGIN
    RETURN  IFNULL(get_eav_addon_ec_id(temp_ec_id,'ECPR'),NULL);
END$$

CREATE  FUNCTION get_ec_sn(temp_ec_id INTEGER) RETURNS int(11)
BEGIN
    RETURN  IFNULL((SELECT sn FROM entity_child WHERE id=temp_ec_id),NULL);
END$$

CREATE  FUNCTION get_ec_sn_eav(temp_ec_id INTEGER) RETURNS int(11)
BEGIN
    RETURN  IFNULL(get_eav_addon_varchar(id,'ECSN'),NULL);
END$$

CREATE  FUNCTION get_ec_status(temp_id INTEGER) RETURNS tinyint(1)
BEGIN

        RETURN (SELECT is_active FROM entity_child WHERE id=temp_id);
        
           
END$$

CREATE  FUNCTION get_entity_child_of_child_from_code(t_code VARCHAR(32), t_entity_code VARCHAR(2)) RETURNS int(11)
BEGIN
        RETURN (SELECT id FROM entity_child WHERE entity_code=t_entity_code AND parent_id=(SELECT ec.id FROM entity_child as ec WHERE ec.code=t_code));        
           
END$$

CREATE  FUNCTION get_entity_child_of_child_from_code_eav(t_code VARCHAR(32), t_entity_code VARCHAR(2)) RETURNS int(11)
BEGIN
        RETURN (SELECT id FROM entity_child WHERE entity_code=t_entity_code AND get_ec_parent_id_eav(entity_child.id)=(SELECT ec.id FROM entity_child as ec WHERE get_eav_addon_varchar(id,'ECCD')=t_code));                   
END$$

CREATE  FUNCTION get_exav(ec_id INT, token VARCHAR(16)) RETURNS text CHARSET utf8
BEGIN    
    DECLARE input_type char(4);    
    
    SELECT get_ecb_attr(token,'APIT') INTO input_type;
    
    IF input_type='ITNM' THEN  
    
        return get_exav_addon_decimal(ec_id,token); 
        
    ELSEIF input_type='ITG1' THEN    
    
        return get_exav_addon_text(ec_id,token);
        
    ELSE    
    
        return get_exav_addon_varchar(ec_id,token); 
        
    END IF;
    
END$$

CREATE  FUNCTION get_exav_addon_date(temp_ec_id INTEGER, token VARCHAR(16)) RETURNS text CHARSET latin1
BEGIN
    RETURN IFNULL((SELECT exa_value FROM exav_addon_date WHERE  parent_id=temp_ec_id AND exa_token=token),NULL);
END$$

CREATE  FUNCTION get_exav_addon_decimal(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,0)
BEGIN

    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);
    
 
END$$

CREATE  FUNCTION get_exav_addon_decimal_1(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,1)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE  FUNCTION get_exav_addon_decimal_2(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,2)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE  FUNCTION get_exav_addon_decimal_3(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,3)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE  FUNCTION get_exav_addon_decimal_4(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,4)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE  FUNCTION get_exav_addon_ec_id(temp_ec_id integer,token VARCHAR(16)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT ec_id FROM exav_addon_ec_id WHERE  parent_id=temp_ec_id AND exa_token=token),NULL);
    END$$

CREATE  FUNCTION get_exav_addon_exa_token(temp_ec_id INT, token VARCHAR(16)) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((SELECT exa_value_token FROM exav_addon_exa_token WHERE  parent_id=temp_ec_id AND exa_token=token ORDER BY id ASC LIMIT 1),NULL);
    END$$

CREATE  FUNCTION get_exav_addon_num(temp_ec_id INT, temp_token VARCHAR(32)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT exa_value FROM exav_addon_num WHERE  parent_id=temp_ec_id AND exa_token=temp_token),NULL);
    END$$

CREATE  FUNCTION get_exav_addon_number(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,0)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE  FUNCTION get_exav_addon_text(ec_id INT, token VARCHAR(16)) RETURNS text CHARSET utf8
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_text WHERE  parent_id=ec_id AND exa_token=token),NULL);
END$$

CREATE  FUNCTION get_exav_addon_varchar(ec_id INT, token VARCHAR(16)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_varchar WHERE  parent_id=ec_id AND exa_token=token ORDER BY id DESC LIMIT 1),NULL);
END$$

CREATE  FUNCTION get_issue_description(temp_ec_id INT) RETURNS text CHARSET utf8
BEGIN
            return IFNULL((get_exav_addon_varchar(temp_ec_id,'ISDS')),NULL);
        END$$

CREATE  FUNCTION get_issue_name(temp_ec_id INT) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((get_exav_addon_varchar(temp_ec_id,'ISNA')),NULL);
    END$$

CREATE  FUNCTION get_page_coach(ec_id INTEGER) RETURNS varchar(32) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT get_eav_addon_varchar(get_eav_ec_id(ec_id,'PGCH'),'CHDN')),NULL);
END$$

CREATE  FUNCTION get_page_coach_code(ec_id INT) RETURNS varchar(32) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT get_coach_code(get_eav_addon_ec_id(ec_id,'PGCH'))),NULL);
END$$

CREATE  FUNCTION get_page_parent(temp_parent_id INT) RETURNS text CHARSET utf8
BEGIN

    IF temp_parent_id=0 THEN      
        RETURN ''; 
    ELSE
        RETURN (SELECT concat(code,'[C]',sn,'[C]',IFNULL(image_a,''),'[C]',IFNULL(image_b,'')) as parent_name FROM entity_child as parent_name WHERE parent_name.id = temp_parent_id);
    END IF;
    
END$$

CREATE  FUNCTION get_page_parent_eav(temp_parent_id INT) RETURNS text CHARSET utf8
BEGIN

    IF temp_parent_id=0 THEN      
        RETURN ''; 
    ELSE
        RETURN (SELECT concat(get_eav_addon_varchar(temp_parent_id,'ECCD'),'[C]',
                              get_eav_addon_varchar(temp_parent_id,'ECSN'),'[C]',
                              IFNULL(get_eav_addon_varchar(temp_parent_id,'ECIA'),''),'[C]',
                              IFNULL(get_eav_addon_varchar(temp_parent_id,'ECIB'),'')) as parent_name FROM entity_child as parent_name WHERE parent_name.id = temp_parent_id);
    END IF;
    
END$$

CREATE  FUNCTION get_user_id(temp_id INT(11)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT id FROM user_info WHERE is_internal=temp_id),NULL);
END$$

CREATE  FUNCTION get_user_internal_email(temp_user_id int) RETURNS text CHARSET utf8
BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COEM');
        END$$

CREATE  FUNCTION get_user_internal_mobile(temp_user_id int) RETURNS text CHARSET utf8
BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COMB');
        END$$

CREATE  FUNCTION get_user_internal_name(temp_user_id int) RETURNS text CHARSET utf8
BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COFN');
        END$$

CREATE  FUNCTION get_user_role(temp_id INT) RETURNS varchar(1024) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ln FROM user_role WHERE id = (SELECT user_role_id FROM user_info WHERE is_internal = temp_id)),NULL);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table demo
--

CREATE TABLE IF NOT EXISTS demo (
  id int(11) NOT NULL AUTO_INCREMENT,
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
  code_editor text,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table demo_page_info
--

CREATE TABLE IF NOT EXISTS demo_page_info (
  id int(11) NOT NULL AUTO_INCREMENT,
  title varchar(128) DEFAULT NULL,
  content text,
  user_id int(11) NOT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY title (title)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_bool
--

CREATE TABLE IF NOT EXISTS eav_addon_bool (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value tinyint(1) DEFAULT '0',
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=320 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_date
--

CREATE TABLE IF NOT EXISTS eav_addon_date (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value date DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY ea_value (ea_value),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_decimal
--

CREATE TABLE IF NOT EXISTS eav_addon_decimal (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value decimal(10,4) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_ec_id
--

CREATE TABLE IF NOT EXISTS eav_addon_ec_id (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ec_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY ec_id (ec_id),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2453 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_exa_token
--

CREATE TABLE IF NOT EXISTS eav_addon_exa_token (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  exa_value_token varchar(32) NOT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY exa_value_token (exa_value_token),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_num
--

CREATE TABLE IF NOT EXISTS eav_addon_num (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value int(16) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_text
--

CREATE TABLE IF NOT EXISTS eav_addon_text (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value text,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=605 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_varchar
--

CREATE TABLE IF NOT EXISTS eav_addon_varchar (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value varchar(1024) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12087 ;

-- --------------------------------------------------------

--
-- Table structure for table eav_addon_vc128uniq
--

CREATE TABLE IF NOT EXISTS eav_addon_vc128uniq (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value varchar(128) DEFAULT NULL,
  ea_value_hash varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=292 ;

--
-- Triggers eav_addon_vc128uniq
--
DROP TRIGGER IF EXISTS trg_eav_addon_vc128uniq_before_ins;
DELIMITER //
CREATE TRIGGER trg_eav_addon_vc128uniq_before_ins BEFORE INSERT ON eav_addon_vc128uniq
 FOR EACH ROW BEGIN

 IF(LENGTH(new.ea_value)=0) THEN
        
            SET new.ea_value = new.id;
    END IF;        
            SET new.ea_value_hash=md5(concat(new.ea_code,'[C]',new.ea_value));
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS trg_eav_addon_vc128uniq_before_upd;
DELIMITER //
CREATE TRIGGER trg_eav_addon_vc128uniq_before_upd BEFORE UPDATE ON eav_addon_vc128uniq
 FOR EACH ROW BEGIN

     IF(LENGTH(new.ea_value)=0) THEN
        
            SET new.ea_value = new.id;
    END IF;        
            SET new.ea_value_hash=md5(concat(new.ea_code,'[C]',new.ea_value));
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table ecb_av_addon_varchar
--

CREATE TABLE IF NOT EXISTS ecb_av_addon_varchar (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value varchar(1024) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28329 ;

-- --------------------------------------------------------

--
-- Table structure for table ecb_parent_child_matrix
--

CREATE TABLE IF NOT EXISTS ecb_parent_child_matrix (
  id int(11) NOT NULL AUTO_INCREMENT,
  ecb_parent_id int(11) DEFAULT NULL,
  ecb_child_id int(11) DEFAULT NULL,
  parent_child_hash varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id),
  KEY fk_ecb_parent_child_matrix_ecb_parent_id (ecb_parent_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5249 ;

-- --------------------------------------------------------

--
-- Table structure for table entity
--

CREATE TABLE IF NOT EXISTS entity (
  id int(11) NOT NULL AUTO_INCREMENT,
  code varchar(4) DEFAULT NULL,
  sn varchar(64) DEFAULT NULL,
  ln varchar(1024) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_lib tinyint(1) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY code (code),
  KEY timestamp_punch (timestamp_punch),
  KEY fk_entity_user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=169 ;

-- --------------------------------------------------------

--
-- Table structure for table entity_attribute
--

CREATE TABLE IF NOT EXISTS entity_attribute (
  id int(11) NOT NULL AUTO_INCREMENT,
  entity_code varchar(4) DEFAULT NULL,
  code char(4) DEFAULT NULL,
  sn varchar(64) DEFAULT NULL,
  ln varchar(1024) DEFAULT NULL,
  line_order decimal(10,2) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY code (code),
  KEY entity_code (entity_code),
  KEY timestamp_punch (timestamp_punch),
  KEY fk_entity_attribute_user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=443 ;

-- --------------------------------------------------------

--
-- Table structure for table entity_child
--

CREATE TABLE IF NOT EXISTS entity_child (
  id int(11) NOT NULL AUTO_INCREMENT,
  entity_code varchar(4) DEFAULT NULL,
  line_order decimal(10,2) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  is_active tinyint(1) DEFAULT '1',
  PRIMARY KEY (id),
  KEY entity_code (entity_code),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4739 ;

-- --------------------------------------------------------

--
-- Table structure for table entity_child_base
--

CREATE TABLE IF NOT EXISTS entity_child_base (
  id int(11) NOT NULL AUTO_INCREMENT,
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
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY entity_code (entity_code),
  KEY timestamp_punch (timestamp_punch),
  KEY token (token),
  KEY fk_entity_child_base_user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3597 ;

--
-- Triggers entity_child_base
--
DROP TRIGGER IF EXISTS trg_entity_child_base_before_ins;
DELIMITER //
CREATE TRIGGER trg_entity_child_base_before_ins BEFORE INSERT ON entity_child_base
 FOR EACH ROW BEGIN
IF(LENGTH(new.token)=0) THEN
        
            SET new.token=((SELECT id FROM entity_child_base ORDER BY id DESC LIMIT 0,1)+1);
            
            END IF;
  
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS trg_entity_child_base_before_upd;
DELIMITER //
CREATE TRIGGER trg_entity_child_base_before_upd BEFORE UPDATE ON entity_child_base
 FOR EACH ROW BEGIN

    IF(LENGTH(new.token)=0) THEN        
            SET new.token = concat(new.token,'');
    END IF; 
    
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view entity_count
--
CREATE TABLE IF NOT EXISTS entity_count (
entity_code varchar(4)
,count bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view entity_ec_count
--
CREATE TABLE IF NOT EXISTS entity_ec_count (
code varchar(4)
,sn varchar(64)
,count bigint(21)
);
-- --------------------------------------------------------

--
-- Table structure for table entity_key_value
--

CREATE TABLE IF NOT EXISTS entity_key_value (
  id int(11) NOT NULL AUTO_INCREMENT,
  coach_id int(11) DEFAULT NULL,
  entity_code varchar(4) DEFAULT NULL,
  domain_hash varchar(32) DEFAULT NULL,
  entity_key varchar(128) DEFAULT NULL,
  entity_value varchar(256) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY coach_id (coach_id),
  KEY timestamp_punch (timestamp_punch),
  KEY fk_entity_key_value_entity_code (entity_code),
  KEY fk_entity_key_value_user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=59 ;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_date
--

CREATE TABLE IF NOT EXISTS exav_addon_date (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value date DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY exa_token (exa_token),
  KEY exa_value (exa_value),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=50 ;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_decimal
--

CREATE TABLE IF NOT EXISTS exav_addon_decimal (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value decimal(14,4) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY exa_token (exa_token),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=61 ;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_ec_id
--

CREATE TABLE IF NOT EXISTS exav_addon_ec_id (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  ec_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY exa_token (exa_token),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id),
  KEY fk_exav_addon_ec_id_ec_id (ec_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_exa_token
--

CREATE TABLE IF NOT EXISTS exav_addon_exa_token (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value_token varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY exa_token (exa_token),
  KEY exa_value_token (exa_value_token),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=71 ;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_num
--

CREATE TABLE IF NOT EXISTS exav_addon_num (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value int(16) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY exa_token (exa_token),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=101 ;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_text
--

CREATE TABLE IF NOT EXISTS exav_addon_text (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value text,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY exa_token (exa_token),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=964 ;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_varchar
--

CREATE TABLE IF NOT EXISTS exav_addon_varchar (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value varchar(1024) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY exa_token (exa_token),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=276 ;

-- --------------------------------------------------------

--
-- Table structure for table exav_addon_vc128uniq
--

CREATE TABLE IF NOT EXISTS exav_addon_vc128uniq (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  exa_token varchar(32) DEFAULT NULL,
  exa_value varchar(128) DEFAULT NULL,
  exa_value_hash varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY exa_token (exa_token),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Triggers exav_addon_vc128uniq
--
DROP TRIGGER IF EXISTS trg_exav_addon_vc128uniq_before_ins;
DELIMITER //
CREATE TRIGGER trg_exav_addon_vc128uniq_before_ins BEFORE INSERT ON exav_addon_vc128uniq
 FOR EACH ROW BEGIN

 IF(LENGTH(new.exa_value)=0) THEN
        
            SET new.exa_value = new.id;
    END IF;        
            SET new.exa_value_hash=md5(concat(new.exa_token,'[C]',new.exa_value));
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS trg_exav_addon_vc128uniq_before_upd;
DELIMITER //
CREATE TRIGGER trg_exav_addon_vc128uniq_before_upd BEFORE UPDATE ON exav_addon_vc128uniq
 FOR EACH ROW BEGIN

     IF(LENGTH(new.exa_value)=0) THEN
        
            SET new.exa_value = new.id;
    END IF;        
            SET new.exa_value_hash=md5(concat(new.exa_token,'[C]',new.exa_value));
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view page_view_log_by_day
--
CREATE TABLE IF NOT EXISTS page_view_log_by_day (
date varchar(10)
,page_code varchar(32)
,total bigint(21)
);
-- --------------------------------------------------------

--
-- Table structure for table status_info
--

CREATE TABLE IF NOT EXISTS status_info (
  id int(11) NOT NULL AUTO_INCREMENT,
  status_code varchar(32) DEFAULT NULL,
  entity_code varchar(4) DEFAULT NULL,
  child_comm_id int(11) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  note varchar(1024) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY status_code (status_code),
  KEY timestamp_punch (timestamp_punch),
  KEY fk_status_info_entity_code (entity_code),
  KEY fk_status_info_user_id (user_id),
  KEY fk_status_info_child_comm_id (child_comm_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

-- --------------------------------------------------------

--
-- Table structure for table status_map
--

CREATE TABLE IF NOT EXISTS status_map (
  id int(11) NOT NULL AUTO_INCREMENT,
  entity_code varchar(4) DEFAULT NULL,
  status_code_start varchar(32) DEFAULT NULL,
  status_code_end varchar(32) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY timestamp_punch (timestamp_punch),
  KEY fk_status_map_entity_code (entity_code),
  KEY fk_status_map_user_id (user_id),
  KEY fk_status_map_status_code_start (status_code_start),
  KEY fk_status_map_status_code_end (status_code_end)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Table structure for table sys_log
--

CREATE TABLE IF NOT EXISTS sys_log (
  id int(11) NOT NULL AUTO_INCREMENT,
  sys_access_ip varchar(32) DEFAULT NULL,
  sys_access_name varchar(32) DEFAULT NULL,
  page_code varchar(32) DEFAULT NULL,
  action varchar(512) DEFAULT NULL,
  action_type varchar(32) DEFAULT NULL,
  access_key varchar(128) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY timestamp_punch (timestamp_punch)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24992 ;

-- --------------------------------------------------------

--
-- Table structure for table user_info
--

CREATE TABLE IF NOT EXISTS user_info (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_name varchar(255) DEFAULT NULL,
  login_name char(32) DEFAULT NULL,
  email varchar(75) DEFAULT NULL,
  password varchar(32) DEFAULT NULL,
  user_role_id int(11) DEFAULT NULL,
  gender_code char(4) DEFAULT NULL,
  user_comm varchar(32) DEFAULT NULL,
  is_mail_check tinyint(1) DEFAULT NULL,
  is_active tinyint(1) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  is_send_mail tinyint(1) DEFAULT NULL,
  is_send_welcome_mail tinyint(1) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_login timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  is_internal int(11) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY is_internal (is_internal),
  KEY timestamp_punch (timestamp_punch),
  KEY user_role_id (user_role_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Triggers user_info
--
DROP TRIGGER IF EXISTS trg_user_info_after_ins;
DELIMITER //
CREATE TRIGGER trg_user_info_after_ins AFTER INSERT ON user_info
 FOR EACH ROW BEGIN
                                                                                                                        INSERT INTO user_info_log
                                                                                                                                  (email,gender_code,id,is_active,is_mail_check,is_send_mail,is_send_welcome_mail,last_login,login_name,password,timestamp_punch,user_comm,user_id,user_name,user_role_id,log_type_code)
                                                                                                                        VALUES
                                                                                                                                  (new.email,new.gender_code,new.id,new.is_active,new.is_mail_check,new.is_send_mail,new.is_send_welcome_mail,new.last_login,new.login_name,new.password,new.timestamp_punch,new.user_comm,new.user_id,new.user_name,new.user_role_id,'LTAD'); 
                                                                                                            END
//
DELIMITER ;
DROP TRIGGER IF EXISTS trg_user_info_after_upd;
DELIMITER //
CREATE TRIGGER trg_user_info_after_upd AFTER UPDATE ON user_info
 FOR EACH ROW BEGIN
                                                                                                                                    INSERT INTO user_info_log
                                                                                                                                              (email,gender_code,id,is_active,is_mail_check,is_send_mail,is_send_welcome_mail,last_login,login_name,password,timestamp_punch,user_comm,user_id,user_name,user_role_id,log_type_code)
                                                                                                                                    VALUES
                                                                                                                                              (new.email,new.gender_code,new.id,new.is_active,new.is_mail_check,new.is_send_mail,new.is_send_welcome_mail,new.last_login,new.login_name,new.password,new.timestamp_punch,new.user_comm,new.user_id,new.user_name,new.user_role_id,'LTUD'); 
                                                                                                                        END
//
DELIMITER ;
DROP TRIGGER IF EXISTS trg_user_info_before_del;
DELIMITER //
CREATE TRIGGER trg_user_info_before_del BEFORE DELETE ON user_info
 FOR EACH ROW BEGIN
                                                                                                                                    INSERT INTO user_info_log
                                                                                                                                              (email,gender_code,id,is_active,is_mail_check,is_send_mail,is_send_welcome_mail,last_login,login_name,password,timestamp_punch,user_comm,user_id,user_name,user_role_id,log_type_code)
                                                                                                                                    VALUES
                                                                                                                                              (old.email,old.gender_code,old.id,old.is_active,old.is_mail_check,old.is_send_mail,old.is_send_welcome_mail,old.last_login,old.login_name,old.password,old.timestamp_punch,old.user_comm,old.user_id,old.user_name,old.user_role_id,'LTDL'); 
                                                                                                                        END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table user_info_log
--

CREATE TABLE IF NOT EXISTS user_info_log (
  log_id int(11) NOT NULL AUTO_INCREMENT,
  id int(11) NOT NULL,
  user_name varchar(255) DEFAULT NULL,
  login_name char(32) DEFAULT NULL,
  email varchar(75) DEFAULT NULL,
  password varchar(32) DEFAULT NULL,
  user_role_id int(11) DEFAULT NULL,
  gender_code char(4) DEFAULT NULL,
  user_comm varchar(32) DEFAULT NULL,
  is_mail_check tinyint(1) DEFAULT NULL,
  is_active tinyint(1) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  is_send_mail tinyint(1) DEFAULT NULL,
  is_send_welcome_mail tinyint(1) DEFAULT NULL,
  timestamp_punch datetime DEFAULT NULL,
  last_login timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  log_type_code varchar(32) DEFAULT NULL,
  timestamp_log datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (log_id),
  KEY timestamp_punch (timestamp_punch)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3981 ;

-- --------------------------------------------------------

--
-- Table structure for table user_role
--

CREATE TABLE IF NOT EXISTS user_role (
  id int(11) NOT NULL AUTO_INCREMENT,
  sn char(3) DEFAULT NULL,
  ln varchar(1024) DEFAULT NULL,
  home_page_url varchar(256) DEFAULT NULL,
  user_id int(11) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY sn (sn),
  KEY timestamp_punch (timestamp_punch),
  KEY fk_user_role_user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Table structure for table user_role_permission
--

CREATE TABLE IF NOT EXISTS user_role_permission (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_role_id int(11) DEFAULT NULL,
  user_permission_ids varchar(256) DEFAULT NULL,
  creation datetime NOT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY timestamp_punch (timestamp_punch),
  KEY fk_user_role_permission_user_role_id (user_role_id),
  KEY fk_user_role_permission_user_id (user_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table user_role_permission_matrix
--

CREATE TABLE IF NOT EXISTS user_role_permission_matrix (
  id int(11) NOT NULL AUTO_INCREMENT,
  user_role_id int(11) DEFAULT NULL,
  user_permission_id int(11) DEFAULT NULL,
  creation datetime DEFAULT CURRENT_TIMESTAMP,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_role_id (user_role_id),
  KEY fk_user_role_permission_matrix_user_permission_id (user_permission_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14046 ;

-- --------------------------------------------------------

--
-- Structure for view entity_count
--
DROP TABLE IF EXISTS entity_count;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW entity_count AS select entity_child.entity_code AS entity_code,count(0) AS count from entity_child group by entity_child.entity_code order by entity_child.entity_code;

-- --------------------------------------------------------

--
-- Structure for view entity_ec_count
--
DROP TABLE IF EXISTS entity_ec_count;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW entity_ec_count AS select entity.code AS code,entity.sn AS sn,(select count(0) from entity_child where (entity_child.entity_code = entity.code)) AS count from entity group by entity.code order by entity.sn;

-- --------------------------------------------------------

--
-- Structure for view page_view_log_by_day
--
DROP TABLE IF EXISTS page_view_log_by_day;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW page_view_log_by_day AS select date_format(sys_log.timestamp_punch,'%Y-%m-%d') AS date,sys_log.page_code AS page_code,count(0) AS total from sys_log group by date_format(sys_log.timestamp_punch,'%d-%b-%Y'),sys_log.page_code;

--
-- Constraints for dumped tables
--

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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

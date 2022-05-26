-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 20, 2021 at 05:34 AM
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
-- Database: `fibenis_live`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_coach_code` (`ec_id` INTEGER) RETURNS VARCHAR(32) CHARSET utf8 BEGIN
    RETURN IFNULL(get_eav_addon_vc128uniq(ec_id,'CHCD'),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_coach_id_by_code` (`temp_coach_name` VARCHAR(64)) RETURNS INT(11) BEGIN
    RETURN IFNULL((SELECT parent_id FROM eav_addon_vc128uniq WHERE ea_code='CHCD' and ea_value=temp_coach_name),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_bool` (`temp_ec_id` INTEGER, `temp_code` CHAR(4)) RETURNS INT(11) BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_bool WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_date` (`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS DATE BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_date WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_ecb_id` (`temp_ecb_id` INT, `temp_code` CHAR(4)) RETURNS INT(11) BEGIN
    RETURN IFNULL((SELECT ecb_id FROM eav_addon_ecb_id WHERE  parent_id=temp_ecb_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_ec_id` (`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS INT(11) BEGIN
    RETURN IFNULL((SELECT ec_id FROM eav_addon_ec_id WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_exa_token` (`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS VARCHAR(32) CHARSET utf8 BEGIN
        return IFNULL((SELECT exa_value_token FROM eav_addon_exa_token WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_num` (`temp_ec_id` INTEGER, `temp_code` CHAR(4)) RETURNS INT(11) BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_num WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_text` (`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS TEXT CHARSET utf8 BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_text WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_varchar` (`ec_id` INT, `code` VARCHAR(4)) RETURNS VARCHAR(1028) CHARSET utf8 BEGIN
    return IFNULL((SELECT ea_value FROM eav_addon_varchar WHERE  parent_id=ec_id AND ea_code=code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_vc128uniq` (`temp_ec_id` INTEGER, `temp_code` CHAR(4)) RETURNS VARCHAR(128) CHARSET utf8 BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_vc128uniq WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_ec_id` (`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS INT(11) BEGIN
    RETURN IFNULL((SELECT ec_id FROM eav_addon_ec_id WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ea_sn_by_code` (`temp_code` VARCHAR(64)) RETURNS VARCHAR(1028) CHARSET utf8 BEGIN
        return IFNULL((SELECT sn FROM entity_attribute WHERE code=temp_code),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_addon_varchar` (`ecb_id` INT, `temp_code` CHAR(4)) RETURNS VARCHAR(1028) CHARSET utf8 BEGIN
    RETURN IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE  parent_id=ecb_id AND ea_code=temp_code ORDER BY id DESC LIMIT 1),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_attr` (`temp_token` VARCHAR(16), `attr_code` CHAR(4)) RETURNS VARCHAR(1028) CHARSET utf8 BEGIN
    DECLARE ecb_id int;
    
    return IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=get_ecb_id_by_token(temp_token) AND ea_code=attr_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_av_addon_text` (`temp_id` INT(11), `temp_code` CHAR(4)) RETURNS TEXT CHARSET utf8 BEGIN
    return IFNULL((SELECT ea_value FROM ecb_av_addon_text WHERE  parent_id=temp_id AND ea_code=temp_code ORDER BY id ASC),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_av_addon_varchar` (`temp_id` INT(11), `temp_code` CHAR(4)) RETURNS TEXT CHARSET utf8 BEGIN
    return IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE  parent_id=temp_id AND ea_code=temp_code ORDER BY id ASC),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_id_by_token` (`temp_token` VARCHAR(32)) RETURNS TEXT CHARSET utf8 BEGIN
    return IFNULL((SELECT id FROM entity_child_base WHERE token=temp_token),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_ln_by_token` (`temp_token` VARCHAR(32)) RETURNS TEXT CHARSET latin1 BEGIN
        return IFNULL((SELECT ln FROM entity_child_base WHERE token=temp_token),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_parent_child_name` (`temp_id` INT, `glue` VARCHAR(2)) RETURNS TEXT CHARSET utf8 BEGIN

        RETURN CONCAT((SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE id=temp_id)),
                       glue,
                      (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE id=temp_id))
                      );
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_parent_child_name_from_hash` (`temp_hash` CHAR(32), `glue` VARCHAR(2)) RETURNS TEXT CHARSET utf8 BEGIN

        RETURN CONCAT((SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE parent_child_hash=temp_hash)),
                       glue,
                      (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE parent_child_hash=temp_hash))
                      );
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_parent_child_name_mode` (`temp_id` INT, `glue` VARCHAR(2), `mode` VARCHAR(4)) RETURNS TEXT CHARSET utf8 BEGIN

        IF mode='PAGE' THEN

            RETURN CONCAT((SELECT token FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE id=temp_id)),
                           '=',
                          (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE id=temp_id))
                          );
        ELSEIF mode='MENU' THEN

            RETURN CONCAT((SELECT ln FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE id=temp_id)),'[C]',(SELECT token FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE id=temp_id)),
                           '=',
                          (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE id=temp_id))
                          );              
        ELSE
        
            RETURN CONCAT((SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE id=temp_id)),
                           glue,
                          (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE id=temp_id))
                          );
                          
        END IF;
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_sn_by_token` (`temp_token` VARCHAR(32)) RETURNS TEXT CHARSET utf8 BEGIN
        return IFNULL((SELECT sn FROM entity_child_base WHERE token=temp_token),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecsn` (`temp_id` INT) RETURNS VARCHAR(1024) CHARSET utf8 BEGIN
    return IFNULL((SELECT ea_value FROM eav_addon_varchar WHERE  parent_id=temp_id AND ea_code='ECSN'),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_child_id` (`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS INT(11) BEGIN
        return IFNULL((SELECT id FROM entity_child WHERE parent_id=temp_ec_id AND entity_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_child_id_eav` (`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS INT(11) BEGIN
        return IFNULL((SELECT id FROM entity_child WHERE get_eav_addon_num(id,'ECPR')=temp_ec_id AND entity_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_id_by_code` (`temp_ent_code` VARCHAR(4), `temp_ec_code` VARCHAR(32)) RETURNS INT(11) BEGIN

        RETURN (SELECT id FROM entity_child WHERE entity_code=temp_ent_code AND code=temp_ec_code);
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_id_by_code_eav` (`temp_ent_code` VARCHAR(4), `temp_ec_code` VARCHAR(32)) RETURNS INT(11) BEGIN

        RETURN (SELECT id FROM entity_child WHERE entity_code=temp_ent_code AND get_eav_addon_varchar(id,'ECCD')=temp_ec_code);
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_parent_id` (`temp_ec_id` INTEGER) RETURNS INT(11) BEGIN
    RETURN  IFNULL((SELECT parent_id FROM entity_child WHERE id=temp_ec_id),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_parent_id_eav` (`temp_ec_id` INT) RETURNS INT(11) BEGIN
    RETURN  IFNULL(get_eav_addon_ec_id(temp_ec_id,'ECPR'),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_sn` (`temp_ec_id` INTEGER) RETURNS INT(11) BEGIN
    RETURN  IFNULL((SELECT sn FROM entity_child WHERE id=temp_ec_id),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_sn_eav` (`temp_ec_id` INT) RETURNS INT(11) BEGIN
    RETURN  IFNULL(get_eav_addon_varchar(temp_ec_id,'ECSN'),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_status` (`temp_id` INTEGER) RETURNS TINYINT(1) BEGIN

        RETURN (SELECT is_active FROM entity_child WHERE id=temp_id);
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_entity_child_of_child_from_code` (`t_code` VARCHAR(32), `t_entity_code` VARCHAR(2)) RETURNS INT(11) BEGIN
        RETURN (SELECT id FROM entity_child WHERE entity_code=t_entity_code AND parent_id=(SELECT ec.id FROM entity_child as ec WHERE ec.code=t_code));        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_entity_child_of_child_from_code_eav` (`t_code` VARCHAR(32), `t_entity_code` VARCHAR(2)) RETURNS INT(11) BEGIN
        RETURN (SELECT id FROM entity_child WHERE entity_code=t_entity_code AND get_ec_parent_id_eav(entity_child.id)=(SELECT ec.id FROM entity_child as ec WHERE get_eav_addon_varchar(id,'ECCD')=t_code));                   
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav` (`ec_id` INT, `token` VARCHAR(16)) RETURNS TEXT CHARSET utf8 BEGIN    
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

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_bool` (`temp_ec_id` INTEGER, `token` VARCHAR(32)) RETURNS TINYINT(1) BEGIN
    RETURN IFNULL((SELECT exa_value FROM exav_addon_bool WHERE  parent_id=temp_ec_id AND exa_token=token),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_date` (`temp_ec_id` INTEGER, `token` VARCHAR(16)) RETURNS TEXT CHARSET latin1 BEGIN
    RETURN IFNULL((SELECT exa_value FROM exav_addon_date WHERE  parent_id=temp_ec_id AND exa_token=token),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal` (`ec_id` INT, `token` VARCHAR(16)) RETURNS DECIMAL(10,0) BEGIN

    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);
    
 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal_1` (`ec_id` INT, `token` VARCHAR(16)) RETURNS DECIMAL(10,1) BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal_2` (`ec_id` INT, `token` VARCHAR(16)) RETURNS DECIMAL(10,2) BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal_3` (`ec_id` INT, `token` VARCHAR(16)) RETURNS DECIMAL(10,3) BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal_4` (`ec_id` INT, `token` VARCHAR(16)) RETURNS DECIMAL(10,4) BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_ec_id` (`temp_ec_id` INTEGER, `token` VARCHAR(16)) RETURNS INT(11) BEGIN
        return IFNULL((SELECT ec_id FROM exav_addon_ec_id WHERE  parent_id=temp_ec_id AND exa_token=token),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_exa_token` (`temp_ec_id` INT, `token` VARCHAR(16)) RETURNS TEXT CHARSET utf8 BEGIN
        return IFNULL((SELECT exa_value_token FROM exav_addon_exa_token WHERE  parent_id=temp_ec_id AND exa_token=token ORDER BY id ASC LIMIT 1),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_num` (`temp_ec_id` INT, `temp_token` VARCHAR(32)) RETURNS INT(11) BEGIN
        return IFNULL((SELECT exa_value FROM exav_addon_num WHERE  parent_id=temp_ec_id AND exa_token=temp_token),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_number` (`ec_id` INT, `token` VARCHAR(16)) RETURNS DECIMAL(10,0) BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_text` (`ec_id` INT, `token` VARCHAR(16)) RETURNS TEXT CHARSET utf8 BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_text WHERE  parent_id=ec_id AND exa_token=token),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_varchar` (`ec_id` INT, `token` VARCHAR(16)) RETURNS VARCHAR(1028) CHARSET utf8 BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_varchar WHERE  parent_id=ec_id AND exa_token=token ORDER BY id DESC LIMIT 1),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_issue_description` (`temp_ec_id` INT) RETURNS TEXT CHARSET utf8 BEGIN
            return IFNULL((get_exav_addon_varchar(temp_ec_id,'ISDS')),NULL);
        END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_issue_name` (`temp_ec_id` INT) RETURNS TEXT CHARSET utf8 BEGIN
        return IFNULL((get_exav_addon_varchar(temp_ec_id,'ISNA')),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_page_coach` (`ec_id` INTEGER) RETURNS VARCHAR(32) CHARSET utf8 BEGIN
    RETURN IFNULL((SELECT get_eav_addon_varchar(get_eav_ec_id(ec_id,'PGCH'),'CHDN')),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_page_coach_code` (`ec_id` INT) RETURNS VARCHAR(32) CHARSET utf8 BEGIN
    RETURN IFNULL((SELECT get_coach_code(get_eav_addon_ec_id(ec_id,'PGCH'))),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_page_parent` (`temp_parent_id` INT) RETURNS TEXT CHARSET utf8 BEGIN

    IF temp_parent_id=0 THEN      
        RETURN ''; 
    ELSE
        RETURN (SELECT concat(code,'[C]',sn,'[C]',IFNULL(image_a,''),'[C]',IFNULL(image_b,'')) as parent_name FROM entity_child as parent_name WHERE parent_name.id = temp_parent_id);
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_page_parent_eav` (`temp_parent_id` INT) RETURNS TEXT CHARSET utf8 BEGIN

    IF temp_parent_id=0 THEN      
        RETURN ''; 
    ELSE
        RETURN (SELECT concat(get_eav_addon_varchar(temp_parent_id,'ECCD'),'[C]',
                              get_eav_addon_varchar(temp_parent_id,'ECSN'),'[C]',
                              IFNULL(get_eav_addon_varchar(temp_parent_id,'ECIA'),''),'[C]',
                              IFNULL(get_eav_addon_varchar(temp_parent_id,'ECIB'),'')) as parent_name FROM entity_child as parent_name WHERE parent_name.id = temp_parent_id);
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_users_role_code` (`temp_id` INT) RETURNS CHAR(3) CHARSET utf8 NO SQL
BEGIN
    RETURN IFNULL((SELECT sn FROM user_role WHERE id = (SELECT user_role_id FROM user_info WHERE user_info.id = temp_id)),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_id` (`temp_id` INT(11)) RETURNS INT(11) BEGIN
    RETURN IFNULL((SELECT id FROM user_info WHERE is_internal=temp_id),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_internal_email` (`temp_user_id` INT) RETURNS TEXT CHARSET utf8 BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COEM');
        END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_internal_mobile` (`temp_user_id` INT) RETURNS TEXT CHARSET utf8 BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COMB');
        END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_internal_name` (`temp_user_id` INT) RETURNS TEXT CHARSET utf8 BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COFN');
        END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_role` (`temp_id` INT) RETURNS VARCHAR(1024) CHARSET utf8 BEGIN
    RETURN IFNULL((SELECT ln FROM user_role WHERE id = (SELECT user_role_id FROM user_info WHERE is_internal = temp_id)),NULL);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `demo`
--

CREATE TABLE `demo` (
  `id` int(11) NOT NULL,
  `text_flat` varchar(64) DEFAULT NULL,
  `text_area` text,
  `decimal_flat` decimal(5,3) DEFAULT NULL,
  `image_flat` varchar(32) DEFAULT NULL,
  `documents` varchar(32) DEFAULT NULL,
  `option_single` varchar(32) DEFAULT NULL,
  `option_multiple` varchar(256) DEFAULT NULL,
  `fiben_table` text,
  `date_flat` date DEFAULT NULL,
  `range_flat` varchar(64) DEFAULT NULL,
  `toggle_switch` tinyint(1) DEFAULT NULL,
  `autocomplete` varchar(64) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `left_right` text,
  `text_editor` text,
  `code_editor` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `demo`
--

INSERT INTO `demo` (`id`, `text_flat`, `text_area`, `decimal_flat`, `image_flat`, `documents`, `option_single`, `option_multiple`, `fiben_table`, `date_flat`, `range_flat`, `toggle_switch`, `autocomplete`, `user_id`, `creation`, `timestamp_punch`, `left_right`, `text_editor`, `code_editor`) VALUES
(1, 'Text ', 'Text Area Text Area Text Area Text Area Text Area Text Area', '99.999', NULL, NULL, 'FT', 'IS,IP,IU', '[[\"First Test\",\"2021-03-01\"],[\"\",\"\"],[\"\",\"\"]]', '2021-03-02', '[\"5\",\"10\"]', 1, '92', 2, '2021-03-03 11:41:28', '2021-03-03 06:11:28', '', '<h2>Formatted&nbsp; Content</h2>\r\n', '<code>\r\n ');

-- --------------------------------------------------------

--
-- Table structure for table `demo_page_info`
--

CREATE TABLE `demo_page_info` (
  `id` int(11) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `content` text,
  `user_id` int(11) NOT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `demo_page_info`
--

INSERT INTO `demo_page_info` (`id`, `title`, `content`, `user_id`, `timestamp_punch`) VALUES
(1, 'Page Title A', '<p><b>Lorem Ipsum</b> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 2, '2019-02-02 08:06:43'),
(2, 'Page Title B', '<p><b>Lorem Ipsum</b> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not <b>only five centuries, but also the leap into electronic typesetting</b>, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 2, '2019-02-02 08:07:06');

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_bool`
--

CREATE TABLE `eav_addon_bool` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` tinyint(1) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `eav_addon_bool`
--

INSERT INTO `eav_addon_bool` (`id`, `parent_id`, `ea_code`, `ea_value`, `user_id`, `timestamp_punch`) VALUES
(141, 5269, 'PGHS', 1, 2, '2021-02-17 11:57:37'),
(142, 5270, 'PGHS', 1, 2, '2021-02-17 11:57:37'),
(143, 5271, 'PGHS', 1, 2, '2021-02-17 11:57:38'),
(144, 5272, 'PGHS', 1, 2, '2021-02-17 11:57:38'),
(145, 5273, 'PGHS', 1, 2, '2021-02-17 11:57:39');

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_date`
--

CREATE TABLE `eav_addon_date` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_decimal`
--

CREATE TABLE `eav_addon_decimal` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` decimal(10,4) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_ecb_id`
--

CREATE TABLE `eav_addon_ecb_id` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ecb_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `eav_addon_ecb_id`
--

INSERT INTO `eav_addon_ecb_id` (`id`, `parent_id`, `ea_code`, `ecb_id`, `user_id`, `timestamp_punch`) VALUES
(2, 5144, 'PGTM', 5840, 2, '2020-06-15 12:32:49');

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_ec_id`
--

CREATE TABLE `eav_addon_ec_id` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ec_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `eav_addon_ec_id`
--

INSERT INTO `eav_addon_ec_id` (`id`, `parent_id`, `ea_code`, `ec_id`, `user_id`, `timestamp_punch`) VALUES
(1534, 3948, 'ECPR', 3655, 2, '2018-12-27 06:44:49'),
(1871, 3974, 'ECPR', 3655, 2, '2019-01-03 07:54:49'),
(2269, 3975, 'ECPR', 3974, 2, '2019-02-01 12:19:40'),
(2270, 4223, 'ECPR', 3974, 2, '2019-02-01 12:19:52'),
(2271, 4224, 'ECPR', 3974, 2, '2019-02-01 12:20:01'),
(2285, 3949, 'ECPR', 3948, 2, '2019-02-01 12:24:11'),
(2300, 4618, 'ECPR', 3655, 2, '2019-02-01 12:29:38'),
(2301, 3894, 'ECPR', 3655, 2, '2019-02-01 12:30:04'),
(2310, 4627, 'ECPR', 4618, 2, '2019-02-01 12:31:36'),
(2327, 4636, 'ECPR', 4618, 2, '2019-02-01 12:34:01'),
(2658, 3880, 'ECPR', 3872, 2, '2019-09-17 11:16:08'),
(2751, 5009, 'ECPR', 4412, 2, '2019-09-28 14:19:06'),
(2853, 3872, 'ECPR', 3655, 2, '2019-11-14 11:37:29'),
(2880, 3895, 'ECPR', 3894, 2, '2019-11-18 10:20:13'),
(2917, 5269, 'PGCH', 3655, 2, '2021-02-17 11:57:37'),
(2918, 5270, 'PGCH', 3655, 2, '2021-02-17 11:57:37'),
(2919, 5271, 'PGCH', 3655, 2, '2021-02-17 11:57:38'),
(2920, 5272, 'PGCH', 3655, 2, '2021-02-17 11:57:38'),
(2921, 5273, 'PGCH', 3655, 2, '2021-02-17 11:57:39'),
(2923, 5265, 'ECPR', 5144, 2, '2021-03-03 05:37:48'),
(2924, 5274, 'ECPR', 5144, 2, '2021-03-03 05:38:15'),
(2925, 5275, 'ECPR', 5144, 2, '2021-03-03 05:39:12'),
(2928, 5144, 'PGCH', 3655, 2, '2021-03-03 05:49:10'),
(2932, 5262, 'PGCH', 3655, 2, '2021-03-03 05:53:48'),
(2938, 5264, 'PGCH', 3655, 2, '2021-03-03 06:02:00');

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_exa_token`
--

CREATE TABLE `eav_addon_exa_token` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `exa_value_token` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_num`
--

CREATE TABLE `eav_addon_num` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` int(16) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_text`
--

CREATE TABLE `eav_addon_text` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` text,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `eav_addon_text`
--

INSERT INTO `eav_addon_text` (`id`, `parent_id`, `ea_code`, `ea_value`, `user_id`, `timestamp_punch`) VALUES
(83, 3576, 'ECDT', '', 2, '2018-12-25 07:06:57'),
(175, 4007, 'ECDT', '<p>TitleTitleTitleTitleTitle</p>\\r\\n\\r\\n<p>TitleTitleTitleTitleTitleTitle</p>\\r\\n\\r\\n<p>vTitleTitleTitleTitleTitle</p>\\r\\n', 2, '2018-12-26 14:11:58'),
(179, 3948, 'ECDT', 'Reach Us', 2, '2018-12-27 06:44:50'),
(262, 3974, 'ECDT', 'Marquee', 2, '2019-01-03 07:54:50'),
(408, 4412, 'ECDT', '', 2, '2019-01-29 05:21:04'),
(569, 4618, 'ECDT', '', 2, '2019-02-01 12:29:38'),
(570, 3894, 'ECDT', 'Test', 2, '2019-02-01 12:30:05'),
(571, 4626, 'ECDT', '<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don&#39;t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn&#39;t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>', 2, '2019-02-01 12:30:55'),
(572, 4627, 'ECDT', '<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don&#39;t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn&#39;t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>', 2, '2019-02-01 12:31:36'),
(573, 4628, 'ECDT', '<p><b>Lorem Ipsum</b>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 2, '2019-02-01 12:32:08'),
(575, 4636, 'ECDT', '<p><b>Lorem Ipsum</b>&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 2, '2019-02-01 12:34:01'),
(673, 3880, 'ECDT', '[[\"Heading Content Prime\"],[\"Heading Content Secondary\"],[\"\"],[\"\"]]', 2, '2019-09-17 11:16:09'),
(722, 5009, 'ECDT', '[[\"primary_color\"],[\"\"],[\"\"]]', 2, '2019-09-28 14:19:07'),
(723, 3872, 'ECDT', '', 2, '2019-11-14 11:37:30'),
(724, 5118, 'ECDT', 'Detail', 2, '2019-11-14 11:58:44'),
(725, 3895, 'ECDT', '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', 2, '2019-11-18 10:20:14'),
(758, 5265, 'ECDT', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla faucibus dolor sed sapien pulvinar, ac maximus nunc egestas. Quisque sodales dictum porttitor. Cras arcu erat, ullamcorper nec accumsan eget, posuere sed tellus. Maecenas lacinia ipsum quis ipsum tempus varius. Fusce molestie eros ante, sed faucibus arcu mattis vitae. Sed viverra risus eu purus euismod vulputate. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ultricies pellentesque faucibus. Morbi commodo nunc in felis imperdiet faucibus. Mauris ut justo a tellus elementum ornare. Morbi posuere, sem ornare ultricies egestas, purus dui lobortis diam, tincidunt egestas turpis arcu non erat.', 2, '2021-03-03 05:37:48'),
(759, 5274, 'ECDT', 'Ut ac nisi eu risus viverra fringilla et id metus. Maecenas quis justo vitae risus tristique dapibus in sit amet sapien. Sed nulla libero, eleifend nec felis ac, lobortis aliquam urna. Pellentesque ut leo egestas, pharetra quam nec, consequat lorem. Donec suscipit magna nulla, placerat porttitor velit molestie a. In ullamcorper quam sit amet dui luctus, sit amet finibus libero iaculis. Sed rhoncus augue ligula, sed condimentum ligula scelerisque a. Proin maximus laoreet ultrices. Phasellus ullamcorper, augue et feugiat tempus, nulla felis consectetur mauris, at accumsan nulla dui eget elit. Sed in purus mollis, gravida diam id, blandit nulla. Donec id lorem ac mi varius laoreet. Nulla nisl nibh, porttitor vitae purus sed, euismod pulvinar urna.', 2, '2021-03-03 05:38:16'),
(760, 5275, 'ECDT', 'Sed egestas tortor in quam tempor ultricies. Donec rhoncus diam eget purus facilisis, at euismod quam sodales. Nunc non dolor nisl. Proin placerat vitae eros in mollis. Curabitur bibendum quam odio, a tempor ipsum egestas malesuada. Phasellus in maximus ex, convallis placerat orci. Sed consectetur facilisis condimentum. Vestibulum gravida blandit libero ut efficitur. Praesent auctor nisl id tempor interdum. Nam convallis volutpat lorem. Pellentesque ultricies leo non euismod laoreet. Nulla eu est sed lacus tempus consectetur.\r\n', 2, '2021-03-03 05:39:12'),
(763, 5144, 'ECDT', '<p>Test</p>\r\n', 2, '2021-03-03 05:49:11'),
(767, 5262, 'ECDT', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla faucibus dolor sed sapien pulvinar, ac maximus nunc egestas. Quisque sodales dictum porttitor. Cras arcu erat, ullamcorper nec accumsan eget, posuere sed tellus. Maecenas lacinia ipsum quis ipsum tempus varius. Fusce molestie eros ante, sed faucibus arcu mattis vitae. Sed viverra risus eu purus euismod vulputate. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ultricies pellentesque faucibus. Morbi commodo nunc in felis imperdiet faucibus. Mauris ut justo a tellus elementum ornare. Morbi posuere, sem ornare ultricies egestas, purus dui lobortis diam, tincidunt egestas turpis arcu non erat.</p>\r\n\r\n<p>Ut ac nisi eu risus viverra fringilla et id metus. Maecenas quis justo vitae risus tristique dapibus in sit amet sapien. Sed nulla libero, eleifend nec felis ac, lobortis aliquam urna. Pellentesque ut leo egestas, pharetra quam nec, consequat lorem. Donec suscipit magna nulla, placerat porttitor velit molestie a. In ullamcorper quam sit amet dui luctus, sit amet finibus libero iaculis. Sed rhoncus augue ligula, sed condimentum ligula scelerisque a. Proin maximus laoreet ultrices. Phasellus ullamcorper, augue et feugiat tempus, nulla felis consectetur mauris, at accumsan nulla dui eget elit. Sed in purus mollis, gravida diam id, blandit nulla. Donec id lorem ac mi varius laoreet. Nulla nisl nibh, porttitor vitae purus sed, euismod pulvinar urna.</p>\r\n\r\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum, neque ut bibendum rhoncus, mi lectus tempor purus, nec euismod sem felis in arcu. Phasellus fermentum enim non facilisis dictum. Fusce suscipit ornare libero, quis ultrices dolor iaculis nec. Etiam libero ante, interdum a nunc eu, fermentum mollis lacus. Phasellus pretium ligula ut nisl ullamcorper dapibus. Donec eu tincidunt sapien. Maecenas tincidunt tortor purus, a aliquet justo consequat ut. Nunc et leo quis enim pulvinar laoreet a sit amet ligula. Quisque nec purus in massa dignissim aliquam.</p>\r\n\r\n<p>Sed egestas tortor in quam tempor ultricies. Donec rhoncus diam eget purus facilisis, at euismod quam sodales. Nunc non dolor nisl. Proin placerat vitae eros in mollis. Curabitur bibendum quam odio, a tempor ipsum egestas malesuada. Phasellus in maximus ex, convallis placerat orci. Sed consectetur facilisis condimentum. Vestibulum gravida blandit libero ut efficitur. Praesent auctor nisl id tempor interdum. Nam convallis volutpat lorem. Pellentesque ultricies leo non euismod laoreet. Nulla eu est sed lacus tempus consectetur.</p>\r\n\r\n<p>Mauris laoreet, ipsum ac feugiat cursus, est risus ornare sapien, ac scelerisque leo nibh ac neque. Aenean vitae tempus nibh, et ornare risus. Nam sit amet ligula cursus, pharetra ante ut, vulputate tellus. Quisque dictum ex vitae tellus cursus scelerisque. Morbi feugiat nisl erat, dapibus iaculis nisi ultricies eget. Pellentesque sed nibh a lacus rhoncus finibus. Pellentesque cursus ipsum in aliquam egestas. Phasellus nec viverra nisi. Nam nec nisi sed augue tempus sollicitudin. Sed sit amet dapibus eros.</p>', 2, '2021-03-03 05:53:49'),
(773, 5264, 'ECDT', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla faucibus dolor sed sapien pulvinar, ac maximus nunc egestas. Quisque sodales dictum porttitor. Cras arcu erat, ullamcorper nec accumsan eget, posuere sed tellus. Maecenas lacinia ipsum quis ipsum tempus varius. Fusce molestie eros ante, sed faucibus arcu mattis vitae. Sed viverra risus eu purus euismod vulputate. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ultricies pellentesque faucibus. Morbi commodo nunc in felis imperdiet faucibus. Mauris ut justo a tellus elementum ornare. Morbi posuere, sem ornare ultricies egestas, purus dui lobortis diam, tincidunt egestas turpis arcu non erat.</p>\r\n\r\n<p>Ut ac nisi eu risus viverra fringilla et id metus. Maecenas quis justo vitae risus tristique dapibus in sit amet sapien. Sed nulla libero, eleifend nec felis ac, lobortis aliquam urna. Pellentesque ut leo egestas, pharetra quam nec, consequat lorem. Donec suscipit magna nulla, placerat porttitor velit molestie a. In ullamcorper quam sit amet dui luctus, sit amet finibus libero iaculis. Sed rhoncus augue ligula, sed condimentum ligula scelerisque a. Proin maximus laoreet ultrices. Phasellus ullamcorper, augue et feugiat tempus, nulla felis consectetur mauris, at accumsan nulla dui eget elit. Sed in purus mollis, gravida diam id, blandit nulla. Donec id lorem ac mi varius laoreet. Nulla nisl nibh, porttitor vitae purus sed, euismod pulvinar urna.</p>\r\n\r\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam bibendum, neque ut bibendum rhoncus, mi lectus tempor purus, nec euismod sem felis in arcu. Phasellus fermentum enim non facilisis dictum. Fusce suscipit ornare libero, quis ultrices dolor iaculis nec. Etiam libero ante, interdum a nunc eu, fermentum mollis lacus. Phasellus pretium ligula ut nisl ullamcorper dapibus. Donec eu tincidunt sapien. Maecenas tincidunt tortor purus, a aliquet justo consequat ut. Nunc et leo quis enim pulvinar laoreet a sit amet ligula. Quisque nec purus in massa dignissim aliquam.</p>\r\n\r\n<p>Sed egestas tortor in quam tempor ultricies. Donec rhoncus diam eget purus facilisis, at euismod quam sodales. Nunc non dolor nisl. Proin placerat vitae eros in mollis. Curabitur bibendum quam odio, a tempor ipsum egestas malesuada. Phasellus in maximus ex, convallis placerat orci. Sed consectetur facilisis condimentum. Vestibulum gravida blandit libero ut efficitur. Praesent auctor nisl id tempor interdum. Nam convallis volutpat lorem. Pellentesque ultricies leo non euismod laoreet. Nulla eu est sed lacus tempus consectetur.</p>\r\n\r\n<p>Mauris laoreet, ipsum ac feugiat cursus, est risus ornare sapien, ac scelerisque leo nibh ac neque. Aenean vitae tempus nibh, et ornare risus. Nam sit amet ligula cursus, pharetra ante ut, vulputate tellus. Quisque dictum ex vitae tellus cursus scelerisque. Morbi feugiat nisl erat, dapibus iaculis nisi ultricies eget. Pellentesque sed nibh a lacus rhoncus finibus. Pellentesque cursus ipsum in aliquam egestas. Phasellus nec viverra nisi. Nam nec nisi sed augue tempus sollicitudin. Sed sit amet dapibus eros.</p>\r\n', 2, '2021-03-03 06:02:01');

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_varchar`
--

CREATE TABLE `eav_addon_varchar` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` varchar(1024) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `eav_addon_varchar`
--

INSERT INTO `eav_addon_varchar` (`id`, `parent_id`, `ea_code`, `ea_value`, `user_id`, `timestamp_punch`) VALUES
(6062, 3576, 'ECSN', 'Home Banner', 2, '2018-12-25 07:06:57'),
(6063, 3576, 'ECLN', 'Home Banner', 2, '2018-12-25 07:06:57'),
(7332, 3865, 'COFN', 'Anonymous', 2, '2018-12-25 07:06:57'),
(7333, 3865, 'COMB', '3333333333', 2, '2018-12-25 07:06:57'),
(7334, 3865, 'COEM', 'any@webstarscg.com', 2, '2018-12-25 07:06:57'),
(7600, 3946, 'COFN', 'Admin', 2, '2018-12-26 05:00:27'),
(7601, 3946, 'COMB', '1111111111', 2, '2018-12-26 04:59:21'),
(7602, 3946, 'COEM', 'admin@webstarscg.com', 2, '2018-12-26 04:59:21'),
(7603, 3947, 'COFN', 'Base user', 2, '2018-12-26 04:59:49'),
(7604, 3947, 'COMB', '2222222222', 2, '2018-12-26 04:59:49'),
(7605, 3947, 'COEM', 'base@webstarscg.com', 2, '2018-12-26 04:59:49'),
(7781, 4007, 'ECLN', 'Title', 2, '2018-12-26 14:11:58'),
(7860, 3948, 'ECSN', 'Reach Us', 2, '2018-12-27 06:44:49'),
(7861, 3948, 'ECLN', 'Reach Us', 2, '2018-12-27 06:44:49'),
(9436, 3974, 'ECSN', 'Marquee', 2, '2019-01-03 07:54:49'),
(9437, 3974, 'ECLN', 'Marquee', 2, '2019-01-03 07:54:50'),
(11127, 4412, 'ECCD', 'ml', 2, '2019-01-29 05:21:04'),
(11128, 4412, 'ECSN', 'ml', 2, '2019-01-29 05:21:04'),
(11129, 4412, 'ECLN', 'Margo lite', 2, '2019-01-29 05:21:04'),
(11530, 3975, 'ECSN', '', 2, '2019-02-01 12:19:40'),
(11531, 3975, 'ECLN', 'Integer tincidunt sapien eu sapien fringilla, in molestie tortor ultricies.', 2, '2019-02-01 12:19:40'),
(11532, 4223, 'ECSN', '', 2, '2019-02-01 12:19:52'),
(11533, 4223, 'ECLN', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', 2, '2019-02-01 12:19:52'),
(11534, 4224, 'ECSN', '', 2, '2019-02-01 12:20:02'),
(11535, 4224, 'ECLN', 'Aliquam vitae nibh at nibh vulputate blandit et tristique erat.', 2, '2019-02-01 12:20:02'),
(11562, 3949, 'CXFN', 'Organization', 2, '2019-02-01 12:24:11'),
(11563, 3949, 'CXRA', 'Residential Address Line 1 ', 2, '2019-02-01 12:24:11'),
(11564, 3949, 'CXRB', 'Residential Address Line 2 ', 2, '2019-02-01 12:24:11'),
(11565, 3949, 'CXLD', 'Landline', 2, '2019-02-01 12:24:11'),
(11566, 3949, 'CXMB', 'Mobile', 2, '2019-02-01 12:24:11'),
(11567, 3949, 'CXEM', 'Email', 2, '2019-02-01 12:24:11'),
(11568, 3949, 'CXGM', '', 2, '2019-02-01 12:24:11'),
(11600, 4618, 'ECSN', 'Accordion', 2, '2019-02-01 12:29:38'),
(11601, 4618, 'ECLN', 'Accordion', 2, '2019-02-01 12:29:38'),
(11602, 3894, 'ECSN', 'About Us', 2, '2019-02-01 12:30:04'),
(11603, 3894, 'ECLN', 'About Us', 2, '2019-02-01 12:30:05'),
(11618, 4626, 'ECLN', 'Mauris id dolor id est facilisis gravida.\\r\\n', 2, '2019-02-01 12:30:55'),
(11619, 4627, 'ECLN', 'Proin vel elit id metus tincidunt luctus.', 2, '2019-02-01 12:31:36'),
(11620, 4628, 'ECLN', 'Donec rhoncus odio a congue hendrerit.', 2, '2019-02-01 12:32:08'),
(11650, 4636, 'ECLN', 'Maecenas porta risus et sollicitudin porta.', 2, '2019-02-01 12:34:01'),
(12612, 3880, 'ECSN', 'Check More', 2, '2019-09-17 11:16:08'),
(12613, 3880, 'ECLN', '?test', 2, '2019-09-17 11:16:08'),
(12614, 3880, 'ECIA', 'terminal/default/images/hb_3880_1.png', 2, '2019-09-17 11:16:09'),
(12907, 3655, 'ECSN', 'Default', 2, '2019-09-21 13:55:01'),
(12908, 3655, 'CHDN', 'default', 2, '2019-09-21 13:55:01'),
(12909, 3655, 'CHIL', 'terminal/default/images/logo_1.png', 2, '2019-09-21 13:55:01'),
(12910, 3655, 'CHIF', 'terminal/default/images/favicon_1.png', 2, '2019-09-21 13:55:01'),
(13094, 5009, 'ECSN', 'primary', 2, '2019-09-28 14:19:07'),
(13095, 5009, 'ECLN', 'Primary', 2, '2019-09-28 14:19:07'),
(13096, 5009, 'ECIA', '../theme/ml/blend/source/primary.less', 2, '2019-09-28 14:19:07'),
(13259, 1540, 'COFN', 'Super Admin', 2, '2019-10-11 08:24:09'),
(13260, 1540, 'COMB', '0000000000', 2, '2019-10-11 08:24:09'),
(13261, 1540, 'COEM', 'sa@webstarscg.com', 2, '2019-10-11 08:24:09'),
(13302, 3872, 'ECSN', 'Home ', 2, '2019-11-14 11:37:29'),
(13303, 3872, 'ECLN', 'Home Banner', 2, '2019-11-14 11:37:30'),
(13314, 5118, 'ECSN', 'H1', 2, '2019-11-14 11:58:44'),
(13315, 5118, 'ECLN', 'SH1', 2, '2019-11-14 11:58:44'),
(13356, 3895, 'ECSN', 'About Us', 2, '2019-11-18 10:20:14'),
(13357, 3895, 'ECIA', 'terminal/default/images/ha_3895_1.png', 2, '2019-11-18 10:20:14'),
(13438, 5146, 'IMFL', 'doc/doc/entity_export_5146.xml', 2, '2020-04-21 23:27:20'),
(13439, 5147, 'IMFL', 'doc/entity_export_5147.xml', 2, '2020-04-21 23:28:42'),
(13440, 5148, 'IMFL', 'doc/entity_export_5148.xml', 2, '2020-04-21 23:35:28'),
(13441, 5149, 'IMFL', 'doc/entity_export_5149.xml', 2, '2020-04-21 23:39:54'),
(13442, 5150, 'IMFL', 'doc/entity_export_5150.xml', 2, '2020-04-21 23:40:24'),
(13443, 5151, 'IMFL', 'doc/entity_export_5151.xml', 2, '2020-04-21 23:41:16'),
(13444, 5152, 'IMFL', 'doc/entity_export_5152.xml', 2, '2020-04-21 23:41:47'),
(13445, 5153, 'IMFL', 'doc/entity_export_5153.xml', 2, '2020-04-21 23:42:04'),
(13446, 5154, 'IMFL', 'doc/entity_export_5154.xml', 2, '2020-04-21 23:43:14'),
(13447, 5155, 'IMFL', 'doc/entity_export_5155.xml', 2, '2020-04-21 23:44:09'),
(13448, 5156, 'IMFL', 'doc/entity_export_5156.xml', 2, '2020-04-21 23:48:14'),
(13449, 5157, 'IMFL', 'doc/entity_export_5157.xml', 2, '2020-04-21 23:48:50'),
(13450, 5158, 'IMFL', 'doc/entity_export_5158.xml', 2, '2020-04-21 23:49:30'),
(13451, 5159, 'IMFL', 'doc/entity_export_5159.xml', 2, '2020-04-21 23:51:43'),
(13452, 5160, 'IMFL', 'doc/entity_export_5160.xml', 2, '2020-04-21 23:57:26'),
(13453, 5161, 'IMFL', 'doc/entity_export_5161.xml', 2, '2020-04-21 23:58:06'),
(13454, 5162, 'IMFL', 'doc/entity_export_5162.xml', 2, '2020-04-21 23:59:50'),
(13455, 5163, 'IMFL', 'doc/entity_export_5163.xml', 2, '2020-04-22 00:00:27'),
(13456, 5164, 'IMFL', 'doc/entity_export_5164.xml', 2, '2020-04-22 00:12:07'),
(13457, 5165, 'IMFL', 'doc/entity_export_5165.xml', 2, '2020-04-22 00:14:26'),
(13458, 5166, 'IMFL', 'doc/entity_export_5166.xml', 2, '2020-04-22 00:14:42'),
(13459, 5167, 'IMFL', 'doc/entity_export_5167.xml', 2, '2020-04-22 00:16:36'),
(13460, 5168, 'IMFL', 'doc/entity_export_5168.xml', 2, '2020-04-22 00:17:28'),
(13461, 5169, 'IMFL', 'doc/entity_export_5169.xml', 2, '2020-04-22 00:33:28'),
(13462, 5170, 'IMFL', 'doc/entity_export_5170.xml', 2, '2020-04-22 00:34:24'),
(13463, 5171, 'IMFL', 'doc/entity_export_5171.xml', 2, '2020-04-22 00:35:52'),
(13464, 5172, 'IMFL', 'doc/entity_export_5172.xml', 2, '2020-04-22 00:36:33'),
(13465, 5173, 'IMFL', 'doc/entity_export_5173.xml', 2, '2020-04-22 00:43:56'),
(13466, 5174, 'IMFL', 'doc/entity_export_5174.xml', 2, '2020-04-22 00:48:10'),
(13467, 5175, 'IMFL', 'doc/entity_export_5175.xml', 2, '2020-04-22 00:48:39'),
(13468, 5176, 'IMFL', 'doc/entity_export_5176.xml', 2, '2020-04-22 00:49:04'),
(13469, 5177, 'IMFL', 'doc/entity_export_5177.xml', 2, '2020-04-22 00:50:26'),
(13470, 5178, 'IMFL', 'doc/entity_export_5178.xml', 2, '2020-04-22 00:54:42'),
(13471, 5179, 'IMFL', 'doc/entity_export_5179.xml', 2, '2020-04-22 00:56:03'),
(13472, 5180, 'IMFL', 'doc/entity_export_5180.xml', 2, '2020-04-22 00:57:18'),
(13473, 5181, 'IMFL', 'doc/entity_export_5181.xml', 2, '2020-04-22 00:59:00'),
(13474, 5182, 'IMFL', 'doc/entity_export_5182.xml', 2, '2020-04-22 01:00:11'),
(13475, 5183, 'IMFL', 'doc/entity_export_5183.xml', 2, '2020-04-22 23:39:32'),
(13476, 5184, 'IMFL', 'doc/entity_export_5184.xml', 2, '2020-04-22 23:52:03'),
(13477, 5185, 'IMFL', 'doc/entity_export_5185.xml', 2, '2020-04-23 00:09:08'),
(13478, 5186, 'IMFL', 'doc/entity_export_5186.xml', 2, '2020-04-23 00:09:38'),
(13479, 5187, 'IMFL', 'doc/entity_export_5187.xml', 2, '2020-04-23 00:10:33'),
(13480, 5188, 'IMFL', 'doc/entity_export_5188.xml', 2, '2020-04-23 00:10:56'),
(13481, 5189, 'IMFL', 'doc/entity_export_5189.xml', 2, '2020-04-23 00:11:14'),
(13482, 5190, 'IMFL', 'doc/entity_export_5190.xml', 2, '2020-04-23 00:12:43'),
(13483, 5191, 'IMFL', 'doc/entity_export_5191.xml', 2, '2020-04-23 00:14:37'),
(13484, 5192, 'IMFL', 'doc/entity_export_5192.xml', 2, '2020-04-23 00:16:35'),
(13485, 5193, 'IMFL', 'doc/entity_export_5193.xml', 2, '2020-04-23 00:17:48'),
(13486, 5194, 'IMFL', 'doc/entity_export_5194.xml', 2, '2020-04-23 00:21:27'),
(13487, 5195, 'IMFL', 'doc/entity_export_5195.xml', 2, '2020-04-23 00:24:29'),
(13488, 5196, 'IMFL', 'doc/entity_export_5196.xml', 2, '2020-04-23 00:33:49'),
(13489, 5197, 'IMFL', 'doc/entity_export_5197.xml', 2, '2020-04-23 00:39:54'),
(13490, 5198, 'IMFL', 'doc/entity_export_5198.xml', 2, '2020-04-23 00:42:43'),
(13491, 5199, 'IMFL', 'doc/entity_export_5199.xml', 2, '2020-04-23 00:43:55'),
(13492, 5200, 'IMFL', 'doc/entity_export_5200.xml', 2, '2020-04-23 00:44:39'),
(13493, 5201, 'IMFL', 'doc/entity_export_5201.xml', 2, '2020-04-23 00:46:36'),
(13494, 5202, 'IMFL', 'doc/entity_export_5202.xml', 2, '2020-04-23 00:53:48'),
(13495, 5203, 'IMFL', 'doc/entity_export_5203.xml', 2, '2020-04-23 00:55:16'),
(13496, 5204, 'IMFL', 'doc/entity_export_5204.xml', 2, '2020-04-23 00:58:05'),
(13497, 5205, 'IMFL', 'doc/entity_export_5205.xml', 2, '2020-04-23 01:00:07'),
(13498, 5206, 'IMFL', 'doc/entity_export_5206.xml', 2, '2020-04-23 01:01:58'),
(13499, 5207, 'IMFL', 'doc/entity_export_5207.xml', 2, '2020-04-23 01:02:44'),
(13500, 5208, 'IMFL', 'doc/entity_export_5208.xml', 2, '2020-04-23 01:04:13'),
(13501, 5209, 'IMFL', 'doc/entity_export_5209.xml', 2, '2020-04-23 01:05:49'),
(13505, 5232, 'IMFL', 'doc/entity_export_5232.xml', 2, '2020-05-22 11:00:07'),
(13506, 5233, 'IMFL', 'doc/entity_export_5233.xml', 2, '2020-05-22 11:10:17'),
(13507, 5234, 'IMFL', 'doc/entity_export_5234.xml', 2, '2020-05-22 11:12:38'),
(13508, 5235, 'IMFL', 'doc/entity_export_5235.xml', 2, '2020-05-22 11:13:42'),
(13509, 5236, 'IMFL', 'doc/entity_export_5236.xml', 2, '2020-05-22 11:14:36'),
(13510, 5237, 'IMFL', 'doc/entity_export_5237.xml', 2, '2020-05-22 11:15:32'),
(13511, 5238, 'IMFL', 'doc/entity_export_5238.xml', 2, '2020-05-22 11:20:56'),
(13512, 5239, 'IMFL', 'doc/entity_export_5239.xml', 2, '2020-05-22 11:22:51'),
(13513, 5240, 'IMFL', 'doc/entity_export_5240.xml', 2, '2020-05-22 11:24:08'),
(13514, 5241, 'IMFL', 'doc/entity_export_5241.xml', 2, '2020-05-22 11:24:32'),
(13515, 5242, 'IMFL', 'doc/entity_export_5242.xml', 2, '2020-05-22 11:24:57'),
(13516, 5243, 'IMFL', 'doc/entity_export_5243.xml', 2, '2020-05-22 11:25:08'),
(13517, 5244, 'IMFL', 'doc/entity_export_5244.xml', 2, '2020-05-22 11:25:14'),
(13518, 5245, 'IMFL', 'doc/entity_export_5245.xml', 2, '2020-05-22 11:25:36'),
(13519, 5246, 'IMFL', 'doc/entity_export_5246.xml', 2, '2020-05-22 11:25:55'),
(13520, 5247, 'IMFL', 'doc/entity_export_5247.xml', 2, '2020-05-22 11:26:35'),
(13521, 5248, 'IMFL', 'doc/entity_export_5248.xml', 2, '2020-05-22 11:26:57'),
(13522, 5249, 'IMFL', 'doc/entity_export_5249.xml', 2, '2020-05-22 11:28:03'),
(13523, 5250, 'IMFL', 'doc/entity_export_5250.xml', 2, '2020-05-22 11:34:36'),
(13524, 5251, 'IMFL', 'doc/entity_export_5251.xml', 2, '2020-05-22 11:37:49'),
(13525, 5252, 'IMFL', 'doc/entity_export_5252.xml', 2, '2020-05-22 11:40:42'),
(13526, 5253, 'IMFL', 'doc/entity_export_5253.xml', 2, '2020-05-22 11:42:31'),
(13527, 5254, 'IMFL', 'doc/entity_export_5254.xml', 2, '2020-05-22 11:48:48'),
(13528, 5255, 'IMFL', 'doc/entity_export_5255.xml', 2, '2020-05-22 13:32:23'),
(13529, 5257, 'IMFL', 'doc/entity_export_5257.xml', 2, '2020-05-22 13:44:09'),
(13530, 5258, 'IMFL', 'doc/entity_export_5258.xml', 2, '2020-05-22 13:45:21'),
(13531, 5259, 'IMFL', 'doc/entity_export_5259.xml', 2, '2020-05-22 13:50:11'),
(13532, 5260, 'IMFL', 'doc/entity_export_5260.xml', 2, '2020-05-22 14:00:11'),
(13533, 5261, 'IMFL', 'doc/entity_export_5261.xml', 2, '2020-05-22 14:14:27'),
(13749, 5267, 'IMFL', 'doc/entity_export_5267.xml', 2, '2020-09-02 15:46:01'),
(13750, 5268, 'IMFL', 'doc/entity_export_5268.xml', 2, '2020-10-19 06:25:29'),
(13751, 5269, 'ECSN', 'Home ', 2, '2021-02-17 11:57:37'),
(13752, 5269, 'PGRD', '#3872', 2, '2021-02-17 11:57:37'),
(13753, 5270, 'ECSN', 'Marquee', 2, '2021-02-17 11:57:37'),
(13754, 5270, 'PGRD', '#3974', 2, '2021-02-17 11:57:37'),
(13755, 5271, 'ECSN', 'About Us', 2, '2021-02-17 11:57:38'),
(13756, 5271, 'PGRD', '#3894', 2, '2021-02-17 11:57:38'),
(13757, 5272, 'ECSN', 'Accordion', 2, '2021-02-17 11:57:38'),
(13758, 5272, 'PGRD', '#4618', 2, '2021-02-17 11:57:38'),
(13759, 5273, 'ECSN', 'Reach Us', 2, '2021-02-17 11:57:38'),
(13760, 5273, 'PGRD', '#3948', 2, '2021-02-17 11:57:39'),
(13772, 5265, 'ECSN', 'Test Heading', 2, '2021-03-03 05:37:48'),
(13773, 5265, 'ECLN', 'Test Sub Heading', 2, '2021-03-03 05:37:48'),
(13774, 5274, 'ECSN', 'Section II', 2, '2021-03-03 05:38:15'),
(13775, 5274, 'ECLN', 'Section Subheading II', 2, '2021-03-03 05:38:16'),
(13776, 5275, 'ECSN', 'Section III', 2, '2021-03-03 05:39:12'),
(13777, 5275, 'ECLN', 'Sub Heading III', 2, '2021-03-03 05:39:12'),
(13800, 5144, 'PGRD', '', 2, '2021-03-03 05:49:10'),
(13801, 5144, 'ECSN', 'Section', 2, '2021-03-03 05:49:10'),
(13802, 5144, 'ECLN', 'Section Content Demo', 2, '2021-03-03 05:49:10'),
(13803, 5144, 'PGPT', '', 2, '2021-03-03 05:49:10'),
(13804, 5144, 'PGKW', '', 2, '2021-03-03 05:49:10'),
(13805, 5144, 'PGPD', '', 2, '2021-03-03 05:49:10'),
(13806, 5144, 'PGIA', '', 2, '2021-03-03 05:49:11'),
(13807, 5144, 'PGIB', '', 2, '2021-03-03 05:49:11'),
(13808, 5144, 'PGIC', '', 2, '2021-03-03 05:49:11'),
(13809, 5144, 'PGPL', 'layout_page', 2, '2021-03-03 05:49:11'),
(13810, 5144, 'PGAT', 'ac72a33191badcf83b847b16d530a5d8', 2, '2021-03-03 05:49:11'),
(13844, 5262, 'PGRD', '', 2, '2021-03-03 05:53:48'),
(13845, 5262, 'ECSN', 'About Us', 2, '2021-03-03 05:53:48'),
(13846, 5262, 'ECLN', 'About Us', 2, '2021-03-03 05:53:48'),
(13847, 5262, 'PGPT', '', 2, '2021-03-03 05:53:48'),
(13848, 5262, 'PGKW', '', 2, '2021-03-03 05:53:48'),
(13849, 5262, 'PGPD', '', 2, '2021-03-03 05:53:49'),
(13850, 5262, 'PGIA', '', 2, '2021-03-03 05:53:49'),
(13851, 5262, 'PGIB', 'terminal//default/images/b_5262_1.jpg', 2, '2021-03-03 05:53:49'),
(13852, 5262, 'PGIC', '', 2, '2021-03-03 05:53:49'),
(13853, 5262, 'PGPL', 'layout_page', 2, '2021-03-03 05:53:49'),
(13854, 5262, 'PGAT', 'ac72a33191badcf83b847b16d530a5d8', 2, '2021-03-03 05:53:49'),
(13910, 5264, 'PGRD', '', 2, '2021-03-03 06:02:00'),
(13911, 5264, 'ECSN', 'Addon Page', 2, '2021-03-03 06:02:00'),
(13912, 5264, 'ECLN', 'Addon Page Name', 2, '2021-03-03 06:02:00'),
(13913, 5264, 'PGPT', '', 2, '2021-03-03 06:02:00'),
(13914, 5264, 'PGKW', '', 2, '2021-03-03 06:02:01'),
(13915, 5264, 'PGPD', '', 2, '2021-03-03 06:02:01'),
(13916, 5264, 'PGIA', '', 2, '2021-03-03 06:02:01'),
(13917, 5264, 'PGIB', '', 2, '2021-03-03 06:02:01'),
(13918, 5264, 'PGIC', '', 2, '2021-03-03 06:02:01'),
(13919, 5264, 'PGPL', 'layout_right', 2, '2021-03-03 06:02:01'),
(13920, 5264, 'PGAT', '8ce960977f90910604290c380259d99a', 2, '2021-03-03 06:02:01'),
(13972, 5730, 'COEC', 'E.Code', 2, '2021-05-20 02:52:40'),
(13973, 5730, 'COFN', 'E.Name', 2, '2021-05-20 02:52:40'),
(13974, 5730, 'COEM', 'Emailid', 2, '2021-05-20 02:52:40'),
(13975, 5731, 'COEC', '10534', 2, '2021-05-20 02:52:40'),
(13976, 5731, 'COFN', 'Gowthmi R', 2, '2021-05-20 02:52:40'),
(13977, 5731, 'COEM', 'tg10534@corp.transactglobal.com', 2, '2021-05-20 02:52:40'),
(13978, 5732, 'COEC', '11547', 2, '2021-05-20 02:52:40'),
(13979, 5732, 'COFN', 'Harish K', 2, '2021-05-20 02:52:40'),
(13980, 5732, 'COEM', 'tg11547@corp.transactglobal.com', 2, '2021-05-20 02:52:40'),
(13981, 5733, 'COEC', '11688', 2, '2021-05-20 02:52:40'),
(13982, 5733, 'COFN', 'Ruban', 2, '2021-05-20 02:52:40'),
(13983, 5733, 'COEM', 'tg11688@corp.transactglobal.com', 2, '2021-05-20 02:52:40'),
(13984, 5734, 'COEC', '11750', 2, '2021-05-20 02:52:40'),
(13985, 5734, 'COFN', 'Sumanth G V', 2, '2021-05-20 02:52:40'),
(13986, 5734, 'COEM', 'tg11750@corp.transactglobal.com', 2, '2021-05-20 02:52:40'),
(13987, 5735, 'COEC', '11763', 2, '2021-05-20 02:52:41'),
(13988, 5735, 'COFN', 'G B Sudeep', 2, '2021-05-20 02:52:41'),
(13989, 5735, 'COEM', 'tg11763@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(13990, 5736, 'COEC', '11800', 2, '2021-05-20 02:52:41'),
(13991, 5736, 'COFN', 'Chandrshekar P', 2, '2021-05-20 02:52:41'),
(13992, 5736, 'COEM', 'tg11800@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(13993, 5737, 'COEC', '11933', 2, '2021-05-20 02:52:41'),
(13994, 5737, 'COFN', 'Chaithra Shree S', 2, '2021-05-20 02:52:41'),
(13995, 5737, 'COEM', 'tg11933@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(13996, 5738, 'COEC', '11975', 2, '2021-05-20 02:52:41'),
(13997, 5738, 'COFN', 'Amrutha R', 2, '2021-05-20 02:52:41'),
(13998, 5738, 'COEM', 'tg11975@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(13999, 5739, 'COEC', '11985', 2, '2021-05-20 02:52:41'),
(14000, 5739, 'COFN', 'Pavan K', 2, '2021-05-20 02:52:41'),
(14001, 5739, 'COEM', 'tg11985@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(14002, 5740, 'COEC', '12065', 2, '2021-05-20 02:52:41'),
(14003, 5740, 'COFN', 'Kruthika K', 2, '2021-05-20 02:52:41'),
(14004, 5740, 'COEM', 'tg12065@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(14005, 5741, 'COEC', '12093', 2, '2021-05-20 02:52:41'),
(14006, 5741, 'COFN', 'Naveen S N', 2, '2021-05-20 02:52:41'),
(14007, 5741, 'COEM', 'tg12093@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(14008, 5742, 'COEC', '12141', 2, '2021-05-20 02:52:41'),
(14009, 5742, 'COFN', 'Thanush', 2, '2021-05-20 02:52:41'),
(14010, 5742, 'COEM', 'tg12141@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(14011, 5743, 'COEC', '12198', 2, '2021-05-20 02:52:41'),
(14012, 5743, 'COFN', 'Sanjay L', 2, '2021-05-20 02:52:41'),
(14013, 5743, 'COEM', 'tg12198@corp.transactglobal.com', 2, '2021-05-20 02:52:41'),
(14014, 5744, 'COEC', '12203', 2, '2021-05-20 02:52:42'),
(14015, 5744, 'COFN', 'G Hemanth', 2, '2021-05-20 02:52:42'),
(14016, 5744, 'COEM', 'tg12203@corp.transactglobal.com', 2, '2021-05-20 02:52:42'),
(14017, 5745, 'COEC', '12204', 2, '2021-05-20 02:52:42'),
(14018, 5745, 'COFN', 'Shruthi N Sudi', 2, '2021-05-20 02:52:42'),
(14019, 5745, 'COEM', 'tg12204@corp.transactglobal.com', 2, '2021-05-20 02:52:42'),
(14020, 5746, 'COEC', '12219', 2, '2021-05-20 02:52:42'),
(14021, 5746, 'COFN', 'M M Prashanth', 2, '2021-05-20 02:52:42'),
(14022, 5746, 'COEM', 'tg12219@corp.transactglobal.com', 2, '2021-05-20 02:52:42'),
(14023, 5747, 'COEC', '12220', 2, '2021-05-20 02:52:42'),
(14024, 5747, 'COFN', 'Rekha B', 2, '2021-05-20 02:52:42'),
(14025, 5747, 'COEM', 'tg12220@corp.transactglobal.com', 2, '2021-05-20 02:52:42'),
(14026, 5748, 'COEC', '12221', 2, '2021-05-20 02:52:42'),
(14027, 5748, 'COFN', 'Anthony Deepak S A', 2, '2021-05-20 02:52:42'),
(14028, 5748, 'COEM', 'tg12221@corp.transactglobal.com', 2, '2021-05-20 02:52:42'),
(14029, 5749, 'COEC', '12222', 2, '2021-05-20 02:52:42'),
(14030, 5749, 'COFN', 'Kushal B L', 2, '2021-05-20 02:52:42'),
(14031, 5749, 'COEM', 'tg12222@corp.transactglobal.com', 2, '2021-05-20 02:52:42'),
(14032, 5750, 'COEC', '12223', 2, '2021-05-20 02:52:42'),
(14033, 5750, 'COFN', 'Dominic Savio A', 2, '2021-05-20 02:52:42'),
(14034, 5750, 'COEM', 'tg12223@corp.transactglobal.com', 2, '2021-05-20 02:52:42'),
(14035, 5751, 'COEC', '12224', 2, '2021-05-20 02:52:42'),
(14036, 5751, 'COFN', 'J Ronaldo Rahul', 2, '2021-05-20 02:52:42'),
(14037, 5751, 'COEM', 'tg12224@corp.transactglobal.com', 2, '2021-05-20 02:52:42'),
(14038, 5752, 'COEC', '12225', 2, '2021-05-20 02:52:43'),
(14039, 5752, 'COFN', 'Sandeep N C', 2, '2021-05-20 02:52:43'),
(14040, 5752, 'COEM', 'tg12225@corp.transactglobal.com', 2, '2021-05-20 02:52:43'),
(14041, 5753, 'COEC', '12226', 2, '2021-05-20 02:52:43'),
(14042, 5753, 'COFN', 'R Mahesh', 2, '2021-05-20 02:52:43'),
(14043, 5753, 'COEM', 'tg12226@corp.transactglobal.com', 2, '2021-05-20 02:52:43'),
(14044, 5754, 'COEC', '12227', 2, '2021-05-20 02:52:43'),
(14045, 5754, 'COFN', 'Kanikaraj V', 2, '2021-05-20 02:52:43'),
(14046, 5754, 'COEM', 'tg12227@corp.transactglobal.com', 2, '2021-05-20 02:52:43'),
(14047, 5755, 'COEC', '12228', 2, '2021-05-20 02:52:43'),
(14048, 5755, 'COFN', 'Shakthi Velu', 2, '2021-05-20 02:52:43'),
(14049, 5755, 'COEM', 'tg12228@corp.transactglobal.com', 2, '2021-05-20 02:52:43'),
(14050, 5756, 'COEC', '12229', 2, '2021-05-20 02:52:44'),
(14051, 5756, 'COFN', 'Yashwanth Kumar M', 2, '2021-05-20 02:52:44'),
(14052, 5756, 'COEM', 'tg12229@corp.transactglobal.com', 2, '2021-05-20 02:52:44'),
(14053, 5757, 'COEC', '12230', 2, '2021-05-20 02:52:44'),
(14054, 5757, 'COFN', 'Melwin V J', 2, '2021-05-20 02:52:44'),
(14055, 5757, 'COEM', 'tg12230@corp.transactglobal.com', 2, '2021-05-20 02:52:44'),
(14056, 5758, 'COEC', '12237', 2, '2021-05-20 02:52:44'),
(14057, 5758, 'COFN', 'Shashank Raju K S', 2, '2021-05-20 02:52:44'),
(14058, 5758, 'COEM', 'tg12237@corp.transactglobal.com', 2, '2021-05-20 02:52:44'),
(14059, 5759, 'COEC', '12238', 2, '2021-05-20 02:52:44'),
(14060, 5759, 'COFN', 'Shwetha R', 2, '2021-05-20 02:52:44'),
(14061, 5759, 'COEM', 'tg12238@corp.transactglobal.com', 2, '2021-05-20 02:52:44'),
(14062, 5760, 'COEC', '12240', 2, '2021-05-20 02:52:44'),
(14063, 5760, 'COFN', 'Numaan Shariff', 2, '2021-05-20 02:52:44'),
(14064, 5760, 'COEM', 'tg12240@corp.transactglobal.com', 2, '2021-05-20 02:52:44'),
(14065, 5761, 'COEC', '12241', 2, '2021-05-20 02:52:44'),
(14066, 5761, 'COFN', 'Venugopal M', 2, '2021-05-20 02:52:44'),
(14067, 5761, 'COEM', 'tg12241@corp.transactglobal.com', 2, '2021-05-20 02:52:44'),
(14068, 5762, 'COEC', '12243', 2, '2021-05-20 02:52:45'),
(14069, 5762, 'COFN', 'Abhishek Tiwary', 2, '2021-05-20 02:52:45'),
(14070, 5762, 'COEM', 'tg12243@corp.transactglobal.com', 2, '2021-05-20 02:52:45'),
(14071, 5763, 'COEC', '12244', 2, '2021-05-20 02:52:45'),
(14072, 5763, 'COFN', 'Malathi K', 2, '2021-05-20 02:52:45'),
(14073, 5763, 'COEM', 'tg12244@corp.transactglobal.com', 2, '2021-05-20 02:52:45'),
(14074, 5764, 'COEC', '12245', 2, '2021-05-20 02:52:45'),
(14075, 5764, 'COFN', 'Akshay V', 2, '2021-05-20 02:52:45'),
(14076, 5764, 'COEM', 'tg12245@corp.transactglobal.com', 2, '2021-05-20 02:52:45'),
(14077, 5765, 'COEC', '12246', 2, '2021-05-20 02:52:45'),
(14078, 5765, 'COFN', 'C Suhas', 2, '2021-05-20 02:52:45'),
(14079, 5765, 'COEM', 'tg12246@corp.transactglobal.com', 2, '2021-05-20 02:52:45'),
(14080, 5766, 'COEC', '12247', 2, '2021-05-20 02:52:45'),
(14081, 5766, 'COFN', 'Surendar Kumar A', 2, '2021-05-20 02:52:45'),
(14082, 5766, 'COEM', 'tg12247@corp.transactglobal.com', 2, '2021-05-20 02:52:45'),
(14083, 5767, 'COEC', '12248', 2, '2021-05-20 02:52:45'),
(14084, 5767, 'COFN', 'C Steeph Rocklin', 2, '2021-05-20 02:52:45'),
(14085, 5767, 'COEM', 'tg12248@corp.transactglobal.com', 2, '2021-05-20 02:52:45'),
(14086, 5768, 'COEC', '12249', 2, '2021-05-20 02:52:45'),
(14087, 5768, 'COFN', 'Navina A', 2, '2021-05-20 02:52:45'),
(14088, 5768, 'COEM', 'tg12249@corp.transactglobal.com', 2, '2021-05-20 02:52:45'),
(14089, 5769, 'COEC', '12250', 2, '2021-05-20 02:52:45'),
(14090, 5769, 'COFN', 'Bharath Kumar B S', 2, '2021-05-20 02:52:45'),
(14091, 5769, 'COEM', 'tg12250@corp.transactglobal.com', 2, '2021-05-20 02:52:45'),
(14092, 5770, 'COEC', '12251', 2, '2021-05-20 02:52:46'),
(14093, 5770, 'COFN', 'Shashi Kiran G S', 2, '2021-05-20 02:52:46'),
(14094, 5770, 'COEM', 'tg12251@corp.transactglobal.com', 2, '2021-05-20 02:52:46'),
(14095, 5771, 'COEC', '12252', 2, '2021-05-20 02:52:46'),
(14096, 5771, 'COFN', 'Mallesha S', 2, '2021-05-20 02:52:46'),
(14097, 5771, 'COEM', 'tg12252@corp.transactglobal.com', 2, '2021-05-20 02:52:46'),
(14098, 5772, 'COEC', '12253', 2, '2021-05-20 02:52:46'),
(14099, 5772, 'COFN', 'Manoj', 2, '2021-05-20 02:52:46'),
(14100, 5772, 'COEM', 'tg12253@corp.transactglobal.com', 2, '2021-05-20 02:52:46'),
(14101, 5773, 'COEC', '12255', 2, '2021-05-20 02:52:46'),
(14102, 5773, 'COFN', 'Kesavaraj', 2, '2021-05-20 02:52:46'),
(14103, 5773, 'COEM', 'tg12255@corp.transactglobal.com', 2, '2021-05-20 02:52:46'),
(14104, 5774, 'COEC', '12256', 2, '2021-05-20 02:52:46'),
(14105, 5774, 'COFN', 'Sowmya B K', 2, '2021-05-20 02:52:46'),
(14106, 5774, 'COEM', 'tg12256@corp.transactglobal.com', 2, '2021-05-20 02:52:46'),
(14107, 5775, 'COEC', '12257', 2, '2021-05-20 02:52:46'),
(14108, 5775, 'COFN', 'Lohith C', 2, '2021-05-20 02:52:46'),
(14109, 5775, 'COEM', 'tg12257@corp.transactglobal.com', 2, '2021-05-20 02:52:46'),
(14110, 5776, 'COEC', '12258', 2, '2021-05-20 02:52:46'),
(14111, 5776, 'COFN', 'Manoj S', 2, '2021-05-20 02:52:46'),
(14112, 5776, 'COEM', 'tg12258@corp.transactglobal.com', 2, '2021-05-20 02:52:46'),
(14113, 5777, 'COEC', '12259', 2, '2021-05-20 02:52:46'),
(14114, 5777, 'COFN', 'Abhay K Bharadwaj', 2, '2021-05-20 02:52:46'),
(14115, 5777, 'COEM', 'tg12259@corp.transactglobal.com', 2, '2021-05-20 02:52:46'),
(14116, 5778, 'COEC', '12260', 2, '2021-05-20 02:52:47'),
(14117, 5778, 'COFN', 'Lohith N', 2, '2021-05-20 02:52:47'),
(14118, 5778, 'COEM', 'tg12260@corp.transactglobal.com', 2, '2021-05-20 02:52:47'),
(14119, 5779, 'COEC', '12261', 2, '2021-05-20 02:52:47'),
(14120, 5779, 'COFN', 'Ravi Kumar H S', 2, '2021-05-20 02:52:47'),
(14121, 5779, 'COEM', 'tg12261@corp.transactglobal.com', 2, '2021-05-20 02:52:47'),
(14122, 5780, 'COEC', '12262', 2, '2021-05-20 02:52:47'),
(14123, 5780, 'COFN', 'Praveen M', 2, '2021-05-20 02:52:47'),
(14124, 5780, 'COEM', 'tg12262@corp.transactglobal.com', 2, '2021-05-20 02:52:47'),
(14125, 5781, 'COEC', '12263', 2, '2021-05-20 02:52:47'),
(14126, 5781, 'COFN', 'Chethan S', 2, '2021-05-20 02:52:47'),
(14127, 5781, 'COEM', 'tg12263@corp.transactglobal.com', 2, '2021-05-20 02:52:47'),
(14128, 5782, 'COEC', '12264', 2, '2021-05-20 02:52:47'),
(14129, 5782, 'COFN', 'Manoj Kumar K T', 2, '2021-05-20 02:52:47'),
(14130, 5782, 'COEM', 'tg12264@corp.transactglobal.com', 2, '2021-05-20 02:52:47'),
(14131, 5783, 'COEC', '12265', 2, '2021-05-20 02:52:47'),
(14132, 5783, 'COFN', 'Kishore K', 2, '2021-05-20 02:52:47'),
(14133, 5783, 'COEM', 'tg12265@corp.transactglobal.com', 2, '2021-05-20 02:52:47'),
(14134, 5784, 'COEC', '12266', 2, '2021-05-20 02:52:48'),
(14135, 5784, 'COFN', 'Mohit L Purohit', 2, '2021-05-20 02:52:48'),
(14136, 5784, 'COEM', 'tg12266@corp.transactglobal.com', 2, '2021-05-20 02:52:48'),
(14137, 5785, 'COEC', '12267', 2, '2021-05-20 02:52:48'),
(14138, 5785, 'COFN', 'Vinod Kumar M', 2, '2021-05-20 02:52:48'),
(14139, 5785, 'COEM', 'tg12267@corp.transactglobal.com', 2, '2021-05-20 02:52:48'),
(14140, 5786, 'COEC', '12268', 2, '2021-05-20 02:52:48'),
(14141, 5786, 'COFN', 'Eranna R', 2, '2021-05-20 02:52:48'),
(14142, 5786, 'COEM', 'tg12268@corp.transactglobal.com', 2, '2021-05-20 02:52:48'),
(14143, 5787, 'COEC', '12269', 2, '2021-05-20 02:52:48'),
(14144, 5787, 'COFN', 'Purushotham S', 2, '2021-05-20 02:52:48'),
(14145, 5787, 'COEM', 'tg12269@corp.transactglobal.com', 2, '2021-05-20 02:52:48'),
(14146, 5788, 'COEC', '12270', 2, '2021-05-20 02:52:48'),
(14147, 5788, 'COFN', 'Chetan R', 2, '2021-05-20 02:52:48'),
(14148, 5788, 'COEM', 'tg12270@corp.transactglobal.com', 2, '2021-05-20 02:52:48'),
(14149, 5789, 'COEC', '12271', 2, '2021-05-20 02:52:48'),
(14150, 5789, 'COFN', 'Vivek G', 2, '2021-05-20 02:52:48'),
(14151, 5789, 'COEM', 'tg12271@corp.transactglobal.com', 2, '2021-05-20 02:52:48'),
(14152, 5790, 'COEC', '12272', 2, '2021-05-20 02:52:48'),
(14153, 5790, 'COFN', 'Jeevan S', 2, '2021-05-20 02:52:48'),
(14154, 5790, 'COEM', 'tg12272@corp.transactglobal.com', 2, '2021-05-20 02:52:48'),
(14155, 5791, 'COEC', '12273', 2, '2021-05-20 02:52:49'),
(14156, 5791, 'COFN', 'Siddharth N', 2, '2021-05-20 02:52:49'),
(14157, 5791, 'COEM', 'tg12273@corp.transactglobal.com', 2, '2021-05-20 02:52:49'),
(14158, 5792, 'COEC', '12274', 2, '2021-05-20 02:52:49'),
(14159, 5792, 'COFN', 'Shruthi V', 2, '2021-05-20 02:52:49'),
(14160, 5792, 'COEM', 'tg12274@corp.transactglobal.com', 2, '2021-05-20 02:52:49'),
(14161, 5793, 'COEC', '12275', 2, '2021-05-20 02:52:49'),
(14162, 5793, 'COFN', 'Pavithra S', 2, '2021-05-20 02:52:49'),
(14163, 5793, 'COEM', 'tg12275@corp.transactglobal.com', 2, '2021-05-20 02:52:49'),
(14164, 5794, 'COEC', '12276', 2, '2021-05-20 02:52:49'),
(14165, 5794, 'COFN', 'Ramya B', 2, '2021-05-20 02:52:49'),
(14166, 5794, 'COEM', 'tg12276@corp.transactglobal.com', 2, '2021-05-20 02:52:49'),
(14167, 5795, 'COEC', '12277', 2, '2021-05-20 02:52:49'),
(14168, 5795, 'COFN', 'Aishwarya P', 2, '2021-05-20 02:52:49'),
(14169, 5795, 'COEM', 'tg12277@corp.transactglobal.com', 2, '2021-05-20 02:52:49'),
(14170, 5796, 'COEC', '12278', 2, '2021-05-20 02:52:50'),
(14171, 5796, 'COFN', 'Nandish A', 2, '2021-05-20 02:52:50'),
(14172, 5796, 'COEM', 'tg12278@corp.transactglobal.com', 2, '2021-05-20 02:52:50'),
(14173, 5797, 'COEC', '12279', 2, '2021-05-20 02:52:50'),
(14174, 5797, 'COFN', 'Yogish', 2, '2021-05-20 02:52:50'),
(14175, 5797, 'COEM', 'tg12279@corp.transactglobal.com', 2, '2021-05-20 02:52:50'),
(14176, 5798, 'COEC', '12280', 2, '2021-05-20 02:52:50'),
(14177, 5798, 'COFN', 'Yathish B', 2, '2021-05-20 02:52:50'),
(14178, 5798, 'COEM', 'tg12280@corp.transactglobal.com', 2, '2021-05-20 02:52:50'),
(14179, 5799, 'COEC', '12281', 2, '2021-05-20 02:52:50'),
(14180, 5799, 'COFN', 'Sagar H ', 2, '2021-05-20 02:52:50'),
(14181, 5799, 'COEM', 'tg12281@corp.transactglobal.com', 2, '2021-05-20 02:52:50'),
(14182, 5800, 'COEC', '12282', 2, '2021-05-20 02:52:50'),
(14183, 5800, 'COFN', 'Devaraju M', 2, '2021-05-20 02:52:50'),
(14184, 5800, 'COEM', 'tg12282@corp.transactglobal.com', 2, '2021-05-20 02:52:50'),
(14185, 5801, 'COEC', '12283', 2, '2021-05-20 02:52:50'),
(14186, 5801, 'COFN', 'Vinod R', 2, '2021-05-20 02:52:50'),
(14187, 5801, 'COEM', 'tg12283@corp.transactglobal.com', 2, '2021-05-20 02:52:50'),
(14188, 5802, 'COEC', '12284', 2, '2021-05-20 02:52:50'),
(14189, 5802, 'COFN', 'Thejesh R', 2, '2021-05-20 02:52:50'),
(14190, 5802, 'COEM', 'tg12284@corp.transactglobal.com', 2, '2021-05-20 02:52:50'),
(14191, 5803, 'COEC', '12285', 2, '2021-05-20 02:52:51'),
(14192, 5803, 'COFN', 'Nikhil Raj ', 2, '2021-05-20 02:52:51'),
(14193, 5803, 'COEM', 'tg12285@corp.transactglobal.com', 2, '2021-05-20 02:52:51'),
(14194, 5804, 'COEC', '12286', 2, '2021-05-20 02:52:51'),
(14195, 5804, 'COFN', 'Yogesh G', 2, '2021-05-20 02:52:51'),
(14196, 5804, 'COEM', 'tg12286@corp.transactglobal.com', 2, '2021-05-20 02:52:51'),
(14197, 5805, 'COEC', '12287', 2, '2021-05-20 02:52:51'),
(14198, 5805, 'COFN', 'Sheshadhri B', 2, '2021-05-20 02:52:51'),
(14199, 5805, 'COEM', 'tg12287@corp.transactglobal.com', 2, '2021-05-20 02:52:51');

-- --------------------------------------------------------

--
-- Table structure for table `eav_addon_vc128uniq`
--

CREATE TABLE `eav_addon_vc128uniq` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` varchar(128) DEFAULT NULL,
  `ea_value_hash` varchar(32) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `eav_addon_vc128uniq`
--

INSERT INTO `eav_addon_vc128uniq` (`id`, `parent_id`, `ea_code`, `ea_value`, `ea_value_hash`, `user_id`, `timestamp_punch`) VALUES
(332, 3655, 'CHCD', 'default', '87e464a5111f3395c8111429a91365f4', 2, '2019-09-21 13:55:00'),
(361, 5144, 'PGCD', 'section_content_demo', 'ad9d866dee5f88e4d751a3ee4060c313', 2, '2021-03-03 05:49:10'),
(365, 5262, 'PGCD', 'about_us', '828da7a17fe98b2c14b736edda7ae08a', 2, '2021-03-03 05:53:48'),
(371, 5264, 'PGCD', 'addon_page_demo', '15a6e4b2b9e4072e9eeae756ae35c204', 2, '2021-03-03 06:02:00');

--
-- Triggers `eav_addon_vc128uniq`
--
DELIMITER $$
CREATE TRIGGER `trg_eav_addon_vc128uniq_before_ins` BEFORE INSERT ON `eav_addon_vc128uniq` FOR EACH ROW BEGIN



 IF(LENGTH(new.ea_value)=0) THEN

        

            SET new.ea_value = new.id;

    END IF;        

            SET new.ea_value_hash=md5(concat(new.ea_code,'[C]',new.ea_value));

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_eav_addon_vc128uniq_before_upd` BEFORE UPDATE ON `eav_addon_vc128uniq` FOR EACH ROW BEGIN



     IF(LENGTH(new.ea_value)=0) THEN

        

            SET new.ea_value = new.id;

    END IF;        

            SET new.ea_value_hash=md5(concat(new.ea_code,'[C]',new.ea_value));

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ecb_av_addon_text`
--

CREATE TABLE `ecb_av_addon_text` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` text,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ecb_av_addon_text`
--

INSERT INTO `ecb_av_addon_text` (`id`, `parent_id`, `ea_code`, `ea_value`, `user_id`, `timestamp_punch`) VALUES
(15, 4150, 'ATTM', '<TMPL_LOOP DATA_INFO>\r\n  <TMPL_VAR TEXT>\r\n  <TMPL_VAR TEAR>  \r\n</TMPL_LOOP>', 2, '2019-09-23 10:23:06'),
(23, 2290, 'ATTM', '<TMPL_LOOP DATA_INFO>\r\n         <TMPL_VAR DETAIL>\r\n</TMPL_LOOP>\r\n', 2, '2020-06-15 12:57:56'),
(24, 4224, 'ATTM', '<TMPL_LOOP DATA_INFO>\r\n   <TMPL_VAR TEXT><br><TMPL_VAR TEXTB>\r\n</TMPL_LOOP>\r\n Generated From Template ', 2, '2020-08-30 14:47:26');

-- --------------------------------------------------------

--
-- Table structure for table `ecb_av_addon_varchar`
--

CREATE TABLE `ecb_av_addon_varchar` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `ea_code` char(4) DEFAULT NULL,
  `ea_value` varchar(1024) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ecb_av_addon_varchar`
--

INSERT INTO `ecb_av_addon_varchar` (`id`, `parent_id`, `ea_code`, `ea_value`, `user_id`, `timestamp_punch`) VALUES
(26716, 2176, 'APIT', 'ITTX', 2, '2018-12-27 08:02:58'),
(26718, 2176, 'APCL', '', 2, '2018-12-27 08:02:58'),
(26719, 2176, 'APIH', '', 2, '2018-12-27 08:02:58'),
(26720, 2176, 'APAL', '', 2, '2018-12-27 08:02:58'),
(26721, 2176, 'APMA', '', 2, '2018-12-27 08:02:58'),
(26722, 2176, 'APHT', '', 2, '2018-12-27 08:02:58'),
(26723, 2176, 'APMD', '', 2, '2018-12-27 08:02:58'),
(26724, 2176, 'APXD', '', 2, '2018-12-27 08:02:58'),
(26725, 2176, 'APMY', '', 2, '2018-12-27 08:02:59'),
(26726, 2176, 'APXY', '', 2, '2018-12-27 08:02:59'),
(26727, 2176, 'APDD', '0', 2, '2018-12-27 08:02:59'),
(26728, 2176, 'APAD', '0', 2, '2018-12-27 08:02:59'),
(26729, 2176, 'APHD', '', 2, '2018-12-27 08:02:59'),
(26730, 2176, 'APRO', '', 2, '2018-12-27 08:02:59'),
(26731, 2176, 'APFR', '', 2, '2018-12-27 08:02:59'),
(26732, 2176, 'APMR', '', 2, '2018-12-27 08:02:59'),
(26733, 2176, 'APGR', '', 2, '2018-12-27 08:02:59'),
(26734, 2176, 'APTM', '', 2, '2018-12-27 08:02:59'),
(26735, 2176, 'APFH', '', 2, '2018-12-27 08:02:59'),
(26736, 2176, 'APFO', '', 2, '2018-12-27 08:02:59'),
(26737, 2176, 'APFN', '', 2, '2018-12-27 08:02:59'),
(26738, 2176, 'APFP', '', 2, '2018-12-27 08:02:59'),
(26739, 2176, 'APFS', '', 2, '2018-12-27 08:02:59'),
(26740, 2176, 'APLO', '', 2, '2018-12-27 08:02:59'),
(26741, 2176, 'APFX', '', 2, '2018-12-27 08:02:59'),
(26742, 2176, 'APFM', '', 2, '2018-12-27 08:02:59'),
(26743, 2176, 'APIS', '', 2, '2018-12-27 08:02:59'),
(26744, 2176, 'APTS', '', 2, '2018-12-27 08:02:59'),
(26745, 2176, 'APTN', '', 2, '2018-12-27 08:02:59'),
(26746, 2176, 'APTF', '', 2, '2018-12-27 08:02:59'),
(26747, 2176, 'APTD', '', 2, '2018-12-27 08:02:59'),
(27398, 2436, 'APGO', '', 2, '2019-01-09 07:49:14'),
(27399, 2436, 'APSL', '', 2, '2019-01-09 07:49:14'),
(27527, 2440, 'APIT', 'ITRG', 2, '2019-01-09 08:08:59'),
(27528, 2440, 'APCL', '', 2, '2019-01-09 08:08:59'),
(27529, 2440, 'APIH', '', 2, '2019-01-09 08:08:59'),
(27530, 2440, 'APAL', '', 2, '2019-01-09 08:08:59'),
(27531, 2440, 'APMA', '0', 2, '2019-01-09 08:08:59'),
(27532, 2440, 'APHT', '', 2, '2019-01-09 08:08:59'),
(27533, 2440, 'APAD', '0', 2, '2019-01-09 08:08:59'),
(27534, 2440, 'APHD', '', 2, '2019-01-09 08:08:59'),
(27535, 2440, 'APRO', '', 2, '2019-01-09 08:08:59'),
(27536, 2440, 'APMD', '', 2, '2019-01-09 08:08:59'),
(27537, 2440, 'APXD', '', 2, '2019-01-09 08:08:59'),
(27538, 2440, 'APMY', '', 2, '2019-01-09 08:08:59'),
(27539, 2440, 'APXY', '', 2, '2019-01-09 08:08:59'),
(27540, 2440, 'APDD', '0', 2, '2019-01-09 08:08:59'),
(27541, 2440, 'APFR', '', 2, '2019-01-09 08:08:59'),
(27542, 2440, 'APMR', '', 2, '2019-01-09 08:08:59'),
(27543, 2440, 'APGR', '', 2, '2019-01-09 08:08:59'),
(27544, 2440, 'APTM', '', 2, '2019-01-09 08:08:59'),
(27545, 2440, 'APFH', '', 2, '2019-01-09 08:08:59'),
(27546, 2440, 'APFO', '', 2, '2019-01-09 08:08:59'),
(27547, 2440, 'APFN', '', 2, '2019-01-09 08:08:59'),
(27548, 2440, 'APFP', '', 2, '2019-01-09 08:08:59'),
(27549, 2440, 'APFS', '', 2, '2019-01-09 08:08:59'),
(27550, 2440, 'APLO', '', 2, '2019-01-09 08:08:59'),
(27551, 2440, 'APFX', '', 2, '2019-01-09 08:08:59'),
(27552, 2440, 'APFM', '', 2, '2019-01-09 08:09:00'),
(27553, 2440, 'APIS', '', 2, '2019-01-09 08:09:00'),
(27554, 2440, 'APTS', '', 2, '2019-01-09 08:09:00'),
(27555, 2440, 'APTN', '', 2, '2019-01-09 08:09:00'),
(27556, 2440, 'APTF', '', 2, '2019-01-09 08:09:00'),
(27557, 2440, 'APTD', '', 2, '2019-01-09 08:09:00'),
(27561, 2441, 'APAL', '', 2, '2019-01-09 08:09:37'),
(27564, 2441, 'APAD', '0', 2, '2019-01-09 08:09:37'),
(27566, 2441, 'APRO', '', 2, '2019-01-09 08:09:37'),
(27567, 2441, 'APMD', '', 2, '2019-01-09 08:09:37'),
(27568, 2441, 'APXD', '', 2, '2019-01-09 08:09:37'),
(27569, 2441, 'APMY', '', 2, '2019-01-09 08:09:37'),
(27570, 2441, 'APXY', '', 2, '2019-01-09 08:09:37'),
(27571, 2441, 'APDD', '0', 2, '2019-01-09 08:09:37'),
(27572, 2441, 'APFR', '', 2, '2019-01-09 08:09:37'),
(27573, 2441, 'APMR', '', 2, '2019-01-09 08:09:38'),
(27574, 2441, 'APGR', '', 2, '2019-01-09 08:09:38'),
(27575, 2441, 'APTM', '', 2, '2019-01-09 08:09:38'),
(27576, 2441, 'APFH', '', 2, '2019-01-09 08:09:38'),
(27577, 2441, 'APFO', '', 2, '2019-01-09 08:09:38'),
(27578, 2441, 'APFN', '', 2, '2019-01-09 08:09:38'),
(27579, 2441, 'APFP', '', 2, '2019-01-09 08:09:38'),
(27580, 2441, 'APFS', '', 2, '2019-01-09 08:09:38'),
(27581, 2441, 'APLO', '', 2, '2019-01-09 08:09:38'),
(27582, 2441, 'APFX', '', 2, '2019-01-09 08:09:38'),
(27583, 2441, 'APFM', '', 2, '2019-01-09 08:09:38'),
(27584, 2441, 'APIS', '', 2, '2019-01-09 08:09:38'),
(27585, 2441, 'APTS', '', 2, '2019-01-09 08:09:38'),
(27586, 2441, 'APTN', '', 2, '2019-01-09 08:09:38'),
(27587, 2441, 'APTF', '', 2, '2019-01-09 08:09:38'),
(27588, 2441, 'APTD', '', 2, '2019-01-09 08:09:38'),
(27589, 2442, 'APIT', 'ITDT', 2, '2019-01-09 08:14:11'),
(27590, 2442, 'APGO', '', 2, '2019-01-09 08:14:11'),
(27591, 2442, 'APSL', '', 2, '2019-01-09 08:14:11'),
(27592, 2442, 'APCL', '', 2, '2019-01-09 08:14:11'),
(27593, 2442, 'APIH', '', 2, '2019-01-09 08:14:11'),
(27594, 2442, 'APAL', '', 2, '2019-01-09 08:14:11'),
(27595, 2442, 'APMA', '0', 2, '2019-01-09 08:14:11'),
(27596, 2442, 'APHT', '', 2, '2019-01-09 08:14:11'),
(27597, 2442, 'APAD', '0', 2, '2019-01-09 08:14:11'),
(27598, 2442, 'APHD', '', 2, '2019-01-09 08:14:11'),
(27599, 2442, 'APRO', '', 2, '2019-01-09 08:14:11'),
(27600, 2442, 'APMD', '', 2, '2019-01-09 08:14:11'),
(27601, 2442, 'APXD', '', 2, '2019-01-09 08:14:11'),
(27602, 2442, 'APMY', '', 2, '2019-01-09 08:14:11'),
(27603, 2442, 'APXY', '', 2, '2019-01-09 08:14:11'),
(27604, 2442, 'APDD', '0', 2, '2019-01-09 08:14:11'),
(27605, 2442, 'APFR', '', 2, '2019-01-09 08:14:11'),
(27606, 2442, 'APMR', '', 2, '2019-01-09 08:14:11'),
(27607, 2442, 'APGR', '', 2, '2019-01-09 08:14:11'),
(27608, 2442, 'APTM', '', 2, '2019-01-09 08:14:11'),
(27609, 2442, 'APFH', '', 2, '2019-01-09 08:14:11'),
(27610, 2442, 'APFO', '', 2, '2019-01-09 08:14:12'),
(27611, 2442, 'APFN', '', 2, '2019-01-09 08:14:12'),
(27612, 2442, 'APFP', '', 2, '2019-01-09 08:14:12'),
(27613, 2442, 'APFS', '', 2, '2019-01-09 08:14:12'),
(27614, 2442, 'APLO', '', 2, '2019-01-09 08:14:12'),
(27615, 2442, 'APFX', '', 2, '2019-01-09 08:14:12'),
(27616, 2442, 'APFM', '', 2, '2019-01-09 08:14:12'),
(27617, 2442, 'APIS', '', 2, '2019-01-09 08:14:12'),
(27618, 2442, 'APTS', '', 2, '2019-01-09 08:14:12'),
(27619, 2442, 'APTN', '', 2, '2019-01-09 08:14:12'),
(27620, 2442, 'APTF', '', 2, '2019-01-09 08:14:12'),
(27621, 2442, 'APTD', '', 2, '2019-01-09 08:14:12'),
(27655, 2444, 'APIT', 'ITLA', 2, '2019-01-09 08:16:57'),
(27656, 2444, 'APGO', '', 2, '2019-01-09 08:16:57'),
(27657, 2444, 'APSL', '', 2, '2019-01-09 08:16:57'),
(27658, 2444, 'APCL', '', 2, '2019-01-09 08:16:57'),
(27659, 2444, 'APIH', '', 2, '2019-01-09 08:16:57'),
(27660, 2444, 'APAL', '', 2, '2019-01-09 08:16:58'),
(27661, 2444, 'APMA', '0', 2, '2019-01-09 08:16:58'),
(27662, 2444, 'APHT', '', 2, '2019-01-09 08:16:58'),
(27663, 2444, 'APAD', '0', 2, '2019-01-09 08:16:58'),
(27664, 2444, 'APHD', '', 2, '2019-01-09 08:16:58'),
(27665, 2444, 'APRO', '', 2, '2019-01-09 08:16:58'),
(27666, 2444, 'APMD', '', 2, '2019-01-09 08:16:58'),
(27667, 2444, 'APXD', '', 2, '2019-01-09 08:16:58'),
(27668, 2444, 'APMY', '', 2, '2019-01-09 08:16:58'),
(27669, 2444, 'APXY', '', 2, '2019-01-09 08:16:58'),
(27670, 2444, 'APDD', '0', 2, '2019-01-09 08:16:58'),
(27671, 2444, 'APFR', '', 2, '2019-01-09 08:16:58'),
(27672, 2444, 'APMR', '', 2, '2019-01-09 08:16:58'),
(27673, 2444, 'APGR', '', 2, '2019-01-09 08:16:58'),
(27674, 2444, 'APTM', '', 2, '2019-01-09 08:16:58'),
(27675, 2444, 'APFH', '', 2, '2019-01-09 08:16:58'),
(27676, 2444, 'APFO', '', 2, '2019-01-09 08:16:58'),
(27677, 2444, 'APFN', '', 2, '2019-01-09 08:16:58'),
(27678, 2444, 'APFP', '', 2, '2019-01-09 08:16:58'),
(27679, 2444, 'APFS', '', 2, '2019-01-09 08:16:58'),
(27680, 2444, 'APLO', '', 2, '2019-01-09 08:16:58'),
(27681, 2444, 'APFX', '', 2, '2019-01-09 08:16:58'),
(27682, 2444, 'APFM', '', 2, '2019-01-09 08:16:58'),
(27683, 2444, 'APIS', '', 2, '2019-01-09 08:16:58'),
(27684, 2444, 'APTS', '', 2, '2019-01-09 08:16:58'),
(27685, 2444, 'APTN', '', 2, '2019-01-09 08:16:58'),
(27686, 2444, 'APTF', '', 2, '2019-01-09 08:16:58'),
(27687, 2444, 'APTD', '', 2, '2019-01-09 08:16:58'),
(27688, 2445, 'APIT', 'ITTB', 2, '2019-01-09 08:17:31'),
(27689, 2445, 'APCL', '', 2, '2019-01-09 08:17:31'),
(27690, 2445, 'APIH', '', 2, '2019-01-09 08:17:31'),
(27691, 2445, 'APAL', '', 2, '2019-01-09 08:17:31'),
(27692, 2445, 'APMA', '0', 2, '2019-01-09 08:17:31'),
(27693, 2445, 'APHT', '', 2, '2019-01-09 08:17:31'),
(27694, 2445, 'APAD', '0', 2, '2019-01-09 08:17:31'),
(27695, 2445, 'APHD', '', 2, '2019-01-09 08:17:31'),
(27696, 2445, 'APRO', '', 2, '2019-01-09 08:17:31'),
(27697, 2445, 'APMD', '', 2, '2019-01-09 08:17:31'),
(27698, 2445, 'APXD', '', 2, '2019-01-09 08:17:31'),
(27699, 2445, 'APMY', '', 2, '2019-01-09 08:17:31'),
(27700, 2445, 'APXY', '', 2, '2019-01-09 08:17:31'),
(27701, 2445, 'APDD', '0', 2, '2019-01-09 08:17:31'),
(27702, 2445, 'APFR', '', 2, '2019-01-09 08:17:31'),
(27703, 2445, 'APMR', '', 2, '2019-01-09 08:17:32'),
(27704, 2445, 'APGR', '', 2, '2019-01-09 08:17:32'),
(27705, 2445, 'APTM', '', 2, '2019-01-09 08:17:32'),
(27706, 2445, 'APFH', '', 2, '2019-01-09 08:17:32'),
(27707, 2445, 'APFO', '', 2, '2019-01-09 08:17:32'),
(27708, 2445, 'APFN', '', 2, '2019-01-09 08:17:32'),
(27709, 2445, 'APFP', '', 2, '2019-01-09 08:17:32'),
(27710, 2445, 'APFS', '', 2, '2019-01-09 08:17:32'),
(27711, 2445, 'APLO', '', 2, '2019-01-09 08:17:32'),
(27712, 2445, 'APFX', '', 2, '2019-01-09 08:17:32'),
(27713, 2445, 'APFM', '', 2, '2019-01-09 08:17:32'),
(27714, 2445, 'APIS', '', 2, '2019-01-09 08:17:32'),
(27715, 2445, 'APTS', '', 2, '2019-01-09 08:17:32'),
(27716, 2445, 'APTN', '', 2, '2019-01-09 08:17:32'),
(27717, 2445, 'APTF', '', 2, '2019-01-09 08:17:32'),
(27718, 2445, 'APTD', '', 2, '2019-01-09 08:17:32'),
(27817, 2448, 'APIT', 'ITIG', 2, '2019-01-09 08:24:44'),
(27818, 2448, 'APGO', '', 2, '2019-01-09 08:24:44'),
(27819, 2448, 'APSL', '', 2, '2019-01-09 08:24:44'),
(27820, 2448, 'APCL', '', 2, '2019-01-09 08:24:44'),
(27821, 2448, 'APIH', '', 2, '2019-01-09 08:24:44'),
(27822, 2448, 'APAL', '', 2, '2019-01-09 08:24:44'),
(27823, 2448, 'APMA', '0', 2, '2019-01-09 08:24:45'),
(27824, 2448, 'APHT', '', 2, '2019-01-09 08:24:45'),
(27825, 2448, 'APAD', '0', 2, '2019-01-09 08:24:45'),
(27826, 2448, 'APHD', '', 2, '2019-01-09 08:24:45'),
(27827, 2448, 'APRO', '', 2, '2019-01-09 08:24:45'),
(27828, 2448, 'APMD', '', 2, '2019-01-09 08:24:45'),
(27829, 2448, 'APXD', '', 2, '2019-01-09 08:24:45'),
(27830, 2448, 'APMY', '', 2, '2019-01-09 08:24:45'),
(27831, 2448, 'APXY', '', 2, '2019-01-09 08:24:45'),
(27832, 2448, 'APDD', '0', 2, '2019-01-09 08:24:45'),
(27833, 2448, 'APFR', '', 2, '2019-01-09 08:24:45'),
(27834, 2448, 'APMR', '', 2, '2019-01-09 08:24:45'),
(27835, 2448, 'APGR', '', 2, '2019-01-09 08:24:45'),
(27836, 2448, 'APTM', '', 2, '2019-01-09 08:24:45'),
(27837, 2448, 'APFH', '', 2, '2019-01-09 08:24:45'),
(27838, 2448, 'APFO', '', 2, '2019-01-09 08:24:46'),
(27839, 2448, 'APFN', '', 2, '2019-01-09 08:24:46'),
(27840, 2448, 'APFP', '', 2, '2019-01-09 08:24:46'),
(27841, 2448, 'APFS', '', 2, '2019-01-09 08:24:46'),
(27842, 2448, 'APLO', '', 2, '2019-01-09 08:24:46'),
(27843, 2448, 'APFX', '', 2, '2019-01-09 08:24:46'),
(27844, 2448, 'APFM', '', 2, '2019-01-09 08:24:46'),
(27845, 2448, 'APIS', '', 2, '2019-01-09 08:24:46'),
(27846, 2448, 'APTS', '', 2, '2019-01-09 08:24:46'),
(27847, 2448, 'APTN', '', 2, '2019-01-09 08:24:46'),
(27848, 2448, 'APTF', '', 2, '2019-01-09 08:24:46'),
(27849, 2448, 'APTD', '', 2, '2019-01-09 08:24:46'),
(27850, 2449, 'APIT', 'ITTG', 2, '2019-01-09 08:25:39'),
(27851, 2449, 'APGO', '', 2, '2019-01-09 08:25:39'),
(27852, 2449, 'APSL', '', 2, '2019-01-09 08:25:39'),
(27853, 2449, 'APCL', '', 2, '2019-01-09 08:25:40'),
(27854, 2449, 'APIH', '', 2, '2019-01-09 08:25:40'),
(27855, 2449, 'APAL', '', 2, '2019-01-09 08:25:40'),
(27856, 2449, 'APMA', '0', 2, '2019-01-09 08:25:40'),
(27857, 2449, 'APHT', '', 2, '2019-01-09 08:25:40'),
(27858, 2449, 'APAD', '0', 2, '2019-01-09 08:25:40'),
(27859, 2449, 'APHD', '', 2, '2019-01-09 08:25:40'),
(27860, 2449, 'APRO', '', 2, '2019-01-09 08:25:40'),
(27861, 2449, 'APMD', '', 2, '2019-01-09 08:25:40'),
(27862, 2449, 'APXD', '', 2, '2019-01-09 08:25:40'),
(27863, 2449, 'APMY', '', 2, '2019-01-09 08:25:40'),
(27864, 2449, 'APXY', '', 2, '2019-01-09 08:25:40'),
(27865, 2449, 'APDD', '0', 2, '2019-01-09 08:25:40'),
(27866, 2449, 'APFR', '', 2, '2019-01-09 08:25:40'),
(27867, 2449, 'APMR', '', 2, '2019-01-09 08:25:40'),
(27868, 2449, 'APGR', '', 2, '2019-01-09 08:25:40'),
(27869, 2449, 'APTM', '', 2, '2019-01-09 08:25:40'),
(27870, 2449, 'APFH', '', 2, '2019-01-09 08:25:40'),
(27871, 2449, 'APFO', '', 2, '2019-01-09 08:25:40'),
(27872, 2449, 'APFN', '', 2, '2019-01-09 08:25:40'),
(27873, 2449, 'APFP', '', 2, '2019-01-09 08:25:40'),
(27874, 2449, 'APFS', '', 2, '2019-01-09 08:25:40'),
(27875, 2449, 'APLO', '', 2, '2019-01-09 08:25:40'),
(27876, 2449, 'APFX', '', 2, '2019-01-09 08:25:40'),
(27877, 2449, 'APFM', '', 2, '2019-01-09 08:25:40'),
(27878, 2449, 'APIS', '', 2, '2019-01-09 08:25:40'),
(27879, 2449, 'APTS', '1', 2, '2019-01-09 08:25:40'),
(27880, 2449, 'APTN', 'Yes', 2, '2019-01-09 08:25:40'),
(27881, 2449, 'APTF', 'No', 2, '2019-01-09 08:25:40'),
(27882, 2449, 'APTD', '', 2, '2019-01-09 08:25:40'),
(27883, 2450, 'APIT', 'ITFI', 2, '2019-01-09 08:28:06'),
(27884, 2450, 'APGO', '', 2, '2019-01-09 08:28:06'),
(27885, 2450, 'APSL', '', 2, '2019-01-09 08:28:06'),
(27886, 2450, 'APCL', '', 2, '2019-01-09 08:28:07'),
(27887, 2450, 'APIH', '', 2, '2019-01-09 08:28:07'),
(27888, 2450, 'APAL', '', 2, '2019-01-09 08:28:07'),
(27889, 2450, 'APMA', '0', 2, '2019-01-09 08:28:07'),
(27890, 2450, 'APHT', '', 2, '2019-01-09 08:28:07'),
(27891, 2450, 'APAD', '0', 2, '2019-01-09 08:28:07'),
(27892, 2450, 'APHD', '', 2, '2019-01-09 08:28:07'),
(27893, 2450, 'APRO', '', 2, '2019-01-09 08:28:07'),
(27894, 2450, 'APMD', '', 2, '2019-01-09 08:28:07'),
(27895, 2450, 'APXD', '', 2, '2019-01-09 08:28:07'),
(27896, 2450, 'APMY', '', 2, '2019-01-09 08:28:07'),
(27897, 2450, 'APXY', '', 2, '2019-01-09 08:28:07'),
(27898, 2450, 'APDD', '0', 2, '2019-01-09 08:28:07'),
(27899, 2450, 'APFR', '', 2, '2019-01-09 08:28:07'),
(27900, 2450, 'APMR', '', 2, '2019-01-09 08:28:07'),
(27901, 2450, 'APGR', '', 2, '2019-01-09 08:28:07'),
(27902, 2450, 'APTM', '', 2, '2019-01-09 08:28:07'),
(27903, 2450, 'APFH', '', 2, '2019-01-09 08:28:07'),
(27904, 2450, 'APFO', '', 2, '2019-01-09 08:28:07'),
(27905, 2450, 'APFN', '', 2, '2019-01-09 08:28:07'),
(27906, 2450, 'APFP', '', 2, '2019-01-09 08:28:07'),
(27907, 2450, 'APFS', '', 2, '2019-01-09 08:28:07'),
(27908, 2450, 'APLO', '', 2, '2019-01-09 08:28:07'),
(27909, 2450, 'APFX', '', 2, '2019-01-09 08:28:07'),
(27910, 2450, 'APFM', '', 2, '2019-01-09 08:28:07'),
(27911, 2450, 'APIS', '', 2, '2019-01-09 08:28:07'),
(27912, 2450, 'APTS', '', 2, '2019-01-09 08:28:07'),
(27913, 2450, 'APTN', '', 2, '2019-01-09 08:28:07'),
(27914, 2450, 'APTF', '', 2, '2019-01-09 08:28:07'),
(27915, 2450, 'APTD', '', 2, '2019-01-09 08:28:07'),
(27916, 2451, 'APIT', 'ITFD', 2, '2019-01-09 08:29:21'),
(27917, 2451, 'APGO', '', 2, '2019-01-09 08:29:21'),
(27918, 2451, 'APSL', '', 2, '2019-01-09 08:29:21'),
(27919, 2451, 'APCL', '', 2, '2019-01-09 08:29:21'),
(27920, 2451, 'APIH', '', 2, '2019-01-09 08:29:21'),
(27921, 2451, 'APAL', '', 2, '2019-01-09 08:29:22'),
(27922, 2451, 'APMA', '0', 2, '2019-01-09 08:29:22'),
(27923, 2451, 'APHT', '', 2, '2019-01-09 08:29:22'),
(27924, 2451, 'APAD', '0', 2, '2019-01-09 08:29:22'),
(27925, 2451, 'APHD', '', 2, '2019-01-09 08:29:22'),
(27926, 2451, 'APRO', '', 2, '2019-01-09 08:29:22'),
(27927, 2451, 'APMD', '', 2, '2019-01-09 08:29:22'),
(27928, 2451, 'APXD', '', 2, '2019-01-09 08:29:22'),
(27929, 2451, 'APMY', '', 2, '2019-01-09 08:29:22'),
(27930, 2451, 'APXY', '', 2, '2019-01-09 08:29:22'),
(27931, 2451, 'APDD', '0', 2, '2019-01-09 08:29:22'),
(27932, 2451, 'APFR', '', 2, '2019-01-09 08:29:22'),
(27933, 2451, 'APMR', '', 2, '2019-01-09 08:29:22'),
(27934, 2451, 'APGR', '', 2, '2019-01-09 08:29:22'),
(27935, 2451, 'APTM', '', 2, '2019-01-09 08:29:22'),
(27936, 2451, 'APFH', '', 2, '2019-01-09 08:29:22'),
(27937, 2451, 'APFO', '', 2, '2019-01-09 08:29:22'),
(27938, 2451, 'APFN', '', 2, '2019-01-09 08:29:22'),
(27939, 2451, 'APFP', '', 2, '2019-01-09 08:29:22'),
(27940, 2451, 'APFS', '', 2, '2019-01-09 08:29:22'),
(27941, 2451, 'APLO', '', 2, '2019-01-09 08:29:22'),
(27942, 2451, 'APFX', '', 2, '2019-01-09 08:29:22'),
(27943, 2451, 'APFM', '', 2, '2019-01-09 08:29:22'),
(27944, 2451, 'APIS', '', 2, '2019-01-09 08:29:22'),
(27945, 2451, 'APTS', '', 2, '2019-01-09 08:29:22'),
(27946, 2451, 'APTN', '', 2, '2019-01-09 08:29:22'),
(27947, 2451, 'APTF', '', 2, '2019-01-09 08:29:22'),
(27948, 2451, 'APTD', '', 2, '2019-01-09 08:29:22'),
(28168, 2439, 'APIT', 'ITNM', 2, '2019-02-02 13:02:48'),
(28169, 2439, 'APCL', '', 2, '2019-02-02 13:02:48'),
(28170, 2439, 'APIH', '', 2, '2019-02-02 13:02:48'),
(28171, 2439, 'APAL', 'd5[.]', 2, '2019-02-02 13:02:48'),
(28172, 2439, 'APMA', '0', 2, '2019-02-02 13:02:48'),
(28173, 2439, 'APHT', '', 2, '2019-02-02 13:02:48'),
(28174, 2439, 'APHD', '', 2, '2019-02-02 13:02:48'),
(28175, 2439, 'APRO', '', 2, '2019-02-02 13:02:48'),
(28176, 2439, 'APMD', '', 2, '2019-02-02 13:02:49'),
(28177, 2439, 'APXD', '', 2, '2019-02-02 13:02:49'),
(28178, 2439, 'APMY', '', 2, '2019-02-02 13:02:49'),
(28179, 2439, 'APXY', '', 2, '2019-02-02 13:02:49'),
(28180, 2439, 'APDD', '0', 2, '2019-02-02 13:02:49'),
(28181, 2439, 'APAD', '0', 2, '2019-02-02 13:02:49'),
(28182, 2439, 'APFR', '', 2, '2019-02-02 13:02:49'),
(28183, 2439, 'APMR', '', 2, '2019-02-02 13:02:50'),
(28184, 2439, 'APGR', '', 2, '2019-02-02 13:02:50'),
(28185, 2439, 'APTM', '', 2, '2019-02-02 13:02:50'),
(28186, 2439, 'APFH', '', 2, '2019-02-02 13:02:50'),
(28187, 2439, 'APFO', '', 2, '2019-02-02 13:02:50'),
(28188, 2439, 'APFN', '', 2, '2019-02-02 13:02:50'),
(28189, 2439, 'APFP', '', 2, '2019-02-02 13:02:50'),
(28190, 2439, 'APFS', '', 2, '2019-02-02 13:02:50'),
(28191, 2439, 'APLO', '', 2, '2019-02-02 13:02:50'),
(28192, 2439, 'APFX', '', 2, '2019-02-02 13:02:51'),
(28193, 2439, 'APFM', '', 2, '2019-02-02 13:02:51'),
(28194, 2439, 'APIS', '', 2, '2019-02-02 13:02:51'),
(28195, 2439, 'APTS', '', 2, '2019-02-02 13:02:51'),
(28196, 2439, 'APTN', '', 2, '2019-02-02 13:02:51'),
(28197, 2439, 'APTF', '', 2, '2019-02-02 13:02:51'),
(28198, 2439, 'APTD', '', 2, '2019-02-02 13:02:51'),
(28199, 2436, 'APIT', 'ITTX', 2, '2019-02-02 13:03:16'),
(28200, 2436, 'APCL', '', 2, '2019-02-02 13:03:16'),
(28201, 2436, 'APIH', '', 2, '2019-02-02 13:03:16'),
(28202, 2436, 'APAL', '', 2, '2019-02-02 13:03:16'),
(28203, 2436, 'APMA', '0', 2, '2019-02-02 13:03:16'),
(28204, 2436, 'APHT', '', 2, '2019-02-02 13:03:16'),
(28205, 2436, 'APHD', '', 2, '2019-02-02 13:03:16'),
(28206, 2436, 'APRO', '', 2, '2019-02-02 13:03:17'),
(28207, 2436, 'APMD', '', 2, '2019-02-02 13:03:17'),
(28208, 2436, 'APXD', '', 2, '2019-02-02 13:03:17'),
(28209, 2436, 'APMY', '', 2, '2019-02-02 13:03:17'),
(28210, 2436, 'APXY', '', 2, '2019-02-02 13:03:17'),
(28211, 2436, 'APDD', '0', 2, '2019-02-02 13:03:17'),
(28212, 2436, 'APAD', '0', 2, '2019-02-02 13:03:17'),
(28213, 2436, 'APFR', '', 2, '2019-02-02 13:03:17'),
(28214, 2436, 'APMR', '', 2, '2019-02-02 13:03:17'),
(28215, 2436, 'APGR', '', 2, '2019-02-02 13:03:17'),
(28216, 2436, 'APTM', '', 2, '2019-02-02 13:03:17'),
(28217, 2436, 'APFH', '', 2, '2019-02-02 13:03:17'),
(28218, 2436, 'APFO', '', 2, '2019-02-02 13:03:17'),
(28219, 2436, 'APFN', '', 2, '2019-02-02 13:03:18'),
(28220, 2436, 'APFP', '', 2, '2019-02-02 13:03:18'),
(28221, 2436, 'APFS', '', 2, '2019-02-02 13:03:18'),
(28222, 2436, 'APLO', '', 2, '2019-02-02 13:03:18'),
(28223, 2436, 'APFX', '', 2, '2019-02-02 13:03:18'),
(28224, 2436, 'APFM', '', 2, '2019-02-02 13:03:18'),
(28225, 2436, 'APIS', '', 2, '2019-02-02 13:03:18'),
(28226, 2436, 'APTS', '', 2, '2019-02-02 13:03:18'),
(28227, 2436, 'APTN', '', 2, '2019-02-02 13:03:18'),
(28228, 2436, 'APTF', '', 2, '2019-02-02 13:03:18'),
(28229, 2436, 'APTD', '', 2, '2019-02-02 13:03:18'),
(28230, 2437, 'APIT', 'ITTA', 2, '2019-02-02 13:04:28'),
(28231, 2437, 'APGO', '', 2, '2019-02-02 13:04:28'),
(28232, 2437, 'APSL', '', 2, '2019-02-02 13:04:28'),
(28233, 2437, 'APCL', '', 2, '2019-02-02 13:04:28'),
(28234, 2437, 'APIH', '', 2, '2019-02-02 13:04:28'),
(28235, 2437, 'APAL', '', 2, '2019-02-02 13:04:28'),
(28236, 2437, 'APMA', '0', 2, '2019-02-02 13:04:28'),
(28237, 2437, 'APHT', '', 2, '2019-02-02 13:04:28'),
(28238, 2437, 'APHD', '', 2, '2019-02-02 13:04:28'),
(28239, 2437, 'APRO', '', 2, '2019-02-02 13:04:28'),
(28240, 2437, 'APMD', '', 2, '2019-02-02 13:04:28'),
(28241, 2437, 'APXD', '', 2, '2019-02-02 13:04:29'),
(28242, 2437, 'APMY', '', 2, '2019-02-02 13:04:29'),
(28243, 2437, 'APXY', '', 2, '2019-02-02 13:04:29'),
(28244, 2437, 'APDD', '0', 2, '2019-02-02 13:04:29'),
(28245, 2437, 'APAD', '0', 2, '2019-02-02 13:04:29'),
(28246, 2437, 'APFR', '', 2, '2019-02-02 13:04:29'),
(28247, 2437, 'APMR', '', 2, '2019-02-02 13:04:30'),
(28248, 2437, 'APGR', '', 2, '2019-02-02 13:04:30'),
(28249, 2437, 'APTM', '', 2, '2019-02-02 13:04:30'),
(28250, 2437, 'APFH', '', 2, '2019-02-02 13:04:30'),
(28251, 2437, 'APFO', '', 2, '2019-02-02 13:04:30'),
(28252, 2437, 'APFN', '', 2, '2019-02-02 13:04:30'),
(28253, 2437, 'APFP', '', 2, '2019-02-02 13:04:30'),
(28254, 2437, 'APFS', '', 2, '2019-02-02 13:04:30'),
(28255, 2437, 'APLO', '', 2, '2019-02-02 13:04:30'),
(28256, 2437, 'APFX', '', 2, '2019-02-02 13:04:30'),
(28257, 2437, 'APFM', '', 2, '2019-02-02 13:04:30'),
(28258, 2437, 'APIS', '', 2, '2019-02-02 13:04:31'),
(28259, 2437, 'APTS', '', 2, '2019-02-02 13:04:31'),
(28260, 2437, 'APTN', '', 2, '2019-02-02 13:04:31'),
(28261, 2437, 'APTF', '', 2, '2019-02-02 13:04:31'),
(28262, 2437, 'APTD', '', 2, '2019-02-02 13:04:31'),
(28263, 2438, 'APIT', 'ITTE', 2, '2019-02-02 13:05:03'),
(28264, 2438, 'APGO', '', 2, '2019-02-02 13:05:03'),
(28265, 2438, 'APSL', '', 2, '2019-02-02 13:05:03'),
(28266, 2438, 'APCL', '', 2, '2019-02-02 13:05:03'),
(28267, 2438, 'APIH', '', 2, '2019-02-02 13:05:03'),
(28268, 2438, 'APAL', '', 2, '2019-02-02 13:05:03'),
(28269, 2438, 'APMA', '0', 2, '2019-02-02 13:05:03'),
(28270, 2438, 'APHT', '', 2, '2019-02-02 13:05:03'),
(28271, 2438, 'APHD', '', 2, '2019-02-02 13:05:03'),
(28272, 2438, 'APRO', '', 2, '2019-02-02 13:05:03'),
(28273, 2438, 'APMD', '', 2, '2019-02-02 13:05:03'),
(28274, 2438, 'APXD', '', 2, '2019-02-02 13:05:03'),
(28275, 2438, 'APMY', '', 2, '2019-02-02 13:05:03'),
(28276, 2438, 'APXY', '', 2, '2019-02-02 13:05:03'),
(28277, 2438, 'APDD', '0', 2, '2019-02-02 13:05:04'),
(28278, 2438, 'APAD', '0', 2, '2019-02-02 13:05:04'),
(28279, 2438, 'APFR', '', 2, '2019-02-02 13:05:04'),
(28280, 2438, 'APMR', '', 2, '2019-02-02 13:05:04'),
(28281, 2438, 'APGR', '', 2, '2019-02-02 13:05:04'),
(28282, 2438, 'APTM', '', 2, '2019-02-02 13:05:04'),
(28283, 2438, 'APFH', '', 2, '2019-02-02 13:05:04'),
(28284, 2438, 'APFO', '', 2, '2019-02-02 13:05:04'),
(28285, 2438, 'APFN', '', 2, '2019-02-02 13:05:04'),
(28286, 2438, 'APFP', '', 2, '2019-02-02 13:05:04'),
(28287, 2438, 'APFS', '', 2, '2019-02-02 13:05:05'),
(28288, 2438, 'APLO', '', 2, '2019-02-02 13:05:05'),
(28289, 2438, 'APFX', '', 2, '2019-02-02 13:05:05'),
(28290, 2438, 'APFM', '', 2, '2019-02-02 13:05:05'),
(28291, 2438, 'APIS', '', 2, '2019-02-02 13:05:05'),
(28292, 2438, 'APTS', '', 2, '2019-02-02 13:05:05'),
(28293, 2438, 'APTN', '', 2, '2019-02-02 13:05:05'),
(28294, 2438, 'APTF', '', 2, '2019-02-02 13:05:05'),
(28295, 2438, 'APTD', '', 2, '2019-02-02 13:05:05'),
(28505, 2441, 'APIT', 'ITHD', 2, '2019-09-19 14:06:21'),
(28506, 2441, 'APCL', '', 2, '2019-09-19 14:06:21'),
(28507, 2441, 'APIH', '', 2, '2019-09-19 14:06:21'),
(28508, 2441, 'APMA', '0', 2, '2019-09-19 14:06:21'),
(28509, 2441, 'APHT', '', 2, '2019-09-19 14:06:21'),
(28510, 2441, 'APHD', '', 2, '2019-09-19 14:06:21'),
(28511, 4149, 'APIT', 'ITFT', 2, '2019-09-21 12:10:43'),
(28512, 4149, 'APCL', '', 2, '2019-09-21 12:10:43'),
(28513, 4149, 'APIH', '', 2, '2019-09-21 12:10:43'),
(28514, 4149, 'APMA', '0', 2, '2019-09-21 12:10:43'),
(28515, 4149, 'APHT', '', 2, '2019-09-21 12:10:43'),
(28516, 4149, 'APHD', '', 2, '2019-09-21 12:10:43'),
(28517, 4149, 'APRO', '', 2, '2019-09-21 12:10:43'),
(28518, 4149, 'APFR', '2', 2, '2019-09-21 12:10:43'),
(28519, 4149, 'APMR', '2', 2, '2019-09-21 12:10:43'),
(28520, 4149, 'APGR', '2', 2, '2019-09-21 12:10:43'),
(28521, 4149, 'APTM', '', 2, '2019-09-21 12:10:43'),
(28522, 4149, 'APFH', '', 2, '2019-09-21 12:10:43'),
(28523, 4149, 'APFO', '[[\"A\",\"100\",\"Text\",\"Entity_Child\",\"token\",\"token\",\"AX->A Series Token FT\",\"TEXT->Text Test\",\"a_100\",\"no\",\"\",\"\"],[\"\",\"\",\"Text\",\"Entity_Child\",\"token\",\"token\",\"AX->A Series Token FT\",\"TEXT->Text Test\",\"\",\"no\",\"\",\"\"],[\"\",\"\",\"Text\",\"Entity_Child\",\"token\",\"token\",\"AX->A Series Token FT\",\"TEXT->Text Test\",\"\",\"no\",\"\",\"\"],[\"\",\"\",\"Text\",\"Entity_Child\",\"token\",\"token\",\"AX->A Series Token FT\",\"TEXT->Text Test\",\"\",\"no\",\"\",\"\"],[\"\",\"\",\"Text\",\"Entity_Child\",\"token\",\"token\",\"AX->A Series Token FT\",\"TEXT->Text Test\",\"\",\"no\",\"\",\"\"],[\"\",\"\",\"Text\",\"Entity_Child\",\"token\",\"token\",\"AX->A Series Token FT\",\"TEXT->Text Test\",\"\",\"no\",\"\",\"\"]]', 2, '2019-09-21 12:10:43'),
(28542, 4150, 'ATKH', '8ce960977f90910604290c380259d99a', 2, '2019-09-23 10:23:05'),
(28543, 4298, 'APIT', 'ITTX', 2, '2019-09-23 11:46:58'),
(28544, 4298, 'APCL', '', 2, '2019-09-23 11:46:58'),
(28545, 4298, 'APIH', '', 2, '2019-09-23 11:46:58'),
(28546, 4298, 'APMA', '0', 2, '2019-09-23 11:46:58'),
(28547, 4298, 'APHT', '', 2, '2019-09-23 11:46:58'),
(28548, 4298, 'APHD', '', 2, '2019-09-23 11:46:58'),
(28549, 4298, 'APRO', '', 2, '2019-09-23 11:46:58'),
(28556, 1139, 'GPEN', 'SL', NULL, '2019-10-11 08:06:19'),
(28577, 1210, 'GPEN', 'HA', NULL, '2020-02-27 07:52:02'),
(28578, 1210, 'GPEN', 'AC', NULL, '2020-02-27 07:52:02'),
(28579, 1210, 'GPEN', 'HB', NULL, '2020-02-27 07:52:02'),
(28580, 1210, 'GPEN', 'PG', NULL, '2020-02-27 07:52:02'),
(28935, 5720, 'DFTY', 'YOU', 2, '2020-05-09 08:40:19'),
(28936, 5721, 'DFTY', 'YOU', 2, '2020-05-09 08:40:20'),
(28937, 5722, 'DFTY', 'YOU', 2, '2020-05-09 08:40:20'),
(28938, 5723, 'DFTY', 'YOU', 2, '2020-05-09 08:40:21'),
(28939, 5724, 'DFTY', 'YOU', 2, '2020-05-09 08:40:21'),
(28940, 5725, 'DFTY', 'INT', 2, '2020-05-09 08:40:22'),
(28941, 5726, 'DFTY', 'INT', 2, '2020-05-09 08:40:22'),
(28942, 5727, 'DFTY', 'INT', 2, '2020-05-09 08:40:22'),
(28943, 5728, 'DFTY', 'INT', 2, '2020-05-09 08:40:23'),
(28944, 5729, 'DFTY', 'INT', 2, '2020-05-09 08:40:23'),
(28946, 5731, 'DFTY', 'INT', 2, '2020-05-09 08:40:24'),
(28947, 5732, 'DFTY', 'INT', 2, '2020-05-09 08:40:24'),
(28948, 5733, 'DFTY', 'INT', 2, '2020-05-09 08:40:24'),
(28949, 5734, 'DFTY', 'INT', 2, '2020-05-09 08:40:24'),
(28950, 5735, 'DFTY', 'INT', 2, '2020-05-09 08:40:25'),
(28951, 5736, 'DFTY', 'INT', 2, '2020-05-09 08:40:26'),
(28952, 5737, 'DFTY', 'INT', 2, '2020-05-09 08:40:26'),
(28953, 5738, 'DFTY', 'INT', 2, '2020-05-09 08:40:26'),
(28954, 5739, 'DFTY', 'INT', 2, '2020-05-09 08:40:27'),
(28955, 5740, 'DFTY', 'INT', 2, '2020-05-09 08:40:27'),
(28956, 5741, 'DFTY', 'INT', 2, '2020-05-09 08:40:27'),
(28957, 5742, 'DFTY', 'INT', 2, '2020-05-09 08:40:28'),
(28958, 5743, 'DFTY', 'INT', 2, '2020-05-09 08:40:28'),
(28959, 5744, 'DFTY', 'INT', 2, '2020-05-09 08:40:28'),
(28961, 5746, 'DFTY', 'INT', 2, '2020-05-09 08:40:29'),
(28963, 5748, 'DFTY', 'INT', 2, '2020-05-09 08:40:29'),
(28964, 5749, 'DFTY', 'INT', 2, '2020-05-09 08:40:30'),
(28965, 5750, 'DFTY', 'INT', 2, '2020-05-09 08:40:30'),
(28966, 5751, 'DFTY', 'INT', 2, '2020-05-09 08:40:31'),
(28967, 5752, 'DFTY', 'INT', 2, '2020-05-09 08:40:31'),
(28968, 5753, 'DFTY', 'INT', 2, '2020-05-09 08:40:31'),
(28969, 5754, 'DFTY', 'INT', 2, '2020-05-09 08:40:31'),
(28970, 5755, 'DFTY', 'INT', 2, '2020-05-09 08:40:32'),
(28971, 5756, 'DFTY', 'INT', 2, '2020-05-09 08:40:32'),
(28972, 5757, 'DFTY', 'INT', 2, '2020-05-09 08:40:33'),
(28973, 5758, 'DFTY', 'INT', 2, '2020-05-09 08:40:34'),
(28974, 5759, 'DFTY', 'INT', 2, '2020-05-09 08:40:34'),
(28975, 5760, 'DFTY', 'INT', 2, '2020-05-09 08:40:34'),
(28976, 5761, 'DFTY', 'INT', 2, '2020-05-09 08:40:35'),
(28977, 5762, 'DFTY', 'INT', 2, '2020-05-09 08:40:35'),
(28978, 5763, 'DFTY', 'INT', 2, '2020-05-09 08:40:36'),
(28979, 5764, 'DFTY', 'INT', 2, '2020-05-09 08:40:36'),
(28980, 5765, 'DFTY', 'INT', 2, '2020-05-09 08:40:37'),
(28981, 5766, 'DFTY', 'INT', 2, '2020-05-09 08:40:37'),
(28982, 5767, 'DFTY', 'INT', 2, '2020-05-09 08:40:37'),
(28983, 5768, 'DFTY', 'INT', 2, '2020-05-09 08:40:37'),
(28984, 5769, 'DFTY', 'INT', 2, '2020-05-09 08:40:38'),
(28985, 5770, 'DFTY', 'INT', 2, '2020-05-09 08:40:38'),
(28986, 5771, 'DFTY', 'INT', 2, '2020-05-09 08:40:38'),
(28987, 5772, 'DFTY', 'INT', 2, '2020-05-09 08:40:38'),
(28988, 5773, 'DFTY', 'INT', 2, '2020-05-09 08:40:39'),
(28989, 5774, 'DFTY', 'INT', 2, '2020-05-09 08:40:39'),
(28990, 5775, 'DFTY', 'INT', 2, '2020-05-09 08:40:39'),
(28991, 5776, 'DFTY', 'INT', 2, '2020-05-09 08:40:39'),
(28992, 5777, 'DFTY', 'INT', 2, '2020-05-09 08:40:40'),
(28993, 5778, 'DFTY', 'INT', 2, '2020-05-09 08:40:41'),
(28994, 5779, 'DFTY', 'INT', 2, '2020-05-09 08:40:41'),
(28995, 5780, 'DFTY', 'INT', 2, '2020-05-09 08:40:42'),
(28996, 5781, 'DFTY', 'INT', 2, '2020-05-09 08:40:42'),
(28997, 5782, 'DFTY', 'INT', 2, '2020-05-09 08:40:43'),
(29015, 5730, 'DFTY', 'INT', 2, '2020-05-10 00:10:12'),
(29016, 5800, 'DFTY', 'INT', 2, '2020-05-10 00:11:13'),
(29025, 5806, 'DFTY', 'INT', 2, '2020-05-11 11:05:20'),
(29146, 5836, 'DFTY', 'INT', 2, '2020-05-22 14:13:29'),
(29177, 2290, 'ATKH', 'ac72a33191badcf83b847b16d530a5d8', 2, '2020-06-15 12:57:56'),
(29192, 5845, 'APIT', 'ITTX', 2, '2020-10-19 06:25:30'),
(29193, 5845, 'APCL', 'w_300', 2, '2020-10-19 06:25:30'),
(29194, 5846, 'APIT', 'ITTG', 2, '2020-10-19 06:25:30'),
(29195, 5846, 'APTS', '1', 2, '2020-10-19 06:25:30'),
(29196, 5846, 'APTN', 'Yes', 2, '2020-10-19 06:25:30'),
(29197, 5846, 'APTF', 'Off', 2, '2020-10-19 06:25:30'),
(29198, 5846, 'APTD', '1', 2, '2020-10-19 06:25:30'),
(29199, 5745, 'DFTY', 'INT', 2, '2020-10-23 00:13:57'),
(29200, 5847, 'DFTY', 'YOU', 2, '2020-10-24 16:43:01'),
(29202, 5844, 'APAD', '', 2, '2021-02-17 11:15:53'),
(29236, 5844, 'APIT', 'ITTX', 2, '2021-05-19 17:14:29'),
(29237, 5844, 'APCL', 'w_200', 2, '2021-05-19 17:14:29'),
(29238, 5844, 'APIH', '', 2, '2021-05-19 17:14:29'),
(29239, 5844, 'APAL', '', 2, '2021-05-19 17:14:29'),
(29240, 5844, 'APMA', '1', 2, '2021-05-19 17:14:29'),
(29241, 5844, 'APHT', '', 2, '2021-05-19 17:14:30'),
(29242, 5844, 'APHD', '', 2, '2021-05-19 17:14:30'),
(29243, 5844, 'APRO', '', 2, '2021-05-19 17:14:30'),
(29244, 5844, 'APEZ', '', 2, '2021-05-19 17:14:30'),
(29245, 5844, 'ADXI', '1', 2, '2021-05-19 17:14:30'),
(29246, 5844, 'ADXN', 'Text Base', 2, '2021-05-19 17:14:30'),
(29247, 5844, 'ADXH', '', 2, '2021-05-19 17:14:30'),
(29248, 5844, 'ADXC', '', 2, '2021-05-19 17:14:30'),
(29249, 5844, 'ADXF', '', 2, '2021-05-19 17:14:30'),
(29250, 5844, 'ADXJ', '', 2, '2021-05-19 17:14:30'),
(29251, 5844, 'ADXQ', '', 2, '2021-05-19 17:14:30'),
(29252, 5844, 'ADXS', '', 2, '2021-05-19 17:14:31'),
(29253, 5844, 'ADLO', '', 2, '2021-05-19 17:14:31'),
(29254, 5848, 'APIT', 'ITSL', 2, '2021-05-19 17:15:03'),
(29255, 5848, 'APSL', '[[\"Entity_Child_Base\",\"IU->Issue status\",\"token\",\"sn\",\"\"]]', 2, '2021-05-19 17:15:03'),
(29256, 5848, 'APAD', '', 2, '2021-05-19 17:15:03'),
(29257, 5848, 'APCL', '', 2, '2021-05-19 17:15:03'),
(29258, 5848, 'APIH', '', 2, '2021-05-19 17:15:03'),
(29259, 5848, 'APMA', '', 2, '2021-05-19 17:15:03'),
(29260, 5848, 'APHT', '', 2, '2021-05-19 17:15:03'),
(29261, 5848, 'APHD', '', 2, '2021-05-19 17:15:03'),
(29262, 5848, 'APRO', '', 2, '2021-05-19 17:15:03'),
(29263, 5848, 'APEZ', '', 2, '2021-05-19 17:15:04'),
(29264, 5848, 'ADXI', '1', 2, '2021-05-19 17:15:04'),
(29265, 5848, 'ADXN', 'Select Base', 2, '2021-05-19 17:15:04'),
(29266, 5848, 'ADXH', '', 2, '2021-05-19 17:15:04'),
(29267, 5848, 'ADXC', '', 2, '2021-05-19 17:15:04'),
(29268, 5848, 'ADXF', '', 2, '2021-05-19 17:15:04'),
(29269, 5848, 'ADXJ', '', 2, '2021-05-19 17:15:04'),
(29270, 5848, 'ADXQ', 'get_ecb_sn_by_token', 2, '2021-05-19 17:15:04'),
(29271, 5848, 'ADXS', '', 2, '2021-05-19 17:15:05'),
(29272, 5848, 'ADLO', '4', 2, '2021-05-19 17:15:05'),
(29273, 5852, 'APIT', 'ITTX', 2, '2021-05-19 17:36:33'),
(29274, 5852, 'APCL', '', 2, '2021-05-19 17:36:33'),
(29275, 5852, 'APIH', '', 2, '2021-05-19 17:36:33'),
(29276, 5852, 'APAL', 'x50', 2, '2021-05-19 17:36:33'),
(29277, 5852, 'APMA', '1', 2, '2021-05-19 17:36:33'),
(29278, 5852, 'APHT', '', 2, '2021-05-19 17:36:33'),
(29279, 5852, 'APHD', '', 2, '2021-05-19 17:36:33'),
(29280, 5852, 'APRO', '', 2, '2021-05-19 17:36:33'),
(29281, 5852, 'APEZ', '', 2, '2021-05-19 17:36:33'),
(29282, 5852, 'ADXI', '1', 2, '2021-05-19 17:36:33'),
(29283, 5852, 'ADXN', 'Patient Name', 2, '2021-05-19 17:36:33'),
(29284, 5852, 'ADXH', '', 2, '2021-05-19 17:36:33'),
(29285, 5852, 'ADXC', '', 2, '2021-05-19 17:36:33'),
(29286, 5852, 'ADXF', '', 2, '2021-05-19 17:36:33'),
(29287, 5852, 'ADXJ', '', 2, '2021-05-19 17:36:33'),
(29288, 5852, 'ADXQ', '', 2, '2021-05-19 17:36:33'),
(29289, 5852, 'ADXS', '1', 2, '2021-05-19 17:36:34'),
(29290, 5852, 'ADLO', '1', 2, '2021-05-19 17:36:34'),
(29397, 5857, 'APIT', 'ITSL', 2, '2021-05-19 17:45:05'),
(29398, 5857, 'APSL', '[[\"Entity_Child_Base\",\"GN->Gender\",\"token\",\"sn\",\"\"]]', 2, '2021-05-19 17:45:05'),
(29399, 5857, 'APAD', '', 2, '2021-05-19 17:45:05'),
(29400, 5857, 'APCL', '', 2, '2021-05-19 17:45:05'),
(29401, 5857, 'APIH', '', 2, '2021-05-19 17:45:05'),
(29402, 5857, 'APMA', '1', 2, '2021-05-19 17:45:05'),
(29403, 5857, 'APHT', '', 2, '2021-05-19 17:45:05'),
(29404, 5857, 'APHD', '', 2, '2021-05-19 17:45:05'),
(29405, 5857, 'APRO', '', 2, '2021-05-19 17:45:06'),
(29406, 5857, 'APEZ', '', 2, '2021-05-19 17:45:06'),
(29407, 5857, 'ADXI', '', 2, '2021-05-19 17:45:06'),
(29408, 5857, 'ADXN', 'Gender', 2, '2021-05-19 17:45:06'),
(29409, 5857, 'ADXH', '', 2, '2021-05-19 17:45:06'),
(29410, 5857, 'ADXC', '', 2, '2021-05-19 17:45:07'),
(29411, 5857, 'ADXF', '', 2, '2021-05-19 17:45:07'),
(29412, 5857, 'ADXJ', '', 2, '2021-05-19 17:45:07'),
(29413, 5857, 'ADXQ', '', 2, '2021-05-19 17:45:07'),
(29414, 5857, 'ADXS', '', 2, '2021-05-19 17:45:07'),
(29415, 5857, 'ADLO', '6', 2, '2021-05-19 17:45:07'),
(29416, 5858, 'APIT', 'ITTX', 2, '2021-05-19 17:46:53'),
(29417, 5858, 'APCL', '', 2, '2021-05-19 17:46:53'),
(29418, 5858, 'APIH', '', 2, '2021-05-19 17:46:53'),
(29419, 5858, 'APAL', 'd10', 2, '2021-05-19 17:46:53'),
(29420, 5858, 'APMA', '', 2, '2021-05-19 17:46:53'),
(29421, 5858, 'APHT', '', 2, '2021-05-19 17:46:53'),
(29422, 5858, 'APHD', '', 2, '2021-05-19 17:46:53'),
(29423, 5858, 'APRO', '', 2, '2021-05-19 17:46:54'),
(29424, 5858, 'APEZ', '', 2, '2021-05-19 17:46:54'),
(29425, 5858, 'ADXI', '', 2, '2021-05-19 17:46:54'),
(29426, 5858, 'ADXN', 'Alternative Mobile No.', 2, '2021-05-19 17:46:54'),
(29427, 5858, 'ADXH', '', 2, '2021-05-19 17:46:54'),
(29428, 5858, 'ADXC', '', 2, '2021-05-19 17:46:54'),
(29429, 5858, 'ADXF', '', 2, '2021-05-19 17:46:54'),
(29430, 5858, 'ADXJ', '', 2, '2021-05-19 17:46:54'),
(29431, 5858, 'ADXQ', '', 2, '2021-05-19 17:46:54'),
(29432, 5858, 'ADXS', '', 2, '2021-05-19 17:46:54'),
(29433, 5858, 'ADLO', '7', 2, '2021-05-19 17:46:54'),
(29452, 5860, 'APIT', 'ITTX', 2, '2021-05-19 17:49:20'),
(29453, 5860, 'APCL', '', 2, '2021-05-19 17:49:20'),
(29454, 5860, 'APIH', '', 2, '2021-05-19 17:49:20'),
(29455, 5860, 'APAL', 'd10', 2, '2021-05-19 17:49:20'),
(29456, 5860, 'APMA', '1', 2, '2021-05-19 17:49:20'),
(29457, 5860, 'APHT', '', 2, '2021-05-19 17:49:20'),
(29458, 5860, 'APHD', '', 2, '2021-05-19 17:49:20'),
(29459, 5860, 'APRO', '', 2, '2021-05-19 17:49:20'),
(29460, 5860, 'APEZ', '', 2, '2021-05-19 17:49:20'),
(29461, 5860, 'ADXI', '', 2, '2021-05-19 17:49:20'),
(29462, 5860, 'ADXN', 'Attendant Contact No..', 2, '2021-05-19 17:49:20'),
(29463, 5860, 'ADXH', '', 2, '2021-05-19 17:49:20'),
(29464, 5860, 'ADXC', '', 2, '2021-05-19 17:49:20'),
(29465, 5860, 'ADXF', '', 2, '2021-05-19 17:49:20'),
(29466, 5860, 'ADXJ', '', 2, '2021-05-19 17:49:20'),
(29467, 5860, 'ADXQ', '', 2, '2021-05-19 17:49:20'),
(29468, 5860, 'ADXS', '', 2, '2021-05-19 17:49:20'),
(29469, 5860, 'ADLO', '9', 2, '2021-05-19 17:49:20'),
(29470, 5859, 'APIT', 'ITTX', 2, '2021-05-19 17:50:46'),
(29471, 5859, 'APCL', '', 2, '2021-05-19 17:50:46'),
(29472, 5859, 'APIH', '', 2, '2021-05-19 17:50:46'),
(29473, 5859, 'APAL', 'x50', 2, '2021-05-19 17:50:46'),
(29474, 5859, 'APMA', '1', 2, '2021-05-19 17:50:46'),
(29475, 5859, 'APHT', '', 2, '2021-05-19 17:50:47'),
(29476, 5859, 'APHD', '', 2, '2021-05-19 17:50:47'),
(29477, 5859, 'APRO', '', 2, '2021-05-19 17:50:47'),
(29478, 5859, 'APEZ', '', 2, '2021-05-19 17:50:47'),
(29479, 5859, 'ADXI', '', 2, '2021-05-19 17:50:47'),
(29480, 5859, 'ADXN', 'Attendant Name', 2, '2021-05-19 17:50:47'),
(29481, 5859, 'ADXH', '', 2, '2021-05-19 17:50:47'),
(29482, 5859, 'ADXC', '', 2, '2021-05-19 17:50:47'),
(29483, 5859, 'ADXF', '', 2, '2021-05-19 17:50:47'),
(29484, 5859, 'ADXJ', '', 2, '2021-05-19 17:50:48'),
(29485, 5859, 'ADXQ', '', 2, '2021-05-19 17:50:48'),
(29486, 5859, 'ADXS', '', 2, '2021-05-19 17:50:48'),
(29487, 5859, 'ADLO', '8', 2, '2021-05-19 17:50:48'),
(29506, 5854, 'APIT', 'ITTX', 2, '2021-05-19 17:52:25'),
(29507, 5854, 'APCL', 'w_50', 2, '2021-05-19 17:52:25'),
(29508, 5854, 'APIH', '', 2, '2021-05-19 17:52:25'),
(29509, 5854, 'APAL', 'd6', 2, '2021-05-19 17:52:25'),
(29510, 5854, 'APMA', '1', 2, '2021-05-19 17:52:25'),
(29511, 5854, 'APHT', '', 2, '2021-05-19 17:52:25'),
(29512, 5854, 'APHD', '', 2, '2021-05-19 17:52:25'),
(29513, 5854, 'APRO', '', 2, '2021-05-19 17:52:25'),
(29514, 5854, 'APEZ', '', 2, '2021-05-19 17:52:25'),
(29515, 5854, 'ADXI', '', 2, '2021-05-19 17:52:25'),
(29516, 5854, 'ADXN', 'Patient Address PIN', 2, '2021-05-19 17:52:25'),
(29517, 5854, 'ADXH', '', 2, '2021-05-19 17:52:26'),
(29518, 5854, 'ADXC', '', 2, '2021-05-19 17:52:26'),
(29519, 5854, 'ADXF', '', 2, '2021-05-19 17:52:26'),
(29520, 5854, 'ADXJ', '', 2, '2021-05-19 17:52:26'),
(29521, 5854, 'ADXQ', '', 2, '2021-05-19 17:52:26'),
(29522, 5854, 'ADXS', '', 2, '2021-05-19 17:52:26'),
(29523, 5854, 'ADLO', '3', 2, '2021-05-19 17:52:26'),
(29524, 5855, 'APIT', 'ITTX', 2, '2021-05-19 17:52:57'),
(29525, 5855, 'APCL', 'w_50', 2, '2021-05-19 17:52:57'),
(29526, 5855, 'APIH', '', 2, '2021-05-19 17:52:57'),
(29527, 5855, 'APAL', 'v1-120', 2, '2021-05-19 17:52:57'),
(29528, 5855, 'APMA', '1', 2, '2021-05-19 17:52:57'),
(29529, 5855, 'APHT', '', 2, '2021-05-19 17:52:57'),
(29530, 5855, 'APHD', '', 2, '2021-05-19 17:52:57'),
(29531, 5855, 'APRO', '', 2, '2021-05-19 17:52:58'),
(29532, 5855, 'APEZ', '', 2, '2021-05-19 17:52:58'),
(29533, 5855, 'ADXI', '', 2, '2021-05-19 17:52:58'),
(29534, 5855, 'ADXN', 'Patient Age', 2, '2021-05-19 17:52:58'),
(29535, 5855, 'ADXH', '', 2, '2021-05-19 17:52:58'),
(29536, 5855, 'ADXC', '', 2, '2021-05-19 17:52:58'),
(29537, 5855, 'ADXF', '', 2, '2021-05-19 17:52:58'),
(29538, 5855, 'ADXJ', '', 2, '2021-05-19 17:52:58'),
(29539, 5855, 'ADXQ', '', 2, '2021-05-19 17:52:58'),
(29540, 5855, 'ADXS', '', 2, '2021-05-19 17:52:58'),
(29541, 5855, 'ADLO', '4', 2, '2021-05-19 17:52:59'),
(29542, 5856, 'APIT', 'ITTX', 2, '2021-05-19 17:53:17'),
(29543, 5856, 'APCL', '', 2, '2021-05-19 17:53:17'),
(29544, 5856, 'APIH', '', 2, '2021-05-19 17:53:17'),
(29545, 5856, 'APAL', 'd10', 2, '2021-05-19 17:53:17'),
(29546, 5856, 'APMA', '1', 2, '2021-05-19 17:53:17'),
(29547, 5856, 'APHT', '', 2, '2021-05-19 17:53:17'),
(29548, 5856, 'APHD', '', 2, '2021-05-19 17:53:17'),
(29549, 5856, 'APRO', '', 2, '2021-05-19 17:53:18'),
(29550, 5856, 'APEZ', '', 2, '2021-05-19 17:53:18'),
(29551, 5856, 'ADXI', '', 2, '2021-05-19 17:53:18'),
(29552, 5856, 'ADXN', 'Patient Contact No.', 2, '2021-05-19 17:53:18'),
(29553, 5856, 'ADXH', '', 2, '2021-05-19 17:53:18'),
(29554, 5856, 'ADXC', '', 2, '2021-05-19 17:53:18'),
(29555, 5856, 'ADXF', '', 2, '2021-05-19 17:53:18'),
(29556, 5856, 'ADXJ', '', 2, '2021-05-19 17:53:19'),
(29557, 5856, 'ADXQ', '', 2, '2021-05-19 17:53:19'),
(29558, 5856, 'ADXS', '', 2, '2021-05-19 17:53:19'),
(29559, 5856, 'ADLO', '5', 2, '2021-05-19 17:53:19'),
(29581, 5865, 'DFTY', 'YOU', 2, '2021-05-19 18:13:04'),
(29676, 5874, 'APIT', 'ITTX', 2, '2021-05-19 19:03:13'),
(29677, 5874, 'APCL', '', 2, '2021-05-19 19:03:13'),
(29678, 5874, 'APIH', '', 2, '2021-05-19 19:03:13'),
(29679, 5874, 'APAL', 'x50', 2, '2021-05-19 19:03:13'),
(29680, 5874, 'APMA', '1', 2, '2021-05-19 19:03:13'),
(29681, 5874, 'APHT', '', 2, '2021-05-19 19:03:13'),
(29682, 5874, 'APHD', '', 2, '2021-05-19 19:03:13'),
(29683, 5874, 'APRO', '', 2, '2021-05-19 19:03:13'),
(29684, 5874, 'APEZ', '', 2, '2021-05-19 19:03:13'),
(29685, 5874, 'ADXI', '', 2, '2021-05-19 19:03:13'),
(29686, 5874, 'ADXN', 'BU No.', 2, '2021-05-19 19:03:13'),
(29687, 5874, 'ADXH', '', 2, '2021-05-19 19:03:13'),
(29688, 5874, 'ADXC', '', 2, '2021-05-19 19:03:13'),
(29689, 5874, 'ADXF', '', 2, '2021-05-19 19:03:13'),
(29690, 5874, 'ADXJ', '', 2, '2021-05-19 19:03:13'),
(29691, 5874, 'ADXQ', '', 2, '2021-05-19 19:03:14'),
(29692, 5874, 'ADXS', '', 2, '2021-05-19 19:03:14'),
(29693, 5874, 'ADLO', '14', 2, '2021-05-19 19:03:14'),
(29694, 5875, 'APIT', 'ITTA', 2, '2021-05-19 19:04:20'),
(29695, 5875, 'APCL', '', 2, '2021-05-19 19:04:20'),
(29696, 5875, 'APIH', '', 2, '2021-05-19 19:04:20'),
(29697, 5875, 'APAL', 'x1000', 2, '2021-05-19 19:04:20'),
(29698, 5875, 'APMA', '', 2, '2021-05-19 19:04:21'),
(29699, 5875, 'APHT', '', 2, '2021-05-19 19:04:21'),
(29700, 5875, 'APHD', '', 2, '2021-05-19 19:04:21'),
(29701, 5875, 'APRO', '', 2, '2021-05-19 19:04:21'),
(29702, 5875, 'APEZ', '', 2, '2021-05-19 19:04:21'),
(29703, 5875, 'ADXI', '', 2, '2021-05-19 19:04:21'),
(29704, 5875, 'ADXN', 'Patient Medical Condition', 2, '2021-05-19 19:04:21'),
(29705, 5875, 'ADXH', '', 2, '2021-05-19 19:04:21'),
(29706, 5875, 'ADXC', '', 2, '2021-05-19 19:04:21'),
(29707, 5875, 'ADXF', '', 2, '2021-05-19 19:04:21'),
(29708, 5875, 'ADXJ', '', 2, '2021-05-19 19:04:21'),
(29709, 5875, 'ADXQ', '', 2, '2021-05-19 19:04:21'),
(29710, 5875, 'ADXS', '', 2, '2021-05-19 19:04:21'),
(29711, 5875, 'ADLO', '15', 2, '2021-05-19 19:04:21'),
(29784, 5872, 'APIT', 'ITSL', 2, '2021-05-19 19:13:15'),
(29785, 5872, 'APSL', '[[\"Entity_Child_Base\",\"TKTW->Testing Way\",\"token\",\"sn\",\"\"]]', 2, '2021-05-19 19:13:16'),
(29786, 5872, 'APAD', '', 2, '2021-05-19 19:13:16'),
(29787, 5872, 'APCL', '', 2, '2021-05-19 19:13:16'),
(29788, 5872, 'APIH', '', 2, '2021-05-19 19:13:17'),
(29789, 5872, 'APMA', '', 2, '2021-05-19 19:13:17'),
(29790, 5872, 'APHT', '', 2, '2021-05-19 19:13:17'),
(29791, 5872, 'APHD', '', 2, '2021-05-19 19:13:18'),
(29792, 5872, 'APRO', '', 2, '2021-05-19 19:13:18'),
(29793, 5872, 'APEZ', '', 2, '2021-05-19 19:13:18'),
(29794, 5872, 'ADXI', '', 2, '2021-05-19 19:13:19'),
(29795, 5872, 'ADXN', 'Medical ', 2, '2021-05-19 19:13:20'),
(29796, 5872, 'ADXH', '', 2, '2021-05-19 19:13:20'),
(29797, 5872, 'ADXC', '', 2, '2021-05-19 19:13:21'),
(29798, 5872, 'ADXF', '', 2, '2021-05-19 19:13:21'),
(29799, 5872, 'ADXJ', '', 2, '2021-05-19 19:13:22'),
(29800, 5872, 'ADXQ', '', 2, '2021-05-19 19:13:26'),
(29801, 5872, 'ADXS', '', 2, '2021-05-19 19:13:27'),
(29802, 5872, 'ADLO', '12', 2, '2021-05-19 19:13:28'),
(29803, 5873, 'APIT', 'ITTX', 2, '2021-05-19 19:13:55'),
(29804, 5873, 'APCL', '', 2, '2021-05-19 19:13:55'),
(29805, 5873, 'APIH', '', 2, '2021-05-19 19:13:55'),
(29806, 5873, 'APAL', 'd32', 2, '2021-05-19 19:13:55'),
(29807, 5873, 'APMA', '1', 2, '2021-05-19 19:13:55'),
(29808, 5873, 'APHT', '', 2, '2021-05-19 19:13:55'),
(29809, 5873, 'APHD', '', 2, '2021-05-19 19:13:55'),
(29810, 5873, 'APRO', '', 2, '2021-05-19 19:13:56'),
(29811, 5873, 'APEZ', '', 2, '2021-05-19 19:13:56'),
(29812, 5873, 'ADXI', '', 2, '2021-05-19 19:13:56'),
(29813, 5873, 'ADXN', 'SRF No.', 2, '2021-05-19 19:13:56'),
(29814, 5873, 'ADXH', '', 2, '2021-05-19 19:13:56'),
(29815, 5873, 'ADXC', '', 2, '2021-05-19 19:13:57'),
(29816, 5873, 'ADXF', '', 2, '2021-05-19 19:13:57'),
(29817, 5873, 'ADXJ', '', 2, '2021-05-19 19:13:57'),
(29818, 5873, 'ADXQ', '', 2, '2021-05-19 19:13:57'),
(29819, 5873, 'ADXS', '', 2, '2021-05-19 19:13:57'),
(29820, 5873, 'ADLO', '13', 2, '2021-05-19 19:13:57'),
(29821, 5876, 'APIT', 'ITHD', 2, '2021-05-19 19:15:25'),
(29822, 5876, 'APCL', '', 2, '2021-05-19 19:15:25'),
(29823, 5876, 'APIH', '', 2, '2021-05-19 19:15:25'),
(29824, 5876, 'APMA', '1', 2, '2021-05-19 19:15:25'),
(29825, 5876, 'APHT', '', 2, '2021-05-19 19:15:25'),
(29826, 5876, 'APHD', '', 2, '2021-05-19 19:15:26'),
(29827, 5876, 'APRO', '', 2, '2021-05-19 19:15:26'),
(29828, 5876, 'APEZ', '', 2, '2021-05-19 19:15:26'),
(29829, 5876, 'ADXI', '', 2, '2021-05-19 19:15:26'),
(29830, 5876, 'ADXN', 'Medical', 2, '2021-05-19 19:15:26'),
(29831, 5876, 'ADXH', '', 2, '2021-05-19 19:15:26'),
(29832, 5876, 'ADXC', '', 2, '2021-05-19 19:15:27'),
(29833, 5876, 'ADXF', '', 2, '2021-05-19 19:15:27'),
(29834, 5876, 'ADXJ', '', 2, '2021-05-19 19:15:27'),
(29835, 5876, 'ADXQ', '', 2, '2021-05-19 19:15:27'),
(29836, 5876, 'ADXS', '', 2, '2021-05-19 19:15:28'),
(29837, 5876, 'ADLO', '16', 2, '2021-05-19 19:15:28'),
(29838, 5871, 'APIT', 'ITSL', 2, '2021-05-19 19:17:01'),
(29839, 5871, 'APSL', '[[\"Entity_Child_Base\",\"TKSC->SARA or Covid\",\"token\",\"sn\",\"\"]]', 2, '2021-05-19 19:17:01'),
(29840, 5871, 'APAD', '', 2, '2021-05-19 19:17:01'),
(29841, 5871, 'APCL', '', 2, '2021-05-19 19:17:01'),
(29842, 5871, 'APIH', '', 2, '2021-05-19 19:17:02'),
(29843, 5871, 'APMA', '', 2, '2021-05-19 19:17:02'),
(29844, 5871, 'APHT', '', 2, '2021-05-19 19:17:02'),
(29845, 5871, 'APHD', '', 2, '2021-05-19 19:17:02'),
(29846, 5871, 'APRO', '', 2, '2021-05-19 19:17:02'),
(29847, 5871, 'APEZ', '', 2, '2021-05-19 19:17:02'),
(29848, 5871, 'ADXI', '', 2, '2021-05-19 19:17:02'),
(29849, 5871, 'ADXN', 'SARA/Covid', 2, '2021-05-19 19:17:02'),
(29850, 5871, 'ADXH', '', 2, '2021-05-19 19:17:02'),
(29851, 5871, 'ADXC', '', 2, '2021-05-19 19:17:02'),
(29852, 5871, 'ADXF', '', 2, '2021-05-19 19:17:03'),
(29853, 5871, 'ADXJ', '', 2, '2021-05-19 19:17:03'),
(29854, 5871, 'ADXQ', '', 2, '2021-05-19 19:17:03'),
(29855, 5871, 'ADXS', '', 2, '2021-05-19 19:17:03'),
(29856, 5871, 'ADLO', '11', 2, '2021-05-19 19:17:03'),
(29876, 5864, 'APIT', 'ITSL', 2, '2021-05-19 19:22:23'),
(29877, 5864, 'APSL', '[[\"Entity_Child_Base\",\"TKCT->Covid Test Results\",\"token\",\"sn\",\"\"]]', 2, '2021-05-19 19:22:23'),
(29878, 5864, 'APAD', '', 2, '2021-05-19 19:22:23'),
(29879, 5864, 'APCL', '', 2, '2021-05-19 19:22:23'),
(29880, 5864, 'APIH', '', 2, '2021-05-19 19:22:23'),
(29881, 5864, 'APMA', '1', 2, '2021-05-19 19:22:23'),
(29882, 5864, 'APHT', '', 2, '2021-05-19 19:22:24'),
(29883, 5864, 'APHD', '', 2, '2021-05-19 19:22:24'),
(29884, 5864, 'APRO', '', 2, '2021-05-19 19:22:24'),
(29885, 5864, 'APEZ', '', 2, '2021-05-19 19:22:24'),
(29886, 5864, 'ADXI', '1', 2, '2021-05-19 19:22:24'),
(29887, 5864, 'ADXN', 'Test Status', 2, '2021-05-19 19:22:24'),
(29888, 5864, 'ADXH', 'Test', 2, '2021-05-19 19:22:24'),
(29889, 5864, 'ADXC', 'Test', 2, '2021-05-19 19:22:24'),
(29890, 5864, 'ADXF', '', 2, '2021-05-19 19:22:24'),
(29891, 5864, 'ADXJ', '', 2, '2021-05-19 19:22:24'),
(29892, 5864, 'ADXQ', 'get_ecb_sn_by_token', 2, '2021-05-19 19:22:24'),
(29893, 5864, 'ADXS', '', 2, '2021-05-19 19:22:25'),
(29894, 5864, 'ADLO', '10', 2, '2021-05-19 19:22:25'),
(29895, 5853, 'APIT', 'ITTA', 2, '2021-05-19 19:23:19'),
(29896, 5853, 'APCL', '', 2, '2021-05-19 19:23:19'),
(29897, 5853, 'APIH', '', 2, '2021-05-19 19:23:19'),
(29898, 5853, 'APAL', 'x1000', 2, '2021-05-19 19:23:19'),
(29899, 5853, 'APMA', '1', 2, '2021-05-19 19:23:19'),
(29900, 5853, 'APHT', '', 2, '2021-05-19 19:23:19'),
(29901, 5853, 'APHD', '', 2, '2021-05-19 19:23:19'),
(29902, 5853, 'APRO', '', 2, '2021-05-19 19:23:19'),
(29903, 5853, 'APEZ', '', 2, '2021-05-19 19:23:19'),
(29904, 5853, 'ADXI', '', 2, '2021-05-19 19:23:19'),
(29905, 5853, 'ADXN', 'Patient Address', 2, '2021-05-19 19:23:19'),
(29906, 5853, 'ADXH', '', 2, '2021-05-19 19:23:19'),
(29907, 5853, 'ADXC', '', 2, '2021-05-19 19:23:20'),
(29908, 5853, 'ADXF', '', 2, '2021-05-19 19:23:20'),
(29909, 5853, 'ADXJ', '', 2, '2021-05-19 19:23:20'),
(29910, 5853, 'ADXQ', '', 2, '2021-05-19 19:23:20'),
(29911, 5853, 'ADXS', '', 2, '2021-05-19 19:23:20'),
(29912, 5853, 'ADLO', '2', 2, '2021-05-19 19:23:20'),
(29913, 5885, 'APIT', 'ITTX', 2, '2021-05-19 23:55:07'),
(29914, 5885, 'APCL', '', 2, '2021-05-19 23:55:07'),
(29915, 5885, 'APIH', '', 2, '2021-05-19 23:55:07'),
(29916, 5885, 'APAL', 'X100', 2, '2021-05-19 23:55:07'),
(29917, 5885, 'APMA', '1', 2, '2021-05-19 23:55:07'),
(29918, 5885, 'APHT', '', 2, '2021-05-19 23:55:07'),
(29919, 5885, 'APHD', '', 2, '2021-05-19 23:55:07'),
(29920, 5885, 'APRO', '', 2, '2021-05-19 23:55:08'),
(29921, 5885, 'APEZ', '', 2, '2021-05-19 23:55:08'),
(29922, 5885, 'ADXI', '1', 2, '2021-05-19 23:55:08'),
(29923, 5885, 'ADXN', 'Name', 2, '2021-05-19 23:55:08'),
(29924, 5885, 'ADXH', '', 2, '2021-05-19 23:55:08'),
(29925, 5885, 'ADXC', '', 2, '2021-05-19 23:55:08'),
(29926, 5885, 'ADXF', '', 2, '2021-05-19 23:55:08'),
(29927, 5885, 'ADXJ', '', 2, '2021-05-19 23:55:08'),
(29928, 5885, 'ADXQ', '', 2, '2021-05-19 23:55:08'),
(29929, 5885, 'ADXS', '', 2, '2021-05-19 23:55:08'),
(29930, 5885, 'ADLO', '1', 2, '2021-05-19 23:55:08'),
(29949, 5886, 'APIT', 'ITTX', 2, '2021-05-19 23:58:26'),
(29950, 5886, 'APCL', '', 2, '2021-05-19 23:58:26'),
(29951, 5886, 'APIH', '', 2, '2021-05-19 23:58:26'),
(29952, 5886, 'APAL', 'X50', 2, '2021-05-19 23:58:26'),
(29953, 5886, 'APMA', '1', 2, '2021-05-19 23:58:26'),
(29954, 5886, 'APHT', '', 2, '2021-05-19 23:58:27'),
(29955, 5886, 'APHD', '', 2, '2021-05-19 23:58:27'),
(29956, 5886, 'APRO', '', 2, '2021-05-19 23:58:27'),
(29957, 5886, 'APEZ', '', 2, '2021-05-19 23:58:27'),
(29958, 5886, 'ADXI', '1', 2, '2021-05-19 23:58:27'),
(29959, 5886, 'ADXN', 'Name', 2, '2021-05-19 23:58:27'),
(29960, 5886, 'ADXH', '', 2, '2021-05-19 23:58:27'),
(29961, 5886, 'ADXC', '', 2, '2021-05-19 23:58:27'),
(29962, 5886, 'ADXF', '', 2, '2021-05-19 23:58:27'),
(29963, 5886, 'ADXJ', '', 2, '2021-05-19 23:58:27'),
(29964, 5886, 'ADXQ', '', 2, '2021-05-19 23:58:27'),
(29965, 5886, 'ADXS', '', 2, '2021-05-19 23:58:28'),
(29966, 5886, 'ADLO', '1', 2, '2021-05-19 23:58:28'),
(29967, 5892, 'APIT', 'ITSL', 2, '2021-05-20 00:07:33'),
(29968, 5892, 'APSL', '[[\"Entity_Child_Base\",\"TKHT->Hospital Type\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 00:07:33'),
(29969, 5892, 'APAD', '', 2, '2021-05-20 00:07:33'),
(29970, 5892, 'APCL', '', 2, '2021-05-20 00:07:33'),
(29971, 5892, 'APIH', '', 2, '2021-05-20 00:07:33'),
(29972, 5892, 'APMA', '1', 2, '2021-05-20 00:07:33'),
(29973, 5892, 'APHT', '', 2, '2021-05-20 00:07:33'),
(29974, 5892, 'APHD', '', 2, '2021-05-20 00:07:33'),
(29975, 5892, 'APRO', '', 2, '2021-05-20 00:07:33'),
(29976, 5892, 'APEZ', '', 2, '2021-05-20 00:07:33'),
(29977, 5892, 'ADXI', '', 2, '2021-05-20 00:07:33'),
(29978, 5892, 'ADXN', 'Type', 2, '2021-05-20 00:07:33'),
(29979, 5892, 'ADXH', '', 2, '2021-05-20 00:07:33'),
(29980, 5892, 'ADXC', '', 2, '2021-05-20 00:07:34'),
(29981, 5892, 'ADXF', '', 2, '2021-05-20 00:07:34'),
(29982, 5892, 'ADXJ', '', 2, '2021-05-20 00:07:34'),
(29983, 5892, 'ADXQ', '', 2, '2021-05-20 00:07:34'),
(29984, 5892, 'ADXS', '', 2, '2021-05-20 00:07:34');
INSERT INTO `ecb_av_addon_varchar` (`id`, `parent_id`, `ea_code`, `ea_value`, `user_id`, `timestamp_punch`) VALUES
(29985, 5892, 'ADLO', '2', 2, '2021-05-20 00:07:34'),
(29986, 5893, 'APIT', 'ITSL', 2, '2021-05-20 00:09:53'),
(29987, 5893, 'APSL', '[[\"Entity_Child_Base\",\"TKHH->Home or Hospital\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 00:09:53'),
(29988, 5893, 'APAD', '', 2, '2021-05-20 00:09:54'),
(29989, 5893, 'APCL', '', 2, '2021-05-20 00:09:54'),
(29990, 5893, 'APIH', '', 2, '2021-05-20 00:09:54'),
(29991, 5893, 'APMA', '1', 2, '2021-05-20 00:09:54'),
(29992, 5893, 'APHT', '', 2, '2021-05-20 00:09:54'),
(29993, 5893, 'APHD', '', 2, '2021-05-20 00:09:54'),
(29994, 5893, 'APRO', '', 2, '2021-05-20 00:09:54'),
(29995, 5893, 'APEZ', '1', 2, '2021-05-20 00:09:54'),
(29996, 5893, 'ADXI', '', 2, '2021-05-20 00:09:54'),
(29997, 5893, 'ADXN', 'Presently Patient at Home / Hospital', 2, '2021-05-20 00:09:54'),
(29998, 5893, 'ADXH', '', 2, '2021-05-20 00:09:54'),
(29999, 5893, 'ADXC', '', 2, '2021-05-20 00:09:54'),
(30000, 5893, 'ADXF', '', 2, '2021-05-20 00:09:54'),
(30001, 5893, 'ADXJ', '', 2, '2021-05-20 00:09:54'),
(30002, 5893, 'ADXQ', '', 2, '2021-05-20 00:09:54'),
(30003, 5893, 'ADXS', '', 2, '2021-05-20 00:09:54'),
(30004, 5893, 'ADLO', '17', 2, '2021-05-20 00:09:54'),
(30024, 5894, 'APIT', 'ITSL', 2, '2021-05-20 00:15:33'),
(30025, 5894, 'APSL', '[[\"Entity_Child\",\"TKHS->Hospitals\",\"id\",\"get_exav_addon_varchar(id,\'TKHSNA\')\",\"\"]]', 2, '2021-05-20 00:30:26'),
(30026, 5894, 'APAD', '', 2, '2021-05-20 00:15:33'),
(30027, 5894, 'APCL', '', 2, '2021-05-20 00:15:33'),
(30028, 5894, 'APIH', '', 2, '2021-05-20 00:15:33'),
(30029, 5894, 'APMA', '', 2, '2021-05-20 00:15:33'),
(30030, 5894, 'APHT', '', 2, '2021-05-20 00:15:33'),
(30031, 5894, 'APHD', '', 2, '2021-05-20 00:15:33'),
(30032, 5894, 'APRO', '', 2, '2021-05-20 00:15:33'),
(30033, 5894, 'APEZ', '1', 2, '2021-05-20 00:15:33'),
(30034, 5894, 'ADXI', '', 2, '2021-05-20 00:15:33'),
(30035, 5894, 'ADXN', 'Hospital', 2, '2021-05-20 00:15:34'),
(30036, 5894, 'ADXH', '', 2, '2021-05-20 00:15:34'),
(30037, 5894, 'ADXC', '', 2, '2021-05-20 00:15:34'),
(30038, 5894, 'ADXF', '', 2, '2021-05-20 00:15:34'),
(30039, 5894, 'ADXJ', '', 2, '2021-05-20 00:15:34'),
(30040, 5894, 'ADXQ', '', 2, '2021-05-20 00:15:34'),
(30041, 5894, 'ADXS', '', 2, '2021-05-20 00:15:34'),
(30042, 5894, 'ADLO', '18', 2, '2021-05-20 00:15:35'),
(30043, 5895, 'APIT', 'ITTA', 2, '2021-05-20 00:16:39'),
(30044, 5895, 'APCL', 'w_300', 2, '2021-05-20 00:16:39'),
(30045, 5895, 'APIH', '', 2, '2021-05-20 00:16:39'),
(30046, 5895, 'APAL', 'x1000', 2, '2021-05-20 00:16:39'),
(30047, 5895, 'APMA', '', 2, '2021-05-20 00:16:39'),
(30048, 5895, 'APHT', '', 2, '2021-05-20 00:16:39'),
(30049, 5895, 'APHD', '', 2, '2021-05-20 00:16:39'),
(30050, 5895, 'APRO', '', 2, '2021-05-20 00:16:39'),
(30051, 5895, 'APEZ', '1', 2, '2021-05-20 00:16:39'),
(30052, 5895, 'ADXI', '', 2, '2021-05-20 00:16:39'),
(30053, 5895, 'ADXN', 'Agent Remarks', 2, '2021-05-20 00:16:39'),
(30054, 5895, 'ADXH', '', 2, '2021-05-20 00:16:39'),
(30055, 5895, 'ADXC', '', 2, '2021-05-20 00:16:39'),
(30056, 5895, 'ADXF', '', 2, '2021-05-20 00:16:39'),
(30057, 5895, 'ADXJ', '', 2, '2021-05-20 00:16:39'),
(30058, 5895, 'ADXQ', '', 2, '2021-05-20 00:16:39'),
(30059, 5895, 'ADXS', '', 2, '2021-05-20 00:16:39'),
(30060, 5895, 'ADLO', '19', 2, '2021-05-20 00:16:39'),
(30061, 5896, 'APIT', 'ITSL', 2, '2021-05-20 00:17:54'),
(30062, 5896, 'APSL', '[[\"Entity_Child_Base\",\"TKBD->Bed Detail\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 00:17:54'),
(30063, 5896, 'APAD', '', 2, '2021-05-20 00:17:54'),
(30064, 5896, 'APCL', '', 2, '2021-05-20 00:17:54'),
(30065, 5896, 'APIH', '', 2, '2021-05-20 00:17:54'),
(30066, 5896, 'APMA', '', 2, '2021-05-20 00:17:54'),
(30067, 5896, 'APHT', '', 2, '2021-05-20 00:17:54'),
(30068, 5896, 'APHD', '', 2, '2021-05-20 00:17:54'),
(30069, 5896, 'APRO', '', 2, '2021-05-20 00:17:54'),
(30070, 5896, 'APEZ', '1', 2, '2021-05-20 00:17:54'),
(30071, 5896, 'ADXI', '', 2, '2021-05-20 00:17:54'),
(30072, 5896, 'ADXN', 'Bed Details', 2, '2021-05-20 00:17:54'),
(30073, 5896, 'ADXH', '', 2, '2021-05-20 00:17:54'),
(30074, 5896, 'ADXC', '', 2, '2021-05-20 00:17:54'),
(30075, 5896, 'ADXF', '', 2, '2021-05-20 00:17:54'),
(30076, 5896, 'ADXJ', '', 2, '2021-05-20 00:17:54'),
(30077, 5896, 'ADXQ', '', 2, '2021-05-20 00:17:55'),
(30078, 5896, 'ADXS', '', 2, '2021-05-20 00:17:55'),
(30079, 5896, 'ADLO', '20', 2, '2021-05-20 00:17:55'),
(30080, 5897, 'APIT', 'ITTX', 2, '2021-05-20 00:20:43'),
(30081, 5897, 'APCL', '', 2, '2021-05-20 00:20:43'),
(30082, 5897, 'APIH', '', 2, '2021-05-20 00:20:43'),
(30083, 5897, 'APAL', 'd5', 2, '2021-05-20 00:20:43'),
(30084, 5897, 'APMA', '', 2, '2021-05-20 00:20:44'),
(30085, 5897, 'APHT', '', 2, '2021-05-20 00:20:44'),
(30086, 5897, 'APHD', '', 2, '2021-05-20 00:20:44'),
(30087, 5897, 'APRO', '', 2, '2021-05-20 00:20:44'),
(30088, 5897, 'APEZ', '1', 2, '2021-05-20 00:20:44'),
(30089, 5897, 'ADXI', '', 2, '2021-05-20 00:20:44'),
(30090, 5897, 'ADXN', 'Zone No.', 2, '2021-05-20 00:20:44'),
(30091, 5897, 'ADXH', '', 2, '2021-05-20 00:20:44'),
(30092, 5897, 'ADXC', '', 2, '2021-05-20 00:20:44'),
(30093, 5897, 'ADXF', '', 2, '2021-05-20 00:20:44'),
(30094, 5897, 'ADXJ', '', 2, '2021-05-20 00:20:44'),
(30095, 5897, 'ADXQ', '', 2, '2021-05-20 00:20:44'),
(30096, 5897, 'ADXS', '', 2, '2021-05-20 00:20:44'),
(30097, 5897, 'ADLO', '21', 2, '2021-05-20 00:20:44'),
(30098, 5898, 'APIT', 'ITSL', 2, '2021-05-20 00:21:50'),
(30099, 5898, 'APSL', '[[\"Entity_Child\",\"TKZN->Zone\",\"id\",\"get_exav_addon_varchar(id,\'TKZNNA\')\",\"\"]]', 2, '2021-05-20 00:29:17'),
(30100, 5898, 'APAD', '', 2, '2021-05-20 00:21:50'),
(30101, 5898, 'APCL', '', 2, '2021-05-20 00:21:50'),
(30102, 5898, 'APIH', '', 2, '2021-05-20 00:21:50'),
(30103, 5898, 'APMA', '1', 2, '2021-05-20 00:21:50'),
(30104, 5898, 'APHT', '', 2, '2021-05-20 00:21:50'),
(30105, 5898, 'APHD', '', 2, '2021-05-20 00:21:50'),
(30106, 5898, 'APRO', '', 2, '2021-05-20 00:21:50'),
(30107, 5898, 'APEZ', '', 2, '2021-05-20 00:21:50'),
(30108, 5898, 'ADXI', '', 2, '2021-05-20 00:21:50'),
(30109, 5898, 'ADXN', 'Zone', 2, '2021-05-20 00:21:50'),
(30110, 5898, 'ADXH', '', 2, '2021-05-20 00:21:50'),
(30111, 5898, 'ADXC', '', 2, '2021-05-20 00:21:51'),
(30112, 5898, 'ADXF', '', 2, '2021-05-20 00:21:51'),
(30113, 5898, 'ADXJ', '', 2, '2021-05-20 00:21:51'),
(30114, 5898, 'ADXQ', '', 2, '2021-05-20 00:21:51'),
(30115, 5898, 'ADXS', '', 2, '2021-05-20 00:21:51'),
(30116, 5898, 'ADLO', '22', 2, '2021-05-20 00:21:51'),
(30117, 5899, 'APIT', 'ITSL', 2, '2021-05-20 00:23:14'),
(30118, 5899, 'APSL', '[[\"Entity_Child_Base\",\"TKTR->Ticket Transfer\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 00:23:14'),
(30119, 5899, 'APAD', '', 2, '2021-05-20 00:23:15'),
(30120, 5899, 'APCL', '', 2, '2021-05-20 00:23:15'),
(30121, 5899, 'APIH', '', 2, '2021-05-20 00:23:15'),
(30122, 5899, 'APMA', '1', 2, '2021-05-20 00:23:15'),
(30123, 5899, 'APHT', '', 2, '2021-05-20 00:23:15'),
(30124, 5899, 'APHD', '', 2, '2021-05-20 00:23:15'),
(30125, 5899, 'APRO', '', 2, '2021-05-20 00:23:15'),
(30126, 5899, 'APEZ', '', 2, '2021-05-20 00:23:15'),
(30127, 5899, 'ADXI', '', 2, '2021-05-20 00:23:15'),
(30128, 5899, 'ADXN', 'Transfer Status', 2, '2021-05-20 00:23:15'),
(30129, 5899, 'ADXH', '', 2, '2021-05-20 00:23:15'),
(30130, 5899, 'ADXC', '', 2, '2021-05-20 00:23:15'),
(30131, 5899, 'ADXF', '', 2, '2021-05-20 00:23:15'),
(30132, 5899, 'ADXJ', '', 2, '2021-05-20 00:23:15'),
(30133, 5899, 'ADXQ', '', 2, '2021-05-20 00:23:15'),
(30134, 5899, 'ADXS', '', 2, '2021-05-20 00:23:15'),
(30135, 5899, 'ADLO', '23', 2, '2021-05-20 00:23:15'),
(30136, 5906, 'APIT', 'ITTX', 2, '2021-05-20 00:49:57'),
(30137, 5906, 'APCL', '', 2, '2021-05-20 00:49:57'),
(30138, 5906, 'APIH', '', 2, '2021-05-20 00:49:57'),
(30139, 5906, 'APAL', 'v1-10', 2, '2021-05-20 00:49:57'),
(30140, 5906, 'APMA', '', 2, '2021-05-20 00:49:57'),
(30141, 5906, 'APHT', '', 2, '2021-05-20 00:49:57'),
(30142, 5906, 'APHD', '', 2, '2021-05-20 00:49:57'),
(30143, 5906, 'APRO', '', 2, '2021-05-20 00:49:57'),
(30144, 5906, 'APEZ', '1', 2, '2021-05-20 00:49:57'),
(30145, 5906, 'ADXI', '', 2, '2021-05-20 00:49:57'),
(30146, 5906, 'ADXN', 'Severty Level', 2, '2021-05-20 00:49:57'),
(30147, 5906, 'ADXH', '', 2, '2021-05-20 00:49:57'),
(30148, 5906, 'ADXC', '', 2, '2021-05-20 00:49:57'),
(30149, 5906, 'ADXF', '', 2, '2021-05-20 00:49:57'),
(30150, 5906, 'ADXJ', '', 2, '2021-05-20 00:49:57'),
(30151, 5906, 'ADXQ', '', 2, '2021-05-20 00:49:57'),
(30152, 5906, 'ADXS', '', 2, '2021-05-20 00:49:57'),
(30153, 5906, 'ADLO', '24', 2, '2021-05-20 00:49:57'),
(30154, 5907, 'APIT', 'ITTX', 2, '2021-05-20 00:50:46'),
(30155, 5907, 'APCL', '', 2, '2021-05-20 00:50:46'),
(30156, 5907, 'APIH', '', 2, '2021-05-20 00:50:46'),
(30157, 5907, 'APAL', 'x10', 2, '2021-05-20 00:50:46'),
(30158, 5907, 'APMA', '', 2, '2021-05-20 00:50:46'),
(30159, 5907, 'APHT', '', 2, '2021-05-20 00:50:46'),
(30160, 5907, 'APHD', '', 2, '2021-05-20 00:50:46'),
(30161, 5907, 'APRO', '', 2, '2021-05-20 00:50:46'),
(30162, 5907, 'APEZ', '1', 2, '2021-05-20 00:50:46'),
(30163, 5907, 'ADXI', '', 2, '2021-05-20 00:50:46'),
(30164, 5907, 'ADXN', 'CORADS/25', 2, '2021-05-20 00:50:47'),
(30165, 5907, 'ADXH', '', 2, '2021-05-20 00:50:47'),
(30166, 5907, 'ADXC', '', 2, '2021-05-20 00:50:47'),
(30167, 5907, 'ADXF', '', 2, '2021-05-20 00:50:47'),
(30168, 5907, 'ADXJ', '', 2, '2021-05-20 00:50:47'),
(30169, 5907, 'ADXQ', '', 2, '2021-05-20 00:50:47'),
(30170, 5907, 'ADXS', '', 2, '2021-05-20 00:50:47'),
(30171, 5907, 'ADLO', '25', 2, '2021-05-20 00:50:47'),
(30172, 5908, 'APIT', 'ITTX', 2, '2021-05-20 00:51:23'),
(30173, 5908, 'APCL', '', 2, '2021-05-20 00:51:23'),
(30174, 5908, 'APIH', '', 2, '2021-05-20 00:51:23'),
(30175, 5908, 'APAL', 'x20', 2, '2021-05-20 00:51:23'),
(30176, 5908, 'APMA', '', 2, '2021-05-20 00:51:23'),
(30177, 5908, 'APHT', '', 2, '2021-05-20 00:51:23'),
(30178, 5908, 'APHD', '', 2, '2021-05-20 00:51:24'),
(30179, 5908, 'APRO', '', 2, '2021-05-20 00:51:24'),
(30180, 5908, 'APEZ', '1', 2, '2021-05-20 00:51:24'),
(30181, 5908, 'ADXI', '', 2, '2021-05-20 00:51:24'),
(30182, 5908, 'ADXN', 'Saturation in Room Air', 2, '2021-05-20 00:51:24'),
(30183, 5908, 'ADXH', '', 2, '2021-05-20 00:51:24'),
(30184, 5908, 'ADXC', '', 2, '2021-05-20 00:51:24'),
(30185, 5908, 'ADXF', '', 2, '2021-05-20 00:51:24'),
(30186, 5908, 'ADXJ', '', 2, '2021-05-20 00:51:24'),
(30187, 5908, 'ADXQ', '', 2, '2021-05-20 00:51:24'),
(30188, 5908, 'ADXS', '', 2, '2021-05-20 00:51:24'),
(30189, 5908, 'ADLO', '26', 2, '2021-05-20 00:51:24'),
(30190, 5909, 'APIT', 'ITTX', 2, '2021-05-20 00:52:15'),
(30191, 5909, 'APCL', '', 2, '2021-05-20 00:52:15'),
(30192, 5909, 'APIH', '', 2, '2021-05-20 00:52:15'),
(30193, 5909, 'APAL', 'x120', 2, '2021-05-20 00:52:15'),
(30194, 5909, 'APMA', '', 2, '2021-05-20 00:52:15'),
(30195, 5909, 'APHT', '', 2, '2021-05-20 00:52:15'),
(30196, 5909, 'APHD', '', 2, '2021-05-20 00:52:15'),
(30197, 5909, 'APRO', '', 2, '2021-05-20 00:52:15'),
(30198, 5909, 'APEZ', '1', 2, '2021-05-20 00:52:15'),
(30199, 5909, 'ADXI', '', 2, '2021-05-20 00:52:15'),
(30200, 5909, 'ADXN', 'Saturation with Oxygen (Volume)', 2, '2021-05-20 00:52:15'),
(30201, 5909, 'ADXH', '', 2, '2021-05-20 00:52:15'),
(30202, 5909, 'ADXC', '', 2, '2021-05-20 00:52:15'),
(30203, 5909, 'ADXF', '', 2, '2021-05-20 00:52:15'),
(30204, 5909, 'ADXJ', '', 2, '2021-05-20 00:52:15'),
(30205, 5909, 'ADXQ', '', 2, '2021-05-20 00:52:15'),
(30206, 5909, 'ADXS', '', 2, '2021-05-20 00:52:15'),
(30207, 5909, 'ADLO', '27', 2, '2021-05-20 00:52:15'),
(30208, 5910, 'APIT', 'ITTX', 2, '2021-05-20 00:54:24'),
(30209, 5910, 'APCL', '', 2, '2021-05-20 00:54:24'),
(30210, 5910, 'APIH', '', 2, '2021-05-20 00:54:24'),
(30211, 5910, 'APAL', 'x1000', 2, '2021-05-20 00:54:24'),
(30212, 5910, 'APMA', '', 2, '2021-05-20 00:54:24'),
(30213, 5910, 'APHT', '', 2, '2021-05-20 00:54:24'),
(30214, 5910, 'APHD', '', 2, '2021-05-20 00:54:24'),
(30215, 5910, 'APRO', '', 2, '2021-05-20 00:54:24'),
(30216, 5910, 'APEZ', '1', 2, '2021-05-20 00:54:24'),
(30217, 5910, 'ADXI', '', 2, '2021-05-20 00:54:24'),
(30218, 5910, 'ADXN', 'Co-Morbidities', 2, '2021-05-20 00:54:24'),
(30219, 5910, 'ADXH', '', 2, '2021-05-20 00:54:24'),
(30220, 5910, 'ADXC', '', 2, '2021-05-20 00:54:24'),
(30221, 5910, 'ADXF', '', 2, '2021-05-20 00:54:24'),
(30222, 5910, 'ADXJ', '', 2, '2021-05-20 00:54:24'),
(30223, 5910, 'ADXQ', '', 2, '2021-05-20 00:54:24'),
(30224, 5910, 'ADXS', '', 2, '2021-05-20 00:54:24'),
(30225, 5910, 'ADLO', '28', 2, '2021-05-20 00:54:24'),
(30226, 5911, 'APIT', 'ITSL', 2, '2021-05-20 00:55:12'),
(30227, 5911, 'APSL', '[[\"Entity_Child_Base\",\"TKSL->Speciality\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 00:55:12'),
(30228, 5911, 'APAD', '', 2, '2021-05-20 00:55:12'),
(30229, 5911, 'APCL', '', 2, '2021-05-20 00:55:12'),
(30230, 5911, 'APIH', '', 2, '2021-05-20 00:55:12'),
(30231, 5911, 'APMA', '', 2, '2021-05-20 00:55:12'),
(30232, 5911, 'APHT', '', 2, '2021-05-20 00:55:12'),
(30233, 5911, 'APHD', '', 2, '2021-05-20 00:55:12'),
(30234, 5911, 'APRO', '', 2, '2021-05-20 00:55:12'),
(30235, 5911, 'APEZ', '', 2, '2021-05-20 00:55:12'),
(30236, 5911, 'ADXI', '', 2, '2021-05-20 00:55:12'),
(30237, 5911, 'ADXN', 'Speciality', 2, '2021-05-20 00:55:12'),
(30238, 5911, 'ADXH', '', 2, '2021-05-20 00:55:12'),
(30239, 5911, 'ADXC', '', 2, '2021-05-20 00:55:13'),
(30240, 5911, 'ADXF', '', 2, '2021-05-20 00:55:13'),
(30241, 5911, 'ADXJ', '', 2, '2021-05-20 00:55:13'),
(30242, 5911, 'ADXQ', '', 2, '2021-05-20 00:55:13'),
(30243, 5911, 'ADXS', '', 2, '2021-05-20 00:55:13'),
(30244, 5911, 'ADLO', '29', 2, '2021-05-20 00:55:13'),
(30245, 5912, 'APIT', 'ITSL', 2, '2021-05-20 00:57:10'),
(30246, 5912, 'APSL', '[[\"Entity_Child_Base\",\"TKBD->Bed Detail\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 00:57:10'),
(30247, 5912, 'APAD', '', 2, '2021-05-20 00:57:10'),
(30248, 5912, 'APCL', '', 2, '2021-05-20 00:57:10'),
(30249, 5912, 'APIH', '', 2, '2021-05-20 00:57:10'),
(30250, 5912, 'APMA', '', 2, '2021-05-20 00:57:10'),
(30251, 5912, 'APHT', '', 2, '2021-05-20 00:57:10'),
(30252, 5912, 'APHD', '', 2, '2021-05-20 00:57:10'),
(30253, 5912, 'APRO', '', 2, '2021-05-20 00:57:10'),
(30254, 5912, 'APEZ', '1', 2, '2021-05-20 00:57:10'),
(30255, 5912, 'ADXI', '', 2, '2021-05-20 00:57:10'),
(30256, 5912, 'ADXN', 'Bed type', 2, '2021-05-20 00:57:10'),
(30257, 5912, 'ADXH', '', 2, '2021-05-20 00:57:10'),
(30258, 5912, 'ADXC', '', 2, '2021-05-20 00:57:11'),
(30259, 5912, 'ADXF', '', 2, '2021-05-20 00:57:11'),
(30260, 5912, 'ADXJ', '', 2, '2021-05-20 00:57:11'),
(30261, 5912, 'ADXQ', '', 2, '2021-05-20 00:57:11'),
(30262, 5912, 'ADXS', '', 2, '2021-05-20 00:57:11'),
(30263, 5912, 'ADLO', '30', 2, '2021-05-20 00:57:11'),
(30264, 5913, 'APIT', 'ITSL', 2, '2021-05-20 00:57:49'),
(30265, 5913, 'APSL', '[[\"Entity_Child_Base\",\"YN->Yes or No\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 00:57:49'),
(30266, 5913, 'APAD', '', 2, '2021-05-20 00:57:49'),
(30267, 5913, 'APCL', '', 2, '2021-05-20 00:57:49'),
(30268, 5913, 'APIH', '', 2, '2021-05-20 00:57:49'),
(30269, 5913, 'APMA', '', 2, '2021-05-20 00:57:49'),
(30270, 5913, 'APHT', '', 2, '2021-05-20 00:57:49'),
(30271, 5913, 'APHD', '', 2, '2021-05-20 00:57:49'),
(30272, 5913, 'APRO', '', 2, '2021-05-20 00:57:49'),
(30273, 5913, 'APEZ', '1', 2, '2021-05-20 00:57:49'),
(30274, 5913, 'ADXI', '', 2, '2021-05-20 00:57:49'),
(30275, 5913, 'ADXN', 'Triage Done', 2, '2021-05-20 00:57:49'),
(30276, 5913, 'ADXH', '', 2, '2021-05-20 00:57:49'),
(30277, 5913, 'ADXC', '', 2, '2021-05-20 00:57:49'),
(30278, 5913, 'ADXF', '', 2, '2021-05-20 00:57:49'),
(30279, 5913, 'ADXJ', '', 2, '2021-05-20 00:57:49'),
(30280, 5913, 'ADXQ', '', 2, '2021-05-20 00:57:49'),
(30281, 5913, 'ADXS', '', 2, '2021-05-20 00:57:50'),
(30282, 5913, 'ADLO', '31', 2, '2021-05-20 00:57:50'),
(30283, 5914, 'APIT', 'ITTX', 2, '2021-05-20 00:58:32'),
(30284, 5914, 'APCL', '', 2, '2021-05-20 00:58:32'),
(30285, 5914, 'APIH', '', 2, '2021-05-20 00:58:32'),
(30286, 5914, 'APAL', 'x10', 2, '2021-05-20 00:58:32'),
(30287, 5914, 'APMA', '', 2, '2021-05-20 00:58:33'),
(30288, 5914, 'APHT', '', 2, '2021-05-20 00:58:33'),
(30289, 5914, 'APHD', '', 2, '2021-05-20 00:58:33'),
(30290, 5914, 'APRO', '', 2, '2021-05-20 00:58:33'),
(30291, 5914, 'APEZ', '1', 2, '2021-05-20 00:58:33'),
(30292, 5914, 'ADXI', '', 2, '2021-05-20 00:58:33'),
(30293, 5914, 'ADXN', 'Call forwarded to 108/SAST', 2, '2021-05-20 00:58:33'),
(30294, 5914, 'ADXH', '', 2, '2021-05-20 00:58:33'),
(30295, 5914, 'ADXC', '', 2, '2021-05-20 00:58:33'),
(30296, 5914, 'ADXF', '', 2, '2021-05-20 00:58:33'),
(30297, 5914, 'ADXJ', '', 2, '2021-05-20 00:58:33'),
(30298, 5914, 'ADXQ', '', 2, '2021-05-20 00:58:33'),
(30299, 5914, 'ADXS', '', 2, '2021-05-20 00:58:33'),
(30300, 5914, 'ADLO', '32', 2, '2021-05-20 00:58:33'),
(30301, 5915, 'APIT', 'ITSL', 2, '2021-05-20 00:59:08'),
(30302, 5915, 'APSL', '[[\"Entity_Child_Base\",\"YN->Yes or No\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 00:59:08'),
(30303, 5915, 'APAD', '', 2, '2021-05-20 00:59:08'),
(30304, 5915, 'APCL', '', 2, '2021-05-20 00:59:09'),
(30305, 5915, 'APIH', '', 2, '2021-05-20 00:59:09'),
(30306, 5915, 'APMA', '', 2, '2021-05-20 00:59:09'),
(30307, 5915, 'APHT', '', 2, '2021-05-20 00:59:09'),
(30308, 5915, 'APHD', '', 2, '2021-05-20 00:59:09'),
(30309, 5915, 'APRO', '', 2, '2021-05-20 00:59:09'),
(30310, 5915, 'APEZ', '', 2, '2021-05-20 00:59:09'),
(30311, 5915, 'ADXI', '', 2, '2021-05-20 00:59:09'),
(30312, 5915, 'ADXN', 'BBMP/108 Triage Done', 2, '2021-05-20 00:59:09'),
(30313, 5915, 'ADXH', '', 2, '2021-05-20 00:59:09'),
(30314, 5915, 'ADXC', '', 2, '2021-05-20 00:59:09'),
(30315, 5915, 'ADXF', '', 2, '2021-05-20 00:59:09'),
(30316, 5915, 'ADXJ', '', 2, '2021-05-20 00:59:09'),
(30317, 5915, 'ADXQ', '', 2, '2021-05-20 00:59:09'),
(30318, 5915, 'ADXS', '', 2, '2021-05-20 00:59:09'),
(30319, 5915, 'ADLO', '33', 2, '2021-05-20 00:59:09'),
(30320, 5916, 'APIT', 'ITTA', 2, '2021-05-20 01:01:19'),
(30321, 5916, 'APCL', '', 2, '2021-05-20 01:01:20'),
(30322, 5916, 'APIH', '', 2, '2021-05-20 01:01:20'),
(30323, 5916, 'APAL', 'x1000', 2, '2021-05-20 01:01:20'),
(30324, 5916, 'APMA', '', 2, '2021-05-20 01:01:20'),
(30325, 5916, 'APHT', '', 2, '2021-05-20 01:01:20'),
(30326, 5916, 'APHD', '', 2, '2021-05-20 01:01:20'),
(30327, 5916, 'APRO', '', 2, '2021-05-20 01:01:20'),
(30328, 5916, 'APEZ', '1', 2, '2021-05-20 01:01:20'),
(30329, 5916, 'ADXI', '', 2, '2021-05-20 01:01:20'),
(30330, 5916, 'ADXN', 'Bed allocation details', 2, '2021-05-20 01:01:20'),
(30331, 5916, 'ADXH', '', 2, '2021-05-20 01:01:20'),
(30332, 5916, 'ADXC', '', 2, '2021-05-20 01:01:20'),
(30333, 5916, 'ADXF', '', 2, '2021-05-20 01:01:20'),
(30334, 5916, 'ADXJ', '', 2, '2021-05-20 01:01:20'),
(30335, 5916, 'ADXQ', '', 2, '2021-05-20 01:01:20'),
(30336, 5916, 'ADXS', '', 2, '2021-05-20 01:01:20'),
(30337, 5916, 'ADLO', '34', 2, '2021-05-20 01:01:20'),
(30338, 5917, 'APIT', 'ITSL', 2, '2021-05-20 01:02:26'),
(30339, 5917, 'APSL', '[[\"Entity_Child_Base\",\"TKHH->Home or Hospital\",\"id\",\"id\",\"\"]]', 2, '2021-05-20 01:02:26'),
(30340, 5917, 'APAD', '', 2, '2021-05-20 01:02:27'),
(30341, 5917, 'APCL', '', 2, '2021-05-20 01:02:27'),
(30342, 5917, 'APIH', '', 2, '2021-05-20 01:02:27'),
(30343, 5917, 'APMA', '', 2, '2021-05-20 01:02:27'),
(30344, 5917, 'APHT', '', 2, '2021-05-20 01:02:27'),
(30345, 5917, 'APHD', '', 2, '2021-05-20 01:02:27'),
(30346, 5917, 'APRO', '', 2, '2021-05-20 01:02:27'),
(30347, 5917, 'APEZ', '1', 2, '2021-05-20 01:02:27'),
(30348, 5917, 'ADXI', '', 2, '2021-05-20 01:02:27'),
(30349, 5917, 'ADXN', 'Bed allotted Hospital', 2, '2021-05-20 01:02:27'),
(30350, 5917, 'ADXH', '', 2, '2021-05-20 01:02:27'),
(30351, 5917, 'ADXC', '', 2, '2021-05-20 01:02:27'),
(30352, 5917, 'ADXF', '', 2, '2021-05-20 01:02:27'),
(30353, 5917, 'ADXJ', '', 2, '2021-05-20 01:02:27'),
(30354, 5917, 'ADXQ', '', 2, '2021-05-20 01:02:27'),
(30355, 5917, 'ADXS', '', 2, '2021-05-20 01:02:27'),
(30356, 5917, 'ADLO', '35', 2, '2021-05-20 01:02:27'),
(30357, 5918, 'APIT', 'ITSL', 2, '2021-05-20 01:04:10'),
(30358, 5918, 'APSL', '[[\"Entity_Child_Base\",\"TKDT->Status from Doctors\",\"token\",\"sn\",\"\"]]', 2, '2021-05-20 01:04:10'),
(30359, 5918, 'APAD', '', 2, '2021-05-20 01:04:10'),
(30360, 5918, 'APCL', '', 2, '2021-05-20 01:04:10'),
(30361, 5918, 'APIH', '', 2, '2021-05-20 01:04:10'),
(30362, 5918, 'APMA', '', 2, '2021-05-20 01:04:11'),
(30363, 5918, 'APHT', '', 2, '2021-05-20 01:04:11'),
(30364, 5918, 'APHD', '', 2, '2021-05-20 01:04:11'),
(30365, 5918, 'APRO', '', 2, '2021-05-20 01:04:11'),
(30366, 5918, 'APEZ', '1', 2, '2021-05-20 01:04:11'),
(30367, 5918, 'ADXI', '', 2, '2021-05-20 01:04:11'),
(30368, 5918, 'ADXN', 'Status', 2, '2021-05-20 01:04:11'),
(30369, 5918, 'ADXH', '', 2, '2021-05-20 01:04:11'),
(30370, 5918, 'ADXC', '', 2, '2021-05-20 01:04:11'),
(30371, 5918, 'ADXF', '', 2, '2021-05-20 01:04:11'),
(30372, 5918, 'ADXJ', '', 2, '2021-05-20 01:04:11'),
(30373, 5918, 'ADXQ', '', 2, '2021-05-20 01:04:11'),
(30374, 5918, 'ADXS', '', 2, '2021-05-20 01:04:11'),
(30375, 5918, 'ADLO', '36', 2, '2021-05-20 01:04:11'),
(30376, 5919, 'APIT', 'ITTA', 2, '2021-05-20 01:05:15'),
(30377, 5919, 'APCL', '', 2, '2021-05-20 01:05:15'),
(30378, 5919, 'APIH', '', 2, '2021-05-20 01:05:15'),
(30379, 5919, 'APAL', 'x1000', 2, '2021-05-20 01:05:15'),
(30380, 5919, 'APMA', '', 2, '2021-05-20 01:05:15'),
(30381, 5919, 'APHT', '', 2, '2021-05-20 01:05:15'),
(30382, 5919, 'APHD', '', 2, '2021-05-20 01:05:15'),
(30383, 5919, 'APRO', '', 2, '2021-05-20 01:05:15'),
(30384, 5919, 'APEZ', '1', 2, '2021-05-20 01:05:15'),
(30385, 5919, 'ADXI', '', 2, '2021-05-20 01:05:15'),
(30386, 5919, 'ADXN', 'Doctors Remark', 2, '2021-05-20 01:05:15'),
(30387, 5919, 'ADXH', '', 2, '2021-05-20 01:05:15'),
(30388, 5919, 'ADXC', '', 2, '2021-05-20 01:05:15'),
(30389, 5919, 'ADXF', '', 2, '2021-05-20 01:05:15'),
(30390, 5919, 'ADXJ', '', 2, '2021-05-20 01:05:15'),
(30391, 5919, 'ADXQ', '', 2, '2021-05-20 01:05:15'),
(30392, 5919, 'ADXS', '', 2, '2021-05-20 01:05:15'),
(30393, 5919, 'ADLO', '37', 2, '2021-05-20 01:05:15'),
(30413, 5920, 'APIT', 'ITSL', 2, '2021-05-20 01:08:42'),
(30414, 5920, 'APSL', '[[\"user_info\",\"TKBD->Bed Detail\",\"id\",\"get_user_internal_name(id)\",\"get_users_role_code(id)=\'DTR\' \"]]', 2, '2021-05-20 01:08:42'),
(30415, 5920, 'APAD', '', 2, '2021-05-20 01:08:42'),
(30416, 5920, 'APCL', '', 2, '2021-05-20 01:08:43'),
(30417, 5920, 'APIH', '', 2, '2021-05-20 01:08:43'),
(30418, 5920, 'APMA', '', 2, '2021-05-20 01:08:43'),
(30419, 5920, 'APHT', '', 2, '2021-05-20 01:08:43'),
(30420, 5920, 'APHD', '', 2, '2021-05-20 01:08:43'),
(30421, 5920, 'APRO', '', 2, '2021-05-20 01:08:43'),
(30422, 5920, 'APEZ', '1', 2, '2021-05-20 01:08:43'),
(30423, 5920, 'ADXI', '', 2, '2021-05-20 01:08:43'),
(30424, 5920, 'ADXN', 'Doctor', 2, '2021-05-20 01:08:43'),
(30425, 5920, 'ADXH', '', 2, '2021-05-20 01:08:43'),
(30426, 5920, 'ADXC', '', 2, '2021-05-20 01:08:44'),
(30427, 5920, 'ADXF', '', 2, '2021-05-20 01:08:44'),
(30428, 5920, 'ADXJ', '', 2, '2021-05-20 01:08:44'),
(30429, 5920, 'ADXQ', '', 2, '2021-05-20 01:08:44'),
(30430, 5920, 'ADXS', '', 2, '2021-05-20 01:08:44'),
(30431, 5920, 'ADLO', '38', 2, '2021-05-20 01:08:44'),
(30449, 5921, 'APIT', 'ITHD', 2, '2021-05-20 01:10:05'),
(30450, 5921, 'APCL', '', 2, '2021-05-20 01:10:05'),
(30451, 5921, 'APIH', '', 2, '2021-05-20 01:10:05'),
(30452, 5921, 'APMA', '', 2, '2021-05-20 01:10:05'),
(30453, 5921, 'APHT', '', 2, '2021-05-20 01:10:05'),
(30454, 5921, 'APHD', '', 2, '2021-05-20 01:10:05'),
(30455, 5921, 'APRO', '', 2, '2021-05-20 01:10:05'),
(30456, 5921, 'APEZ', '', 2, '2021-05-20 01:10:05'),
(30457, 5921, 'ADXI', '', 2, '2021-05-20 01:10:06'),
(30458, 5921, 'ADXN', 'Doctors Section', 2, '2021-05-20 01:10:06'),
(30459, 5921, 'ADXH', '', 2, '2021-05-20 01:10:06'),
(30460, 5921, 'ADXC', '', 2, '2021-05-20 01:10:06'),
(30461, 5921, 'ADXF', '', 2, '2021-05-20 01:10:06'),
(30462, 5921, 'ADXJ', '', 2, '2021-05-20 01:10:06'),
(30463, 5921, 'ADXQ', '', 2, '2021-05-20 01:10:06'),
(30464, 5921, 'ADXS', '', 2, '2021-05-20 01:10:06'),
(30465, 5921, 'ADLO', '39', 2, '2021-05-20 01:10:06');

-- --------------------------------------------------------

--
-- Table structure for table `ecb_parent_child_matrix`
--

CREATE TABLE `ecb_parent_child_matrix` (
  `id` int(11) NOT NULL,
  `ecb_parent_id` int(11) DEFAULT NULL,
  `ecb_child_id` int(11) DEFAULT NULL,
  `parent_child_hash` varchar(32) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ecb_parent_child_matrix`
--

INSERT INTO `ecb_parent_child_matrix` (`id`, `ecb_parent_id`, `ecb_child_id`, `parent_child_hash`, `user_id`, `timestamp_punch`) VALUES
(2198, 2037, 2026, 'e89a83384d48a4ac572bc84fc468ed9d', 2, '2018-12-25 07:06:58'),
(2200, 2037, 2040, 'f68a5834818e3b481d2108e3fb0ea5a3', 2, '2018-12-25 07:06:58'),
(2201, 2037, 2039, '7f84cf049cd1ca1ec04c0150d4d0c356', 2, '2018-12-25 07:06:58'),
(2202, 2037, 2043, 'e9eb891ad083d2470230f6a4b61528ae', 2, '2018-12-25 07:06:58'),
(2203, 2037, 2041, 'db3aeab2d92092e5586b7375fd885ba0', 2, '2018-12-25 07:06:58'),
(2204, 2037, 2042, '2d4a92e779d30cc823a3feffafa56c8c', 2, '2018-12-25 07:06:58'),
(4232, 2300, 3061, '43594089a68bddb780b45e739738eb73', 2, '2019-01-28 13:00:50'),
(5235, 3593, 3594, 'ff2994e0f44eeea244785a9fe6407e41', 2, '2019-02-02 07:41:14'),
(6661, 4150, 2436, 'b3654e38846314860b9a60510c478f3a', 2, '2019-09-23 10:23:07'),
(6662, 4150, 2437, 'cbb604f270c2ed595351c3a47f33cdb3', 2, '2019-09-23 10:23:07'),
(7485, 4610, 4594, 'b59be050b0578b75e4c97e48fd3b1320', 2, '2019-10-01 10:45:35'),
(7486, 4610, 4595, '7ff1f1b8678d9c75c1beb589d08db922', 2, '2019-10-01 10:45:35'),
(7487, 4610, 4596, 'd605d0825e68f70be5298a11ccbe12be', 2, '2019-10-01 10:45:35'),
(7488, 4610, 4597, 'c4ad2e10184b22828add869da2394be1', 2, '2019-10-01 10:45:35'),
(7489, 4610, 4598, '6fa5c9ceba0f161cb86b04b67ff356ef', 2, '2019-10-01 10:45:35'),
(7490, 4610, 4599, '789cd92bb88c76b9b5358ddb9e9c1c79', 2, '2019-10-01 10:45:35'),
(7491, 4610, 4600, '9f1e575ac26c49c08b1c833c1f317c53', 2, '2019-10-01 10:45:35'),
(7492, 4610, 4601, '3cf97a8e0e5e530518368cd22ab1dfcb', 2, '2019-10-01 10:45:35'),
(7493, 4609, 4602, '27610bc3e414ce569e266affe2c63a80', 2, '2019-10-01 10:46:01'),
(7494, 4609, 4603, '22fd453a0b3548ac75a87f9cfd650ad1', 2, '2019-10-01 10:46:01'),
(7495, 4609, 4604, 'f497a2008ccdaf230cba2ba5eeb45e89', 2, '2019-10-01 10:46:01'),
(7496, 4609, 4605, 'f584b8b928890b8236e71c8923730f97', 2, '2019-10-01 10:46:01'),
(7497, 4611, 4606, 'cf4bb0a403b757112a7f9c1350fdf705', 2, '2019-10-01 10:46:27'),
(7498, 4611, 4607, 'cdcf0a6529d58dfe87fecbfc5758d914', 2, '2019-10-01 10:46:27'),
(7499, 4612, 4608, '8a39fcb52c7fe14267bc443521195710', 2, '2019-10-01 10:46:48'),
(9781, 5721, 578, '269db040dfeb4cb163a4446af077014f', 2, '2020-05-09 08:40:20'),
(9782, 5721, 576, '7c9f4391e68b69c33b09418cfaf2c8ca', 2, '2020-05-09 08:40:20'),
(9783, 5721, 577, '6bd92f5c394d9e0908aa316ed7ac077a', 2, '2020-05-09 08:40:20'),
(9784, 5722, 578, '55db10caca5f1e901a3ceee4167b977e', 2, '2020-05-09 08:40:20'),
(9785, 5722, 576, 'f0c6c3332323c88aa79683216acd46bc', 2, '2020-05-09 08:40:20'),
(9786, 5722, 577, 'bece94ec11cca935a734c07ae1a45838', 2, '2020-05-09 08:40:21'),
(9787, 5722, 2533, '3ca0c6902de0fcaa0de014d8ea13b8a9', 2, '2020-05-09 08:40:21'),
(9788, 5723, 578, 'bd750942058d43baee63606205bebb07', 2, '2020-05-09 08:40:21'),
(9789, 5723, 576, 'fc78742aa0ed4a7f584d2ac9fff179e0', 2, '2020-05-09 08:40:21'),
(9790, 5723, 577, 'edae18a5a8c4806897dc4f50813c2d42', 2, '2020-05-09 08:40:21'),
(9791, 5723, 2533, 'e2b462ebc3fd4893df8e060ff19ec962', 2, '2020-05-09 08:40:21'),
(9792, 5724, 576, '8b17aecfb717ab627e53958b71885b66', 2, '2020-05-09 08:40:21'),
(9793, 5724, 577, '33f561430390337e2bc077b8dfeb7cb5', 2, '2020-05-09 08:40:21'),
(9794, 5725, 574, '5a93ae3f104218f82a1a704836ced069', 2, '2020-05-09 08:40:22'),
(9795, 5725, 573, '523217d1492715b315ef9ad9ff401d21', 2, '2020-05-09 08:40:22'),
(9796, 5725, 575, 'b89f53699c010a0c5a473978753c751d', 2, '2020-05-09 08:40:22'),
(9797, 5725, 2532, '4a7501d09e2d7a2ee080ac8c9fc5332d', 2, '2020-05-09 08:40:22'),
(9798, 5726, 574, '1b38884589d076c5434c9a51b882532a', 2, '2020-05-09 08:40:22'),
(9799, 5726, 573, '717a86c8f1eebed29233bd516af24760', 2, '2020-05-09 08:40:22'),
(9800, 5726, 575, '635e793b1a352ebe2e26f2e13660fa3e', 2, '2020-05-09 08:40:22'),
(9801, 5727, 574, '1496191288e4215551886b1e12b6589c', 2, '2020-05-09 08:40:22'),
(9802, 5727, 573, '7e1f85e8db0eee3044d156183f71bde0', 2, '2020-05-09 08:40:23'),
(9803, 5727, 575, 'dedd11eef4cd5fd46bb6cf60d65956fd', 2, '2020-05-09 08:40:23'),
(9804, 5728, 2532, '6c8441a900c81612099f3414e11684ad', 2, '2020-05-09 08:40:23'),
(9805, 5729, 573, 'a0e9a7b4a2b2eefee7d8f677043bc1f9', 2, '2020-05-09 08:40:23'),
(9806, 5729, 575, '266750986b89eb34d1f4cec3c93aaa78', 2, '2020-05-09 08:40:23'),
(9809, 5731, 575, '78d8fe346aba67047650c982b8016228', 2, '2020-05-09 08:40:24'),
(9810, 5732, 574, '9e7bdba3c9083047eaaca00e63ce38bf', 2, '2020-05-09 08:40:24'),
(9811, 5732, 573, 'dce09fe755a34e80b6c4394a3f31fe50', 2, '2020-05-09 08:40:24'),
(9812, 5732, 575, 'db87b50f683864ec472577e30d0d26aa', 2, '2020-05-09 08:40:24'),
(9813, 5733, 2532, 'd8daebec040c9314b4162197eb81bc2e', 2, '2020-05-09 08:40:24'),
(9814, 5734, 574, '63135b7b314b7e4ccee840613ccceecd', 2, '2020-05-09 08:40:24'),
(9815, 5734, 573, 'a8b5a40a661c3ac5d7f43fc7fe59415c', 2, '2020-05-09 08:40:25'),
(9816, 5734, 575, 'a08dd899764e2bb9e864aac69f3709f1', 2, '2020-05-09 08:40:25'),
(9817, 5735, 574, '140b6b7253d224e6843cfbcc5a702fb2', 2, '2020-05-09 08:40:25'),
(9818, 5735, 573, 'd5413606dd54fd80ccec217a82dbfb89', 2, '2020-05-09 08:40:25'),
(9819, 5735, 575, '034347c3307e72fc52ac60298edda0cd', 2, '2020-05-09 08:40:25'),
(9820, 5736, 573, '1114b07838bb63eef061f9d7a5c5cb02', 2, '2020-05-09 08:40:26'),
(9821, 5736, 575, '9b9e1f7f925dc2f50442bef807e8ac40', 2, '2020-05-09 08:40:26'),
(9822, 5737, 574, '13df601acb7b60b46a549a7214dc0225', 2, '2020-05-09 08:40:26'),
(9823, 5737, 573, '4afab6a78abd233ad1dee1cb79671955', 2, '2020-05-09 08:40:26'),
(9824, 5737, 575, 'a8ed6927cc9287e5b51a8d1f6cc43a3a', 2, '2020-05-09 08:40:26'),
(9825, 5738, 574, 'efaf587a2dfb6201db39466730ffa649', 2, '2020-05-09 08:40:27'),
(9826, 5738, 573, '0e7c85928843e3061250236dd7405570', 2, '2020-05-09 08:40:27'),
(9827, 5738, 575, 'e4d429883e3413ab3b39e889ba565815', 2, '2020-05-09 08:40:27'),
(9828, 5739, 574, 'd97d555973465cd6fa137501436a0d5e', 2, '2020-05-09 08:40:27'),
(9829, 5739, 573, '8cc49a665aa1019d8e12d30e29d85cf7', 2, '2020-05-09 08:40:27'),
(9830, 5739, 575, '1cee094464ae8f04c339e871d2a82398', 2, '2020-05-09 08:40:27'),
(9831, 5740, 573, 'f098cd5efd172303e9d200d79624edb8', 2, '2020-05-09 08:40:27'),
(9832, 5741, 573, '010abbf86098d3a57015a7f0c62865ce', 2, '2020-05-09 08:40:27'),
(9833, 5741, 575, '136a038f76d8dbf44564f3930490afa7', 2, '2020-05-09 08:40:27'),
(9834, 5742, 574, '0e8435a3277802b459f743c0b1916797', 2, '2020-05-09 08:40:28'),
(9835, 5742, 573, '2bddaee4fb1bd7809bf3b8623ab6c126', 2, '2020-05-09 08:40:28'),
(9836, 5742, 575, '768bcf0619c8bb360ee2e81ca3ec739f', 2, '2020-05-09 08:40:28'),
(9837, 5743, 573, '2bb0e63b29389ef08ffacb6013fe42f8', 2, '2020-05-09 08:40:28'),
(9838, 5743, 575, '3c0d525d76d8111a05e7e0322d2649c4', 2, '2020-05-09 08:40:28'),
(9839, 5744, 574, '87d6f492809a38d850e1fd4021a867a0', 2, '2020-05-09 08:40:28'),
(9840, 5744, 573, 'e1d0ea8fcdb69ac200d4718b495caf11', 2, '2020-05-09 08:40:28'),
(9841, 5744, 575, '94febad790bc36a5f654074f09cb1e8a', 2, '2020-05-09 08:40:28'),
(9845, 5746, 574, 'f0ae1536e9d14976a2ce7da5c1a6ca39', 2, '2020-05-09 08:40:29'),
(9848, 5748, 573, 'fd68d37ab4a3709324e03ee4c335b1b3', 2, '2020-05-09 08:40:29'),
(9849, 5749, 573, '4bdc6c38b8992f6e7c16b74a55aef1bb', 2, '2020-05-09 08:40:30'),
(9850, 5749, 575, '1400badb13253e1f47fdcc14193d7492', 2, '2020-05-09 08:40:30'),
(9851, 5750, 573, '85ff503270e040568260af632a14644a', 2, '2020-05-09 08:40:30'),
(9852, 5750, 575, '4e645e28ed10fe6fc018017fd881676d', 2, '2020-05-09 08:40:30'),
(9853, 5751, 575, '9f586e81897ff5e7be21c7cf7669e00a', 2, '2020-05-09 08:40:31'),
(9854, 5752, 573, 'f182647d2d44116ed27c839ca7dcc6ac', 2, '2020-05-09 08:40:31'),
(9855, 5752, 575, '950b8c803a22b758d97ec1d0e8482507', 2, '2020-05-09 08:40:31'),
(9856, 5753, 2532, '1c80db828a868c7674d5f7b25c2f5c43', 2, '2020-05-09 08:40:31'),
(9857, 5754, 573, 'a4f368eac295110f2fbcdb2e27821d76', 2, '2020-05-09 08:40:32'),
(9858, 5754, 575, '1f2dd30cc08e755b8025e3f91187dc1c', 2, '2020-05-09 08:40:32'),
(9859, 5755, 573, '703c4c47b766fa4fb56f6cba34fe998a', 2, '2020-05-09 08:40:32'),
(9860, 5755, 575, '65cd03de937d51d1cb10c57b191d937a', 2, '2020-05-09 08:40:32'),
(9861, 5756, 573, '1ef42d2338de9319d2c65e259eba90bc', 2, '2020-05-09 08:40:32'),
(9862, 5756, 575, '274ce809af01b02a4c2c9452fed38235', 2, '2020-05-09 08:40:32'),
(9863, 5757, 573, 'fdd682e9f6c0520fe2c376d1b8f707b7', 2, '2020-05-09 08:40:33'),
(9864, 5757, 575, '1749337ad6440c8979cb6cb70fa5c923', 2, '2020-05-09 08:40:33'),
(9865, 5758, 573, '203c3a613e37ee6c885dd515b7dc8871', 2, '2020-05-09 08:40:34'),
(9866, 5758, 575, '407008e6f0b682ff06393245d57bc47b', 2, '2020-05-09 08:40:34'),
(9867, 5759, 573, 'c4f7a76d533d32c31bc5030487258fc6', 2, '2020-05-09 08:40:34'),
(9868, 5759, 575, 'aa13a687b4757b624075ddaa71b1e9f1', 2, '2020-05-09 08:40:34'),
(9869, 5760, 574, '34e59cee93052b526779daea58846294', 2, '2020-05-09 08:40:34'),
(9870, 5760, 573, 'ad8163e926f5633cade9908504b69399', 2, '2020-05-09 08:40:34'),
(9871, 5760, 575, '7773a624b12f2fe67ba723b5fc0d4373', 2, '2020-05-09 08:40:34'),
(9872, 5761, 573, '2ffeedd1d72bff4ca39d82ba72ff82e1', 2, '2020-05-09 08:40:35'),
(9873, 5761, 575, '0860bcae7b213e4ab497803d7808ac6d', 2, '2020-05-09 08:40:35'),
(9874, 5762, 573, '7758b0c18402ce65da845afb6c6e0f17', 2, '2020-05-09 08:40:35'),
(9875, 5762, 575, '9bff6feb5999cc723800af2192601cd2', 2, '2020-05-09 08:40:35'),
(9876, 5763, 573, 'e8e054663a5505f47c3eb44ed1da715b', 2, '2020-05-09 08:40:36'),
(9877, 5763, 575, 'a13af883a776672110457a4713630a0b', 2, '2020-05-09 08:40:36'),
(9878, 5764, 573, 'f6a493b8ef6b14b86c060917f15595c4', 2, '2020-05-09 08:40:36'),
(9879, 5764, 575, '3e613ba82a36d9b388866ab2a3357f97', 2, '2020-05-09 08:40:36'),
(9880, 5765, 2532, '03f3684f5de301283ac760f12575664f', 2, '2020-05-09 08:40:37'),
(9881, 5766, 573, 'f9b82860700a366c80be8501d7428c4c', 2, '2020-05-09 08:40:37'),
(9882, 5767, 574, '1d296be5f5f1b3bb0a1126de966b1cdf', 2, '2020-05-09 08:40:37'),
(9883, 5767, 573, 'ed64ea856375d86e9ea7063885f0230b', 2, '2020-05-09 08:40:37'),
(9884, 5767, 575, 'aef3d6be6149094861d5f1aba72f4312', 2, '2020-05-09 08:40:37'),
(9885, 5767, 2532, '562cb1bc3409ac2874fbe5eb913adce1', 2, '2020-05-09 08:40:37'),
(9886, 5768, 575, '36efee84b6d4c1fc647a156102873b02', 2, '2020-05-09 08:40:37'),
(9887, 5769, 573, '42c6c26f1529de4063772d5a7c7074bf', 2, '2020-05-09 08:40:38'),
(9888, 5769, 575, '270086e4e102cff8eac1932116ba4fc5', 2, '2020-05-09 08:40:38'),
(9889, 5770, 573, '8b50d6ca80ba3d9b5cb8b4ffd8c0b342', 2, '2020-05-09 08:40:38'),
(9890, 5770, 575, '1c01d92708e3aa6a630363978b68ebf3', 2, '2020-05-09 08:40:38'),
(9891, 5771, 2532, '2462fd6b5fb9f9be6536615e6e2b1cbb', 2, '2020-05-09 08:40:38'),
(9892, 5772, 575, 'cd1afd8e6911f5e5b4f1f740f6287f98', 2, '2020-05-09 08:40:39'),
(9893, 5773, 573, '9ad809eafcaf45b5282eae989bd52614', 2, '2020-05-09 08:40:39'),
(9894, 5773, 575, '83a27d5a5425d01fe7747006eeefea92', 2, '2020-05-09 08:40:39'),
(9895, 5774, 573, '4456701098ad2f9dd55c95a5568a0da4', 2, '2020-05-09 08:40:39'),
(9896, 5774, 575, '5054f98f48d7bb84fb5d186c952c112b', 2, '2020-05-09 08:40:39'),
(9897, 5775, 573, '195ff077991e8f673d6baaab00c8d4ad', 2, '2020-05-09 08:40:39'),
(9898, 5776, 574, '426be5d0e161914ed4440c02a3141cb9', 2, '2020-05-09 08:40:39'),
(9899, 5776, 573, 'dec58f4a65b400008062019473874366', 2, '2020-05-09 08:40:40'),
(9900, 5776, 575, 'c79c33ded2b916a0c8a3b7469c7fe10a', 2, '2020-05-09 08:40:40'),
(9901, 5776, 2532, 'e3c5985d48e74dedc11f7f3cabfea37d', 2, '2020-05-09 08:40:40'),
(9902, 5777, 573, '2f5f4cbff611db97e6ab50548f38e6d9', 2, '2020-05-09 08:40:40'),
(9903, 5777, 575, '1d5b62d1f0a8a7c1e47450ed5150ee36', 2, '2020-05-09 08:40:40'),
(9904, 5777, 2532, 'a58a39b528ac602641eb9ce2cb5f8717', 2, '2020-05-09 08:40:40'),
(9905, 5778, 573, '6faa7a543c7835459a9dd97ad140e77a', 2, '2020-05-09 08:40:41'),
(9906, 5778, 575, '4dad5498b82bed40aa4b360499e0afca', 2, '2020-05-09 08:40:41'),
(9907, 5778, 2532, '3ace06cc0f9827da6cbe70703cc9fd29', 2, '2020-05-09 08:40:41'),
(9908, 5779, 574, 'c5262f7d731f5b113919b04f5e488510', 2, '2020-05-09 08:40:41'),
(9909, 5779, 573, '650c914e7bebb36ba79b1de13858a038', 2, '2020-05-09 08:40:42'),
(9910, 5779, 575, 'ef92e677dd8317dbd956fecc352eb30d', 2, '2020-05-09 08:40:42'),
(9911, 5780, 573, 'd1e0274abb8f44fc5c7dc4f66deb74ae', 2, '2020-05-09 08:40:42'),
(9912, 5780, 575, '5046831ce6c45c35618be91f68f4736a', 2, '2020-05-09 08:40:42'),
(9913, 5781, 573, '7aac1bd053a379c00c6fc2a438a4bae6', 2, '2020-05-09 08:40:42'),
(9914, 5781, 575, 'dde499f92710634bcfd293551ad1cc8f', 2, '2020-05-09 08:40:43'),
(9915, 5782, 573, 'f4ef675e611b6da63b1af7271d6d9692', 2, '2020-05-09 08:40:43'),
(9916, 5782, 575, 'b0501931e87325280b93693f0df14a85', 2, '2020-05-09 08:40:43'),
(9921, 5720, 578, '1a9500d94ce57449694f6a4e9a4ccec1', 2, '2020-05-09 14:20:14'),
(9922, 5720, 576, '6ff4ad38e2f270ca8763eb54a2ed63cf', 2, '2020-05-09 14:20:14'),
(9923, 5720, 577, '04f1dd279695128b864e027977472f09', 2, '2020-05-09 14:20:14'),
(9924, 5720, 2533, 'cec6bf9b9112e52b06abfc9f798fe870', 2, '2020-05-09 14:20:14'),
(9955, 5730, 573, '30f769e3c657a7a06f0d07466213b5f3', 2, '2020-05-10 00:10:12'),
(9956, 5730, 575, 'f4caf79fad29fbe8b1998f9659943c4b', 2, '2020-05-10 00:10:12'),
(9957, 5730, 2532, '06c90ca74f314d132a8ae2d5c641ac3f', 2, '2020-05-10 00:10:12'),
(9958, 5800, 2532, 'db0f40e231051253f2fb9914a483b84f', 2, '2020-05-10 00:11:14'),
(9974, 5806, 2532, 'b71e3615dfbc07c635bb15ea03e498a4', 2, '2020-05-11 11:05:20'),
(9977, 5836, 575, '19eafba68a0ecebfcdb8cb219206d0f5', 2, '2020-05-22 14:13:29'),
(9981, 5745, 574, '70ca47a58c2356b61ef8f4cb55b91134', 2, '2020-10-23 00:13:57'),
(9982, 5745, 573, 'e0bc1c421df9e30d4975dc974c310397', 2, '2020-10-23 00:13:57'),
(9983, 5745, 575, 'e7779cb4f147a914b650d369992d5190', 2, '2020-10-23 00:13:57'),
(9984, 5745, 2532, '8dcad62c7e983043bebe720a6334f077', 2, '2020-10-23 00:13:57'),
(9985, 5847, 2533, '49fddd0276edb06ad53f387293582ae5', 2, '2020-10-24 16:43:01'),
(9994, 5865, 578, '6f354f7c86e52902fb6dae2cb8ae4243', 2, '2021-05-19 18:13:05'),
(9995, 5865, 576, '867f8a7b81d6e346001d405483c1a399', 2, '2021-05-19 18:13:05'),
(9996, 5865, 577, '322d90352f61e23ee6a53803ae4ea4c9', 2, '2021-05-19 18:13:05'),
(9997, 5865, 2533, '13649e90adbe9366f81e6d3839fc22d6', 2, '2021-05-19 18:13:05');

-- --------------------------------------------------------

--
-- Table structure for table `entity`
--

CREATE TABLE `entity` (
  `id` int(11) NOT NULL,
  `code` varchar(4) DEFAULT NULL,
  `sn` varchar(64) DEFAULT NULL,
  `ln` varchar(1024) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_lib` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity`
--

INSERT INTO `entity` (`id`, `code`, `sn`, `ln`, `creation`, `user_id`, `timestamp_punch`, `is_lib`) VALUES
(1, 'MP', 'Master Panel', 'Master Panel', '2015-02-10 15:56:53', 2, '2018-12-25 07:06:58', 1),
(20, 'SL', 'System Log', 'System Log', '2015-02-10 15:56:53', 2, '2018-12-25 07:06:58', 1),
(22, 'PG', 'Page', 'Page', '2015-02-10 15:56:53', 2, '2018-12-25 07:06:58', 1),
(23, 'PL', 'Page Layout', 'Page Layout', '2015-02-10 15:56:53', 2, '2018-12-25 07:06:58', 1),
(30, 'MQ', 'Home Scroller', '=opeav__home_scroller', '2015-02-10 15:56:53', 2, '2018-12-26 13:55:06', 1),
(33, 'AT', 'Page Addon Type', 'Page Addon Type', '2017-04-27 14:57:18', 2, '2019-10-11 11:30:22', 1),
(34, 'AP', 'Input Attribute Properties', 'Attribute Properties', '2017-04-28 14:59:35', 2, '2020-01-26 08:44:56', 1),
(35, 'EA', 'Page Addon External Attributes', 'External Attributes', '2017-04-28 14:59:52', 2, '2020-01-26 08:45:55', 1),
(36, 'IT', 'Input Type', 'Input Type', '2017-04-28 15:00:07', 2, '2018-12-25 07:06:58', 1),
(47, 'HA', 'Home About Us', '=opeav__about_us', '2017-11-30 10:36:01', 2, '2018-12-25 07:06:58', 1),
(50, 'HB', 'Home Banner', '=opeav__home_banner', '2017-12-15 15:07:04', 2, '2018-12-25 07:06:58', 1),
(51, 'CO', 'Contact', '=opeav__contact_one_page', '2017-12-15 16:04:53', 2, '2018-12-25 07:06:58', 1),
(52, 'AC', 'Home Accordion', '=opeav__accordion', '2017-12-18 12:28:50', 2, '2019-10-11 11:40:50', 1),
(56, 'CH', 'Page Coach', 'Coach', '2017-12-23 10:27:15', 2, '2020-01-26 08:49:47', 1),
(60, 'OP', 'One Page Entity', 'One Page Entity', '2018-02-16 17:28:21', 2, '2018-12-25 07:06:58', 1),
(61, 'EB', 'Entity Child Base', 'Entity Child Base', '2018-02-17 11:49:30', 2, '2018-12-25 07:06:58', 1),
(65, 'TH', 'Theme', 'Theme', '2018-02-21 14:29:30', 2, '2018-12-25 07:06:58', 1),
(92, 'DF', 'Definition ', 'Definition ', '2018-03-20 12:13:45', 2, '2018-12-25 07:06:58', 1),
(93, 'EC', 'Entity Child', 'Entity Child', '2018-03-20 12:13:45', 2, '2018-12-25 07:06:58', 1),
(95, 'EG', 'Engine', 'Engine', '2018-03-20 12:13:45', 2, '2018-12-25 07:06:58', 1),
(148, 'GP', 'Entity Grouping', 'Entity Grouping', '2018-10-08 14:57:51', 2, '2018-12-25 07:06:58', 1),
(149, 'IS', 'Issue', 'Issue', '2018-10-10 15:54:10', 2, '2020-01-26 12:29:12', 0),
(150, 'IU', 'Issue status', 'Issue status', '2018-10-10 16:33:12', 2, '2020-01-26 12:29:34', 0),
(152, 'IP', 'Issue Priority', 'Issue Priority', '2018-10-10 16:34:13', 2, '2020-01-26 12:29:38', 0),
(154, 'DE', 'Demo', 'Demo', '2018-10-12 18:36:11', 2, '2018-12-25 07:06:58', 1),
(159, 'LX', 'Log Action', 'Log Actions', '2018-12-06 15:08:37', 2, '2018-12-27 07:51:21', 1),
(161, 'CX', 'Home Contact One page', '=opeav__contact_one_page', '2018-12-26 10:43:21', 2, '2019-10-11 11:45:09', 1),
(163, 'TP', 'Page Template Part', 'Page Template', '2019-01-08 15:55:43', 2, '2020-01-26 08:34:00', 1),
(165, 'SC', 'Page Section', 'Section', '2019-01-14 11:57:30', 2, '2020-01-26 12:30:48', 1),
(167, 'BE', 'Theme Blend', 'Blend', '2019-01-28 16:53:59', 2, '2019-10-11 11:41:25', 1),
(173, 'IM', 'Import Entity', NULL, '2020-04-22 04:29:30', 2, '2020-04-21 22:59:30', 1),
(231, 'FT', 'Demo Form EAV Check', NULL, '2020-10-19 11:55:30', 2, '2020-10-19 06:25:30', 0),
(232, 'TK', 'Ticket System', NULL, '2021-05-19 23:02:58', 2, '2021-05-19 17:32:58', 0),
(233, 'GN', 'Gender', NULL, '2021-05-19 23:03:25', 2, '2021-05-19 17:33:25', 0),
(234, 'TKCT', 'Covid Test Results', NULL, '2021-05-19 23:29:52', 2, '2021-05-19 17:59:52', 0),
(235, 'TKSC', 'SARA or Covid', NULL, '2021-05-20 00:16:01', 2, '2021-05-19 18:46:01', 0),
(236, 'TKTW', 'Testing Way', NULL, '2021-05-20 00:19:01', 2, '2021-05-19 18:49:01', 0),
(237, 'TKHH', 'Home or Hospital', NULL, '2021-05-20 05:16:39', 2, '2021-05-19 23:46:39', 0),
(238, 'TKBD', 'Bed Detail', NULL, '2021-05-20 05:17:34', 2, '2021-05-19 23:47:34', 0),
(239, 'TKTR', 'Ticket Transfer', NULL, '2021-05-20 05:17:49', 2, '2021-05-19 23:47:49', 0),
(240, 'TKHS', 'Hospitals', NULL, '2021-05-20 05:18:14', 2, '2021-05-19 23:48:14', 0),
(241, 'TKZN', 'Zone', NULL, '2021-05-20 05:18:39', 2, '2021-05-19 23:48:39', 0),
(242, 'TKHT', 'Hospital Type', NULL, '2021-05-20 05:31:42', 2, '2021-05-20 00:01:42', 0),
(243, 'TKSL', 'Speciality', NULL, '2021-05-20 06:11:49', 2, '2021-05-20 00:41:49', 0),
(244, 'YN', 'Yes or No', NULL, '2021-05-20 06:13:28', 2, '2021-05-20 00:43:28', 0),
(245, 'TKDT', 'Status from Doctors', NULL, '2021-05-20 06:15:22', 2, '2021-05-20 00:45:22', 0);

-- --------------------------------------------------------

--
-- Table structure for table `entity_attribute`
--

CREATE TABLE `entity_attribute` (
  `id` int(11) NOT NULL,
  `entity_code` varchar(4) DEFAULT NULL,
  `code` char(4) DEFAULT NULL,
  `sn` varchar(64) DEFAULT NULL,
  `ln` varchar(1024) DEFAULT NULL,
  `line_order` decimal(10,2) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity_attribute`
--

INSERT INTO `entity_attribute` (`id`, `entity_code`, `code`, `sn`, `ln`, `line_order`, `creation`, `user_id`, `timestamp_punch`) VALUES
(286, 'PG', 'PGKW', 'Page Keyword', 'Page Keyword', '1.00', '2017-04-10 15:14:01', 2, '2018-12-25 07:06:58'),
(287, 'PG', 'PGPD', 'Page Description', '', '2.00', '2017-04-10 15:48:07', 2, '2018-12-25 07:06:58'),
(290, 'PG', 'PGPL', 'Layout', 'Layout', '3.00', '2017-04-25 11:39:56', 2, '2018-12-25 07:06:58'),
(312, 'AP', 'APIT', 'Input Type', 'Input Type', '1.00', '2017-04-28 15:01:09', 2, '2018-12-25 07:06:58'),
(320, 'PG', 'PGIA', 'Image Addon 1', 'Image Addon 1', '2.00', '2017-05-16 16:25:10', 2, '2018-12-25 07:06:58'),
(321, 'PG', 'PGPT', 'Page Title', 'Page Title', '1.00', '2017-05-18 11:56:01', 2, '2018-12-25 07:06:58'),
(325, 'CH', 'CHDN', 'Coach Domain', 'Coach Domain', '1.00', '2018-02-17 11:09:41', 2, '2018-12-25 07:06:58'),
(329, 'PG', 'PGCH', 'Page Coach', 'Page Coach', '1.00', '2018-02-17 16:56:38', 2, '2018-12-25 07:06:58'),
(330, 'CO', 'COFN', 'Contact Name', 'Contact Name', '1.00', '2018-02-19 11:40:08', 2, '2018-12-25 07:06:58'),
(332, 'CO', 'COMB', 'Mobile', 'Mobile', '3.00', '2018-02-19 11:40:47', 2, '2018-12-25 07:06:58'),
(333, 'CO', 'COEM', 'Email', 'Email', '4.00', '2018-02-19 11:40:58', 2, '2018-12-25 07:06:58'),
(336, 'CH', 'CHTH', 'Coach Theme', 'Coach Theme', '2.00', '2018-02-21 14:31:09', 2, '2018-12-25 07:06:58'),
(337, 'PG', 'PGRD', 'Page Re-direction Code', 'Page Re-direction Code', '1.00', '2018-03-07 16:49:37', 2, '2018-12-25 07:06:58'),
(342, 'AP', 'APSL', 'Attribute Simple List Option ', 'Attribute Simple List Option ', '1.00', '2018-03-14 11:41:05', 2, '2018-12-25 07:06:58'),
(343, 'AP', 'APGO', 'Attribute Grid Options', 'Attribute Grid Options', '1.00', '2018-03-14 11:41:18', 2, '2018-12-25 07:06:58'),
(344, 'AP', 'APCL', 'Class ', 'Class ', '1.00', '2018-03-14 11:41:29', 2, '2018-12-25 07:06:58'),
(345, 'AP', 'APAL', 'Allow ', 'Allow ', '1.00', '2018-03-14 11:41:41', 2, '2018-12-25 07:06:58'),
(346, 'AP', 'APMA', 'Mandatory ', 'Mandatory ', '1.00', '2018-03-14 11:42:01', 2, '2018-12-25 07:06:58'),
(347, 'AP', 'APDD', 'Default Date', 'Default Date', '1.00', '2018-03-14 11:42:13', 2, '2018-12-25 07:06:58'),
(348, 'AP', 'APAD', 'Avoid Default Option', 'Avoid Default Option', '1.00', '2018-03-14 11:42:32', 2, '2018-12-25 07:06:58'),
(349, 'AP', 'APFR', 'Grid Rows', 'Grid Rows', '1.00', '2018-03-14 11:48:37', 2, '2018-12-25 07:06:58'),
(350, 'AP', 'APFO', 'Fiben Grid', 'Fiben Grid', '1.00', '2018-03-21 01:57:54', 2, '2018-12-25 07:06:58'),
(352, 'AP', 'APHD', 'Is Hide', 'Is Hide', '1.00', '2018-04-18 14:23:43', 2, '2018-12-25 07:06:58'),
(353, 'AP', 'APRO', 'Read Only', 'Read Only', '1.00', '2018-04-18 14:24:03', 2, '2018-12-25 07:06:58'),
(378, 'AP', 'APFN', 'Save File Name', 'Save File Name', '1.00', '2018-04-27 12:25:54', 2, '2018-12-25 07:06:58'),
(379, 'AP', 'APFP', 'File Name Prefix', 'File Name Prefix', '2.00', '2018-04-27 12:26:15', 2, '2018-12-25 07:06:58'),
(380, 'AP', 'APFS', 'Attribute File Suffix', 'Attribute File Suffix', '2.00', '2018-04-27 12:26:36', 2, '2018-12-25 07:06:58'),
(383, 'AP', 'APMD', 'Min Date', 'Min Date', '1.00', '2018-05-24 02:04:02', 2, '2018-12-25 07:06:58'),
(384, 'AP', 'APXD', 'Max Date', 'Max Date', '1.00', '2018-05-24 02:06:29', 2, '2018-12-25 07:06:58'),
(385, 'AP', 'APHT', 'Hint', 'Hint', '1.00', '2018-05-24 02:45:47', 2, '2018-12-25 07:06:58'),
(386, 'AP', 'APLO', 'File location', 'File location', '1.00', '2018-06-07 02:47:39', 2, '2018-12-25 07:06:58'),
(387, 'AP', 'APIS', 'Image size', 'Image size', '1.00', '2018-06-07 03:25:52', 2, '2018-12-25 07:06:58'),
(388, 'AP', 'APFX', 'File Allow Type', 'File Allow Type', '1.00', '2018-06-13 05:57:31', 2, '2018-12-25 07:06:58'),
(389, 'AP', 'APFM', 'File Maximum Size', 'File Maximum Size', '1.00', '2018-06-13 05:57:49', 2, '2018-12-25 07:06:58'),
(391, 'AP', 'APLC', 'Label content', 'Label content', '1.00', '2018-06-28 03:06:44', 2, '2018-12-25 07:06:58'),
(392, 'AP', 'APMY', 'Min Year', 'Min Year', '1.00', '2018-07-02 02:54:55', 2, '2018-12-25 07:06:58'),
(393, 'AP', 'APXY', 'Max Year', 'Max Year', '1.00', '2018-07-02 02:55:09', 2, '2018-12-25 07:06:58'),
(395, 'AP', 'APTS', 'Toggle Status Label', 'Toggle Status Label', '1.00', '2018-07-17 03:21:51', 2, '2018-12-25 07:06:58'),
(396, 'AP', 'APTN', 'Toggle On Label', 'Toggle On Label', '2.00', '2018-07-17 03:22:12', 2, '2018-12-25 07:06:58'),
(397, 'AP', 'APTF', 'Toggle Off Label', 'Toggle Off Label', '3.00', '2018-07-17 03:22:31', 2, '2018-12-25 07:06:58'),
(398, 'AP', 'APTD', 'Toggle Default', 'Toggle Default', '4.00', '2018-07-17 03:22:51', 2, '2018-12-25 07:06:58'),
(400, 'AP', 'APMR', 'Max row in fiben grid', 'Max row in fiben grid', '1.00', '2018-07-23 08:50:35', 2, '2018-12-25 07:06:58'),
(401, 'AP', 'APIH', 'Input HTML', 'Input HTML', '1.00', '2018-07-25 05:54:40', 2, '2018-12-25 07:06:58'),
(402, 'AP', 'APGR', 'Minimal Rows to Fill', 'Minimal Rows to Fill', '2.00', '2018-07-28 04:05:48', 2, '2018-12-25 07:06:58'),
(403, 'CH', 'CHTL', 'Coach Template', 'Coach Template', '2.00', '2018-08-14 02:37:32', 2, '2018-12-25 07:06:58'),
(404, 'AP', 'APTM', 'Template', '', '2.00', '2018-08-22 10:10:38', 2, '2018-12-25 07:06:58'),
(405, 'PG', 'PGHS', 'Page Home Section', 'Page Home Section', '0.00', '2018-09-26 01:21:58', 2, '2018-12-25 07:06:58'),
(408, 'GP', 'GPEN', 'Grouping Entity', 'Grouping Entity', '1.00', '2018-10-08 17:00:30', 2, '2018-12-25 07:06:58'),
(409, 'EC', 'ECSN', 'Short Name', 'Short Name', '0.00', '2018-10-11 17:11:37', 2, '2018-12-25 07:06:58'),
(410, 'EC', 'ECLN', 'Long Name', 'Long Name', '0.00', '2018-10-11 17:11:37', 2, '2018-12-25 07:06:58'),
(411, 'EC', 'ECDT', 'Detail', 'Detail', '0.00', '2018-10-11 17:11:37', 2, '2018-12-25 07:06:58'),
(412, 'EC', 'ECPR', 'Parent Id', 'Parent Id', '0.00', '2018-10-11 17:11:37', 2, '2018-12-25 07:06:58'),
(413, 'EC', 'ECCD', 'Code', 'Code', '0.00', '2018-10-11 17:11:37', 2, '2018-12-25 07:06:58'),
(414, 'EC', 'ECIA', 'Image A', 'Image A', '0.00', '2018-10-11 17:11:37', 2, '2018-12-25 07:06:58'),
(415, 'EC', 'ECIB', 'Image B', 'Image B', '0.00', '2018-10-11 17:11:37', 2, '2018-12-25 07:06:58'),
(416, 'EC', 'ECIC', 'Image C', 'Image C', '0.00', '2018-10-11 17:11:37', 2, '2018-12-25 07:06:58'),
(417, 'PG', 'PGIB', 'Page Image B', 'Page Image B', '2.00', '2018-10-11 17:59:23', 2, '2018-12-25 07:06:58'),
(418, 'PG', 'PGIC', 'Page Image C', 'Page Image C', '2.00', '2018-10-11 17:59:38', 2, '2018-12-25 07:06:58'),
(419, 'PG', 'PGAT', 'Page Addon Type', 'Page Addon Type', '1.00', '2018-10-11 18:00:00', 2, '2018-12-25 07:06:58'),
(420, 'CH', 'CHSN', 'Short name', 'Short name', '1.00', '2018-10-12 12:45:40', 2, '2018-12-25 07:06:58'),
(421, 'EC', 'ECSC', 'Status Code', 'Status Code', '1.00', '2018-10-12 17:28:10', 2, '2018-12-25 07:06:58'),
(423, 'PG', 'PGCD', 'Page Code', 'Page Code', '1.00', '2018-10-20 11:43:42', 2, '2018-12-25 07:06:58'),
(425, 'CH', 'CHCD', 'Coach Code', 'Coach Code', '1.00', '2018-10-20 18:04:02', 2, '2018-12-25 07:06:58'),
(430, 'CX', 'CXFN', 'Contact Name', 'Contact Name', '1.00', '2018-12-26 10:44:35', 2, '2018-12-26 05:14:35'),
(431, 'CX', 'CXMB', 'Mobile', 'Mobile', '2.00', '2018-12-26 10:44:52', 2, '2018-12-26 05:14:52'),
(432, 'CX', 'CXEM', 'Email', 'Email', '3.00', '2018-12-26 10:45:10', 2, '2018-12-26 05:15:10'),
(433, 'CX', 'CXLD', 'Landline', 'Landline', '4.00', '2018-12-26 10:45:33', 2, '2018-12-26 05:15:33'),
(434, 'CX', 'CXRA', ' Residential Address Line 1', ' Residential Address Line 1', '5.00', '2018-12-26 10:45:56', 2, '2018-12-26 05:15:56'),
(435, 'CX', 'CXGM', 'Google Map', 'Google Map', '5.00', '2018-12-26 10:46:12', 2, '2018-12-26 05:16:12'),
(436, 'CX', 'CXRB', 'Residential Address Line 2', 'Residential Address Line 2', '6.00', '2018-12-26 10:46:27', 2, '2018-12-26 05:16:27'),
(439, 'AP', 'APFH', 'Table Heading TMPL', 'Table Heading TMPL', '5.00', '2018-12-26 16:29:54', 2, '2018-12-26 10:59:54'),
(441, 'AT', 'ATKH', 'Addon Type Key hash', 'Addon Type Key hash', '1.00', '2019-01-03 19:01:47', 2, '2019-01-03 13:31:47'),
(442, 'PG', 'PGTM', 'Page Section Template', 'Page Section Template', '1.00', '2019-01-23 16:00:14', 2, '2019-01-23 10:30:14'),
(444, 'CH', 'CHIL', 'Coach Logo', 'Coach Logo', '2.00', '2019-09-12 14:20:47', 2, '2019-09-12 08:50:47'),
(445, 'CH', 'CHIF', 'Coach Favicon', 'Coach Favicon', '3.00', '2019-09-12 14:21:07', 2, '2019-09-12 08:51:07'),
(446, 'AT', 'ATTM', 'Addon Template', 'Addon Template', '2.00', '2019-09-23 15:20:35', 2, '2019-09-23 09:50:35'),
(447, 'IM', 'IMFL', 'Import XML File', '', '1.00', '2020-04-22 04:30:19', 2, '2020-04-21 23:00:19'),
(448, 'AP', 'ADXI', 'Is Desk Exists', '', '35.00', '2020-04-26 05:40:12', 2, '2020-04-26 00:10:12'),
(449, 'AP', 'ADXN', 'Desk Column Header Name', '', '36.00', '2020-04-26 05:41:00', 2, '2020-04-26 00:11:00'),
(450, 'AP', 'ADXH', 'Desk Col Header Attribute', '', '37.00', '2020-04-26 05:41:24', 2, '2020-04-26 00:11:24'),
(451, 'AP', 'ADXC', 'Desk Col Attribute', '', '38.00', '2020-04-26 05:41:44', 2, '2020-04-26 00:11:44'),
(452, 'AP', 'ADXF', 'Desk Col Filter Out', '', '39.00', '2020-04-26 05:42:04', 2, '2020-04-26 00:12:04'),
(453, 'AP', 'ADXJ', 'Desk Column JavaScript Call', '', '40.00', '2020-04-26 05:42:48', 2, '2020-04-26 00:12:48'),
(454, 'AP', 'ADXS', 'Desk Column Sort', '', '41.00', '2020-04-26 05:43:43', 2, '2020-04-26 00:13:43'),
(455, 'DF', 'DFTY', 'Definition Type', '', '1.00', '2020-05-09 12:42:50', 2, '2020-05-09 07:12:50'),
(456, 'AP', 'ADLO', 'Line Order', '', '1.00', '2020-05-09 12:42:50', 2, '2020-05-09 07:12:50'),
(457, 'AP', 'APEZ', 'Avoid Empty or Zero', '', '1.00', '2020-05-09 12:42:50', 2, '2020-05-09 07:12:50'),
(458, 'AP', 'ADXQ', 'Query', '', '1.00', '2021-05-10 13:50:00', 2, '2021-05-10 13:50:00'),
(459, 'CO', 'COEC', 'Employee Code', '', '4.00', '2021-05-20 07:28:45', 2, '2021-05-20 01:58:45');

-- --------------------------------------------------------

--
-- Table structure for table `entity_child`
--

CREATE TABLE `entity_child` (
  `id` int(11) NOT NULL,
  `entity_code` varchar(4) DEFAULT NULL,
  `line_order` decimal(10,2) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity_child`
--

INSERT INTO `entity_child` (`id`, `entity_code`, `line_order`, `creation`, `timestamp_punch`, `user_id`, `is_active`) VALUES
(1540, 'CO', '0.00', '2018-10-12 12:13:54', '2018-12-25 07:04:19', 2, 0),
(3576, 'HB', '2.00', '2018-10-19 13:13:12', '2018-12-25 07:27:46', 2, 1),
(3655, 'CH', '0.00', '2018-10-22 12:55:37', '2018-12-25 07:06:58', 2, 0),
(3865, 'CO', NULL, '2018-12-25 11:48:39', '2018-12-25 09:30:40', 2, 1),
(3872, 'HB', '1.00', '2018-12-25 14:55:17', '2018-12-25 10:57:41', 2, 1),
(3880, 'HB', '1.00', '2018-12-25 15:54:00', '2018-12-25 10:24:00', 2, 1),
(3894, 'HA', '4.00', '2018-12-25 16:15:10', '2019-11-14 12:14:28', 2, 1),
(3895, 'HA', '1.00', '2018-12-25 16:16:41', '2018-12-25 10:46:41', 2, 1),
(3946, 'CO', NULL, '2018-12-26 10:29:21', '2018-12-26 04:59:21', 2, 1),
(3947, 'CO', NULL, '2018-12-26 10:29:49', '2018-12-26 04:59:49', 2, 1),
(3948, 'CX', '7.00', '2018-12-26 11:10:28', '2021-02-17 11:57:32', 2, 0),
(3949, 'CX', NULL, '2018-12-26 11:11:06', '2018-12-26 05:41:06', 2, 1),
(3974, 'MQ', '2.00', '2018-12-26 19:20:00', '2019-11-14 12:13:08', 2, 0),
(3975, 'MQ', '1.00', '2018-12-26 19:33:13', '2018-12-26 14:03:13', 2, 1),
(4007, 'AC', '1.00', '2018-12-26 19:41:57', '2018-12-26 14:11:57', 2, 1),
(4223, 'MQ', '2.00', '2018-12-28 17:55:59', '2018-12-28 12:25:59', 2, 1),
(4224, 'MQ', '3.00', '2018-12-28 17:56:09', '2018-12-28 12:26:09', 2, 1),
(4412, 'TH', '0.00', '2019-01-29 10:51:04', '2019-01-29 05:21:04', 2, 1),
(4618, 'AC', '6.00', '2019-02-01 17:58:57', '2019-11-14 12:15:18', 2, 1),
(4626, 'AC', '1.00', '2019-02-01 18:00:55', '2019-02-01 12:30:55', 2, 1),
(4627, 'AC', '1.00', '2019-02-01 18:01:36', '2019-02-01 12:31:36', 2, 1),
(4628, 'AC', '2.00', '2019-02-01 18:02:08', '2019-02-01 12:32:08', 2, 1),
(4636, 'AC', '2.00', '2019-02-01 18:03:15', '2019-02-01 12:33:15', 2, 1),
(5009, 'BE', NULL, '2019-09-28 19:49:06', '2019-09-28 14:19:06', 2, 1),
(5118, 'SC', '1.00', '2019-11-14 17:28:44', '2019-11-14 11:58:44', 2, 1),
(5144, 'PG', '2.00', '2020-01-11 12:29:38', '2021-03-03 05:49:10', 2, 1),
(5145, 'IM', NULL, '2020-04-22 04:56:05', '2020-04-21 23:26:05', 2, 1),
(5146, 'IM', NULL, '2020-04-22 04:57:20', '2020-04-21 23:27:20', 2, 1),
(5147, 'IM', NULL, '2020-04-22 04:58:42', '2020-04-21 23:28:42', 2, 1),
(5148, 'IM', NULL, '2020-04-22 05:05:28', '2020-04-21 23:35:28', 2, 1),
(5149, 'IM', NULL, '2020-04-22 05:09:54', '2020-04-21 23:39:54', 2, 1),
(5150, 'IM', NULL, '2020-04-22 05:10:24', '2020-04-21 23:40:24', 2, 1),
(5151, 'IM', NULL, '2020-04-22 05:11:16', '2020-04-21 23:41:16', 2, 1),
(5152, 'IM', NULL, '2020-04-22 05:11:47', '2020-04-21 23:41:47', 2, 1),
(5153, 'IM', NULL, '2020-04-22 05:12:04', '2020-04-21 23:42:04', 2, 1),
(5154, 'IM', NULL, '2020-04-22 05:13:14', '2020-04-21 23:43:14', 2, 1),
(5155, 'IM', NULL, '2020-04-22 05:14:08', '2020-04-21 23:44:08', 2, 1),
(5156, 'IM', NULL, '2020-04-22 05:18:14', '2020-04-21 23:48:14', 2, 1),
(5157, 'IM', NULL, '2020-04-22 05:18:50', '2020-04-21 23:48:50', 2, 1),
(5158, 'IM', NULL, '2020-04-22 05:19:30', '2020-04-21 23:49:30', 2, 1),
(5159, 'IM', NULL, '2020-04-22 05:21:43', '2020-04-21 23:51:43', 2, 1),
(5160, 'IM', NULL, '2020-04-22 05:27:26', '2020-04-21 23:57:26', 2, 1),
(5161, 'IM', NULL, '2020-04-22 05:28:06', '2020-04-21 23:58:06', 2, 1),
(5162, 'IM', NULL, '2020-04-22 05:29:50', '2020-04-21 23:59:50', 2, 1),
(5163, 'IM', NULL, '2020-04-22 05:30:27', '2020-04-22 00:00:27', 2, 1),
(5164, 'IM', NULL, '2020-04-22 05:42:07', '2020-04-22 00:12:07', 2, 1),
(5165, 'IM', NULL, '2020-04-22 05:44:26', '2020-04-22 00:14:26', 2, 1),
(5166, 'IM', NULL, '2020-04-22 05:44:42', '2020-04-22 00:14:42', 2, 1),
(5167, 'IM', NULL, '2020-04-22 05:46:35', '2020-04-22 00:16:35', 2, 1),
(5168, 'IM', NULL, '2020-04-22 05:47:28', '2020-04-22 00:17:28', 2, 1),
(5169, 'IM', NULL, '2020-04-22 06:03:28', '2020-04-22 00:33:28', 2, 1),
(5170, 'IM', NULL, '2020-04-22 06:04:24', '2020-04-22 00:34:24', 2, 1),
(5171, 'IM', NULL, '2020-04-22 06:05:52', '2020-04-22 00:35:52', 2, 1),
(5172, 'IM', NULL, '2020-04-22 06:06:33', '2020-04-22 00:36:33', 2, 1),
(5173, 'IM', NULL, '2020-04-22 06:13:55', '2020-04-22 00:43:55', 2, 1),
(5174, 'IM', NULL, '2020-04-22 06:18:09', '2020-04-22 00:48:09', 2, 1),
(5175, 'IM', NULL, '2020-04-22 06:18:39', '2020-04-22 00:48:39', 2, 1),
(5176, 'IM', NULL, '2020-04-22 06:19:04', '2020-04-22 00:49:04', 2, 1),
(5177, 'IM', NULL, '2020-04-22 06:20:25', '2020-04-22 00:50:25', 2, 1),
(5178, 'IM', NULL, '2020-04-22 06:24:42', '2020-04-22 00:54:42', 2, 1),
(5179, 'IM', NULL, '2020-04-22 06:26:03', '2020-04-22 00:56:03', 2, 1),
(5180, 'IM', NULL, '2020-04-22 06:27:18', '2020-04-22 00:57:18', 2, 1),
(5181, 'IM', NULL, '2020-04-22 06:29:00', '2020-04-22 00:59:00', 2, 1),
(5182, 'IM', NULL, '2020-04-22 06:30:11', '2020-04-22 01:00:11', 2, 1),
(5183, 'IM', NULL, '2020-04-23 05:09:31', '2020-04-22 23:39:31', 2, 1),
(5184, 'IM', NULL, '2020-04-23 05:22:03', '2020-04-22 23:52:03', 2, 1),
(5185, 'IM', NULL, '2020-04-23 05:39:08', '2020-04-23 00:09:08', 2, 1),
(5186, 'IM', NULL, '2020-04-23 05:39:38', '2020-04-23 00:09:38', 2, 1),
(5187, 'IM', NULL, '2020-04-23 05:40:33', '2020-04-23 00:10:33', 2, 1),
(5188, 'IM', NULL, '2020-04-23 05:40:56', '2020-04-23 00:10:56', 2, 1),
(5189, 'IM', NULL, '2020-04-23 05:41:14', '2020-04-23 00:11:14', 2, 1),
(5190, 'IM', NULL, '2020-04-23 05:42:43', '2020-04-23 00:12:43', 2, 1),
(5191, 'IM', NULL, '2020-04-23 05:44:37', '2020-04-23 00:14:37', 2, 1),
(5192, 'IM', NULL, '2020-04-23 05:46:35', '2020-04-23 00:16:35', 2, 1),
(5193, 'IM', NULL, '2020-04-23 05:47:48', '2020-04-23 00:17:48', 2, 1),
(5194, 'IM', NULL, '2020-04-23 05:51:27', '2020-04-23 00:21:27', 2, 1),
(5195, 'IM', NULL, '2020-04-23 05:54:29', '2020-04-23 00:24:29', 2, 1),
(5196, 'IM', NULL, '2020-04-23 06:03:49', '2020-04-23 00:33:49', 2, 1),
(5197, 'IM', NULL, '2020-04-23 06:09:54', '2020-04-23 00:39:54', 2, 1),
(5198, 'IM', NULL, '2020-04-23 06:12:43', '2020-04-23 00:42:43', 2, 1),
(5199, 'IM', NULL, '2020-04-23 06:13:55', '2020-04-23 00:43:55', 2, 1),
(5200, 'IM', NULL, '2020-04-23 06:14:39', '2020-04-23 00:44:39', 2, 1),
(5201, 'IM', NULL, '2020-04-23 06:16:36', '2020-04-23 00:46:36', 2, 1),
(5202, 'IM', NULL, '2020-04-23 06:23:48', '2020-04-23 00:53:48', 2, 1),
(5203, 'IM', NULL, '2020-04-23 06:25:16', '2020-04-23 00:55:16', 2, 1),
(5204, 'IM', NULL, '2020-04-23 06:28:05', '2020-04-23 00:58:05', 2, 1),
(5205, 'IM', NULL, '2020-04-23 06:30:07', '2020-04-23 01:00:07', 2, 1),
(5206, 'IM', NULL, '2020-04-23 06:31:58', '2020-04-23 01:01:58', 2, 1),
(5207, 'IM', NULL, '2020-04-23 06:32:44', '2020-04-23 01:02:44', 2, 1),
(5208, 'IM', NULL, '2020-04-23 06:34:13', '2020-04-23 01:04:13', 2, 1),
(5209, 'IM', NULL, '2020-04-23 06:35:49', '2020-04-23 01:05:49', 2, 1),
(5232, 'IM', NULL, '2020-05-22 16:30:07', '2020-05-22 11:00:07', 2, 1),
(5233, 'IM', NULL, '2020-05-22 16:40:17', '2020-05-22 11:10:17', 2, 1),
(5234, 'IM', NULL, '2020-05-22 16:42:38', '2020-05-22 11:12:38', 2, 1),
(5235, 'IM', NULL, '2020-05-22 16:43:42', '2020-05-22 11:13:42', 2, 1),
(5236, 'IM', NULL, '2020-05-22 16:44:35', '2020-05-22 11:14:35', 2, 1),
(5237, 'IM', NULL, '2020-05-22 16:45:32', '2020-05-22 11:15:32', 2, 1),
(5238, 'IM', NULL, '2020-05-22 16:50:56', '2020-05-22 11:20:56', 2, 1),
(5239, 'IM', NULL, '2020-05-22 16:52:51', '2020-05-22 11:22:51', 2, 1),
(5240, 'IM', NULL, '2020-05-22 16:54:08', '2020-05-22 11:24:08', 2, 1),
(5241, 'IM', NULL, '2020-05-22 16:54:32', '2020-05-22 11:24:32', 2, 1),
(5242, 'IM', NULL, '2020-05-22 16:54:57', '2020-05-22 11:24:57', 2, 1),
(5243, 'IM', NULL, '2020-05-22 16:55:08', '2020-05-22 11:25:08', 2, 1),
(5244, 'IM', NULL, '2020-05-22 16:55:14', '2020-05-22 11:25:14', 2, 1),
(5245, 'IM', NULL, '2020-05-22 16:55:36', '2020-05-22 11:25:36', 2, 1),
(5246, 'IM', NULL, '2020-05-22 16:55:55', '2020-05-22 11:25:55', 2, 1),
(5247, 'IM', NULL, '2020-05-22 16:56:35', '2020-05-22 11:26:35', 2, 1),
(5248, 'IM', NULL, '2020-05-22 16:56:57', '2020-05-22 11:26:57', 2, 1),
(5249, 'IM', NULL, '2020-05-22 16:58:03', '2020-05-22 11:28:03', 2, 1),
(5250, 'IM', NULL, '2020-05-22 17:04:36', '2020-05-22 11:34:36', 2, 1),
(5251, 'IM', NULL, '2020-05-22 17:07:49', '2020-05-22 11:37:49', 2, 1),
(5252, 'IM', NULL, '2020-05-22 17:10:42', '2020-05-22 11:40:42', 2, 1),
(5253, 'IM', NULL, '2020-05-22 17:12:31', '2020-05-22 11:42:31', 2, 1),
(5254, 'IM', NULL, '2020-05-22 17:18:48', '2020-05-22 11:48:48', 2, 1),
(5255, 'IM', NULL, '2020-05-22 19:02:23', '2020-05-22 13:32:23', 2, 1),
(5257, 'IM', NULL, '2020-05-22 19:14:08', '2020-05-22 13:44:08', 2, 1),
(5258, 'IM', NULL, '2020-05-22 19:15:21', '2020-05-22 13:45:21', 2, 1),
(5259, 'IM', NULL, '2020-05-22 19:20:11', '2020-05-22 13:50:11', 2, 1),
(5260, 'IM', NULL, '2020-05-22 19:30:11', '2020-05-22 14:00:11', 2, 1),
(5261, 'IM', NULL, '2020-05-22 19:44:27', '2020-05-22 14:14:27', 2, 1),
(5262, 'PG', '1.00', '2020-06-15 16:51:57', '2021-03-02 09:56:14', 2, 1),
(5264, 'PG', '3.00', '2020-06-15 17:59:10', '2021-03-03 05:56:15', 2, 1),
(5265, 'SC', '1.00', '2020-06-15 18:02:37', '2020-06-15 12:32:37', 2, 1),
(5267, 'IM', NULL, '2020-09-02 21:16:01', '2020-09-02 15:46:01', 2, 1),
(5268, 'IM', NULL, '2020-10-19 11:55:29', '2020-10-19 06:25:29', 2, 1),
(5269, 'PG', NULL, '2021-02-17 17:27:37', '2021-02-17 11:57:37', 2, 1),
(5270, 'PG', NULL, '2021-02-17 17:27:37', '2021-02-17 11:57:37', 2, 0),
(5271, 'PG', NULL, '2021-02-17 17:27:38', '2021-02-17 11:57:38', 2, 0),
(5272, 'PG', NULL, '2021-02-17 17:27:38', '2021-02-17 11:57:38', 2, 0),
(5273, 'PG', NULL, '2021-02-17 17:27:38', '2021-02-17 11:57:38', 2, 0),
(5274, 'SC', '2.00', '2021-03-03 11:08:15', '2021-03-03 05:38:15', 2, 1),
(5275, 'SC', '3.00', '2021-03-03 11:09:12', '2021-03-03 05:39:12', 2, 1),
(5276, 'FT', NULL, '2021-05-19 22:43:15', '2021-05-19 17:13:15', 2, 1),
(5282, 'TKZN', NULL, '2021-05-20 05:27:55', '2021-05-19 23:57:55', 2, 1),
(5283, 'TKZN', NULL, '2021-05-20 05:28:07', '2021-05-19 23:58:07', 2, 1),
(5571, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5572, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5573, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5574, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5575, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5576, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5577, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5578, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5579, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5580, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5581, 'TKHS', NULL, '2021-05-20 07:25:55', '2021-05-20 01:55:55', 2, 1),
(5582, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5583, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5584, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5585, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5586, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5587, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5588, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5589, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5590, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5591, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5592, 'TKHS', NULL, '2021-05-20 07:25:56', '2021-05-20 01:55:56', 2, 1),
(5593, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5594, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5595, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5596, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5597, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5598, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5599, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5600, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5601, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5602, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5603, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5604, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5605, 'TKHS', NULL, '2021-05-20 07:25:57', '2021-05-20 01:55:57', 2, 1),
(5606, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5607, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5608, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5609, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5610, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5611, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5612, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5613, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5614, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5615, 'TKHS', NULL, '2021-05-20 07:25:58', '2021-05-20 01:55:58', 2, 1),
(5616, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5617, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5618, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5619, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5620, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5621, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5622, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5623, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5624, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5625, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5626, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5627, 'TKHS', NULL, '2021-05-20 07:25:59', '2021-05-20 01:55:59', 2, 1),
(5628, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5629, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5630, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5631, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5632, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5633, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5634, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5635, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5636, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5637, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5638, 'TKHS', NULL, '2021-05-20 07:26:00', '2021-05-20 01:56:00', 2, 1),
(5639, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5640, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5641, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5642, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5643, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5644, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5645, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5646, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5647, 'TKHS', NULL, '2021-05-20 07:26:01', '2021-05-20 01:56:01', 2, 1),
(5648, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5649, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5650, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5651, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5652, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5653, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5654, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5655, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5656, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5657, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5658, 'TKHS', NULL, '2021-05-20 07:26:02', '2021-05-20 01:56:02', 2, 1),
(5659, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5660, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5661, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5662, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5663, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5664, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5665, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5666, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5667, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5668, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5669, 'TKHS', NULL, '2021-05-20 07:26:03', '2021-05-20 01:56:03', 2, 1),
(5670, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5671, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5672, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5673, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5674, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5675, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5676, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5677, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5678, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5679, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5680, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5681, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5682, 'TKHS', NULL, '2021-05-20 07:26:04', '2021-05-20 01:56:04', 2, 1),
(5683, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5684, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5685, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5686, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5687, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5688, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5689, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5690, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5691, 'TKHS', NULL, '2021-05-20 07:26:05', '2021-05-20 01:56:05', 2, 1),
(5692, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5693, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5694, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5695, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5696, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5697, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5698, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5699, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5700, 'TKHS', NULL, '2021-05-20 07:26:06', '2021-05-20 01:56:06', 2, 1),
(5701, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5702, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5703, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5704, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5705, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5706, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5707, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5708, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5709, 'TKHS', NULL, '2021-05-20 07:26:07', '2021-05-20 01:56:07', 2, 1),
(5710, 'TKHS', NULL, '2021-05-20 07:26:08', '2021-05-20 01:56:08', 2, 1),
(5711, 'TKHS', NULL, '2021-05-20 07:26:08', '2021-05-20 01:56:08', 2, 1),
(5712, 'TKHS', NULL, '2021-05-20 07:26:08', '2021-05-20 01:56:08', 2, 1),
(5730, 'CO', NULL, '2021-05-20 08:22:40', '2021-05-20 02:52:40', 2, 1),
(5731, 'CO', NULL, '2021-05-20 08:22:40', '2021-05-20 02:52:40', 2, 1),
(5732, 'CO', NULL, '2021-05-20 08:22:40', '2021-05-20 02:52:40', 2, 1),
(5733, 'CO', NULL, '2021-05-20 08:22:40', '2021-05-20 02:52:40', 2, 1),
(5734, 'CO', NULL, '2021-05-20 08:22:40', '2021-05-20 02:52:40', 2, 1),
(5735, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5736, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5737, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5738, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5739, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5740, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5741, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5742, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5743, 'CO', NULL, '2021-05-20 08:22:41', '2021-05-20 02:52:41', 2, 1),
(5744, 'CO', NULL, '2021-05-20 08:22:42', '2021-05-20 02:52:42', 2, 1),
(5745, 'CO', NULL, '2021-05-20 08:22:42', '2021-05-20 02:52:42', 2, 1),
(5746, 'CO', NULL, '2021-05-20 08:22:42', '2021-05-20 02:52:42', 2, 1),
(5747, 'CO', NULL, '2021-05-20 08:22:42', '2021-05-20 02:52:42', 2, 1),
(5748, 'CO', NULL, '2021-05-20 08:22:42', '2021-05-20 02:52:42', 2, 1),
(5749, 'CO', NULL, '2021-05-20 08:22:42', '2021-05-20 02:52:42', 2, 1),
(5750, 'CO', NULL, '2021-05-20 08:22:42', '2021-05-20 02:52:42', 2, 1),
(5751, 'CO', NULL, '2021-05-20 08:22:42', '2021-05-20 02:52:42', 2, 1),
(5752, 'CO', NULL, '2021-05-20 08:22:43', '2021-05-20 02:52:43', 2, 1),
(5753, 'CO', NULL, '2021-05-20 08:22:43', '2021-05-20 02:52:43', 2, 1),
(5754, 'CO', NULL, '2021-05-20 08:22:43', '2021-05-20 02:52:43', 2, 1),
(5755, 'CO', NULL, '2021-05-20 08:22:43', '2021-05-20 02:52:43', 2, 1),
(5756, 'CO', NULL, '2021-05-20 08:22:44', '2021-05-20 02:52:44', 2, 1),
(5757, 'CO', NULL, '2021-05-20 08:22:44', '2021-05-20 02:52:44', 2, 1),
(5758, 'CO', NULL, '2021-05-20 08:22:44', '2021-05-20 02:52:44', 2, 1),
(5759, 'CO', NULL, '2021-05-20 08:22:44', '2021-05-20 02:52:44', 2, 1),
(5760, 'CO', NULL, '2021-05-20 08:22:44', '2021-05-20 02:52:44', 2, 1),
(5761, 'CO', NULL, '2021-05-20 08:22:44', '2021-05-20 02:52:44', 2, 1),
(5762, 'CO', NULL, '2021-05-20 08:22:44', '2021-05-20 02:52:44', 2, 1),
(5763, 'CO', NULL, '2021-05-20 08:22:45', '2021-05-20 02:52:45', 2, 1),
(5764, 'CO', NULL, '2021-05-20 08:22:45', '2021-05-20 02:52:45', 2, 1),
(5765, 'CO', NULL, '2021-05-20 08:22:45', '2021-05-20 02:52:45', 2, 1),
(5766, 'CO', NULL, '2021-05-20 08:22:45', '2021-05-20 02:52:45', 2, 1),
(5767, 'CO', NULL, '2021-05-20 08:22:45', '2021-05-20 02:52:45', 2, 1),
(5768, 'CO', NULL, '2021-05-20 08:22:45', '2021-05-20 02:52:45', 2, 1),
(5769, 'CO', NULL, '2021-05-20 08:22:45', '2021-05-20 02:52:45', 2, 1),
(5770, 'CO', NULL, '2021-05-20 08:22:46', '2021-05-20 02:52:46', 2, 1),
(5771, 'CO', NULL, '2021-05-20 08:22:46', '2021-05-20 02:52:46', 2, 1),
(5772, 'CO', NULL, '2021-05-20 08:22:46', '2021-05-20 02:52:46', 2, 1),
(5773, 'CO', NULL, '2021-05-20 08:22:46', '2021-05-20 02:52:46', 2, 1),
(5774, 'CO', NULL, '2021-05-20 08:22:46', '2021-05-20 02:52:46', 2, 1),
(5775, 'CO', NULL, '2021-05-20 08:22:46', '2021-05-20 02:52:46', 2, 1),
(5776, 'CO', NULL, '2021-05-20 08:22:46', '2021-05-20 02:52:46', 2, 1),
(5777, 'CO', NULL, '2021-05-20 08:22:46', '2021-05-20 02:52:46', 2, 1),
(5778, 'CO', NULL, '2021-05-20 08:22:47', '2021-05-20 02:52:47', 2, 1),
(5779, 'CO', NULL, '2021-05-20 08:22:47', '2021-05-20 02:52:47', 2, 1),
(5780, 'CO', NULL, '2021-05-20 08:22:47', '2021-05-20 02:52:47', 2, 1),
(5781, 'CO', NULL, '2021-05-20 08:22:47', '2021-05-20 02:52:47', 2, 1),
(5782, 'CO', NULL, '2021-05-20 08:22:47', '2021-05-20 02:52:47', 2, 1),
(5783, 'CO', NULL, '2021-05-20 08:22:47', '2021-05-20 02:52:47', 2, 1),
(5784, 'CO', NULL, '2021-05-20 08:22:48', '2021-05-20 02:52:48', 2, 1),
(5785, 'CO', NULL, '2021-05-20 08:22:48', '2021-05-20 02:52:48', 2, 1),
(5786, 'CO', NULL, '2021-05-20 08:22:48', '2021-05-20 02:52:48', 2, 1),
(5787, 'CO', NULL, '2021-05-20 08:22:48', '2021-05-20 02:52:48', 2, 1),
(5788, 'CO', NULL, '2021-05-20 08:22:48', '2021-05-20 02:52:48', 2, 1),
(5789, 'CO', NULL, '2021-05-20 08:22:48', '2021-05-20 02:52:48', 2, 1),
(5790, 'CO', NULL, '2021-05-20 08:22:48', '2021-05-20 02:52:48', 2, 1),
(5791, 'CO', NULL, '2021-05-20 08:22:48', '2021-05-20 02:52:48', 2, 1),
(5792, 'CO', NULL, '2021-05-20 08:22:49', '2021-05-20 02:52:49', 2, 1),
(5793, 'CO', NULL, '2021-05-20 08:22:49', '2021-05-20 02:52:49', 2, 1),
(5794, 'CO', NULL, '2021-05-20 08:22:49', '2021-05-20 02:52:49', 2, 1),
(5795, 'CO', NULL, '2021-05-20 08:22:49', '2021-05-20 02:52:49', 2, 1),
(5796, 'CO', NULL, '2021-05-20 08:22:49', '2021-05-20 02:52:49', 2, 1),
(5797, 'CO', NULL, '2021-05-20 08:22:50', '2021-05-20 02:52:50', 2, 1),
(5798, 'CO', NULL, '2021-05-20 08:22:50', '2021-05-20 02:52:50', 2, 1),
(5799, 'CO', NULL, '2021-05-20 08:22:50', '2021-05-20 02:52:50', 2, 1),
(5800, 'CO', NULL, '2021-05-20 08:22:50', '2021-05-20 02:52:50', 2, 1),
(5801, 'CO', NULL, '2021-05-20 08:22:50', '2021-05-20 02:52:50', 2, 1),
(5802, 'CO', NULL, '2021-05-20 08:22:50', '2021-05-20 02:52:50', 2, 1),
(5803, 'CO', NULL, '2021-05-20 08:22:51', '2021-05-20 02:52:51', 2, 1),
(5804, 'CO', NULL, '2021-05-20 08:22:51', '2021-05-20 02:52:51', 2, 1),
(5805, 'CO', NULL, '2021-05-20 08:22:51', '2021-05-20 02:52:51', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `entity_child_base`
--

CREATE TABLE `entity_child_base` (
  `id` int(11) NOT NULL,
  `entity_code` varchar(4) DEFAULT NULL,
  `token` varchar(32) DEFAULT NULL,
  `sn` varchar(64) DEFAULT NULL,
  `ln` varchar(1024) DEFAULT NULL,
  `note` text,
  `parent_id` int(11) DEFAULT NULL,
  `dna_code` varchar(32) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `creation` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `line_order` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity_child_base`
--

INSERT INTO `entity_child_base` (`id`, `entity_code`, `token`, `sn`, `ln`, `note`, `parent_id`, `dna_code`, `created_by`, `creation`, `line_order`, `is_active`, `user_id`, `timestamp_punch`) VALUES
(573, 'EG', 'd', 'Global(d_series)', 'Global(d_series)', '', 0, 'EBAX', 1, '2018-03-20 12:14:50', '0.00', 1, 2, '2020-01-20 17:48:19'),
(574, 'EG', 'a', 'Global(a_series)', 'Global(a_series)', '', 0, 'EBAX', 1, '2018-03-20 12:14:50', '0.00', 1, 2, '2020-01-20 17:47:43'),
(575, 'EG', 'f', 'Global(f_series)', 'Global(f_series)', '', 0, 'EBAX', 1, '2018-03-20 12:14:50', '0.00', 1, 2, '2020-01-20 17:48:53'),
(576, 'EG', 'dx', 'Custom(d_series)', 'Custom(d_series)', '', 0, 'EBAX', 1, '2018-03-20 12:14:50', '0.00', 1, 2, '2020-01-20 17:48:38'),
(577, 'EG', 'fx', 'Custom(f_series)', 'Custom(f_series)', '', 0, 'EBAX', 1, '2018-03-20 12:14:50', '0.00', 1, 2, '2020-01-20 17:49:10'),
(578, 'EG', 'ax', 'Custom(a_series)', 'Custom(a_series)', '', 0, 'EBAX', 1, '2018-03-20 12:14:50', '0.00', 1, 2, '2020-01-20 17:47:58'),
(804, 'OP', 'OPSS', 'One Page Section Status', 'One Page Section Status', '', NULL, 'EBAT', 0, '2018-07-16 06:23:04', '0.00', 1, 2, '2018-12-25 07:06:59'),
(1139, 'GP', 'FIBN', 'Fibenis', 'Fibenis', 'SL', NULL, 'EBUC', 0, '2018-10-09 17:41:30', '0.00', 1, 2, '2019-10-11 08:06:19'),
(1140, 'IS', 'ISNA', 'Name', 'Name', '', NULL, 'EBUC', 0, '2018-10-10 15:54:47', '1.00', 1, 2, '2018-12-25 07:06:59'),
(1141, 'IS', 'ISDS', 'Description', 'Description', '', NULL, 'EBUC', 0, '2018-10-10 15:55:06', '2.00', 1, 2, '2018-12-25 07:06:59'),
(1142, 'IS', 'ISRO', 'Raised On', 'Raised On', '', NULL, 'EBUC', 0, '2018-10-10 15:55:26', '3.00', 1, 2, '2018-12-25 07:06:59'),
(1143, 'IS', 'ISKD', 'Kind', 'Kind', '', NULL, 'EBUC', 0, '2018-10-10 15:55:43', '4.00', 1, 2, '2018-12-25 07:06:59'),
(1144, 'IS', 'ISPI', 'Priority', 'Priority', '', NULL, 'EBUC', 0, '2018-10-10 15:55:59', '5.00', 1, 2, '2018-12-25 07:06:59'),
(1145, 'IS', 'ISST', 'Status', 'Status', '', NULL, 'EBUC', 0, '2018-10-10 15:56:22', '6.00', 1, 2, '2018-12-25 07:06:59'),
(1146, 'IS', 'ISSO', 'Source', 'Source', '', NULL, 'EBUC', 0, '2018-10-10 15:57:34', '7.00', 1, 2, '2018-12-25 07:06:59'),
(1147, 'IP', 'IPMI', 'Minor', 'Minor', '', NULL, 'EBMS', 0, '2018-10-10 16:35:50', '1.00', 1, 2, '2018-12-25 07:06:59'),
(1149, 'IP', 'IPMA', 'Major', 'Major', '', NULL, 'EBMS', 0, '2018-10-10 16:37:08', '3.00', 1, 2, '2018-12-25 07:06:59'),
(1150, 'IP', 'IPCR', 'Critical', 'Critical', '', NULL, 'EBMS', 0, '2018-10-10 16:37:33', '4.00', 1, 2, '2018-12-25 07:06:59'),
(1153, 'IU', 'IUOP', 'Open', 'Open', 'IUIP', NULL, 'EBMS', 0, '2018-10-10 17:21:51', '1.00', 1, 2, '2018-12-25 07:06:59'),
(1154, 'IU', 'IUIP', 'In-Progress', 'In-Progress', 'IUTE', NULL, 'EBMS', 0, '2018-10-10 17:22:57', '2.00', 1, 2, '2018-12-25 07:06:59'),
(1155, 'IU', 'IUTE', 'To be Tested', 'To be Tested', 'IUCM,IURO', NULL, 'EBMS', 0, '2018-10-10 17:23:27', '3.00', 1, 2, '2018-12-25 07:06:59'),
(1156, 'IU', 'IURO', 'Reopen', 'Reopen', 'IUIP', NULL, 'EBMS', 0, '2018-10-10 17:23:55', '4.00', 1, 2, '2018-12-25 07:06:59'),
(1157, 'IU', 'IUCM', 'Completed', 'Completed', '', NULL, 'EBMS', 0, '2018-10-10 17:24:20', '5.00', 1, 2, '2018-12-25 07:06:59'),
(1210, 'GP', 'CMST', 'CMS', 'Content Management System', 'HA,AC,HB,PG', NULL, 'EBUC', 0, '2018-10-13 15:07:56', '0.00', 1, 2, '2020-02-27 07:51:53'),
(2025, 'LX', 'VIEW', 'View', 'Page View', '', 0, 'EBMS', 0, '2018-12-06 15:09:15', '1.00', 1, 2, '2019-10-01 07:19:52'),
(2026, 'LX', 'AAKY', 'Key Login', 'Key Login', '', 0, 'EBMS', 0, '2018-12-06 15:33:15', '2.00', 1, 2, '2018-12-25 07:06:59'),
(2036, 'LX', 'PAGE', 'Page View', NULL, '2025', NULL, 'EBAX', 0, '2018-12-07 12:51:24', '0.00', 1, 2, '2018-12-25 07:06:59'),
(2037, 'LX', 'GATE', 'Gate Actions', NULL, '2026,2038,2040,2039,2043,2041,2042', NULL, 'EBAX', 0, '2018-12-07 13:04:38', '0.00', 1, 2, '2018-12-25 07:06:59'),
(2038, 'LX', 'AAKV', 'AAKV', 'Login Detail Verification', '', 0, 'EBMS', 0, '2018-12-07 13:08:42', '2.00', 1, 2, '2019-10-01 07:19:28'),
(2039, 'LX', 'ACKY', 'ACKY', 'Check Password', '', 0, 'EBMS', 0, '2018-12-07 13:09:02', '3.00', 1, 2, '2018-12-25 07:06:59'),
(2040, 'LX', 'ACHP', 'ACHP', 'Change Password', '', 0, 'EBMS', 0, '2018-12-07 13:09:23', '4.00', 1, 2, '2018-12-25 07:06:59'),
(2041, 'LX', 'AFGK', 'AFGK', 'Forget Password', '', 0, 'EBMS', 0, '2018-12-07 13:09:44', '5.00', 1, 2, '2018-12-25 07:06:59'),
(2042, 'LX', 'AGTO', 'AGTO', 'Log Out', '', 0, 'EBMS', 0, '2018-12-07 13:10:04', '6.00', 1, 2, '2018-12-25 07:06:59'),
(2043, 'LX', 'ACUE', 'ACUE', 'Check user exists', '', 0, 'EBMS', 0, '2018-12-07 13:11:53', '7.00', 1, 2, '2018-12-25 07:06:59'),
(2046, 'DE', 'DETX', 'Text', 'Text', '', 0, 'EBFA', NULL, '2018-12-25 17:22:31', '1.00', NULL, 2, '2020-01-26 07:38:28'),
(2047, 'DE', 'DETA', 'Textarea', 'Textarea', '', 0, 'EBFA', NULL, '2018-12-25 17:22:46', '2.00', NULL, 2, '2020-01-26 07:38:28'),
(2048, 'DE', 'DEDC', 'Decimal', 'Decimal', '', 0, 'EBFA', NULL, '2018-12-25 17:23:05', '3.00', NULL, 2, '2020-01-26 07:38:28'),
(2049, 'DE', 'DEIM', 'Image', 'Image', '', 0, 'EBFA', NULL, '2018-12-25 17:23:19', '4.00', NULL, 2, '2020-01-26 07:38:28'),
(2050, 'DE', 'DEDU', 'Documents', 'Documents', '', 0, 'EBFA', NULL, '2018-12-25 17:23:50', '5.00', NULL, 2, '2020-01-26 07:38:28'),
(2051, 'DE', 'DEOS', 'Option single', 'Option single', '', 0, 'EBFA', NULL, '2018-12-25 17:24:10', '6.00', NULL, 2, '2020-01-26 07:38:28'),
(2052, 'DE', 'DEOM', 'Option multiple', 'Option multiple', '', 0, 'EBFA', NULL, '2018-12-25 17:24:29', '7.00', NULL, 2, '2020-01-26 07:38:28'),
(2053, 'DE', 'DEFT', 'Fiben table', 'Fiben table', '', 0, 'EBFA', NULL, '2018-12-25 17:24:51', '8.00', NULL, 2, '2020-01-26 07:38:28'),
(2054, 'DE', 'DEDT', 'Date', 'Date', '', 0, 'EBFA', NULL, '2018-12-25 17:25:07', '9.00', NULL, 2, '2020-01-26 07:38:28'),
(2055, 'DE', 'DERG', 'Range', 'Range', '', 0, 'EBFA', NULL, '2018-12-25 17:25:19', '10.00', NULL, 2, '2020-01-26 07:38:28'),
(2056, 'DE', 'DETS', 'Toggle switch', 'Toggle switch', '', 0, 'EBFA', NULL, '2018-12-25 17:25:34', '11.00', NULL, 2, '2020-01-26 07:38:28'),
(2057, 'DE', 'DEAU', 'Autocomplete', 'Autocomplete', '', 0, 'EBFA', NULL, '2018-12-25 17:25:49', '12.00', NULL, 2, '2020-01-26 07:38:28'),
(2061, 'DE', 'DELR', 'Let right', 'Let right', '', 0, 'EBFA', NULL, '2018-12-26 16:48:03', '13.00', 1, 2, '2020-01-26 07:38:28'),
(2062, 'DE', 'DETE', 'Text Editor', 'Text Editor', '', 0, 'EBFA', NULL, '2018-12-26 16:48:25', '14.00', 1, 2, '2020-01-26 07:38:28'),
(2063, 'DE', 'DECE', 'Code Editor', 'Code Editor', '', 0, 'EBFA', NULL, '2018-12-26 16:48:46', '15.00', 1, 2, '2020-01-26 07:38:28'),
(2176, 'EA', 'FEAT', 'Features', '', '', NULL, 'EBAT', NULL, '2018-12-27 13:32:58', '1.00', 1, 2, '2019-09-19 12:46:34'),
(2290, 'AT', 't', 'template__basic', 'Basic Template', '', NULL, NULL, NULL, '2019-01-02 19:05:06', NULL, 1, 2, '2019-01-03 13:23:26'),
(2298, 'PL', 'layout_right', 'Layout Right', 'Layout Right', '  <!---<TMPL_VAR PAGE_ID>\r\n      <TMPL_VAR PAGE_TITLE>\r\n      <TMPL_VAR PARENT_KEY_CODE>\r\n      <TMPL_VAR PARENT_NAME>\r\n      <TMPL_VAR PARENT_RIGHT_IMAGE>\r\n      <TMPL_VAR PARENT_HEADER_IMAGE>\r\n      <TMPL_VAR PAGE_HEADER_IMAGE>\r\n      <TMPL_VAR PAGE_RIGHT_IMAGE>\r\n      <TMPL_VAR SIDE_MENU>\r\n      <TMPL_VAR MENU_NAME>\r\n      <TMPL_VAR CODE>\r\n  --->\r\n\r\n    <TMPL_IF PAGE_TITLE>\r\n  \r\n    <div class=\"page-banner no-subtitle bg_clr_gray_e\"\r\n	  <TMPL_IF PAGE_HEADER_IMAGE>\r\n	    style=\"background: url(<TMPL_VAR PAGE_HEADER_IMAGE>)\"\r\n	  <TMPL_ELSE>\r\n	    <TMPL_IF PARENT_HEADER_IMAGE>\r\n	    style=\"background: url(<TMPL_VAR PARENT_HEADER_IMAGE>)\"\r\n	    </TMPL_IF>\r\n	  </TMPL_IF> \r\n	>     \r\n      <div class=\"container \">\r\n	  <div class=\"row\">\r\n	    <div class=\"col-md-6\">&nbsp;	      \r\n	    </div>\r\n	    <div class=\"col-md-6 align_RM\">\r\n	      <ul class=\"breadcrumb\">\r\n	      <li><a href=\"?<TMPL_VAR PARENT_KEY_CODE>\"><TMPL_VAR PARENT_NAME></a></li>\r\n	      <li><TMPL_VAR PAGE_TITLE></li>\r\n	      </ul>\r\n	    </div>\r\n	  </div>\r\n      </div>\r\n    </div>\r\n    \r\n    </TMPL_IF>\r\n    <!-- End Page Banner -->\r\n    \r\n    \r\n    <div id=\"content\">\r\n	<div class=\"container\">	\r\n	    <div class=\"page-content\">\r\n	        <div class=\"row pad_lr\">\r\n			<div class=\"col-md-12 pad_lr\">\r\n			    <!-- Page Content--->\r\n			    <div class=\"col-md-9  brdr_right_light \">\r\n			        <TMPL_IF PAGE_TITLE>\r\n				  <h4 class=\"classic-title\">\r\n				    <span><TMPL_VAR PAGE_TITLE></span>\r\n				  </h4>\r\n				</TMPL_IF>		  									\r\n			    \r\n				<TMPL_VAR PAGE_INFO>\r\n			    </div>\r\n			    \r\n			    <!--- Side bar--->	\r\n			    <div class=\"col-md-3 sidebar right-sidebar\"  id=\"sidebar\">				    \r\n				      \r\n				      <div class=\"widget widget-categories\">					   \r\n					<ul>\r\n					    <!---right image--->\r\n					    <TMPL_IF PAGE_RIGHT_IMAGE>\r\n					         <li>\r\n						    <a class=\"brdr_bottom  brdr_width_2 brdr_clr_gray_f\" >	\r\n						      <img src=\"<TMPL_VAR PAGE_RIGHT_IMAGE>\" class=\"img-responsive\">\r\n						    </a>\r\n						  </li>      					     \r\n					    <TMPL_ELSE>\r\n						<TMPL_IF PARENT_RIGHT_IMAGE>\r\n						  <li>\r\n						    <a class=\"brdr_bottom  brdr_width_2 brdr_clr_gray_f\" >	\r\n						      <img src=\"<TMPL_VAR PARENT_RIGHT_IMAGE>\" class=\"img-responsive\">\r\n						    </a>\r\n						  </li>      \r\n						</TMPL_IF>  				    \r\n					    </TMPL_IF>\r\n					    <TMPL_LOOP SIDE_MENU>												  \r\n						  <li>\r\n						    <a href=\"<TMPL_IF REDIRECT_URL><TMPL_VAR REDIRECT_URL><TMPL_ELSE>?<TMPL_VAR code></TMPL_IF>\" id=\"<TMPL_VAR code>\" class=\"col-md-12\" >						    \r\n							<TMPL_IF IS_NO_CONTENT>\r\n							  <div class=\"col-md-9\"><TMPL_VAR MENU_NAME></div>\r\n							  <div class=\"col-md-3\"><span class=\"badge clr_box_light_green pad_5_tb txt_size_13\" >&nbsp;<b><TMPL_VAR NO_DATA></b>&nbsp;</span></div>\r\n							<TMPL_ELSE>\r\n							  <TMPL_VAR MENU_NAME>\r\n							</TMPL_IF>  \r\n						    </a>\r\n						  </li>\r\n					    </TMPL_LOOP>\r\n					</ul>\r\n				      </div>\r\n			    </div> <!--end of sidebar-->			    \r\n			</div><!--- inner container--->\r\n		</div><!--/row-->\r\n	    </div><!--page- content-->\r\n	</div><!--container-->\r\n    </div><!--- Content--->  \r\n       ', 2300, NULL, NULL, '2019-01-05 13:54:29', NULL, 1, 2, '2019-01-05 15:08:17'),
(2300, 'TH', 'ml', 'Margo Lite', 'Margo Lite', '', NULL, 'EBMS', NULL, '2019-01-05 18:31:07', '1.00', 1, 2, '2019-01-05 13:27:22'),
(2428, 'TP', 'footer', 'footer', 'Footer', '<!---<TMPL_VAR LIB_PATH><TMPL_VAR TERMINAL_PATH><TMPL_VAR PAGE_TITLE><TMPL_VAR CURRENT_YEAR><TMPL_VAR THEME_ROUTE><TMPL_VAR DEFAULT_FOOTER>--->\r\n      \r\n	\r\n<TMPL_UNLESS IS_USER>	\r\n	<footer>\r\n	 \r\n	  <div class=\"container\">\r\n	    <div class=\"row footer-widgets\">    	\r\n	      \r\n	      <div class=\"copyright-section\">	      \r\n		\r\n		<div class=\"row\">		\r\n		  \r\n		  <div class=\"col-md-9\">\r\n		    <p>&copy; <TMPL_VAR CURRENT_YEAR> </p>\r\n		    <span id=\"footer\"><TMPL_VAR DEFAULT_FOOTER></span>\r\n		  </div>		  \r\n		  \r\n		  <div class=\"col-md-3\">\r\n		    <ul class=\"footer-nav\">\r\n		      <li></li>		  \r\n		    </ul>\r\n		  </div>	\r\n		</div>	  \r\n	      </div>\r\n	    </div>\r\n	  </div>\r\n	  \r\n	</footer>\r\n    \r\n	</TMPL_UNLESS>\r\n	<!---Test--->\r\n	\r\n	\r\n	<a href=\"#\" class=\"back-to-top\"><i class=\"fa fa-angle-up\"></i></a>\r\n		 \r\n	<script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/script.js\"></script>       \r\n        \r\n	<script language=\"JavaScript\" type=\"text/javascript\">\r\n            \r\n	    if(document.getElementById(\'<TMPL_VAR PAGE_ID>\')!=undefined){            \r\n	       document.getElementById(\'<TMPL_VAR PAGE_ID>\').className=\'active\';\r\n	    }\r\n	    \r\n            $(function() {\r\n	\r\n		  <TMPL_IF COACH_ADDON>\r\n			 <TMPL_LOOP COACH_ADDON>			\r\n				  ELEMENT(\'<TMPL_VAR BINDER>\').innerHTML=\'<TMPL_VAR CONTENT>\';\r\n			  </TMPL_LOOP>\r\n		  </TMPL_IF> \r\n   	      \r\n		  $(\"a[rel^=\'prettyPhoto\']\").prettyPhoto({\r\n		      theme: \"pp_default\",\r\n		      social_tools: false		  \r\n		      });	      \r\n	      \r\n		    <TMPL_IF IS_HOME>\r\n		    </TMPL_IF>\r\n		    \r\n		    <TMPL_IF SIGN_EMAIL>	   \r\n			$(\'#myModalSignIn\').modal(\'show\');		      \r\n			$(\'#inputEmail\').val(\'<TMPL_VAR SIGN_EMAIL>\');		      		    \r\n		    </TMPL_IF>\r\n		   \r\n		    <TMPL_IF SIGNUP_EMAIL>		   		      \r\n			$(\'#myModal_signUp\').modal(\'show\');		      \r\n			$(\'#singUpinputEmail\').val(\'<TMPL_VAR SIGNUP_EMAIL>\');			\r\n		    </TMPL_IF>\r\n		    \r\n		    modal_hide_events();\r\n                    \r\n                    \r\n                    \r\n                    $.validate({\r\n                        \r\n                                form : \'#enquiry_form\',\r\n                    \r\n                                //modules : \'location, date, security, file\',\r\n                                onSuccess : function($form) {\r\n                                                \r\n                                                var enquiry = new ajax();\r\n                                                    \r\n                                                var form_data = new Object({\"a\":G.$(\'a\').value,\r\n                                                                            \"b\":G.$(\'b\').value,\r\n                                                                            \"c\":G.$(\'c\').value,\r\n                                                                            \"d\":G.$(\'d\').value,\r\n                                                                           });    \r\n                                                    \r\n                                                enquiry.set_request(\'router.php\',\'&series=a&action=enquiry&token=NESC\'+\r\n                                                                                 \'&param=\'+JSON.stringify(form_data));\r\n                                                                                   \r\n                                                enquiry.send_get(enquiry_response);\r\n                                                \r\n                                                 G.showLoader(\'Sending your request..\');\r\n                                                \r\n                                                return false; // Will stop the submission of the form\r\n                                            \r\n                                } // end\r\n                    });\r\n                                                \r\n                                                \r\n                    // query\r\n                    \r\n                    function enquiry_response(response){\r\n                        \r\n                            if(response==1){\r\n                                G.hideLoader();\r\n                                G.bs_alert_success(\'Thanks for your query.\');\r\n                            }\r\n                    } //\r\n		  \r\n		    \r\n		    \r\n		   \r\n            });\r\n   \r\n		    function modal_signup(){\r\n					\r\n					$(\'#myModal_signUp\').modal();\r\n					\r\n		    }	\r\n</script>\r\n', 2300, NULL, NULL, '2019-01-08 18:01:47', NULL, 1, 2, '2019-09-30 11:50:26'),
(2436, 'EA', 'TEXT', 'Text', 'Text', '', NULL, 'EBAT', NULL, '2019-01-09 13:17:02', '2.00', 1, 2, '2019-02-02 13:03:16'),
(2437, 'EA', 'TEAR', 'Text Area ', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:24:42', '3.00', 1, 2, '2019-02-02 13:04:28'),
(2438, 'EA', 'TEED', 'Text Area Editor', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:25:25', '4.00', 1, 2, '2019-02-02 13:05:03'),
(2439, 'EA', 'NUMB', 'Number', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:37:48', '5.00', 1, 2, '2019-02-02 13:02:48'),
(2440, 'EA', 'RANG', 'range', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:38:59', '6.00', 1, 2, '2019-01-09 08:08:59'),
(2441, 'EA', 'HEAD', 'Documents', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:39:37', '7.00', 1, 2, '2019-09-19 14:06:20'),
(2442, 'EA', 'DATE', 'date', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:44:11', '8.00', 1, 2, '2019-01-09 08:14:11'),
(2444, 'EA', 'LABL', 'label', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:46:57', '9.00', 1, 2, '2019-01-09 08:16:57'),
(2445, 'EA', 'TWBX', 'twin_box', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:47:31', '10.00', 1, 2, '2019-01-09 08:17:31'),
(2448, 'EA', 'INTE', 'integer', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:54:44', '13.00', 1, 2, '2019-01-09 08:24:44'),
(2449, 'EA', 'TOSW', 'toogle_switch', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:55:39', '14.00', 1, 2, '2019-01-09 08:25:39'),
(2450, 'EA', 'UPIM', 'upload_image', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:58:06', '15.00', 1, 2, '2019-01-09 08:28:06'),
(2451, 'EA', 'UPDC', 'upload_document', '', '', NULL, 'EBAT', NULL, '2019-01-09 13:59:21', '16.00', 1, 2, '2019-01-09 08:29:21'),
(2532, 'EG', 't', 'Global(t_series)', 'Global(t_series)', '', 0, 'EBAX', NULL, '2019-01-11 11:01:49', '0.00', 1, 2, '2020-01-20 17:50:28'),
(2533, 'EG', 'tx', 'Custom(t_series)', 'Custom(t_series)', '', 0, 'EBAX', NULL, '2019-01-11 11:02:02', '0.00', 1, 2, '2020-01-20 17:50:42'),
(2597, 'PL', 'layout_basic', 'Layout Basic', '', '	<!---<TMPL_VAR PAGE_ID>\r\n	    <TMPL_VAR PAGE_TITLE>\r\n	    <TMPL_VAR PARENT_KEY_CODE>\r\n	    <TMPL_VAR PARENT_NAME>\r\n	    <TMPL_VAR PARENT_RIGHT_IMAGE>\r\n	    <TMPL_VAR PARENT_HEADER_IMAGE>\r\n	    <TMPL_VAR PAGE_HEADER_IMAGE>\r\n	    <TMPL_VAR PAGE_RIGHT_IMAGE>\r\n	    <TMPL_VAR SIDE_MENU>\r\n	    <TMPL_VAR MENU_NAME>\r\n	    <TMPL_VAR CODE>\r\n	--->\r\n\r\n	<div class=\"container\">	\r\n	        <div class=\"row pad_lr\">					    			    \r\n			<TMPL_VAR PAGE_INFO>			    \r\n		</div>\r\n	</div>', 2300, NULL, NULL, '2019-01-11 11:19:04', NULL, 1, 2, '2019-01-11 05:49:04'),
(2598, 'PL', 'layout_page', 'Layout Page', '', '\r\n      <!---<TMPL_VAR PAGE_ID>\r\n      <TMPL_VAR PAGE_TITLE>\r\n      <TMPL_VAR PARENT_KEY_CODE>\r\n      <TMPL_VAR PARENT_NAME>\r\n      <TMPL_VAR PARENT_RIGHT_IMAGE>\r\n      <TMPL_VAR PARENT_HEADER_IMAGE>\r\n      <TMPL_VAR PAGE_HEADER_IMAGE>\r\n      <TMPL_VAR PAGE_RIGHT_IMAGE>\r\n      <TMPL_VAR SIDE_MENU>\r\n      <TMPL_VAR MENU_NAME>\r\n      <TMPL_VAR CODE>\r\n  --->\r\n  \r\n  \r\n  <TMPL_IF PAGE_TITLE>\r\n  \r\n    <div class=\"page-banner no-subtitle bg_clr_gray_e\"\r\n	  <TMPL_IF PAGE_HEADER_IMAGE>\r\n	    style=\"background: url(<TMPL_VAR PAGE_HEADER_IMAGE>)\"\r\n	  <TMPL_ELSE>\r\n	    <TMPL_IF PARENT_HEADER_IMAGE>\r\n	    style=\"background: url(<TMPL_VAR PARENT_HEADER_IMAGE>)\"\r\n	    </TMPL_IF>\r\n	  </TMPL_IF> \r\n	>     \r\n      <div class=\"container \">\r\n	  <div class=\"row\">\r\n	    <div class=\"col-md-6\">&nbsp;	      \r\n	    </div>\r\n	    <div class=\"col-md-6 align_RM\">\r\n	      <ul class=\"breadcrumb\">\r\n	      <li><a href=\"?<TMPL_VAR PARENT_KEY_CODE>\"><TMPL_VAR PARENT_NAME></a></li>\r\n	      <li><TMPL_VAR PAGE_TITLE></li>\r\n	      </ul>\r\n	    </div>\r\n	  </div>\r\n      </div>\r\n    </div>\r\n    \r\n  </TMPL_IF>\r\n  \r\n  <div id=\"content\">\r\n	<div class=\"container\">	\r\n	    <div class=\"page-content\">\r\n	        <div class=\"row pad_lr\">\r\n			<div class=\"col-md-12 pad_lr\">			    \r\n			    <TMPL_IF PAGE_TITLE><h4 class=\"classic-title\"><span><TMPL_VAR PAGE_TITLE></span></h4></TMPL_IF>		  												    \r\n			    <TMPL_VAR PAGE_INFO>			    \r\n			</div>\r\n		</div>\r\n	    </div>\r\n	</div>\r\n  </div>\r\n\r\n\r\n', 2300, NULL, NULL, '2019-01-11 11:21:20', NULL, 1, 2, '2019-01-11 05:51:20'),
(2599, 'PL', 'layout_full', 'Layout Full', '', '<!---<TMPL_VAR PAGE_ID>\r\n       <TMPL_VAR PAGE_TITLE>\r\n       <TMPL_VAR PARENT_KEY_CODE>\r\n       <TMPL_VAR PARENT_NAME>\r\n       <TMPL_VAR PARENT_RIGHT_IMAGE>\r\n       <TMPL_VAR PARENT_HEADER_IMAGE>\r\n       <TMPL_VAR PAGE_HEADER_IMAGE>\r\n       <TMPL_VAR PAGE_RIGHT_IMAGE>\r\n  --->\r\n\r\n<TMPL_VAR PAGE_INFO>	\r\n\r\n     \r\n\r\n\r\n', 2300, NULL, NULL, '2019-01-11 11:23:10', NULL, 1, 2, '2019-09-30 11:52:56'),
(3593, 'AC', 'ACAC', 'accordion', 'accordion', '', 0, 'EBMS', NULL, '2019-02-02 13:10:05', '2.00', 1, 2, '2019-02-02 07:40:05'),
(3607, 'PL', 'external_attribute', 'Layout for external attribute', 'Layout for external attribute for side menu', '\r\n <!---<TMPL_VAR PAGE_ID><TMPL_VAR PAGE_TITLE><TMPL_VAR PARENT_KEY_CODE>\r\n      <TMPL_VAR PARENT_NAME>\r\n      <TMPL_VAR PARENT_RIGHT_IMAGE>\r\n      <TMPL_VAR PARENT_HEADER_IMAGE>\r\n      <TMPL_VAR PAGE_HEADER_IMAGE>\r\n      <TMPL_VAR PAGE_RIGHT_IMAGE>\r\n      <TMPL_VAR SIDE_MENU>\r\n      <TMPL_VAR MENU_NAME>\r\n      <TMPL_VAR CODE>\r\n  --->\r\n\r\n  \r\n    \r\n    \r\n    <div id=\"content\">\r\n	<div class=\"container\">	\r\n	    <div class=\"page-content\">\r\n	        <div class=\"row pad_lr\">\r\n			<div class=\"col-md-12 pad_lr\">\r\n			    <!-- Page Content--->\r\n			    <div class=\"col-md-9  brdr_right_light \">\r\n				<TMPL_VAR PAGE_INFO>\r\n			    </div>\r\n			    \r\n			    <!--- Side bar--->	\r\n			    <div class=\"col-md-3 sidebar right-sidebar pad_lr\"  id=\"sidebar\">\r\n                   <div class=\"lo_external_attribute\">\r\n                        <ul>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITTX\')\">Text</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITTA\')\">Textarea</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITLA\')\">Label</a></li> \r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITHD\')\">Heading</a></li>  \r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITSH\')\">Sub-heading</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITIG\')\">Integer</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITNM\')\">Number</a></li>  \r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITDT\')\">Date</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITTG\')\">Toggle Switch</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITRG\')\">Range</a></li>  \r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITTB\')\">Twin Box</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITSL\')\">Simple List</a></li>  \r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITFT\')\">Fiben Table</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITTE\')\">Textarea Editor</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITCE\')\">Code Editor</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITFD\')\">Upload Doc</a></li>\r\n                            <li><a href=\"javascript:external_attribute_load(\'&i_t=ITFI\')\">Upload Image</a></li>\r\n                      </ul>\r\n                  </div>\r\n			    </div> <!--end of sidebar-->			    \r\n			</div><!--- inner container--->\r\n		</div><!--/row-->\r\n	    </div><!--page- content-->\r\n	</div><!--container-->\r\n    </div><!--- Content--->  \r\n       \r\n\r\n\r\n', 2300, NULL, NULL, '2019-04-02 19:03:02', NULL, 1, 2, '2020-04-20 12:30:24'),
(4149, 'EA', 'fibentable', 'Fiben Table', '', '', NULL, 'EBAT', NULL, '2019-09-21 17:40:43', '2.00', 1, 2, '2019-09-21 12:10:43'),
(4150, 'AT', 't', 'template', 'Addon Template', '2436,2437', NULL, NULL, NULL, '2019-09-21 17:55:18', NULL, 1, 2, '2019-09-23 10:20:43'),
(4298, 'EA', 'textb', 'Text B', '', '', NULL, 'EBAT', NULL, '2019-09-23 17:16:58', '2.00', 1, 2, '2019-09-23 11:46:58'),
(4373, 'TP', 'header', 'Header', '', '      <!-- Basic -->\r\n      <title>\r\n            <TMPL_IF PAGE_TITLE><TMPL_VAR PAGE_TITLE><TMPL_ELSE><TMPL_IF PARENT_TITLE><TMPL_VAR PARENT_TITLE><TMPL_ELSE><TMPL_VAR DEFAULT_TITLE></TMPL_IF></TMPL_IF>\r\n            <TMPL_IF PAGE_CONTENT_TITLE> - <TMPL_VAR PAGE_CONTENT_TITLE></TMPL_IF>         \r\n      </title>\r\n        \r\n      <!-- Define Charset -->\r\n      <meta charset=\"utf-8\">\r\n    \r\n      <!-- Responsive Metatag -->\r\n      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1\">\r\n      <!-- keyword -->\r\n      <meta name=\"keywords\" content=\"<TMPL_IF PAGE_KEYWORDS><TMPL_VAR PAGE_KEYWORDS><TMPL_ELSE><TMPL_IF PARENT_KEYWORDS><TMPL_VAR PARENT_KEYWORDS><TMPL_ELSE><TMPL_VAR DEFAULT_KEYWORDS></TMPL_IF></TMPL_IF>\">  \r\n      <!-- Page Description and Author -->\r\n      <meta name=\"description\" content=\"<TMPL_IF PAGE_DESCRIPTION><TMPL_VAR PAGE_DESCRIPTION><TMPL_ELSE><TMPL_IF PARENT_DESCRIPTION><TMPL_VAR PARENT_DESCRIPTION><TMPL_ELSE><TMPL_VAR DEFAULT_DESCRIPTION></TMPL_IF></TMPL_IF>\">\r\n      <meta name=\"author\" content=\"Webstars\">\r\n      <meta name=\"revisit-after\" content=\"2 days\">\r\n      <meta name=\"contact\" content=\"<TMPL_VAR PRIMARY_MAIL>\">\r\n      <meta name=\"generator\" content=\"Fibenis\">\r\n\r\n      <link rel=\"icon\" id=\"favicon\" href=\"<TMPL_VAR TERMINAL_PATH>images/favicon_1.png\" type=\"image/png\">     \r\n      \r\n      <TMPL_VAR CORE_HEADER>\r\n          \r\n      <!--- Margo CSS Styles --->\r\n      <link rel=\"stylesheet\" type=\"text/css\" href=\"<TMPL_VAR THEME_ROUTE>/css/style.css\" media=\"screen\">\r\n    \r\n      <!--- Responsive CSS Styles --->\r\n      <link rel=\"stylesheet\" type=\"text/css\" href=\"<TMPL_VAR THEME_ROUTE>/css/responsive.css\" media=\"screen\">\r\n    \r\n      <!--- Css3 Transitions Styles --->\r\n      <link rel=\"stylesheet\" type=\"text/css\" href=\"<TMPL_VAR THEME_ROUTE>/css/animate.css\" media=\"screen\">\r\n      \r\n      <!--- Slicknav --->\r\n      <link rel=\"stylesheet\" type=\"text/css\" href=\"<TMPL_VAR THEME_ROUTE>/css/slicknav.css\" media=\"screen\">\r\n\r\n      <!--- Addon --->\r\n      <TMPL_IF COACH_THEME_BLEND>\r\n          <link rel=\"stylesheet\" type=\"text/css\" href=\"<TMPL_VAR THEME_ROUTE>/blend/<TMPL_VAR COACH_THEME_BLEND>.css\" media=\"screen\">\r\n      <TMPL_ELSE>\r\n          <link rel=\"stylesheet\" type=\"text/css\" href=\"<TMPL_VAR THEME_ROUTE>/blend/<TMPL_VAR THEME_BLEND>.css\" media=\"screen\">\r\n      </TMPL_IF>\r\n  \r\n      <!--- Margo Lite JS --->\r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/jquery.migrate.js\"></script>\r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/modernizrr.js\"></script>\r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/asset/js/bootstrap.min.js\"></script>\r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/jquery.fitvids.js\"></script>\r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/owl.carousel.min.js\"></script>      \r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/jquery.appear.js\"></script>\r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/count-to.js\"></script>\r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/jquery.slicknav.js\"></script>\r\n      <script type=\"text/javascript\" src=\"<TMPL_VAR THEME_ROUTE>/js/form-validator.min.js\"></script>\r\n      <!--[if IE 8]><script src=\"http://html5shiv.googlecode.com/svn/trunk/html5.js\"></script><![endif]-->\r\n      <!--[if lt IE 9]><script src=\"http://html5shiv.googlecode.com/svn/trunk/html5.js\"></script><![endif]-->\r\n    \r\n    \r\n      <!---<TMPL_VAR LIB_PATH><TMPL_VAR CURRENT_YEAR><TMPL_VAR IS_HOME><TMPL_VAR IS_PAGE>--->', 2300, NULL, NULL, '2019-09-30 17:18:57', NULL, 1, 2, '2019-09-30 11:48:57');
INSERT INTO `entity_child_base` (`id`, `entity_code`, `token`, `sn`, `ln`, `note`, `parent_id`, `dna_code`, `created_by`, `creation`, `line_order`, `is_active`, `user_id`, `timestamp_punch`) VALUES
(4374, 'TP', 'menu', 'Menu', '', '\r\n    <div  id=\"margo_loader\">\r\n	  <div class=\"spinner\">\r\n	    <div class=\"dot1\"></div>\r\n	   <div class=\"dot2\"></div>\r\n	  </div>\r\n    </div>\r\n	\r\n    \r\n    <!-- Start Header Section -->\r\n    <div class=\"hidden-header\"></div>\r\n    <header class=\"clearfix\">\r\n\r\n      <!-- Start Top Bar -->\r\n      <div class=\"top-bar\">\r\n        <div class=\"container\">\r\n          <div class=\"row\">\r\n            <div class=\"col-md-12\">\r\n              <!-- Start Contact Info -->\r\n              <ul class=\"contact-details\">\r\n		\r\n		<TMPL_IF IS_HOME>\r\n		  \r\n		  \r\n		  <li><a href=\"#\" class=\" txt_size_14 b\"><i class=\"fa fa-map-marker\">&nbsp;</i><span id=\"menu_org_name\"><TMPL_VAR HOME_ADD_NAME></span>&nbsp;&nbsp; </a></li>              \r\n		  <li id=\"menu_email_area\"><a href=\"#\" class=\" txt_size_14\"><i class=\"fa fa-send clr_pri\">&nbsp;</i><span id=\"menu_email\"><TMPL_VAR HOME_ADD_EMAIL></span>&nbsp;</a></li>		                \r\n		  <li id=\"menu_phone_area\"><a href=\"#\"  class=\" txt_size_14\"><i class=\"fa fa-phone clr_pri\">&nbsp;</i><span id=\"menu_phone\"><TMPL_VAR HOME_ADD_PHONE></span>&nbsp; </a></li>              \r\n		  <li id=\"menu_mobile_area\"><a href=\"#\"  class=\" txt_size_14\"><i class=\"fa fa-mobile clr_pri animated <TMPL_IF IS_HOME> infinite </TMPL_IF> bounceIn\">&nbsp;</i><span id=\"menu_mobile\"><TMPL_VAR HOME_ADD_MOBILE></span></a></li>\r\n		\r\n		</TMPL_IF>\r\n		 \r\n              </ul>\r\n              <!-- End Contact Info -->\r\n            </div>\r\n            \r\n          </div>\r\n          <!-- .row -->\r\n        </div>\r\n        <!-- .container -->\r\n      </div>\r\n      <!-- .top-bar -->\r\n      <!-- End Top Bar -->\r\n\r\n\r\n      <!-- Start  Logo & Naviagtion  -->\r\n      \r\n      <div class=\"navbar navbar-default navbar-top\">\r\n        <div class=\"container\">\r\n          <div class=\"navbar-header\">\r\n            <!-- Stat Toggle Nav Link For Mobiles -->\r\n            <button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\".navbar-collapse\">\r\n              <i class=\"fa fa-bars\"></i>\r\n            </button>\r\n            <!-- End Toggle Nav Link For Mobiles -->\r\n            <a class=\"navbar-brand\" href=\"?home\">\r\n              <img id=\"logo\" alt=\"Home\" src=\"<TMPL_VAR COACH_PATH>/<TMPL_VAR COACH_NAME>/images/logo_1.png\"  class=\"img-responsive\">\r\n            </a>\r\n          </div>\r\n          <div class=\"navbar-collapse collapse\">\r\n            \r\n            <!-- Start Navigation List -->\r\n            <ul class=\"nav navbar-nav navbar-right\">\r\n		  \r\n		  <TMPL_IF APP_MENU_TEXT>\r\n			      <TMPL_VAR APP_MENU_TEXT>\r\n		  <TMPL_ELSE>			\r\n			      <TMPL_LOOP APP_MENU>\r\n					  <TMPL_IF CHILD_MENU> \r\n						    \r\n						 <li>\r\n						     \r\n						     <a  href=\"#\" title=\"<TMPL_VAR MENU_TITLE>\"\r\n							 class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">			       \r\n							 <TMPL_VAR MENU_TITLE>&nbsp;<span class=\"caret\"></span>\r\n						     </a>\r\n						     \r\n						     <ul class=\"dropdown-menu\" role=\"menu\">\r\n							 \r\n							 <TMPL_LOOP CHILD_MENU>\r\n							     <li>\r\n								 <a href=\"<TMPL_VAR MENU_HREF>\">\r\n								     <span class=\"<TMPL_VAR css_class>\" aria-hidden=\"true\"></span>\r\n								     &nbsp;&nbsp;<TMPL_VAR MENU_TITLE> \r\n								    \r\n								 </a>\r\n							     </li>\r\n							 </TMPL_LOOP>\r\n								      \r\n						     </ul> \r\n						 </li>\r\n						     \r\n					     <TMPL_ELSE>\r\n						 <li ><a href=\"<TMPL_VAR menu_href>\"><TMPL_VAR menu_title>&nbsp;</a></li>\r\n					     </TMPL_IF>\r\n				    \r\n			      </TMPL_LOOP>\r\n		  </TMPL_IF>\r\n			\r\n	      \r\n		  <TMPL_IF USER_SAD>\r\n			\r\n			<!--<li ><a  href=\"?dx=ps_connection\"> <i class=\"fa fa-refresh\"></i>&nbsp;\r\n			            PubSub\r\n			      </a>\r\n			</li>\r\n			\r\n			<li ><a  href=\"?d=entity_dash_board\"> <i class=\"fa fa-th-list\"></i>&nbsp;\r\n			            PublishedDataSet\r\n			      </a>\r\n			</li>\r\n			\r\n			\r\n			<li><a>|</a></li>\r\n			\r\n			\r\n			<li ><a  href=\"?d=entity_dash_board\"> <i class=\"fa fa-download\"></i>&nbsp;\r\n			            Download Client Certificate\r\n			      </a>\r\n			</li>\r\n			\r\n			<li><a>|</a></li>-->\r\n			\r\n			<li ><a  href=\"?d=entity_dash_board\"> <i class=\"fa fa-pie-chart\"></i>&nbsp;\r\n			Entity Dash&nbsp;</a></li>		    			\r\n			\r\n			<!---EA--->\r\n			<li>\r\n			    \r\n			    <a href=\"#\"\r\n			       class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\"			       \r\n			      >\r\n			        <i class=\"fa fa-clone\"></i>\r\n			        &nbsp;Entity Setup&nbsp;<span class=\"caret\"></span>\r\n			    </a>			    \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				    <li> <a href=\"?d=entity\">Entity</a></li>\r\n				    <li> <a href=\"?d=F\">Entity Attribute</a></li>\r\n				    <li> <a href=\"?d=external_entity\">External Entity</a></li>\r\n				    <li> <a href=\"?d=external_attribute\">External Attribute</a></li>				\r\n				    <li> <a href=\"?d=entity_child\">Entity Child</a></li>\r\n				    <li> <a href=\"?d=entity_child_base\">Entity Child Base</a></li>\r\n				    <li> <a href=\"?d=entity_key_value\">Entity Key Value</a></li>\r\n				    <li> <a href=\"?d=entity_grouping\">Entity Grouping</a></li>\r\n				    <li> <a href=\"?d=master_panel\">Master Panel</a></li>\r\n			    </ul>\r\n			</li>\r\n			\r\n			\r\n			<!---Page--->\r\n			<li>\r\n\r\n			    <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				&nbsp;\r\n				<i class=\"fa fa-file\"></i>\r\n				&nbsp;Portal&nbsp;\r\n				<span class=\"caret\"></span>\r\n			    </a>				\r\n				 \r\n			      <ul class=\"dropdown-menu\" role=\"menu\">\r\n				    <li><a href=\"?d=coach_eav\">Coach</a></li>\r\n				    <li><a href=\"?d=cms_page_eav\">Page Desk</a></li>\r\n				    <li><a href=\"?d=page_addon\">Page Addon</a></li>\r\n				    <li><a href=\"?d=page_addon_attribute\">Page Addon Attribute</a></li>\r\n				    <li><a href=\"?d=page_section__template\">Page Section Template</a></li>\r\n				  <!--<li><a href=\"?d=page_layout\">Page Layout</a></li>\r\n				    <li><a href=\"?d=page_template\">Template</a></li>-->\r\n				    <li><a href=\"?d=theme\">Theme</a></li>\r\n			      </ul>\r\n			</li>\r\n			\r\n			\r\n			<!---Issues--->\r\n			<li>			    \r\n			    <a href=\"#\"\r\n			       class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\"			       \r\n			      >\r\n			        <i class=\"fa fa-clone\"></i>\r\n			        &nbsp;Apps&nbsp;<span class=\"caret\"></span>\r\n			    </a>\r\n			    \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">				 \r\n				   <li> <a href=\"?d=issue\">Issue</a></li>\r\n			    </ul>			    \r\n			</li>\r\n			\r\n			\r\n			\r\n			<li>\r\n\r\n			    <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				&nbsp;\r\n				<i class=\"fa fa-user\"></i>\r\n				&nbsp;Setup&nbsp;\r\n				<span class=\"caret\"></span>\r\n			    </a>				\r\n				 \r\n			     <ul class=\"dropdown-menu\" role=\"menu\">\r\n			            <li><a href=\"?d=def\">App Definations</a></li>\r\n				    <li><a href=\"?d=log_action\">Log Action</a></li>\r\n				    <li><a href=\"?d=contact_eav\">Contact</a></li>\r\n			            <li><a href=\"?d=user_neutral\">User Neutral</a></li>\r\n				    <li><a href=\"?d=user_role\">User Role</a></li>\r\n				    <li><a href=\"?d=user_role_permission\">User Role Permissions</a></li>\r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n			\r\n			\r\n			<li>\r\n\r\n			    <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				<span class=\"glyphicon glyphicon-time\" aria-hidden=\"true\"></span>\r\n				&nbsp;Log&nbsp;\r\n				<span class=\"caret\"></span>\r\n			    </a>				\r\n				 \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				    <li> <a href=\"?d=status\">Status Log</a></li>				    				\r\n				    <li> <a href=\"?d=sys_log\">Sys Log</a></li>\r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n			<!---Setup--->\r\n			<li>			    \r\n			    <a href=\"#\" class=\"dropdown-toggle hint--left\" data-hint=\"Manage your Profile\" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				<span class=\"glyphicon glyphicon-cog clr_gray_a more txt_size_18\" aria-hidden=\"true\"></span>\r\n				<span class=\"caret\"></span>\r\n			    </a>			  \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#my-account\">\r\n				    <span class=\"glyphicon glyphicon-folder-open\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;My Account\r\n				     </a>\r\n				</li>\r\n				<li class=\"divider\"></li>\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalChangePassword\">\r\n				    <span class=\"glyphicon glyphicon-sort\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;Change Password\r\n				    </a>\r\n				</li>\r\n			    </ul>			  \r\n			</li>\r\n			\r\n			<!---EA--->\r\n			<li>\r\n			    \r\n			    <a href=\"#\"\r\n			       class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\"			       \r\n			      >\r\n			        <i class=\"fa fa-clone\"></i>\r\n			        &nbsp;Demo&nbsp;<span class=\"caret\"></span>\r\n			    </a>\r\n			    \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				 \r\n				   <li><a href=\"?dx=demo__flat\">Demo Flat</a></li>\r\n				   <li><a href=\"?dx=demo__eav\">Demo EAV</a></li>\r\n				   <li><a href=\"?dx=demo__ui_form\">Faddon Form</a></li>\r\n				 \r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n			\r\n			\r\n		    </TMPL_IF>	 <!--- end of super admin---> 	\r\n			\r\n		    \r\n		     <!--- Dynamic Menu--->\r\n		     \r\n		     <TMPL_UNLESS USER_ADM>\r\n			\r\n			 <TMPL_UNLESS USER_SAD>\r\n		     \r\n			      <TMPL_LOOP PARENT_MENU>\r\n					 \r\n				 <TMPL_IF CHILD_MENU> \r\n					<!--<TMPL_VAR menu_code>-->	\r\n				     <li>\r\n					 \r\n					 <a  href=\"#\" title=\"<TMPL_VAR MENU_TITLE>\"\r\n					     class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">			       \r\n					     <TMPL_VAR MENU_NAME>&nbsp;<span class=\"caret\"></span>\r\n					 </a>\r\n					 \r\n					 <ul class=\"dropdown-menu\" role=\"menu\">\r\n					     \r\n					     <TMPL_LOOP CHILD_MENU>\r\n						 <li>\r\n						     <a href=\"<TMPL_VAR MENU_HREF>\">\r\n							 <span class=\"<TMPL_VAR css_class>\" aria-hidden=\"true\"></span>\r\n							 &nbsp;&nbsp;<TMPL_VAR MENU_NAME> \r\n							 <!-- <TMPL_VAR no_data>  -->\r\n						     </a>\r\n						 </li>\r\n					     </TMPL_LOOP>\r\n							  \r\n					 </ul> \r\n				     </li>\r\n					 \r\n				 <TMPL_ELSE>\r\n				     <li ><a class=\"page-scroll\"  id=\"<TMPL_VAR menu_code>\" href=\"<TMPL_VAR menu_href>\"><TMPL_VAR menu_name>&nbsp;</a></li>\r\n				 </TMPL_IF>\r\n						 \r\n			      </TMPL_LOOP>\r\n			      \r\n			      <!--- Dynamic Content--->\r\n			      \r\n				  <TMPL_IF is_directory>\r\n				       <li id=\"directory\">\r\n					 <a href=\"?d=contact_card\">\r\n					 <i class=\"fa fa-book clr_sec\" aria-hidden=\"true\">&nbsp;&nbsp;</i>\r\n					   Directory</a>\r\n				   </li>\r\n				 </TMPL_IF> \r\n				 \r\n				  <TMPL_IF is_news_events> \r\n				       <li id=\"news_events\">\r\n					     <a href=\"?d=news_events\">\r\n					     <i class=\"fa fa-calendar clr_sec\" aria-hidden=\"true\">&nbsp;&nbsp;</i>Events</a>\r\n				       </li>\r\n				  </TMPL_IF>   \r\n				\r\n				 <TMPL_IF is_blog> \r\n				    <li id=\"blog\">\r\n					  <a href=\"?d=blog\">\r\n					  <i class=\"fa fa-pencil clr_sec\" aria-hidden=\"true\">&nbsp;&nbsp;</i>Blog</a>\r\n				    </li>\r\n				  </TMPL_IF>\r\n				 \r\n				 <TMPL_IF is_gallery>\r\n				    <li id=\"gallery\">\r\n					  <a href=\"?d=gallery_view\">\r\n					  <i class=\"fa fa-image clr_sec\" aria-hidden=\"true\">&nbsp;&nbsp;</i>Gallery</a>\r\n				    </li>\r\n				 </TMPL_IF>\r\n				 \r\n				 <!--<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalSignIn\"><b><i class=\"fa fa-key\">&nbsp;</i>Sign In</b></a>-->\r\n				  \r\n			</TMPL_UNLESS>\r\n			 \r\n			 \r\n			 \r\n		     </TMPL_UNLESS>\r\n		    \r\n		 \r\n		    \r\n		    \r\n		    <!---Admin--->  \r\n		    <TMPL_IF USER_SYS_ADM>\r\n			\r\n			    <!--<li id=\"my_tree\"><a href=\"?d_series=report_desk\">Reports</a></li>-->\r\n			\r\n			    <li>				\r\n				<a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				    \r\n				    <i class=\"fa fa-cubes\" aria-hidden=\"true\"></i>\r\n				    &nbsp;CMS&nbsp;\r\n				    <span class=\"caret\"></span>\r\n				</a>\r\n				    \r\n				<ul class=\"dropdown-menu\" role=\"menu\">\r\n				    \r\n					<li>\r\n					    <a href=\"?d=cms_page_eav\">\r\n						<i class=\"fa fa-file-code-o\" aria-hidden=\"true\"></i>\r\n						Pages\r\n					    </a>\r\n					</li>					\r\n									    \r\n					\r\n					<li><a href=\"?d=cms_blog\">\r\n						<i class=\"fa fa-pencil\" aria-hidden=\"true\"></i>\r\n						Blog\r\n					    </a>\r\n					</li>\r\n					\r\n					<li>\r\n					    <a href=\"?d=blog_category\">\r\n						<i class=\"fa fa-plus-square\" aria-hidden=\"true\"></i>\r\n						Blog Category\r\n					    </a>\r\n					</li>					\r\n					\r\n					\r\n					<li>\r\n					    <a href=\"?d=cms_news_events\">\r\n						<i class=\"fa fa-calendar\" aria-hidden=\"true\"></i>\r\n						News & Events\r\n					    </a>\r\n					</li>\r\n					\r\n					<li>\r\n					    <a href=\"?d=news_event_type\">\r\n						<i class=\"fa fa-calendar-plus-o\" aria-hidden=\"true\"></i>\r\n						Events Type\r\n					    </a>\r\n					</li>					\r\n					\r\n					\r\n					<li>\r\n					    <a href=\"?d=contact\">\r\n						<i class=\"fa fa-book\" aria-hidden=\"true\"></i>\r\n						Directory\r\n					    </a>\r\n					</li>\r\n					\r\n					\r\n					\r\n					<li>\r\n					    <a href=\"?d=contact_group\">\r\n						<i class=\"fa fa-group\" aria-hidden=\"true\"></i>\r\n						Contact Group\r\n					    </a>\r\n					</li>\r\n					\r\n				       \r\n				       <li>\r\n					    <a href=\"?d=plug_gallery\">\r\n						<i class=\"fa fa-chevron-circle-right\" aria-hidden=\"true\"></i>\r\n						Gallery \r\n					    </a>\r\n					</li>\r\n				       \r\n				           <li>\r\n					    <a href=\"?d=plug_image\">\r\n						<i class=\"fa fa-file-image-o\" aria-hidden=\"true\"></i>\r\n						Site Images\r\n					    </a>\r\n				       </li>\r\n				\r\n				    \r\n					  \r\n				       <li>\r\n					    <a href=\"?d=menu_set\">\r\n						<i class=\"fa fa-align-justify\" aria-hidden=\"true\"></i>\r\n						Manage Menu\r\n					    </a>\r\n				       </li>\r\n				       \r\n				       <li>\r\n					    <a href=\"?d=page_meta\">\r\n						<i class=\"fa fa-align-justify\" aria-hidden=\"true\"></i>\r\n						Page Meta Updates\r\n					    </a>\r\n				       </li>\r\n					\r\n				</ul>\r\n			    </li>\r\n				\r\n				\r\n			    <TMPL_IF ADDON_TYPE>   \r\n			      <li>				\r\n				  <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">				    \r\n				      <i class=\"fa fa-cubes\" aria-hidden=\"true\"></i>\r\n				      &nbsp;Page Addon&nbsp;\r\n				      <span class=\"caret\"></span>\r\n				  </a>\r\n				      \r\n				  <ul class=\"dropdown-menu\" role=\"menu\">				    \r\n					  <TMPL_LOOP ADDON_TYPE>					\r\n					    <li>\r\n						<a href=\'?d=cms_page_eav&default_addon={\"at\":\"<TMPL_VAR ID>\"}\'>\r\n						    <TMPL_VAR SN>\r\n						</a>\r\n					    </li>					\r\n					  </TMPL_LOOP>					\r\n				  </ul>\r\n			      </li>\r\n			    </TMPL_IF>\r\n				\r\n			    <!--<li> <a href=\"?d=one_page&default_addon=mop_base\">One Page</a></li>\r\n			    <li> <a href=\"?d=one_page&default_addon=fibenis\">Fibenis</a></li>-->\r\n			    <li><a href=\"?d=coach\">Coach</a></li>\r\n			    <li>\r\n				\r\n				<a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				    \r\n				    <i class=\"fa fa-wrench\" aria-hidden=\"true\"></i>\r\n				    &nbsp;Home Setup&nbsp;\r\n				    <span class=\"caret\"></span>\r\n				</a>\r\n				       <ul class=\"dropdown-menu\" role=\"menu\">\r\n					\r\n					<li> <a href=\"?d=about_us\"> About Us</a></li>\r\n					\r\n					<li> <a href=\"?d=accordion\"> Accordion</a></li>\r\n					\r\n					<li> <a href=\"?d=action_box\">Action Box</a></li>\r\n					\r\n					<li> <a href=\"?d=home_address\">Contact</a></li>\r\n					\r\n					<li> <a href=\"?d=client\">Home Client</a></li>\r\n				   \r\n					<li> <a href=\"?d=counter\">Home Counter</a></li>\r\n				   \r\n		  			<li> <a href=\"?d=home_banner\">Home Banner</a></li>\r\n					\r\n					<li> <a href=\"?d=portfolio\">Home Portfolio</a></li>\r\n				  \r\n  				        <li> <a href=\"?d=home_salient_features\">Home Salient Features</a></li>\r\n				       \r\n				        <li> <a href=\"?d=home_scroller\">Home Scroller</a></li>\r\n				\r\n					<li> <a href=\"?d=tab\">Tab</a></li>\r\n					\r\n				        <li> <a href=\"?d=team\">Team</a></li>\r\n				   \r\n				        <li> <a href=\"?d=testimonial\">Testimonial</a></li>\r\n					\r\n					<li> <a href=\"?d=timeline\">Timeline</a></li>\r\n					\r\n				       </ul>\r\n				</li>			        \r\n			    \r\n			    <li class=\"dropdown\">				\r\n				\r\n				<a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				    <span class=\"glyphicon glyphicon-time\" aria-hidden=\"true\"></span>\r\n				    &nbsp;Log&nbsp;<span class=\"caret\"></span>\r\n				</a>\r\n				\r\n				<ul class=\"dropdown-menu\" role=\"menu\">\r\n				    <li><a href=\"?d_series=status_detail\">Status Log</a></li>\r\n				    <li><a href=\"?d_series=view_log\">Profile View Log</a></li>					    \r\n				    <li><a href=\"?d_series=sys_log\">Sys Log</a></li>\r\n				</ul>\r\n				\r\n			    </li>\r\n			    \r\n			    <!--- Admin Info--->\r\n			    <li class=\"dropdown\">\r\n				\r\n				<a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				  <span class=\"glyphicon glyphicon-tag\" aria-hidden=\"true\"></span>\r\n				  &nbsp;<TMPL_VAR USER_NAME>&nbsp;<span class=\"caret\"></span>\r\n				</a>\r\n			      \r\n				<ul class=\"dropdown-menu\" role=\"menu\">				 				    \r\n				    <li>\r\n					<a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalChangePassword\">\r\n					    <span class=\"glyphicon glyphicon-sort\" aria-hidden=\"true\"></span>\r\n					    &nbsp;&nbsp;Change Password\r\n					</a>\r\n				    </li>				 \r\n				</ul>\r\n			   </li>\r\n			    \r\n		    </TMPL_IF>  <!--- end of SYSTEM admin--->\r\n		    \r\n		    \r\n		    <TMPL_IF USER_ADM>\r\n		      \r\n		      <li ><a  href=\"?d=entity_dash_board\"> <i class=\"fa fa-pie-chart\"></i>&nbsp;\r\n			Entity Dash&nbsp;</a></li>		    			\r\n			\r\n			\r\n			<!---Page--->\r\n			<li>\r\n\r\n			    <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				&nbsp;\r\n				<i class=\"fa fa-file\"></i>\r\n				&nbsp;Page&nbsp;\r\n				<span class=\"caret\"></span>\r\n			    </a>				\r\n				 \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				    <li><a href=\"?d=coach_eav\">Coach</a></li>\r\n				    <li><a href=\"?d=cms_page_eav\">Page Info</a></li>\r\n				    <li><a href=\"?d=page_addon\">Page Addon</a></li>\r\n				    <li><a href=\"?d=page_layout\">Page Layout</a></li>\r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n			<!---EA--->\r\n			<li>\r\n			    \r\n			    <a href=\"#\"\r\n			       class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\"			       \r\n			      >\r\n			        <i class=\"fa fa-clone\"></i>\r\n			        &nbsp;Others&nbsp;<span class=\"caret\"></span>\r\n			    </a>\r\n			    \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				   <li><a href=\"?d=contact_eav\">Contact</a></li>\r\n				   <li><a href=\"?dx=demo__flat\">Demo Flat</a></li>\r\n				   <li><a href=\"?dx=demo__eav\">Demo EAV</a></li>\r\n				   <li> <a href=\"?d=issue\">Issue</a></li>\r\n			    </ul>\r\n			    \r\n			</li>\r\n					\r\n		      <li>			    \r\n			    <a href=\"#\" class=\"dropdown-toggle hint--left\" data-hint=\"Manage your Profile\" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				<span class=\"glyphicon glyphicon-cog clr_gray_a more txt_size_18\" aria-hidden=\"true\"></span>\r\n				<span class=\"caret\"></span>\r\n			    </a>			  \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#my-account\">\r\n				    <span class=\"glyphicon glyphicon-folder-open\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;My Account\r\n				     </a>\r\n				</li>\r\n				\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalChangePassword\">\r\n				    <span class=\"glyphicon glyphicon-sort\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;Change Password\r\n				    </a>\r\n				</li>\r\n			    </ul>			  \r\n		      </li>	\r\n			\r\n		    </TMPL_IF> <!--- End of Member A --->\r\n		    \r\n		    \r\n		    <!--- Base User---> \r\n		    <TMPL_IF USER_BAS>\r\n		      \r\n		      <li><a>|</a></li>\r\n		      <li><a href=\"?dx=demo_flat\">\r\n			  <i class=\"fa fa-lightbulb-o txt_size_1_2em clr_pri\" aria-hidden=\"true\">&nbsp;</i>\r\n			  Sample</a>\r\n		      </li>		\r\n		      <li>			    \r\n			    <a href=\"#\" class=\"dropdown-toggle hint--left\" data-hint=\"Manage your Profile\" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				<span class=\"glyphicon glyphicon-cog clr_gray_a more txt_size_18\" aria-hidden=\"true\"></span>\r\n				<span class=\"caret\"></span>\r\n			    </a>			  \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#my-account\">\r\n				    <span class=\"glyphicon glyphicon-folder-open\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;My Account\r\n				     </a>\r\n				</li>\r\n				\r\n				<!--<li><a href=\"?dx=my_profile\">\r\n				    <i class=\"fa fa-user\" aria-hidden=\"true\">&nbsp;</i>\r\n				    &nbsp;&nbsp;My Profile\r\n				     </a>\r\n				</li>-->\r\n				\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalChangePassword\">\r\n				    <span class=\"glyphicon glyphicon-sort\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;Change Password\r\n				    </a>\r\n				</li>\r\n			    </ul>			  \r\n		      </li>	\r\n			\r\n		    </TMPL_IF> <!--- End of Member A --->	\r\n		     \r\n		    <!---Member B--->  \r\n		    <TMPL_IF USER_MEB>						       \r\n			   \r\n		    </TMPL_IF>	\r\n		     \r\n		     \r\n		    <!---Inactive User---> \r\n		    <TMPL_IF USER_MED>\r\n			  	    			    \r\n		    </TMPL_IF>\r\n		    \r\n		     <TMPL_UNLESS NO_USER>\r\n			   <li>\r\n			      <a href=\"JavaScript:get_out();\" class=\"txt_clr_red\"\r\n				 rel=\"txtTooltip\" title=\"Log Out\" data-toggle=\"tooltip\" data-placement=\"bottom\"\r\n				 >\r\n			      \r\n				 <button class=\"btn btn-xs btn-danger\" type=\"button\">			\r\n				    <span class=\"glyphicon glyphicon-log-out pad_5\" aria-hidden=\"true\"></span>\r\n				 </button>\r\n			      </a>\r\n			   </li>\r\n		     </TMPL_UNLESS>		     \r\n		     \r\n		    <!---No User--->\r\n		    \r\n		    <TMPL_IF NO_USER>\r\n			\r\n			\r\n		      \r\n		      <TMPL_IF IS_OPEN>\r\n			  \r\n			   \r\n				    <li>\r\n					<a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalSignIn\" >\r\n					    <span class=\"glyphicon glyphicon-log-in\" aria-hidden=\"true\"></span>\r\n					    &nbsp;&nbsp;Sign In\r\n					</a>\r\n				    </li>\r\n				  <li>\r\n					<a href=\"#\" data-toggle=\"modal\" data-target=\"#myModal_signUp\">\r\n					    <span class=\"glyphicon glyphicon-edit\" aria-hidden=\"true\">\r\n					    </span>&nbsp;&nbsp;Sign Up\r\n					</a>\r\n				    </li>	\r\n				\r\n		      </TMPL_IF>\r\n					\r\n		    </TMPL_IF>\r\n		    \r\n		    \r\n		     <li>&nbsp;&nbsp;&nbsp;&nbsp;</li>\r\n            </ul>\r\n            <!-- End Navigation List -->\r\n          </div>\r\n        </div>\r\n\r\n       \r\n        <!-- Mobile Menu Start -->\r\n        <ul class=\"wpb-mobile-menu\">	 \r\n	  \r\n	   <TMPL_IF USER_SAD>		      \r\n		      \r\n		        <li ><a  href=\"?d=entity_dash_board\"> <i class=\"fa fa-pie-chart\"></i>&nbsp;\r\n			Entity Dash&nbsp;</a></li>		    			\r\n			<!---EA--->\r\n			<li>\r\n			    \r\n			    <a href=\"#\"\r\n			       class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\"			       \r\n			      >\r\n			        <i class=\"fa fa-clone\"></i>\r\n			        &nbsp;Entity Setup&nbsp;<span class=\"caret\"></span>\r\n			    </a>\r\n			    \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				   <li> <a href=\"?d=entity\">Entity</a></li>\r\n				   <li> <a href=\"?d=entity_attribute\">Entity Attr.</a></li>\r\n				   <li> <a href=\"?d=external_attribute\">External Attr.</a></li>\r\n				   <li> <a href=\"?d=entity_child\">Entity Child</a></li>\r\n				   <li> <a href=\"?d=entity_child_base\">Entity Child Base</a></li>\r\n				   <li> <a href=\"?d=entity_key_value\">Entity Key Value</a></li>\r\n				   <li> <a href=\"?d=entity_child_apex\">Entity Child Apex</a></li>\r\n				   \r\n				 \r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n			\r\n			<!---EA--->\r\n			<li>\r\n			    \r\n			    <a href=\"#\"\r\n			       class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\"			       \r\n			      >\r\n			        <i class=\"fa fa-clone\"></i>\r\n			        &nbsp;Others&nbsp;<span class=\"caret\"></span>\r\n			    </a>\r\n			    \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				   <li> <a href=\"?d=time_range\">Time Range HMS</a></li>\r\n				   <li> <a href=\"?d=issue\">Issue</a></li>\r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n					<!---Log--->\r\n			<li>\r\n\r\n			    <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				&nbsp;\r\n				<i class=\"fa fa-file\"></i>\r\n				&nbsp;Page&nbsp;\r\n				<span class=\"caret\"></span>\r\n			    </a>				\r\n				 \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				    <li><a href=\"?d=def\">App Definations</a></li>\r\n				    <li><a href=\"?d=coach\">Coach</a></li>\r\n				    <li><a href=\"?d=cms_page_eav\">Page Info</a></li>\r\n				    <li><a href=\"?d=page_layout\">Page Layout</a></li>\r\n				    <li><a href=\"?d=page_addon\">Page Addon</a></li>\r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n			\r\n			<li>\r\n\r\n			    <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				&nbsp;\r\n				<i class=\"fa fa-user\"></i>\r\n				&nbsp;Setup&nbsp;\r\n				<span class=\"caret\"></span>\r\n			    </a>				\r\n				 \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n			          <li><a href=\"?d=user_neutral\">User Neutral</a></li>\r\n				  <li><a href=\"?d=user_role\">User Role</a></li>\r\n				  <li><a href=\"?d=user_role_permission\">User Role Permissions</a></li>\r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n			\r\n			\r\n			<li>\r\n\r\n			    <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				<span class=\"glyphicon glyphicon-time\" aria-hidden=\"true\"></span>\r\n				&nbsp;Log&nbsp;\r\n				<span class=\"caret\"></span>\r\n			    </a>				\r\n				 \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				    <li> <a href=\"?d_series=status_detail\">Status Log</a></li>				    				\r\n				    <li> <a href=\"?d_series=sys_log\">Sys Log</a></li>\r\n			    </ul>\r\n			    \r\n			</li>\r\n			\r\n			<!---Setup--->\r\n			<li>			    \r\n			    <a href=\"#\" class=\"dropdown-toggle hint--left\" data-hint=\"Manage your Profile\" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				<span class=\"glyphicon glyphicon-cog clr_gray_a more txt_size_18\" aria-hidden=\"true\"></span>\r\n				<span class=\"caret\"></span>\r\n			    </a>			  \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#my-account\">\r\n				    <span class=\"glyphicon glyphicon-folder-open\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;My Account\r\n				     </a>\r\n				</li>\r\n				<li class=\"divider\"></li>\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalChangePassword\">\r\n				    <span class=\"glyphicon glyphicon-sort\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;Change Password\r\n				    </a>\r\n				</li>\r\n			    </ul>			  \r\n			</li>\r\n			\r\n			\r\n			\r\n		    </TMPL_IF>	 <!--- end of super admin---> 	\r\n			\r\n		    \r\n		     <!--- Dynamic Menu--->\r\n		     \r\n		     <TMPL_UNLESS USER_ADM>\r\n			\r\n			 <TMPL_UNLESS USER_SAD>\r\n		     \r\n			      <TMPL_LOOP PARENT_MENU>\r\n					 \r\n				 <TMPL_IF CHILD_MENU> \r\n					<!--<TMPL_VAR menu_code>-->	\r\n				     <li>\r\n					 \r\n					 <a  href=\"#\" title=\"<TMPL_VAR MENU_TITLE>\"\r\n					     class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">			       \r\n					     <TMPL_VAR MENU_NAME>&nbsp;<span class=\"caret\"></span>\r\n					 </a>\r\n					 \r\n					 <ul class=\"dropdown-menu\" role=\"menu\">\r\n					     \r\n					     <TMPL_LOOP CHILD_MENU>\r\n						 <li>\r\n						     <a href=\"<TMPL_VAR MENU_HREF>\">\r\n							 <span class=\"<TMPL_VAR css_class>\" aria-hidden=\"true\"></span>\r\n							 &nbsp;&nbsp;<TMPL_VAR MENU_NAME> \r\n							 <!-- <TMPL_VAR no_data>  -->\r\n						     </a>\r\n						 </li>\r\n					     </TMPL_LOOP>\r\n							  \r\n					 </ul> \r\n				     </li>\r\n					 \r\n				 <TMPL_ELSE>\r\n				     <li ><a class=\"page-scroll\"  id=\"<TMPL_VAR menu_code>\" href=\"<TMPL_VAR menu_href>\"><TMPL_VAR menu_name>&nbsp;</a></li>\r\n				 </TMPL_IF>\r\n						 \r\n			      </TMPL_LOOP>\r\n			      \r\n			      <!--- Dynamic Content--->\r\n			      \r\n				  <TMPL_IF is_directory>\r\n				       <li id=\"directory\">\r\n					 <a href=\"?d=contact_card\">\r\n					 <i class=\"fa fa-book clr_sec\" aria-hidden=\"true\">&nbsp;&nbsp;</i>\r\n					   Directory</a>\r\n				   </li>\r\n				 </TMPL_IF> \r\n				 \r\n				  <TMPL_IF is_news_events> \r\n				       <li id=\"news_events\">\r\n					     <a href=\"?d=news_events\">\r\n					     <i class=\"fa fa-calendar clr_sec\" aria-hidden=\"true\">&nbsp;&nbsp;</i>Events</a>\r\n				       </li>\r\n				  </TMPL_IF>   \r\n				\r\n				 <TMPL_IF is_blog> \r\n				    <li id=\"blog\">\r\n					  <a href=\"?d=blog\">\r\n					  <i class=\"fa fa-pencil clr_sec\" aria-hidden=\"true\">&nbsp;&nbsp;</i>Blog</a>\r\n				    </li>\r\n				  </TMPL_IF>\r\n				 \r\n				 <TMPL_IF is_gallery>\r\n				    <li id=\"gallery\">\r\n					  <a href=\"?d=gallery_view\">\r\n					  <i class=\"fa fa-image clr_sec\" aria-hidden=\"true\">&nbsp;&nbsp;</i>Gallery</a>\r\n				    </li>\r\n				 </TMPL_IF>\r\n				 \r\n				 <!--<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalSignIn\"><b><i class=\"fa fa-key\">&nbsp;</i>Sign In</b></a>-->\r\n				  \r\n			</TMPL_UNLESS>\r\n			 \r\n			 \r\n			 \r\n		     </TMPL_UNLESS>\r\n		    \r\n		 \r\n		    \r\n		    \r\n		    <!---Admin--->  \r\n		    <TMPL_IF USER_SYS_ADM>\r\n			\r\n			    <!--<li id=\"my_tree\"><a href=\"?d_series=report_desk\">Reports</a></li>-->\r\n			\r\n			    <li>				\r\n				<a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				    \r\n				    <i class=\"fa fa-cubes\" aria-hidden=\"true\"></i>\r\n				    &nbsp;CMS&nbsp;\r\n				    <span class=\"caret\"></span>\r\n				</a>\r\n				    \r\n				<ul class=\"dropdown-menu\" role=\"menu\">\r\n				    \r\n					<li>\r\n					    <a href=\"?d=cms_page_eav\">\r\n						<i class=\"fa fa-file-code-o\" aria-hidden=\"true\"></i>\r\n						Pages\r\n					    </a>\r\n					</li>					\r\n									    \r\n					\r\n					<li><a href=\"?d=cms_blog\">\r\n						<i class=\"fa fa-pencil\" aria-hidden=\"true\"></i>\r\n						Blog\r\n					    </a>\r\n					</li>\r\n					\r\n					<li>\r\n					    <a href=\"?d=blog_category\">\r\n						<i class=\"fa fa-plus-square\" aria-hidden=\"true\"></i>\r\n						Blog Category\r\n					    </a>\r\n					</li>					\r\n					\r\n					\r\n					<li>\r\n					    <a href=\"?d=cms_news_events\">\r\n						<i class=\"fa fa-calendar\" aria-hidden=\"true\"></i>\r\n						News & Events\r\n					    </a>\r\n					</li>\r\n					\r\n					<li>\r\n					    <a href=\"?d=news_event_type\">\r\n						<i class=\"fa fa-calendar-plus-o\" aria-hidden=\"true\"></i>\r\n						Events Type\r\n					    </a>\r\n					</li>					\r\n					\r\n					\r\n					<li>\r\n					    <a href=\"?d=contact\">\r\n						<i class=\"fa fa-book\" aria-hidden=\"true\"></i>\r\n						Directory\r\n					    </a>\r\n					</li>\r\n					\r\n					\r\n					\r\n					<li>\r\n					    <a href=\"?d=contact_group\">\r\n						<i class=\"fa fa-group\" aria-hidden=\"true\"></i>\r\n						Contact Group\r\n					    </a>\r\n					</li>\r\n					\r\n				       \r\n				       <li>\r\n					    <a href=\"?d=plug_gallery\">\r\n						<i class=\"fa fa-chevron-circle-right\" aria-hidden=\"true\"></i>\r\n						Gallery \r\n					    </a>\r\n					</li>\r\n				       \r\n				           <li>\r\n					    <a href=\"?d=plug_image\">\r\n						<i class=\"fa fa-file-image-o\" aria-hidden=\"true\"></i>\r\n						Site Images\r\n					    </a>\r\n				       </li>\r\n				\r\n				    \r\n					  \r\n				       <li>\r\n					    <a href=\"?d=menu_set\">\r\n						<i class=\"fa fa-align-justify\" aria-hidden=\"true\"></i>\r\n						Manage Menu\r\n					    </a>\r\n				       </li>\r\n				       \r\n				       <li>\r\n					    <a href=\"?d=page_meta\">\r\n						<i class=\"fa fa-align-justify\" aria-hidden=\"true\"></i>\r\n						Page Meta Updates\r\n					    </a>\r\n				       </li>\r\n					\r\n				</ul>\r\n			    </li>\r\n				\r\n				\r\n			    <TMPL_IF ADDON_TYPE>   \r\n			      <li>				\r\n				  <a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">				    \r\n				      <i class=\"fa fa-cubes\" aria-hidden=\"true\"></i>\r\n				      &nbsp;Page Addon&nbsp;\r\n				      <span class=\"caret\"></span>\r\n				  </a>\r\n				      \r\n				  <ul class=\"dropdown-menu\" role=\"menu\">				    \r\n					  <TMPL_LOOP ADDON_TYPE>					\r\n					    <li>\r\n						<a href=\'?d=cms_page_eav&default_addon={\"at\":\"<TMPL_VAR ID>\"}\'>\r\n						    <TMPL_VAR SN>\r\n						</a>\r\n					    </li>					\r\n					  </TMPL_LOOP>					\r\n				  </ul>\r\n			      </li>\r\n			    </TMPL_IF>\r\n				\r\n			    <!--<li> <a href=\"?d=one_page&default_addon=mop_base\">One Page</a></li>\r\n			    <li> <a href=\"?d=one_page&default_addon=fibenis\">Fibenis</a></li>-->\r\n			    <li><a href=\"?d=coach\">Coach</a></li>\r\n			    <li>\r\n				\r\n				<a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				    \r\n				    <i class=\"fa fa-wrench\" aria-hidden=\"true\"></i>\r\n				    &nbsp;Home Setup&nbsp;\r\n				    <span class=\"caret\"></span>\r\n				</a>\r\n				       <ul class=\"dropdown-menu\" role=\"menu\">\r\n					\r\n					<li> <a href=\"?d=about_us\"> About Us</a></li>\r\n					\r\n					<li> <a href=\"?d=accordion\"> Accordion</a></li>\r\n					\r\n					<li> <a href=\"?d=action_box\">Action Box</a></li>\r\n					\r\n					<li> <a href=\"?d=home_address\">Contact</a></li>\r\n					\r\n					<li> <a href=\"?d=client\">Home Client</a></li>\r\n				   \r\n					<li> <a href=\"?d=counter\">Home Counter</a></li>\r\n				   \r\n		  			<li> <a href=\"?d=home_banner\">Home Banner</a></li>\r\n					\r\n					<li> <a href=\"?d=portfolio\">Home Portfolio</a></li>\r\n				  \r\n  				        <li> <a href=\"?d=home_salient_features\">Home Salient Features</a></li>\r\n				       \r\n				        <li> <a href=\"?d=home_scroller\">Home Scroller</a></li>\r\n				\r\n					<li> <a href=\"?d=tab\">Tab</a></li>\r\n					\r\n				        <li> <a href=\"?d=team\">Team</a></li>\r\n				   \r\n				        <li> <a href=\"?d=testimonial\">Testimonial</a></li>\r\n					\r\n					<li> <a href=\"?d=timeline\">Timeline</a></li>\r\n					\r\n				       </ul>\r\n				</li>			        \r\n			    \r\n			    <li class=\"dropdown\">				\r\n				\r\n				<a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				    <span class=\"glyphicon glyphicon-time\" aria-hidden=\"true\"></span>\r\n				    &nbsp;Log&nbsp;<span class=\"caret\"></span>\r\n				</a>\r\n				\r\n				<ul class=\"dropdown-menu\" role=\"menu\">\r\n				    <li><a href=\"?d_series=status_detail\">Status Log</a></li>\r\n				    <li><a href=\"?d_series=view_log\">Profile View Log</a></li>					    \r\n				    <li><a href=\"?d_series=sys_log\">Sys Log</a></li>\r\n				</ul>\r\n				\r\n			    </li>\r\n			    \r\n			    <!--- Admin Info--->\r\n			    <li class=\"dropdown\">\r\n				\r\n				<a href=\"#\" class=\"dropdown-toggle \" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				  <span class=\"glyphicon glyphicon-tag\" aria-hidden=\"true\"></span>\r\n				  &nbsp;<TMPL_VAR USER_NAME>&nbsp;<span class=\"caret\"></span>\r\n				</a>\r\n			      \r\n				<ul class=\"dropdown-menu\" role=\"menu\">				 				    \r\n				    <li>\r\n					<a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalChangePassword\">\r\n					    <span class=\"glyphicon glyphicon-sort\" aria-hidden=\"true\"></span>\r\n					    &nbsp;&nbsp;Change Password\r\n					</a>\r\n				    </li>				 \r\n				</ul>\r\n			   </li>\r\n			    \r\n		    </TMPL_IF>  <!--- end of SYSTEM admin--->\r\n		    \r\n		    \r\n		    <TMPL_IF USER_ADM>\r\n		      \r\n		      <li><a>|</a></li>\r\n		      <li><a href=\"?dx=adm_prog\">\r\n			  <i class=\"fa fa-lightbulb-o txt_size_1_2em clr_pri\" aria-hidden=\"true\">&nbsp;</i>\r\n			   Innovation</a>\r\n		      </li>		\r\n		      <li>			    \r\n			    <a href=\"#\" class=\"dropdown-toggle hint--left\" data-hint=\"Manage your Profile\" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				<span class=\"glyphicon glyphicon-cog clr_gray_a more txt_size_18\" aria-hidden=\"true\"></span>\r\n				<span class=\"caret\"></span>\r\n			    </a>			  \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#my-account\">\r\n				    <span class=\"glyphicon glyphicon-folder-open\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;My Account\r\n				     </a>\r\n				</li>\r\n				\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalChangePassword\">\r\n				    <span class=\"glyphicon glyphicon-sort\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;Change Password\r\n				    </a>\r\n				</li>\r\n			    </ul>			  \r\n		      </li>	\r\n			\r\n		    </TMPL_IF> <!--- End of Member A --->\r\n		    \r\n		    \r\n		    <!--- Base User---> \r\n		    <TMPL_IF USER_BAS>\r\n		      \r\n		      <li><a>|</a></li>\r\n		      <li><a href=\"?dx=programme\">\r\n			  <i class=\"fa fa-lightbulb-o txt_size_1_2em clr_pri\" aria-hidden=\"true\">&nbsp;</i>\r\n			  My Innovation</a>\r\n		      </li>		\r\n		      <li>			    \r\n			    <a href=\"#\" class=\"dropdown-toggle hint--left\" data-hint=\"Manage your Profile\" data-toggle=\"dropdown\" role=\"button\" aria-expanded=\"false\">\r\n				<span class=\"glyphicon glyphicon-cog clr_gray_a more txt_size_18\" aria-hidden=\"true\"></span>\r\n				<span class=\"caret\"></span>\r\n			    </a>			  \r\n			    <ul class=\"dropdown-menu\" role=\"menu\">\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#my-account\">\r\n				    <span class=\"glyphicon glyphicon-folder-open\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;My Account\r\n				     </a>\r\n				</li>\r\n				\r\n				<li><a href=\"?dx=my_profile\">\r\n				    <i class=\"fa fa-user\" aria-hidden=\"true\">&nbsp;</i>\r\n				    &nbsp;&nbsp;My Profile\r\n				     </a>\r\n				</li>\r\n				\r\n				<li><a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalChangePassword\">\r\n				    <span class=\"glyphicon glyphicon-sort\" aria-hidden=\"true\"></span>\r\n				    &nbsp;&nbsp;Change Password\r\n				    </a>\r\n				</li>\r\n			    </ul>			  \r\n		      </li>	\r\n			\r\n		    </TMPL_IF> <!--- End of Member A --->	\r\n		     \r\n		    <!---Member B--->  \r\n		    <TMPL_IF USER_MEB>						       \r\n			   \r\n		    </TMPL_IF>	\r\n		     \r\n		     \r\n		    <!---Inactive User---> \r\n		    <TMPL_IF USER_MED>\r\n			  	    			    \r\n		    </TMPL_IF>\r\n		    \r\n		     <TMPL_UNLESS NO_USER>\r\n			   <li>\r\n			      <a href=\"JavaScript:get_out();\" class=\"txt_clr_red\"\r\n				 rel=\"txtTooltip\" title=\"Log Out\" data-toggle=\"tooltip\" data-placement=\"bottom\"\r\n				 >\r\n			      \r\n				 <button class=\"btn btn-xs btn-danger\" type=\"button\">			\r\n				    <span class=\"glyphicon glyphicon-log-out pad_5\" aria-hidden=\"true\"></span>\r\n				 </button>\r\n			      </a>\r\n			   </li>\r\n		     </TMPL_UNLESS>		     \r\n		     \r\n		    <!---No User--->\r\n		    \r\n		    <TMPL_IF NO_USER>\r\n		      \r\n		      <TMPL_IF IS_OPEN>\r\n			  \r\n			   \r\n				    <li>\r\n					<a href=\"#\" data-toggle=\"modal\" data-target=\"#myModalSignIn\" >\r\n					    <span class=\"glyphicon glyphicon-log-in\" aria-hidden=\"true\"></span>\r\n					    &nbsp;&nbsp;Sign In\r\n					</a>\r\n				    </li>\r\n				  <li>\r\n					<a href=\"#\" data-toggle=\"modal\" data-target=\"#myModal_signUp\">\r\n					    <span class=\"glyphicon glyphicon-edit\" aria-hidden=\"true\">\r\n					    </span>&nbsp;&nbsp;Sign Up\r\n					</a>\r\n				    </li>	\r\n				\r\n		      </TMPL_IF>\r\n					\r\n		    </TMPL_IF>\r\n		    \r\n		    \r\n		     <li>&nbsp;&nbsp;&nbsp;&nbsp;</li>\r\n         \r\n        </ul>\r\n        <!-- Mobile Menu End -->\r\n\r\n\r\n      </div>\r\n      <!-- End Header Logo & Naviagtion -->\r\n      <TMPL_UNLESS IS_PAGE>\r\n	    <section class=\"fbn_page_bar\">\r\n		  <div class=\"container\">\r\n			<span class=\"col-md-12\"><b>&raquo;</b>&nbsp;<TMPL_VAR PAGE_TITLE></span>\r\n		  </div>\r\n	    </section>\r\n      </TMPL_UNLESS>\r\n\r\n    </header>\r\n    <!-- End Header Section -->\r\n    \r\n   \r\n ', 2300, NULL, NULL, '2019-09-30 17:19:51', NULL, 1, 2, '2019-09-30 11:49:51'),
(4594, 'LX', 'DVEW', 'd_seried view', '', '', 0, 'EBMS', NULL, '2019-10-01 16:06:19', '0.00', 1, 2, '2019-10-01 10:36:19'),
(4595, 'LX', 'DELE', 'd_series delete action', '', '', 0, 'EBMS', NULL, '2019-10-01 16:06:39', '0.00', 1, 2, '2019-10-01 10:36:39'),
(4596, 'LX', 'SERC', 'd_series search', 'd_series Search', '', 0, 'EBMS', NULL, '2019-10-01 16:07:02', '0.00', 1, 2, '2019-10-01 10:37:02'),
(4597, 'LX', 'ORDB', 'order by action', 'order by action', '', 0, 'EBMS', NULL, '2019-10-01 16:07:38', '0.00', 1, 2, '2019-10-01 10:37:38'),
(4598, 'LX', 'CCSV', 'CSV Creation Action', 'CSV Creation Action', '', 0, 'EBMS', NULL, '2019-10-01 16:07:54', '0.00', 1, 2, '2019-10-01 10:37:54'),
(4599, 'LX', 'PAGR', 'Pager Action', 'Pager Action', '', 0, 'EBMS', NULL, '2019-10-01 16:08:08', '0.00', 1, 2, '2019-10-01 10:38:08'),
(4600, 'LX', 'VADM', 'Super Admin View ', 'Super Admin View ', '', 0, 'EBMS', NULL, '2019-10-01 16:08:44', '0.00', 1, 2, '2019-10-01 10:38:44'),
(4601, 'LX', 'VUSR', 'User Based Filter Action', '', '', 0, 'EBMS', NULL, '2019-10-01 16:09:18', '0.00', 1, 2, '2019-10-01 10:39:18'),
(4602, 'LX', 'FVEW', 'f_series view', 'f_series view', '', 0, 'EBMS', NULL, '2019-10-01 16:09:46', '0.00', 1, 2, '2019-10-01 10:39:46'),
(4603, 'LX', 'UPDT', 'Form Update', 'Form Update', '', 0, 'EBMS', NULL, '2019-10-01 16:10:04', '0.00', 1, 2, '2019-10-01 10:40:04'),
(4604, 'LX', 'ADDN', 'Form Addition', 'Form Addition', '', 0, 'EBMS', NULL, '2019-10-01 16:10:19', '0.00', 1, 2, '2019-10-01 10:40:19'),
(4605, 'LX', 'PFDT', 'Prefill Form', 'Prefill Form', '', 0, 'EBMS', NULL, '2019-10-01 16:10:35', '0.00', 1, 2, '2019-10-01 10:40:35'),
(4606, 'LX', 'TSAV', 'Template Save Action', 'Template Save Action', '', 0, 'EBMS', NULL, '2019-10-01 16:10:53', '0.00', 1, 2, '2019-10-01 10:40:53'),
(4607, 'LX', 'TRUN', 'Template Run Action', 'Template Run Action', '', 0, 'EBMS', NULL, '2019-10-01 16:11:07', '0.00', 1, 2, '2019-10-01 10:41:07'),
(4608, 'LX', 'ARUT', 'a_series router action', 'a_series router action', '', 0, 'EBMS', NULL, '2019-10-01 16:11:24', '0.00', 1, 2, '2019-10-01 10:41:24'),
(4609, 'LX', 'FSER', 'Form Series (f_series) Actions', '', '4602,4603,4604,4605', NULL, 'EBAX', NULL, '2019-10-01 16:13:22', NULL, 1, 2, '2019-10-01 10:46:01'),
(4610, 'LX', 'DSER', 'Desk Series(d_series) Action', '', '4594,4595,4596,4597,4598,4599,4600,4601', NULL, 'EBAX', NULL, '2019-10-01 16:14:30', NULL, 1, 2, '2019-10-01 10:45:34'),
(4611, 'LX', 'TSER', 'Template Series (t_series) Action', '', '4606,4607', NULL, 'EBAX', NULL, '2019-10-01 16:14:47', NULL, 1, 2, '2019-10-01 10:46:27'),
(4612, 'LX', 'ASER', 'Ajax Series (a_series) Actions', '', '4608', NULL, 'EBAX', NULL, '2019-10-01 16:15:07', NULL, 1, 2, '2019-10-01 10:46:48'),
(4792, 'EB', 'EBUC', 'Un-Classified', '', '', 0, 'EBMS', NULL, '2020-01-26 17:39:16', '1.00', 1, 2, '2020-01-26 12:09:16'),
(4793, 'EB', 'EBMS', 'Master', '', '', 0, 'EBMS', NULL, '2020-01-26 17:39:34', '2.00', 1, 2, '2020-01-26 12:09:34'),
(4794, 'EB', 'EBAT', 'Attribute', '', '', 0, 'EBMS', NULL, '2020-01-26 17:39:51', '3.00', 1, 2, '2020-01-26 12:09:51'),
(4795, 'EB', 'EBDF', 'Defination', '', '', 0, 'EBMS', NULL, '2020-01-26 17:40:15', '4.00', 1, 2, '2020-01-26 12:10:15'),
(4796, 'EB', 'EBAX', 'Apex Entity', '', '', 0, 'EBMS', NULL, '2020-01-26 17:40:37', '5.00', 1, 2, '2020-01-26 12:10:37'),
(4797, 'EB', 'EBFA', 'Free Attribute', '', '', 0, 'EBMS', NULL, '2020-01-26 17:41:11', '6.00', 1, 2, '2020-01-26 12:11:11'),
(4798, 'EB', 'EBPC', 'Page Content Things', '', '', 0, 'EBMS', NULL, '2020-01-26 17:41:25', '7.00', 1, 2, '2020-01-26 12:11:25'),
(4799, 'EB', 'EBGR', 'Grouping', '', '', 0, 'EBMS', NULL, '2020-01-26 17:41:56', '8.00', 1, 2, '2020-01-26 12:11:56'),
(4878, 'IT', 'ITTX', 'varchar', 'Text', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '1.00', 1, 2, '2020-04-25 23:36:49'),
(4879, 'IT', 'ITNM', 'decimal', 'Decimal Number', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '2.00', 1, 2, '2020-04-25 23:36:49'),
(4880, 'IT', 'ITHD', '', 'Heading', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '3.00', 1, 2, '2020-04-25 23:36:49'),
(4881, 'IT', 'ITRG', 'varchar', 'Range', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '4.00', 1, 2, '2020-04-25 23:36:49'),
(4882, 'IT', 'ITTB', 'varchar', 'Twin Box', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '5.00', 1, 2, '2020-04-25 23:36:49'),
(4883, 'IT', 'ITSL', 'varchar', 'Simple List', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '6.00', 1, 2, '2020-04-25 23:36:49'),
(4884, 'IT', 'ITDT', 'date', 'Date', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '7.00', 1, 2, '2020-04-25 23:36:49'),
(4885, 'IT', 'ITTA', 'text', 'Textarea', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '8.00', 1, 2, '2020-04-25 23:36:49'),
(4886, 'IT', 'ITFT', 'text', 'Fiben Table', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '9.00', 1, 2, '2020-04-25 23:36:49'),
(4887, 'IT', 'ITSH', '', 'Sub-Heading', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '10.00', 1, 2, '2020-04-25 23:36:49'),
(4888, 'IT', 'ITFI', 'varchar', 'Upload Image', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '11.00', 1, 2, '2020-04-25 23:36:49'),
(4889, 'IT', 'ITFD', 'varchar', 'Upload Document', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '12.00', 1, 2, '2020-04-25 23:36:49'),
(4890, 'IT', 'ITIG', 'num', 'Integer', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '13.00', 1, 2, '2020-04-25 23:36:49'),
(4891, 'IT', 'ITLA', '', 'Label', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '14.00', 1, 2, '2020-04-25 23:36:49'),
(4892, 'IT', 'ITTG', 'bool', 'Toggle Switch', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '15.00', 1, 2, '2020-04-25 23:36:49'),
(4893, 'IT', 'ITTE', 'text', 'Textarea editior', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '16.00', 1, 2, '2020-04-25 23:36:49'),
(4894, 'IT', 'ITCE', 'text', 'Code editor', NULL, NULL, 'EBMS', 2, '0000-00-00 00:00:00', '17.00', 1, 2, '2020-04-25 23:36:49'),
(5720, 'DF', '3b22ce811479788bc926c2bd46201e96', 'demo__direct_perm', 'Demo  Direct Perm', '578,576,577,2533', NULL, 'EBDF', 2, '2020-05-09 14:10:19', NULL, 1, 2, '2020-05-09 14:17:18'),
(5721, 'DF', '9fd233eb7f0e249b20beff515b9b75ed', 'demo__eav', 'Demo  Eav', '578,576,577', NULL, 'EBDF', 2, '2020-05-09 14:10:20', NULL, 1, 2, '2020-05-09 08:40:20'),
(5722, 'DF', 'e99770723fdff6e32f847539dddf18b6', 'demo__flat', 'Demo  Flat', '578,576,577,2533', NULL, 'EBDF', 2, '2020-05-09 14:10:20', NULL, 1, 2, '2020-05-09 08:40:21'),
(5723, 'DF', '101663cb67788ae1a4dffca0ccc87255', 'demo__page', 'Demo  Page', '578,576,577,2533', NULL, 'EBDF', 2, '2020-05-09 14:10:21', NULL, 1, 2, '2020-05-09 08:40:21'),
(5724, 'DF', 'cc7c832a2bf458bfa983b3550899f9d4', 'demo__ui_form', 'Demo  Ui Form', '576,577', NULL, 'EBDF', 2, '2020-05-09 14:10:21', NULL, 1, 2, '2020-05-09 08:40:21'),
(5725, 'DF', '2b6f8370c1827af6d65c092e09440126', 'cms_page_eav', 'Cms Page Eav', '574,573,575,2532', NULL, 'EBDF', 2, '2020-05-09 14:10:22', NULL, 1, 2, '2020-05-09 08:40:22'),
(5726, 'DF', '00e3a642b73fa0a2efa9c5d897f61f04', 'coach_eav', 'Coach Eav', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:22', NULL, 1, 2, '2020-05-09 08:40:22'),
(5727, 'DF', '4ea30eb6097c4b3cf3dded98bfb0a646', 'contact_eav', 'Contact Eav', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:22', NULL, 1, 2, '2020-05-09 08:40:23');
INSERT INTO `entity_child_base` (`id`, `entity_code`, `token`, `sn`, `ln`, `note`, `parent_id`, `dna_code`, `created_by`, `creation`, `line_order`, `is_active`, `user_id`, `timestamp_punch`) VALUES
(5728, 'DF', '2dbe858ecccec277952229941bd8bf79', 'db_report', 'Db Report', '2532', NULL, 'EBDF', 2, '2020-05-09 14:10:23', NULL, 1, 2, '2020-05-09 08:40:23'),
(5729, 'DF', '0cd249783d978963c1e70d7770b972be', 'def', 'Def', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:23', NULL, 1, 2, '2020-05-09 08:40:23'),
(5730, 'DF', '9a247f26e30ff9633b7b4f42be0275ae', 'def__external', 'Def  External', '573,575,2532', NULL, 'EBDF', 2, '2020-05-09 14:10:23', NULL, 1, 2, '2020-05-10 00:10:11'),
(5731, 'DF', 'b4ab841be4f377c3305941b5dbe19be8', 'ecb_parent_child', 'Ecb Parent Child', '575', NULL, 'EBDF', 2, '2020-05-09 14:10:24', NULL, 1, 2, '2020-05-09 08:40:24'),
(5732, 'DF', '24f9ee458eb09d3f0c34e475b5a3386f', 'entity', 'Entity', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:24', NULL, 1, 2, '2020-05-09 08:40:24'),
(5733, 'DF', '5a691f930a792c3a27bc14fe9a438085', 'entity__eav__export', 'Entity  Eav  Export', '2532', NULL, 'EBDF', 2, '2020-05-09 14:10:24', NULL, 1, 2, '2020-05-09 08:40:24'),
(5734, 'DF', '7fc931d4d310ae7846e63a1d6a16cf48', 'entity_attribute', 'Entity Attribute', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:24', NULL, 1, 2, '2020-05-09 08:40:25'),
(5735, 'DF', 'be4e9baf5dc90b21f67fe6f89324118b', 'entity_child', 'Entity Child', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:25', NULL, 1, 2, '2020-05-09 08:40:25'),
(5736, 'DF', '931ebc01741b98b9b29c5e578a665402', 'entity_child_addon', 'Entity Child Addon', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:25', NULL, 1, 2, '2020-05-09 08:40:26'),
(5737, 'DF', '083d1f8b9522a64e07fdc7826d152237', 'entity_child_base', 'Entity Child Base', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:26', NULL, 1, 2, '2020-05-09 08:40:26'),
(5738, 'DF', 'aa48103f9f7e75553af4af662bc5d19e', 'entity_child_eav', 'Entity Child Eav', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:26', NULL, 1, 2, '2020-05-09 08:40:27'),
(5739, 'DF', 'd985c5bfc9763c18840936d24fefd8e3', 'entity_child_of_child', 'Entity Child Of Child', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:27', NULL, 1, 2, '2020-05-09 08:40:27'),
(5740, 'DF', '271ff4a10bd49b96f7d3fc7689516267', 'entity_dash_board', 'Entity Dash Board', '573', NULL, 'EBDF', 2, '2020-05-09 14:10:27', NULL, 1, 2, '2020-05-09 08:40:27'),
(5741, 'DF', '5bd070c2ec838135bb69bd320e68a8eb', 'entity_grouping', 'Entity Grouping', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:27', NULL, 1, 2, '2020-05-09 08:40:27'),
(5742, 'DF', 'aacb61f6edae773aa315c3cfc060b38d', 'entity_key_value', 'Entity Key Value', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:28', NULL, 1, 2, '2020-05-09 08:40:28'),
(5743, 'DF', '5f7a5a41793f69eb8a231d10228cc89d', 'ext_at_addon', 'Ext At Addon', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:28', NULL, 1, 2, '2020-05-09 08:40:28'),
(5744, 'DF', 'e2c522e5ab8bced23c02fd6843c1421c', 'external_attribute', 'External Attribute', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:28', NULL, 1, 2, '2020-05-09 08:40:28'),
(5745, 'DF', 'ea6a0479881f9cbd076d1df88248888b', 'external_entity', 'External Entity', '574,573,575,2532', NULL, 'EBDF', 2, '2020-05-09 14:10:28', NULL, 1, 2, '2020-10-23 00:13:56'),
(5746, 'DF', 'da27e6a3a8488e7b2be3f9828fa2d2b8', 'general', 'General', '574', NULL, 'EBDF', 2, '2020-05-09 14:10:29', NULL, 1, 2, '2020-05-09 08:40:29'),
(5748, 'DF', '0a0b996f19d3eab840fa8e884515a178', 'inline', 'Inline', '573', NULL, 'EBDF', 2, '2020-05-09 14:10:29', NULL, 1, 2, '2020-05-09 08:40:30'),
(5749, 'DF', '8da71ac9fd37ca55b0fa34d3f1331716', 'issue', 'Issue', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:30', NULL, 1, 2, '2020-05-09 08:40:30'),
(5750, 'DF', '666551ed772272ae839d9578bc04a785', 'log_action', 'Log Action', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:30', NULL, 1, 2, '2020-05-09 08:40:30'),
(5751, 'DF', 'f152162cd20b78a9381c2e0eb75c725f', 'manage_def', 'Manage Def', '575', NULL, 'EBDF', 2, '2020-05-09 14:10:30', NULL, 1, 2, '2020-05-09 08:40:31'),
(5752, 'DF', 'cb69142a19f12df3ace936aca2077333', 'master_panel', 'Master Panel', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:31', NULL, 1, 2, '2020-05-09 08:40:31'),
(5753, 'DF', '019d95bf64c25e7280d23dc234fa0a6c', 'mop_v2_eav', 'Mop V2 Eav', '2532', NULL, 'EBDF', 2, '2020-05-09 14:10:31', NULL, 1, 2, '2020-05-09 08:40:31'),
(5754, 'DF', 'b43c0089f63eec2dfbd77615f235ccb5', 'one_page_eav', 'One Page Eav', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:31', NULL, 1, 2, '2020-05-09 08:40:32'),
(5755, 'DF', 'f75ced33228f78bbf8a1965aee3a5f4f', 'opeav__about_us', 'Opeav  About Us', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:32', NULL, 1, 2, '2020-05-09 08:40:32'),
(5756, 'DF', '779926330aa6174567858edaea960082', 'opeav__accordion', 'Opeav  Accordion', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:32', NULL, 1, 2, '2020-05-09 08:40:32'),
(5757, 'DF', 'eda1089e4a6820f39f449f8b16e2cbf5', 'opeav__contact_one_page', 'Opeav  Contact One Page', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:33', NULL, 1, 2, '2020-05-09 08:40:33'),
(5758, 'DF', 'da0dcc1596d623ccdf83c2bcb403d136', 'opeav__home_banner', 'Opeav  Home Banner', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:33', NULL, 1, 2, '2020-05-09 08:40:34'),
(5759, 'DF', '480b919f62619903da59d2d9389f29ea', 'opeav__home_scroller', 'Opeav  Home Scroller', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:34', NULL, 1, 2, '2020-05-09 08:40:34'),
(5760, 'DF', '02ab4c979d2cd0e34b0ccc9d92eedb14', 'opg_v2_eav', 'Opg V2 Eav', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:34', NULL, 1, 2, '2020-05-09 08:40:35'),
(5761, 'DF', 'c158acab349539d7d400657fc6a36292', 'page_addon', 'Page Addon', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:35', NULL, 1, 2, '2020-05-09 08:40:35'),
(5762, 'DF', 'c69ff3643d799ba00ce3a2451ddc9e6e', 'page_addon_attribute', 'Page Addon Attribute', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:35', NULL, 1, 2, '2020-05-09 08:40:36'),
(5763, 'DF', '70add24ce6b5ecb724df306ebecf372c', 'page_addon_view', 'Page Addon View', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:36', NULL, 1, 2, '2020-05-09 08:40:36'),
(5764, 'DF', '074ae030db4d55e4923a0ff7ed284c87', 'page_layout', 'Page Layout', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:36', NULL, 1, 2, '2020-05-09 08:40:36'),
(5765, 'DF', '0c6b633612fc6ad72dfe256b871134f3', 'page_layout__create_html', 'Page Layout  Create Html', '2532', NULL, 'EBDF', 2, '2020-05-09 14:10:36', NULL, 1, 2, '2020-05-09 08:40:37'),
(5766, 'DF', 'c6931df1e2780b2ba3f89e3bf0112e9e', 'page_meta', 'Page Meta', '573', NULL, 'EBDF', 2, '2020-05-09 14:10:37', NULL, 1, 2, '2020-05-09 08:40:37'),
(5767, 'DF', '9169b44cbc5d574283cda281e874e758', 'page_section', 'Page Section', '574,573,575,2532', NULL, 'EBDF', 2, '2020-05-09 14:10:37', NULL, 1, 2, '2020-05-09 08:40:37'),
(5768, 'DF', '8517d9cfffde5a84d650b1c671c1a3ba', 'page_section__set_template', 'Page Section  Set Template', '575', NULL, 'EBDF', 2, '2020-05-09 14:10:37', NULL, 1, 2, '2020-05-09 08:40:37'),
(5769, 'DF', 'f44ce5b571ca2ec32a5d85fc111a1407', 'page_section__template', 'Page Section  Template', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:38', NULL, 1, 2, '2020-05-09 08:40:38'),
(5770, 'DF', 'f72855cce9ce364e8908bdd3b86e3328', 'page_template', 'Page Template', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:38', NULL, 1, 2, '2020-05-09 08:40:38'),
(5771, 'DF', '5f61f65df1fb870c07fe0682447c435d', 'page_template__create_html', 'Page Template  Create Html', '2532', NULL, 'EBDF', 2, '2020-05-09 14:10:38', NULL, 1, 2, '2020-05-09 08:40:38'),
(5772, 'DF', 'd9d8ac41d7992c33c71b438987fa8c92', 'set_pwd', 'Set Pwd', '575', NULL, 'EBDF', 2, '2020-05-09 14:10:38', NULL, 1, 2, '2020-05-09 08:40:39'),
(5773, 'DF', '0209fc4f136bcb504478ae9604f259d2', 'status', 'Status', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:39', NULL, 1, 2, '2020-05-09 08:40:39'),
(5774, 'DF', 'afdc8e3d21bcaa694c020626db522d81', 'status_map', 'Status Map', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:39', NULL, 1, 2, '2020-05-09 08:40:39'),
(5775, 'DF', '9c6bdea6443c8cc1c163b14591a8d32b', 'sys_log', 'Sys Log', '573', NULL, 'EBDF', 2, '2020-05-09 14:10:39', NULL, 1, 2, '2020-05-09 08:40:39'),
(5776, 'DF', '0c26d7ab5fd7b9d90d5bc31f9a20462b', 'theme', 'Theme', '574,573,575,2532', NULL, 'EBDF', 2, '2020-05-09 14:10:39', NULL, 1, 2, '2020-05-09 08:40:40'),
(5777, 'DF', 'f735bd73e78a37c3446d783684c9701c', 'theme__blend', 'Theme  Blend', '573,575,2532', NULL, 'EBDF', 2, '2020-05-09 14:10:40', NULL, 1, 2, '2020-05-09 08:40:40'),
(5778, 'DF', 'ab0fe1dfda415512d267a2deb2588255', 'theme__blend_source', 'Theme  Blend Source', '573,575,2532', NULL, 'EBDF', 2, '2020-05-09 14:10:41', NULL, 1, 2, '2020-05-09 08:40:41'),
(5779, 'DF', 'faa6d890eddb418c66def8e06e7086cc', 'user_neutral', 'User Neutral', '574,573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:41', NULL, 1, 2, '2020-05-09 08:40:42'),
(5780, 'DF', 'c7466dda8e37e1a749f99596803bfc5e', 'user_role', 'User Role', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:42', NULL, 1, 2, '2020-05-09 08:40:42'),
(5781, 'DF', 'c62ac158e8e25b9faeb44a61024ae436', 'user_role_page', 'User Role Page', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:42', NULL, 1, 2, '2020-05-09 08:40:43'),
(5782, 'DF', '3fd785fcb163f8f9ee8fdc34d3883c11', 'user_role_permission', 'User Role Permission', '573,575', NULL, 'EBDF', 2, '2020-05-09 14:10:43', NULL, 1, 2, '2020-05-09 08:40:43'),
(5800, 'DF', 'c69075a22935a48a642a43c8b9cfc076', 'def__entity_auto__form', 'Def Entity Auto Form Generation', '2532', NULL, 'EBDF', NULL, '2020-05-10 05:41:13', NULL, 1, 2, '2020-05-10 00:11:13'),
(5806, 'DF', '65d045a2cae03b196fe6a90fcfe63cad', 'def__entity_auto__desk', 'Def Entity Auto Desk Generation', '2532', NULL, 'EBDF', NULL, '2020-05-11 16:28:38', NULL, 1, 2, '2020-05-11 11:05:20'),
(5836, 'DF', 'faa127315162d2483cfffb2a16ea0b1c', 'entity__eav__import', 'Entity EAV Import', '575', NULL, 'EBDF', NULL, '2020-05-22 19:41:14', NULL, 1, 2, '2020-05-22 14:13:28'),
(5840, 'SC', NULL, 'Basic', NULL, '<TMPL_LOOP DATA_INFO>\r\n  <h2><TMPL_VAR HEADING></h4>\r\n    <h4><TMPL_VAR SUB_HEADING></h4>\r\n      <p><TMPL_VAR DETAIL></p>\r\n</TMPL_LOOP>', NULL, 'EBMS', NULL, '2020-06-15 17:11:41', NULL, 1, 2, '2021-03-03 05:41:34'),
(5844, 'FT', 'FTTX', 'Text Base', 'Text Base', '', NULL, 'EBAT', NULL, '2020-10-19 11:55:30', '0.00', 1, 2, '2021-05-19 17:14:29'),
(5845, 'FT', 'FTTA', 'Text Area', 'Text Area', NULL, NULL, 'EBAT', NULL, '2020-10-19 11:55:30', '0.00', 1, 2, '2020-10-19 06:25:30'),
(5846, 'FT', 'FTBOOL', 'Boolean', 'Boolean', NULL, NULL, 'EBAT', NULL, '2020-10-19 11:55:30', '0.00', 1, 2, '2020-10-19 06:25:30'),
(5847, 'DF', 'c8cad4940002ee0da7d0ac13b31bad4a', 'demo__eav__export', 'Export', '2533', NULL, 'EBDF', NULL, '2020-10-24 22:13:01', NULL, 1, 2, '2020-10-24 16:43:01'),
(5848, 'FT', 'FTSEL', 'Select Base', 'Select Base', '', NULL, 'EBAT', NULL, '2021-05-19 22:42:57', '4.00', 1, 2, '2021-05-19 17:12:57'),
(5849, 'GN', 'GNFM', 'Female', 'Female', '', NULL, 'EBMS', 2, '2021-05-19 23:04:21', '1.00', 1, 2, '2021-05-19 17:34:21'),
(5850, 'GN', 'GNMA', 'Male', 'Male', '', NULL, 'EBMS', 2, '2021-05-19 23:04:37', '2.00', 1, 2, '2021-05-19 17:34:37'),
(5851, 'GN', 'GNTG', 'Transgender', 'Transgender', '', NULL, 'EBMS', 2, '2021-05-19 23:05:17', '3.00', 1, 2, '2021-05-19 17:35:17'),
(5852, 'TK', 'TKPTNA', 'Patient Name', 'Patient Name', '', NULL, 'EBAT', NULL, '2021-05-19 23:06:33', '1.00', 1, 2, '2021-05-19 17:36:33'),
(5853, 'TK', 'TKPTADDR', 'Patient Address', 'Patient Address', '', NULL, 'EBAT', NULL, '2021-05-19 23:07:35', '2.00', 1, 2, '2021-05-19 17:37:35'),
(5854, 'TK', 'TKPTAPIN', 'Patient Address PIN', 'Patient Address PIN', '', NULL, 'EBAT', NULL, '2021-05-19 23:08:59', '3.00', 1, 2, '2021-05-19 17:38:59'),
(5855, 'TK', 'TKPTAG', 'Patient Age', 'Patient Age', '', NULL, 'EBAT', NULL, '2021-05-19 23:09:53', '4.00', 1, 2, '2021-05-19 17:39:53'),
(5856, 'TK', 'TKPTCNA', 'Patient Contact No.', 'Patient Contact No.', '', NULL, 'EBAT', NULL, '2021-05-19 23:11:05', '6.00', 1, 2, '2021-05-19 17:44:36'),
(5857, 'TK', 'TKPTGN', 'Gender', 'Gender', '', NULL, 'EBAT', NULL, '2021-05-19 23:13:32', '5.00', 1, 2, '2021-05-19 17:45:05'),
(5858, 'TK', 'TKPTCNB', 'Alternative Mobile No.', 'Alternative Mobile No.', '', NULL, 'EBAT', NULL, '2021-05-19 23:16:53', '7.00', 1, 2, '2021-05-19 17:46:53'),
(5859, 'TK', 'TKPTATNA', 'Attendant Name', 'Attendant Name', '', NULL, 'EBAT', NULL, '2021-05-19 23:17:57', '8.00', 1, 2, '2021-05-19 17:50:46'),
(5860, 'TK', 'TKPTATCN', 'Attendant Contact No..', 'Attendant Contact No..', '', NULL, 'EBAT', NULL, '2021-05-19 23:19:20', '9.00', 1, 2, '2021-05-19 17:49:20'),
(5861, 'TKCT', 'TKCTPS', 'Positive', 'Positive', '', NULL, 'EBMS', 2, '2021-05-19 23:31:12', '1.00', 1, 2, '2021-05-19 18:01:12'),
(5862, 'TKCT', 'TKCTNS', 'Negative', 'Negative', '', NULL, 'EBMS', 2, '2021-05-19 23:31:53', '2.00', 1, 2, '2021-05-19 18:01:53'),
(5863, 'TKCT', 'TKCTNT', 'Not Tested', '', '', NULL, 'EBMS', 2, '2021-05-19 23:32:17', '2.00', 1, 2, '2021-05-19 18:02:17'),
(5864, 'TK', 'TKCTRES', 'Covid-19 Test Result', 'Covid-19 Test Result', '', NULL, 'EBAT', NULL, '2021-05-19 23:35:04', '10.00', 1, 2, '2021-05-19 18:05:04'),
(5865, 'DF', '10bb55d0153086ac0293fd753e89c5ed', 'ticket__base', 'Ticket', '578,576,577,2533', NULL, 'EBDF', NULL, '2021-05-19 23:41:18', NULL, 1, 2, '2021-05-19 18:13:04'),
(5866, 'TKSC', 'TKSCSA', 'Sara', 'Sara', '', NULL, 'EBMS', 2, '2021-05-20 00:17:05', '1.00', 1, 2, '2021-05-19 18:47:05'),
(5867, 'TKSC', 'TKSCCV', 'Covid', '', '', NULL, 'EBMS', 2, '2021-05-20 00:17:41', '1.00', 1, 2, '2021-05-19 18:47:41'),
(5868, 'TKTW', 'TKTWRAT', 'Rat', '', '', NULL, 'EBMS', 2, '2021-05-20 00:20:08', '1.00', 1, 2, '2021-05-19 18:50:08'),
(5869, 'TKTW', 'TKTWPCR', 'PCR', '', '', NULL, 'EBMS', 2, '2021-05-20 00:20:32', '2.00', 1, 2, '2021-05-19 18:50:32'),
(5870, 'TKTW', 'TKTWCTS', 'CT Scan', 'CT Scan', '', NULL, 'EBMS', 2, '2021-05-20 00:21:13', '3.00', 1, 2, '2021-05-19 18:51:13'),
(5871, 'TK', 'TKSACV', 'SARA/Covid', 'SARA/Covid', '', NULL, 'EBAT', NULL, '2021-05-20 00:24:58', '11.00', 1, 2, '2021-05-19 19:00:46'),
(5872, 'TK', 'TKCTWAY', 'Medical ', 'Medical ', '', NULL, 'EBAT', NULL, '2021-05-20 00:25:52', '12.00', 1, 2, '2021-05-19 19:13:15'),
(5873, 'TK', 'TKSRFNO', 'SRF No.', 'SRF No.', '', NULL, 'EBAT', NULL, '2021-05-20 00:27:26', '13.00', 1, 2, '2021-05-19 18:57:26'),
(5874, 'TK', 'TKBUNO', 'BU No.', 'BU No.', '', NULL, 'EBAT', NULL, '2021-05-20 00:33:13', '14.00', 1, 2, '2021-05-19 19:03:13'),
(5875, 'TK', 'TKPTMDCOND', 'Patient Medical Condition', 'Patient Medical Condition', '', NULL, 'EBAT', NULL, '2021-05-20 00:34:20', '15.00', 1, 2, '2021-05-19 19:04:20'),
(5876, 'TK', 'TKHDCV', 'Medical', 'Medical', '', NULL, 'EBAT', NULL, '2021-05-20 00:38:23', '9.10', 1, 2, '2021-05-19 19:09:14'),
(5877, 'TKHH', 'TKHHHM', 'Home', '', '', NULL, 'EBMS', 2, '2021-05-20 05:19:13', '1.00', 1, 2, '2021-05-19 23:49:13'),
(5878, 'TKHH', 'TKHHHS', 'Hospital', 'Hospital', '', NULL, 'EBMS', 2, '2021-05-20 05:19:30', '1.00', 1, 2, '2021-05-19 23:49:30'),
(5879, 'TKBD', 'TKBDGEN', 'General', '', '', NULL, 'EBMS', 2, '2021-05-20 05:20:27', '1.00', 1, 2, '2021-05-19 23:50:27'),
(5880, 'TKBD', 'TKBDHDU', 'HDU', 'HDU', '', NULL, 'EBMS', 2, '2021-05-20 05:20:46', '1.00', 1, 2, '2021-05-19 23:50:46'),
(5881, 'TKBD', 'TKBDICU', 'ICU', 'ICU', '', NULL, 'EBMS', 2, '2021-05-20 05:21:00', '2.00', 1, 2, '2021-05-19 23:51:00'),
(5882, 'TKBD', 'TKBDICV', 'ICU with Ventilatoor', 'ICU with Ventilator', '', NULL, 'EBMS', 2, '2021-05-20 05:21:37', '3.00', 1, 2, '2021-05-19 23:51:37'),
(5883, 'TKTR', 'TKTRRNR', 'RNR', 'RNR', '', NULL, 'EBMS', 2, '2021-05-20 05:22:38', '1.00', 1, 2, '2021-05-19 23:52:38'),
(5884, 'TKTR', 'TKTRBSY', 'Busy', 'Busy', '', NULL, 'EBMS', 2, '2021-05-20 05:22:52', '1.00', 1, 2, '2021-05-19 23:52:52'),
(5885, 'TKHS', 'TKHSNA', 'Name', 'Name', '', NULL, 'EBAT', NULL, '2021-05-20 05:25:07', '1.00', 1, 2, '2021-05-19 23:55:07'),
(5886, 'TKZN', 'TKZNNA', 'Name', 'Name', '', NULL, 'EBAT', NULL, '2021-05-20 05:27:22', '1.00', 1, 2, '2021-05-19 23:57:22'),
(5887, 'TKHT', 'TKHTGH', 'Govt. Hospital', 'Govt. Hospital', '', NULL, 'EBMS', 2, '2021-05-20 05:32:31', '1.00', 1, 2, '2021-05-20 00:02:31'),
(5888, 'TKHT', 'TKHTGM', 'Govt. Medical College', 'Govt. Medical College\r\n', '', NULL, 'EBMS', 2, '2021-05-20 05:32:57', '1.00', 1, 2, '2021-05-20 00:02:57'),
(5889, 'TKHT', 'TKHTPH', 'Private Hospital', 'Private Hospital\r\n', '', NULL, 'EBMS', 2, '2021-05-20 05:33:18', '2.00', 1, 2, '2021-05-20 00:03:18'),
(5890, 'TKHT', 'TKHTPM', 'Private Medical College', 'Private Medical College\r\n', '', NULL, 'EBMS', 2, '2021-05-20 05:33:40', '3.00', 1, 2, '2021-05-20 00:03:40'),
(5891, 'TKHT', 'TKHTCC', 'Covid Care Center', 'Covid Care Center\r\n', '', NULL, 'EBMS', 2, '2021-05-20 05:33:58', '4.00', 1, 2, '2021-05-20 00:03:58'),
(5892, 'TKHS', 'TKHSTY', 'Type', 'Type', '', NULL, 'EBAT', NULL, '2021-05-20 05:37:33', '2.00', 1, 2, '2021-05-20 00:07:33'),
(5893, 'TK', 'TKPTHH', 'Presently Patient at Home / Hospital', 'Presently Patient at Home / Hospital', '', NULL, 'EBAT', NULL, '2021-05-20 05:39:53', '17.00', 1, 2, '2021-05-20 00:09:53'),
(5894, 'TK', 'TKPTHS', 'Hospital', 'Hospital', '', NULL, 'EBAT', NULL, '2021-05-20 05:42:43', '18.00', 1, 2, '2021-05-20 00:12:43'),
(5895, 'TK', 'TKAGNREM', 'Agent Remarks', 'Agent Remarks', '', NULL, 'EBAT', NULL, '2021-05-20 05:46:38', '19.00', 1, 2, '2021-05-20 00:16:38'),
(5896, 'TK', 'TKPTBD', 'Bed Details', 'Bed Details', '', NULL, 'EBAT', NULL, '2021-05-20 05:47:54', '20.00', 1, 2, '2021-05-20 00:17:54'),
(5897, 'TK', 'TKPTZN', 'Zone No.', 'Zone No.', '', NULL, 'EBAT', NULL, '2021-05-20 05:50:43', '21.00', 1, 2, '2021-05-20 00:20:43'),
(5898, 'TK', 'TKPTZN', 'Zone', 'Zone', '', NULL, 'EBAT', NULL, '2021-05-20 05:51:50', '22.00', 1, 2, '2021-05-20 00:21:50'),
(5899, 'TK', 'TKTR', 'Transfer Status', 'Transfer Status', '', NULL, 'EBAT', NULL, '2021-05-20 05:53:14', '23.00', 1, 2, '2021-05-20 00:23:14'),
(5900, 'TKSL', 'TKSLGEN', 'General', 'General', '', NULL, 'EBMS', 2, '2021-05-20 06:12:29', '1.00', 1, 2, '2021-05-20 00:42:29'),
(5901, 'TKSL', 'TKSLCAN', 'Cancer', 'Cancer', '', NULL, 'EBMS', 2, '2021-05-20 06:12:49', '2.00', 1, 2, '2021-05-20 00:42:49'),
(5902, 'YN', 'YNY', 'Yes', 'Yes', '', NULL, 'EBMS', 2, '2021-05-20 06:13:53', '1.00', 1, 2, '2021-05-20 00:43:53'),
(5903, 'YN', 'YNN', 'No', 'No', '', NULL, 'EBMS', 2, '2021-05-20 06:14:07', '2.00', 1, 2, '2021-05-20 00:44:07'),
(5904, 'TKDT', 'TKDTRSTCLO', 'Closed', 'Closed', '', NULL, 'EBMS', 2, '2021-05-20 06:15:59', '1.00', 1, 2, '2021-05-20 00:45:59'),
(5905, 'TKDT', 'TKDTRSTFWD', 'Forwarded', '', '', NULL, 'EBMS', 2, '2021-05-20 06:16:30', '2.00', 1, 2, '2021-05-20 00:47:23'),
(5906, 'TK', 'TKPTSL', 'Severty Level', 'Severty Level', '', NULL, 'EBAT', NULL, '2021-05-20 06:19:57', '24.00', 1, 2, '2021-05-20 00:49:57'),
(5907, 'TK', 'TKPTCO25', 'CORADS/25', 'CORADS/25', '', NULL, 'EBAT', NULL, '2021-05-20 06:20:46', '25.00', 1, 2, '2021-05-20 00:50:46'),
(5908, 'TK', 'TKPTSATRA', 'Saturation in Room Air', 'Saturation in Room Air', '', NULL, 'EBAT', NULL, '2021-05-20 06:21:23', '26.00', 1, 2, '2021-05-20 00:51:23'),
(5909, 'TK', 'TKPTSATOXY', 'Saturation with Oxygen (Volume)', 'Saturation with Oxygen (Volume)', '', NULL, 'EBAT', NULL, '2021-05-20 06:22:15', '27.00', 1, 2, '2021-05-20 00:52:15'),
(5910, 'TK', 'TKPTCOMOR', 'Co-Morbidities', 'Co-Morbidities', '', NULL, 'EBAT', NULL, '2021-05-20 06:24:24', '28.00', 1, 2, '2021-05-20 00:54:24'),
(5911, 'TK', 'TKPTSL', 'Speciality', 'Speciality', '', NULL, 'EBAT', NULL, '2021-05-20 06:25:12', '29.00', 1, 2, '2021-05-20 00:55:12'),
(5912, 'TK', 'TKPTDTRBD', 'Bed type', 'Bed type', '', NULL, 'EBAT', NULL, '2021-05-20 06:27:10', '30.00', 1, 2, '2021-05-20 00:57:10'),
(5913, 'TK', 'TKPTTRAG', 'Triage Done', 'Triage Done', '', NULL, 'EBAT', NULL, '2021-05-20 06:27:49', '31.00', 1, 2, '2021-05-20 00:57:49'),
(5914, 'TK', 'TKPTCF', 'Call forwarded to 108/SAST', 'Call forwarded to 108/SAST', '', NULL, 'EBAT', NULL, '2021-05-20 06:28:32', '32.00', 1, 2, '2021-05-20 00:58:32'),
(5915, 'TK', 'TKPTTRBB108', 'BBMP/108 Triage Done', 'BBMP/108 Triage Done', '', NULL, 'EBAT', NULL, '2021-05-20 06:29:08', '33.00', 1, 2, '2021-05-20 00:59:08'),
(5916, 'TK', 'TKPTBDDT', 'Bed allocation details', 'Bed allocation details', '', NULL, 'EBAT', NULL, '2021-05-20 06:31:19', '34.00', 1, 2, '2021-05-20 01:01:19'),
(5917, 'TK', 'TKPTDTRHS', 'Bed allotted Hospital', 'Bed allotted Hospital', '', NULL, 'EBAT', NULL, '2021-05-20 06:32:26', '35.00', 1, 2, '2021-05-20 01:02:26'),
(5918, 'TK', 'TKPTDTRST', 'Status', 'Status', '', NULL, 'EBAT', NULL, '2021-05-20 06:34:10', '36.00', 1, 2, '2021-05-20 01:04:10'),
(5919, 'TK', 'TKPTDTRREM', 'Doctors Remark', 'Doctors Remark', '', NULL, 'EBAT', NULL, '2021-05-20 06:35:15', '37.00', 1, 2, '2021-05-20 01:05:15'),
(5920, 'TK', 'TKPTDTR', 'Doctor', 'Doctor', '', NULL, 'EBAT', NULL, '2021-05-20 06:38:02', '38.00', 1, 2, '2021-05-20 01:08:02'),
(5921, 'TK', 'TKHDDTR', 'Doctors Section', 'Doctors Section', '', NULL, 'EBAT', NULL, '2021-05-20 06:39:40', '23.10', 1, 2, '2021-05-20 01:10:05');

--
-- Triggers `entity_child_base`
--
DELIMITER $$
CREATE TRIGGER `trg_entity_child_base_before_ins` BEFORE INSERT ON `entity_child_base` FOR EACH ROW BEGIN

IF(LENGTH(new.token)=0) THEN

        

            SET new.token=((SELECT id FROM entity_child_base ORDER BY id DESC LIMIT 0,1)+1);

            

            END IF;

  

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_entity_child_base_before_upd` BEFORE UPDATE ON `entity_child_base` FOR EACH ROW BEGIN



    IF(LENGTH(new.token)=0) THEN        

            SET new.token = concat(new.token,'');

    END IF; 

    

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `entity_count`
-- (See below for the actual view)
--
CREATE TABLE `entity_count` (
`entity_code` varchar(4)
,`count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `entity_ec_count`
-- (See below for the actual view)
--
CREATE TABLE `entity_ec_count` (
`code` varchar(4)
,`sn` varchar(64)
,`count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `entity_internal_external`
-- (See below for the actual view)
--
CREATE TABLE `entity_internal_external` (
`entity` varchar(8)
,`total_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `entity_key_value`
--

CREATE TABLE `entity_key_value` (
  `id` int(11) NOT NULL,
  `coach_id` int(11) DEFAULT NULL,
  `entity_code` varchar(4) DEFAULT NULL,
  `domain_hash` varchar(32) DEFAULT NULL,
  `entity_key` varchar(128) DEFAULT NULL,
  `entity_value` varchar(256) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `entity_key_value`
--

INSERT INTO `entity_key_value` (`id`, `coach_id`, `entity_code`, `domain_hash`, `entity_key`, `entity_value`, `creation`, `user_id`, `timestamp_punch`) VALUES
(13, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'default_gx', '1', '2017-04-10 15:12:39', 2, '2019-01-10 06:42:54'),
(16, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'page_img_a_path', 'images/', '2017-07-11 12:23:44', 2, '2019-01-03 15:24:54'),
(17, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'page_img_a_size', '{\"350\":\"350\",\"100\":\"100\"}', '2017-07-11 12:25:26', 2, '2019-01-03 15:25:06'),
(18, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'page_img_b_path', 'images/', '2017-07-12 11:47:51', 2, '2019-01-03 15:18:37'),
(19, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'page_img_b_size', '{\"1600\":\"375\"}', '2017-07-12 11:48:22', 2, '2020-06-15 11:19:53'),
(20, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'page_img_c_path', 'images/', '2017-07-12 11:48:49', 2, '2019-01-03 15:25:22'),
(42, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'any_id', '1', '2019-01-07 12:22:02', 2, '2019-05-20 11:44:46'),
(43, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'meta_title', 'Covid Support Helpdesk(1912) - System', '2019-01-08 13:10:54', 2, '2021-05-19 17:32:18'),
(44, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'meta_keywords', 'Covid Support Helpdesk(1912) - System', '2019-01-08 13:11:47', 2, '2021-05-19 17:32:20'),
(45, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'meta_description', 'Covid Support Helpdesk(1912) - System', '2019-01-08 13:17:43', 2, '2021-05-19 17:32:22'),
(46, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'default_footer', 'Covid Support Helpdesk(1912) - System', '2019-01-08 14:05:51', 2, '2021-05-19 17:32:24'),
(55, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'logo_size', '{\"270\":\"99\"}', '2019-02-02 11:21:42', 2, '2019-09-21 13:54:13'),
(56, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'home_banner_img', '{\"1600\":\"450\"}', '2019-02-02 17:46:23', 2, '2019-05-20 11:44:46'),
(57, 3655, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'page_img_c_size', ' {\"290:\"81\"}', '2019-02-02 18:41:55', 2, '2019-09-21 13:51:40'),
(58, NULL, 'MP', 'c21f969b5f03d33d43e04f8f136e7682', 'aboutus_image_size', '{\"600\":\"400\"}', '2019-09-12 14:55:17', 2, '2019-09-17 13:19:34');

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_bool`
--

CREATE TABLE `exav_addon_bool` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `exa_value` tinyint(1) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exav_addon_bool`
--

INSERT INTO `exav_addon_bool` (`id`, `parent_id`, `exa_token`, `exa_value`, `user_id`, `timestamp_punch`) VALUES
(1, 5276, 'FTBOOL', 1, 2, '2021-05-19 17:13:16');

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_date`
--

CREATE TABLE `exav_addon_date` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `exa_value` date DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_decimal`
--

CREATE TABLE `exav_addon_decimal` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `exa_value` decimal(14,4) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_ec_id`
--

CREATE TABLE `exav_addon_ec_id` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `ec_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_exa_token`
--

CREATE TABLE `exav_addon_exa_token` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `exa_value_token` varchar(32) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_num`
--

CREATE TABLE `exav_addon_num` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `exa_value` int(16) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exav_addon_num`
--

INSERT INTO `exav_addon_num` (`id`, `parent_id`, `exa_token`, `exa_value`, `user_id`, `timestamp_punch`) VALUES
(44, 3948, 'OPSS', 1, 2, '2018-12-27 06:44:49'),
(45, 3974, 'OPSS', 1, 2, '2019-01-03 07:54:49'),
(99, 4618, 'OPSS', 1, 2, '2019-02-01 12:29:38'),
(100, 3894, 'OPSS', 1, 2, '2019-02-01 12:30:04'),
(149, 3872, 'OPSS', 0, 2, '2019-11-14 11:37:30');

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_text`
--

CREATE TABLE `exav_addon_text` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `exa_value` text,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exav_addon_text`
--

INSERT INTO `exav_addon_text` (`id`, `parent_id`, `exa_token`, `exa_value`, `user_id`, `timestamp_punch`) VALUES
(1591, 5264, 'TEAR', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla faucibus dolor sed sapien pulvinar, ac maximus nunc egestas. Quisque sodales dictum porttitor. Cras arcu erat, ullamcorper nec accumsan eget, posuere sed tellus. Maecenas lacinia ipsum quis ipsum tempus varius. Fusce molestie eros ante, sed faucibus arcu mattis vitae. Sed viverra risus eu purus euismod vulputate. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ultricies pellentesque faucibus. Morbi commodo nunc in felis imperdiet faucibus. Mauris ut justo a tellus elementum ornare. Morbi posuere, sem ornare ultricies egestas, purus dui lobortis diam, tincidunt egestas turpis arcu non erat.</p><div class=\"pad_100_tb\">&nbsp;</div>', 2, '2021-03-03 06:02:02');

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_varchar`
--

CREATE TABLE `exav_addon_varchar` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `exa_value` varchar(1024) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `exav_addon_varchar`
--

INSERT INTO `exav_addon_varchar` (`id`, `parent_id`, `exa_token`, `exa_value`, `user_id`, `timestamp_punch`) VALUES
(752, 5264, 'TEXT', 'Text Title', 2, '2021-03-03 06:02:02'),
(753, 5276, 'FTTX', 'Test', 2, '2021-05-19 17:13:15'),
(754, 5276, 'FTTA', 'Test Area', 2, '2021-05-19 17:13:16'),
(755, 5276, 'FTSEL', 'IUOP', 2, '2021-05-19 17:13:16'),
(776, 5282, 'TKZNNA', 'Anekal', 2, '2021-05-19 23:57:55'),
(777, 5283, 'TKZNNA', 'Bangalore Rural', 2, '2021-05-19 23:58:07'),
(1086, 5571, 'TKHSNA', 'St Philomenas Hospital', 2, '2021-05-20 01:55:55'),
(1087, 5572, 'TKHSNA', 'Sapthagiri Super Speciality Hospital', 2, '2021-05-20 01:55:55'),
(1088, 5573, 'TKHSNA', 'New Janapriya Super Specialty Hospital', 2, '2021-05-20 01:55:55'),
(1089, 5574, 'TKHSNA', 'Rajarajeswari Medicalcollege And Hospital', 2, '2021-05-20 01:55:55'),
(1090, 5575, 'TKHSNA', 'Sri Sai Hospitals', 2, '2021-05-20 01:55:55'),
(1091, 5576, 'TKHSNA', 'Bowring And Lady Curzon Hospitals', 2, '2021-05-20 01:55:55'),
(1092, 5577, 'TKHSNA', 'St Johns Medical College Hospital', 2, '2021-05-20 01:55:55'),
(1093, 5578, 'TKHSNA', 'East Point Hospital', 2, '2021-05-20 01:55:55'),
(1094, 5579, 'TKHSNA', 'General Hospital Kr Puram', 2, '2021-05-20 01:55:55'),
(1095, 5580, 'TKHSNA', 'Mallige Medical Centre Private Limited', 2, '2021-05-20 01:55:55'),
(1096, 5581, 'TKHSNA', 'Shanthi Nagar(primerose) CCC', 2, '2021-05-20 01:55:56'),
(1097, 5582, 'TKHSNA', 'General Hospital Anekal', 2, '2021-05-20 01:55:56'),
(1098, 5583, 'TKHSNA', 'Sakra Hospital', 2, '2021-05-20 01:55:56'),
(1099, 5584, 'TKHSNA', 'Narayana Hrudayalaya Private Limited', 2, '2021-05-20 01:55:56'),
(1100, 5585, 'TKHSNA', 'Vimalalaya Hospital a Unit of Vimalalaya hospital', 2, '2021-05-20 01:55:56'),
(1101, 5586, 'TKHSNA', 'P D HINDUJA SINDHI HOSPITAL', 2, '2021-05-20 01:55:56'),
(1102, 5587, 'TKHSNA', 'BGS Global Institute of Medical Science and Hospital', 2, '2021-05-20 01:55:56'),
(1103, 5588, 'TKHSNA', 'Govt HSIS Gosha Hospital', 2, '2021-05-20 01:55:56'),
(1104, 5589, 'TKHSNA', 'M S Ramaiah Hospital', 2, '2021-05-20 01:55:56'),
(1105, 5590, 'TKHSNA', 'Rangadore hospital', 2, '2021-05-20 01:55:56'),
(1106, 5591, 'TKHSNA', 'Saralaya Hospitals pvt Ltd', 2, '2021-05-20 01:55:56'),
(1107, 5592, 'TKHSNA', 'Vikram Hospital Bengaluru Private Limited', 2, '2021-05-20 01:55:57'),
(1108, 5593, 'TKHSNA', 'Manipal Hospitals Whitefield', 2, '2021-05-20 01:55:57'),
(1109, 5594, 'TKHSNA', 'APOLLO HOSPITALS ENTERPRISE LIMITED', 2, '2021-05-20 01:55:57'),
(1110, 5595, 'TKHSNA', 'Chinmaya Mission Hospital', 2, '2021-05-20 01:55:57'),
(1111, 5596, 'TKHSNA', 'Akash Hospital', 2, '2021-05-20 01:55:57'),
(1112, 5597, 'TKHSNA', 'APOLLO HOSPITALS ENTERPRISES LIMITED SHESHADRIPUR', 2, '2021-05-20 01:55:57'),
(1113, 5598, 'TKHSNA', 'Apoorva Hospitals And Diagnostic Centre', 2, '2021-05-20 01:55:57'),
(1114, 5599, 'TKHSNA', 'Manipal hospital', 2, '2021-05-20 01:55:57'),
(1115, 5600, 'TKHSNA', 'BANGALORE BAPTIST HOSPITAL', 2, '2021-05-20 01:55:57'),
(1116, 5601, 'TKHSNA', 'Dr Malathi Manipal Hospital', 2, '2021-05-20 01:55:57'),
(1117, 5602, 'TKHSNA', 'Dr B R Ambedkar Medical College', 2, '2021-05-20 01:55:57'),
(1118, 5603, 'TKHSNA', 'Manipal Northside Hospital a unit of MHEPL', 2, '2021-05-20 01:55:57'),
(1119, 5604, 'TKHSNA', 'Fortis Hospital Bannerghatta', 2, '2021-05-20 01:55:57'),
(1120, 5605, 'TKHSNA', 'Sri Lakshmi Multi Specialty Hospital', 2, '2021-05-20 01:55:57'),
(1121, 5606, 'TKHSNA', 'City Hospital', 2, '2021-05-20 01:55:58'),
(1122, 5607, 'TKHSNA', 'ST MARTHAS Hospital', 2, '2021-05-20 01:55:58'),
(1123, 5608, 'TKHSNA', 'Sagar Hospitals', 2, '2021-05-20 01:55:58'),
(1124, 5609, 'TKHSNA', 'Vydehi Hospital', 2, '2021-05-20 01:55:58'),
(1125, 5610, 'TKHSNA', 'Unity Lifeline Hospital India Pvt Ltd', 2, '2021-05-20 01:55:58'),
(1126, 5611, 'TKHSNA', 'The Bangalore Hospital', 2, '2021-05-20 01:55:58'),
(1127, 5612, 'TKHSNA', 'MVJ Medical College And Research Hospital', 2, '2021-05-20 01:55:58'),
(1128, 5613, 'TKHSNA', 'CHARAKA SUPER SPECIALITY HOSPITAL', 2, '2021-05-20 01:55:58'),
(1129, 5614, 'TKHSNA', 'SSNMC Super Specialty Hospital', 2, '2021-05-20 01:55:58'),
(1130, 5615, 'TKHSNA', 'Vijayanagar Hospital', 2, '2021-05-20 01:55:58'),
(1131, 5616, 'TKHSNA', 'ASTRA SUPER SPECIALITY HOSPITAL', 2, '2021-05-20 01:55:59'),
(1132, 5617, 'TKHSNA', 'Santosh Hospital', 2, '2021-05-20 01:55:59'),
(1133, 5618, 'TKHSNA', 'FORTIS HOSPITALS', 2, '2021-05-20 01:55:59'),
(1134, 5619, 'TKHSNA', 'Rainbow Childrens Medicare Private Limited', 2, '2021-05-20 01:55:59'),
(1135, 5620, 'TKHSNA', 'KIMS Hospital And Research Center', 2, '2021-05-20 01:55:59'),
(1136, 5621, 'TKHSNA', 'Meenakshi Hospital', 2, '2021-05-20 01:55:59'),
(1137, 5622, 'TKHSNA', 'Columbia Asia Hospital Hebbal', 2, '2021-05-20 01:55:59'),
(1138, 5623, 'TKHSNA', 'Nu Hospitals Pvt Ltd', 2, '2021-05-20 01:55:59'),
(1139, 5624, 'TKHSNA', 'Shankar super speciality hospital', 2, '2021-05-20 01:55:59'),
(1140, 5625, 'TKHSNA', 'SHIFAA HOSPITAL', 2, '2021-05-20 01:55:59'),
(1141, 5626, 'TKHSNA', 'Aster CMI Hospital', 2, '2021-05-20 01:55:59'),
(1142, 5627, 'TKHSNA', 'Aster RV Hospital', 2, '2021-05-20 01:55:59'),
(1143, 5628, 'TKHSNA', 'Apollo Hospitals Bannerghatta A Unit of Imperial Hospital', 2, '2021-05-20 01:56:00'),
(1144, 5629, 'TKHSNA', 'Nandana Health Care Services India Private Limited', 2, '2021-05-20 01:56:00'),
(1145, 5630, 'TKHSNA', 'Mediscope Chest and Super Speciality Hospital', 2, '2021-05-20 01:56:00'),
(1146, 5631, 'TKHSNA', 'ESI Hospital Indiranagar', 2, '2021-05-20 01:56:00'),
(1147, 5632, 'TKHSNA', 'MALLYA HOSPITAL', 2, '2021-05-20 01:56:00'),
(1148, 5633, 'TKHSNA', 'The Oxford Medical College Hospital and Research center', 2, '2021-05-20 01:56:00'),
(1149, 5634, 'TKHSNA', 'Artyem Hospital', 2, '2021-05-20 01:56:00'),
(1150, 5635, 'TKHSNA', 'Ehaa Hospital', 2, '2021-05-20 01:56:00'),
(1151, 5636, 'TKHSNA', 'ST THERESAS HOSPITAL', 2, '2021-05-20 01:56:00'),
(1152, 5637, 'TKHSNA', 'TRUSTWELL HOSPITALS PRIVATE LIMITED', 2, '2021-05-20 01:56:00'),
(1153, 5638, 'TKHSNA', 'Yashomati Hospitals', 2, '2021-05-20 01:56:01'),
(1154, 5639, 'TKHSNA', 'Bhagwan Mahaveer Jain Hospital Girinagar', 2, '2021-05-20 01:56:01'),
(1155, 5640, 'TKHSNA', 'General Hospital Jayanagar', 2, '2021-05-20 01:56:01'),
(1156, 5641, 'TKHSNA', 'HAL', 2, '2021-05-20 01:56:01'),
(1157, 5642, 'TKHSNA', 'BGS GLOBAL HOSPITAL', 2, '2021-05-20 01:56:01'),
(1158, 5643, 'TKHSNA', 'Sir C V Raman General Hopsital Indiranagar', 2, '2021-05-20 01:56:01'),
(1159, 5644, 'TKHSNA', 'Columbia Asia Referral Hospital Yeshwanthpur', 2, '2021-05-20 01:56:01'),
(1160, 5645, 'TKHSNA', 'BROOKEFIELD HOSPITAL', 2, '2021-05-20 01:56:01'),
(1161, 5646, 'TKHSNA', '\"NERGH', 2, '2021-05-20 01:56:01'),
(1162, 5647, 'TKHSNA', 'Agadi Hospital', 2, '2021-05-20 01:56:02'),
(1163, 5648, 'TKHSNA', 'FORTIS HOSPITAL Nagarabhavi', 2, '2021-05-20 01:56:02'),
(1164, 5649, 'TKHSNA', 'GANGA SPECIALTY HOSPITAL', 2, '2021-05-20 01:56:02'),
(1165, 5650, 'TKHSNA', 'Fortis hospital Rajajinagar', 2, '2021-05-20 01:56:02'),
(1166, 5651, 'TKHSNA', 'Pristine Hospital And Research Centre Pvt Ltd', 2, '2021-05-20 01:56:02'),
(1167, 5652, 'TKHSNA', 'Sai Ambica Hospital', 2, '2021-05-20 01:56:02'),
(1168, 5653, 'TKHSNA', 'Columbia Asia Hospital', 2, '2021-05-20 01:56:02'),
(1169, 5654, 'TKHSNA', 'ESIMC PGIMSR MODEL HOSPITAL', 2, '2021-05-20 01:56:02'),
(1170, 5655, 'TKHSNA', 'N R R Hospital', 2, '2021-05-20 01:56:02'),
(1171, 5656, 'TKHSNA', 'Marvel Multispeciality hospital', 2, '2021-05-20 01:56:02'),
(1172, 5657, 'TKHSNA', 'Columbia Asia hospital White Field', 2, '2021-05-20 01:56:02'),
(1173, 5658, 'TKHSNA', 'Vagus Super Speciality Hospital', 2, '2021-05-20 01:56:02'),
(1174, 5659, 'TKHSNA', 'Sri Krishna Sevashrama Hospital', 2, '2021-05-20 01:56:03'),
(1175, 5660, 'TKHSNA', 'Sevakshetra Hospital', 2, '2021-05-20 01:56:03'),
(1176, 5661, 'TKHSNA', 'M S SHEKHAR HOSPITAL', 2, '2021-05-20 01:56:03'),
(1177, 5662, 'TKHSNA', 'Rajshekar Multi Speciality Hospital Pvt Ltd', 2, '2021-05-20 01:56:03'),
(1178, 5663, 'TKHSNA', 'People Tree Hospitals', 2, '2021-05-20 01:56:03'),
(1179, 5664, 'TKHSNA', 'Bhagwan Mahaveer Jain Hospital', 2, '2021-05-20 01:56:03'),
(1180, 5665, 'TKHSNA', 'New varalakshmi hospital', 2, '2021-05-20 01:56:03'),
(1181, 5666, 'TKHSNA', 'Cura Hospital', 2, '2021-05-20 01:56:03'),
(1182, 5667, 'TKHSNA', 'BMS Hospital', 2, '2021-05-20 01:56:03'),
(1183, 5668, 'TKHSNA', 'PM Santosha Hospital', 2, '2021-05-20 01:56:03'),
(1184, 5669, 'TKHSNA', 'Shushrusha Hospital Yelahanka', 2, '2021-05-20 01:56:03'),
(1185, 5670, 'TKHSNA', 'K C General Hospital', 2, '2021-05-20 01:56:04'),
(1186, 5671, 'TKHSNA', 'Prakriya Hospitals A Unit of C Square Healthcare', 2, '2021-05-20 01:56:04'),
(1187, 5672, 'TKHSNA', 'Sreenivasa hospital', 2, '2021-05-20 01:56:04'),
(1188, 5673, 'TKHSNA', 'Excelcare Hospital A Unit of Excelcare Health Alli', 2, '2021-05-20 01:56:04'),
(1189, 5674, 'TKHSNA', 'Vasavi Hospital', 2, '2021-05-20 01:56:04'),
(1190, 5675, 'TKHSNA', 'BANGALORE INSTITUTE OF GASTROENTEROLOGY', 2, '2021-05-20 01:56:04'),
(1191, 5676, 'TKHSNA', 'Karmikara Bhavana CCC', 2, '2021-05-20 01:56:04'),
(1192, 5677, 'TKHSNA', 'V CARE MEDISCON HOSPITAL', 2, '2021-05-20 01:56:04'),
(1193, 5678, 'TKHSNA', 'Kanva Sri Hospital', 2, '2021-05-20 01:56:04'),
(1194, 5679, 'TKHSNA', 'Sri Ashwini Hospital', 2, '2021-05-20 01:56:04'),
(1195, 5680, 'TKHSNA', 'Gayathri Hospitals Pvt Limited', 2, '2021-05-20 01:56:04'),
(1196, 5681, 'TKHSNA', 'Trinity Hospital And Heart Foundation', 2, '2021-05-20 01:56:04'),
(1197, 5682, 'TKHSNA', 'Sanjeevini Hospital', 2, '2021-05-20 01:56:05'),
(1198, 5683, 'TKHSNA', 'Specialist Health System Pvt Limited', 2, '2021-05-20 01:56:05'),
(1199, 5684, 'TKHSNA', 'Government Pre metric  Girls Hostel CCC', 2, '2021-05-20 01:56:05'),
(1200, 5685, 'TKHSNA', 'Ananya Hospital Pvt Ltd Rajajinagar', 2, '2021-05-20 01:56:05'),
(1201, 5686, 'TKHSNA', 'Suguna Hospital Bangalore', 2, '2021-05-20 01:56:05'),
(1202, 5687, 'TKHSNA', 'Navachethana Hospital A Unit of Pan Asia Hospitals', 2, '2021-05-20 01:56:05'),
(1203, 5688, 'TKHSNA', 'Ramaiah Harsha Hospital', 2, '2021-05-20 01:56:05'),
(1204, 5689, 'TKHSNA', 'Leena Multispeciality Hospital', 2, '2021-05-20 01:56:05'),
(1205, 5690, 'TKHSNA', 'General Hospital Yelahanka', 2, '2021-05-20 01:56:05'),
(1206, 5691, 'TKHSNA', 'Victoria Hospital', 2, '2021-05-20 01:56:05'),
(1207, 5692, 'TKHSNA', 'ABHAYA HOSPITAL', 2, '2021-05-20 01:56:06'),
(1208, 5693, 'TKHSNA', 'SI Vega Hospital Private Limited Regal Hospital', 2, '2021-05-20 01:56:06'),
(1209, 5694, 'TKHSNA', 'HBS Hospital Trust', 2, '2021-05-20 01:56:06'),
(1210, 5695, 'TKHSNA', 'Aveksha Hospital', 2, '2021-05-20 01:56:06'),
(1211, 5696, 'TKHSNA', 'Punya Hospitals India pvt Ltd', 2, '2021-05-20 01:56:06'),
(1212, 5697, 'TKHSNA', 'Aaxis Hospital', 2, '2021-05-20 01:56:06'),
(1213, 5698, 'TKHSNA', 'Navya International Covid Care Center', 2, '2021-05-20 01:56:06'),
(1214, 5699, 'TKHSNA', 'Bmcri Ssh Pmssy', 2, '2021-05-20 01:56:06'),
(1215, 5700, 'TKHSNA', 'MEDSTAR SPECIALITY HOSPITAL', 2, '2021-05-20 01:56:06'),
(1216, 5701, 'TKHSNA', 'Government Ayurveda and Medical College', 2, '2021-05-20 01:56:07'),
(1217, 5702, 'TKHSNA', 'Rajmahal Vilas Hospital A Unit of Anjan Nursing Home', 2, '2021-05-20 01:56:07'),
(1218, 5703, 'TKHSNA', 'BLUE BLISS HOSPITAL unit of Lalitha Healthcare P L', 2, '2021-05-20 01:56:07'),
(1219, 5704, 'TKHSNA', 'Jeevika Hospitals Pvt Ltd', 2, '2021-05-20 01:56:07'),
(1220, 5705, 'TKHSNA', 'Unani Hospital', 2, '2021-05-20 01:56:07'),
(1221, 5706, 'TKHSNA', 'EMPLOYEES STATE INSURANCE CORPORATION Peenya', 2, '2021-05-20 01:56:07'),
(1222, 5707, 'TKHSNA', 'SREE SAIPRASAD MULTISPECIALITY HOSPITAL', 2, '2021-05-20 01:56:07'),
(1223, 5708, 'TKHSNA', 'REPUBLIC HOSPITAL', 2, '2021-05-20 01:56:07'),
(1224, 5709, 'TKHSNA', 'Pulse Hospital Kurubarahalli', 2, '2021-05-20 01:56:08'),
(1225, 5710, 'TKHSNA', 'Haj Bhavan', 2, '2021-05-20 01:56:08'),
(1226, 5711, 'TKHSNA', 'Prashanth Hospital', 2, '2021-05-20 01:56:08'),
(1227, 5712, 'TKHSNA', 'TCS Vydehi Covid Care Centre', 2, '2021-05-20 01:56:08');

-- --------------------------------------------------------

--
-- Table structure for table `exav_addon_vc128uniq`
--

CREATE TABLE `exav_addon_vc128uniq` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `exa_token` varchar(32) DEFAULT NULL,
  `exa_value` varchar(128) DEFAULT NULL,
  `exa_value_hash` varchar(32) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `exav_addon_vc128uniq`
--
DELIMITER $$
CREATE TRIGGER `trg_exav_addon_vc128uniq_before_ins` BEFORE INSERT ON `exav_addon_vc128uniq` FOR EACH ROW BEGIN



 IF(LENGTH(new.exa_value)=0) THEN

        

            SET new.exa_value = new.id;

    END IF;        

            SET new.exa_value_hash=md5(concat(new.exa_token,'[C]',new.exa_value));

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_exav_addon_vc128uniq_before_upd` BEFORE UPDATE ON `exav_addon_vc128uniq` FOR EACH ROW BEGIN



     IF(LENGTH(new.exa_value)=0) THEN

        

            SET new.exa_value = new.id;

    END IF;        

            SET new.exa_value_hash=md5(concat(new.exa_token,'[C]',new.exa_value));

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `internal_entity_count`
-- (See below for the actual view)
--
CREATE TABLE `internal_entity_count` (
`entity` varchar(64)
,`total_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `page_view_log_by_day`
-- (See below for the actual view)
--
CREATE TABLE `page_view_log_by_day` (
`date` varchar(10)
,`page_code` varchar(32)
,`total` bigint(21)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `session_by_date`
-- (See below for the actual view)
--
CREATE TABLE `session_by_date` (
`date` varchar(10)
,`total_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `status_info`
--

CREATE TABLE `status_info` (
  `id` int(11) NOT NULL,
  `status_code` varchar(32) DEFAULT NULL,
  `entity_code` varchar(4) DEFAULT NULL,
  `child_comm_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `note` varchar(1024) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `status_map`
--

CREATE TABLE `status_map` (
  `id` int(11) NOT NULL,
  `entity_code` varchar(4) DEFAULT NULL,
  `status_code_start` varchar(32) DEFAULT NULL,
  `status_code_end` varchar(32) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status_map`
--

INSERT INTO `status_map` (`id`, `entity_code`, `status_code_start`, `status_code_end`, `user_id`, `timestamp_punch`) VALUES
(1, 'IU', 'IUOP', 'IUIP', 2, '2018-12-25 07:07:00'),
(2, 'IU', 'IUIP', 'IUTE', 2, '2018-12-25 07:07:00'),
(3, 'IU', 'IUTE', 'IURO', 2, '2018-12-25 07:07:00'),
(4, 'IU', 'IUTE', 'IUCM', 2, '2018-12-25 07:07:00'),
(5, 'IU', 'IURO', 'IUIP', 2, '2018-12-25 07:07:00');

-- --------------------------------------------------------

--
-- Table structure for table `sys_log`
--

CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL,
  `sys_access_ip` varchar(32) DEFAULT NULL,
  `sys_access_name` varchar(32) DEFAULT NULL,
  `page_code` varchar(32) DEFAULT NULL,
  `action` varchar(512) DEFAULT NULL,
  `action_type` varchar(32) DEFAULT NULL,
  `access_key` varchar(128) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Stand-in structure for view `user_engine_sessions`
-- (See below for the actual view)
--
CREATE TABLE `user_engine_sessions` (
`user_name` text
,`desk` bigint(21)
,`form` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE `user_info` (
  `id` int(11) NOT NULL,
  `password` varchar(32) NOT NULL,
  `user_role_id` int(11) DEFAULT NULL,
  `is_mail_check` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_send_mail` tinyint(1) DEFAULT NULL,
  `is_send_welcome_mail` tinyint(1) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_internal` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_info`
--

INSERT INTO `user_info` (`id`, `password`, `user_role_id`, `is_mail_check`, `is_active`, `user_id`, `is_send_mail`, `is_send_welcome_mail`, `timestamp_punch`, `last_login`, `is_internal`) VALUES
(1, '098f6bcd4621d373cade4e832627b4f6', 1, 1, 1, 2, NULL, NULL, '2018-12-25 06:41:20', '0000-00-00 00:00:00', 3865),
(2, '098f6bcd4621d373cade4e832627b4f6', 2, 1, 1, 2, 0, 1, '2018-03-21 11:44:47', '2021-05-20 03:25:53', 1540),
(3, '098f6bcd4621d373cade4e832627b4f6', 3, 0, 1, 2, 0, 0, '2018-12-26 05:02:20', '2020-01-26 06:41:36', 3946),
(4, '098f6bcd4621d373cade4e832627b4f6', 4, 0, 1, 2, 0, 0, '2018-12-26 05:03:07', '2020-01-26 06:38:10', 3947),
(20, '5b01935d6610e7406b928a59c76116af', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:40', '0000-00-00 00:00:00', 5730),
(21, '065dcdccbf5d2100307083f62dc168e7', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:40', '0000-00-00 00:00:00', 5731),
(22, '01efe355e62e6a113c4bb1919da4558c', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:40', '2021-05-20 02:53:57', 5732),
(23, '90c17cd54feab0da4c28c93f203db942', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:40', '0000-00-00 00:00:00', 5733),
(24, '9332ec3f7e49269bd333225c19ebf698', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:40', '0000-00-00 00:00:00', 5734),
(25, '9688149974a580f63394e69b16d89b2a', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:41', '0000-00-00 00:00:00', 5735),
(26, '63b9769ab2324d61ead24df88fc4c00b', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:41', '0000-00-00 00:00:00', 5736),
(27, 'e874e4e3a021cb1f7d9250b80503536f', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:41', '0000-00-00 00:00:00', 5737),
(28, 'b11c5998efb6d5acf45ba105676a372b', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:41', '0000-00-00 00:00:00', 5738),
(29, '13722907d79e5d4f39a2abc283956ef3', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:41', '0000-00-00 00:00:00', 5739),
(30, 'cfc30cf8efd697e7b4179cfaf1f64be6', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:41', '0000-00-00 00:00:00', 5740),
(31, '2fe3baa2ad0b4c040eff91617f85950a', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:41', '0000-00-00 00:00:00', 5741),
(32, '5b931fe0020e9886eec5ac78d02a530d', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:41', '0000-00-00 00:00:00', 5742),
(33, 'aaa0cb314746804988fbc1e0c8b5fc39', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:42', '0000-00-00 00:00:00', 5743),
(34, 'aba2447cb1f4845a9eca2d5e0d1f930e', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:42', '0000-00-00 00:00:00', 5744),
(35, '354cdd5c792f50ce0b42aa8771b86ee1', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:42', '0000-00-00 00:00:00', 5745),
(36, 'e91b24cdf4e0b17d1a57df18d70282d7', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:42', '0000-00-00 00:00:00', 5746),
(37, 'cd8f20cabdb0ddaad17ac606b4158025', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:42', '0000-00-00 00:00:00', 5747),
(38, 'b0f7fab79f5ef224c10c316bc15291ba', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:42', '0000-00-00 00:00:00', 5748),
(39, '14cca1723e04bcab4417b456ed60a169', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:42', '0000-00-00 00:00:00', 5749),
(40, 'e2b641402db40d90073526357f0a581f', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:42', '0000-00-00 00:00:00', 5750),
(41, '144412cac8fc722a4cafb0f03d1faf64', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:43', '0000-00-00 00:00:00', 5751),
(42, '65ad330315c1611279c1b92a8558f555', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:43', '0000-00-00 00:00:00', 5752),
(43, 'c9330185f2080a4afdf649bc001cf831', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:43', '0000-00-00 00:00:00', 5753),
(44, 'b87e86119421d9d2b48665526af6380a', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:43', '0000-00-00 00:00:00', 5754),
(45, '40aaf95a1b1e101b0d576253ddabe51b', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:44', '0000-00-00 00:00:00', 5755),
(46, '5cc3c360deb81d5328e95db1a084aa84', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:44', '0000-00-00 00:00:00', 5756),
(47, '5688cda47811af4bfd2da2ad39cac558', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:44', '0000-00-00 00:00:00', 5757),
(48, '417b36e0824ff3338c72b8499ebf6b1b', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:44', '0000-00-00 00:00:00', 5758),
(49, 'd9b8c0de10be358c44a093d93bab53f9', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:44', '0000-00-00 00:00:00', 5759),
(50, '715c92ff96b0c3d6f2a52f4b4faf2fe4', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:44', '0000-00-00 00:00:00', 5760),
(51, 'f0455ef677c657e7ed16966c80739186', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:44', '0000-00-00 00:00:00', 5761),
(52, '5164589d1b9c72b79d6e11a37a1eb821', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:45', '0000-00-00 00:00:00', 5762),
(53, '18116fe4f1ebacf4680a76e5948c7c7f', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:45', '0000-00-00 00:00:00', 5763),
(54, 'bc4bd6e6f1db06ab2f963d3f66479458', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:45', '0000-00-00 00:00:00', 5764),
(55, '94e58594a1f81ea2d23ae823d9d41d90', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:45', '0000-00-00 00:00:00', 5765),
(56, '559f300537df386d7023c4bb34e6ed09', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:45', '0000-00-00 00:00:00', 5766),
(57, '86c630eca93540a969dde291c74a46bc', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:45', '0000-00-00 00:00:00', 5767),
(58, '5f32d701c816fb5d1fe445a00a47c9f1', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:45', '0000-00-00 00:00:00', 5768),
(59, '059308c90a8ae5fb68dec59ba4a14e13', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:46', '0000-00-00 00:00:00', 5769),
(60, '56936488584685803ddf59168102f225', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:46', '0000-00-00 00:00:00', 5770),
(61, '8a53308c35ff9a8437128fc528346695', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:46', '0000-00-00 00:00:00', 5771),
(62, 'c8c48070128b3a50f05beee4fefd21b1', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:46', '0000-00-00 00:00:00', 5772),
(63, '929d20658b85442a8a6636993ef70865', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:46', '0000-00-00 00:00:00', 5773),
(64, '4da1cb3417398e2790a22c51ca7282fc', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:46', '0000-00-00 00:00:00', 5774),
(65, 'e101cbb2c9b871615aeff848ba536dd7', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:46', '0000-00-00 00:00:00', 5775),
(66, '612bb0367e5b8702ce1a908b52d9fd09', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:46', '0000-00-00 00:00:00', 5776),
(67, 'b3f602ad7422ae58165fd6974b8b4c72', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:47', '0000-00-00 00:00:00', 5777),
(68, '4e96b0ba596b191c760b58c2e73d33fd', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:47', '0000-00-00 00:00:00', 5778),
(69, 'd12a293687ded0bfbb3686573bf8b6c9', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:47', '0000-00-00 00:00:00', 5779),
(70, '2e264985c0d2c618bae88d55ec0f642c', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:47', '0000-00-00 00:00:00', 5780),
(71, 'f484c1a82edc96b057cb6f86032bb274', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:47', '0000-00-00 00:00:00', 5781),
(72, 'fd2b8372cc0118d88e45e4788b7b7828', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:47', '0000-00-00 00:00:00', 5782),
(73, '6912b9472e8163bb397fb91f9073d9a3', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:48', '0000-00-00 00:00:00', 5783),
(74, '2a6c88b31fe03786c5070f43dbc42676', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:48', '0000-00-00 00:00:00', 5784),
(75, '085e65d86a864d7a56353becb0e6cd4c', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:48', '0000-00-00 00:00:00', 5785),
(76, '38a90a20ea22de582123366a332d32f4', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:48', '0000-00-00 00:00:00', 5786),
(77, '38fbf10facf604ef346f27164c4de59a', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:48', '0000-00-00 00:00:00', 5787),
(78, '4722087faef14bebf14f7eadb84b5944', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:48', '0000-00-00 00:00:00', 5788),
(79, '8579b615abcb83e8a74612f3616b0ed1', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:48', '0000-00-00 00:00:00', 5789),
(80, 'b680e21797d46a37faf40ecec3f99be1', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:48', '0000-00-00 00:00:00', 5790),
(81, '0032030f52801c04ea5c83ecce4c877a', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:49', '0000-00-00 00:00:00', 5791),
(82, 'fd408f9236c6d0b6c91cc0f46b8f2bbe', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:49', '0000-00-00 00:00:00', 5792),
(83, '8347decfd92578dc4705debca912c343', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:49', '0000-00-00 00:00:00', 5793),
(84, '52877e1485c4573cb11388673bd105dd', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:49', '0000-00-00 00:00:00', 5794),
(85, '7f7bd25c097caa7e83932085631bcdae', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:49', '0000-00-00 00:00:00', 5795),
(86, '40e88be0dc26e03f83b1b8135114c86a', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:50', '0000-00-00 00:00:00', 5796),
(87, '896c80573a32826fcfdaa38fc931b6ab', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:50', '0000-00-00 00:00:00', 5797),
(88, '3a270eb90c11e046d42668e864b8098c', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:50', '0000-00-00 00:00:00', 5798),
(89, '2ae1f33f8a23e5cebcdf3cb6aa04bcc3', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:50', '0000-00-00 00:00:00', 5799),
(90, '401dd57ec8222a1cb0bbb1b49f6e3bbd', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:50', '0000-00-00 00:00:00', 5800),
(91, 'e3dea9a11ecca02cccf53d2688ce983f', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:50', '0000-00-00 00:00:00', 5801),
(92, '8f3c4acfe20088a6f85d0ee1f2540372', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:51', '0000-00-00 00:00:00', 5802),
(93, 'cff84ce34a39f73eb5c3bade7b363b87', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:51', '0000-00-00 00:00:00', 5803),
(94, '929a3619ae19b48b5888bcb5753356ed', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:51', '0000-00-00 00:00:00', 5804),
(95, '8e561c7278910e46cb7d1e90d5db2ec1', 5, 0, 1, 2, 0, 0, '2021-05-20 02:52:51', '2021-05-20 02:53:29', 5805);

-- --------------------------------------------------------

--
-- Table structure for table `user_info_log`
--

CREATE TABLE `user_info_log` (
  `log_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `password` varchar(32) DEFAULT NULL,
  `user_role_id` int(11) DEFAULT NULL,
  `is_mail_check` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_send_mail` tinyint(1) DEFAULT NULL,
  `is_send_welcome_mail` tinyint(1) DEFAULT NULL,
  `timestamp_punch` datetime DEFAULT NULL,
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `log_type_code` varchar(32) DEFAULT NULL,
  `timestamp_log` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` int(11) NOT NULL,
  `sn` char(3) DEFAULT NULL,
  `ln` varchar(1024) DEFAULT NULL,
  `home_page_url` varchar(256) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`id`, `sn`, `ln`, `home_page_url`, `user_id`, `creation`, `timestamp_punch`) VALUES
(1, 'ANY', 'Anonymous', NULL, 2, '2018-12-25 10:48:29', '2018-12-25 05:18:29'),
(2, 'SAD', 'Super Admin', '?d=entity', 2, '2015-12-03 06:38:21', '2018-12-25 07:07:01'),
(3, 'ADM', 'Admin', '?d=coach_eav', 2, '2015-12-03 06:38:21', '2018-12-28 06:39:36'),
(4, 'BAS', 'Base User', '?dx=demo__flat', 2, '2018-04-16 03:04:16', '2019-11-21 13:08:03'),
(5, 'AGN', 'Agent', '?dx=ticket__base', 2, '2021-05-19 23:46:06', '2021-05-19 18:16:06'),
(6, 'DTR', 'Doctor', '?tx=ticket__base', 2, '2021-05-19 23:46:32', '2021-05-19 18:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `user_role_page`
--

CREATE TABLE `user_role_page` (
  `id` int(11) NOT NULL,
  `user_role_id` int(11) DEFAULT NULL,
  `sn` varchar(256) NOT NULL,
  `user_page_ids` text,
  `line_order` decimal(5,2) NOT NULL,
  `creation` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role_page`
--

INSERT INTO `user_role_page` (`id`, `user_role_id`, `sn`, `user_page_ids`, `line_order`, `creation`, `user_id`, `timestamp_punch`) VALUES
(1, 5, 'Ticket', '9995', '1.00', '0000-00-00 00:00:00', 2, '2021-05-19 18:17:58');

-- --------------------------------------------------------

--
-- Table structure for table `user_role_page_matrix`
--

CREATE TABLE `user_role_page_matrix` (
  `id` int(11) NOT NULL,
  `user_role_page_id` int(11) DEFAULT NULL,
  `user_page_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `sn` varchar(128) DEFAULT NULL,
  `line_order` decimal(5,2) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role_page_matrix`
--

INSERT INTO `user_role_page_matrix` (`id`, `user_role_page_id`, `user_page_id`, `parent_id`, `sn`, `line_order`, `creation`, `user_id`, `timestamp_punch`) VALUES
(1, 1, 9995, 0, 'Ticket', '1.00', '2021-05-19 23:47:58', 2, '2021-05-19 18:17:58');

-- --------------------------------------------------------

--
-- Table structure for table `user_role_permission`
--

CREATE TABLE `user_role_permission` (
  `id` int(11) NOT NULL,
  `user_role_id` int(11) DEFAULT NULL,
  `user_permission_ids` text,
  `creation` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role_permission`
--

INSERT INTO `user_role_permission` (`id`, `user_role_id`, `user_permission_ids`, `creation`, `user_id`, `timestamp_punch`) VALUES
(1, 2, '9781,9782,9783,9784,9785,9786,9787,9788,9789,9790,9791,9792,9793,9794,9795,9796,9797,9798,9799,9800,9801,9802,9803,9804,9805,9806,9809,9810,9811,9812,9813,9814,9815,9816,9817,9818,9819,9820,9821,9822,9823,9824,9825,9826,9827,9828,9829,9830,9831,9832,9833,9834,9835,9836,9837,9838,9839,9840,9841,9845,9848,9849,9850,9851,9852,9853,9854,9855,9856,9857,9858,9859,9860,9861,9862,9863,9864,9865,9866,9867,9868,9869,9870,9871,9872,9873,9874,9875,9876,9877,9878,9879,9880,9881,9882,9883,9884,9885,9886,9887,9888,9889,9890,9891,9892,9893,9894,9895,9896,9897,9898,9899,9900,9901,9902,9903,9904,9905,9906,9907,9908,9909,9910,9911,9912,9913,9914,9915,9916,9921,9922,9923,9924,9955,9956,9957,9958,9974,9977,9981,9982,9983,9984,9985,9994,9995,9996,9997', '0000-00-00 00:00:00', 2, '2021-05-19 18:13:05'),
(2, 3, '9781,9782,9783,9784,9785,9786,9787,9788,9789,9790,9791,9792,9793,9794,9795,9796,9797,9798,9799,9800,9801,9802,9803,9804,9805,9806,9809,9810,9811,9812,9813,9814,9815,9816,9817,9818,9819,9820,9821,9822,9823,9824,9825,9826,9827,9828,9829,9830,9831,9832,9833,9834,9835,9836,9837,9838,9839,9840,9841,9845,9848,9849,9850,9851,9852,9853,9854,9855,9856,9857,9858,9859,9860,9861,9862,9863,9864,9865,9866,9867,9868,9869,9870,9871,9872,9873,9874,9875,9876,9877,9878,9879,9880,9881,9882,9883,9884,9885,9886,9887,9888,9889,9890,9891,9892,9893,9894,9895,9896,9897,9898,9899,9900,9901,9902,9903,9904,9905,9906,9907,9908,9909,9910,9911,9912,9913,9914,9915,9916,9921,9922,9923,9924,9955,9956,9957,9958,9974,9977,9981,9982,9983,9984,9985,9994,9995,9996,9997', '0000-00-00 00:00:00', 2, '2021-05-19 18:13:05'),
(3, 4, '9781,9782,9783,9784,9785,9786,9787,9788,9789,9790,9791,9792,9793,9794,9795,9796,9797,9798,9799,9800,9801,9802,9803,9804,9805,9806,9809,9810,9811,9812,9813,9814,9815,9816,9817,9818,9819,9820,9821,9822,9823,9824,9825,9826,9827,9828,9829,9830,9831,9832,9833,9834,9835,9836,9837,9838,9839,9840,9841,9845,9848,9849,9850,9851,9852,9853,9854,9855,9856,9857,9858,9859,9860,9861,9862,9863,9864,9865,9866,9867,9868,9869,9870,9871,9872,9873,9874,9875,9876,9877,9878,9879,9880,9881,9882,9883,9884,9885,9886,9887,9888,9889,9890,9891,9892,9893,9894,9895,9896,9897,9898,9899,9900,9901,9902,9903,9904,9905,9906,9907,9908,9909,9910,9911,9912,9913,9914,9915,9916,9921,9922,9923,9924,9955,9956,9957,9958,9974,9977,9981,9982,9983,9984,9985,9994,9995,9996,9997', '0000-00-00 00:00:00', 2, '2021-05-19 18:13:05'),
(4, 5, '9994,9995,9996,9997', '0000-00-00 00:00:00', 2, '2021-05-19 18:16:57');

-- --------------------------------------------------------

--
-- Table structure for table `user_role_permission_matrix`
--

CREATE TABLE `user_role_permission_matrix` (
  `id` int(11) NOT NULL,
  `user_role_id` int(11) DEFAULT NULL,
  `user_permission_id` int(11) DEFAULT NULL,
  `creation` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `timestamp_punch` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_role_permission_matrix`
--

INSERT INTO `user_role_permission_matrix` (`id`, `user_role_id`, `user_permission_id`, `creation`, `user_id`, `timestamp_punch`) VALUES
(21670, 2, 9781, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21671, 2, 9782, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21672, 2, 9783, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21673, 2, 9784, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21674, 2, 9785, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21675, 2, 9786, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21676, 2, 9787, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21677, 2, 9788, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21678, 2, 9789, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21679, 2, 9790, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21680, 2, 9791, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21681, 2, 9792, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21682, 2, 9793, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21683, 2, 9794, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21684, 2, 9795, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21685, 2, 9796, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21686, 2, 9797, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21687, 2, 9798, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21688, 2, 9799, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21689, 2, 9800, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21690, 2, 9801, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21691, 2, 9802, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21692, 2, 9803, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21693, 2, 9804, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21694, 2, 9805, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21695, 2, 9806, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21696, 2, 9809, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21697, 2, 9810, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21698, 2, 9811, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21699, 2, 9812, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21700, 2, 9813, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21701, 2, 9814, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21702, 2, 9815, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21703, 2, 9816, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21704, 2, 9817, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21705, 2, 9818, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21706, 2, 9819, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21707, 2, 9820, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21708, 2, 9821, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21709, 2, 9822, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21710, 2, 9823, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21711, 2, 9824, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21712, 2, 9825, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21713, 2, 9826, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21714, 2, 9827, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21715, 2, 9828, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21716, 2, 9829, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21717, 2, 9830, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21718, 2, 9831, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21719, 2, 9832, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21720, 2, 9833, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21721, 2, 9834, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21722, 2, 9835, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21723, 2, 9836, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21724, 2, 9837, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21725, 2, 9838, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21726, 2, 9839, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21727, 2, 9840, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21728, 2, 9841, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21732, 2, 9845, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21733, 2, 9848, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21734, 2, 9849, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21735, 2, 9850, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21736, 2, 9851, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21737, 2, 9852, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21738, 2, 9853, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21739, 2, 9854, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21740, 2, 9855, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21741, 2, 9856, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21742, 2, 9857, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21743, 2, 9858, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21744, 2, 9859, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21745, 2, 9860, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21746, 2, 9861, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21747, 2, 9862, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21748, 2, 9863, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21749, 2, 9864, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21750, 2, 9865, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21751, 2, 9866, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21752, 2, 9867, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21753, 2, 9868, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21754, 2, 9869, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21755, 2, 9870, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21756, 2, 9871, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21757, 2, 9872, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21758, 2, 9873, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21759, 2, 9874, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21760, 2, 9875, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21761, 2, 9876, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21762, 2, 9877, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21763, 2, 9878, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21764, 2, 9879, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21765, 2, 9880, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21766, 2, 9881, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21767, 2, 9882, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21768, 2, 9883, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21769, 2, 9884, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21770, 2, 9885, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21771, 2, 9886, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21772, 2, 9887, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21773, 2, 9888, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21774, 2, 9889, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21775, 2, 9890, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21776, 2, 9891, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21777, 2, 9892, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21778, 2, 9893, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21779, 2, 9894, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21780, 2, 9895, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21781, 2, 9896, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21782, 2, 9897, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21783, 2, 9898, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21784, 2, 9899, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21785, 2, 9900, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21786, 2, 9901, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21787, 2, 9902, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21788, 2, 9903, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21789, 2, 9904, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21790, 2, 9905, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21791, 2, 9906, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21792, 2, 9907, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21793, 2, 9908, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21794, 2, 9909, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21795, 2, 9910, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21796, 2, 9911, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21797, 2, 9912, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21798, 2, 9913, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21799, 2, 9914, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21800, 2, 9915, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21801, 2, 9916, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21802, 2, 9921, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21803, 2, 9922, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21804, 2, 9923, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21805, 2, 9924, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21806, 2, 9955, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21807, 2, 9956, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21808, 2, 9957, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21809, 2, 9958, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21810, 2, 9974, '2020-05-22 19:42:01', 2, '2020-05-22 14:12:01'),
(21812, 2, 9977, '2020-05-22 19:43:29', 2, '2020-05-22 14:13:29'),
(21813, 2, 9981, '2020-10-23 05:43:57', 2, '2020-10-23 00:13:57'),
(21814, 2, 9982, '2020-10-23 05:43:57', 2, '2020-10-23 00:13:57'),
(21815, 2, 9983, '2020-10-23 05:43:57', 2, '2020-10-23 00:13:57'),
(21816, 2, 9984, '2020-10-23 05:43:57', 2, '2020-10-23 00:13:57'),
(21817, 2, 9985, '2020-10-24 22:13:01', 2, '2020-10-24 16:43:01'),
(21826, 2, 9994, '2021-05-19 23:43:05', 2, '2021-05-19 18:13:05'),
(21827, 2, 9995, '2021-05-19 23:43:05', 2, '2021-05-19 18:13:05'),
(21828, 2, 9996, '2021-05-19 23:43:05', 2, '2021-05-19 18:13:05'),
(21829, 2, 9997, '2021-05-19 23:43:05', 2, '2021-05-19 18:13:05'),
(21830, 5, 9994, '2021-05-19 23:46:57', 2, '2021-05-19 18:16:57'),
(21831, 5, 9995, '2021-05-19 23:46:57', 2, '2021-05-19 18:16:57'),
(21832, 5, 9996, '2021-05-19 23:46:57', 2, '2021-05-19 18:16:57'),
(21833, 5, 9997, '2021-05-19 23:46:57', 2, '2021-05-19 18:16:57');

-- --------------------------------------------------------

--
-- Stand-in structure for view `user_session_30_days`
-- (See below for the actual view)
--
CREATE TABLE `user_session_30_days` (
`user_name` text
,`total_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `entity_count`
--
DROP TABLE IF EXISTS `entity_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entity_count`  AS  select `entity_child`.`entity_code` AS `entity_code`,count(0) AS `count` from `entity_child` group by `entity_child`.`entity_code` order by `entity_child`.`entity_code` ;

-- --------------------------------------------------------

--
-- Structure for view `entity_ec_count`
--
DROP TABLE IF EXISTS `entity_ec_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entity_ec_count`  AS  select `entity`.`code` AS `code`,`entity`.`sn` AS `sn`,(select count(0) from `entity_child` where (`entity_child`.`entity_code` = `entity`.`code`)) AS `count` from `entity` group by `entity`.`code` order by `entity`.`sn` ;

-- --------------------------------------------------------

--
-- Structure for view `entity_internal_external`
--
DROP TABLE IF EXISTS `entity_internal_external`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entity_internal_external`  AS  select if((`entity`.`is_lib` = 0),'External','Internal') AS `entity`,count(0) AS `total_count` from `entity` group by `entity`.`is_lib` ;

-- --------------------------------------------------------

--
-- Structure for view `internal_entity_count`
--
DROP TABLE IF EXISTS `internal_entity_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `internal_entity_count`  AS  select (select `entity`.`sn` from `entity` where (`entity`.`code` = `entity_attribute`.`entity_code`)) AS `entity`,count(0) AS `total_count` from `entity_attribute` group by `entity_attribute`.`entity_code` ;

-- --------------------------------------------------------

--
-- Structure for view `page_view_log_by_day`
--
DROP TABLE IF EXISTS `page_view_log_by_day`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `page_view_log_by_day`  AS  select date_format(`sys_log`.`timestamp_punch`,'%Y-%m-%d') AS `date`,`sys_log`.`page_code` AS `page_code`,count(0) AS `total` from `sys_log` group by date_format(`sys_log`.`timestamp_punch`,'%d-%b-%Y'),`sys_log`.`page_code` ;

-- --------------------------------------------------------

--
-- Structure for view `session_by_date`
--
DROP TABLE IF EXISTS `session_by_date`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `session_by_date`  AS  select date_format(`sys_log`.`timestamp_punch`,'%Y-%m-%d') AS `date`,count(0) AS `total_count` from `sys_log` group by date_format(`sys_log`.`timestamp_punch`,'%Y-%m-%d') ;

-- --------------------------------------------------------

--
-- Structure for view `user_engine_sessions`
--
DROP TABLE IF EXISTS `user_engine_sessions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_engine_sessions`  AS  select `get_user_internal_name`(`user_info`.`id`) AS `user_name`,(select count(0) from `sys_log` where ((`sys_log`.`action_type` = 'DVEW') and (`sys_log`.`user_id` = `user_info`.`id`))) AS `desk`,(select count(0) from `sys_log` where ((`sys_log`.`action_type` = 'FVEW') and (`sys_log`.`user_id` = `user_info`.`id`))) AS `form` from `user_info` ;

-- --------------------------------------------------------

--
-- Structure for view `user_session_30_days`
--
DROP TABLE IF EXISTS `user_session_30_days`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_session_30_days`  AS  select `get_user_internal_name`(`sys_log`.`user_id`) AS `user_name`,count(0) AS `total_count` from `sys_log` where (`sys_log`.`timestamp_punch` > (now() - interval 30 day)) group by `sys_log`.`user_id` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `demo`
--
ALTER TABLE `demo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `demo_page_info`
--
ALTER TABLE `demo_page_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `eav_addon_bool`
--
ALTER TABLE `eav_addon_bool`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `eav_addon_date`
--
ALTER TABLE `eav_addon_date`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `ea_value` (`ea_value`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `eav_addon_decimal`
--
ALTER TABLE `eav_addon_decimal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `eav_addon_ecb_id`
--
ALTER TABLE `eav_addon_ecb_id`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `ecb_id` (`ecb_id`);

--
-- Indexes for table `eav_addon_ec_id`
--
ALTER TABLE `eav_addon_ec_id`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `ec_id` (`ec_id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `eav_addon_exa_token`
--
ALTER TABLE `eav_addon_exa_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `exa_value_token` (`exa_value_token`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `eav_addon_num`
--
ALTER TABLE `eav_addon_num`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `eav_addon_text`
--
ALTER TABLE `eav_addon_text`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `eav_addon_varchar`
--
ALTER TABLE `eav_addon_varchar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `eav_addon_vc128uniq`
--
ALTER TABLE `eav_addon_vc128uniq`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ecb_av_addon_text`
--
ALTER TABLE `ecb_av_addon_text`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ecb_av_addon_varchar`
--
ALTER TABLE `ecb_av_addon_varchar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ea_code` (`ea_code`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `ecb_parent_child_matrix`
--
ALTER TABLE `ecb_parent_child_matrix`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_ecb_parent_child_matrix_ecb_parent_id` (`ecb_parent_id`),
  ADD KEY `parent_child_hash` (`parent_child_hash`) USING HASH;

--
-- Indexes for table `entity`
--
ALTER TABLE `entity`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `fk_entity_user_id` (`user_id`);

--
-- Indexes for table `entity_attribute`
--
ALTER TABLE `entity_attribute`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `entity_code` (`entity_code`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `fk_entity_attribute_user_id` (`user_id`);

--
-- Indexes for table `entity_child`
--
ALTER TABLE `entity_child`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entity_code` (`entity_code`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `entity_child_base`
--
ALTER TABLE `entity_child_base`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entity_code` (`entity_code`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `token` (`token`),
  ADD KEY `fk_entity_child_base_user_id` (`user_id`);

--
-- Indexes for table `entity_key_value`
--
ALTER TABLE `entity_key_value`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coach_id` (`coach_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `fk_entity_key_value_entity_code` (`entity_code`),
  ADD KEY `fk_entity_key_value_user_id` (`user_id`);

--
-- Indexes for table `exav_addon_bool`
--
ALTER TABLE `exav_addon_bool`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`,`exa_token`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `exa_token` (`exa_token`);

--
-- Indexes for table `exav_addon_date`
--
ALTER TABLE `exav_addon_date`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exa_token` (`exa_token`),
  ADD KEY `exa_value` (`exa_value`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `exav_addon_decimal`
--
ALTER TABLE `exav_addon_decimal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exa_token` (`exa_token`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `exav_addon_ec_id`
--
ALTER TABLE `exav_addon_ec_id`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exa_token` (`exa_token`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `fk_exav_addon_ec_id_ec_id` (`ec_id`);

--
-- Indexes for table `exav_addon_exa_token`
--
ALTER TABLE `exav_addon_exa_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exa_token` (`exa_token`),
  ADD KEY `exa_value_token` (`exa_value_token`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `exav_addon_num`
--
ALTER TABLE `exav_addon_num`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exa_token` (`exa_token`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `exav_addon_text`
--
ALTER TABLE `exav_addon_text`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exa_token` (`exa_token`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `exav_addon_varchar`
--
ALTER TABLE `exav_addon_varchar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exa_token` (`exa_token`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `exav_addon_vc128uniq`
--
ALTER TABLE `exav_addon_vc128uniq`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exa_token` (`exa_token`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `status_info`
--
ALTER TABLE `status_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status_code` (`status_code`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `fk_status_info_entity_code` (`entity_code`),
  ADD KEY `fk_status_info_user_id` (`user_id`),
  ADD KEY `fk_status_info_child_comm_id` (`child_comm_id`);

--
-- Indexes for table `status_map`
--
ALTER TABLE `status_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `fk_status_map_entity_code` (`entity_code`),
  ADD KEY `fk_status_map_user_id` (`user_id`),
  ADD KEY `fk_status_map_status_code_start` (`status_code_start`),
  ADD KEY `fk_status_map_status_code_end` (`status_code_end`);

--
-- Indexes for table `sys_log`
--
ALTER TABLE `sys_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `is_internal` (`is_internal`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_role_id` (`user_role_id`);

--
-- Indexes for table `user_info_log`
--
ALTER TABLE `user_info_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sn` (`sn`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `fk_user_role_user_id` (`user_id`);

--
-- Indexes for table `user_role_page`
--
ALTER TABLE `user_role_page`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `fk_user_role_permission_user_id` (`user_id`),
  ADD KEY `user_role_page_ibfk_1` (`user_role_id`),
  ADD KEY `line_order` (`line_order`);

--
-- Indexes for table `user_role_page_matrix`
--
ALTER TABLE `user_role_page_matrix`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_role_id` (`user_role_page_id`),
  ADD KEY `fk_user_role_permission_matrix_user_permission_id` (`user_page_id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `user_role_permission`
--
ALTER TABLE `user_role_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fk_user_role_permission_user_role_id` (`user_role_id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `fk_user_role_permission_user_id` (`user_id`);

--
-- Indexes for table `user_role_permission_matrix`
--
ALTER TABLE `user_role_permission_matrix`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timestamp_punch` (`timestamp_punch`),
  ADD KEY `user_role_id` (`user_role_id`),
  ADD KEY `fk_user_role_permission_matrix_user_permission_id` (`user_permission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `demo`
--
ALTER TABLE `demo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `demo_page_info`
--
ALTER TABLE `demo_page_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `eav_addon_bool`
--
ALTER TABLE `eav_addon_bool`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT for table `eav_addon_date`
--
ALTER TABLE `eav_addon_date`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eav_addon_decimal`
--
ALTER TABLE `eav_addon_decimal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eav_addon_ecb_id`
--
ALTER TABLE `eav_addon_ecb_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `eav_addon_ec_id`
--
ALTER TABLE `eav_addon_ec_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2939;

--
-- AUTO_INCREMENT for table `eav_addon_exa_token`
--
ALTER TABLE `eav_addon_exa_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eav_addon_num`
--
ALTER TABLE `eav_addon_num`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eav_addon_text`
--
ALTER TABLE `eav_addon_text`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=774;

--
-- AUTO_INCREMENT for table `eav_addon_varchar`
--
ALTER TABLE `eav_addon_varchar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14200;

--
-- AUTO_INCREMENT for table `eav_addon_vc128uniq`
--
ALTER TABLE `eav_addon_vc128uniq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=372;

--
-- AUTO_INCREMENT for table `ecb_av_addon_text`
--
ALTER TABLE `ecb_av_addon_text`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `ecb_av_addon_varchar`
--
ALTER TABLE `ecb_av_addon_varchar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30466;

--
-- AUTO_INCREMENT for table `ecb_parent_child_matrix`
--
ALTER TABLE `ecb_parent_child_matrix`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9998;

--
-- AUTO_INCREMENT for table `entity`
--
ALTER TABLE `entity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=246;

--
-- AUTO_INCREMENT for table `entity_attribute`
--
ALTER TABLE `entity_attribute`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=460;

--
-- AUTO_INCREMENT for table `entity_child`
--
ALTER TABLE `entity_child`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5806;

--
-- AUTO_INCREMENT for table `entity_child_base`
--
ALTER TABLE `entity_child_base`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5922;

--
-- AUTO_INCREMENT for table `entity_key_value`
--
ALTER TABLE `entity_key_value`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `exav_addon_bool`
--
ALTER TABLE `exav_addon_bool`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `exav_addon_date`
--
ALTER TABLE `exav_addon_date`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exav_addon_decimal`
--
ALTER TABLE `exav_addon_decimal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exav_addon_ec_id`
--
ALTER TABLE `exav_addon_ec_id`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exav_addon_exa_token`
--
ALTER TABLE `exav_addon_exa_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `exav_addon_num`
--
ALTER TABLE `exav_addon_num`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=150;

--
-- AUTO_INCREMENT for table `exav_addon_text`
--
ALTER TABLE `exav_addon_text`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1596;

--
-- AUTO_INCREMENT for table `exav_addon_varchar`
--
ALTER TABLE `exav_addon_varchar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1228;

--
-- AUTO_INCREMENT for table `exav_addon_vc128uniq`
--
ALTER TABLE `exav_addon_vc128uniq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status_info`
--
ALTER TABLE `status_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status_map`
--
ALTER TABLE `status_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sys_log`
--
ALTER TABLE `sys_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_info`
--
ALTER TABLE `user_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `user_info_log`
--
ALTER TABLE `user_info_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `user_role_page`
--
ALTER TABLE `user_role_page`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_role_page_matrix`
--
ALTER TABLE `user_role_page_matrix`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_role_permission`
--
ALTER TABLE `user_role_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_role_permission_matrix`
--
ALTER TABLE `user_role_permission_matrix`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21834;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `eav_addon_bool`
--
ALTER TABLE `eav_addon_bool`
  ADD CONSTRAINT `eav_addon_bool_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`),
  ADD CONSTRAINT `eav_addon_codE_fk` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `eav_addon_parent_fk` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `eav_addon_date`
--
ALTER TABLE `eav_addon_date`
  ADD CONSTRAINT `fk_eav_addon_date_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_date_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_date_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `eav_addon_decimal`
--
ALTER TABLE `eav_addon_decimal`
  ADD CONSTRAINT `fk_eav_addon_decimal_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_decimal_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_decimal_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `eav_addon_ecb_id`
--
ALTER TABLE `eav_addon_ecb_id`
  ADD CONSTRAINT `eav_addon_ecb_id_ibfk_1` FOREIGN KEY (`ecb_id`) REFERENCES `entity_child_base` (`id`),
  ADD CONSTRAINT `eav_addon_ecb_id_ibfk_2` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`),
  ADD CONSTRAINT `eav_addon_ecb_id_ibfk_3` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `eav_addon_ec_id`
--
ALTER TABLE `eav_addon_ec_id`
  ADD CONSTRAINT `fk_eav_addon_ec_id_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_ec_id_ec_id` FOREIGN KEY (`ec_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_ec_id_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_ec_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `eav_addon_exa_token`
--
ALTER TABLE `eav_addon_exa_token`
  ADD CONSTRAINT `fk_eav_addon_exa_token_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_exa_token_exa_value_token` FOREIGN KEY (`exa_value_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_exa_token_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_exa_token_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `eav_addon_num`
--
ALTER TABLE `eav_addon_num`
  ADD CONSTRAINT `fk_eav_addon_num_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_num_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_num_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `eav_addon_text`
--
ALTER TABLE `eav_addon_text`
  ADD CONSTRAINT `fk_eav_addon_text_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_text_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_text_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `eav_addon_varchar`
--
ALTER TABLE `eav_addon_varchar`
  ADD CONSTRAINT `fk_eav_addon_varchar_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_varchar_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_varchar_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `eav_addon_vc128uniq`
--
ALTER TABLE `eav_addon_vc128uniq`
  ADD CONSTRAINT `fk_eav_addon_vc128uniq_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_vc128uniq_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_eav_addon_vc128uniq_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `ecb_av_addon_varchar`
--
ALTER TABLE `ecb_av_addon_varchar`
  ADD CONSTRAINT `fk_ecb_av_addon_varchar_ea_code` FOREIGN KEY (`ea_code`) REFERENCES `entity_attribute` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ecb_av_addon_varchar_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child_base` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ecb_av_addon_varchar_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `ecb_parent_child_matrix`
--
ALTER TABLE `ecb_parent_child_matrix`
  ADD CONSTRAINT `fk_ecb_parent_child_matrix_ecb_parent_id` FOREIGN KEY (`ecb_parent_id`) REFERENCES `entity_child_base` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ecb_parent_child_matrix_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `entity`
--
ALTER TABLE `entity`
  ADD CONSTRAINT `fk_entity_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `entity_attribute`
--
ALTER TABLE `entity_attribute`
  ADD CONSTRAINT `fk_entity_attribute_entity_code` FOREIGN KEY (`entity_code`) REFERENCES `entity` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entity_attribute_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `entity_child`
--
ALTER TABLE `entity_child`
  ADD CONSTRAINT `fk_entity_child_entity_code` FOREIGN KEY (`entity_code`) REFERENCES `entity` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entity_child_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `entity_child_base`
--
ALTER TABLE `entity_child_base`
  ADD CONSTRAINT `fk_entity_child_base_entity_code` FOREIGN KEY (`entity_code`) REFERENCES `entity` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entity_child_base_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `entity_key_value`
--
ALTER TABLE `entity_key_value`
  ADD CONSTRAINT `fk_entity_key_value_entity_code` FOREIGN KEY (`entity_code`) REFERENCES `entity` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entity_key_value_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `exav_addon_bool`
--
ALTER TABLE `exav_addon_bool`
  ADD CONSTRAINT `exav_addon_bool_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `exav_addon_bool_ibfk_2` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON UPDATE CASCADE;

--
-- Constraints for table `exav_addon_date`
--
ALTER TABLE `exav_addon_date`
  ADD CONSTRAINT `fk_exav_addon_date_exa_token` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_date_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_date_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `exav_addon_decimal`
--
ALTER TABLE `exav_addon_decimal`
  ADD CONSTRAINT `fk_exav_addon_decimal_exa_token` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_decimal_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_decimal_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `exav_addon_ec_id`
--
ALTER TABLE `exav_addon_ec_id`
  ADD CONSTRAINT `fk_exav_addon_ec_id_ec_id` FOREIGN KEY (`ec_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_ec_id_exa_token` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_ec_id_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_ec_id_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `exav_addon_exa_token`
--
ALTER TABLE `exav_addon_exa_token`
  ADD CONSTRAINT `fk_exav_addon_exa_token_exa_token` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_exa_token_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_exa_token_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `exav_addon_num`
--
ALTER TABLE `exav_addon_num`
  ADD CONSTRAINT `fk_exav_addon_num_exa_token` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_num_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_num_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `exav_addon_text`
--
ALTER TABLE `exav_addon_text`
  ADD CONSTRAINT `fk_exav_addon_text_exa_token` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_text_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_text_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `exav_addon_varchar`
--
ALTER TABLE `exav_addon_varchar`
  ADD CONSTRAINT `fk_exav_addon_varchar_exa_token` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_varchar_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_varchar_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `exav_addon_vc128uniq`
--
ALTER TABLE `exav_addon_vc128uniq`
  ADD CONSTRAINT `fk_exav_addon_vc128uniq_exa_token` FOREIGN KEY (`exa_token`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_vc128uniq_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_exav_addon_vc128uniq_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `status_info`
--
ALTER TABLE `status_info`
  ADD CONSTRAINT `fk_status_info_child_comm_id` FOREIGN KEY (`child_comm_id`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_status_info_entity_code` FOREIGN KEY (`entity_code`) REFERENCES `entity` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_status_info_status_code` FOREIGN KEY (`status_code`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_status_info_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `status_map`
--
ALTER TABLE `status_map`
  ADD CONSTRAINT `fk_status_map_entity_code` FOREIGN KEY (`entity_code`) REFERENCES `entity` (`code`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_status_map_status_code_end` FOREIGN KEY (`status_code_end`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_status_map_status_code_start` FOREIGN KEY (`status_code_start`) REFERENCES `entity_child_base` (`token`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_status_map_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_info`
--
ALTER TABLE `user_info`
  ADD CONSTRAINT `fk_user_info_is_internal` FOREIGN KEY (`is_internal`) REFERENCES `entity_child` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_info_user_role_id` FOREIGN KEY (`user_role_id`) REFERENCES `user_role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `fk_user_role_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_role_page`
--
ALTER TABLE `user_role_page`
  ADD CONSTRAINT `user_role_page_ibfk_1` FOREIGN KEY (`user_role_id`) REFERENCES `user_role` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_role_page_matrix`
--
ALTER TABLE `user_role_page_matrix`
  ADD CONSTRAINT `user_role_page_matrix_ibfk_1` FOREIGN KEY (`user_role_page_id`) REFERENCES `user_role_page` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_role_permission`
--
ALTER TABLE `user_role_permission`
  ADD CONSTRAINT `fk_user_role_permission_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_role_permission_user_role_id` FOREIGN KEY (`user_role_id`) REFERENCES `user_role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `user_role_permission_matrix`
--
ALTER TABLE `user_role_permission_matrix`
  ADD CONSTRAINT `fk_user_role_permission_matrix_user_permission_id` FOREIGN KEY (`user_permission_id`) REFERENCES `ecb_parent_child_matrix` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_role_permission_matrix_user_role_id` FOREIGN KEY (`user_role_id`) REFERENCES `user_role` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

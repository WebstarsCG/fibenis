-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 13, 2019 at 11:29 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `fibenis_base`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_coach_code`(ec_id INTEGER) RETURNS varchar(32) CHARSET utf8
BEGIN
    RETURN IFNULL(get_eav_addon_vc128uniq(ec_id,'CHCD'),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_coach_id_by_code`(temp_coach_name VARCHAR(64)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT parent_id FROM eav_addon_vc128uniq WHERE ea_code='CHCD' and ea_value=temp_coach_name),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_bool`(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_bool WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_date`(temp_ec_id INT, temp_code CHAR(4)) RETURNS date
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_date WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_ec_id`(`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ec_id FROM eav_addon_ec_id WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_exa_token`(temp_ec_id INT, temp_code CHAR(4)) RETURNS varchar(32) CHARSET utf8
BEGIN
        return IFNULL((SELECT exa_value_token FROM eav_addon_exa_token WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_num`(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_num WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_text`(`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS text CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_text WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_varchar`(ec_id INT, code VARCHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    return IFNULL((SELECT ea_value FROM eav_addon_varchar WHERE  parent_id=ec_id AND ea_code=code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_addon_vc128uniq`(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS varchar(128) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_vc128uniq WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_eav_ec_id`(`temp_ec_id` INT, `temp_code` CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ec_id FROM eav_addon_ec_id WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ea_sn_by_code`(temp_code VARCHAR(64)) RETURNS varchar(1028) CHARSET utf8
BEGIN
        return IFNULL((SELECT sn FROM entity_attribute WHERE code=temp_code),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_addon_varchar`(`ecb_id` INT, `temp_code` CHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE  parent_id=ecb_id AND ea_code=temp_code ORDER BY id DESC LIMIT 1),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_attr`(temp_token VARCHAR(16), attr_code CHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    DECLARE ecb_id int;
    
    return IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=get_ecb_id_by_token(temp_token) AND ea_code=attr_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_av_addon_varchar`(`temp_id` INT(11), `temp_code` CHAR(4)) RETURNS text CHARSET utf8
BEGIN
    return IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE  parent_id=temp_id AND ea_code=temp_code ORDER BY id ASC),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_id_by_token`(temp_token VARCHAR(32)) RETURNS text CHARSET utf8
BEGIN
    return IFNULL((SELECT id FROM entity_child_base WHERE token=temp_token),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_ln_by_token`(temp_token VARCHAR(32)) RETURNS text CHARSET latin1
BEGIN
        return IFNULL((SELECT ln FROM entity_child_base WHERE token=temp_token),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_parent_child_name`(`temp_id` INT, `glue` VARCHAR(2)) RETURNS text CHARSET utf8
BEGIN

        RETURN CONCAT((SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE id=temp_id)),
                       glue,
                      (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE id=temp_id))
                      );
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_parent_child_name_from_hash`(`temp_hash` CHAR(32), `glue` VARCHAR(2)) RETURNS text CHARSET utf8
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

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_parent_child_name_mode`(`temp_id` INT, `glue` VARCHAR(2), `mode` VARCHAR(4)) RETURNS text CHARSET utf8
BEGIN

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

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecb_sn_by_token`(temp_token varchar(32)) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((SELECT sn FROM entity_child_base WHERE token=temp_token),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ecsn`(`temp_id` INT) RETURNS varchar(1024) CHARSET utf8
BEGIN
    return IFNULL((SELECT ea_value FROM eav_addon_varchar WHERE  parent_id=temp_id AND ea_code='ECSN'),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_child_id`(temp_ec_id INT, temp_code CHAR(4)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT id FROM entity_child WHERE parent_id=temp_ec_id AND entity_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_child_id_eav`(temp_ec_id INT, temp_code CHAR(4)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT id FROM entity_child WHERE get_eav_addon_num(id,'ECPR')=temp_ec_id AND entity_code=temp_code),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_id_by_code`(temp_ent_code VARCHAR(4), temp_ec_code VARCHAR(32)) RETURNS int(11)
BEGIN

        RETURN (SELECT id FROM entity_child WHERE entity_code=temp_ent_code AND code=temp_ec_code);
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_id_by_code_eav`(temp_ent_code VARCHAR(4), temp_ec_code VARCHAR(32)) RETURNS int(11)
BEGIN

        RETURN (SELECT id FROM entity_child WHERE entity_code=temp_ent_code AND get_eav_addon_varchar(id,'ECCD')=temp_ec_code);
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_parent_id`(temp_ec_id INTEGER) RETURNS int(11)
BEGIN
    RETURN  IFNULL((SELECT parent_id FROM entity_child WHERE id=temp_ec_id),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_parent_id_eav`(`temp_ec_id` INT) RETURNS int(11)
BEGIN
    RETURN  IFNULL(get_eav_addon_ec_id(temp_ec_id,'ECPR'),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_sn`(temp_ec_id INTEGER) RETURNS int(11)
BEGIN
    RETURN  IFNULL((SELECT sn FROM entity_child WHERE id=temp_ec_id),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_sn_eav`(temp_ec_id INTEGER) RETURNS int(11)
BEGIN
    RETURN  IFNULL(get_eav_addon_varchar(id,'ECSN'),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_ec_status`(temp_id INTEGER) RETURNS tinyint(1)
BEGIN

        RETURN (SELECT is_active FROM entity_child WHERE id=temp_id);
        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_entity_child_of_child_from_code`(t_code VARCHAR(32), t_entity_code VARCHAR(2)) RETURNS int(11)
BEGIN
        RETURN (SELECT id FROM entity_child WHERE entity_code=t_entity_code AND parent_id=(SELECT ec.id FROM entity_child as ec WHERE ec.code=t_code));        
           
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_entity_child_of_child_from_code_eav`(`t_code` VARCHAR(32), `t_entity_code` VARCHAR(2)) RETURNS int(11)
BEGIN
        RETURN (SELECT id FROM entity_child WHERE entity_code=t_entity_code AND get_ec_parent_id_eav(entity_child.id)=(SELECT ec.id FROM entity_child as ec WHERE get_eav_addon_varchar(id,'ECCD')=t_code));                   
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav`(ec_id INT, token VARCHAR(16)) RETURNS text CHARSET utf8
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

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_date`(temp_ec_id INTEGER, token VARCHAR(16)) RETURNS text CHARSET latin1
BEGIN
    RETURN IFNULL((SELECT exa_value FROM exav_addon_date WHERE  parent_id=temp_ec_id AND exa_token=token),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal`(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,0)
BEGIN

    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);
    
 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal_1`(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,1)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal_2`(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,2)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal_3`(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,3)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_decimal_4`(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,4)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_ec_id`(temp_ec_id integer,token VARCHAR(16)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT ec_id FROM exav_addon_ec_id WHERE  parent_id=temp_ec_id AND exa_token=token),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_exa_token`(temp_ec_id INT, token VARCHAR(16)) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((SELECT exa_value_token FROM exav_addon_exa_token WHERE  parent_id=temp_ec_id AND exa_token=token ORDER BY id ASC LIMIT 1),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_num`(temp_ec_id INT, temp_token VARCHAR(32)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT exa_value FROM exav_addon_num WHERE  parent_id=temp_ec_id AND exa_token=temp_token),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_number`(ec_id INT, token VARCHAR(16)) RETURNS decimal(10,0)
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_decimal WHERE  parent_id=ec_id AND exa_token=token),NULL);     
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_text`(ec_id INT, token VARCHAR(16)) RETURNS text CHARSET utf8
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_text WHERE  parent_id=ec_id AND exa_token=token),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_exav_addon_varchar`(ec_id INT, token VARCHAR(16)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    return IFNULL((SELECT exa_value FROM exav_addon_varchar WHERE  parent_id=ec_id AND exa_token=token ORDER BY id DESC LIMIT 1),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_issue_description`(`temp_ec_id` INT) RETURNS text CHARSET utf8
BEGIN
            return IFNULL((get_exav_addon_varchar(temp_ec_id,'ISDS')),NULL);
        END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_issue_name`(`temp_ec_id` INT) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((get_exav_addon_varchar(temp_ec_id,'ISNA')),NULL);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_page_coach`(ec_id INTEGER) RETURNS varchar(32) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT get_eav_addon_varchar(get_eav_ec_id(ec_id,'PGCH'),'CHDN')),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_page_coach_code`(`ec_id` INT) RETURNS varchar(32) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT get_coach_code(get_eav_addon_ec_id(ec_id,'PGCH'))),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_page_parent`(temp_parent_id INT) RETURNS text CHARSET utf8
BEGIN

    IF temp_parent_id=0 THEN      
        RETURN ''; 
    ELSE
        RETURN (SELECT concat(code,'[C]',sn,'[C]',IFNULL(image_a,''),'[C]',IFNULL(image_b,'')) as parent_name FROM entity_child as parent_name WHERE parent_name.id = temp_parent_id);
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_page_parent_eav`(temp_parent_id INT) RETURNS text CHARSET utf8
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

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_id`(`temp_id` INT(11)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT id FROM user_info WHERE is_internal=temp_id),NULL);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_internal_email`(temp_user_id int) RETURNS text CHARSET utf8
BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COEM');
        END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_internal_mobile`(temp_user_id int) RETURNS text CHARSET utf8
BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COMB');
        END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_internal_name`(temp_user_id int) RETURNS text CHARSET utf8
BEGIN
            return get_eav_addon_varchar((SELECT is_internal FROM user_info WHERE user_info.id=temp_user_id),'COFN');
        END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_user_role`(`temp_id` INT) RETURNS varchar(1024) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ln FROM user_role WHERE id = (SELECT user_role_id FROM user_info WHERE is_internal = temp_id)),NULL);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `entity_count`
--
CREATE TABLE IF NOT EXISTS `entity_count` (
`entity_code` varchar(4)
,`count` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `entity_ec_count`
--
CREATE TABLE IF NOT EXISTS `entity_ec_count` (
`code` varchar(4)
,`sn` varchar(64)
,`count` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `page_view_log_by_day`
--
CREATE TABLE IF NOT EXISTS `page_view_log_by_day` (
`date` varchar(10)
,`page_code` varchar(32)
,`total` bigint(21)
);
-- --------------------------------------------------------

--
-- Structure for view `entity_count`
--
DROP TABLE IF EXISTS `entity_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entity_count` AS select `entity_child`.`entity_code` AS `entity_code`,count(0) AS `count` from `entity_child` group by `entity_child`.`entity_code` order by `entity_child`.`entity_code`;

-- --------------------------------------------------------

--
-- Structure for view `entity_ec_count`
--
DROP TABLE IF EXISTS `entity_ec_count`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `entity_ec_count` AS select `entity`.`code` AS `code`,`entity`.`sn` AS `sn`,(select count(0) from `entity_child` where (`entity_child`.`entity_code` = `entity`.`code`)) AS `count` from `entity` group by `entity`.`code` order by `entity`.`sn`;

-- --------------------------------------------------------

--
-- Structure for view `page_view_log_by_day`
--
DROP TABLE IF EXISTS `page_view_log_by_day`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `page_view_log_by_day` AS select date_format(`sys_log`.`timestamp_punch`,'%Y-%m-%d') AS `date`,`sys_log`.`page_code` AS `page_code`,count(0) AS `total` from `sys_log` group by date_format(`sys_log`.`timestamp_punch`,'%d-%b-%Y'),`sys_log`.`page_code`;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

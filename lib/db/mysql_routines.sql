--- Page Count View

CREATE VIEW page_view_log_by_day as SELECT date_format(timestamp_punch,'%Y-%m-%d') as date,page_code,count(*) as total FROM sys_log 
GROUP BY date_format(timestamp_punch,'%d-%b-%Y'),page_code


---- Test

CREATE VIEW entity_count  as SELECT entity_code,count(*) as count FROM entity_child GROUP BY entity_code ORDER BY entity_code


DELIMITER $$

CREATE  FUNCTION get_contact_name(temp_id integer) RETURNS text CHARSET utf8
BEGIN
        return IFNULL(concat((get_ecb_sn_by_token
        (get_eav_addon_exa_token(temp_id,'COHN'))),
        (get_eav_addon_varchar(temp_id,'COFN')),' ',
        (get_eav_addon_varchar(temp_id,'COLN'))),NULL);
    END$$



CREATE  FUNCTION get_contact_name_mobile(temp_ec_id integer) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((get_eav_addon_varchar(temp_ec_id,'COMB')),NULL);
    END$$



CREATE  FUNCTION get_eav_addon_exa_token(temp_ec_id INT, temp_code CHAR(4)) RETURNS varchar(32) CHARSET utf8
BEGIN
        return IFNULL((SELECT exa_value_token FROM eav_addon_exa_token WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
    END$$



CREATE  FUNCTION get_eav_addon_date(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_date WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$



CREATE  FUNCTION get_eav_addon_varchar(ec_id INT, code VARCHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    return IFNULL((SELECT ea_value FROM eav_addon_varchar WHERE  parent_id=ec_id AND ea_code=code),NULL);
END$$



CREATE  FUNCTION get_eav_addon_text(temp_ec_id integer,temp_code char(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_text WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$



CREATE  FUNCTION get_ec_parent_id(temp_ec_id integer,temp_code char(4)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT id FROM entity_child WHERE  parent_id=temp_ec_id AND entity_code=temp_code),NULL);
    END$$



CREATE  FUNCTION get_eav_ec_id(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ec_id FROM eav_addon_ec_id WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$


CREATE  FUNCTION get_eav_addon_bool(temp_ec_id INTEGER, temp_code CHAR(4)) RETURNS int(11)
BEGIN
    RETURN IFNULL((SELECT ea_value FROM eav_addon_bool WHERE  parent_id=temp_ec_id AND ea_code=temp_code),NULL);
END$$

CREATE  FUNCTION get_ec_id_by_codes(temp_ent_code VARCHAR(4), temp_ec_code VARCHAR(16)) RETURNS int(11)
BEGIN

        RETURN (SELECT id FROM entity_child WHERE entity_code=temp_ent_code AND code=temp_ec_code);
        
           
END$$



CREATE  FUNCTION get_ec_status(temp_id INTEGER) RETURNS tinyint(1)
BEGIN

        RETURN (SELECT is_active FROM entity_child WHERE id=temp_id);
        
           
END$$




CREATE  FUNCTION get_ecb_addon_varchar(ecb_id INTEGER, temp_code CHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE  parent_id=ecb_id AND ea_code=temp_code),NULL);
END$$



CREATE  FUNCTION get_ecb_attr(temp_token VARCHAR(16), attr_code CHAR(4)) RETURNS varchar(1028) CHARSET utf8
BEGIN
    DECLARE ecb_id int;
    
    return IFNULL((SELECT ea_value FROM ecb_av_addon_varchar WHERE parent_id=get_ecb_id_by_token(temp_token) AND ea_code=attr_code),NULL);
END$$



CREATE  FUNCTION get_ecb_id_by_token(temp_token VARCHAR(16)) RETURNS text CHARSET utf8
BEGIN
    return IFNULL((SELECT id FROM entity_child_base WHERE token=temp_token),NULL);
END$$



CREATE  FUNCTION get_ecb_matrix_name(temp_id INT, glue VARCHAR(2)) RETURNS text CHARSET utf8
BEGIN

        RETURN (SELECT  concat((SELECT token from entity_child_base as ecb WHERE ecb.id=ecb_id),
                               glue,
                               (SELECT token from entity_child_base as ecb WHERE ecb.id=xa_id)) as name                              
                               
                FROM
                        ecb_xa_matrix
                WHERE
                        id=temp_id);
    
    
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

        RETURN CONCAT((SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_parent_id FROM ecb_parent_child_matrix WHERE parent_child_hash=temp_hash)),
                       glue,
                      (SELECT sn FROM entity_child_base WHERE id=(SELECT ecb_child_id FROM ecb_parent_child_matrix WHERE parent_child_hash=temp_hash))
                      );
        
           
END$$



CREATE  FUNCTION get_ecb_sn_by_token(temp_token varchar(32)) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((SELECT sn FROM entity_child_base WHERE token=temp_token),NULL);
    END$$



CREATE  FUNCTION get_entity_child_of_child_from_code(t_code VARCHAR(32), t_entity_code VARCHAR(2)) RETURNS int(11)
BEGIN

        RETURN (SELECT id FROM entity_child WHERE entity_code=t_entity_code AND parent_id=(SELECT ec.id FROM entity_child as ec WHERE ec.code=t_code));
        
           
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



CREATE  FUNCTION get_exav_addon_date(temp_ec_id INTEGER, token VARCHAR(16)) RETURNS text
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



CREATE  FUNCTION get_exav_addon_exa_token(temp_ec_id integer,token VARCHAR(16)) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((SELECT exa_value_token FROM exav_addon_exa_token WHERE  parent_id=ec_id AND exa_token=token),NULL);
    END$$



CREATE  FUNCTION get_exav_addon_num(temp_ec_id integer,temp_code VARCHAR(16)) RETURNS int(11)
BEGIN
        return IFNULL((SELECT exa_value FROM exav_addon_num WHERE  parent_id=ec_id AND exa_token=token),NULL);
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
    return IFNULL((SELECT exa_value FROM exav_addon_varchar WHERE  parent_id=ec_id AND exa_token=token),NULL);
END$$



CREATE  FUNCTION get_issue_description(temp_ec_id integer) RETURNS text CHARSET utf8
BEGIN
            return IFNULL((get_eav_addon_varchar(temp_ec_id,'ISDS')),NULL);
        END$$



CREATE  FUNCTION get_issue_name(temp_ec_id integer) RETURNS text CHARSET utf8
BEGIN
        return IFNULL((get_eav_addon_varchar(temp_ec_id,'ISNA')),NULL);
    END$$



CREATE  FUNCTION get_page_coach(ec_id INTEGER) RETURNS varchar(32) CHARSET utf8
BEGIN
    RETURN IFNULL((SELECT get_eav_addon_varchar(get_eav_ec_id(ec_id,'PGCH'),'CHDN')),NULL);
END$$



CREATE  FUNCTION get_page_parent(temp_parent_id INT) RETURNS text CHARSET utf8
BEGIN

    IF temp_parent_id=0 THEN      
        RETURN ''; 
    ELSE
        RETURN (SELECT concat(code,'[C]',sn,'[C]',IFNULL(image_a,''),'[C]',IFNULL(image_b,'')) as parent_name FROM entity_child as parent_name WHERE parent_name.id = temp_parent_id);
    END IF;
    
END$$



CREATE  FUNCTION get_parent_id(temp_ec_id INTEGER) RETURNS int(11)
BEGIN
    RETURN  IFNULL((SELECT parent_id FROM entity_child WHERE id=temp_ec_id),NULL);
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
        
DELIMITER ;


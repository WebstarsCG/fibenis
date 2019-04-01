---- 30SEP2018
---- Mysql
---- Page Section
---- Inlcluded for Contact Map Attrobute
---- Contact map Entity 'CM'

INSERT INTO entity (code, sn, ln, creation, user_id, timestamp_punch)
        VALUES ('CM','Contact with Google Map','Contact with Google Map',CURRENT_TIMESTAMP,
               (SELECT user_info.id FROM user_info WHERE user_role_id=(SELECT user_role.id FROM user_role WHERE sn='SAD') LIMIT 0,1),
                CURRENT_TIMESTAMP);

---- 30SEP2018
---- Pgsql
---- Page Section
---- Inlcluded for Contact Map Attrobute
---- Contact map Entity 'CM'

INSERT INTO entity (code, sn, ln, creation, user_id, timestamp_punch)
        VALUES ('CM','Contact with Google Map','Contact with Google Map',CURRENT_TIMESTAMP,
               (SELECT user_info.id FROM user_info WHERE user_role_id=(SELECT user_role.id FROM user_role WHERE sn='SAD') LIMIT 0 OFFSET 1),
                CURRENT_TIMESTAMP);
                
                
                
---- 30SEP2018
---- Mysql
---- Page Section
---- Inlcluded for Contact Map Attrobute
INSERT  INTO entity_attribute (entity_code, code, sn, ln, line_order, creation, user_id, timestamp_punch)
        VALUES ('CO','COGM','Contact Google Map','Contact Google Map', '0', CURRENT_TIMESTAMP,
               (SELECT user_info.id FROM user_info WHERE user_role_id=(SELECT user_role.id FROM user_role WHERE sn='SAD') LIMIT 0,1),
                CURRENT_TIMESTAMP);
                

---- 30SEP2018
---- Pgsql
---- Page Section
---- Inlcluded for Contact Map Attrobute
INSERT  INTO entity_attribute (entity_code, code, sn, ln, line_order, creation, user_id, timestamp_punch)
        VALUES ('CO','COGM','Contact Google Map','Contact Google Map', '0', CURRENT_TIMESTAMP,
               (SELECT user_info.id FROM user_info WHERE user_role_id=(SELECT user_role.id FROM user_role WHERE sn='SAD') LIMIT 0 OFFSET 1),
                CURRENT_TIMESTAMP);


---- Mysql
---- Page Section
---- Inlcluded for CMS One Page, Page Section Pages
INSERT INTO entity_attribute (entity_code, code, sn, ln, line_order, creation, user_id, timestamp_punch) VALUES ('PG', 'PGHS', 'Page Home Section', 'Page Home Section', '0', CURRENT_TIMESTAMP,(SELECT user_info.id FROM user_info WHERE user_role_id=(SELECT user_role.id FROM user_role WHERE sn='SAD') LIMIT 0,1), CURRENT_TIMESTAMP);

---- pgsql
---- Page Section
---- Inlcluded for CMS One Page, Page Section Pages
INSERT INTO entity_attribute (entity_code, code, sn, ln, line_order, creation, user_id, timestamp_punch) VALUES ('PG', 'PGHS', 'Page Home Section', 'Page Home Section', '0', CURRENT_TIMESTAMP,(SELECT user_info.id FROM user_info WHERE user_role_id=(SELECT user_role.id FROM user_role WHERE sn='SAD') LIMIT 1 OFFSET 1), CURRENT_TIMESTAMP);

                             
 
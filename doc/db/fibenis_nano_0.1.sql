-- 31Mar2023
DROP TABLE IF EXISTS ecb_av_addon_ec_id;
CREATE TABLE ecb_av_addon_ec_id(
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  ec_id int(11) NOT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY ec_id (ec_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id),
   CONSTRAINT fk_ecb_av_addon_ec_id_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
   CONSTRAINT fk_ecb_av_addon_ec_id_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child_base (id) ON DELETE CASCADE ON UPDATE NO ACTION,
   CONSTRAINT fk_ecb_av_addon_ec_id_ec_id FOREIGN KEY (ec_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
   CONSTRAINT fk_ecb_av_addon_ec_id_user_id FOREIGN KEY (user_id) REFERENCES user_info (id) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO entity_attribute (entity_code, code, sn, ln, line_order, creation, user_id, timestamp_punch) VALUES
                             ('CH', 'CHID', 'Coach ID', '', '9.00',now(), 2,now());
                             
-- 14Feb2023
INSERT INTO entity_attribute (entity_code, code, sn, ln, line_order, creation, user_id, timestamp_punch) VALUES
                             ('CH', 'CHET', 'Coach Entity', '', '8.00',now(), 2,now());


-- 08NOV2022
INSERT INTO entity_attribute (entity_code, code, sn, ln, line_order, creation, user_id, timestamp_punch) VALUES
                             ('GP', 'GPIL', 'Is Core Group', '', '2.00',now(), 2,now());
							 
-- 12OCT2022
DROP TABLE IF EXISTS eav_addon_entity_code;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE eav_addon_entity_code (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) DEFAULT NULL,
  ea_code char(4) DEFAULT NULL,
  entity_code varchar(4) NOT NULL,
  user_id int(11) DEFAULT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY ea_code (ea_code),
  KEY parent_id (parent_id),
  KEY timestamp_punch (timestamp_punch),
  KEY user_id (user_id),
  CONSTRAINT eav_addon_entity_code_id_ibfk_1 FOREIGN KEY (user_id) REFERENCES user_info (id),
  CONSTRAINT eav_addon_entity_code_ea_code_fk FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON UPDATE CASCADE,
  CONSTRAINT eav_addon_entity_code_parent_id_fk FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT eav_addon_entity_code_fk FOREIGN KEY (entity_code) REFERENCES entity(code) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


-- 11OCT2021
-- Addition of checkbox & radio column
ALTER TABLE demo ADD type_hidden VARCHAR(64) DEFAULT NULL AFTER text_flat;
ALTER TABLE demo ADD checkbox VARCHAR(64) DEFAULT NULL AFTER type_hidden;
ALTER TABLE demo ADD radio VARCHAR(64) DEFAULT NULL AFTER checkbox;
ALTER TABLE demo ADD checkbox_ms VARCHAR(512) DEFAULT NULL COMMENT 'Multistate Checkbox' AFTER radio;
ALTER TABLE demo ADD option_code CHAR(2) DEFAULT NULL COMMENT 'Multistate Checkbox' AFTER checkbox_ms;
ALTER TABLE demo ADD option_sn VARCHAR(32) DEFAULT NULL COMMENT 'Multistate Checkbox' AFTER option_code;

CREATE OR REPLACE VIEW entity_internal_external as SELECT IF(is_lib=0,'External','Internal') as entity ,count(*) as total_count FROM entity GROUP BY is_lib;


CREATE OR REPLACE VIEW internal_entity_count as SELECT(SELECT sn FROM entity WHERE code= entity_code) as entity ,count(*) as total_count FROM entity_attribute  GROUP BY entity_code;

CREATE OR REPLACE VIEW session_by_date as SELECT date_format(timestamp_punch,'%Y-%m-%d') as date,count(*) as total_count FROM sys_log GROUP BY date_format(timestamp_punch,'%Y-%m-%d');

CREATE OR REPLACE VIEW user_session_30_days as  SELECT get_user_internal_name(user_id) as user_name, count(*) as total_count FROM sys_log WHERE timestamp_punch > now() - INTERVAL 30 day GROUP BY user_id;

CREATE OR REPLACE VIEW user_engine_sessions as SELECT  get_user_internal_name(id) as user_name, (SELECT count(*) FROM sys_log WHERE action_type='DVEW' AND user_id=user_info.id ) as desk, (SELECT count(*) FROM sys_log WHERE action_type='FVEW' AND user_id=user_info.id ) as form FROM user_info;

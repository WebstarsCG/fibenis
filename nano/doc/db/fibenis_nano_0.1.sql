

---11OCT2021
---- Addition of checkbox & radio column
ALTER TABLE demo ADD type_hidden VARCHAR(64) DEFAULT NULL AFTER text_flat;
ALTER TABLE demo ADD checkbox VARCHAR(64) DEFAULT NULL AFTER type_hidden;
ALTER TABLE demo ADD radio VARCHAR(64) DEFAULT NULL AFTER checkbox;
ALTER TABLE demo ADD checkbox_ms VARCHAR(512) DEFAULT NULL COMMENT 'Multistate Checkbox' AFTER radio;
ALTER TABLE demo ADD option_code CHAR(2) DEFAULT NULL COMMENT 'Multistate Checkbox' AFTER checkbox_ms ;
ALTER TABLE demo ADD option_sn VARCHAR(32) DEFAULT NULL COMMENT 'Multistate Checkbox' AFTER option_code;

CREATE OR REPLACE VIEW entity_internal_external as SELECT IF(is_lib=0,'External','Internal') as entity ,count(*) as total_count FROM entity GROUP BY is_lib;


CREATE OR REPLACE VIEW internal_entity_count as SELECT(SELECT sn FROM entity WHERE code= entity_code) as entity ,count(*) as total_count FROM entity_attribute  GROUP BY entity_code;

CREATE OR REPLACE VIEW session_by_date as SELECT date_format(timestamp_punch,'%Y-%m-%d') as date,count(*) as total_count FROM sys_log GROUP BY date_format(timestamp_punch,'%Y-%m-%d');

CREATE OR REPLACE VIEW user_session_30_days as  SELECT get_user_internal_name(user_id) as user_name, count(*) as total_count FROM `sys_log` WHERE timestamp_punch > now() - INTERVAL 30 day GROUP BY user_id;

CREATE OR REPLACE VIEW user_engine_sessions as SELECT  get_user_internal_name(id) as user_name, (SELECT count(*) FROM sys_log WHERE action_type='DVEW' AND user_id=user_info.id ) as desk, (SELECT count(*) FROM sys_log WHERE action_type='FVEW' AND user_id=user_info.id ) as form FROM user_info;

--- entity count
CREATE VIEW entity_internal_external as SELECT IF(is_lib=0,'External','Internal') as entity ,count(*) as total_count FROM entity GROUP BY is_lib


CREATE VIEW internal_entity_count as SELECT(SELECT sn FROM entity WHERE code= entity_code) as entity ,count(*) as total_count FROM entity_attribute  GROUP BY entity_code

CREATE OR REPLACE VIEW session_by_date as SELECT date_format(timestamp_punch,'%Y-%m-%d') as date,count(*) as total_count FROM sys_log GROUP BY date_format(timestamp_punch,'%Y-%m-%d')

CREATE OR REPLACE VIEW user_session_30_days as  SELECT get_user_internal_name(user_id) as user_name, count(*) as total_count FROM `sys_log` WHERE timestamp_punch > now() - INTERVAL 30 day GROUP BY user_id

CREATE OR REPLACE VIEW user_session_30_days as  SELECT  get_user_internal_name(id), (SELECT count(*) FROM sys_log WHERE ) FROM user_info

CREATE VIEW user_engine_sessions as SELECT  get_user_internal_name(id) as user_name, (SELECT count(*) FROM sys_log WHERE action_type='DVEW' AND user_id=user_info.id ) as desk, (SELECT count(*) FROM sys_log WHERE action_type='FVEW' AND user_id=user_info.id ) as form FROM user_info
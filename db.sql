--
-- Key genrator

AAKY  -> Sign Up
AAKV  -> Key Verification
ACKY  -> Login Check 
ACHP  -> Change Password
AFGK  -> Forget Password
AGTO  -> Logout
ACUE  -> Check Existing User

SELECT 
md5('GATE__AAKY') as 'AAKY',  
md5('GATE__AAKV') as 'AAKV',  
md5('GATE__ACKY') as 'ACKY',  
md5('GATE__ACHP') as 'ACHP',  
md5('GATE__AFGK') as 'AFGK',  
md5('GATE__AGTO') as 'AGTO',  
md5('GATE__ACUE') as 'ACUE'  

-- EBAX
--- Entity Child Base Apex Entity Added


--
-- Table structure for table eav_addon_decimal
--

CREATE TABLE eav_addon_decimal (
  id int(11) NOT NULL,
  parent_id int(11) NOT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value decimal(14,4) DEFAULT NULL,
  user_id int(11) NOT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  ADD PRIMARY KEY (id),
  ADD KEY parent_id (parent_id),
  ADD KEY fk_eav_addon_decimal_ea_value (ea_code);
  
--
-- AUTO_INCREMENT for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  MODIFY id int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
  
--
-- Constraints for table eav_addon_decimal
--
ALTER TABLE eav_addon_decimal
  ADD CONSTRAINT fk_eav_addon_decimal_ea_code FOREIGN KEY (ea_code) REFERENCES entity_attribute (code) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT fk_eav_addon_decimal_parent_id FOREIGN KEY (parent_id) REFERENCES entity_child (id) ON DELETE CASCADE ON UPDATE NO ACTION;




--
-- Table structure for table exav_addon_vc128uniq
--

CREATE TABLE IF NOT EXISTS exav_addon_vc128uniq (
  id int(11) NOT NULL AUTO_INCREMENT,
  parent_id int(11) NOT NULL,
  exa_token varchar(32) NOT NULL,
  exa_value varchar(128) NOT NULL,
  exa_value_hash varchar(32) NOT NULL,
  user_id int(11) NOT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY exa_value_hash (exa_value_hash),
  KEY parent_id (parent_id,exa_token),
  KEY exa_token (exa_token,exa_value)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


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

--
-- Constraints for table eav_addon_vc128uniq
--
ALTER TABLE exav_addon_vc128uniq
  ADD CONSTRAINT fk_exav_addon_vc128uniq_exa_token FOREIGN KEY (exa_token) REFERENCES entity_child_base (token) ON DELETE CASCADE ON UPDATE NO ACTION;
SET FOREIGN_KEY_CHECKS=1;


--- Demo

CREATE TABLE page_info (
  id int(11) NOT NULL,
  parent_id int(11) NOT NULL,
  ea_code char(4) DEFAULT NULL,
  ea_value decimal(14,4) DEFAULT NULL,
  user_id int(11) NOT NULL,
  timestamp_punch timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
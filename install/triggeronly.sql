-- Adminer 4.8.1 MySQL 5.5.5-10.6.4-MariaDB dump

DELIMITER ;;

CREATE TRIGGER `update_ContactGroup_after_UpdateContact` AFTER UPDATE ON `Contact` FOR EACH ROW
update ContactGroup set members=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',members,','), CONCAT(',',OLD.contact_name,','), CONCAT(',',NEW.contact_name,',')) )  where FIND_IN_SET(OLD.contact_name, members);;

CREATE TRIGGER `update_ContactGroup_after_DeleteContact` AFTER DELETE ON `Contact` FOR EACH ROW
update ContactGroup set members=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',members,','), CONCAT(',',OLD.contact_name,','),  ',') )  where FIND_IN_SET(OLD.contact_name, members);;

DELIMITER ;



DELIMITER ;;

CREATE TRIGGER `update_Service_after_UpdateContactGroup` AFTER UPDATE ON `ContactGroup` FOR EACH ROW
update Service set contact_groups=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',contact_groups,','), CONCAT(',',OLD.contactgroup_name,','), CONCAT(',',NEW.contactgroup_name,',')) )  where FIND_IN_SET(OLD.contactgroup_name, contact_groups);;

CREATE TRIGGER `update_Service_after_DeleteContactGroup` AFTER DELETE ON `ContactGroup` FOR EACH ROW
update Service set contact_groups=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',contact_groups,','), CONCAT(',',OLD.contactgroup_name,','), ',') )  where FIND_IN_SET(OLD.contactgroup_name, contact_groups);;

DELIMITER ;

DELIMITER ;;

CREATE TRIGGER `update HostGroup_after_UpdateHost` AFTER UPDATE ON `Host` FOR EACH ROW
update HostGroup set members=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',members,','), CONCAT(',',OLD.host_name,','), CONCAT(',',NEW.host_name,',')) )  where FIND_IN_SET(OLD.host_name, members);;

CREATE TRIGGER `update_Service_after_UpdateHost` AFTER UPDATE ON `Host` FOR EACH ROW
update Service set host_name=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',host_name,','), CONCAT(',',OLD.host_name,','), CONCAT(',',NEW.host_name,',')) )  where FIND_IN_SET(OLD.host_name, host_name);;

CREATE TRIGGER `update_Service_after_UpdateHostEQ` AFTER UPDATE ON `Host` FOR EACH ROW
update Service set host_name=NEW.host_name where host_name=OLD.host_name;;

CREATE TRIGGER `update_HostGroup_after_DeleteHost` AFTER DELETE ON `Host` FOR EACH ROW
update HostGroup set members=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',members,','), CONCAT(',',OLD.host_name,','), ',') )  where FIND_IN_SET(OLD.host_name, members);;

CREATE TRIGGER `update_Service_after_DeleteHost` AFTER DELETE ON `Host` FOR EACH ROW
BEGIN
	delete from Service where host_name=OLD.host_name;
	update Service set host_name=TRIM(BOTH ',' FROM REPLACE( CONCAT(',',host_name,','), CONCAT(',',OLD.host_name,','), ',') )  where FIND_IN_SET(OLD.host_name, host_name);
  END;;

DELIMITER ;


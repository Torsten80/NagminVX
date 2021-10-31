<?php
$pbsdummy='dummy';
$pbsdummylogin="cn=dummy,ou=myou,dc=Tortisoft,dc=de";
$pbsdummypwd='geheim';
$context="ou=user,dc=Tortisoft,dc=de";
$ldapconnection='ldaps://mydc01.Tortisoft.de/';
$ds = ldap_connect($ldapconnection) or die("Failed to connect to ldap server.");

//ldap_set_option(NULL, LDAP_OPT_DEBUG_LEVEL, 7);
ldap_set_option($ds, LDAP_OPT_PROTOCOL_VERSION, 3);
ldap_set_option($ds, LDAP_OPT_REFERRALS, 0);
ldap_set_option($ds, LDAP_OPT_SIZELIMIT, 2000);

   $r1=ldap_bind($ds,$pbsdummylogin,$pbsdummypwd ) or die("Could not bind to LDAP");
?>
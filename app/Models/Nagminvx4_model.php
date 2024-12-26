<?php 
namespace App\Models;
use CodeIgniter\Database\ConnectionInterface;
use CodeIgniter\Model;
use CodeIgniter\Database\Exceptions\DatabaseException;
	

class Nagminvx4_model extends Model {
		

		function getmytables1($ndb){
//			$ndb="nagios";
                        if(!$ndb) $ndb= "default";
			$db1 = db_connect($ndb);		
			$tables = $db1->listTables();
			return $tables;
		}



		function get_query($ndb,$query){
			if(!$ndb) $ndb= "default";
		    $db = db_connect($ndb);
	//		log_message('debug',"o#########! $ndb !!#################");
			try
			{
			$query=$db->Query("$query");
			}
			catch (\Exception $e)
		   {
			$myerror=$e->getMessage();	
			return($myerror);
		   }
		

			  $res = $query->getResultArray();
		 
			return $res;
		}

		function get_querySimple($ndb,$query){
			if(!$ndb) $ndb= "default";
		    $db = db_connect($ndb);

                    if ($db->simpleQuery("$query")) {
		     log_message('info', 'Success!');
		     } else {
			    log_message('info', 'Query failed!');
	             }
			return 1;
		}

		
		function get_queryX($ndb,$query){
		 if(!$ndb) $ndb= "default";

		    $db = db_connect($ndb);

			try
			{
			$query=$db->Query("$query");
			}
			catch (\Exception $e)
		   {
			$myerror=$e->getMessage();	
			return($myerror);
		   }
	//	log_message('debug',$query->getResult());
		//	 $res = $query->getResultArray();
		
		//	return 1;
		}
	
		function get_num_fields($ndb,$query){
		    $db = db_connect($ndb);
			$query=$db->Query("$query");
	        $res= $query->getFieldCount();
			return $res;
			
		}

	


function getmytableheadpure($ndb,$x) {
	if(!$ndb) $ndb= "default";
	$db1 = db_connect($ndb);		
	$query = $db1->getFieldNames($x);
	return $query;
}

function getmytablepkey($ndb,$x) {
        if(!$ndb) $ndb= "default";
	$db1 = db_connect($ndb);		
	$fields = $db1->getFieldData($x);
	$pkey="";
	foreach ($fields as $field)
	{
	/*		echo $field->name;
			echo $field->type;
			echo $field->max_length;
			echo $field->primary_key;
			*/
	 if($field->primary_key){
			//return $field->name;
			$pkey=$pkey.":".$field->name;

	    }
	}
	//return $fields->primary_key;
	return $pkey;
}

	  
	
function myupdate($ndb,$tname,$data,$where)
 {

	if(!$ndb) $ndb= "default";
	$db = db_connect($ndb);	
	$builder = $db->table($tname);

	$builder->set($data, FALSE);
	$builder->where($where);
	
	try
	{
     $builder->update(); // gives UPDATE mytable SET field = field+1 WHERE `id` = 2
	}
	catch (\Exception $e)
   {
	$myerror=$e->getMessage();	
	return($myerror);
   }

   return $db->affectedRows();
 }


	
 function myadd($ndb,$tname,$data)
 {
 	if(!$ndb) $ndb= "default";
	$db = db_connect($ndb);	
	$builder = $db->table($tname);

	try
	{
     $builder->insert($data);
	}
 	catch (\Exception $e)
	{
	 $myerror=$e->getMessage();	
	 return($myerror);
	}

      return $db->affectedRows();
 }

 function mydelete($ndb,$ndata)
 {
	if(!$ndb) $ndb= "default";
	$db = db_connect($ndb);	

	try
	{
	$query=$db->Query("$ndata");
    }
	catch (\Exception $e)
	{
	 $myerror=$e->getMessage();	
	 return($myerror);
	}
			
     return $db->affectedRows();
 }



}
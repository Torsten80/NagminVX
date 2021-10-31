<?php 
namespace App\Models;
use CodeIgniter\Database\ConnectionInterface;
use CodeIgniter\Model;

	

class Nagminvx4_model extends Model {
		

		function getmytables1($ndb){
			$db1 = db_connect($ndb);		
			$tables = $db1->listTables();
			return $tables;
		}



		function get_query($ndb,$query){
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
		
			$res = $query->getResultArray();
			return $res;
		}
	
		function get_num_fields($ndb,$query){
		    $db = db_connect($ndb);
			$query=$db->Query("$query");
	        $res= $query->getFieldCount();
			return $res;
			
		}

	


function getmytableheadpure($ndb,$x) {
	$db1 = db_connect($ndb);		
	$query = $db1->getFieldNames($x);
	return $query;
}

function getmytablepkey($ndb,$x) {

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
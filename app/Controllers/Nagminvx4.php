<?php namespace App\Controllers;
use CodeIgniter\Controller, Myth\Auth\auth; 
 //?????????????????????????????????????
use App\Models\Nagminvx4_model;
use CodeIgniter\Events\Events;


$session = session();

helper('Myth\Auth\auth');
helper('filesystem');


Events::on('DBQuery', function ($query) {

$session = session();		
	if(!$session->has('uname')){
		log_message('debug',"auf uname kann nicht zugegriffen werden!");
		$_SESSION['uname']="unbekannt";
		//return;
	}
	
	if(stristr($query,"SELECT *") ) return;
	if(stristr($query,"update") or stristr($query,"insert") or stristr($query,"delete") ) {
//		user()

			$user=$_SESSION['uname'];
		log_message('info',"Audit: $user: $query");
	    }


});


//class Nagminvx4 extends BaseController
class Nagminvx4 extends \CodeIgniter\Controller
{
	
	 public function index()
	{
	  //		$auth = Services::authenticate();
	  $ll=logged_in();
	  //$uu1=user();
	 // $current_user = $auth->user();
	  $uu=user_id();

//	  log_message('debug',"logged_in:::::::::::::::::::::::::::::::::::::::::::");
//	  print_r($uu);
//	  log_message('debug',"$current_user");
	  log_message('debug',"$ll");
	  log_message('debug',"$uu");
		echo view('start_view');
		echo view('templates/footer');

	}

		public function setsessionuser()
	{		 
		$user = service('request')->getPost('user');
		// log_message('info',"Audit: $user: +++++++++++++++");
        $session = session();
        $session->set('uname', $user);
        
		echo "$user";
	}	

		public function nvtables()
	{		 
		$data['nvtable'] = $this->request->uri->getSegment(3);
        echo view('nvtables_view', $data);
	}
	

		public function nvfile()
	{		 
		$nvfilex = $this->request->uri->getSegment(3);
		$nvfile = explode(':',$nvfilex);

		$myfile = getenv('nagdir');
		$myfile = WRITEPATH."$myfile/$nvfile[0]";

		echo "<p>$myfile:<p>";
		//$datax = shell_exec ("cat $mycmd");
		$datax = file_get_contents("$myfile");
	
		if($datax){
		    echo "<small>";
			echo nl2br($datax);
			echo "</small>";
		}else{
			echo "<b> Error while executing: $myfile";
		}


	}
	
	public function get_control()
	{
		$data=array();
		$dir = getenv('nagdir');
		$dir = WRITEPATH."$dir/";
	
		$files1 = scandir($dir);
		echo json_encode($files1);
	}


	public function nvtables1()
	{
		 $ntable = $this->uri->segment(3);
		 $ndb = getenv('MyDBCCCCCCCCCCCCCCCCCCCC????????????????????????????????????????????');
		 $query = "select * from $ntable";
		 $ndb = getenv('MyDBCCCCCCCCCCCCCCCCCCCC????????????????????????????????????????????');
		 $data = $this->nagminvx4->get_query($ndb,$query);
		 echo json_encode($data);
		 

	}


	public function get_mytables()
	{
		$data = $this->nagminvx4->listcollections();
		echo json_encode($data);
    }
	

	public function get_query()
	{
	
		if ($this->request->isAJAX()) {
			$query = service('request')->getPost('query');
			$ndb= service('request')->getPost('ndb');
		}

		

		$model = new Nagminvx4_Model();
 
		$data = $model->get_query($ndb,$query);
	
		echo json_encode($data);
		
    }
	


	public function get_form()
	{
		$model = new Nagminvx4_Model();
	

		if ($this->request->isAJAX()) {
			$query = service('request')->getPost('query');
			$tname = service('request')->getPost('tname');
			$ndb= service('request')->getPost('ndb');
		}


		log_message('debug',$tname);
		log_message('debug',"o#########! $ndb !!#################");


		$ttname = explode(":", $tname);
		$tname = $ttname[0];
		
		log_message('debug',$tname);
		log_message('debug',"o##########################1");
	
		// $query="desc $tname ";
		$mydefault="NagminVX";
		if($ttname[1]==1) $ndb = getenv('MyDB');
		else $ndb="";
		log_message('debug',$ndb);


// TFTFTF???????? wie Feldtypen erhalten
// https://codeigniter.com/user_guide/database/query_builder.html#updating-data
		for($i=0;$i<sizeof($query);$i++){
			$query[$i]= strtr($query[$i], "+", " "); 
			
			log_message('debug',"query:");

		 log_message('debug',$query[$i]);
		 
		}
		
	//	$ndb = getenv('MyDB');
		$data = $model->get_query($ndb,$query[0]);
	    echo json_encode($data);
//    	echo $data;
       }
// ------------------------------------------------------------------------------------	

public function get_newform()
{
	$model = new Nagminvx4_Model();

	if ($this->request->isAJAX()) {
		$tname = service('request')->getPost('tname');
	}
	log_message('debug',$tname);
	$ttname = explode(":", $tname);
	$tname = $ttname[0];
	
	log_message('debug',$tname);
	log_message('debug',"o##########################++++++++111");

	// $query="desc $tname ";
	$mydefault="NagminVX";
	if($ttname[1]==1) $ndb = getenv('MyDB');
	else $ndb="";
	log_message('debug',$ndb);

	$query="SELECT column_name, table_name, COLUMN_TYPE, nsource, ntype, EXTRA FROM `information_schema`.`columns` left join $mydefault.Relations USING (table_name,column_name) WHERE `table_schema` = DATABASE() AND `table_name` ='$tname'";
	log_message('debug',$query);
 
	$data = $model->get_query($ndb,$query);

//print_r($data);
	echo json_encode($data);
}




public function get_mytable()
	{
	
		$model = new Nagminvx4_Model();
 
		if ($this->request->isAJAX()) {
			$x = service('request')->getPost('ntable');
			$nb = service('request')->getPost('ndb');
		}
		if($nb ==1) $ndb = getenv('MyDB');
  			else $ndb="";


//		log_message('debug',"$ndb-----XXXXXXXXXX--------------");
 //$ndb = getenv('MyDB');
	log_message('debug',"$ndb-----XXXXXXXXXX--------------");
 $query="select * from $x";
 $list = $model->get_query($ndb,$query);
 //		log_message('debug',"list-------------------");
 $myfields = $model->getmytableheadpure($ndb,$x);

 $pkey=$model->getmytablepkey($ndb,$x);
 $ppkey = explode(":", $pkey);
log_message('debug',"pkey-------------------$pkey");
		
$data = array();
$fcount=0;
foreach ($list as $l) {
 $row = array();
 foreach ($myfields as $key1 => $val1) {
	// find val1 in list
	$flag=0;

    // für das select
    $xtext="select+*+from+".$x."+where+"; // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    $j=0;
    foreach ($l as $key => $val) {
	 // if($key==$pkey) $xtext=$xtext.$val."'";
     //	log_message('debug',"xx--$key==-$ppkey[1]-$ppkey[0]--$ppkey[2]-------------");
	 if (array_search($key, $ppkey)) {
//		log_message('debug',"gefunden-------------------");
		$i = array_search($key, $ppkey);  // $key = 2;
//		log_message('debug',"i-------------------$i");
		$val = str_replace(" ", "+", $val);

		if($j==0 )$xtext=$xtext.$ppkey[$i]."='".$val."'";
		 else $xtext=$xtext."+and+".$ppkey[$i]."='".$val."'";
		$j++;

	}
  }

 
  // log_message('debug',"i-----------$xtext--------test");
  //			$row[] = '<input type="checkbox"  id="checkbox"  value='. "$xtext".'>'; 
  $xtext=str_replace("\n","%",$xtext); // ugly , but I need this workaround !!!!!!!!!!!!!!!!!!!!!!!!!!!
  $row[] = "<input type='checkbox'  id='checkbox'  value=$xtext >"; 
  foreach ($l as $key => $val) {  // Feldname passt; Flag = Treffer, nicht leer
     $val  = str_replace(",", ", ", $val);
	 $row[] = $val;  
  }	

   if($flag==0) $row[] ="";
}	
$fcount++;
$data[] = $row;
}

		$output = array(
//			            "draw" => $_POST['draw'],
//						"recordsTotal" => $tcount,
						"recordsFiltered" => $fcount,
						"data" => $data,
				);
		echo json_encode($output);

 }
	


 	  public function get_mygroup($user)
 	{
		 $query="select group_id from users, auth_groups_users where username='$user' and id=user_id;";
//		 $query="select group_id from users, auth_groups_users where username='paul' and id=user_id;";
		 $model = new Nagminvx4_Model();
		 $ndb="";
		 $data = $model->get_query($ndb,$query);
		 if(!$data) $data[0]['group_id']=99 ;
		  return($data[0]);
 	}



	 public function is_admin()
	{
	 $user=$_SESSION['uname'];
	 if(is_numeric ($user)){
	  $u1=user();
	  $user=$u1->username;
	 }
	 $admin=$this->get_mygroup($user);
	 $adm=$admin['group_id'];
	 return($adm);
	}

	   public function get_mytables1()
	{
				
		if ($this->request->isAJAX()) {
			$ndb = service('request')->getPost('ndb');
		}

		$model = new Nagminvx4_Model();

		
		$user=$_SESSION['uname'];
		if(is_numeric ($user)){
		 $u1=user();
		 $user=$u1->username;
		}
		$admin=$this->get_mygroup($user);
		$adm=$admin['group_id'];


		log_message('info',"AAAAAAAAAAAAAAAAA: $user:  $adm");
 // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     if($adm==1 || $ndb){
 		$data = $model->getmytables1($ndb);
		echo json_encode($data);
	 }	 else echo json_encode(NULL);
 	}
	


	   public function get_mytablesimple()
	{
		$x=$this->input->post('ntable');
		log_message('debug','nable;');
		log_message('debug',$x);
		$list = $this->nagminvx4->getmyquery1($x);
		$data = array();
		foreach ($list as $l) {
			$row = array();
	
			foreach ($l as $key => $val) {
				$row[] =$val;
			}	
			$data[] = $row;
		}

		echo json_encode($data);
       }
	

	   public function get_mytablecolumns()
	{

		 if ($this->request->isAJAX()) {
			$ntable = service('request')->getPost('ntable');
			$nb = service('request')->getPost('ndb');
		}
		if($nb ==1) $ndb = getenv('MyDB');
  			else $ndb="";
//$ndb = getenv('MyDB');

		$model = new Nagminvx4_Model();
 
		$data = $model->getmytableheadpure($ndb,$ntable);
	
		echo json_encode($data);



     }

	 public function ssystem()
	 {

	   // $last_line = system('ls -l', $retval);
	    $mycmd="ls -l";
		$data = shell_exec ("pwd & echo '$mycmd' & $mycmd");
		echo nl2br($data);
	  }
 




	  public function snmp_run($nquery)
	 {

		echo "<script type=\"text/javascript\"> $('#spinner').hide();</script>";
		echo "<a class=\"btn btn-secondary\" href=\"javascript:void(0)\" id=\"btnStart\" title=\"start\" onclick=\"myaction('SNMP_Walker')\"><i class=\"glyphicon glyphicon-step-backward\"></i> Back</a><p>";
		$model = new Nagminvx4_Model();
		//$ndb = getenv('MyDB');
		$ndb="";
//		$query="select * from SNMP_Walker"
		log_message('debug',$nquery);
 
    	$data = $model->get_query($ndb,$nquery);
	//	echo "Hallo xxx $data[1]";
		print_r($data);
		//echo json_encode($data);
		$sversion=$data[0]['version'];
		$shost_name=$data[0]['host_name'];
		$query="select address from Host where host_name=\"$shost_name\"";
		$ndb = getenv('MyDB');
		$data1 = $model->get_query($ndb,$query);
		$shost_ip=$data1[0]['address'];
	 
		$scommunity=$data[0]['community'];

		$sauthProtocol=$data[0]['authProtocol']; if($sauthProtocol) $sauthProtocol="-a $sauthProtocol";
		$sprivProtocol=$data[0]['privProtocol']; if($sprivProtocol) $sprivProtocol="-x $sprivProtocol";
		$sauthKey=$data[0]['authKey']; if($sauthKey) $sauthKey="-A '$sauthKey'";
		$sprivKey=$data[0]['privKey'];  if($sauthKey) $sprivKey="-X '$sprivKey'";
		$ssecurityLevel=$data[0]['securityLevel'];
		$soid=$data[0]['oid'];
		$sport=$data[0]['port'];  if($sport) $sport=":$sport";

	

		$snmp1 = array("1", "2", "2c");
        if (in_array($sversion, $snmp1)) {
			$mycmd= "snmpwalk -v$sversion -c $scommunity $shost_ip$sport $soid 2>&1";  
        }else{
		/*	
			snmpwalk -v3 -l <noAuthNoPriv|authNoPriv|authPriv> -u <username> [-a <MD5|SHA>] [-A <authphrase>]
			[-x <DES|AES>] [-X <privaphrase>] <ipaddress>[:<dest_port>] [oid]
			*/
			$mycmd= "snmpwalk -v3 -l $ssecurityLevel -u $scommunity $sauthProtocol $sauthKey $sprivProtocol $sprivKey $shost_ip$sport $soid 2>&1 ";

		}

		echo "<p><hr><p>";

		echo "<p>$mycmd<p>";
		$output = shell_exec($mycmd);
		echo "<pre>$output</pre>";
		echo "<p><hr><p>";

		echo "<a class=\"btn btn-secondary\" href=\"javascript:void(0)\" id=\"btnStart\" title=\"start\" onclick=\"myaction('SNMP_Walker')\"><i class=\"glyphicon glyphicon-step-backward\"></i> Back</a>";
		
/*
		$a = snmpwalk("127.0.0.1", "public", "");

foreach ($a as $val) {
    echo "$val\n";
}
*/

 }
 
// ###################################################

public function interface_run($nquery)
{

   echo "<script type=\"text/javascript\"> $('#spinner').hide();</script>";
   echo "<a class=\"btn btn-secondary\" href=\"javascript:void(0)\" id=\"btnStart\" title=\"start\" onclick=\"myaction('Interface_Scanner')\"><i class=\"glyphicon glyphicon-step-backward\"></i> Back</a><p>";
   $model = new Nagminvx4_Model();
   //$ndb = getenv('MyDB');
   $ndb="";
   log_message('debug',$nquery);

   $data = $model->get_query($ndb,$nquery);
//   print_r($data);
   //echo json_encode($data);
   $sversion=$data[0]['version'];
   $shost_name=$data[0]['host_name'];

   $query="select address from Host where host_name=\"$shost_name\"";
   $ndb = getenv('MyDB');
   $data1 = $model->get_query($ndb,$query);
   $shost_ip=$data1[0]['address'];


 //  echo "<p>-- $shost_ip -";
   $scommunity=$data[0]['community'];
   
//  // für  Alternative  ein einfacher snmpwalk
/*   $sauthProtocol=$data[0]['authProtocol']; if($sauthProtocol) $sauthProtocol="-a $sauthProtocol";
   $sprivProtocol=$data[0]['privProtocol']; if($sprivProtocol) $sprivProtocol="-x $sprivProtocol";
   $sauthKey=$data[0]['authKey']; if($sauthKey) $sauthKey="-A $sauthKey";
   $sprivKey=$data[0]['privKey'];  if($sauthKey) $sprivKey="-X $sprivKey";
*/

   $sauthProtocol=$data[0]['authProtocol']; if($sauthProtocol) $sauthProtocol="$sauthProtocol";
   $sprivProtocol=$data[0]['privProtocol']; if($sprivProtocol) $sprivProtocol="$sprivProtocol";
   $sauthKey=$data[0]['authKey']; if($sauthKey) $sauthKey="$sauthKey";
   $sprivKey=$data[0]['privKey'];  if($sauthKey) $sprivKey="$sprivKey";


   $ssecurityLevel=$data[0]['securityLevel'];
   $soid=$data[0]['oid'];
   $sport=$data[0]['port'];  if($sport) $sport=":$sport";


   $soid=".1.3.6.1.2.1.2.2.1.2";

   $snmp1 = array("1", "2", "2c");



  if (in_array($sversion, $snmp1)) {
	   $mycmd= "/usr/local/nagios/libexec/check_nwc_health --mode list-interfaces-detail --hostname $shost_ip --protocol $sversion --community $scommunity 2>&1";  
   }else{
	   
	   $mycmd= "/usr/local/nagios/libexec/check_nwc_health --mode list-interfaces-detail --hostname $shost_ip --protocol $sversion --username $scommunity --authpassword '$sauthKey' --authprotocol $sauthProtocol --privpassword '$sprivKey' --privprotocol $sprivProtocol 2>&1";

   }



 // oder Alternative  ein einfacher snmpwalk
/*   
   
   if (in_array($sversion, $snmp1)) {
	   $mycmd= "snmpwalk -v$sversion -c $scommunity $shost_name$sport $soid 2>&1";  
   }else{
  
	   $mycmd= "snmpwalk -v3 -l $ssecurityLevel -u $scommunity $sauthProtocol $sauthKey $sprivProtocol $sauthKey $shost_name$sport $soid 2>&1 ";

   }
*/
   echo "<p><hr><p>";

   echo "<p>$mycmd<p>";
   $output = shell_exec($mycmd);
   echo "<pre>$output</pre>";
   echo "<p><hr><p>";

   echo "<a class=\"btn btn-secondary\" href=\"javascript:void(0)\" id=\"btnStart\" title=\"start\" onclick=\"myaction('Interface_Scanner')\"><i class=\"glyphicon glyphicon-step-backward\"></i> Back</a>";
   
/*
   $a = snmpwalk("127.0.0.1", "public", "");

foreach ($a as $val) {
echo "$val\n";
}
*/

}


public function get_default()
{
	$nagdir = getenv('nagdir');
    $ini_array = parse_ini_file(WRITEPATH."$nagdir/config", true, INI_SCANNER_RAW);

    //echo($ini_array);
	echo json_encode($ini_array);

}


public function dynamic_servicegroup_services() 
{
	
	    echo "dynamic_servicegroup_services\n";
		$model = new Nagminvx4_Model();
		$ndb = "";
		$nagdir = getenv('nagdir');
		$ndb = getenv('MyDB');
		$ini_array = parse_ini_file(WRITEPATH."$nagdir/config", true, INI_SCANNER_RAW);
		$defaultcontactgroup=$ini_array['contact_groups'];

		$table="Service";
		$query = "select host_name,service_templates,contact_groups FROM ServiceGroup, Host WHERE service_group like  concat('%',servicegroup_name,',%')  or service_group = servicegroup_name  or service_group like  concat('%,',servicegroup_name,'%')";
		$numfields= $model->get_num_fields($ndb,$query);

		$data = $model->get_query($ndb,$query);
		  
     	foreach ($data as $row)	  {

			foreach ($row as $key => $value){
			 if($key=='service_templates') {

				log_message('debug',"gefunden-------------------cccccccccccccc");
  			   $ttempl=explode(",", $value);
			   for($k=0;$k<sizeof($ttempl);$k++){
	// ******* Contact_groups ermitteln
	//$data = $model->get_query($ndb,$query);	


			   if($row['contact_groups']) $contactgroup=$row['contact_groups']; else $contactgroup=$defaultcontactgroup;
	//## overwrite contact_groups if contact groups in Service_Template is set
	    	   $query = "select contact_groups, service_description from `ServiceTemplate` where name='$ttempl[$k]'";
			   $data1 = $model->get_query($ndb,$query);
			   //$row1 = $data1->fetch_row();
			   if($data1[0]['contact_groups']) $contactgroup=$data1[0]['contact_groups'];
	////////////////////////////////////////////////////////////////////////////
				$query = "select service_description from Service where service_description='".$data1[0]['service_description']."' and (host_name like '%".$row['host_name'].",%' or host_name='".$row['host_name']."' or host_name like '%,".$row['host_name']."')";
				
				
				//log_message('debug',"contact_groups-------------------$query");
				$data2 = $model->get_query($ndb,$query);
				//$row2 = $data2->fetch_row();

				$hname=$row['host_name'];

			   if($data2){ 
				$sname=$data2[0]['service_description'];
        		$cmd="# $sname for $hname is allready definied in Service\n";
				write_file(WRITEPATH."$nagdir/$table.cfg", "$cmd\n",'a');		
 			   }
			   else{
			    write_file(WRITEPATH."$nagdir/$table.cfg", "define service {\n",'a');		
   			    $cmd="use ";
			    write_file(WRITEPATH."$nagdir/$table.cfg", "\t$cmd $ttempl[$k]\n",'a');		




/*
//	            $finfo1 = $data[0]->fetch_field_direct(0);
				log_message('debug',"aaaaaaaaaaaaaaaa-------------------$myxxx");
     		    $cmd="   ".$finfo1->name." ";
			    write_file(WRITEPATH."$nagdir/$table.cfg", "$cmd 'row[0]",'a');	
//			    $finfo2 = $data->fetch_field_direct(2);
				log_message('debug',"bbbbbbbbbbbbbb-------------------$myxxx");
		        $cmd="   ".finfo2->name." ";
*/				
			    write_file(WRITEPATH."$nagdir/$table.cfg", "\thost_name $hname\n",'a');	
				write_file(WRITEPATH."$nagdir/$table.cfg", "\tcontact_groups $contactgroup\n}\n",'a');	
				
			  }
	//*********************************************************************
	    	} // if
		  } // for
		 
	    } // foreach
	 
	}
}
	



Function load_template($table,$value,$nagdir)
{

$teml_arry = array(); 
$model = new Nagminvx4_Model();
$ndb = getenv('MyDB');
$nagdir = getenv('nagdir');
$ini_array = parse_ini_file(WRITEPATH."$nagdir/config", true, INI_SCANNER_RAW);

	$template = "";
	if ($table == "host" ) { $template="HostTemplate"; }
	if ($table == "contact") { $template="ContactTemplate"; }
	if ($table == "service") { $template="ServiceTemplate";}
	if ($table == "hostextinfo") { $template="HostExtTemplate";}
	if ($table == "serviceextinfo") { $template="ServiceExtTemplate";}

	if ($template != "") {
		$query= "select * from $template where name=\"$value\"\n";
//		echo "::::select * from $template where name=\"$value\" <br>";
		$data = $model->get_query($ndb,$query);
	
		foreach ($data as $row)
		{
     	  foreach ($row as $key => $value){
  
//					log_message('debug',"   $key \t $value");
// programm default werte --- aus ini File 
					if (array_key_exists($key, $ini_array)){
					  $teml_arry[$key]=$ini_array[$key];
			//		  echo "treffer $teml_arry[$key]=$ini_array[$key]<br>";
					}
		  	  
		           if($value== "" | !$value){}
				   else {
	//				log_message('debug',"====   $key \t $value");
					 $teml_arry[$key]=$value;
				   }
		  

	      }
		}
	}
    return($teml_arry);
}






public function wcommon($table,$key1)
{

log_message('debug',"i-------------$table,$key1------");	
$model = new Nagminvx4_Model();
$ndb = "";
$nagdir = getenv('nagdir');
$ndb = getenv('MyDB');

$createtime=date(DATE_RFC822);

if ( ! write_file(WRITEPATH."$nagdir/$table.cfg", "# NagMIN Configuration File ($nagdir/$table.cfg)\n# Generated $createtime \n"))
{
	echo 'Unable to write the file<p>';
};


	$query= "select * from $table order by $key1";
	$numfields= $model->get_num_fields($ndb,$query);
    $data = $model->get_query($ndb,$query);
  
	  foreach ($data as $row)
	  {

	 $ccmd=strtolower($table);


//load_template($ccmd,$row[0]);
//       $key=strtolower($key);
	   $ccmd=strtolower($table);


		if ($ccmd == "contacttemplate") { $ccmd = "contact"; }
		else if ($ccmd == "hosttemplate") { $ccmd = "host"; }
		else if ($ccmd == "hostexttemplate") { $ccmd = "hostextinfo"; }
		else if ($ccmd == "servicetemplate") { $ccmd = "service"; }
		else if ($ccmd == "serviceexttemplate") { $ccmd = "serviceextinfo"; }

	
		$xxx=reset($row);
		//$xxx=key($row);
		//log_message('debug',"load_template($ccmd,$xxx)");
		$teml_arry=$this->load_template($ccmd,$xxx,$nagdir);

		write_file(WRITEPATH."$nagdir/$table.cfg", "define $ccmd {\n",'a');	
//		fwrite($handle,"define $ccmd{\n");
//			system("echo \"define $ccmd {\">> $nagdir/$table.cfg");

			foreach ($row as $key => $value){

             		$ok=1;
		           
				   // wenn kein Wert , dann aus Template nehmen
        			if (array_key_exists($key, $teml_arry) && $value == "") {  
				//		log_message('debug',"test $key=$value");
				//		echo "$value=$teml_arry[$key]<p>";
            			$value=$teml_arry[$key];
        			}

					if ($value == "") { $ok=0; } 
					if ($key== "community") { $ok=0; }
					if ($key== "hostextinfo") { $ok=0; }
					if ($table == "hostgroup" && $foo== "contact_groups") { $ok=0; }
					if ($key== "service_group") { $ok=0; }
					if ($key== "port_scan") { $ok=0; }
					if ($key== "port") { $ok=0; }
					if ($key== "protocol") { $ok=0; }
					if ($key== "id") { $ok=0; }
					if ($key== "level") { $ok=0; }
					if ($key== "password") { $ok=0; }
					if ($key== "store_config") { $ok=0; }
					if ($key== "current_contact_groups") { $ok=0; }
					if ($key== "template") { $key="use"; }
					if ($key== "hostgroup_name" && $ccmd == "serviceextinfo") { $foo="hostgroup"; }
					if ($key== "host_notification_options" && strtolower($table) == "host") {
						$key="notification_options";  }
					if ($key== "host_notification_options" && strtolower($table) == "hosttemplate") {
						$key="notification_options";  }
					if ($key== "service_notification_options" && strtolower($table) == "service") {
						$key="notification_options";  }
					if ($key== "service_notification_options" && strtolower($table) == "servicetemplate" ) { 
						$key="notification_options"; }

        			if($ok==1){ 
         				if($key=='comment') 
           				$cmd="#  ".$key." ";
          				else $cmd="\t".$key." ";

        			$cmd = str_replace("'", '"', $cmd);
    				$value = str_replace("'", '"', $value);

					if ($key=="service_description") {
						$value = str_replace("[", '{', $value);
						$value = str_replace("]", '}', $value);
						$value = str_replace("(", '{', $value);
						$value = str_replace(")", '}', $value);
					}


//$value = mb_convert_encoding($value, "ISO-8859-1"); // 'Windows-1252', 'UTF-8'
//$value = mb_convert_encoding($value, 'Windows-1252', 'UTF-8'); // 'Windows-1252', 'UTF-8'
					 write_file(WRITEPATH."$nagdir/$table.cfg", "$cmd  $value\n",'a');
//					 fwrite($handle,"$cmd  $value\n");
//					 system("echo '$cmd' '$value' >> $nagdir/$table.cfg");
	
        }
       }
	   write_file(WRITEPATH."$nagdir/$table.cfg", "}\n",'a');	
      }

}

	  

	  public function write_config()
	  {
 
		date_default_timezone_set('Europe/Berlin'); // ???????????????
		$createtime=date(DATE_RFC822);
		$nagdir = getenv('nagdir');
		$ini_array = parse_ini_file(WRITEPATH."$nagdir/config", true, INI_SCANNER_RAW);

//		//$nagios_tables = array ("Command","Contact","ContactGroup","ContactTemplate","Host","HostDependency","HostEscalation","HostExtInfo","HostExtTemplate","HostGroup","HostGroupEscalation","HostTemplate","Service","ServiceDependency","ServiceEscalation","ServiceExtInfo","ServiceExtTemplate","ServiceTemplate","TimePeriod","PollerTags");
		//$nagios_tables = array ("Command","Contact","ContactGroup","ContactTemplate","Host","HostDependency","HostEscalation","HostExtInfo","HostExtTemplate","HostGroup","HostGroupEscalation","HostTemplate","Service","ServiceDependency","ServiceEscalation","ServiceExtInfo","ServiceExtTemplate","ServiceTemplate","TimePeriod","Poller");
		$nagios_tables = array ("Command","Contact","ContactGroup","ContactTemplate","Host","HostDependency","HostEscalation","HostExtInfo","HostExtTemplate","HostGroup","HostGroupEscalation","HostTemplate","Service","ServiceDependency","ServiceEscalation","ServiceExtInfo","ServiceExtTemplate","ServiceTemplate","TimePeriod");
		
		$teml_arry = array(); 
		foreach ($nagios_tables as &$table) {
			
			$ccmd=strtolower($table);


			$key = $table."_name";
		if ($table == "HostDependency")  { $key = "dependent_host_name,host_name"; }
		else if ($table == "HostExtInfo" ) { $key = "host_name"; }
		else if ($table == "HostExtTemplate" ) { $key = "name"; }
		else if ($table == "ContactTemplate" ) { $key = "name"; }
		else if ($table == "HostGroupEscalation" ) { $key = "hostgroup_name"; }
		else if ($table == "PortScan")  { $key = "host_name,port"; }
		else if ($table == "System")  { $key = "host_name"; }
		else if ($table == "HostTemplate" || $table == "ServiceTemplate")  { $key = "name"; }
		else if ($table == "HostEscalation")  { $key = "host_name,first_notification"; }
		else if ($table == "ServiceDependency")  { $key = "host_name,dependent_host_name,dependent_service_description"; }
		else if ($table == "ServiceEscalation")  { $key = "host_name,service_description,first_notification"; }
		else if ($table == "Service")  { $key = "host_name,service_description"; }
		else if ($table == "ServiceExtInfo") { $key = "host_name,service_description"; }
		else if ($table == "ServiceExtTemplate") { $key = "name,service_description"; }
		
		echo "<small>$table - </small>";

		$this->wcommon($table,$key);
		  
	   }
	/*
 Create Dynamic Services
*/
/*
#
&sync_logos();
if ($config{'nagiosportscan'}) { print "<BR>Creating dynamic Port Scan services..."; &dynamic_portscan_services(); }
if ($config{'nagiossnmpscan'}) { print "<BR>Creating dynamic  SNMP Interface services..."; &dynamic_snmpscan_services(); }
if ($config{'nagminpinginterfaces'}) { print "<BR>Creating PING services for interfaces..."; &dynamic_ping_interfaces(); }
if ($config{'nagiosservicegroups'}) { print "<BR>Creating dynamic Service Group services..."; &dynamic_servicegroup_services(); }
if ($config{'nagiosparentdependency'}) { print "<BR>Creating Parent Dependencies..."; &parent_dependency(); }
if ($config{'nagiosserviceescalations'}) { print "<BR>Creating Service Escalations..."; &service_escalations(); }
*/
/*
if (array_key_exists('nagiosportscan', $ini_array)) {
    if($ini_array['nagiosportscan']) $this->dynamic_portscan_services("Service");
}
*/

if (array_key_exists("nagiosservicegroups", $ini_array)) {
    if($ini_array['nagiosservicegroups']) $this->dynamic_servicegroup_services();
}

}
 // ....................................................

   public function verify_config()
	  {
		
        $this->write_config();

		$query = "select action from Actions where name='verify'";
		$ndb = "";
		$model = new Nagminvx4_Model();
		$data = $model->get_query($ndb,$query);	

		$mycmd=$data[0]['action'];
		echo "<p>$mycmd<p>";
		$datax = shell_exec ("$mycmd");
		if($datax){
			$datax=$this->highlightText($datax);
    		$datax =  nl2br($datax);

			$adatax = explode("\n", $datax);
			$output = array_slice($adatax, -10);
			foreach ($output as &$value) {
				echo "<b>$value</b>";
			}

		    echo "<small>$datax <small>";
		}else{
			echo "<b> Error while executing: $mycmd";
		}


	  }


	  public function activate()
	  {

        $this->write_config();

		$query = "select action from Actions where name='activate'";
		$ndb = "";
		$model = new Nagminvx4_Model();
		$data = $model->get_query($ndb,$query);	

		$mycmd=$data[0]['action'];
		echo "<p>$mycmd<p>";
		$datax = shell_exec ("$mycmd");
		if($datax){
			$datax=$this->highlightText($datax);
    		$datax =  nl2br($datax);
			
			$adatax = explode("\n", $datax);
			$output = array_slice($adatax, -10);
			foreach ($output as &$value) {
				echo "<b>$value</b>";
			}
		    echo "<small>$datax <small>";
		}else{
			echo "<b> Error while executing: $mycmd";
		}


	  }




	  public function highlightText($text) {

/*
		$term= "shinken";
		$text = preg_replace('#'. preg_quote($term) .'#i', '<span style="background-color:#FFFF66; ">\\0</span>', $text);
*/		
		$term= "okay";
		$text = preg_replace('#'. preg_quote($term) .'#i', '<span style="background-color:#00cc66;color:#FFFF66;">\\0</span>', $text);

		$term= "error";
		$text = preg_replace('#'. preg_quote($term) .'#i', '<span style="background-color:#FF0000;color:#FFFF66;">\\0</span>', $text);
		$term= "warning";
		$text = preg_replace('#'. preg_quote($term) .'#i', '<span style="background-color:#FFFF66; ">\\0</span>', $text);

		return $text;
	}


  	  public function activate_soft()
	  {
		
    
	    $this->write_config();

		$query = "select action from Actions where name='activate_soft'";
		$ndb = "";
		$model = new Nagminvx4_Model();
		$data = $model->get_query($ndb,$query);	

		$mycmd=$data[0]['action'];
		echo "<p>$mycmd<p>";
		$datax = shell_exec ("$mycmd");


		if($datax){
             $datax=$this->highlightText($datax);
  //		echo nl2br($datax);
    		$datax =  nl2br($datax);

			$adatax = explode("\n", $datax);
			$output = array_slice($adatax, -10);
			foreach ($output as &$value) {
				echo "<b>$value</b>";
			}
		    echo "<small>$datax <small>";
		}else{
			echo "<b> Error while executing: $mycmd";
		}


	  }






	  public function saction()
	  {
		$sa  = $this->request->uri->getSegment(3);
		log_message('debug',"sa==== $sa");
	
		$query = "select action from Actions where name='$sa'";
		$ndb = "";
		$model = new Nagminvx4_Model();
		$data = $model->get_query($ndb,$query);	

		$mycmd=$data[0]['action'];
		echo "<p>$mycmd<p>";
		//return;
		$datax = shell_exec ("$mycmd");
		if($datax){
  //		echo nl2br($datax);
    		$datax =  nl2br($datax);
		    echo "<nobr><small>$datax <small>";
		}else{
			echo "<b> Error while executing: $mycmd";
		}


	  }

	  public function logos1()
	  {
		$i=0;
		echo "<table border='1' cellspacing='0' cellpadding='4'><tr>"; 
		$dir = getenv('icondir');
				
		// log_message('debug',"dir==== $dir");
		foreach(glob("$dir/*.*") as $file) {
		 $im = file_get_contents($file);
		 $file1=str_replace("$dir/",'',$file);
		 echo "<td><img width= 50 height= 50  src='data:image/jpg;base64,".base64_encode($im)."' alt=$file1>
		 <br>$file1 <button class=\"btn btn-light btn-sm\" onclick=\"logo_delete('$file1')\"><i class=\"glyphicon glyphicon-remove\"></i></button></td>";
		 if($i==10){
			echo "</tr><tr>"; 
			$i=-1;
		 }
		 $i++;
		}
			echo "</tr></table>"; 
			echo "<form
			
			<form action='nagminvx4/logo_upload' name=\"formU\" id=\"formU\" method=\"post\" accept-charset=\"utf-8\" enctype=\"multipart/form-data\">
			<input type=\"file\" onchange=\"readURL(this);\" accept=\".png, .jpg, .jpeg, .gif\"  name=\"images[]\" multiple />";
			echo "<button  type=\"submit\" class=\"btn btn-success\" ><i class=\"glyphicon glyphicon-upload\"></i> Upload</button></form>";
/*
			echo "<form action='nagminvx4/logo_import' name=\"formI\" id=\"formI\" method=\"post\" accept-charset=\"utf-8\" enctype=\"multipart/form-data\">";
			echo "<button  type=\"submit\" class=\"btn btn-success\" ><i class=\"glyphicon glyphicon-upload\"></i> Import Names</button></form>";
  */
		
	  }

	  public function logo_upload()
	  {
		$dir = getenv('icondir');

		echo "<p>$dir<p>";
		if($imagefile = $this->request->getFiles())
		{
		   foreach($imagefile['images'] as $img)
		   {
			  if ($img->isValid() && ! $img->hasMoved())
			  {
			       $myName = $img->getName();
				   $img->move($dir, $myName);
				   echo "<p>$myName";
			  }
		   }
		}
		

		//$this->logos1();
		$bu=base_url();
		echo "<p><a class=\"btn btn-secondary\" href=\"$bu\" id=\"btnStart\" title=\"start\" onclick=\"onclick=location.href='$bu'\"><i class=\"glyphicon glyphicon-step-backward\"></i> Back</a><p>";
		$this->logo_import();
    //   return redirect()->to('/logos1');

	  }


	
	
	  public function logo_import()
	  {
		$dir = getenv('icondir');
		$model = new Nagminvx4_Model();
		//$ndb = getenv('MyDB');
		$ndb ="";
		$query="truncate table  `LOGOS` ";
		$data = $model->get_query($ndb,$query);
	
		foreach(glob("$dir/*.*") as $file) {
			$file1=str_replace("$dir/",'',$file);
			$query="INSERT INTO `LOGOS` (`name`) VALUES('$file1')";
			echo "$ndb $query<p>";

			$data = $model->get_query($ndb,$query);
	   }
	   $bu=base_url();
	   return redirect()->to($bu);


	  }

	  public function logo_delete()
	  {
		$dir = getenv('icondir');
		$file1  = $this->request->uri->getSegment(3);
		$mycmd="rm $dir/$file1";
		echo "<p>$mycmd<p>";
		$data = shell_exec ("$mycmd");
		echo nl2br($data);
		$bu=base_url();
		echo "<p><a class=\"btn btn-secondary\" href=\"$bu\" id=\"btnStart\" title=\"start\" onclick=\"onclick=location.href='$bu'\"><i class=\"glyphicon glyphicon-step-backward\"></i> Back</a><p>";
	


	  }

	  
	

	  public function Reports($nquery)

	  {

		$model = new Nagminvx4_Model();
		$ndb =  getenv('');	
		$data = $model->get_query($ndb,$nquery);
     	$x=$data[0]['name'];
		 echo "<script type=\"text/javascript\"> $('#spinner').hide();</script>";		
		

		echo "<script type=\"text/javascript\"> $('#spinner').hide();</script>";		
    	 echo"
		 <SCRIPT Language=\"Javascript\">
				 $('#list').tablesort();
		 </SCRIPT>";
		 
		 echo "<style>
		 table, th, td {
		   border: 1px solid #e0e0e0;
		   border-collapse: collapse;
		 }
		 table tr.even {
			background-color: #f2f2f2;
			}
		table tr.odd {
				background-color: #fffF;
			}	
		 </style>";

     
//    $createtime=date(DATE_RFC822);
    $createtime= date("D M j G:i:s T Y");  

	echo "<small>Report $x : $createtime<br></small>";	
		
	 $model = new Nagminvx4_Model();
     $ndb =  getenv('');

	 $myfields = $model->getmytableheadpure($ndb,$x);
	 echo "<DIV align=\"center\">
	 <table  \"border=1px solid black\" width=90% class=\"data\" id='list' class='data'><thead><TR><thead bgcolor=#CCCCCC>";
	 $i=0;
	 $farray = array();

	 foreach ($myfields as $key1 => $val1) {
		 echo "<th>$val1</th>";
		 $farray[] =$val1;
		 $i++;
	 }

	echo "</thead>";

	 $query = "select * from $x";
	 $data = $model->get_query($ndb,$query);
	

	 $oddeven="odd";
	 $odd_row="odd";         

	 for ($k=0;$k<count($data);$k++) {
      $oddeven=$odd_row ? "odd" : "even";
	  $odd_row = ! $odd_row;
 	  echo "<tr class=$oddeven>";
		 for($j=0;$j<$i;$j++){
		  $myyx=$data[$k][$farray[$j]];
          echo "<td>$myyx</td>";
		 }
	  echo "</tr>";
	 }


	 echo "</table</DIV>";
	 echo "<p><hr><p>";


	 
}


	  
  public function myaccount()	   {
		   
		   
	$session = session();		
	$user=$_SESSION['uname'];
	if(!$session->has('uname')){
		log_message('debug',"auf uname kann nicht zugegriffen werden!");
		$_SESSION['uname']="unbekannt";
		//return;
	}


	$ll=logged_in();

if(!$ll){  // hier sollte der Benutzer ein AD user sein
	echo "Login = $user<p>";

    $isadmin=$this->is_admin();

    if($isadmin==1) $iadmin="yes"; else $iadmin="no";
    echo "is admin = $iadmin<p>";

   $ul= strtolower($user);
   $sr=ldap_search($ds, "$context","cn=$ul" );
   $info1 = ldap_get_entries($ds, $sr);
   for ($i=0; $i<$info1["count"]; $i++) {	

     $xobjectsid    = bin2hex($info1[$i]["objectsid"][0]);
     $xobjectclass    = $info1[$i]["objectclass"][3];
     $xdisplayname    = $info1[$i]["displayname"][0];
     $xdisplayname1    = $info1[$i]["department"][0];
     $xgivenname      = $info1[$i]["givenname"][0];
     $xsn             = $info1[$i]["sn"][0];
     $xmail           = $info1[$i]["mail"][0];
     $xtelephonenumber= $info1[$i]["telephonenumber"][0];
     $xoffice	     = $info1[$i]["physicaldeliveryofficename"][0];
     $xdescription    = $info1[$i]["description"][0];
     $xpostalcode     = $info1[$i]["postalcode"][0];
     $xfax            = $info1[$i]["facsimiletelephonenumber"][0];
     $xcompany        = $info1[$i]["company"][0];
     $xlocation       = $info1[$i]["l"][0];
     $xloginname      = $info1[$i]["dn"];
	 echo "<table>
	 <tr><td>Displayname:</td><td>$xdisplayname</td></tr>
	 <tr><td>Displayname1:</td><td>$xdisplayname1</td></tr>
	 <tr><td>email:</td><td>$xmail</td></tr>
	 <tr><td>phone:</td><td>$xtelephonenumber</td></tr>
	 <tr><td>description:</td><td>$xdescription</td></tr>
	 <tr><td>office:</td><td>$xoffice</td></tr>
	 </table>
	 ";
	 if($isadmin==1) $iadmin="yes"; else $iadmin="no"; 
	 echo "is admin:  $iadmin <br>";
 }
} 
else{    
		   
		   
	//	$ll=logged_in();
		$uu=user_id();
		$u1=user();
		$gg=in_groups(1); // Gruppennummer oder Gruppenname als Parameter als check
		$pp=has_permission(0);// ... als Parameter als check
		echo "logged_in  $ll<br>";
		echo "user_id:  $uu<br>";
//		->withGroup('guests') [created_at] => 2021-03-06 05:05:36 [updated_at] => 2021-03-06 05:05:36 
		echo "user name :  $u1->username <br>";
		$isadmin=$this->is_admin();
		if($isadmin==1) $iadmin="yes"; else $iadmin="no"; 
		echo "is admin:  $iadmin <br>";
		echo "user email:  $u1->email <br>";
		echo "created_at :  $u1->created_at <br>";
		echo "updated_at:  $u1->updated_at <br>";
//		echo "Token:  $u1->token <br>";
		//print_r($u1);
		echo "<br>";
//		echo "in_groups:  $gg<br>";
//		echo "has_permission:  $pp<br>";
		$href = 'reset-password';

echo "<a class=\"btn btn-secondary\"  id=\"btnStart\" title=\"reset password\" onclick=\"myaction('resetpassword')\"><i class=\"glyphicon glyphicon-remove\"></i>reset password</a>";
	
 }		
}
  
public function resetpassword()
	{ 

		$model = new Nagminvx4_Model();
		$ndb = "";
		$u1=user();
		 echo "user email:  $u1->email <br>";
		 $r_hash=password_hash($u1->email, PASSWORD_DEFAULT);
		 $query = "update users set force_pass_reset=1, reset_hash='$r_hash' where email='$u1->email'";
//		 log_message('debug',$query);
		 $data = $model->get_query($ndb,$query);

		return redirect('logout');

}
 
 public function get_username()
	 { 
		  $u1=user();
		  return $u1->username;
	  }
  

	  public function ajax_add()
	  {

		if ($this->request->isAJAX()) {
			$ndata = service('request')->getPost('ndata');
			$tname = service('request')->getPost('tname');
		}
		
		log_message('debug',$tname);
		$ttname = explode(":", $tname);
		$tname = $ttname[0].'"';
		
		log_message('debug',$tname);
		log_message('debug',"o######!!!!!!!!!!!!!!!!!!!!!!!####################");
	
		// $query="desc $tname ";
		$mydefault="NagminVX";
		if($ttname[1][0]==1) $ndb = getenv('MyDB');
		else $ndb="";

		$tname=json_decode($tname);

		$data = array();
	
	//	log_message('debug',"o######!: $ndata");
	
		$data = json_decode($ndata, true);
		$model = new Nagminvx4_Model();

		$result = $model->myadd($ndb,$tname,$data);
	
         echo $result;
	  }
  






	  public function ajax_update()
	  {
		if ($this->request->isAJAX()) {
			$ndata = service('request')->getPost('ndata');
			$tname = service('request')->getPost('tname');
			$oldvalues = service('request')->getPost('oldvalues');
		}


		$ttname = explode(":", $tname);
		$tname = $ttname[0].'"';
		
	//	log_message('debug',$ttname[1][0]);
	//	log_message('debug',"o##########################2");
	
		// $query="desc $tname ";
		$mydefault="NagminVX";
		if($ttname[1][0]==1) $ndb = getenv('MyDB');
		else $ndb="";



		$tname=json_decode($tname);
		// null ---------------------------------------------------
		$ndata = str_replace(":\"null\"", ":null", $ndata);
		$oldvalues = str_replace(":\"null\"", ":null", $oldvalues);
/*
		log_message('debug',$ndata);
		log_message('debug',$oldvalues);
*/		
		$data = array();
		$where = array();

		$data = json_decode($ndata, true);
		$where = json_decode($oldvalues, true);

		
	

		$model = new Nagminvx4_Model();
		$result = $model->myupdate($ndb,$tname,$data,$where);

		
        echo $result;
		}
  

		public function x_delete($val,$table)
		{
/*			log_message('debug',"val-------------------");
			log_message('debug',$val);
			log_message('debug',"ndata-------------------");
			log_message('debug',$table);
*/

/*
Die funktion nur verwenden, wenn Trigger nicht möglich
Host:
DELIMITER ;;

CREATE TRIGGER `update_Service` AFTER DELETE ON `Host` FOR EACH ROW
update Service set host_name=TRIM(BOTH ',' FROM (SELECT REPLACE(REPLACE(host_name,OLD.host_name,''),',,',',')))  where FIND_IN_SET(OLD.host_name, host_name) and (LENGTH(host_name) - LENGTH(REPLACE(host_name, ',', '')))>0;;
DELIMITER ;


DELIMITER ;;

CREATE TRIGGER `delete_Service` AFTER DELETE ON `Host` FOR EACH ROW FOLLOWS update_Service
Delete from Service where FIND_IN_SET(OLD.host_name, host_name) and (LENGTH(host_name) - LENGTH(REPLACE(host_name, ',', '')))=0;;

DELIMITER ;


*/

			$model = new Nagminvx4_Model();
			$ndb = getenv('MyDB');

			$table=trim($table.'\'');
			$table=rtrim($table,'\'');
			log_message('debug',"table====$table");

			switch ($table) {
		//		case 'Contact':
		//			$query = "update ContactGroup set members=TRIM(BOTH ',' FROM (SELECT REPLACE(REPLACE(members,$val,''),',,',',')))  where FIND_IN_SET($val, members) "; // leere ContactGroup is mir egal	
		//			$data = $model->get_query($ndb,$query);
		//			break;
				case 'Host':
		//			$query = "Delete from Service where host_name=$val";	
		//			$data = $model->get_query($ndb,$query);
					
		//			$query = "update Service set host_name=TRIM(BOTH ',' FROM (SELECT REPLACE(REPLACE(host_name,$val,''),',,',',')))  where FIND_IN_SET($val, host_name) and (LENGTH(host_name) - LENGTH(REPLACE(host_name, ',', '')))>0";	
		//			$data = $model->get_query($ndb,$query);
										
		//			$query = "update HostGroup set members=TRIM(BOTH ',' FROM (SELECT REPLACE(REPLACE(members,$val,''),',,',',')))  where FIND_IN_SET($val, members) "; // leere HostGroup is mir egal	
		//			$data = $model->get_query($ndb,$query);
		// trigger on same tabel is not possible !!!!!!!!!!!!!!!!1
					$query = "update Host set parents= TRIM(BOTH ',' FROM REPLACE( CONCAT(',',parents,','), CONCAT(',',$val,','), ',') )  where FIND_IN_SET($val, parents) "; // 	
					$data = $model->get_query($ndb,$query);

					break;
				case 'xxxxx2':
					echo "i ist gleich 2";
					break;
			}

		}



	  public function ajax_delete()
	  {
		if ($this->request->isAJAX()) {
			$ndata = service('request')->getPost('ndata');
			$tname = service('request')->getPost('tname');
	
		}


//		log_message('debug',"ndata-------------------");
//		log_message('debug',$ndata);

		$ttname = explode(":", $tname);
		$mydefault="NagminVX";
		if($ttname[1][0]==1) $ndb = getenv('MyDB');
		else $ndb="";

//		log_message('debug',"tname-------------------");
//		log_message('debug',$ttname[0]);

	

	// nur wenn trigger nicht möglich
/*		$mycascade = array("Host", "Service");
		if (in_array($ttname[0], $mycascade))
        {
  			//echo "Match found";
			  //$ndata  select+*+from+Command+where+command_name='z3'
			  $myval=explode("=", $ndata);
			  log_message('debug',"myval-------------------");
			  log_message('debug',$myval[1]);
			  $this->x_delete($myval[1],$ttname[0]);
        }
*/
//		log_message('debug',"ndata-------------------");
//		log_message('debug',$ndata);
		$myval=explode("=", $ndata);
			  log_message('debug',"myval-------------------");
			  log_message('debug',$myval[1]);
        $this->x_delete($myval[1],$ttname[0]); //  trigger delete on same table ist not possible !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


		$ndata = str_replace("select+*+", "delete ", $ndata);
		$ndata = str_replace("+", " ", $ndata);
	
//		log_message('debug',$ndata);
		$model = new Nagminvx4_Model();
 
        $result = $model->mydelete($ndb,$ndata);
		
		echo $result;
		
	  }
  

  public function check_show_()
  {
		 
		 $model = new Nagminvx4_Model();
         $ndb = getenv('MyDB');
		 if ($this->request->isAJAX()) {
			$nfield = service('request')->getPost('myobject');
		}

		 log_message('debug',$nfield);


		  $query = "select nsource from NagminVX.Help1 where column_name='$nfield'";
		  log_message('debug',$query);
		  $data = $model->get_query($ndb,$query);
		  if($data) {
			log_message('debug','test1');
			echo "1";
			return;
		  }
		  log_message('debug','test11111111');
		  echo "0";
		  return;

  }
  

  public function show_()
  {
		 
		 $model = new Nagminvx4_Model();
         $ndb = getenv('MyDB');
		 //else $ndb="";
		 $nfield = $this->request->uri->getSegment(3);
	
		 log_message('debug',$nfield);
		 //	return;	 
 
		// echo "<script type=\"text/javascript\"> $('#spinner').hide();</script>";	
		$bu=base_url();
		echo "<script src=\"$bu/assets/jquery/jquery-2.1.4.min.js\"></script>";	
		echo "<script src=\"$bu/assets/jquery/jquery.tablesorter.js\"></script>";
		// echo "<script src='assets/jquery/jquery.tablesorter.js'></script>";
		  echo"
		  <SCRIPT Language=\"Javascript\">
		  $(document).ready(function() {
				  $('#list').tablesort();
		  })
				
		  </SCRIPT>";
		  
		  echo "<style>
		  table, th, td {
			border: 1px solid #e0e0e0;
			border-collapse: collapse;
		  }
		  table tr.even {
			 background-color: #f2f2f2;
			 }
		 table tr.odd {
				 background-color: #fffF;
			 }	
		  </style>";
		  
	  
 


		  $query = "select nsource from NagminVX.Help1 where column_name='$nfield'";
		  log_message('debug',$query);
		  $data = $model->get_query($ndb,$query);
		  $e= json_encode($data);
		  log_message('debug',$e);
		  log_message('debug',$data[0]['nsource']);
		 $x=$data[0]['nsource'];



	  $myfields = $model->getmytableheadpure($ndb,$x);
	  echo "<DIV align=\"center\">
	  <table  \"border=1px solid black\" width=90% class=\"data\" id='list' class='data'><thead><TR><thead bgcolor=#CCCCCC>";
	  $i=0;
	  $farray = array();
 
	  foreach ($myfields as $key1 => $val1) {
		  echo "<th>$val1</th>";
		  $farray[] =$val1;
		  $i++;
	  }
 
	 echo "</thead>";
 
	  $query = "select * from $x";
	  $data = $model->get_query($ndb,$query);
	 
 
	  $oddeven="odd";
	  $odd_row="odd";         
 
	  for ($k=0;$k<count($data);$k++) {
	   $oddeven=$odd_row ? "odd" : "even";
	   $odd_row = ! $odd_row;
		echo "<tr class=$oddeven>";
		  for($j=0;$j<$i;$j++){
		   $myyx=$data[$k][$farray[$j]];
			if($j==0){
		   	 echo "<td id=$myyx>$myyx</td>";
//			   	   echo "<td id=$myyx onclick=\"var aa=this.id; alert(aa); document.getElementById(\"check_command\").value=aa\">$myyx</td>";
//			   	   echo "<td id=$myyx onclick=\"var aa=this.id; alert(aa);document.getElementById('check_command').value=aa\">$myyx</td>";
//			   	   echo "<td id=$myyx onclick=\"$('#modal_form').modal({show:false});\">$myyx</td>";
			} else echo "<td>$myyx</td>";
		  }
	   echo "</tr>";
	  }
 
	  echo "</table</DIV>";

  }
  


}

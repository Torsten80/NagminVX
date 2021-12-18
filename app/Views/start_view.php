<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <!-- https://getbootstrap.com/docs/4.0/getting-started/introduction/ -->
    <link href="<?php echo base_url('assets/bootstrap4-glyphicons/css/bootstrap-glyphicons.css')?>" rel="stylesheet"> 
    <link href="<?php echo base_url('assets/bootstrap/css/bootstrap.min.css')?>" rel="stylesheet"> 
    

    <link href="<?php echo base_url('assets/datatables/css/dataTables.bootstrap.css')?>" rel="stylesheet">
    <link href="<?php echo base_url('assets/datatables/css/jquery.dataTables.min.css')?>" rel="stylesheet">
    <link href="<?php echo base_url('assets/bootstrap-select/css/bootstrap-select.css')?>" rel="stylesheet">
    <link href="<?php echo base_url('assets/tortisoft/NagminVX4.css')?>" rel="stylesheet">
    <link rel="icon" href="<?=base_url()?>/favicon.ico" type="image/x-icon">

  </head>
  <body>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="<?php echo base_url('assets/jquery/jquery-2.1.4.min.js')?>"></script>
    <script src="<?php echo base_url('assets/bootstrap/js/popper.min.js')?>"></script>
    <script src="<?php echo base_url('assets/bootstrap/js/bootstrap.min.js')?>"></script>
    
    <script src="<?php echo base_url('assets/datatables/js/jquery.dataTables.min.js')?>"></script> 
    <script src="<?php echo base_url('assets/bootstrap-select/js/bootstrap-select.min.js')?>"></script>
    <script src="<?php echo base_url('assets/jquery/jquery.tablesorter.js')?>"></script>
    <script src="<?php echo base_url('assets/tortisoft/ad_sso_module.js')?>"></script>
    <script src="<?php echo base_url('assets/tortisoft/ad_settings.js')?>"></script>
 
    
    
    
   



<?php 
 // https://getbootstrap.com/docs/3.3/components/

 $logininfo[0]="unknown";
 $logininfo[1]="";
 $logininfo[2]="xyz";

 
$myhref=$_SERVER['REQUEST_URI'];
?>

 
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">NagminVX</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" href="#myModal" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span> 
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href=<?php echo "$myhref"?>
       ><B>Home </B><span class="sr-only">(current)</span></a>
      </li>


    <li class="nav-item dropdown">
     <a class="nav-link dropdown-toggle" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Configuration Tables   </a>
       <div class="dropdown-menu" id="nconft" aria-labelledby="navbarDropdown">
      </div>
    </li>  

    <li class="nav-item dropdown">
     <a class="nav-link dropdown-toggle" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Configs   </a>
       <div class="dropdown-menu" id="nconfigs" aria-labelledby="navbarDropdown">
      </div>
    </li>  

    <li class="nav-item dropdown">
     <a class="nav-link dropdown-toggle" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Control Files   </a>
       <div class="dropdown-menu" id="ncontrolf" aria-labelledby="navbarDropdown">
      </div>
      </li>  

      <li class="nav-item dropdown">
     <a class="nav-link dropdown-toggle" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Tools   </a>
       <div class="dropdown-menu" id="ntools" aria-labelledby="navbarDropdown">
      </div>
    </li>  
    <li class="nav-item dropdown">
     <a class="nav-link dropdown-toggle" href="#"  role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
     Documentation   </a>
       <div class="dropdown-menu" id="ndocus" aria-labelledby="navbarDropdown">
      </div>
    </li>  
    <button class="btn btn-success" onclick="$('#spinner').show();myaction('verify_config')"><i class="glyphicon glyphicon-ok"></i> Verify</button>
    <button class="btn btn-primary" onclick="$('#spinner').show();myaction('activate_soft')"><i class="glyphicon glyphicon-play-circle"></i> Soft Activate</button>
    <button class="btn btn-secondary" onclick="$('#spinner').show();myaction('activate')"><i class="glyphicon glyphicon-play"></i> Activate</button>
    <button class="btn btn-secondary" onclick="$('#spinner').show();myaction('status')"><i class="glyphicon glyphicon-info-sign"></i> Status</button>
    <button class="btn btn-secondary" onclick="$('#spinner').show();myaction('restart')"><i class="glyphicon glyphicon-arrow-right"></i> Restart</button>
    <button class="btn btn-secondary" onclick="$('#spinner').show();myaction('reload')"><i class="glyphicon glyphicon-refresh"></i> Reload</button>
    <button class="btn btn-danger" onclick="$('#spinner').show();myaction('stop')"><i class="glyphicon glyphicon-stop"></i> Stop</button>
		
  </div>
   <ul class="navbar-nav ml-auto nav-flex-icons">
      <li class="nav-item avatar">
          <div class="text-center"><div class="spinner-border" id="spinner" role="status"><span class="sr-only">Loading...</span></div>    
      </li>
    </ul>
  <div class="mx-auto order-0">

  <ul class="navbar-nav mr-auto">
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" id="nprofile" data-toggle="dropdown"
          aria-haspopup="true" aria-expanded="false">
          <i class="glyphicon glyphicon-user" id="user"></i>  </a>
        <div class="dropdown-menu dropdown-menu-right dropdown-info" aria-labelledby="navbarDropdownMenuLink-4">
          <a class="dropdown-item" onclick="myaccount()">My account</a>
          <a class="dropdown-item" href="logout">Log out</a>
         </div>
     </li> 
  </ul>
  </div>
   <ul class="navbar-nav ml-auto nav-flex-icons">
      <li class="nav-item avatar">
        <a class="nav-link p-0" href="#">
        <img alt="TF"  id="Image1_img" width= 50 height= 50 src="<?php echo base_url(); ?>/assets/img//tf.gif" >
        </a>
      </li>
    </ul>
    
       
 
</div>

 </nav>

 <div id="mcontent">

 <h5>Configuration Tables </h5>
 <div style="float:left; width: 33%">
 <table id="mytables1" name="mytables1" class="table table-striped table-bordered" cellspacing="0" width="33%"> </table>
 </div>
  <div style="float:left; width: 33%">
 <table id="mytables2" name="mytables2" class="table table-striped table-bordered" cellspacing="0" width="33%"> </table>
 </div>
 <div style="float:left; width: 33%">
 <table id="mytables3" name="mytables3" class="table table-striped table-bordered" cellspacing="0" width="33%"> </table>
 </div>     
  </div>
  
<script type="text/javascript">

var save_method; //for save method string
var table;

$(document).ready(function() {

 $('#spinner').hide();
var username="";
//// ******* AD SSO Module ja oder nein !!!!!!!!!!!!!!!!!!!!!!!!!1
if(usead===1){
 username=ad_sso(adgroup);
 uid=username;

 document.getElementById("user").innerHTML = username;
  
 $.ajax({
            url : "<?php echo site_url('nagminvx4/setsessionuser')?>",
            type: "POST",
			 data: {user:username},
	
           success: function(response)
        {
        	console.log("++++++++++++++");
          
       },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('setsessionuser');
        }
    });
  
  } else{
   $.ajax({
            url : "<?php echo site_url('nagminvx4/get_username')?>",
            type: "POST",
           success: function(response)
        {
    //    	console.log("++++++++++++++");
    //      console.log(response);
    //      console.log("--------------");
          document.getElementById("user").innerHTML = response;
          username=response;
         
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('get_username');
        }
    });
    var uid="<?php echo user_id();?>"
    <?php 
     $session = session();
     $uid=user_id();
 
     $session->set('uname', $uid);
   ?>

}



//console.log(username);




if(!uid){
 var href = 'login'
  window.location.replace(href);
  return
}  


//  Tools  laden

		$.ajax({
            url : "<?php echo site_url('nagminvx4/get_query')?>",
            type: "POST",
           dataType: "JSON",
           data: {ndb:'',query:'select * from Tools'},
           success: function(response)
        {
         for(i=0;i<response.length;++i) {
       //   console.log("response i");
       //   console.log(response[i]);
          $('#ntools').append("<a class='dropdown-item'     onclick=$('#spinner').show();myaction("+"'"+response[i].name+"'"+       ")>"+response[i].name+"</a>");
         }
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax 1');
        }
    });
		
		
     
// Configfiles auflisten

		$.ajax({
      url : "<?php echo site_url('nagminvx4/get_control')?>",
            type: "POST",
           dataType: "JSON",
           success: function(response)
        {
      //  	console.log(response);
        for(i=0;i<response.length;++i) {
         if(response[i] != '.' && response[i] != '..' ) $('#ncontrolf').append("<a class='dropdown-item'     onclick=x_file("+"'"+response[i]+":1'"+       ")>"+response[i]+"</a>");

        }
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax 3');
        }
    });

//  Konfigurations-Tabellen laden
$.ajax({
  url : "<?php echo site_url('nagminvx4/get_mytables1')?>",
            type: "POST",
           dataType: "JSON",
           data: {ndb:''},
           success: function(response)
        {
         if(response){ // wird nur angezeigt, wenn man Administrator ist
          for(i=0;i<response.length;++i) {
           $('#nconfigs').append("<a href='#' class='list-group-item list-group-item-action list-group-item-light' onclick=x_table("+"'"+response[i]+":0'"+")>"+response[i]+"</a>");
          }
         }
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax');
        }
    });


 
 //  Documentation  laden

 // Zuerst NagminVX Website
    $('#ndocus').append("<div class='dropdown-divider'></div>");
    $('#ndocus').append("<a class='dropdown-item' href='http://nagminv.blogspot.com/p/blog-page_9.html' target='_blank'>NagmninVX Website</a>");
    $('#ndocus').append("<div class='dropdown-divider'></div>");


$.ajax({
            url : "<?php echo site_url('nagminvx4/get_query')?>",
            type: "POST",
           dataType: "JSON",
           data: {ndb:'',query:'select * from Documentation'},
           success: function(response)
        {
         for(i=0;i<response.length;++i) {
          $('#ndocus').append("<a class='dropdown-item' href="+"'"+response[i].action+"'"+"target='_blank'>"+response[i].name+"</a>");
         }
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax 1');
        }
    });
		

//  Tabellen laden

 $.ajax({
            url : "<?php echo site_url('nagminvx4/get_mytables1')?>",
            type: "POST",
           dataType: "JSON",
           data: {ndb:'nagios'},
           success: function(response)
        {
          var j=1
          for(i=0;i<response.length;++i) {
           if(j == 1) { $('#mytables1').append("<a href='#' class='list-group-item list-group-item-action list-group-item-light' onclick=x_table("+"'"+response[i]+":1'"+")>"+response[i]+"</a>"); }
           if(j == 2) { $('#mytables2').append("<a href='#' class='list-group-item list-group-item-action list-group-item-light' onclick=x_table("+"'"+response[i]+":1'"+")>"+response[i]+"</a>"); }
           if(j == 3) { $('#mytables3').append("<a href='#' class='list-group-item list-group-item-action list-group-item-light' onclick=x_table("+"'"+response[i]+":1'"+")>"+response[i]+"</a>"); }
           j++
           if(j == 4) {j=1}

          $('#nconft').append("<a class='dropdown-item'     onclick=x_table("+"'"+response[i]+":1'"+       ")>"+response[i]+"</a>");
        }
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax 2');
        }
    });




})
 // document ready - END ----------------------------------------------------------------

 
function x_table(myname)
{
 var href = 'index.php/nagminvx4/nvtables/'+myname
 $('#mcontent').load(href);

 }

 function x_file(myname)
{
 var href = 'index.php/nagminvx4/nvfile/'+myname
 $('#mcontent').load(href);

 }

function reload_table()
{
	var logininfo=$('[name="auser"]').val();
      if(!logininfo) logininfo=0;
	var myurl="<?php echo site_url('logs/ajax_list')?>/"+logininfo;
	table.ajax.url(myurl).load();
}


function logo_delete(mya){
  myname = 'logo_delete';
  var mybase="<?php echo site_url('nagminvx4/')?>"

  $.ajax({
  url : mybase+myname+'/'+mya, mya,
            type: "POST",
           success: function(response)
        {
          $('#mcontent').html(response);     
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax');
        }
    });

}

function myaction(mya){


  switch(mya) {
    case "stop":
    var myname = 'saction';
    break;
    case "status":
    var myname = 'saction';
    break;
    case "reload":
    var myname = 'saction';
    break;
    case "restart":
    var myname = 'saction';
    break;
    case "Audit_today":
    var myname = 'saction';
    break;
    case "Audit_last_7days":
    var myname = 'saction';
    break;
    case "Backup":
    var myname = 'saction';
    break;
    case "Logo_Manager":
    var myname = 'logos1';
    break;
    case "SNMP_Walker":
      mya=mya+':0'
      x_table(mya);
      $('#spinner').hide();
      return
    break;
    case "Interface_Scanner":
      mya=mya+':0'
      x_table(mya);
      $('#spinner').hide();
      return
    break;
    case "Reports":
      mya=mya+':0'
      x_table(mya);
      $('#spinner').hide();
      return     
    break;
    case "resetpassword":
      var href = 'index.php/nagminvx4/'+mya, mya
      $('#mcontent').load(href);      
      $('#spinner').hide();
      return    
    break;
   default:
    var myname = mya;
}

var mybase="<?php echo site_url('nagminvx4/')?>"

$.ajax({
  url : mybase+myname+'/'+mya, mya,
            type: "POST",
           success: function(response)
        {
          $('#spinner').hide();
          $('#mcontent').html(response);     
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error get data from ajax');
        }
    });
}


 function verify_s(){
   var myname = 'ssystem'
   var href = 'index.php/nagminvx4/'+myname, myname
   $('#mcontent').load(href);

 }

 function verify_s1(){
   var myname = 'write_config'
   var href = 'index.php/nagminvx4/'+myname, myname
   $('#mcontent').load(href);

 }


 function myaccount(){
   var myname = 'myaccount'
   var href = 'index.php/nagminvx4/'+myname, myname
   $('#mcontent').load(href);

 }

</script>


</body>
</html>
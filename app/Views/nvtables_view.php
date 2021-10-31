<!doctype html>
<html lang="en">


<title><?php echo $nvtable;?></title>
<input type="hidden" value=<?php echo $nvtable;?> name="nvtable" id="nvtable"/> 
<div class="wrapper" style="width: 95%; margin: 0 auto;">
   
   <table id="xxtable" class="table table-striped table-bordered" cellspacing="0" width="100%" > </table>
    <tr><td><button class="btn btn-success" onclick="reload_table()"><i class="glyphicon glyphicon-refresh"></i> Reload</button></td><td></td><td>   Table: <?php  echo $nvtable;?></td></tr>
   </table> 
  
        <input type=text  style="border:none" id=next1 hidden=true size=40 readonly value='Searching ......' >
        <br>
        
        <table id="table" name="table" class="table table-striped table-bordered" cellspacing="0" width="100%"> </table>
        

        Select All <input type="checkbox" class='selectall' id='selectall' name='selectall'>     
       <a class="btn btn-sm btn-primary" href="javascript:void(0)" id="btnEdit" title="edit" onclick="$(selectall).prop('checked', false);edit_(0)"><i class="glyphicon glyphicon-pencil"></i> Edit</a>
       <a class="btn btn-sm btn btn-success" href="javascript:void(0)" id="btnStart1" title="start" onclick="$(selectall).prop('checked', false);$('#spinner').show();snmp_start()"><i class="glyphicon glyphicon-play"></i> Start</a>
       <a class="btn btn-sm btn btn-success" href="javascript:void(0)" id="btnStart2" title="start" onclick="$(selectall).prop('checked', false);$('#spinner').show();report_start()"><i class="glyphicon glyphicon-play"></i> Start</a>
       <a class="btn btn-sm btn btn-success" href="javascript:void(0)" id="btnInterfaces" title="interfaces" onclick="$(selectall).prop('checked', false);$('#spinner').show();interface_start()"><i class="glyphicon glyphicon-play"></i>Interfaces Scan</a>
       <a class="btn btn-sm btn-primary" href="javascript:void(0)" id="btnCopy" title="copy" onclick="$(selectall).prop('checked', false);edit_(1)"><i class="glyphicon glyphicon-pencil"></i> Duplicate</a>
       <a class="btn btn-sm btn-primary" href="javascript:void(0)" id="btnNew" title="new" onclick="$(selectall).prop('checked', false);add_()"><i class="glyphicon glyphicon-pencil"></i> Add</a>
  	   <a class="btn btn-sm btn-danger" href="javascript:void(0)" id="btnDelete" title="delete" onclick="$(selectall).prop('checked', false);delete_()"><i class="glyphicon glyphicon-trash"></i> Delete</a>	
 
        
   </div>
  



<script type="text/javascript">

var save_method; //for save method string
var table;



$(document).ready(function() { 

const $table = $('#table');
const $remove = $('#remove');
let selections = [];
$('#btnSaveX').hide();
mydefaults = new Array();

var tname = <?php echo json_encode($nvtable); ?>;
//console.log(tname);

if(tname=="SNMP_Walker:0") $('#btnStart1').show();
   else $('#btnStart1').hide();
if(tname=="Reports:0") $('#btnStart2').show();
   else $('#btnStart2').hide();
if(tname=="Interface_Scanner:0"){ 
   $('#btnInterfaces').show();
   tname="SNMP_Walker:0";
  }
   else $('#btnInterfaces').hide();
 if(tname=="Reports:0") {

  $.ajax( {
  url : "<?php echo site_url('nagminvx4/is_admin')?>",
    type: "POST",
    success: function(response)
       	{
      //    Wenn nicht Administrator , buttons ausblenden
          if(response !=1){
           $('#btnEdit').hide();
           $('#btnCopy').hide();
           $('#btnDelete').hide();
           $('#btnNew').hide();
          }
         },		
         error: function (jqXHR, textStatus, errorThrown)
         {
        	alert('Error  data'  + ' ' + textStatus );
         }
});

// es sollte eigentlich auch der Text "select all ausgeblendet werden"

 }

 //tname = <?php echo json_encode($nvtable); ?>;
  $.ajax( {
  url : "<?php echo site_url('nagminvx4/get_default')?>",
    type: "POST",
    success: function(response)
       	{
          mydefaults = JSON.parse(response)
           },		
         error: function (jqXHR, textStatus, errorThrown)
         {
        	alert('Error  data'  + ' ' + textStatus );
         }
});



 //alert(tname);
 // ** tabwlname von db trennen
 mytname=tname.split(":");
 tname=mytname[0];

var columnsJSON =new Array();
$.ajax( {
    url : "<?php echo site_url('nagminvx4/get_mytablecolumns')?>",
    type: "POST",
//    async: "false",
    data: {ntable:tname,ndb:mytname[1]},
        success: function(response)
       	{
            var mycol2 = new Array();
            var mytmp1 = new Array();
            mycol2=response.split(",");
            columnsJSON.push ( {title:""} );

            for(let i = 0; i < mycol2.length; i++)
            {              
//                console.log(mycol2[i]);
//                mytmp1=mycol2[i].split(":");
                mytmp1[1] = mycol2[i].replace(/\"/g, "");
                mytmp1[1] = mytmp1[1].replace(/\}/g, "");
                mytmp1[1] = mytmp1[1].replace(/\]/g, "");
                mytmp1[1] = mytmp1[1].replace(/\[/g, "");
                columnsJSON.push ( {title:mytmp1[1], visible: true} );
                
            }    
            initTable();               
      	},		
         error: function (jqXHR, textStatus, errorThrown)
         {
        	alert('Error  data'  + ' ' + textStatus );
         }
});
               



 $('#modal_form').on('shown.bs.modal', function (e) {
            mytest1()
});


 
 // +++++++++++++++++++++++++++++++++++++++++++++
 
 function getHeight() {
//  console.log('getHeight');
  return $(window).height() - $('h1').outerHeight(true);
}
 
 // https://github.com/wenzhixin/bootstrap-table/issues/3895
 function initTable() {
   ndb="halloballo"

  ttable = $table.DataTable({
    filterControl: true,
    disableUnusedSelectOptions: true,
    height: getHeight(),
    search: true,
    orderCellsTop: true,
    fixedHeader: true,
    autoWidth: true,
    select: {
            style: 'multi'
        },
    columns: columnsJSON,

    "ajax": {
      url : "<?php echo site_url('nagminvx4/get_mytable')?>",
      type: "POST",
 //     async: "true",
      data: {ntable:tname,ndb:mytname[1]},
    },
    
   
        initComplete: function () {
            // Apply the search
            this.api().columns().every( function () {
                var that = this;
                $( 'textarea', this.footer() ).on( 'keyup change clear', function () {
                    if ( that.search() !== this.value ) {
                        row=this.id
                        that.column(row).search( this.value ).draw();
                    }
                } );
           } );
  
            
        }
  });

var rid=0;
  $('#table thead th').each( function () {
        var title = $(this).text();    
        if(title && (title !== 'id')) $(this).html( title+'<br> <textarea rows="1" cols="20" type="text" id='+rid+' placeholder="Search '+title+'" />' );
        rid++;
    } );


    
 }

  //console.log($table);
  // Sometimes footer render error.
  setTimeout(() => {
//    $table.DataTable('resetView');
  }, 200);

  
  $table.on('check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', () => {
    $remove.prop('disabled', !$table.DataTable('getSelections').length);
    // Save your data, here just save the current page.
    selections = getIdSelections();
    // Push or splice the selections if you want to save all data selections.
  });

 
});

function reload_table()
{
       ttable.ajax.reload(null,false); //reload datatable ajax 
}




$("#selectall").click(function(){
        $("input[type=checkbox]").prop('checked', $(this).prop('checked'));

});


function Sleep(milliseconds) {
 return new Promise(resolve => setTimeout(resolve, milliseconds));
}

function check_show(myobject)
{
  //alert(myobject)
//  console.log(myobject)

  $.ajax({
            url : "<?php echo site_url('nagminvx4/check_show_')?>",
            type: "POST",
            data: {myobject:myobject},
           success: function(response)
        {
          if(response==1){
            myurl='nagminvx4/show_/'+myobject
            window.open(myurl, "mywin", "width=800,height=500");
            console.log("--------------");
          }
            
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('error in show_');
        }
    });

}

function edit_(mymethod)
{
 var idsArr = [];
 var xtext = [];
 var xtest = [];
 var j =0;
 var tname ="";
 var tftext = "";
 var myselectx = new Array();
 var myxyz = new Array();

 if(mymethod == 1) {save_method = 'add'; $('#btnSaveX').show();}
  else save_method = 'update';
//  alert(save_method);

  tname = <?php echo json_encode($nvtable); ?>;
  if(tname=="Interface_Scanner:0"){ 
      tname="SNMP_Walker:0";
  }
 //   console.log(tname);
 //   console.log('------------------');


  var xtest1 = [];  // datatype
  var ttest1 = [];  // form field type
  var stest1 = [];  // select
  var textra = [];  // EXTRA
  ndb='nagios';
$.ajax( {
    url : "<?php echo site_url('nagminvx4/get_newform')?>",
    type: "POST",
    data: {tname:tname,ndb:ndb},
 //   dataType: "json",
          success: function(response)
       	{
           var obj = JSON.parse( response );
           var xyz =''

           for(var i = 0; i < obj.length; i++) { 
             xtest=Object.entries(obj[i]) ;
             xtest1[i] = xtest[2][1];
             stest1[i] = xtest[3][1];
             ttest1[i] = xtest[4][1];
             if(xtest[5][1]){
              textra[i] = xtest[5][1];
             }
             else textra[i]="";
            }

 x=0;
 xx=0;
 ndb='nagios';
$('#table').find('input[type=checkbox]:checked').each(function() {
    this.value = this.value.replace("%", "\n"); // ugly , but I need this workaround !!!!!!!!!!!!!!!!!!!!!!!!!!!
    idsArr .push(this.value);
    xx++;
})

if(xx==0){
  alert("no record selected");
  return;
}

tftext = '<form action="#" id="form1" name="form1" class="form-horizontal"><div class="form-body">'

if(x==0){
  $.ajax( {
    url : "<?php echo site_url('nagminvx4/get_form')?>",
    type: "POST",
    data: {query:idsArr,tname:tname,ndb:ndb},
 //   dataType: "json",
          success: function(response)
       	{
           var obj = JSON.parse( response );
           var result1 = Object.entries(obj[0]); 
           var xyz =''
           var oldvalues="";
           k=0

          for(var i = 0; i < result1.length; i++) {       
            if(result1[i][1] !== null && result1[i][1] !== '') {
              xyz = result1[i][1]
            } else {xyz =''}
     
            var myrows=1
            var mytype='textarea'
            if(xyz.length > 50) {myrows=3}
         
        		if(xyz) xyz1 = xyz.replace(/\'/g,'§')
              else xyz1 = xyz

             oldvalues=oldvalues+result1[i][0]+'...'+xyz+'+-!,'

//             console.log("old::: "+oldvalues)

             if(mydefaults[result1[i][0]]) xdefaultt="<small> default="+mydefaults[result1[i][0]]+"</small>"
             else xdefaultt=""

            if(xtest1[i].substr(0,3) == "int" ) {
              xyz = result1[i][1]
              
                mytype='number'
                mychange=''
             
              if(mymethod == 1 && textra[i] =="auto_increment") xyz="";  // bei auto_increment kann es den Wert nur einmal geben, bei NULL wird hochgezählt
              tftext=tftext+'<div class="form-group row">' +              
                '<div class="col-3"><label for="text" class="col-form-label" onclick="check_show(\''+result1[i][0]+'\')">'+result1[i][0]+'</label></div>' +
                '<div class="col-9"><input type='+mytype+' id="'+result1[i][0]+'" '+mychange+'" min="0" value='+xyz+' step="1" data-bind="value:replyNumber" />'+xdefaultt+'</div>'+

                '<input type="hidden" value='+'"'+xyz+'"'+' name=xold_'+result1[i][0]+' id=xold_'+result1[i][0]+' /></div>' +
                '</div>'
             
            }else{
              myhelp="Hallo,Ballo"
              if(ttest1[i])  res = ttest1[i].split(","); else res = myhelp.split(",")
             
              if(res[0]=="selectone" || res[0]=="mselect" ){
                if(res[0]=="mselect" ) {multiple="multiple"} else {multiple=""} 
                var squery = stest1[i].replace(/\"/g, "#");
                if(res[1]==0) squery=0  // wenn keine Werte übernommen werden sollen

                tftext=tftext+'<div class="form-group row">' +
                '<div class="col-3"><label for="text" class="col-form-label" onclick="check_show(\''+result1[i][0]+'\')">'+result1[i][0]+'</label></div>' +
                '<div class="col-9">'+
                '<select id='+result1[i][0]+' name='+result1[i][0] +' onchange="gettemplate('+result1[i][0]+',\''+squery+'\');" class="selectpicker" data-selected-text-format '+multiple+'   data-live-search="true" data-width="80%"   >'+ 
                '</select>'+xdefaultt+'</div>'+
                '</div>'
               
               var myselect1=result1[i][0]
               tftext=tftext+'<input type=text  id=xold_'+myselect1+' hidden=true value='+'"'+xyz+'"'+' >'  // tname ist nicht unique !!!!!!!!!!!!!!!!!!!!!!!!!!
               myselectx.push(myselect1)
               myxyz.push(xyz)
               
                $.ajax( {
                  url : "<?php echo site_url('nagminvx4/get_query')?>",
                  type: "POST",
                  dataType: "JSON",
                  data: {ndb:'nagios',query:stest1[i]},             
        ///         async: false,
                  success: function(response)
       	        {
//                  console.log( "rquery::::::::::"+stest1[i]);
                 for(z=0;z<response.length;++z) {
                   if(!response[z].value) response[z].value=response[z].name
                    $('[name="'+response[z].fn+'"]').append('<option value="'+response[z].value+'">'+response[z].name+'</option>'); 
                  }   
                   var myold='#'+'xold_'+response[0].fn
                   var myoldtest=$(myold).val();
                   if(myoldtest)  ar = myoldtest.split(","); else ar = myhelp.split(",")
            //       var ar = myoldtest.split(','); // split string on comma space
                   $('[name="'+response[0].fn+'"]').val(ar);
                   $('[name="'+response[0].fn+'"]').prop('selected', true);               
                   $('[name="'+response[0].fn+'"]').selectpicker('refresh');
                   k++;

                }

              });
     
          
              }            

              if(!ttest1[i])
              tftext=tftext+'<div class="form-group row">' +
                '<div class="col-3"><label for="text" class="col-form-label" onclick="check_show(\''+result1[i][0]+'\')">'+result1[i][0]+'</label></div>' +
                '<div class="col-9"><'+mytype+' id="'+result1[i][0]+'" rows='+myrows+' class="form-control">'+xyz+'</'+mytype+'>'+
                '<input type="hidden" value='+'\''+xyz1+'\''+' name=xold_'+result1[i][0]+' id=xold_'+result1[i][0]+' /></div>' +
                '</div>'

          } 
      } 
 
  
            tftext=tftext+'</div></form>'

            xtext[j]=tftext;
      //    alert("hallo1: "+tftext)
        //  console.log(tftext)
 
  if(mymethod == 1)  $(".modal-title").text("Dublicate Form ");   
          else  $(".modal-title").text("Edit Form ");   

           $(".modal-body").html(tftext);
   //        $('#modal_form').modal({show:true});
   //        $("#modal_form").modal('show');
 
 
      	},		
         error: function (jqXHR, textStatus, errorThrown)
         {
        	alert('Error  data'  + ' ' + textStatus );
         }

});
}
///// }
x=2;

$('#modal_form').modal({show:true});
idsArr.pop();
j++;  


 
 if(j == 0 && mymethod==0)  alert("no row selected");

},		
         error: function (jqXHR, textStatus, errorThrown)
         {
        	alert('Error  data'  + ' ' + textStatus );
         }
});        

}



// ---------------------------------------------------------------------------
function gettemplate(myselect,tname){
 

// alert(tname);
if(tname==0) return; // wenn keine Werte übernommen werden sollen

if(save_method != "add") {
  var r = confirm("Update Values?");

  if (r != true) return;
}

  myval=$(myselect).val(); 
 

  mytable=tname 
  
  var resx = mytable.split(/from/); // jetzt tabelle filtern
  // console.log(resx[1]);
  resx[1]=resx[1].replaceAll("  ", " ");
  //console.log(resx[1]);
  mytablex = resx[1].split(" ");
  // console.log(mytablex[1]+"// ??????????????????????????????????????????")

  // console.log(mytable);
  var res = mytable.split(" ");



//myquery="select * from "+res[res.length-1]+" where "+res[1].replace(',','')+"='"+myval+"'"
myquery="select * from "+mytablex[1]+" where "+res[1].replace(',','')+"='"+myval+"'"

// console.log("// myquery-------------------------")

// console.log(myquery);

 $.ajax( {
                  url : "<?php echo site_url('nagminvx4/get_query')?>",
                  type: "POST",
                  dataType: "JSON",
                  data: {ndb:'nagios',query:myquery},
                  success: function(response)
       	        {
//                   console.log(response);
                  for(i=0;i<response.length;++i) {
//                    console.log( "response::::##############################::::::"+response[i]);

                    for (const [key, value] of Object.entries(response[i])) {
    
                     if(key !== res[1] ){
              
                       if(document.getElementById(key)){
                          document.getElementById(key).value=value
                          console.log(key);
                          console.log(value);
                      }
                     }

                    }

         
                  }  
  
                }

});

}


function get_default(key)
{
/*
  tname = <?php echo json_encode($nvtable); ?>;
  $.ajax( {
  url : "<?php echo site_url('nagminvx4/get_default')?>",
    type: "POST",
    data: {tname:tname,key:key},
    success: function(response)
       	{
          alert(response)
          return(response)

           },		
         error: function (jqXHR, textStatus, errorThrown)
         {
        	alert('Error  data'  + ' ' + textStatus );
         }
});
*/
// console.log('mydefaulllllllts='+mydefaults + ' von' )
return(mydefaults[key])
}

function add_()
{
 
 var i =0;
 var tname ="";
  var xtest1 = [];  // datatype
  var ttest1 = [];  // form field type
  var stest1 = [];  // select
 save_method = 'add';
 var myselectx = new Array();

 $('#btnSaveX').show();


 tname = <?php echo json_encode($nvtable); ?>;
  if(tname=="Interface_Scanner:0"){ 
      tname="SNMP_Walker:0";
  }
// console.log(tname);
//alert(tname);


/*
https://phppot.com/jquery/loading-dynamic-content-on-a-bootstrap-modal-using-jquery/

*/

var tftext = '<form action="#" id="form1" name="form1" class="form-horizontal"><div class="form-body">'
hbase="<?php echo base_url()?>"
//alert(hbase)
href=hbase+'/nagminvx4/show_/';

$.ajax( {
  url : "<?php echo site_url('nagminvx4/get_newform')?>",
    type: "POST",
    data: {tname:tname},
    success: function(response)
       	{
      //   alert(response)
//           console.log( response );
           var obj = JSON.parse( response );
           var xyz =''
           k=0;

           for(var i = 0; i < obj.length; i++) { 
//             console.log( 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY++++!!!!!!!!!!!++++++' );
             xtest=Object.entries(obj[i]) ;
//             console.log( xtest[0][1] );
//             console.log( xtest[1][1]);
//             console.log( xtest[2][1]);
//             console.log("==========" + xtest[3][1]);
//             console.log( xtest[3][1]);
             xtest1[i] = xtest[2][1];
             stest1[i] = xtest[3][1];             // query für Template!!!!
             ttest1[i] = xtest[4][1];
//             console.log( i );
//             console.log("TTEST= "+ttest1[i] + "-  "+stest1[i]);
//             console.log("cycycycycycycyccyycXXXTTEST= "+xtest[2][1] + "  ttest1[i]  "+ttest1[i] );
          

            var myrows=1
            var mytype='textarea'
            if(xtest[2][1] == "text" ) {myrows=3}
            
            if(mydefaults[xtest[0][1]]) xdefaultt="<small> default="+mydefaults[xtest[0][1]]+"</small>"
             else xdefaultt=""

            if(xtest[2][1].substr(0,3) == "int" ) {
              mytype='number'
                tftext=tftext+'<div class="form-group row">' +              
                '<div class="col-3"><label for="text" id="'+xtest[0][1]+'#" class="col-form-label" onclick="check_show(\''+xtest[0][1]+'\')">'+xtest[0][1]+'</label></div>' +
                '<div class="col-9"><input type='+mytype+' id="'+xtest[0][1]+'" min="0" step="1" data-bind="value:replyNumber,valueAllowUnset:true" />'+xdefaultt+'</div>'+
                '</div>'
                ttest1[i]=1
              }else{  

          //      if(ttest1[i])  res = ttest1[i].split(","); else res[0] = ttest1[i]
                myhelp="Hallo1,Ballo"
              if(ttest1[i])  res = ttest1[i].split(","); else res = myhelp.split(",")
             
             if(res[0]=="selectone" || res[0]=="mselect" ){
               if(res[0]=="mselect" ) {multiple="multiple"} else {multiple=""} 
               
              var squery = stest1[i].replace(/\"/g, "#");
           
              if(res[1]==0) squery=0  // wenn keine Werte übernommen werden sollen
               tftext=tftext+'<div class="form-group row">' +
              '<div class="col-3"><label for="text" id="'+xtest[0][1]+'#" class="col-form-label" onclick="check_show(\''+xtest[0][1]+'\')">'+xtest[0][1]+' '+'</label></div>' +
              '<div class="col-9">'+
              '<select id='+xtest[0][1]+' name='+xtest[0][1]+'  onchange="gettemplate('+xtest[0][1]+',\''+squery+'\');" class="selectpicker" data-selected-text-format '+multiple+' data-live-search="true" data-width="80%"   >'+
              '</select>'+xdefaultt+'</div>'+
              '</div>'
               myselect1=xtest[0][1]
//               console.log( " myselectSELECT * FROM `Relations` WHERE 11 "+ myselect1);
//                console.log( " tquery= "+stest1[i]+" select= "+ myselect1);
              myselectx.push(myselect1); 

              $.ajax( {
                url : "<?php echo site_url('nagminvx4/get_query')?>",
                type: "POST",
                dataType: "JSON",
                data: {ndb:'nagios',query:stest1[i]},
                success: function(response)
                {
//                  console.log( "response:::::CCCCCCCC:::::"+response);
                  for(z=0;z<response.length;++z) {
  //                  console.log( "response:::::value:::::"+response[z].value);
  
                    if(!response[z].value) response[z].value=response[z].name
                //    console.log( "response:::::value:::::"+response[z].value);
                    $('[name="'+response[z].fn+'"]').append('<option value="'+response[z].value+'">'+response[z].name+'</option>'); 
              //    $('[name="'+response[z].fn+'"]').append('<option value="'+response[z].name+'">'+response[z].name+'</option>'); 
              //   console.log( "appen:::::"+response[z].fn+" " + "::::" +response[z].name);
        //      $('[name="'+response[z].fn+'"]').append('<option value=""> </option>'); 
                 }  
//       console.log('select===='+response[0].fn)
                
                 $('[name="'+response[0].fn+'"]').selectpicker('refresh');
                 k++;

                }

              });
   }

  }

//  '<div class="col-3"><label for="text" id="'+xtest[0][1]+'#" class="col-form-label" onclick="var aa=this.id; alert(aa);">'+xtest[0][1]+'</label></div>' +
//'<div class="col-3"><label for="text" id="'+xtest[0][1]+'#" class="col-form-label" onclick="window.open(\''+href+xtest[0][1]+'\', \'mywin\',\'left=20,top=20,width=800,height=500,toolbar=1,resizable=1\'); return false;">'+xtest[0][1]+'</label></div>' +

if(!ttest1[i])
tftext=tftext+'<div class="form-group row">' +
 '<div class="col-3"><label for="text" id="'+xtest[0][1]+'#" class="col-form-label" onclick="check_show(\''+xtest[0][1]+'\')">'+xtest[0][1]+'</label></div>' +
 '<div class="col-9"><'+mytype+' id="'+xtest[0][1]+'" rows='+myrows+' class="form-control">'+'</'+mytype+'></div>'+
 '</div>'
 //var href = 'index.php/nagminvx4/snmp_run/'+this.value

 
 //alert(href)
// if(res[0]=="link1")
//'<div class="col-3"><label for="text" class="col-form-label"><a href=\"index.php/nagminvx4/show_/" onclick=\"window.open(this.href, \'mywin\',\'left=20,top=20,width=800,height=500,toolbar=1,resizable=1\'); return false;\">'+xtest[0][1]+'</a></label></div>' +
//'<div class="col-3"><label for="text" class="col-form-label"><a href=\"index.php/nagminvx4/show_/" onclick=\"window.open('+href+', \'mywin\',\'left=20,top=20,width=800,height=500,toolbar=1,resizable=1\'); return false;\">'+xtest[0][1]+'</a></label></div>' +
//onclick=\"var aa=this.id; alert(aa);


 
      } 
            tftext=tftext+'</div></form>'
       //    alert(tftext)
//            console.log( tftext);

           $(".modal-title").text("Add Record ");
           $(".modal-body").html(tftext);

   //        $([name='template']).val('generic-host');
          //$([name='template']).append('<option value=""> </option>'); 
          $([name='template']).selectpicker('refresh');
//          $('[name="'+response[z].fn+'"]').append('<option value="'+response[z].value+'">'+response[z].name+'</option>'); 

           $('#modal_form').modal({show:true});


       
  
      	},		
         error: function (jqXHR, textStatus, errorThrown)
         {
        	alert('Error  data'  + ' ' + textStatus );
         }
});
           
      //     $([name='template']).selectpicker('val', 'generic-host');
           //val('generic-host');
           $([name='template']).selectpicker('refresh');
     //      $([name='template']).val('generic-host');
           $([name='template']).change();
      //     $('.selectpicker').selectpicker('val', 'generic-host');
           $([name='template']).selectpicker('refresh');

  
     //      mytest1()

 }

function mytest1(){ // wenn das Formular geöffnet wird
  if( $(".modal-title").text() == "Add Record "){ // aber nur beim hinzufügem
        $('.selectpicker').change();
        $('.selectpicker').selectpicker('refresh');
 } 
}

function save(myrepeat)
{
  


    $('#btnSave').text('saving...'); //change button text
    $('#btnSave').attr('disabled',true); //set button disable 



  //alert(save_method);
  // console.log("save_method========================"+save_method)
  var tname = <?php echo json_encode($nvtable); ?>;
   if(tname=="Interface_Scanner:0"){ 
      tname="SNMP_Walker:0";
  }
  var url;

    if(save_method == 'add') {
        url = "<?php echo site_url('nagminvx4/ajax_add')?>";
    } else {
        url = "<?php echo site_url('nagminvx4/ajax_update')?>";
    }

  //  var allElements = form1.querySelectorAll('*[id]')
  //  select input
    var allElements = form1.querySelectorAll("select, input, textarea")
  //  var x = document.querySelectorAll("h2, div, span");

    var allfields = {};
    var oldfields = {};
    

    var oldvalues="";
    for (var i = 0, n = allElements.length; i < n; ++i) {
      var el = allElements[i];
    
      if (el.id) { 
//       console.log(el.id); 
       var myclass = document.getElementById(el.id).className 
     // console.log(myclass);
     // console.log("myclassmmmmmmmmmmmmmmmmmmmmmmmmm");
       myfield = el.id
       
       var myvalue=document.getElementById(el.id).value
  //     var myvalue=$('#'+el.id).val()
       if(myclass == "selectpicker") { 
        myvalue = $('#'+el.id).val()
       
        if(myvalue) myvalue = myvalue.toString();
 //       alert(myvalue)
        }
//instead of e.target.value, you can use $(this).find("option:selected").text();
//$('select').val();
//       alert(myvalue)
       if(myfield.startsWith("xold_")){

          if(myvalue){
   //         myvalueo=myvalue.replace(/-/g, "\"");
            myvalue = myvalue.replace(/§/g,'\'')
            oldfields[myfield.substring(5)] = myvalue;
          }
 
      }
       else{
        if(myvalue){
       //  myvalue = myvalue.indexOf("\n") == 0 ? myvalue.substring(1) : myvalue;  // wenn das erste Zeichen ein Newline, entfernen .. bei mehreren gehe ich von Absicht aus
         myvalue = myvalue.trim();
        }
        if(!myvalue) myvalue=null

          if(myfield != 'tname') allfields[myfield] = myvalue; // not the hidden
       }

      }
    }



  // $('#modal_form').modal('hide');


  // console.log('+++++++++++++++++++++++++++++++++++'); 
  // console.log(allfields); 
  // console.log(oldfields);
  // console.log('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'); 

  // console.log('----------------------'); 
  
    $.ajax({
        url : url,
        type: "POST",
        data: {tname:JSON.stringify(tname),ndata:JSON.stringify(allfields) ,oldvalues:JSON.stringify(oldfields)},
        dataType: "JSON",
        success: function(data)
        {
           $('#btnSave').text('save'); //change button text
           $('#btnSave').attr('disabled',false); //set button enable 
         //  alert("Stored!");

        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error adding / update data: '+jqXHR.responseText);
            $('#btnSave').text('save'); //change button text
            $('#btnSave').attr('disabled',false); //set button enable 

        }
    });

i=0
//alert(myrepeat);
//alert("Stored!");

j=0
if(myrepeat==0){ // wenn ...............
     $("input:checked").each(function() { 
      if(i==0) {  
       $(this).prop('checked', false);
       //alert("I== "+i)
      }
      i++;
      j++; 
     // alert("EDIT I== "+i)
      
     }); 
     if(j>1)edit_(0); // nur neuer Dialog, wenn noch mindestens ein Datensatz ausgewählt ist
}
// if(save_method == 'add') i=1

if(i==1 && myrepeat==0) { 
 // alert("Das ist das Ende")
  $('#btnSaveX').hide();
  $('#modal_form').modal('hide');
  reload_table();
//  console.log("reload_table")

}



//console.log("save_method= "+save_method+" myrepeat "+myrepeat)
if(save_method == 'add' &&  myrepeat == 0){
  $('#modal_form').modal('hide');
  reload_table();
//  console.log("reload_table")
}


}


function delete_()
{
   
  var idsArr = [];
  var i =0;
  var tname = <?php echo json_encode($nvtable); ?>;
   if(tname=="Interface_Scanner:0"){ 
      tname="SNMP_Walker:0";
  }
  var url;
  url = "<?php echo site_url('nagminvx4/ajax_delete')?>";
  

   $('#table').find('input[type=checkbox]:checked').each(function() {
   idsArr .push(this.value);
 
//    console.log('---------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx---------');
//    console.log( this.value);

   // tname = <?php echo json_encode($nvtable); ?>;
 //   console.log(tname);
 //   console.log('------------------');
    
    i++;
   
    var tmp1=this.value.substr(this.value.lastIndexOf("+")+1);
//alert(tmp1);
    Check = confirm("Delete "+tmp1+"?");
    xyz="OK ich lösche: "+tmp1
    if(Check == true) {
      alert(xyz);
      $.ajax({
        url : url,
        type: "POST",
        data: {tname:tname,ndata:this.value},
       dataType: "JSON",
        success: function(data)
        {
     //    alert(data);
        },
        error: function (jqXHR, textStatus, errorThrown)
        {
            alert('Error deleting data: '+jqXHR.responseText);
        }
    });



    }
});

if(i == 0) alert("no row selectetd");



 $(".modal-title").text("Delete");
 $(".modal-body").text("das ist der Inhalt");


//


   $("#myModal").modal('show');
   reload_table();


}



function snmp_start(){
 var idsArr = [];
 xx=0
 $('#table').find('input[type=checkbox]:checked').each(function() {
 
    this.value = this.value.replace("%", "\n"); // ugly , but I need this workaround !!!!!!!!!!!!!!!!!!!!!!!!!!!
    idsArr .push(this.value);

    var href = 'index.php/nagminvx4/snmp_run/'+this.value
    $('#mcontent').load(href);
    xx++;
 //   console.log( idsArr );
 })
 if(xx==0){
  $('#spinner').hide(); 
  alert("no record selected");
  return;
}

}



function interface_start(){
 var idsArr = [];
 xx=0
 $('#table').find('input[type=checkbox]:checked').each(function() {
  ///$xtext=str_replace("\n","%",$xtext); // ugly , but I need this !!!!!!!!!!!!!!!!!!!!!!!!!!!
    this.value = this.value.replace("%", "\n"); // ugly , but I need this workaround !!!!!!!!!!!!!!!!!!!!!!!!!!!
    idsArr .push(this.value);
    var href = 'index.php/nagminvx4/interface_run/'+this.value
    $('#mcontent').load(href);
    xx++;
 //   console.log( idsArr );
 })
 if(xx==0){
  $('#spinner').hide(); 
  alert("no record selected");
  return;
}
}

function report_start(){
 var idsArr = [];
 xx=0
 $('#table').find('input[type=checkbox]:checked').each(function() {
      this.value = this.value.replace("%", "\n"); // ugly , but I need this workaround !!!!!!!!!!!!!!!!!!!!!!!!!!!
    idsArr .push(this.value);
    var href = 'index.php/nagminvx4/Reports/'+this.value
    $('#mcontent').load(href);
    xx++;

 })
 if(xx==0){
  $('#spinner').hide(); 
  alert("no record selected");
  return;
}
}






// https://phppot.com/jquery/loading-dynamic-content-on-a-bootstrap-modal-using-jquery/
</script>


<!-- Bootstrap modal -->
<div class="modal fade" id="modal_form" role="dialog">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title">Person Form</h3>
            </div>
            <div class="modal-body form">
            <form action="#" id="form" class="form-horizontal">
            </form>           
            </div>
            <div class="modal-footer" id="modal-footer">
                <button type="button" id="btnSave" onclick="save(0)" class="btn btn-primary">Save</button>
                <button type="button" id="btnSaveX" onclick="save(1)" class="btn btn-primary">Save repeat</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- End Bootstrap modal -->


</body>
</html>
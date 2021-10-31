
function ad_sso()
{

    var username='';   
    $.ajax({
            url : 'https://myiis.Tortisoft.de/authpageNV/authcheck.aspx',
        type: 'GET',
        async: false,
        crossDomain : true,
                xhrFields: {
                    withCredentials: true
                }
                })
                .done(function (data) {
                    mydata = data.replace(/(<([^>]+)>)/ig,'');
          //          alert(mydata);
                    var res = mydata.split(';');
                    var res1 = res[1].split(':');
                //	alert("hahah"+res1);
                   var res2 = res[1].split('\\');
//                     alert( res2[1].toLowerCase());
                     
                    username = res2[1].toLowerCase(); 
                    $('#lname').val(res2[1].toLowerCase());
                    $('#name').val(res2[1].toLowerCase());
                     

                })
                .fail(function (jqXHR, textStatus, errorThrown) {
                    $('#result').text(textStatus);
                    console.log($('#result').text(textStatus));
                    alert('Fehler bei Authentifizierung an: myserver');

                });
                
                var user = ['xxxx', 'torsten', 'admin'];
                var n = jQuery.inArray( username.toLowerCase(), user );
                 if(n < 0) window.location.href='https://myserver/error.html';             

    return(username);
}

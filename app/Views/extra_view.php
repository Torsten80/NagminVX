<!doctype html>
<html lang="en">

<div class="modal fade" id="modalSNMPForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold">SNMP + Interface Browser</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="form-group row">              
                <div class="col-3"><label for="text" class="col-form-label">snmp version</label></div>
                <div class="col-9"><input type=number id="snmp_version" min="1" step="1" data-bind="value:replyNumber,valueAllowUnset:true" />1</div>
      </div>
      <div class="form-group row">              
                <div class="col-3"><label for="text" class="col-form-label">Host</label></div>
                <div class="col-9"><input type=number id="snmp_version" min="1" step="1" data-bind="value:replyNumber,valueAllowUnset:true" />1</div>
      </div>
      <div class="form-group row">              
                <div class="col-3"><label for="text" class="col-form-label">Community</label></div>
                <div class="col-9"><input type=number id="snmp_version" min="1" step="1" data-bind="value:replyNumber,valueAllowUnset:true" />1</div>
      </div>
      <div class="form-group row">              
                <div class="col-3"><label for="text" class="col-form-label">authProtocol</label></div>
                <div class="col-9"><input type=number id="snmp_version" min="1" step="1" data-bind="value:replyNumber,valueAllowUnset:true" />1</div>
      </div>
      <div class="form-group row">              
                <div class="col-3"><label for="text" class="col-form-label">privProtocol</label></div>
                <div class="col-9"><input type=number id="snmp_version" min="1" step="1" data-bind="value:replyNumber,valueAllowUnset:true" />1</div>
      </div>
      <div class="form-group row">              
                <div class="col-3"><label for="text" class="col-form-label">authProtocol</label></div>
                <div class="col-9"><input type=number id="snmp_version" min="1" step="1" data-bind="value:replyNumber,valueAllowUnset:true" />1</div>
      </div>
      <div class="form-group row">              
                <div class="col-3"><label for="text" class="col-form-label">privProtocol</label></div>
                <div class="col-9"><input type=number id="snmp_version" min="1" step="1" data-bind="value:replyNumber,valueAllowUnset:true" />1</div>
      </div>
      <div class="modal-footer d-flex justify-content-center">
        <button class="btn btn-default " onclick="snmp_t1()">Start</button>
      </div>
    </div>
  </div>
</div>



<div class="modal fade" id="modalSNMPForm1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold">SNMP + Interface Browser</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body mx-3">
        <div class="md-form mb-5">
          <i class="fas fa-envelope prefix grey-text"></i>
          <input type="email" id="defaultForm-email" class="form-control validate">
          <label data-error="wrong" data-success="right" for="defaultForm-email">Your email</label>
        </div>

        <div class="md-form mb-4">
          <i class="fas fa-lock prefix grey-text"></i>
          <input type="password" id="defaultForm-pass" class="form-control validate">
          <label data-error="wrong" data-success="right" for="defaultForm-pass">Your password</label>
        </div>

      </div>
      <div class="modal-footer d-flex justify-content-center">
        <button class="btn btn-default " onclick="snmp_t1()">Start</button>
      </div>
    </div>
  </div>
</div>


<script>





function snmp_t1()
{
  alert("SNMP T1 Test");
  $('#spinner').hide();
  $('#modalSNMPForm').modal('dispose');
  //echo "<b>Hallo Ballo<p>";
  myaccount();


}

$(document).ready(function() {

$('#spinner').hide();
$('#modalSNMPForm').modal({show:true});


})
 // document ready - END ----------------------------------------------------------------

</script>

</body>
</html>
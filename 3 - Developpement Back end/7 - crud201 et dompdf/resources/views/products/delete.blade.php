
<div id="myModalDeleteProduct" class="modal">
    <!-- Modal content -->
    <div class="modal-content" style="width:700px;">
        <div class="modal-header">
            <span class=" btnClose close">&times;</span>
            <h2>@lang('Delete')</h2>
        </div>
        <div class="modal-body">
            <div class="row">
                <div class="col-xs-12 col-sm-12 col-md-12">
                    <div class="form-group">

                        <form id="deleteForm" onsubmit="return submitDeleteForm(event)">
                            @csrf<input id="txtId" name="txtId" type="hidden" value=""/>
                        </form>





                        <strong>Are you sure you want to delete this product ?</strong>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <button  class="btnYes bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded" id="close">@lang('Yes delete it')</button>
            <button  class="btnClose  bg-black  text-white font-bold py-2 px-4 rounded" id="close">@lang('Close')</button>
        </div>
    </div>

</div>
<script>
       $(".btnClose").on('click',function(){
          $("#myModalDeleteProduct").hide();
      })

      $(".btnYes").on('click',function(){
        var formData = $('#deleteForm').serialize();
        var url = "{{ route('products.delete')}}"   //  $("#searchForm").attr("action");

         //troisième methode de recherche sans actualisation de la page avec axios
        axios.post(url, formData)
        .then(response => {
            if (response.data=="ok")
            {
                    $("#myModalDeleteProduct").hide();
                    $("#row"+$("#txtId").val()).remove();
                    //document.location.reload();
            }
            else
                alert("Error");
        })
        .catch(error => {
            console.log(error);
        });




      })



</script>

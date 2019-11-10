<template>
  <div id="app">
    <div class="table-responsive">
      <table id="users-datatable" data-source="/my/users.json" class="table table-bordered dataTable">
        <thead>
          <tr>
          <th>User Name</th>
          <th>Email</th>
          </tr>
        </thead>
        <tbody>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  mounted: function() {
    jQuery('#users-datatable').dataTable({
      "processing": true,
      "serverSide": true,
      "columnDefs": [
        { "width": "1.5em", "orderable": false, "targets": 0 },
        { "width": "8.5em", "orderable": false, "targets": -1 }
      ],
      "ajax": { "url": "/my/users.json" },
      "language": { "url": "//cdn.datatables.net/plug-ins/1.10.19/i18n/Japanese.json" },
      "drawCallback": function( settings ) {
        $('#users-datatable a[data-toggle="tooltip"]').tooltip()
        jQuery('#users-datatable a[data-toggle="modal"]').click(function(e) {
          e.preventDefault();
          var url = jQuery(this).attr('href');
          if (url.indexOf('#') == 0) {
            jQuery(url).modal('open');
          } else {
            jQuery.get(url, function(data) {
              jQuery('<div class="modal" tabindex="-1" role="dialog">  <div class="modal-dialog" role="document">    <div class="modal-content">      <div class="modal-header">        <h5 class="modal-title">Modal title</h5>        <button type="button" class="close" data-dismiss="modal" aria-label="Close">          <span aria-hidden="true">&times;</span>        </button>      </div>      <div class="modal-body">        <p>Modal body text goes here.</p>      </div>      <div class="modal-footer">        <button type="button" class="btn btn-primary">Save changes</button>        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>      </div>    </div>  </div></div>').modal();
        //    }).success(function() {
        //      jQuery('input:text:visible:first').focus();
            });
          }
        });
      },
      "pagingType": "full_numbers",
      "columns": [
        {"data": "username"},
        {"data": "email"}
      ],
      "order": [[ 1, "asc" ]]
      // pagingType is optional, if you want full pagination controls.
      // Check dataTables documentation to learn more about
      // available options.
    });

  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

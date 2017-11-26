<div class="module-filter">

  <h3 class="oc-module-heading"><?php echo $heading_title; ?></h3>

  <div class="panel panel-default panel-condensed">
    <div class="list-group list-group-condensed form-horizontal">
      <?php foreach ($filter_groups as $filter_group) { ?>
        <a class="list-group-item list-group-heading"><?php echo $filter_group['name']; ?></a>
        <div class="list-group-item">
          <div id="filter-group<?php echo $filter_group['filter_group_id']; ?>">
            <?php foreach ($filter_group['filter'] as $filter) { ?>
              <div class="checkbox">
                <label>
                  <?php if (in_array($filter['filter_id'], $filter_category)) { ?>
                    <input name="filter[]" type="checkbox" value="<?php echo $filter['filter_id']; ?>" checked="checked" />
                    <b class="text-primary"><?php echo $filter['name']; ?></b>
                  <?php } else { ?>
                    <input name="filter[]" type="checkbox" value="<?php echo $filter['filter_id']; ?>" />
                    <?php echo $filter['name']; ?>
                  <?php } ?>
                </label>
              </div>
            <?php } ?>
          </div>
        </div>
      <?php } ?>
    </div>
    <div class="panel-footer text-right">
      <button type="button" id="button-clear-filter" class="btn btn-sm btn-danger pull-left" data-toggle="tooltip" title="<?php echo $button_clear; ?>"><i class="fa fa-times"></i></button>
      <button type="button" id="button-filter" class="btn btn-sm btn-primary"><?php echo $button_filter; ?></button>
    </div>
  </div>
  <script>
  $('#button-filter').on('click', function() {
    var filter = [];
    
    $('input[name^=\'filter\']:checked').each(function(element) {
      filter.push(this.value);
    });
    
    location = '<?php echo $action; ?>&filter=' + filter.join(',');
  });
  $('#button-clear-filter').on('click', function() {
    location = '<?php echo $action; ?>';
  });
  </script> 
</div>
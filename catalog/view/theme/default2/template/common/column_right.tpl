<?php if ($position_sidebar_right) { ?>
  <?php echo $position_sidebar_right; ?>
<?php } else { ?>
<?php if ($modules) { ?>
<column id="column-right" class="col-sm-3 hidden-xs module-vert">
  <?php foreach ($modules as $module) { ?>
    <?php if ($module) { ?>
      <div class="oc-module">
        <?php echo $module; ?>
      </div>
    <?php } ?>
  <?php } ?>
</column>
<?php } ?>
<?php } ?>
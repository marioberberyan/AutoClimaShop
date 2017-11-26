<?php if ($position_content_top_a || $position_content_top_b) { ?>
  <div class="position-container position-content-top">
    <?php echo $position_content_top_a . $position_content_top_b; ?>
  </div>
<?php } ?>
<?php if ($modules) { ?>
  <div id="content-top" class="module-horz">
    <?php foreach ($modules as $module) { ?>
      <div class="oc-module">
        <?php echo $module; ?>
      </div>
    <?php } ?>
  </div>
<?php } ?>
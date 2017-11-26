<?php if ($modules) { ?>
  <div id="content-bottom" class="module-horz">
    <?php foreach ($modules as $module) { ?>
      <div class="oc-module">
        <?php echo $module; ?>
      </div>
    <?php } ?>
  </div>
<?php } ?>
<?php if ($position_content_btm_a || $position_content_btm_b) { ?>
  <div class="position-container position-content-bottom">
    <?php echo $position_content_btm_a . $position_content_btm_b; ?>
  </div>
<?php } ?>
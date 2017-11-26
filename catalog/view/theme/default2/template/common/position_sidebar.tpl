<?php if ($modules) { ?>
  <column id="<?php echo $position['id']; ?>" class="col-sm-3 hidden-xs">
    <div class="position-block <?php echo $position['class']; ?>">
      <?php foreach ($modules as $module) { ?>
        <?php if ($module) { ?>
          <div class="oc-module">
            <?php echo $module; ?>
          </div>
        <?php } ?>
      <?php } ?>
    </div>
  </column>
<?php } ?>
<?php if ($modules) { ?>
  <div id="<?php echo $position['id']; ?>" class="position-block <?php echo $position['class']; ?>">
    <?php if (count($blocks) > 1) { ?>

      <div class="row">
        <?php foreach ($modules as $col => $columns) {
          switch ($blocks[$col]) {
            case 3:
              $grid = 'col-sm-6 col-md-3 module-vert';
              break;
            case 4:
              $grid = 'col-sm-4 col-md-4 module-vert';
              break;
            case 6:
              $grid = 'col-sm-6 col-md-6 module-vert';
              break;
            case 9:
              $grid = 'col-sm-6 col-md-9';
              break;
            default:
              $grid = 'col-sm-' . $blocks[$col];
              break;
          }
        ?>
          <div class="<?php echo $grid; ?>">
            <?php foreach ($columns as $module) { ?>
              <?php if ($module) { ?>
                <div class="oc-module">
                  <?php echo $module; ?>
                </div>
              <?php } ?>
            <?php } ?>
          </div>
        <?php } ?>
      </div>

    <?php } else { ?>

      <?php foreach ($modules as $module) { ?>
        <?php if ($module) { ?>
          <div class="oc-module">
            <?php echo $module; ?>
          </div>
        <?php } ?>
      <?php } ?>

    <?php } ?>
  </div>
<?php } ?>
<div class="module-category">
  <div class="list-group">
    <?php foreach ($categories as $category) { ?>
        <a href="<?php echo $category['href']; ?>" class="list-group-item <?php echo ($category['category_id'] == $category_id) ? 'active' : ''; ?>">
          <?php echo $category['name']; ?>
          <?php if ($category['count'] != 0) { ?>
            <span class="badge"><?php echo $category['count']; ?></span>
          <?php } ?>
        </a>

      <?php if ($category['children'] && ($category['category_id'] == $category_id)) { ?>
        <?php foreach ($category['children'] as $child) { ?>
          <a href="<?php echo $child['href']; ?>" class="list-group-item <?php echo ($child['category_id'] == $child_id) ? 'active' : ''; ?>">
            <div class="bs-margin-left-sm">
              <?php echo $child['name']; ?>
              <?php if ($child['count'] != 0) { ?>
                <span class="badge pull-right"><?php echo $child['count']; ?></span>
              <?php } ?>
            </div>
          </a>
        <?php } ?>
      <?php } ?>

    <?php } ?>
  </div>
</div>
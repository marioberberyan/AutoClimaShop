<?php echo $header; ?>

<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>

  <div class="row">
    <?php if ($position_top_a || $position_top_b || $position_top_c) { ?>
      <div class="col-sm-12 position-container position-top">
        <?php echo $position_top_a . $position_top_b . $position_top_c; ?>
      </div>
    <?php } ?>
    <?php echo $column_left; ?>

    <?php
      if ($column_left && $column_right) {
        $class = 'col-sm-6';
      } elseif ($column_left || $column_right) {
        $class = 'col-sm-9';
      } else {
        $class = 'col-sm-12';
      }
    ?>
    <div id="content" class="<?php echo $class; ?>">
      <?php echo $content_top; ?>

      <div class="category-info">
        <h1 class="page-title"><?php echo $heading_title; ?></h1>

        <?php if ($thumb || $description) { ?>
          <div class="row">
            <?php if ($thumb) { ?>
              <div class="col-sm-4 category-thumb"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" title="<?php echo $heading_title; ?>" class="img-thumbnail" /></div>
            <?php } ?>

            <?php if ($description && $thumb) { ?>
              <div class="col-sm-8 category-description"><?php echo $description; ?></div>
            <?php } elseif ($description && !$thumb) { ?>
              <div class="col-sm-12 category-description"><?php echo $description; ?></div>
            <?php } ?>

          </div>
          <hr>
        <?php } ?>
      </div> <!-- /.category-info -->

      <?php if ($categories) { ?>
          <div class="category-child-list">
            <div class="row">
              <?php foreach ($categories as $category) { ?>
                <div class="col-xs-12">
                  <div class="thumbnail" style="min-height:<?php echo $default2['child_thumb_size_height']; ?>px">
                    <a href="<?php echo $category['href']; ?>">
                      <img src="<?php echo $category['image']; ?>" alt="">

                      <div class="ccl-category">
                        <h3><?php echo $category['name']; ?></h3>
                        <p><?php echo $category['desc']; ?></p>
                      </div>
                    </a>
                  </div>
                </div>
              <?php } ?>
            </div>
          </div>
        <?php } ?>

      <?php if (!$categories) { ?>
        <div class="empty-entries"><?php echo $text_empty; ?></div>
      <?php } ?>

      <?php echo $content_bottom; ?>
    </div>

    <?php echo $column_right; ?>
    <?php if ($position_bottom_a || $position_bottom_b || $position_bottom_c) { ?>
      <div class="col-sm-12 position-container position-bottom">
        <?php echo $position_bottom_a . $position_bottom_b . $position_bottom_c; ?>
      </div>
    <?php } ?>
  </div>

</div>
<?php echo $footer; ?>
<?php echo $header; ?>

<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li> <a href="<?php echo $breadcrumb['href']; ?>"> <?php echo $breadcrumb['text']; ?> </a> </li>
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

      <h1 class="page-title"><?php echo $heading_title; ?></h1>

      <?php if ($categories) { ?>
        <ul class="list-inline manufacture-index-list">
          <li><strong><?php echo $text_index; ?></strong></li>
          <?php foreach ($categories as $category) { ?>
            <li><a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><?php echo $category['name']; ?></a></li>
          <?php } ?>
        </ul>

        <?php foreach ($categories as $category) { ?>
          <h3 class="manufacture-index" id="<?php echo $category['name']; ?>"><?php echo $category['name']; ?></h3>
          <?php if ($category['manufacturer']) { ?>
            <?php foreach (array_chunk($category['manufacturer'], 4) as $manufacturers) { ?>
              <div class="row">
                <?php foreach ($manufacturers as $manufacturer) { ?>
                <div class="col-sm-3"><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></div>
                <?php } ?>
              </div>
            <?php } ?>
          <?php } ?>
        <?php } ?>
      <?php } else { ?>
        <div class="empty-entries"><?php echo $text_empty; ?></p>
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
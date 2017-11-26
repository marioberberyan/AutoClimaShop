<?php echo $header; ?>

<div class="not-found-404">
  <div class="container">

    <div class="row">
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

        <div class="row">
          <div class="col-sm-6 col-sm-offset-3 text-center">
            <h1 class="title-404">404</h1>

            <p class="text-404"><?php echo $not_found_info; ?></p>

            <div class="search-404">
              <div id="search404" class="input-group js-portable-search">
                <input type="text" name="search" value="" placeholder="Search" class="form-control input-lg js-input-search">
                <span class="input-group-btn">
                  <button type="button" class="btn btn-primary btn-lg js-button-search"><i class="fa fa-search"></i></button>
                </span>
              </div>
            </div>

            <div class="nav-404">
              <ul class="list-inline">
                <li>
                  <a href="<?php echo $link_home ?>"><?php echo $text_home; ?></a>
                </li>
                <li>
                  <a href="<?php echo $link_sitemap ?>"><?php echo $text_sitemap; ?></a>
                </li>
                <li>
                  <a href="<?php echo $link_contact ?>"><?php echo $text_contact; ?></a>
                </li>
              </ul>
            </div>

          </div>
        </div>

        <?php echo $content_bottom; ?>
      </div>

      <?php echo $column_right; ?>
    </div>
  </div>

<script>
<?php if ($default2['template_404'] == '2') { ?>
  $('body').addClass('blank-mode');
<?php } ?>
</script>

</div>
<?php echo $footer; ?>
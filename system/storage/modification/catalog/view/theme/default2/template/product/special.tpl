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
      </div>

      <?php if ($products) { ?>
        <div class="category-product">
          <div class="category-panel">
            <div class="row">
              <div class="col-md-4">
                <div class="btn-group btn-group-sm hidden-xs bs-margin-right-xs btn-grid-list">
                  <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
                  <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
                </div>
                <a id="compare-total" class="btn btn-default btn-sm btn-view-compare" href="<?php echo $compare; ?>"><?php echo $text_compare; ?></a>
              </div>

              <div class="col-md-8">
                <div class="form-inline">
                  <div class="form-group">
                    <label for="input-sort"><?php echo $text_sort; ?></label>
                    <select id="input-sort" class="form-control input-sm" onchange="location = this.value;">
                      <?php foreach ($sorts as $sorts) { ?>
                        <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
                          <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
                        <?php } else { ?>
                          <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
                        <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                  <div class="form-group">
                    <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
                    <select id="input-limit" class="form-control input-sm" onchange="location = this.value;">
                      <?php foreach ($limits as $limits) { ?>
                        <?php if ($limits['value'] == $limit) { ?>
                          <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
                        <?php } else { ?>
                          <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
                        <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </div>

            </div>
          </div> <!-- /.category-panel -->

          <div class="category-list">
            <?php $identifier = round(microtime() * 10000000); ?>
            <div class="row bs-row-condensed">
              <?php foreach ($products as $product) { ?>
                <div class="product-layout product-list col-xs-12">
                  <div class="product-thumb">
                    <div class="product-thumb-inner">
                      <div class="image">
                        <a href="<?php echo $product['href']; ?>">
                          <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                        </a>
                      </div>

                      <div class="caption mh-category-<?php echo $identifier; ?>">
                        <h4 class="mh-category-<?php echo $identifier; ?>-title"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>

                        <p class="teaser mh-category-<?php echo $identifier; ?>-teaser"><?php echo $product['description']; ?></p>

                        <?php if ($product['price']) { ?>
                          <div class="price">
                            <?php if (!$product['special']) { ?>
                              <span class="price-regular"><?php echo $product['price']; ?></span>
                            <?php } else { ?>
                              <span class="price-new"><?php echo $product['special']; ?></span>
                              <span class="price-old"><?php echo $product['price']; ?></span>
                            <?php } ?>

                            <?php if (false)  { ?>
                              <div class="price-tax">
                                <?php echo $text_tax; ?>
                                <?php echo $product['tax']; ?>
                              </div>
                            <?php } ?>
                          </div>
                        <?php } ?>

                        <?php if ($product['rating']) { ?>
                          <div class="rating">
                            <?php for ($i = 1; $i <= 5; $i++) { ?>
                              <span class="star">
                                <?php if ($product['rating'] < $i) { ?>
                                    <i class="fa fa-star-o fa-lg text-muted"></i>
                                <?php } else { ?>
                                    <i class="fa fa-star fa-lg text-warning"></i>
                                <?php } ?>
                              </span>
                            <?php } ?>
                          </div>
                        <?php } ?>
                      </div>

                      <div class="button-container">
                        <div class="btn-group button-group">
                          <button type="button" class="btn btn-primary btn-cart col-xs-6 col-lg-8" onclick="cart.add('<?php echo $product['product_id']; ?>');">
                            <i class="fa fa-shopping-cart fa-lg"></i> <span class="hidden-md"><?php echo $button_cart; ?></span>
                          </button>
                          <button type="button" class="btn btn-default btn-wishlist col-xs-3 col-lg-2" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');">
                            <i class="fa fa-heart"></i>
                          </button>
                          <button type="button" class="btn btn-default btn-compare col-xs-3 col-lg-2" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');">
                            <i class="fa fa-exchange"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  </div> <!-- /.product-thumb -->
                </div>
              <?php } ?>
            </div>
          </div> <!-- /.category-list -->

          <div class="category-pagination">
            <div class="row">
              <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
              <div class="col-sm-6 text-right"><?php echo $results; ?></div>
            </div>
          </div> <!-- /.category-pagination -->
        </div> <!-- /.category-product -->
      <?php } else { ?>
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

<?php if ($products) { ?>
<script>
$(document).ready(function()
{
  $('.mh-category-<?php echo $identifier; ?>-title').matchHeight();
  $('.mh-category-<?php echo $identifier; ?>-teaser').matchHeight(false);
  $('.mh-category-<?php echo $identifier; ?>').matchHeight();
  $(window).trigger('resize');

  $('.btn-grid-list .btn').on('click', function() {
    setTimeout(function() {
      $(window).trigger('resize');
    }, 500);
  });
});
</script>
<?php } ?>

</div>
<?php echo $footer; ?>
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
        $class_content        = 'col-sm-6';
        $class_product_left   = 'col-sm-6';
        $class_product_right  = 'col-sm-6';
      } elseif ($column_left || $column_right) {
        $class_content        = 'col-sm-9';
        $class_product_left   = 'col-sm-7 col-lg-13-20';
        $class_product_right  = 'col-sm-5 col-lg-7-20';
      } else {
        $class_content        = 'col-sm-12';
        $class_product_left   = 'col-sm-8';
        $class_product_right  = 'col-sm-4';
      }
    ?>
    <div id="content" class="<?php echo $class_content; ?>">
      <?php echo $content_top; ?>

      <div class="row">
        <div class="product-left-panel <?php echo $class_product_left; ?>">
          <div class="product-image bs-margin-bottom-lg">
            <?php if ($thumb) { ?>
              <div class="image-main imagePopup">
                <a class="thumbnail" href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>">
                  <img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                </a>
              </div>
            <?php } ?>
            <?php if ($images) { ?>
              <ul class="list-inline image-additionals imagePopup">
                <?php foreach ($images as $image) { ?>
                  <li class="image-additional col-xs-6 col-sm-3 col-md-1-5">
                    <a class="thumbnail" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>">
                      <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                    </a>
                  </li>
                <?php } ?>
              </ul>
            <?php } ?>
          </div><!-- /.product-image -->

          <ul class="nav nav-tabs product-tab">
            <li class="active">
              <a href="#tab-description" data-toggle="tab"><?php echo $tab_description; ?></a>
            </li>
            <?php if ($attribute_groups) { ?>
              <li><a href="#tab-specification" data-toggle="tab"><?php echo $tab_attribute; ?></a></li>
            <?php } ?>
            <?php if ($review_status) { ?>
              <li><a href="#tab-review" data-toggle="tab"><?php echo $tab_review; ?></a></li>
            <?php } ?>
          </ul>

          <div class="tab-content product-tab-content">
            <div class="tab-pane active" id="tab-description"><?php echo $description; ?></div>

            <?php if ($attribute_groups) { ?>
              <div class="tab-pane" id="tab-specification">
                <table class="table table-bordered">
                  <?php foreach ($attribute_groups as $attribute_group) { ?>
                  <thead>
                    <tr>
                      <td colspan="2"><strong><?php echo $attribute_group['name']; ?></strong></td>
                    </tr>
                  </thead>
                  <tbody>
                    <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
                    <tr>
                      <td><?php echo $attribute['name']; ?></td>
                      <td><?php echo $attribute['text']; ?></td>
                    </tr>
                    <?php } ?>
                  </tbody>
                  <?php } ?>
                </table>
              </div>
            <?php } ?>

            <?php if ($review_status) { ?>
              <div class="tab-pane" id="tab-review">
                <div id="review" class="review-list"></div>

                <div class="review-form">
                  <h2><?php echo $text_write; ?></h2>

                  <?php if ($review_guest) { ?>
                    <form id="form-review" class="form-horizontal">
                      <div class="form-group required">
                          <label class="control-label col-md-3" for="input-name"><?php echo $entry_name; ?></label>
                          <div class="col-md-9">
                            <input type="text" name="name" value="" id="input-name" class="form-control" />
                          </div>
                      </div>
                      <div class="form-group required">
                          <label class="control-label col-md-3" for="input-review"><?php echo $entry_review; ?></label>
                          <div class="col-md-9">
                            <textarea name="text" rows="5" id="input-review" class="form-control"></textarea>
                            <div class="bs-text-help"><?php echo $text_note; ?></div>
                          </div>
                      </div>
                      <div class="form-group required">
                        <label class="control-label col-md-3"><?php echo $entry_rating; ?></label>
                        <div class="col-md-9">
                          <span class="bs-margin-right-xs"><?php echo $entry_bad; ?></span>
                          <input type="radio" name="rating" value="1" />
                          <input type="radio" name="rating" value="2" />
                          <input type="radio" name="rating" value="3" />
                          <input type="radio" name="rating" value="4" />
                          <input type="radio" name="rating" value="5" />
                          <span class="bs-margin-left-xs"><?php echo $entry_good; ?></span>
                        </div>
                      </div>
                      <?php echo $captcha; ?>
                      <div class="buttons">
                        <div class="pull-right">
                          <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><?php echo $button_continue; ?></button>
                        </div>
                      </div>
                    </form>
                  <?php } else { ?>
                    <?php echo $text_login; ?>
                  <?php } ?>
                </div>

              </div>
            <?php } ?>
          </div> <!-- /.product-tab-content -->
        </div> <!-- /.product-left-panel -->

        <div class="product-right-panel <?php echo $class_product_right; ?>">
          <div class="product-detail">
            <h1 class="page-title product-title"><?php echo $heading_title; ?></h1>

            <div class="product-info">
              <ul class="list-unstyled">
                <?php if ($manufacturer) { ?>
                  <li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
                <?php } ?>
                <li><?php echo $text_model; ?> <?php echo $model; ?></li>
                <?php if ($reward) { ?>
                  <li><?php echo $text_reward; ?> <?php echo $reward; ?></li>
                <?php } ?>
                <li><?php echo $text_stock; ?> <?php echo $stock; ?></li>
              </ul>
            </div>

            <?php if ($price) { ?>
              <div class="price product-price">
                <ul class="list-unstyled">
                  <?php if (!$special) { ?>
                    <li><span class="price-regular"><?php echo $price; ?></span></li>
                  <?php } else { ?>
                    <li><span class="price-old"><?php echo $price; ?></span></li>
                    <li><div class="price-new"><?php echo $special; ?></div></li>
                  <?php } ?>

                  <?php if (false) { ?>
                    <li><span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span></li>
                  <?php } ?>
                  <?php if ($points) { ?>
                    <li><span class="price-point"><?php echo $text_points; ?> <?php echo $points; ?></span></li>
                  <?php } ?>
                  <?php if ($discounts) { ?>
                    <li><hr></li>
                    <?php foreach ($discounts as $discount) { ?>
                      <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                    <?php } ?>
                  <?php } ?>
                </ul>
              </div>
            <?php } ?>

            <?php if ($review_status) { ?>
              <div class="product-rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <span class="star">
                    <?php if ($rating < $i) { ?>
                        <i class="fa fa-star-o fa-lg text-muted"></i>
                    <?php } else { ?>
                        <i class="fa fa-star fa-lg text-warning"></i>
                    <?php } ?>
                  </span>
                <?php } ?>

                <span class="bs-text-helper bs-margin-left-xs">
                  <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $reviews; ?></a>
                  / <a href="" onclick="$('a[href=\'#tab-review\']').trigger('click'); return false;"><?php echo $text_write; ?></a>
                </span>
              </div>
            <?php } ?>
          </div>

          <div id="product" class="product-options">
            <?php if ($options) { ?>
              <hr>
              <h4><?php echo $text_option; ?></h4>

              <div class="row">
                <div class="col-xs-12 col-md-9-10 col-lg-8-10">
                  <?php foreach ($options as $option) { ?>
                    <?php if ($option['type'] == 'select') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                      <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                        <?php if ($option_value['price']) { ?>
                        (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                        <?php } ?>
                        </option>
                        <?php } ?>
                      </select>
                    </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'radio') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label"><?php echo $option['name']; ?></label>
                      <div id="input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="radio">
                          <label>
                            <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                            <?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                          </label>
                        </div>
                        <?php } ?>
                      </div>
                    </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'checkbox') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label"><?php echo $option['name']; ?></label>
                      <div id="input-option<?php echo $option['product_option_id']; ?>">
                        <?php foreach ($option['product_option_value'] as $option_value) { ?>
                        <div class="checkbox">
                          <label>
                            <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                            <?php echo $option_value['name']; ?>
                            <?php if ($option_value['price']) { ?>
                            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                            <?php } ?>
                          </label>
                        </div>
                        <?php } ?>
                      </div>
                    </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'image') { ?>
                      <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                        <label class="control-label"><?php echo $option['name']; ?></label>
                        <div id="input-option<?php echo $option['product_option_id']; ?>">
                          <?php foreach ($option['product_option_value'] as $option_value) { ?>
                          <div class="radio">
                            <label>
                              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
                              <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
                              <?php if ($option_value['price']) { ?>
                              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                              <?php } ?>
                            </label>
                          </div>
                          <?php } ?>
                        </div>
                      </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'text') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                      <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                    </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'textarea') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                      <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
                    </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'file') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label"><?php echo $option['name']; ?></label>
                      <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                      <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
                    </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'date') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                      <div class="input-group date">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                        <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                        </span></div>
                    </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'datetime') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                      <div class="input-group datetime">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span></div>
                    </div>
                    <?php } ?>
                    <?php if ($option['type'] == 'time') { ?>
                    <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
                      <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
                      <div class="input-group time">
                        <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
                        <span class="input-group-btn">
                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span></div>
                    </div>
                    <?php } ?>
                  <?php } ?>
                </div>
              </div>
            <?php } ?>

            <?php if ($recurrings) { ?>
              <hr>
              <h4><?php echo $text_payment_recurring ?></h4>

              <div class="row">
                <div class="col-xs-12 col-md-9-10 col-lg-8-10">
                  <div class="form-group required">
                    <select name="recurring_id" class="form-control">
                      <option value=""><?php echo $text_select; ?></option>
                      <?php foreach ($recurrings as $recurring) { ?>
                      <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
                      <?php } ?>
                    </select>
                    <div class="help-block" id="recurring-description"></div>
                  </div>
                </div>
              </div>
            <?php } ?>

            <div class="form-group">
              <hr>
              <div class="row form-horizontal">
                <label class="control-label col-sm-2" for="input-quantity"><?php echo $entry_qty; ?></label>
                <div class="col-sm-6 col-md-4">
                  <input type="number" name="quantity" value="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
                </div>
                <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
              </div>
              <br />

              <?php if ($minimum > 1) { ?>
                <div class="alert alert-warning"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
              <?php } ?>

              <div class="btn-group btn-group-lg btn-block">
                <button type="button" id="button-cart" class="btn btn-primary col-xs-6 col-md-8 btn-cart" data-loading-text="<?php echo $text_loading; ?>"><?php echo $button_cart; ?></button>
                <button type="button" class="btn btn-default col-xs-3 col-md-2 btn-wishlist" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');"><i class="fa fa-heart"></i></button>
                <button type="button" class="btn btn-default col-xs-3 col-md-2 btn-compare" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');"><i class="fa fa-exchange"></i></button>
              </div>
            </div>
          </div>

          <hr>
          <!-- AddThis Button BEGIN -->
          <div class="addthis_toolbox addthis_default_style"><a class="addthis_button_facebook_like" fb:like:layout="button_count"></a> <a class="addthis_button_tweet"></a> <a class="addthis_button_pinterest_pinit"></a> <a class="addthis_counter addthis_pill_style"></a></div>
          <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-515eeaf54693130e"></script> 
          <!-- AddThis Button END --> 
        </div> <!-- /.product-right-panel -->
      </div>

      <?php if ($products) { ?>
        <?php $identifier = round(microtime() * 10000000); ?>
        <?php
          if ($column_left && $column_right) {
            $class = 'col-xs-12 col-md-6';
          } elseif ($column_left || $column_right) {
            $class = 'col-xs-12 col-sm-6 col-md-3';
          } else {
            $class = 'col-xs-12 col-sm-6 col-md-3 col-lg-1-5';
          }
        ?>

        <div class="product-related">
          <h3><?php echo $text_related; ?></h3>

          <div class="row bs-row-condensed">
            <?php foreach ($products as $product) { ?>

              <div class="<?php echo $class; ?>">
                <div class="product-thumb">
                  <div class="product-thumb-inner">
                    <div class="image">
                      <a href="<?php echo $product['href']; ?>">
                        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
                      </a>
                    </div>

                    <div class="caption <?php echo (!$default2['related_product_desc']) ? 'hide-teaser' : '' ; ?> mh-related-<?php echo $identifier; ?>">
                      <h4 class="mh-related-<?php echo $identifier; ?>-title"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>

                      <?php if ($default2['related_product_desc']) { ?>
                        <p class="teaser mh-related-<?php echo $identifier; ?>-teaser"><?php echo $product['description']; ?></p>
                      <?php } ?>

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

                    <div class="btn-group button-group">
                      <button type="button" class="btn btn-primary btn-cart col-xs-6 col-lg-8" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
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
                </div> <!-- /.product-thumb -->
              </div>
            <?php } ?>
          </div>
        </div>
      <?php } ?>

      <?php if ($tags) { ?>
        <p><?php echo $text_tags; ?>
          <?php for ($i = 0; $i < count($tags); $i++) { ?>
            <?php if ($i < (count($tags) - 1)) { ?>
              <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
            <?php } else { ?>
              <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
            <?php } ?>
          <?php } ?>
        </p>
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

<script>
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
  $.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
    dataType: 'json',
    beforeSend: function() {
      $('#recurring-description').html('');
    },
    success: function(json) {
      $('.alert, .text-danger').remove();
      
      if (json['success']) {
        $('#recurring-description').html(json['success']);
      }
    }
  });
});
</script> 
<script>
$('#button-cart').on('click', function() {
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('#product input[type=\'text\'], #product input[type=\'number\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('#button-cart').button('loading');
    },
    complete: function() {
      $('#button-cart').button('reset');
    },
    success: function(json) {
      $('.alert, .text-danger').remove();
      $('.form-group').removeClass('has-error');

      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            var element = $('#input-option' + i.replace('_', '-'));
            
            if (element.parent().hasClass('input-group')) {
              element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            } else {
              element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            }
          }
        }
        
        if (json['error']['recurring']) {
          $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
        }
        
        // Highlight any found errors
        $('.text-danger').parent().addClass('has-error');
      }
      
      if (json['success']) {
        $('.breadcrumb').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
        
        $('#cart-total').html(json['total']);
        
        $('html, body').animate({ scrollTop: 0 }, 'slow');
        
        $('#cart > ul').load('index.php?route=common/cart/info ul li');
      }
    }
  });
});
</script> 
<script>
$('.date').datetimepicker({
  pickTime: false
});

$('.datetime').datetimepicker({
  pickDate: true,
  pickTime: true
});

$('.time').datetimepicker({
  pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
  var node = this;

  $('#form-upload').remove();
  
  $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');
  
  $('#form-upload input[name=\'file\']').trigger('click');
  
  timer = setInterval(function() {
    if ($('#form-upload input[name=\'file\']').val() != '') {
      clearInterval(timer);

      $.ajax({
        url: 'index.php?route=tool/upload',
        type: 'post',
        dataType: 'json',
        data: new FormData($('#form-upload')[0]),
        cache: false,
        contentType: false,
        processData: false,
        beforeSend: function() {
          $(node).button('loading');
        },
        complete: function() {
          $(node).button('reset');
        },
        success: function(json) {
          $('.text-danger').remove();

          if (json['error']) {
            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
          }

          if (json['success']) {
            alert(json['success']);

            $(node).parent().find('input').attr('value', json['code']);
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    }
  }, 500);
});
</script> 
<script>
$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();

    $('#review').fadeOut('slow');
    $('#review').load(this.href);
    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: $("#form-review").serialize(),
    beforeSend: function() {
      $('#button-review').button('loading');
    },
    complete: function() {
      $('#button-review').button('reset');
    },
    success: function(json) {
      $('.alert-success, .alert-danger').remove();

      if (json['error']) {
        $('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
      }

      if (json['success']) {
        $('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
        
        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').prop('checked', false);
      }
    }
  });
});

$(document).ready(function() {
  $('.imagePopup').magnificPopup({
    type:'image',
    delegate: 'a',
    gallery: {
      enabled:true
    }
  });

  <?php if ($products) { ?>
    $('.mh-related-<?php echo $identifier; ?>-title').matchHeight();
    $('.mh-related-<?php echo $identifier; ?>-teaser').matchHeight(false);
    $('.mh-related-<?php echo $identifier; ?>').matchHeight();
  <?php } ?>
});
 </script> 
<?php echo $footer; ?>

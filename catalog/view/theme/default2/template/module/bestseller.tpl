<div class="module-bestseller">
<?php $identifier = round(microtime() * 10000000); ?>

<h3 class="oc-module-heading"><?php echo $heading_title; ?></h3>

<div class="row bs-row-condensed">
  <?php foreach ($products as $product) { ?>
    <div class="col-xs-12 col-sm-6 col-md-3">
      <div class="product-thumb">
        <div class="product-thumb-inner">
          <div class="image">
            <a href="<?php echo $product['href']; ?>">
              <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
            </a>
          </div>

          <div class="caption mh-bestseller-<?php echo $identifier; ?> <?php echo (!$default2['product_module_desc']) ? 'hide-teaser' : ''; ?>">
            <h4 class="mh-bestseller-<?php echo $identifier; ?>-title"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>

            <?php if ($default2['product_module_desc']) { ?>
              <p class="teaser mh-bestseller-<?php echo $identifier; ?>-teaser"><?php echo $product['description']; ?></p>
            <?php } ?>

            <?php if ($product['price']) { ?>
              <div class="price">
                <?php if (!$product['special']) { ?>
                  <span class="price-regular"><?php echo $product['price']; ?></span>
                <?php } else { ?>
                  <span class="price-new"><?php echo $product['special']; ?></span>
                  <span class="price-old"><?php echo $product['price']; ?></span>
                <?php } ?>

                <?php if ($product['tax']) { ?>
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
      </div> <!-- /.product-thumb -->
    </div>
  <?php } ?>
</div>

<script>
$(document).ready(function()
{
  $('.mh-bestseller-<?php echo $identifier; ?>-title').matchHeight();
  $('.mh-bestseller-<?php echo $identifier; ?>-teaser').matchHeight(false);
  $('.mh-bestseller-<?php echo $identifier; ?>').matchHeight();
});
</script>
</div>
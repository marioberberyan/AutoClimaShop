<?php echo $header; ?>

<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>

  <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  <?php } ?>

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

      <?php if ($products) { ?>
        <?php $count = count($products); ?>
        <div class="table-responsive">
          <table class="compare-table table table-striped table-hover">
            <thead>
              <tr>
                <td colspan="<?php echo $count + 1; ?>"><?php echo $text_product; ?></td>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="compare-first-column"><?php echo $text_name; ?></td>
                <?php foreach ($products as $product) { ?>
                  <td class="compare-name col-sm-<?php echo 12 / $count; ?>"><a href="<?php echo $products[$product['product_id']]['href']; ?>"><?php echo $products[$product['product_id']]['name']; ?></a></td>
                <?php } ?>
              </tr>
              <tr>
                <td><?php echo $text_image; ?></td>
                <?php foreach ($products as $product) { ?>
                  <td class="text-center compare-image">
                    <?php if ($products[$product['product_id']]['thumb']) { ?>
                      <img src="<?php echo $products[$product['product_id']]['thumb']; ?>" alt="<?php echo $products[$product['product_id']]['name']; ?>" title="<?php echo $products[$product['product_id']]['name']; ?>" class="img-thumbnail" />
                    <?php } ?>
                  </td>
                <?php } ?>
              </tr>
              <tr>
                <td><?php echo $text_price; ?></td>
                <?php foreach ($products as $product) { ?>
                  <td class="price compare-price">
                    <?php if ($products[$product['product_id']]['price']) { ?>
                      <?php if (!$products[$product['product_id']]['special']) { ?>
                        <span class="price-regular"><?php echo $products[$product['product_id']]['price']; ?></span>
                      <?php } else { ?>
                        <span class="price-new"> <?php echo $products[$product['product_id']]['special']; ?> </span>
                        <span class="price-old"><?php echo $products[$product['product_id']]['price']; ?> </span>
                      <?php } ?>
                    <?php } ?>
                  </td>
                <?php } ?>
              </tr>
              <tr>
                <td><?php echo $text_model; ?></td>
                <?php foreach ($products as $product) { ?>
                  <td><?php echo $products[$product['product_id']]['model']; ?></td>
                <?php } ?>
              </tr>
              <tr>
                <td><?php echo $text_manufacturer; ?></td>
                <?php foreach ($products as $product) { ?>
                  <td><?php echo $products[$product['product_id']]['manufacturer']; ?></td>
                <?php } ?>
              </tr>
              <tr>
                <td><?php echo $text_availability; ?></td>
                <?php foreach ($products as $product) { ?>
                  <td><?php echo $products[$product['product_id']]['availability']; ?></td>
                <?php } ?>
              </tr>
              <?php if ($review_status) { ?>
              <tr>
                <td><?php echo $text_rating; ?></td>
                <?php foreach ($products as $product) { ?>
                  <td class="rating">
                    <?php for ($i = 1; $i <= 5; $i++) { ?>
                      <?php if ($products[$product['product_id']]['rating'] < $i) { ?>
                        <i class="fa fa-star-o fa-lg text-muted"></i>
                      <?php } else { ?>
                        <i class="fa fa-star fa-lg text-warning"></i>
                      <?php } ?>
                    <?php } ?>
                    <div class="bs-text-helper">
                      <?php echo $products[$product['product_id']]['reviews']; ?>
                    </div>
                  </td>
                <?php } ?>
              </tr>
              <?php } ?>
              <tr>
                <td><?php echo $text_summary; ?></td>
                <?php foreach ($products as $product) { ?>
                  <td class="description compare-description"><?php echo $products[$product['product_id']]['description']; ?></td>
                <?php } ?>
              </tr>
              <tr>
                <td><?php echo $text_weight; ?></td>
                <?php foreach ($products as $product) { ?>
                <td><?php echo $products[$product['product_id']]['weight']; ?></td>
                <?php } ?>
              </tr>
              <tr>
                <td><?php echo $text_dimension; ?></td>
                <?php foreach ($products as $product) { ?>
                <td><?php echo $products[$product['product_id']]['length']; ?> x <?php echo $products[$product['product_id']]['width']; ?> x <?php echo $products[$product['product_id']]['height']; ?></td>
                <?php } ?>
              </tr>
            </tbody>

            <!-- Add to cart button -->
            <tbody class="divider">
              <tr>
                <td colspan="<?php echo $count + 1; ?>"></td>
              </tr>
              <tr>
                <td></td>
                <?php foreach ($products as $product) { ?>
                  <td class="text-center">
                    <input type="button" value="<?php echo $button_cart; ?>" class="btn btn-primary btn-cart" onclick="cart.add('<?php echo $product['product_id']; ?>');" />
                    <a href="<?php echo $product['remove']; ?>" class="btn btn-danger btn-remove"><?php echo $button_remove; ?></a>
                  </td>
                <?php } ?>
              </tr>
            </tbody>

            <?php if (!empty($attribute_groups)) { ?>
              <?php foreach ($attribute_groups as $attribute_group) { ?>
                <tbody class="divider">
                  <tr>
                    <td colspan="<?php echo $count + 1; ?>"></td>
                  </tr>
                </tbody>
                <thead>
                  <tr>
                    <td colspan="<?php echo $count + 1; ?>"><?php echo $attribute_group['name']; ?></td>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
                    <tr>
                      <td><?php echo $attribute['name']; ?></td>
                      <?php foreach ($products as $product) { ?>
                      <?php if (isset($products[$product['product_id']]['attribute'][$key])) { ?>
                      <td><?php echo $products[$product['product_id']]['attribute'][$key]; ?></td>
                      <?php } else { ?>
                      <td></td>
                      <?php } ?>
                      <?php } ?>
                    </tr>
                  <?php } ?>
                </tbody>
              <?php } ?>

              <!-- Add to cart button -->
              <tbody class="divider">
                <tr>
                  <td colspan="<?php echo $count + 1; ?>"></td>
                </tr>
                <tr>
                  <td></td>
                  <?php foreach ($products as $product) { ?>
                    <td class="text-center">
                      <input type="button" value="<?php echo $button_cart; ?>" class="btn btn-primary btn-cart" onclick="cart.add('<?php echo $product['product_id']; ?>');" />
                      <a href="<?php echo $product['remove']; ?>" class="btn btn-danger btn-remove"><?php echo $button_remove; ?></a>
                    </td>
                  <?php } ?>
                </tr>
              </tbody>
            <?php } ?>

          </table>
        </div>
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
</div>
<?php echo $footer; ?>
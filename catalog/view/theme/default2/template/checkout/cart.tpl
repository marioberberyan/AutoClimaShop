<?php echo $header; ?>

<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>

  <?php if ($attention) { ?>
    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  <?php } ?>
  <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  <?php } ?>
  <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
  <?php } ?>

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

      <h1 class="page-title"><?php echo $heading_title; ?>
        <?php if ($weight) { ?>
        <small>(<?php echo $weight; ?>)</small>
        <?php } ?>
      </h1>

      <form class="cart-list" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <div class="table-responsive">
          <table class="table table-striped table-hover">
            <thead>
              <tr>
                <td class="text-center cl-image"><?php echo $column_image; ?></td>
                <td class="text-left cl-name"><?php echo $column_name; ?></td>
                <td class="text-left cl-model"><?php echo $column_model; ?></td>
                <td class="text-center cl-qty"><?php echo $column_quantity; ?></td>
                <td class="text-right cl-price"><?php echo $column_price; ?></td>
                <td class="text-right cl-total"><?php echo $column_total; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product) { ?>
                <tr class="cart-list-item cart-product <?php echo (!$product['stock']) ? 'danger' : ''; ?>">
                  <td class="text-center">
                    <?php if ($product['thumb']) { ?>
                      <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-thumbnail" /></a>
                    <?php } ?>
                  </td>
                  <td class="text-left">
                    <div class="cart-item-name">
                      <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
                      <?php if (!$product['stock']) { ?>
                        <span class="text-danger">***</span>
                      <?php } ?>
                    </div>
                    
                    <div class="cart-item-options">
                      <?php if ($product['option'] || $product['reward'] || $product['recurring']) { ?>
                        <ul class="list-unstyled">
                          <?php if ($product['option']) { ?>
                            <?php foreach ($product['option'] as $option) { ?>
                              <li><?php echo $option['name']; ?>: <?php echo $option['value']; ?></li>
                            <?php } ?>
                          <?php } ?>
                          <?php if ($product['reward']) { ?>
                            <li><?php echo $product['reward']; ?></li>
                          <?php } ?>
                          <?php if ($product['recurring']) { ?>
                            <li>
                              <span class="label label-warning"><?php echo $text_recurring_item; ?></span>
                              <?php echo $product['recurring']; ?>
                            </li>
                          <?php } ?>
                        </ul>
                      <?php } ?>
                    </div>
                  </td>
                  <td class="text-left"><?php echo $product['model']; ?></td>
                  <td class="text-left">
                    <div class="input-group input-group-sm cart-item-quantity">
                      <input type="number" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" class="form-control" />
                      <span class="input-group-btn">
                        <button type="submit" data-toggle="tooltip" title="<?php echo $button_update; ?>" class="btn btn-primary"><i class="fa fa-refresh"></i></button>
                        <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="cart.remove('<?php echo $product['cart_id']; ?>');"><i class="fa fa-times-circle"></i></button>
                      </span>
                    </div>
                  </td>
                  <td class="text-right"><?php echo $product['price']; ?></td>
                  <td class="text-right"><?php echo $product['total']; ?></td>
                </tr>
              <?php } ?>

              <?php foreach ($vouchers as $vouchers) { ?>
                <tr class="cart-list-item cart-voucher">
                  <td></td>
                  <td class="text-left"><?php echo $vouchers['description']; ?></td>
                  <td class="text-left"></td>
                  <td class="text-left">
                    <div class="input-group input-group-sm cart-item-quantity">
                      <input type="text" name="" value="1" size="1" disabled="disabled" class="form-control" />
                      <span class="input-group-btn">
                        <button type="button" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger" onclick="voucher.remove('<?php echo $vouchers['key']; ?>');">
                          <i class="fa fa-times-circle"></i>
                        </button>
                      </span>
                    </div>
                  </td>
                  <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                  <td class="text-right"><?php echo $vouchers['amount']; ?></td>
                </tr>
              <?php } ?>
            </tbody>
          </table>
        </div>
      </form> <!-- /.cart-list -->

      <div class="row">
        <div class="col-md-7 cart-options">
          <?php if ($coupon || $voucher || $reward || $shipping) { ?>
            <div class="panel-group panel-condensed" id="accordion">
              <?php echo $coupon; ?>
              <?php echo $voucher; ?>
              <?php echo $reward; ?>
              <?php echo $shipping; ?>
            </div>
          <?php } ?>
        </div>
        <div class="col-md-4 col-md-offset-1 cart-order">
          <table class="table table-condensed">
            <?php foreach ($totals as $total) { ?>
              <tr>
                <td class="text-right"><strong><?php echo $total['title']; ?>:</strong></td>
                <td class="text-right"><?php echo $total['text']; ?></td>
              </tr>
            <?php } ?>
          </table>
        </div>
      </div>


      <div class="buttons">
        <div class="pull-left"><a href="<?php echo $continue; ?>" class="btn btn-default btn-continue"><?php echo $button_shopping; ?></a></div>
        <div class="pull-right"><a href="<?php echo $checkout; ?>" class="btn btn-danger btn-checkout"><?php echo $button_checkout; ?></a></div>
      </div>

      <?php echo $content_bottom; ?>
    </div>

    <?php echo $column_right; ?>
  </div>
</div>
<?php echo $footer; ?> 
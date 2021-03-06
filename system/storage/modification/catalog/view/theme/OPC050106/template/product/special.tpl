<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h1><?php echo $heading_title; ?></h1>
      <?php if ($products) { ?>
    
      <div class="row category_filter">
        <div class="col-md-4 btn-list-grid">
          <div class="btn-group">
            <button type="button" id="list-view" class="btn" data-toggle="tooltip" title="<?php echo $button_list; ?>"></button>
            <button type="button" id="grid-view" class="btn" data-toggle="tooltip" title="<?php echo $button_grid; ?>"></button>
          </div>
		    <a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a>
        </div>
<div class="product_filter col-md-6">
        <div class="col-sm-3 col-md-3 text-right sort_label">
          <label class="control-label" for="input-sort"><?php echo $text_sort; ?></label>
        </div>
        <div class="col-sm-3 col-md-3 text-right sort">
          <select id="input-sort" class="form-control" onchange="location = this.value;">
            <?php foreach ($sorts as $sorts) { ?>
            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="col-md-2 text-right limit_label">
          <label class="control-label" for="input-limit"><?php echo $text_limit; ?></label>
        </div>
        <div class="col-xs-2 col-sm-2 col-md-2 text-right limit">
          <select id="input-limit" class="form-control" onchange="location = this.value;">
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
      <div class="row">  
        <?php foreach ($products as $product) { ?>     
        <div class="product-layout product-list col-xs-12">
          <div class="product-thumb product-block">
            <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" /></a></div>
            <div class="caption">
			<h4>
				<!--<?php if (strlen($product['name']) > '15') { ?>
						<a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>"><?php echo substr($product['name'], 0, 15)."..."; ?></a>
				 <?php } else { ?>
						<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
				 <?php } ?> -->
				<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
			 </h4>   
            <div class="description">
<?php echo $product['description']; ?></div>
              <?php if ($product['rating']) { ?>
              <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($product['rating'] < $i) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
              <?php } ?>
                  <div class="wishlist">
                <button type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-heart"></i><?php echo $button_wishlist; ?></button></div>
				 <div class="compare">
                <button type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="fa fa-exchange"></i><?php echo $button_compare; ?></button></div>
             


              <?php if ($product['price']) { ?>
              <p class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
                <?php } ?>
                <?php if (false)  { ?>
                <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                <?php } ?>
              </p>
              <?php } ?>
          
           
			<div class="cart">
			   			   <button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');"> <span class="hidden-xs hidden-sm hidden-md"><?php echo $button_cart; ?></span></button>

              			  </div>
            </div>
          </div>
        </div>
        <?php } ?>
      </div>
      <div class="row">
   <div class="pagination_link">
        <div class="text-right pull-right"><?php echo $pagination; ?></div>
        <div class="text-left pull-left results"><?php echo $results; ?></div>
      </div>
	  </div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
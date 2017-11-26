<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title><?php echo $title; ?></title>
  <base href="<?php echo $base; ?>" />
  <?php if ($description) { ?>
  <meta name="description" content="<?php echo $description; ?>" />
  <?php } ?>
  <?php if ($keywords) { ?>
  <meta name="keywords" content= "<?php echo $keywords; ?>" />
  <?php } ?>

  <?php foreach ($links as $link) { ?>
  <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
  <?php } ?>

  <link href="catalog/view/theme/default2/stylesheet/bootstrap.min.css?v=3.3.2" rel="stylesheet">
  <link href="catalog/view/theme/default2/stylesheet/font-awesome.min.css?v=4.3.0" rel="stylesheet">
  <link href="catalog/view/theme/default2/stylesheet/bootstrap-extra.min.css?v=3.3.2" rel="stylesheet">
  <?php if ($gfont_load) { ?>
    <link href="//fonts.googleapis.com/css?family=<?php echo $gfont_load; ?>" rel="stylesheet" type="text/css" />
  <?php } ?>
  <?php foreach ($styles as $style) { ?>
    <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
  <?php } ?>
  <link href="catalog/view/theme/default2/stylesheet/default2.min.css?v=<?php echo $default2_version; ?>" rel="stylesheet">
  <?php if (file_exists('catalog/view/theme/default2/stylesheet/default2-preset-' . $default2['preset_id'] . '.css')) { ?>
    <link href="catalog/view/theme/default2/stylesheet/default2-preset-<?php echo $default2['preset_id']; ?>.css?v=<?php echo $default2['uniqid']; ?>" rel="stylesheet">
  <?php } ?>
  <?php if (file_exists('catalog/view/theme/default2/stylesheet/default2-custom.css')) { ?>
    <link href="catalog/view/theme/default2/stylesheet/default2-custom.css" rel="stylesheet">
  <?php } ?>

  <script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
  <script src="catalog/view/theme/default2/javascript/bootstrap.min.js?v=3.3.2" type="text/javascript"></script>
  <script src="catalog/view/theme/default2/javascript/matchHeight.min.js" type="text/javascript"></script>
  <script src="catalog/view/javascript/common.js" type="text/javascript"></script>
  <?php foreach ($scripts as $script) { ?>
    <script src="<?php echo $script; ?>" type="text/javascript"></script>
  <?php } ?>
  <script src="catalog/view/theme/default2/javascript/default2.js?v=<?php echo $default2_version; ?>" type="text/javascript"></script>

  <?php foreach ($analytics as $analytic) { ?>
    <?php echo $analytic; ?>
  <?php } ?>
</head>

<body class="<?php echo $class; ?>">
<?php if ($position_hide_blk_top) { ?>
  <?php echo $position_hide_blk_top; ?>
<?php } ?>

<nav id="nav-top" class="link-contrast">
  <div class="container">
    <div class="row">
      <div class="col-xs-6">
        <?php if ($position_tlb_top_left) { ?>
          <div class="position-container position-toolbar">
            <?php echo $position_tlb_top_left; ?>
          </div>
        <?php } else { ?>
          <ul class="list-inline top-nav-left">
            <li><?php echo $currency; ?></li>
            <li><?php echo $language; ?></li>
          </ul>
        <?php } ?>
      </div>
      <div class="col-xs-6 text-right">
       <?php if ($position_tlb_top_right) { ?>
          <div class="position-container position-toolbar">
            <?php echo $position_tlb_top_right; ?>
          </div>
        <?php } else { ?>
          <ul class="list-inline top-nav-right">
            <li class="dropdown dropdown-hover bs-dropdown-tight">
              <a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>" class="dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-user fa-lg visible-xs-inline"></i> <span class="hidden-xs"><?php echo $text_account; ?></span> <span class="caret"></span>
              </a>
              <ul class="dropdown-menu dropdown-menu-right">
                <?php if ($logged) { ?>
                  <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                  <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                  <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
                  <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
                  <li><a href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a></li>
                <?php } else { ?>
                  <li><a href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
                  <li><a href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
                <?php } ?>
              </ul>
            </li>
            <li>
              <a href="<?php echo $wishlist; ?>" id="wishlist-total" title="<?php echo $text_wishlist; ?>">
                <i class="fa fa-heart fa-lg visible-xs-inline"></i> <span class="hidden-xs"><?php echo $text_wishlist; ?></span>
              </a>
            </li>
            <li>
              <a href="<?php echo $shopping_cart; ?>" title="<?php echo $text_shopping_cart; ?>">
                <i class="fa fa-shopping-cart fa-lg visible-xs-inline"></i> <span class="hidden-xs"><?php echo $text_shopping_cart; ?></span>
              </a>
            </li>
          </ul>
        <?php } ?>
      </div>
    </div>
  </div>
</nav> <!-- /#nav-top -->

<header id="site-header">
  <div class="container">
    <div class="row">
      <div class="col-sm-4 logo-section">
        <div id="logo">
          <?php if ($logo) { ?>
            <a href="<?php echo $home; ?>">
              <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" />
            </a>
          <?php } else { ?>
            <h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
          <?php } ?>
        </div>
      </div>
      <div class="col-sm-5 search-section">
        <?php echo $search; ?>
      </div>
      <div class="col-sm-3 cart-section">
        <?php echo $cart; ?>
      </div>
    </div>
  </div>
</header> <!-- /#site-header -->

<div class="container">
  <div id="nav-main">
    <?php if ($position_main_menu) { ?>
      <div class="position-container position-main-menu">
        <?php echo $position_main_menu; ?>
      </div>
    <?php } elseif ($categories) { ?>
      <nav class="navbar navbar-plain navbar-double">
        <div class="navbar-header visible-xs visible-sm">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-menu-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand"><?php echo $text_category; ?></a>
        </div>

        <div id="main-menu-collapse" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <?php foreach ($categories as $category) { ?>
              <?php if ($category['children']) { ?>
                <li class="dropdown">
                  <a href="<?php echo $category['href']; ?>" class="dropdown-toggle" data-toggle="dropdown">
                    <?php echo $category['name']; ?>
                    <span class="caret"></span>
                  </a>
                  
                  <?php if ($category['column'] > 1) { ?>
                    <div class="dropdown-menu dropdown-megamenu">
                      <div class="megamenu-container megamenu-<?php echo min($category['column'], 5); ?>">
                        <?php foreach (array_chunk($category['children'], ceil(count($category['children']) / min($category['column'], 5) )) as $children) { ?>
                          <ul class="megamenu-item">
                            <?php foreach ($children as $child) { ?>
                            <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                            <?php } ?>
                          </ul>
                        <?php } ?>
                      </div>
                      <ul class="megamenu-item">
                        <li class="divider"></li>
                        <li class="see-all"><a href="<?php echo $category['href']; ?>"><?php echo $text_all; ?> <?php echo $category['name']; ?></a></li>
                      </ul>
                    </div>
                  <?php } else { ?>
                    <ul class="dropdown-menu">
                      <?php foreach ($category['children'] as $child) { ?>
                        <li><a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a></li>
                      <?php } ?>
                        <li class="divider"></li>
                        <li class="see-all"><a href="<?php echo $category['href']; ?>"><?php echo $text_all; ?> <?php echo $category['name']; ?></a></li>
                    </ul>
                  <?php } ?>
                </li>
              <?php } else { ?>
                <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
              <?php } ?>
            <?php } ?>
          </ul> <!-- /.navbar-nav -->
        </div>
      </nav> <!-- /#nav-main -->
    <?php } ?>
  </div>
</div>
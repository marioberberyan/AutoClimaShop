<?php if (count($currencies) > 1) { ?>
  <form action="<?php echo $action; ?>" method="post" id="currency">
    <div class="dropdown dropdown-hover bs-dropdown-tight">
      <a class="dropdown-toggle" data-toggle="dropdown">
        <?php foreach ($currencies as $currency) { ?>
          <?php if ($currency['code'] == $code) { ?>
            <strong class="visible-xs-inline"><?php echo $currency['symbol_left'] ?: $currency['symbol_right']; ?></strong>
            <span class="hidden-xs"><?php echo $currency['title']; ?></span>
            <span class="caret"></span>
          <?php } ?>
        <?php } ?>
      </a>
      <ul class="dropdown-menu bs-dropdown-sm">
        <?php foreach ($currencies as $currency) { ?>
          <li>
            <a class="currency-select" name="<?php echo $currency['code']; ?>">
              <?php echo $currency['symbol_left'] ?: $currency['symbol_right']; ?>
              <?php echo $currency['title']; ?>
            </a>
          </li>
        <?php } ?>
      </ul>
    </div>
    <input type="hidden" name="code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </form>
<?php } ?>
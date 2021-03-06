<div class="container">
  <footer>
      <div class="row">
        <?php if ($informations) { ?>
        <div class="col-sm-3">
          <h4><?php echo $text_information; ?></h4>
          <ul class="list-group">
            <?php foreach ($informations as $information) { ?>
            <li class="list-group-item"><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
            <?php } ?>
          </ul>
        </div>
        <?php } ?>
        <div class="col-sm-3">
          <h4><?php echo $text_service; ?></h4>
          <ul class="list-group">
            <li class="list-group-item"><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
            <li class="list-group-item"><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
            <li class="list-group-item"><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
          </ul>
        </div>
        <div class="col-sm-3">
          <h4><?php echo $text_extra; ?></h4>
          <ul class="list-group">
            <li class="list-group-item"><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
            <li class="list-group-item"><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
            <li class="list-group-item"><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
            <li class="list-group-item"><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
          </ul>
        </div>
        <div class="col-sm-3">
          <h4><?php echo $text_account; ?></h4>
          <ul class="list-group">
            <li class="list-group-item"><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
            <li class="list-group-item"><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li class="list-group-item"><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
            <li class="list-group-item"><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
          </ul>
        </div>
      </div>
      <p class="text-center text-uppercase text-muted powered">Design by <a href="//themefiber.com/">themefiber</a>. <?php echo $powered; ?></p>
  </footer>
</div>

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<!-- Theme created by Welford Media for OpenCart 2.0 www.welfordmedia.co.uk -->

</body></html>

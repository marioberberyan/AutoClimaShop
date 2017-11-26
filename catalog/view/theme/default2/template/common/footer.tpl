<footer id="footer" class="link-contrast">
  <?php if ($position_footer_ribbon) { ?>
    <div class="position-container position-ribbon">
      <div class="footer-ribbon">
        <div class="container">
          <?php echo $position_footer_ribbon; ?>
        </div>
      </div>
    </div>
  <?php } ?>

  <div class="container">
    <div class="position-container position-footer">
      <?php if ($position_footer_a) { ?>
        <div class="footer-block">
          <?php echo $position_footer_a; ?>
        </div>
      <?php } ?>

      <?php if ($position_footer_b) { ?>
        <div class="footer-block">
          <?php echo $position_footer_b; ?>
        </div>
      <?php } else { ?>
        <!-- default footer menu -->
        <div class="footer-block">
            <div class="row">
              <?php if ($informations) { ?>
              <div class="col-sm-3">
                <div class="footer-info-1 footer-information">
                  <h5 class="header"><?php echo $text_information; ?></h5>
                  <ul class="list-unstyled">
                    <?php foreach ($informations as $information) { ?>
                      <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
                    <?php } ?>
                  </ul>
                </div>
              </div>
              <?php } ?>
              <div class="col-sm-3">
                <div class="footer-info-2">
                  <h5 class="header"><?php echo $text_service; ?></h5>
                  <ul class="list-unstyled">
                    <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
                    <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
                    <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
                  </ul>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="footer-info-3">
                  <h5 class="header"><?php echo $text_extra; ?></h5>
                  <ul class="list-unstyled">
                    <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
                    <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
                    <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
                    <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
                  </ul>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="footer-info-4 footer-account">
                  <h5 class="header"><?php echo $text_account; ?></h5>
                  <ul class="list-unstyled">
                    <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
                    <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
                    <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
                    <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
                  </ul>
                </div>
              </div>
            </div>
        </div>
      <?php } ?>

      <?php if ($position_footer_c) { ?>
        <div class="footer-block">
          <?php echo $position_footer_c; ?>
        </div>
      <?php } ?>
    </div>
  </div>

  <div class="footer-toolbar">
    <div class="container">
      <div class="row">
        <div class="col-sm-6">
          <?php if ($position_tlb_btm_left) { ?>
            <div class="position-container position-toolbar">
              <?php echo $position_tlb_btm_left; ?>
            </div>
          <?php } else { ?>
            <small>
              <?php echo $powered; ?>
            </small>
          <?php } ?>
        </div>
        <div class="col-sm-6 text-right">
         <?php if ($position_tlb_btm_right) { ?>
            <div class="position-container position-toolbar">
              <?php echo $position_tlb_btm_right; ?>
            </div>
          <?php } else { ?>
            <small>
              Theme by <a href="http://www.echothemes.com">EchoThemes</a>
            </small>
          <?php } ?>
        </div>
      </div>
    </div>
  </div> <!-- /.footer-toolbar -->
</footer>

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//--> 

<!-- default2 Theme created by EchoThemes (www.echothemes.com) -->

<?php if ($position_hide_blk_btm) { ?>
  <?php echo $position_hide_blk_btm; ?>
<?php } ?>
</body>
</html>
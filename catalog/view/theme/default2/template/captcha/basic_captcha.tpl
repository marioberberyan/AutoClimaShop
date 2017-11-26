<div class="form-group required">
  <?php if (substr($route, 0, 9) == 'checkout/') { ?>
    <label class="control-label" for="input-payment-captcha"><?php echo $entry_captcha; ?></label>
    <input type="text" name="captcha" id="input-payment-captcha" class="form-control" />
    <img src="index.php?route=captcha/basic_captcha/captcha" alt="" />
  <?php } elseif (substr($route, 0, 19) == 'information/contact') { ?>
    <label class="col-sm-4 control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
    <div class="col-sm-8">
      <div class="row">
        <div class="col-sm-6">
          <input type="text" name="captcha" id="input-captcha" class="form-control bs-margin-bottom-xs" />
        </div>
      </div>
      <div>
        <img src="index.php?route=captcha/basic_captcha/captcha" alt="" />
      </div>
      <?php if ($error_captcha) { ?>
        <div class="text-danger"><?php echo $error_captcha; ?></div>
      <?php } ?>
    </div>
  <?php } else { ?>
    <label class="col-md-3 control-label" for="input-captcha"><?php echo $entry_captcha; ?></label>
    <div class="col-md-9">
      <div class="row">
        <div class="col-md-4">
          <input type="text" name="captcha" id="input-captcha" class="form-control bs-margin-bottom-xs" />
        </div>
      </div>
      <div>
        <img src="index.php?route=captcha/basic_captcha/captcha" alt="" />
      </div>
      <?php if ($error_captcha) { ?>
        <div class="text-danger"><?php echo $error_captcha; ?></div>
      <?php } ?>
    </div>
  <?php } ?>
</div>

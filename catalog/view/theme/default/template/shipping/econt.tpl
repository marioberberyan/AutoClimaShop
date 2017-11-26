<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="econt_form" class="form-horizontal">
  <div class="content">
    <div>
      <div class="form-group" <?php if (!$cd) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label"><?php echo $entry_cd; ?></label>
        <div class="col-sm-10">
          <label class="radio-inline">
            <input type="radio" id="cd_yes" name="cd_payment" value="1" <?php if ($cd_payment) { ?> checked="checked"<?php } ?> />
            <?php echo $text_yes; ?>
          </label>
          <label class="radio-inline">
            <input type="radio" id="cd_no" name="cd_payment" value="0" <?php if (!$cd_payment) { ?> checked="checked"<?php } ?> />
            <?php echo $text_no; ?>
          </label>
        </div>
      </div>
      <div class="form-group" style="display: none;">
        <label class="col-sm-2 control-label"><?php echo $entry_shipping_to; ?></label>
        <div class="col-sm-10">
          <input type="radio" id="to_door" name="shipping_to" value="DOOR" <?php if ($shipping_to != 'OFFICE') { ?> checked="checked"<?php } ?> onclick="$('#econt_office_city_id,#econt_office_id,#econt_office_code,#econt_office_locator').hide(); $('#econt_post_code,#econt_city,#econt_quarter,#econt_street,#econt_street_num,#econt_other,#services_door').show();" class="form-control" class="form-control" />
          <label for="to_door"><?php echo $text_to_door; ?></label>
          <input type="radio" id="to_office" name="shipping_to" value="OFFICE" <?php if ($shipping_to == 'OFFICE') { ?> checked="checked"<?php } ?> onclick="$('#econt_office_city_id,#econt_office_id,#econt_office_code,#econt_office_locator').show();$('#econt_post_code,#econt_city,#econt_quarter,#econt_street,#econt_street_num,#econt_other,#services_door').hide();" />
          <label for="to_office"><?php echo $text_to_office; ?></label>
        </div>
      </div>
      <div class="form-group" id="econt_post_code" <?php if ($shipping_to == 'OFFICE' || !$to_door) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="post_code"><?php echo $entry_post_code; ?></label>
        <div class="col-sm-10">
          <input type="text" id="post_code" name="postcode" value="<?php echo $postcode; ?>" size="3" disabled="disabled" class="form-control" />
        </div>
      </div>
      <div class="form-group" id="econt_city" <?php if ($shipping_to == 'OFFICE' || !$to_door) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="city"><?php echo $entry_city; ?></label>
        <div class="col-sm-10">
          <input type="text" id="city" name="city" value="<?php echo $city; ?>" class="form-control" />
          <input type="hidden" id="city_id" name="city_id" value="<?php echo $city_id; ?>" class="form-control" />
        </div>
      </div>
      <div class="form-group" id="econt_quarter" <?php if ($shipping_to == 'OFFICE' || !$to_door) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="quarter"><?php echo $entry_quarter; ?></label>
        <div class="col-sm-10">
          <input type="text" id="quarter" name="quarter" value="<?php echo $quarter; ?>" class="form-control" />
        </div>
      </div>
      <div class="form-group" id="econt_street" <?php if ($shipping_to == 'OFFICE' || !$to_door) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="street"><?php echo $entry_street; ?></label>
        <div class="col-sm-10">
          <input type="text" id="street" name="street" value="<?php echo $street; ?>" class="form-control" />
        </div>
      </div>
      <div class="form-group" id="econt_street_num" <?php if ($shipping_to == 'OFFICE' || !$to_door) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="street_num"><?php echo $entry_street_num; ?></label>
        <div class="col-sm-10">
          <input type="text" id="street_num" name="street_num" value="<?php echo $street_num; ?>" class="form-control" />
        </div>
      </div>
      <div class="form-group" id="econt_other" <?php if ($shipping_to == 'OFFICE' || !$to_door) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="other"><?php echo $entry_other; ?></label>
        <div class="col-sm-10">
          <input type="text" id="other" name="other" value="<?php echo $other; ?>" class="form-control" />
            <?php if ($error_address) { ?>
            <span class="text-danger"><?php echo $error_address; ?></span>
            <?php } ?>
        </div>
      </div>
      <div class="form-group" id="econt_office_city_id" <?php if ($shipping_to != 'OFFICE' || !$to_office) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="office_city_id"><?php echo $entry_city; ?></label>
        <div class="col-sm-10">
          <select id="office_city_id" name="office_city_id" onchange="getOfficesByCityId();" class="form-control">
            <option value="0"><?php echo $text_select; ?></option>
            <?php foreach ($cities as $city) { ?>
            <?php if ($city['city_id'] == $office_city_id) { ?>
            <option value="<?php echo $city['city_id']; ?>" selected="selected"><?php echo $city['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $city['city_id']; ?>"><?php echo $city['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
      </div>
      <div class="form-group" id="econt_office_id" <?php if ($shipping_to != 'OFFICE' || !$to_office) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="office_id"><?php echo $entry_office; ?></label>
        <div class="col-sm-10">
          <select id="office_id" name="office_id" onchange="getOffice();" class="form-control">
            <option value="0"><?php echo $text_select; ?></option>
            <?php foreach ($offices as $office) { ?>
            <?php if ($office['office_id'] == $office_id) { ?>
            <option value="<?php echo $office['office_id']; ?>" selected="selected"><?php echo $office['office_code'] . ', ' . $office['name'] . ', ' . $office['address']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $office['office_id']; ?>"><?php echo $office['office_code'] . ', ' . $office['name'] . ', ' . $office['address']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
          <?php if ($error_office) { ?>
          <span class="text-danger"><?php echo $error_office; ?></span>
          <?php } ?>
        </div>
      </div>
      <div class="form-group" id="econt_office_code" <?php if ($shipping_to != 'OFFICE' || !$to_office) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="office_code"><?php echo $entry_office_code; ?></label>
        <div class="col-sm-10">
          <input type="text" id="office_code" name="office_code" value="<?php echo $office_code; ?>" size="3" disabled="disabled" class="form-control" />
        </div>
      </div>
      <div class="form-group" id="econt_office_locator" <?php if ($shipping_to != 'OFFICE' || !$to_office) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label">&nbsp;</label>
        <div class="col-sm-10">
          <a href="javascript:void(0);" id="office_locator" class="btn btn-primary" title="<?php echo $button_office_locator; ?>"><?php echo $button_office_locator; ?></a>
        </div>
      </div>
    </div>
    <div id="services_door" <?php if ($shipping_to == 'OFFICE' || !$to_door) { ?> style="display: none;"<?php } ?>>
      <div class="form-group" id="priority_time" <?php if (!$priority_time) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label">
          <input type="checkbox" id="priority_time_cb" name="priority_time_cb" value="1" <?php if ($priority_time_cb) { ?> checked="checked"<?php } ?> onclick="checkPriorityTime();" />
          <?php echo $entry_priority_time; ?>
        </label>
        <div class="col-sm-3">
          <select id="priority_time_type_id" name="priority_time_type_id" <?php if (!$priority_time_cb) { ?> disabled="disabled"<?php } ?> onchange="setPriorityTime();" class="form-control">
            <?php foreach ($priority_time_types as $priority_time_type) { ?>
            <?php if ($priority_time_type['id'] == $priority_time_type_id) { ?>
            <?php $priority_time_hours = $priority_time_type['hours']; ?>
            <option value="<?php echo $priority_time_type['id']; ?>" selected="selected"><?php echo $priority_time_type['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $priority_time_type['id']; ?>"><?php echo $priority_time_type['name']; ?> </option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="col-sm-3">
          <select id="priority_time_hour_id" name="priority_time_hour_id" <?php if (!$priority_time_cb) { ?> disabled="disabled"<?php } ?> class="form-control">
            <?php foreach ($priority_time_hours as $priority_time_hour) { ?>
            <?php if ($priority_time_hour == $priority_time_hour_id) { ?>
            <option value="<?php echo $priority_time_hour; ?>" selected="selected"><?php echo $priority_time_hour; ?> <?php echo $text_hour; ?></option>
            <?php } else { ?>
            <option value="<?php echo $priority_time_hour; ?>"><?php echo $priority_time_hour; ?> <?php echo $text_hour; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="col-sm-3">
          <?php if ($error_priority_time) { ?>
          <span class="text-danger"><?php echo $error_priority_time; ?></span>
          <?php } ?>
        </div>
      </div>
      <div class="form-group" id="express_city_courier" <?php if (!$express_city_courier) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label">
          <input type="checkbox" id="express_city_courier_cb" name="express_city_courier_cb" value="1" <?php if ($express_city_courier_cb) { ?> checked="checked"<?php } ?> onclick="checkExpressCityCourier();" />
          <?php echo $entry_express_city_courier; ?>
        </label>
        <div class="col-sm-3">
          <input type="radio" id="express_city_courier_e1" name="express_city_courier_e" value="e1" <?php if ($express_city_courier_e == 'e1') { ?> checked="checked"<?php } ?> <?php if (!$express_city_courier_cb) { ?> disabled="disabled"<?php } ?> class="radio-inline" />
          <label class="control-label" for="express_city_courier_e1"><?php echo $text_e1; ?></label>
        </div>
        <div class="col-sm-3">
          <input type="radio" id="express_city_courier_e2" name="express_city_courier_e" value="e2" <?php if ($express_city_courier_e == 'e2') { ?> checked="checked"<?php } ?> <?php if (!$express_city_courier_cb) { ?> disabled="disabled"<?php } ?> class="radio-inline" />
          <label class="control-label" for="express_city_courier_e2"><?php echo $text_e2; ?></label>
        </div>
        <div class="col-sm-3">
          <input type="radio" id="express_city_courier_e3" name="express_city_courier_e" value="e3" <?php if ($express_city_courier_e == 'e3') { ?> checked="checked"<?php } ?> <?php if (!$express_city_courier_cb) { ?> disabled="disabled"<?php } ?> class="radio-inline" />
          <label class="control-label" for="express_city_courier_e3"><?php echo $text_e3; ?></label>
        </div>
      </div>
    </div>
    <div>
      <div class="form-group" <?php if (!$delivery_day || !$delivery_days && !$error_delivery_day) { ?> style="display: none;"<?php } ?>>
        <label class="col-sm-2 control-label" for="delivery_day_id"><?php echo $entry_delivery_day; ?></label>
        <div class="col-sm-10">
          <select id="delivery_day_id" name="delivery_day_id" onchange="changeDeliveryDay(true);" class="form-control">
            <?php foreach ($delivery_days as $delivery_day) { ?>
            <?php if ($delivery_day['id'] == $delivery_day_id) { ?>
            <option value="<?php echo $delivery_day['id']; ?>" selected="selected"><?php echo $delivery_day['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $delivery_day['id']; ?>"><?php echo $delivery_day['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
          <?php if ($error_delivery_day) { ?>
          <span class="text-danger"><?php echo $error_delivery_day; ?></span>
          <?php } ?>
        </div>
      </div>
    </div>
  </div>
  <div class="content">
    <?php if ($dc) { ?>
    <p><i><?php echo $text_dc; ?></i></p>
    <?php } ?>
    <?php if ($dc_cp) { ?>
    <p><i><?php echo $text_dc_cp; ?></i></p>
    <?php } ?>
    <?php if ($invoice_before_cd) { ?>
    <p><i><?php echo $text_invoice_before_cd; ?></i></p>
    <?php } ?>
    <?php if ($pay_after_accept) { ?>
    <p><i><?php echo $text_pay_after_accept; ?></i></p>
    <?php } ?>
    <?php if ($pay_after_test) { ?>
    <p><i><?php echo $text_pay_after_test; ?></i></p>
    <?php } ?>
    <?php if ($instruction_shipping_returns) { ?>
    <p><i><?php echo $text_instruction_shipping_returns; ?></i></p>
    <?php } ?>
    <?php if ($instruction_returns) { ?>
    <p><i><?php echo $text_instruction_returns; ?></i></p>
    <?php } ?>
    <?php if ($partial_delivery) { ?>
    <p><b><?php echo $text_partial_delivery; ?></b></p>
    <?php } ?>
  </div>
</form>

<script src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/jquery/magnific/magnific-popup.css" rel="stylesheet">

<script type="text/javascript"><!--
	function receiveMessage(event) {
		if (event.origin !== '<?php echo $office_locator_domain; ?>')
			return;

		message_array = event.data.split('||');
		getOfficeByOfficeCode(message_array[0]);
		$.magnificPopup.close();
	}

	if (window.addEventListener) {
		window.addEventListener('message', receiveMessage, false);
	} else if (window.attachEvent) {
		window.attachEvent('onmessage', receiveMessage);
	}

	$(document).ready(function() {
		if ($('#office_city_id').val()) {
			url = '<?php echo $office_locator; ?>&address=' + $('#office_city_id option:selected').text();
		} else {
			url = '<?php echo $office_locator; ?>';
		}

		$('#office_locator').magnificPopup({
			type: 'iframe',
			  iframe: {
				patterns: {
				  bgmaps: {				   
					index: 'javascript:void(0);',					
					src: url					
				  }
				}
			  }
		 });

		$('#office_city_id').change(function () {
			if ($('#office_city_id').val()) {
				url = '<?php echo $office_locator; ?>&address=' + $('#office_city_id option:selected').text();
			} else {
				url = '<?php echo $office_locator; ?>';
			}

			$('#office_locator').magnificPopup({
				type: 'iframe',
				  iframe: {
					patterns: {
					  bgmaps: {				   
						index: 'javascript:void(0);',					
						src: url					
					  }
					}
				  }
			 });
		});
	});

	function getOfficeByOfficeCode(office_code) {
		if (parseInt(office_code)) {
			$.ajax({
				url: 'index.php?route=shipping/econt/getOfficeByOfficeCode',
				type: 'POST',
				data: 'office_code=' + parseInt(office_code),
				dataType: 'json',
				success: function(data) {
					if (!data.error) {
						$('#office_city_id').val(data.city_id);
						html = '<option value="0"><?php echo $text_select; ?></option>';

						for (i = 0; i < data.offices.length; i++) {
							html += '<option ';
							if (data.offices[i]['office_id'] == data.office_id) {
								html += 'selected="selected"';
							}
							html += 'value="' + data.offices[i]['office_id'] + '">' + data.offices[i]['office_code'] + ', ' + data.offices[i]['name'] + ', ' + data.offices[i]['address'] +  '</option>';
						}

						$('#office_id').html(html);
						$('#office_code').val(office_code);
					}
				}
			});
		}
	}
//--></script>
<script type="text/javascript"><!--
var priority_time = '<?php echo $priority_time; ?>';

$(document).ready(function() {
	if ($('#delivery_day_id').is(':visible')) {
		changeDeliveryDay(false);
	}

	$('#cd_yes').click(function() {
		$('[name="payment_method"][value="econt_cod"]').attr('checked', true);
		$('[name="payment_method"][value="econt_cod"]').parent().parent().show();
		$('[name="payment_method"][value!="econt_cod"]').parent().parent().hide();

		econtSubmit(false);
	});

	$('#cd_no').click(function() {
		$('[name="payment_method"][value="econt_cod"]').attr('checked', false);
		$('[name="payment_method"][value="econt_cod"]').parent().parent().hide();
		$('[name="payment_method"][value!="econt_cod"]').parent().parent().show();

		econtSubmit(false);
	});

	if ($('#cd_yes:checked').length) {
		$('[name="payment_method"][value="econt_cod"]').attr('checked', true);
		$('[name="payment_method"][value="econt_cod"]').parent().parent().show();
		$('[name="payment_method"][value!="econt_cod"]').parent().parent().hide();
	} else {
		$('[name="payment_method"][value="econt_cod"]').attr('checked', false);
		$('[name="payment_method"][value="econt_cod"]').parent().parent().hide();
		$('[name="payment_method"][value!="econt_cod"]').parent().parent().show();
	}
});


$('#button-shipping-method').off();
$('#button-shipping-method').on('click', function() {
	if ($('[name="shipping_method"][value^="econt."]:checked').length) {
		econtSubmit(true);
	} else {
		econtShipping(true);
	}
	return false;
});


function econtSubmit(next_step) {
	$('.wait').remove();
	$('#econt_form').prepend('<div class="wait"><img src="catalog/view/theme/default/image/loading.gif" alt="" /></div>');
	econt_disabled = $('#econt_form :input :disabled');
	$('#econt_form :input').removeAttr('disabled');

	$.ajax({
		url: 'index.php?route=shipping/econt',
		type: 'POST',
		data: $('#econt_form').serialize() + '&next_step=' + (next_step ? 1 : 0),
		dataType: 'json',
		complete: function() {
			econt_disabled.attr('disabled', true);
		},
		success: function(json) {
			if (json) {
				if (json.redirect) {
					location = json.redirect;
				} else if (json.submit) {
					econtShipping(next_step);
				} else {
					$('#econt').html(json.html);
				}
			}
		}
	});
}

function econtShipping(next_step) {
    $.ajax({
        url: 'index.php?route=checkout/shipping_method/save',
        type: 'post',
        data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-shipping-method').button('loading');
		},  
        complete: function() {
			$('#button-shipping-method').button('reset');
        },          
        success: function(json) {
            $('.wait').remove();
            $('.alert, .text-danger').remove();
            
            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
                    $('#collapse-shipping-method .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                }           
            } else {
				$('#econt_form').prepend('<div class="wait"><img src="catalog/view/theme/default/image/loading.gif" alt="" /></div>');

				$.ajax({
					url: 'index.php?route=checkout/shipping_method',
					dataType: 'html',
					success: function(html) {
						$('.wait').remove();
						$('#collapse-shipping-method .panel-body').html(html);

						if (next_step) {
							$.ajax({
								url: 'index.php?route=checkout/payment_method',
								dataType: 'html',
								success: function(html) {
									$('#collapse-payment-method .panel-body').html(html);
									
									$('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');
									
									$('a[href=\'#collapse-payment-method\']').trigger('click');
									
									$('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
								}
							});
						}
					}
				});
            }
        }
    });
}

function getOfficesByCityId() {
	$('#office_id').html('<option value="0"><?php echo $text_wait; ?></option>');
	$('#office_code').val('');

	$.ajax({
		url: 'index.php?route=shipping/econt/getOfficesByCityId',
		type: 'POST',
		data: 'city_id=' + encodeURIComponent($('#office_city_id').val()),
		dataType: 'json',
		success: function(data) {
			if (data) {
				html = '<option value="0"><?php echo $text_select; ?></option>';

				for (i = 0; i < data.length; i++) {
					html += '<option value="' + data[i]['office_id'] + '">' + data[i]['office_code'] + ', ' + data[i]['name'] + ', ' + data[i]['address'] +  '</option>';
				}

				$('#office_id').html(html);

				<?php if (!$office_calculated) { ?>
				econtSubmit(false);
				<?php } ?>
			}
		}
	});
}

function getOffice() {
	$('#office_code').val('');

	$.ajax({
		url: 'index.php?route=shipping/econt/getOffice',
		type: 'POST',
		data: 'office_id=' + encodeURIComponent($('#office_id').val()),
		dataType: 'json',
		success: function(data) {
			if (data && data.office_code) {
				$('#office_code').val(data.office_code);
			}
		}
	});
}

function checkPriorityTime() {
	if ($('#priority_time_cb:checked').length) {
		$('#priority_time_type_id').removeAttr('disabled');
		$('#priority_time_hour_id').removeAttr('disabled');
	} else {
		$('#priority_time_type_id').attr('disabled', 'disabled');
		$('#priority_time_hour_id').attr('disabled', 'disabled');
	}

	econtSubmit(false);
}

function setPriorityTime() {
	var type = $('#priority_time_type_id').val();
	var hour = $('#priority_time_hour_id').val();

	var html = '<option value="10">10</option>';
	html += '<option value="11">11</option>';
	html += '<option value="12">12</option>';
	html += '<option value="13">13</option>';
	html += '<option value="14">14</option>';
	html += '<option value="15">15</option>';
	html += '<option value="16">16</option>';
	html += '<option value="17">17</option>';

	if (type == 'BEFORE') {
		$('#priority_time_hour_id').html(html + '<option value="18">18</option>');
	} else if (type == 'IN') {
		$('#priority_time_hour_id').html('<option value="9">9</option>' + html + '<option value="18">18</option>');
	} else if (type == 'AFTER') {
		$('#priority_time_hour_id').html('<option value="9">9</option>' + html);
	}

	$('#priority_time_hour_id').val(hour).attr('selected', 'selected');
}

function checkExpressCityCourier() {
	if ($('#express_city_courier_cb:checked').length) {
		$('#express_city_courier_e1').removeAttr('disabled');
		$('#express_city_courier_e2').removeAttr('disabled');
		$('#express_city_courier_e3').removeAttr('disabled');
	} else {
		$('#express_city_courier_e1').attr('disabled', 'disabled');
		$('#express_city_courier_e2').attr('disabled', 'disabled');
		$('#express_city_courier_e3').attr('disabled', 'disabled');
	}

	econtSubmit(false);
}

function changeDeliveryDay(econt_submit) {
	if ($('#delivery_day_id').val() == '<?php echo $priority_date; ?>') {
		$('#priority_time').show();

		if (!$('#priority_time_cb:checked').length) {
			$('#priority_time_cb').attr('checked', true);
			$('#priority_time_type_id').removeAttr('disabled');
			$('#priority_time_type_id').val('BEFORE').attr('selected', 'selected');
			$('#priority_time_hour_id').removeAttr('disabled');
			$('#priority_time_hour_id').val('13');
		}
	} else {
		if (!parseInt(priority_time)) {
			$('#priority_time').hide();
		}

		$('#priority_time_cb').attr('checked', false);
		$('#priority_time_type_id').attr('disabled', 'disabled');
		$('#priority_time_hour_id').attr('disabled', 'disabled');
	}

	if (econt_submit) {
		econtSubmit(false);
	}
}
//--></script>

<script type="text/javascript"><!--
$(document).ready(function() {
	var sender_post_code = '<?php echo $sender_post_code; ?>';
	var econt_city = '<?php echo $city; ?>';
	var econt_quarter = '<?php echo $quarter; ?>';
	var econt_street = '<?php echo $street; ?>';

	$('#city').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=shipping/econt/getCitiesByName&filter_name=' + encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label:     item['post_code'] + ' ' + item['name'],
							value:     item['post_code'] + ' ' + item['name'],
							name:      item['name'],
							city_id:   item['city_id'],
							post_code: item['post_code']
						}
					}));
				}
			});
		},
		'select': function(item) {
			if (item) {
				econt_city = item.name;
				$('#city').val(item.name);
				$('#city_id').val(item.city_id);
				$('#post_code').val(item.post_code);
				$('#quarter').val('');
				$('#street').val('');
				$('#street_num').val('');
				$('#other').val('');

				if (item.post_code == sender_post_code) {
					$('#express_city_courier').show();
				} else {
					$('#express_city_courier').hide();
				}

				econtSubmit(false);
			}
		},
		'change': function(item) {
			if(!item) {
				$('#city').val('');
				$('#city_id').val('');
				$('#post_code').val('');
			}

			$('#quarter').val('');
			$('#street').val('');
			$('#street_num').val('');
			$('#other').val('');

			$('#express_city_courier').hide();
		}
	});

	$('#city').blur(function() {
		if ($(this).val() != econt_city) {
			$(this).val('');
			$('#city_id').val('');
			$('#post_code').val('');
			$('#quarter').val('');
			$('#street').val('');
			$('#street_num').val('');
			$('#other').val('');

			$('#express_city_courier').hide();
		}
	});

	$('#quarter').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=shipping/econt/getQuartersByName&filter_name=' +  encodeURIComponent(request) + '&city_id=' +  encodeURIComponent($('#city_id').val()),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['name']
						}
					}));
				}
			});
		},
		'select': function(item) {
			if (item) {
				econt_quarter = item.label;
				$('#quarter').val(item['label']);
			}
		},
		'change': function(item) {
			if(!item) {
				$('#quarter').val('');
			}
		}
	});

	$('#quarter').blur(function() {
		if ($(this).val() != econt_quarter) {
			$('#quarter').val('');
		}
	});

	$('#street').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=shipping/econt/getStreetsByName&filter_name=' +  encodeURIComponent(request) + '&city_id=' +  encodeURIComponent($('#city_id').val()),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label: item['name'],
							value: item['name']
						}
					}));
				}
			});
		},
		'select': function(item) {
			if (item) {
				econt_street = item.label;
				$('#street').val(item['label']);
			}
		},
		'change': function(item) {
			if(!item) {
				$('#street').val('');
			}
		}
	});

	$('#street').blur(function() {
		if ($(this).val() != econt_street) {
			$('#street').val('');
		}
	});
});
//--></script>
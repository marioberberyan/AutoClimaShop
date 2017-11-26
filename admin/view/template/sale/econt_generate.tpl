<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <a onclick="$('#form-econt :input').removeAttr('disabled'); $('#form-econt').submit();" class="btn btn-primary"><?php echo $button_generate; ?></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">  
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
     <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
	 <div class="panel-heading">
		<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
     </div>
     <div class="panel-body">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-econt" class="form-horizontal">
        <div class="panel-body">
          <div class="form-group">
            <div class="col-sm-3"></div>
            <div class="col-sm-9"><h3><?php echo $entry_receiver_address; ?></h3></div>
          </div>
          <div class="form-group" <?php if (!$receiver_address['to_door'] || !$receiver_address['to_office']) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label"><?php echo $text_receiver_shipping_to; ?></label>
            <div class="col-sm-9">
              <label class="radio-inline" style="display: inline; width: auto; float: none;">
                <input type="radio" id="to_door" name="shipping_to" value="DOOR" <?php if ($receiver_address['shipping_to'] != 'OFFICE') { ?>checked="checked"<?php } ?> onclick="$('#econt_office_city_id,#econt_office_id,#econt_office_code,#econt_office_locator').hide();$('#econt_post_code,#econt_city,#econt_quarter,#econt_street,#econt_street_num,#econt_other,#services_door').show();" />
                <?php echo $text_to_door; ?>
              </label>              
              <label class="radio-inline" style="display: inline; width: auto; float: none;">
                <input type="radio" id="to_office" name="shipping_to" value="OFFICE" <?php if ($receiver_address['shipping_to'] == 'OFFICE') { ?>checked="checked"<?php } ?> onclick="$('#econt_office_city_id,#econt_office_id,#econt_office_code,#econt_office_locator').show();$('#econt_post_code,#econt_city,#econt_quarter,#econt_street,#econt_street_num,#econt_other,#services_door').hide();" />
                <?php echo $text_to_office; ?>
              </label>
            </div>
          </div>
          <div class="form-group" id="econt_post_code" <?php if ($receiver_address['shipping_to'] == 'OFFICE' || !$receiver_address['to_door']) { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="post_code"><?php echo $text_receiver_postcode; ?></label>
            <div class="col-sm-9">
			  <input class="form-control" type="text" id="post_code" name="post_code" value="<?php echo $receiver_address['post_code']; ?>" size="3" readonly="readonly" />
			</div>
          </div>
          <div class="form-group" id="econt_city" <?php if ($receiver_address['shipping_to'] == 'OFFICE' || !$receiver_address['to_door']) { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="city"><?php echo $text_receiver_city; ?></label>
            <div class="col-sm-9">
			  <input class="form-control" type="text" id="city" name="city" value="<?php echo $receiver_address['city']; ?>" />
              <input class="form-control" type="hidden" id="city_id" name="city_id" value="<?php echo $receiver_address['city_id']; ?>" />
			</div>
          </div>
          <div class="form-group" id="econt_quarter" <?php if ($receiver_address['shipping_to'] == 'OFFICE' || !$receiver_address['to_door']) { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="quarter"><?php echo $text_receiver_quarter; ?></label>
            <div class="col-sm-9">
			  <input class="form-control" type="text" id="quarter" name="quarter" value="<?php echo $receiver_address['quarter']; ?>" />
			</div>
          </div>
          <div class="form-group" id="econt_street" <?php if ($receiver_address['shipping_to'] == 'OFFICE' || !$receiver_address['to_door']) { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="street"><?php echo $text_receiver_street; ?></label>
            <div class="col-sm-9">
			  <input class="form-control" type="text" id="street" name="street" value="<?php echo $receiver_address['street']; ?>" />
			</div>
          </div>
          <div class="form-group" id="econt_street_num" <?php if ($receiver_address['shipping_to'] == 'OFFICE' || !$receiver_address['to_door']) { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="street_num"><?php echo $text_receiver_street_num; ?></label>
            <div class="col-sm-9">
			  <input class="form-control" type="text" id="street_num" name="street_num" value="<?php echo $receiver_address['street_num']; ?>" />
			</div>
          </div>
          <div class="form-group" id="econt_other" <?php if ($receiver_address['shipping_to'] == 'OFFICE' || !$receiver_address['to_door']) { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="other"><?php echo $text_receiver_other; ?></label>
            <div class="col-sm-9">
			  <input class="form-control" type="text" id="other" name="other" value="<?php echo $receiver_address['other']; ?>" />
              <?php if ($error_receiver_address) { ?>
              <br />&nbsp;&nbsp;&nbsp;<span class="text-danger"><?php echo $error_receiver_address; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="form-group" id="econt_office_city_id" <?php if ($receiver_address['shipping_to'] != 'OFFICE' || !$receiver_address['to_office']) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="office_city_id"><?php echo $text_receiver_city; ?></label>
            <div class="col-sm-9">
			  <select class="form-control" id="office_city_id" name="office_city_id" onchange="getOfficesByCityId();">
				<option value="0"><?php echo $text_select; ?></option>
				<?php foreach ($receiver_address['cities'] as $city) { ?>
				<?php if (isset($receiver_address['office_city_id']) && $city['city_id'] == $receiver_address['office_city_id']) { ?>
				<option value="<?php echo $city['city_id']; ?>" selected="selected"><?php echo $city['name']; ?>	</option>
				<?php } else { ?>
				<option value="<?php echo $city['city_id']; ?>"><?php echo $city['name']; ?></option>
				<?php } ?>
				<?php } ?>
              </select>
			</div>
          </div>
          <div class="form-group" id="econt_office_id" <?php if ($receiver_address['shipping_to'] != 'OFFICE' || !$receiver_address['to_office']) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="office_id"><?php echo $text_receiver_office; ?></label>
            <div class="col-sm-9">
			  <select class="form-control" id="office_id" name="office_id" onchange="getOffice();">
				<option value="0"><?php echo $text_select; ?></option>
				<?php foreach ($receiver_address['offices'] as $office) { ?>
				<?php if ($office['office_id'] == $receiver_address['office_id']) { ?>
				<option value="<?php echo $office['office_id']; ?>" selected="selected"><?php echo $office['office_code'] . ', ' .  $office['name'] . ', ' . $office['address']; ?></option>
				<?php } else { ?>
				<option value="<?php echo $office['office_id']; ?>"><?php echo $office['office_code'] . ', ' .  $office['name'] . ', ' . $office['address']; ?></option>
				<?php } ?>
				<?php } ?>
			  </select>
			  <?php if ($error_receiver_office) { ?>
			  <br />&nbsp;&nbsp;&nbsp;<span class="text-danger"><?php echo $error_receiver_office; ?></span>
			  <?php } ?>
            </div>
          </div>
          <div class="form-group" id="econt_office_code" <?php if ($receiver_address['shipping_to'] != 'OFFICE' || !$receiver_address[ 'to_office']) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="office_code"><?php echo $text_receiver_office_code; ?></label>
            <div class="col-sm-9">
			  <input class="form-control" type="text" id="office_code" name="office_code" value="<?php echo $receiver_address['office_code']; ?>" size="3" readonly="readonly" />
			</div>
          </div>
          <div class="form-group" id="econt_office_locator" <?php if ($receiver_address['shipping_to'] != 'OFFICE' || !$receiver_address['to_office']) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label">&nbsp;</label>
            <div class="col-sm-9">
			  <a href="javascript:void(0);" id="office_locator" class="btn btn-primary"><span><?php echo $button_office_locator; ?></span></a>
			</div>
          </div>
          <div class="form-group">
            <div class="col-sm-3"></div>
            <div class="col-sm-9"><h3><?php echo $entry_sender_data; ?></h3></div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="address_id"><?php echo $entry_address; ?></label>
			<div class="col-sm-9">
              <select class="form-control" id="address_id" name="address_id" onchange="displayExpressCityCourier();">
				<?php foreach ($addresses as $address) { ?>
				<?php if ($address['address_id'] == $address_id) { ?>
				<option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['name']; ?></option>
				<?php } else { ?>
				<option value="<?php echo $address['address_id']; ?>"><?php echo $address['name']; ?></option>
				<?php } ?>
				<?php } ?>
              </select>
              <?php if ($error_address) { ?>
              <span class="text-danger"><?php echo $error_address; ?></span>
              <?php } ?>
			</div>
          </div>
          <?php if ($products_weight) { ?>
          <div class="form-group">
            <label class="col-sm-3 control-label"><?php echo $entry_products_weight; ?></label>
            <div class="col-sm-9">
			  <?php foreach ($products_weight as $product_weight) { ?>
              [ <a href="<?php echo $product_weight['href']; ?>" target="_blank"><?php echo $product_weight['text'];   ?></a> ]
              <?php } ?>
              <?php if ($error_products_weight) { ?>
              <span class="text-danger"><?php echo $error_products_weight; ?></span>
              <?php } ?>
			</div>
          </div>
          <?php } ?>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="sms"><?php echo $entry_sms; ?></label>
            <div class="col-sm-9">
			  <select class="form-control" id="sms" name="sms" onchange="$('#sms_num').toggle();">
				<?php if ($sms) { ?>
				<option value="1" selected="selected"><?php echo $text_yes; ?></option>
				<option value="0"><?php echo $text_no; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_yes; ?></option>
				<option value="0" selected="selected"><?php echo $text_no; ?></option>
				<?php } ?>
			  </select>
			  <span id="sms_num" <?php if (!$sms) { ?> style="display: none;"<?php } ?>>
				<label for="sms_no"><?php echo $entry_sms_no; ?></label>
				<input class="form-control" type="text" id="sms_no" name="sms_no" value="<?php echo $sms_no; ?>" />
				<?php if ($error_sms) { ?>
				<span class="text-danger"><?php echo $error_sms; ?></span>
				<?php } ?>
              </span>
			</div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="invoice_before_cd"><?php echo $entry_invoice_before_cd; ?></label>
            <div class="col-sm-9">
			  <select class="form-control" id="invoice_before_cd" name="invoice_before_cd">
				<?php if ($invoice_before_cd) { ?>
				<option value="1" selected="selected"><?php echo $text_yes; ?></option>
				<option value="0"><?php echo $text_no; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_yes; ?></option>
				<option value="0" selected="selected"><?php echo $text_no; ?></option>
				<?php } ?>
              </select>
			</div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="dc"><?php echo $entry_dc; ?></label>
            <div class="col-sm-9"> 
			  <select class="form-control" id="dc" name="dc" onchange="if ($(this).val() == 1) { $('#dc_cp').val('0').attr('selected', 'selected'); }">
				<?php if ($dc) { ?>
				<option value="1" selected="selected"><?php echo $text_yes; ?></option>
				<option value="0"><?php echo $text_no; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_yes; ?></option>
				<option value="0" selected="selected"><?php echo $text_no; ?></option>
				<?php } ?>
              </select>
			</div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="dc_cp"><?php echo $entry_dc_cp; ?></label>
            <div class="col-sm-9"> 
			  <select class="form-control" id="dc_cp" name="dc_cp" onchange="if ($(this).val() == 1) { $('#dc').val('0').attr('selected', 'selected'); }">
				<?php if ($dc_cp) { ?>
				<option value="1" selected="selected"><?php echo $text_yes; ?></option>
				<option value="0"><?php echo $text_no; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_yes; ?></option>
				<option value="0" selected="selected"><?php echo $text_no; ?></option>
				<?php } ?>
              </select>
			</div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label"><?php echo $entry_disposition; ?></label>
            <div class="col-sm-9"> 
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="pay_after_accept" name="pay_after_accept" value="1" <?php if ($pay_after_accept) { ?> checked="checked"<?php } ?> onclick="$('#pay_after_test').attr('checked', false);" />
                  <?php echo $entry_pay_after_accept; ?>
                </label>
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="pay_after_test" name="pay_after_test" value="1" <?php if ($pay_after_test) { ?> checked="checked"<?php } ?> onclick="$('#pay_after_accept').attr('checked', false);" />
                  <?php echo $entry_pay_after_test; ?>
                </label>
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="instruction_shipping_returns" name="instruction_returns" value="shipping_returns" <?php if ($instruction_returns == 'shipping_returns') { ?> checked="checked"<?php } ?> onclick="$('#instruction_returns').attr('checked', false);" />
                  <?php echo $entry_instruction_shipping_returns; ?>
                </label>
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="instruction_returns" name="instruction_returns" value="returns" <?php if ($instruction_returns == 'returns') { ?> checked="checked"<?php } ?> onclick="$('#instruction_shipping_returns').attr('checked', false);" />
                  <?php echo $entry_instruction_returns; ?>
                </label>
              </div>
			</div>
          </div>
        </div>
        <div class="panel-body" id="services_door" <?php if ($receiver_address['shipping_to'] == 'OFFICE' || !$receiver_address['to_door']) { ?> style="display: none;"<?php } ?>>
          <div class="form-group">
            <label class="col-sm-3 control-label">
              <input type="checkbox" id="priority_time_cb" name="priority_time_cb" value="1" <?php if ($priority_time_cb) { ?> checked="checked"<?php } ?> onclick="checkPriorityTime();" />
              <?php echo $entry_priority_time; ?>
            </label>
            <div class="col-sm-3">
              <select class="form-control" id="priority_time_type_id" name="priority_time_type_id" <?php if (!$priority_time_cb) { ?> disabled="disabled"<?php } ?> onchange="setPriorityTime();">
                <?php foreach ($priority_time_types as $priority_time_type) { ?>
                <?php if ($priority_time_type['id'] == $priority_time_type_id) { ?>
                <?php $priority_time_hours = $priority_time_type['hours']; ?>
                <option value="<?php echo $priority_time_type['id']; ?>" selected="selected"><?php echo $priority_time_type['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $priority_time_type['id']; ?>"><?php echo $priority_time_type['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
            <div class="col-sm-3">
              <select class="form-control" id="priority_time_hour_id" name="priority_time_hour_id" <?php if (!$priority_time_cb) { ?> disabled="disabled"<?php } ?>>
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
            <div class="col-sm-3 control-label">
			  <input class="form-control" style="display: inline;" type="checkbox" id="express_city_courier_cb" name="express_city_courier_cb" value="1" <?php if ($express_city_courier_cb) { ?> checked="checked"<?php } ?> onclick="checkExpressCityCourier();" />
              <label for="express_city_courier_cb"><?php echo $entry_express_city_courier; ?></label>
			</div>
            <div class="col-sm-9">
			  <input class="form-control" style="display: inline;" type="radio" id="express_city_courier_e1" name="express_city_courier_e" value="e1" <?php if ($express_city_courier_e == 'e1') { ?> checked="checked"<?php } ?> <?php if (!$express_city_courier_cb) { ?> disabled="disabled"<?php } ?> />
              <label for="express_city_courier_e1"><?php echo $text_e1; ?></label><br/>
              <input class="form-control" style="display: inline;" type="radio" id="express_city_courier_e2" name="express_city_courier_e" value="e2" <?php if ($express_city_courier_e == 'e2') { ?> checked="checked"<?php } ?> <?php if (!$express_city_courier_cb) { ?> disabled="disabled"<?php } ?> />
              <label for="express_city_courier_e2"><?php echo $text_e2; ?></label><br/>
              <input class="form-control" style="display: inline;" type="radio" id="express_city_courier_e3" name="express_city_courier_e" value="e3" <?php if ($express_city_courier_e == 'e3') { ?> checked="checked"<?php } ?> <?php if (!$express_city_courier_cb) { ?> disabled="disabled"<?php } ?> />
              <label for="express_city_courier_e3"><?php echo $text_e3; ?></label>
			</div>
          </div>
        </div>
		<div class="panel-body">
          <div class="form-group" <?php if (!$delivery_days) { ?> style="display: none;"<?php } ?>>
            <div class="col-sm-3 control-label">
			  <input class="form-control" style="display: inline;" type="checkbox" id="delivery_day_cb" name="delivery_day_cb" value="1" <?php if ($delivery_day_cb) { ?> checked="checked"<?php } ?> onclick="checkDeliveryDay();" />
              <label for="delivery_day_cb"><?php echo $entry_delivery_day; ?></label>
			</div>
            <div class="col-sm-9">
			  <select class="form-control" id="delivery_day_id" name="delivery_day_id" <?php if (!$delivery_day_cb) { ?> disabled="disabled"<?php } ?> onchange="changeDeliveryDay();">
				<?php foreach ($delivery_days as $delivery_day) { ?>
				<?php if ($delivery_day['id'] == $delivery_day_id) { ?>
				<option value="<?php echo $delivery_day['id']; ?>" selected="selected"><?php echo $delivery_day[	'name']; ?></option>
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
          <div class="form-group">
            <label class="col-sm-3 control-label" for="pack_count"><?php echo $entry_pack_count; ?></label>
            <div class="col-sm-9">
			  <input class="form-control" type="text" id="pack_count" name="pack_count" value="<?php echo $pack_count; ?>" />
			</div>
          </div>
          <div class="form-group" <?php if ($products_count <= 1) { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="partial_delivery"><?php echo $entry_partial_delivery; ?></label>
            <div class="col-sm-9">
			  <select class="form-control" id="partial_delivery" name="partial_delivery" onchange="$('#pd_instruction').toggle();">
				<?php if ($partial_delivery) { ?>
				<option value="1" selected="selected"><?php echo $text_yes; ?></option>
				<option value="0"><?php echo $text_no; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_yes; ?></option>
				<option value="0" selected="selected"><?php echo $text_no; ?></option>
				<?php } ?>
              </select>
			  <input class="form-control" type="hidden" name="products_count" value="<?php echo $products_count; ?>" />
			</div>
          </div>
          <div class="form-group" id="pd_instruction" <?php if (!$partial_delivery || $products_count <= 1) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="partial_delivery_instruction"><?php echo $entry_partial_delivery_instruction; ?></label>
            <div class="col-sm-9">
			  <select class="form-control" id="partial_delivery_instruction" name="partial_delivery_instruction">
				<?php foreach ($partial_delivery_instructions as $value) { ?>
				<?php if ($value['code'] == $partial_delivery_instruction) { ?>
				<option value="<?php echo $value['code']; ?>" selected="selected"><?php echo $value['title']; ?></option>
				<?php } else { ?>
				<option value="<?php echo $value['code']; ?>"><?php echo $value['title']; ?></option>
				<?php } ?>
				<?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group" >
            <label class="col-sm-3 control-label" for="inventory"><?php echo $entry_inventory; ?></label>
            <div class="col-sm-9">
			  <select class="form-control" id="inventory" name="inventory" onchange="$('#inventory_types').toggle();">
				<?php if ($inventory) { ?>
				<option value="1" selected="selected"><?php echo $text_yes; ?></option>
				<option value="0"><?php echo $text_no; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_yes; ?></option>
				<option value="0" selected="selected"><?php echo $text_no; ?></option>
				<?php } ?>
              </select>
			</div>
          </div>
          <div class="form-group" id="inventory_types" <?php if (!$inventory) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="inventory_type"><?php echo $entry_inventory_type; ?></label>
            <div class="col-sm-9">
			  <select class="form-control" id="inventory_type" name="inventory_type" onchange="displayInventoryType();">
                <?php foreach ($inventory_types as $value) { ?>
                <?php if ($value['code'] == $inventory_type) { ?>
				<option value="<?php echo $value['code']; ?>" selected="selected"><?php echo $value['title']; ?>	</option>
				<?php } else { ?>
				<option value="<?php echo $value['code']; ?>"><?php echo $value['title']; ?></option>
				<?php } ?>
				<?php } ?>
              </select>
			  <span id="inventory_type_loading" <?php if ($inventory_type != 'LOADING') { ?>style="display: none;"<?php } ?>><?php echo $text_loading_note; ?></span>
              <table class="table table-bordered table-hover" id="inventory_type_digital" style="margin-top: 10px; margin-bottom: 0; <?php if ($inventory && $inventory_type != 'DIGITAL') { ?>display: none;<?php } ?>">
                <thead>
                  <tr>
					<td><?php echo $entry_product_id; ?></td>
					<td><?php echo $entry_product_name; ?></td>
					<td><?php echo $entry_product_weight; ?></td>
					<td><?php echo $entry_product_price; ?></td>
					<td>&nbsp;</td>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
					<td colspan="4">&nbsp;</td>
					<td class="left"><a onclick="addProduct();" class="btn btn-primary"><span><?php echo $button_add; ?></span></a></td>
                  </tr>
                </tfoot>
                <tbody id="products">
                  <?php $product_row = 0; ?>
                  <?php foreach ($products as $product) { ?>
                  <tr id="product_<?php echo $product_row; ?>">
                    <td class="left"><input class="form-control" type="text" id="product_id_<?php echo $product_row; ?>" name="products[<?php echo $product_row; ?>][product_id]" value="<?php echo $product['product_id']; ?>" size="3" /></td>
                    <td class="left"><input class="form-control" type="text" id="product_name_<?php echo $product_row; ?>" name="products[<?php echo $product_row; ?>][name]" value="<?php echo $product['name']; ?>" size="50" /></td>
                    <td class="left"><input class="form-control" type="text" id="product_weight_<?php echo $product_row; ?>" name="products[<?php echo $product_row; ?>][weight]" value="<?php echo $product['weight']; ?>" size="10" /></td>
                    <td class="left"><input class="form-control" type="text" id="product_price_<?php echo $product_row; ?>" name="products[<?php echo $product_row; ?>][price]" value="<?php echo $product['price']; ?>" size="10" /></td>
                    <td class="left"><a onclick="$('#product_<?php echo $product_row; ?>').remove();" class="btn btn-primary"><span><?php echo $button_remove; ?></span></a></td>
                  </tr>
                  <?php $product_row++; ?>
                  <?php } ?>
                </tbody>
              </table>
            </div>
          </div>
		  <div class="form-group">
            <label class="col-sm-3 control-label" for="instruction" class="control-label"><span data-toggle="tooltip" title="<?php echo $help_entry_instructions; ?>"><?php echo $entry_instructions; ?></span></label>
            <div class="col-sm-9">
			  <select class="form-control" id="instruction" name="instruction" style="margin-bottom: 5px;" onchange="$('#get_instructions').toggle(); $('#instructions').toggle();">
				<?php if ($instruction) { ?>
				<option value="1" selected="selected"><?php echo $text_yes; ?></option>
				<option value="0"><?php echo $text_no; ?></option>
				<?php } else { ?>
				<option value="1"><?php echo $text_yes; ?></option>
				<option value="0" selected="selected"><?php echo $text_no; ?></option>
				<?php } ?>
              </select>
              <span id="get_instructions" <?php if (!$instruction) { ?> style="display: none;"<?php } ?>>
				<a onclick="getInstructions();" class="btn btn-primary"><span><?php echo $button_get_instructions; ?></span></a>
				<a onclick="getInstructionsForm();" class="btn btn-primary"><span><?php echo $button_instructions_form; ?></span></a>
              </span>
              <span id="instructions_error"></span>
			  <table class="table table-bordered table-hover"  id="instructions" class="list" style="margin-bottom: 0; <?php if (!$instruction) { ?> display: none;<?php } ?>">
                <thead>
				  <tr>
					<td class="left"><?php echo $entry_instructions_type; ?></td>
					<td class="left"><?php echo $entry_instructions_name; ?></td>
					<td class="left"><?php echo $entry_instructions_list; ?></td>
				  </tr>
				</thead>
				<tbody>
				  <?php foreach ($instructions_types as $instructions_type) { ?>
					<tr>
					  <td class="left">
						<?php echo $instructions_type['title']; ?>
					  </td>
					  <td class="left">
						<input class="form-control" type="text" id="instructions_<?php echo $instructions_type['code']; ?>" name="instructions[<?php echo $instructions_type['code']; ?>]" value="<?php echo isset($instructions[$instructions_type['code']]) ? $instructions[$instructions_type['code']] : ''; ?>" />
					  </td>
					  <td class="left">
						<select class="form-control" id="instructions_id_<?php echo $instructions_type['code']; ?>" name="instructions_id_<?php echo $instructions_type['code']; ?>" onchange="fillInstructions('<?php echo $instructions_type['code']; ?>');" style="width: 300px;">
						  <option value=""><?php echo $text_get_instructions; ?></option>
						  <?php if (isset($instructions_id[$instructions_type['code']])) { ?>
						  <?php foreach ($instructions_id[$instructions_type['code']] as $instruction_id) { ?>
						  <?php if (isset($instructions[$instructions_type['code']]) && $instructions[$instructions_type['code']] == $instruction_id) { ?>
						  <option value="<?php echo $instruction_id; ?>" selected="selected"><?php echo $instruction_id; ?></option>
						  <?php } else { ?>
						  <option value="<?php echo $instruction_id; ?>"><?php echo $instruction_id; ?></option>
						  <?php } ?>
						  <?php } ?>
						  <?php } ?>
						</select>
					  </td>
					</tr>
				  <?php } ?>
				</tbody>
			  </table>
			</div>
		  </div>
		</div>
      </form>
      <div class="pull-right">
        <a onclick="$('#form-econt :input').removeAttr('disabled'); $('#form-econt').submit();" class="btn btn-primary"><?php echo $button_generate; ?></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
      </div>
    </div>
   </div>
  </div>
</div>
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

		$('a#office_locator').magnificPopup({
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

			$('a#office_locator').magnificPopup({
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
				url: 'index.php?route=shipping/econt/getOfficeByOfficeCode&token=<?php echo $token; ?>',
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
$(document).ready(function() {
	if ($('#delivery_day_id').is(':visible')) {
		changeDeliveryDay();
	}
});

<?php if ($express_city_courier) { ?>
var express_city_courier_id = parseInt('<?php echo $express_city_courier_id; ?>');
<?php } else { ?>
var express_city_courier_id = '';
<?php } ?>

function displayExpressCityCourier() {
	if ($('#address_id').val() == express_city_courier_id) {
		$('#express_city_courier').show();
	} else {
		$('#express_city_courier').hide();
	}
}

function checkPriorityTime() {
	if ($('#priority_time_cb:checked').length) {
		$('#priority_time_type_id').removeAttr('disabled');
		$('#priority_time_hour_id').removeAttr('disabled');
	} else {
		$('#priority_time_type_id').attr('disabled', 'disabled');
		$('#priority_time_hour_id').attr('disabled', 'disabled');
	}
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
}

function checkDeliveryDay() {
	if ($('#delivery_day_cb:checked').length) {
		$('#delivery_day_id').removeAttr('disabled');
	} else {
		$('#delivery_day_id').attr('disabled', 'disabled');
	}
}

function changeDeliveryDay() {
	if ($('#delivery_day_id').val() == '<?php echo $priority_date; ?>') {
		if (!$('#priority_time_cb:checked').length) {
			$('#priority_time_cb').attr('checked', true);
			$('#priority_time_type_id').removeAttr('disabled');
			$('#priority_time_type_id').val('BEFORE').attr('selected', 'selected');
			$('#priority_time_hour_id').removeAttr('disabled');
			$('#priority_time_hour_id').val('13');
		}
	} else {
		$('#priority_time_cb').attr('checked', false);
		$('#priority_time_type_id').attr('disabled', 'disabled');
		$('#priority_time_hour_id').attr('disabled', 'disabled');
	}
}

function displayInventoryType() {
	if ($('#inventory_type').val() == 'DIGITAL') {
		$('#inventory_type_loading').hide();
		$('#inventory_type_digital').show();
	} else if ($('#inventory_type').val() == 'LOADING') {
		$('#inventory_type_loading').show();
		$('#inventory_type_digital').hide();
	} else {
		$('#inventory_type_loading').hide();
		$('#inventory_type_digital').hide();
	}
}

var product_row = <?php echo $product_row; ?>;

function addProduct() {
	html  = '<tr id="product_' + product_row + '">';
	html += '  <td class="left"><input class="form-control" type="text" id="product_id_' + product_row + '" name="products[' + product_row + '][product_id]" value="" size="3" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" id="product_name_' + product_row + '" name="products[' + product_row + '][name]" value="" size="50" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" id="product_weight_' + product_row + '" name="products[' + product_row + '][weight]" value="" size="10" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" id="product_price_' + product_row + '" name="products[' + product_row + '][price]" value="" size="10" /></td>';
	html += '  <td class="left"><a onclick="$(\'#product_' + product_row + '\').remove();" class="btn btn-primary"><span><?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';

	$('#products').append(html);

	product_row++;
}

function getInstructions() {
	$('#instructions_error').html('').removeClass("text-danger");
<?php foreach ($instructions_types as $instructions_type) { ?>
	$('#instructions_id_<?php echo $instructions_type['code']; ?>').html('<option value="0"><?php echo $text_wait; ?></option>');
<?php } ?>

	$.ajax({
		url: 'index.php?route=shipping/econt/getClients&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'username=<?php echo $econt_username; ?>&password=<?php echo $econt_password; ?>&test=<?php echo $econt_test; ?>',
		dataType: 'json',
		success: function(data) {
			if (data) {
				if (data.instructions) {
<?php foreach ($instructions_types as $instructions_type) { ?>
					html = '<option value=""><?php echo $text_select; ?></option>';

					if (data.instructions['<?php echo $instructions_type['code']; ?>']) {
						for (i = 0; i < data.instructions['<?php echo $instructions_type['code']; ?>'].length; i++) {
							if (data.instructions['<?php echo $instructions_type['code']; ?>'][i] && data.instructions['<?php echo $instructions_type['code']; ?>'][i].length) {
								html += '<option value="' + data.instructions['<?php echo $instructions_type['code']; ?>'][i] + '">' + data.instructions['<?php echo $instructions_type['code']; ?>'][i] + '</option>';
							}
						}
					}

					$('#instructions_id_<?php echo $instructions_type['code']; ?>').html(html);
					$('#instructions_id_<?php echo $instructions_type['code']; ?>').val($('#instructions_<?php echo $instructions_type['code']; ?>').val()).attr('selected', 'selected');
<?php } ?>
				} else if (data.error) {
					$('#instructions_error').html(data.error).addClass('text-danger');
				}
			}
		}
	});
}

function fillInstructions(type) {
	if ($('#instructions_id_' + type).val() != '') {
		$('#instructions_' + type).val($('#instructions_id_' + type).val());
	} else {
		$('#instructions_' + type).val('');
	}
}

function getInstructionsForm() {
	$.ajax({
		url: 'index.php?route=shipping/econt/getProfile&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'username=<?php echo $econt_username; ?>&password=<?php echo $econt_password; ?>&test=<?php echo $econt_test; ?>',
		dataType: 'json',
		success: function(data) {
			if (data) {
				if (data.instructions_form_url) {
					window.open(data.instructions_form_url, '', 'width=1050,height=800,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no');
				} else if (data.error) {
					alert(data.error);
				}
			}
		}
	});
}

function getOfficesByCityId() {
	$('#office_id').html('<option value="0"><?php echo $text_wait; ?></option>');
	$('#office_code').val('');

	$.ajax({
		url: 'index.php?route=shipping/econt/getOfficesByCityId&token=<?php echo $token; ?>',
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
			}
		}
	});
}

function getOffice() {
	$('#office_code').val('');

	$.ajax({
		url: 'index.php?route=shipping/econt/getOffice&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'office_id=' + encodeURIComponent($('#office_id').val()),
		dataType: 'json',
		success: function(data) {
			if (data) {
				$('#office_code').val(data.office_code);
			}
		}
	});
}
//--></script>

<script type="text/javascript"><!--
	var sender_post_code = '<?php echo $receiver_address['sender_post_code']; ?>';
	var econt_city = '<?php echo $receiver_address['city']; ?>';
	var econt_quarter = '<?php echo $receiver_address['quarter']; ?>';
	var econt_street = '<?php echo $receiver_address['street']; ?>';

	$('#city').autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=shipping/econt/getCitiesByName&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
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
				url: 'index.php?route=shipping/econt/getQuartersByName&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request) + '&city_id=' +  encodeURIComponent($('#city_id').val()),
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
				url: 'index.php?route=shipping/econt/getStreetsByName&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request) + '&city_id=' +  encodeURIComponent($('#city_id').val()),
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
//--></script></div>
<?php echo $footer; ?>
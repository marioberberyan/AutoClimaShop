<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" onclick="$('#form-econt :input').removeAttr('disabled');" form="form-econt" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-econt" class="form-horizontal">
        <div class="panel-body">
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_test"><?php echo $entry_test; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_test" name="econt_test">
                <?php if ($econt_test) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-3 control-label" for="econt_username"><?php echo $entry_username; ?></label>
            <div class="col-sm-9">
              <input type="text" id="econt_username" name="econt_username" value="<?php echo $econt_username; ?>" placeholder="<?php echo $econt_username; ?>" class="form-control" />
              <?php if ($error_username) { ?>
              <span class="text-danger"><?php echo $error_username; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-3 control-label" for="econt_password"><?php echo $entry_password; ?></label>
            <div class="col-sm-9">
              <input type="password" id="econt_password" name="econt_password" value="<?php echo $econt_password; ?>" placeholder="<?php echo $econt_password; ?>" class="form-control" />
              <?php if ($error_password) { ?>
               <span class="text-danger"><?php echo $error_password; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-3 control-label"><?php echo $entry_get_data; ?></label>
            <div class="col-sm-9">
              <a id="get_data" onclick="refreshData();" class="btn btn-primary"><span id="get_data_text"><?php if (!$cities) { ?><?php echo $button_get_data; ?><?php } else { ?><?php echo $button_refresh_data; ?><?php } ?></span></a>
              <span id="data_error"><?php if ($error_get_data) { ?><?php echo $error_get_data; ?><?php } ?></span>
            </div>
          </div>
       </div>
       <div class="panel-body" id="additional_table" <?php if (!$cities) { ?> style="display: none;"<?php } ?>>
          <div class="form-group required">
            <label class="col-sm-3 control-label" for="econt_name"><?php echo $entry_name; ?></label>
            <div class="col-sm-9">
              <input type="text" id="econt_name" name="econt_name" value="<?php echo $econt_name; ?>" placeholder="<?php echo $econt_name; ?>" class="form-control" />
              <?php if ($error_name) { ?>
              <span class="text-danger"><?php echo $error_name; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-3 control-label" for="econt_name_person"><?php echo $entry_name_person; ?></label>
            <div class="col-sm-9">
              <input type="text" id="econt_name_person" name="econt_name_person" value="<?php echo $econt_name_person; ?>" placeholder="<?php echo $econt_name_person; ?>" class="form-control" />
              <?php if ($error_name_person) { ?>
              <span class="text-danger"><?php echo $error_name_person; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-3 control-label" for="econt_phone"><?php echo $entry_phone; ?></label>
            <div class="col-sm-9">
              <input type="text" id="econt_phone" name="econt_phone" value="<?php echo $econt_phone; ?>" placeholder="<?php echo $econt_phone; ?>" class="form-control" />
              <?php if ($error_phone) { ?>
              <span class="text-danger"><?php echo $error_phone; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_address_id"><?php echo $entry_addresses; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_address_id" name="econt_address_id" onchange="fillAddress();" style="margin-bottom: 5px;">
              <option value="0"><?php echo $text_get_address; ?></option>
              </select>
              <a onclick="getProfile();" class="btn btn-primary"><span><?php echo $button_get_address; ?></span></a>
              <span id="address_error"></span></td>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-3 control-label" ><?php echo $entry_address; ?></label>
            <div class="col-sm-9">
             <div class="table-responsive">
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <td><?php echo $entry_post_code; ?></td>
                    <td><?php echo $entry_city; ?></td>
                    <td><?php echo $entry_quarter; ?></td>
                    <td><?php echo $entry_street; ?></td>
                    <td><?php echo $entry_street_num; ?></td>
                    <td><?php echo $entry_other; ?></td>
                    <td>&nbsp;</td>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <td colspan="6">&nbsp;</td>
                    <td class="left"><a onclick="addAddress();" class="btn btn-primary"><span><?php echo $button_add; ?></span></a></td>
                  </tr>
                </tfoot>
                <tbody id="econt_addresses">
                  <?php $address_row = -1; ?>
                  <?php foreach ($econt_addresses as $address) { ?>
                  <?php $address_row++; ?>
                  <tr id="econt_address_<?php echo $address_row; ?>">
                    <td class="left"><input class="form-control" type="text" id="econt_post_code_<?php echo $address_row; ?>" name="econt_addresses[<?php echo $address_row; ?>][post_code]" value="<?php echo $address['post_code']; ?>" size="3" disabled="disabled" /></td>
                    <td class="left"><input class="form-control" type="text" id="econt_city_<?php echo $address_row; ?>" name="econt_addresses[<?php echo $address_row; ?>][city]" value="<?php echo $address['city']; ?>" />
                      <input class="form-control" type="hidden" id="econt_city_id_<?php echo $address_row; ?>" name="econt_addresses[<?php echo $address_row; ?>][city_id]" value="<?php echo $address['city_id']; ?>" /></td>
                    <td class="left"><input class="form-control" type="text" id="econt_quarter_<?php echo $address_row; ?>" name="econt_addresses[<?php echo $address_row; ?>][quarter]" value="<?php echo $address['quarter']; ?>" /></td>
                    <td class="left"><input class="form-control" type="text" id="econt_street_<?php echo $address_row; ?>" name="econt_addresses[<?php echo $address_row; ?>][street]" value="<?php echo $address['street']; ?>" /></td>
                    <td class="left"><input class="form-control" type="text" id="econt_street_num_<?php echo $address_row; ?>" name="econt_addresses[<?php echo $address_row; ?>][street_num]" value="<?php echo $address['street_num']; ?>" size="1" /></td>
                    <td class="left"><input class="form-control" type="text" id="econt_other_<?php echo $address_row; ?>" name="econt_addresses[<?php echo $address_row; ?>][other]" value="<?php echo $address['other']; ?>" /></td>
                    <td class="left"><a onclick="$('#econt_address_<?php echo $address_row; ?>').remove();" class="btn btn-primary"><span><?php echo $button_remove; ?></span></a></td>
                  </tr>
                  <?php } ?>
                </tbody>
              </table>
              <?php if ($error_addresses) { ?>
              <span class="text-danger"><?php echo $error_addresses; ?></span>
              <?php } ?>
             </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_shipping_from"><?php echo $entry_shipping_from; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_shipping_from" name="econt_shipping_from" onchange="$('#office_city_id,#office_id,#office_code,#office_locator').toggle();">
                <?php if ($econt_shipping_from == 'OFFICE') { ?>
                <option value="OFFICE" selected="selected"><?php echo $text_from_office; ?></option>
                <option value="DOOR"><?php echo $text_from_door; ?></option>
                <?php } else { ?>
                <option value="OFFICE"><?php echo $text_from_office; ?></option>
                <option value="DOOR" selected="selected"><?php echo $text_from_door; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group" id="office_city_id" <?php if ($econt_shipping_from != 'OFFICE') { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="econt_office_city_id"><?php echo $entry_city; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_office_city_id" name="econt_office_city_id" onchange="getOfficesByCityId();">
                <option value="0"><?php echo $text_select; ?></option>
                <?php foreach ($cities as $city) { ?>
                <?php if ($city['city_id'] == $econt_office_city_id) { ?>
                <option value="<?php echo $city['city_id']; ?>" selected="selected"><?php echo $city['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $city['city_id']; ?>"><?php echo $city['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group" id="office_id" <?php if ($econt_shipping_from != 'OFFICE') { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="econt_office_id"><?php echo $entry_office; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_office_id" name="econt_office_id" onchange="getOffice();" style="width: 400px;">
                <option value="0"><?php echo $text_select; ?></option>
                <?php foreach ($offices as $office) { ?>
                <?php if ($office['office_id'] == $econt_office_id) { ?>
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
          <div class="form-group" id="office_code" <?php if ($econt_shipping_from != 'OFFICE') { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label"><?php echo $entry_office_code; ?></label>
            <div class="col-sm-9">
              <input type="text" id="econt_office_code" name="econt_office_code" value="<?php echo $econt_office_code; ?>" size="3" disabled="disabled" placeholder="<?php echo $econt_office_code; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group" id="office_locator" <?php if ($econt_shipping_from != 'OFFICE') { ?> style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label">&nbsp;</label>
            <div class="col-sm-9">
               <a href="javascript:void(0);" id="office_locator_button" class="btn btn-primary" title="<?php echo $button_office_locator; ?>"><span><?php echo $button_office_locator; ?></span></a>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_to_door"><?php echo $entry_to_door; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_to_door" name="econt_to_door" onchange="if ($(this).val() == 0) { $('#econt_to_office').val('1').attr('selected', 'selected'); }">
                <?php if ($econt_to_door || !$econt_to_office) { ?>
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
            <label class="col-sm-3 control-label" for="econt_to_office"><?php echo $entry_to_office; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_to_office" name="econt_to_office" onchange="if ($(this).val() == 0) { $('#econt_to_door').val('1').attr('selected', 'selected'); }">
                <?php if ($econt_to_office) { ?>
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
            <label class="col-sm-3 control-label" for="econt_cd"><?php echo $entry_cd; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_cd" name="econt_cd" onchange="displayCDAgreement();">
                <?php if ($econt_cd) { ?>
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
            <label class="col-sm-3 control-label" for="econt_oc"><?php echo $entry_oc; ?></label></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_oc" name="econt_oc" onchange="$('#total_for_oc').toggle();">
                <?php if ($econt_oc) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
              <?php } ?></select>
              <span id="total_for_oc" <?php if (!$econt_oc) { ?> style="display: none;"<?php } ?>>
                <label for="econt_total_for_oc"><?php echo $entry_total_for_oc; ?></label>
                <input class="form-control" type="text" id="econt_total_for_oc" name="econt_total_for_oc" value="<?php echo $econt_total_for_oc; ?>" />
              </span>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_dc"><?php echo $entry_dc; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_dc" name="econt_dc" onchange="if ($(this).val() == 1) { $('#econt_dc_cp').val('0').attr('selected', 'selected'); }">
                <?php if ($econt_dc) { ?>
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
            <label class="col-sm-3 control-label" for="econt_dc_cp"><?php echo $entry_dc_cp; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_dc_cp" name="econt_dc_cp" onchange="if ($(this).val() == 1) { $('#econt_dc').val('0').attr('selected', 'selected'); }">
                <?php if ($econt_dc_cp) { ?>
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
            <label class="col-sm-3 control-label" for="econt_sms"><?php echo $entry_sms; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_sms" name="econt_sms" onchange="$('#sms_no').toggle();">
              <?php if ($econt_sms) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
              <?php } ?></select>
              <span id="sms_no" <?php if (!$econt_sms) { ?> style="display: none;"<?php } ?>>
                <label class="control-label" for="econt_sms_no"><?php echo $entry_sms_no; ?></label>
                <input class="form-control" type="text" id="econt_sms_no" name="econt_sms_no" value="<?php echo $econt_sms_no; ?>" />
                <?php if ($error_sms) { ?>
                <span class="text-danger"><?php echo $error_sms; ?></span>
                <?php } ?>
              </span>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_invoice_before_cd"><?php echo $entry_invoice_before_cd; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_invoice_before_cd" name="econt_invoice_before_cd">
              <?php if ($econt_invoice_before_cd) { ?>
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
                  <input type="checkbox" id="econt_pay_after_accept" name="econt_pay_after_accept" value="1" <?php if ($econt_pay_after_accept) { ?> checked="checked"<?php } ?> onclick="$('#econt_pay_after_test').attr('checked', false);" />
                  <?php echo $entry_pay_after_accept; ?>
                </label>
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="econt_pay_after_test" name="econt_pay_after_test" value="1" <?php if ($econt_pay_after_test) { ?> checked="checked"<?php } ?> onclick="$('#econt_pay_after_accept').attr('checked', false);" />
                  <?php echo $entry_pay_after_test; ?>
                </label>
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="econt_instruction_shipping_returns" name="econt_instruction_returns" value="shipping_returns" <?php if ($econt_instruction_returns == 'shipping_returns') { ?> checked="checked"<?php } ?> onclick="$('#econt_instruction_returns').attr('checked', false);"  />
                  <?php echo $entry_instruction_shipping_returns; ?>
                </label>
              </div>
              <div class="checkbox">
                <label>
                  <input type="checkbox" id="econt_instruction_returns" name="econt_instruction_returns" value="returns" <?php if ($econt_instruction_returns == 'returns') { ?> checked="checked"<?php } ?> onclick="$('#econt_instruction_shipping_returns').attr('checked', false);" />
                  <?php echo $entry_instruction_returns; ?>
                </label>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" or="econt_side"><?php echo $entry_side; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_side" name="econt_side">
                <?php if ($econt_side == 'SENDER') { ?>
                <option value="RECEIVER"><?php echo $text_receiver; ?></option>
                <option value="SENDER" selected="selected"><?php echo $text_sender; ?></option>
                <?php } else { ?>
                <option value="RECEIVER" selected="selected"><?php echo $text_receiver; ?></option>
                <option value="SENDER"><?php echo $text_sender; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_payment_method"><?php echo $entry_payment_method; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_payment_method" name="econt_payment_method" onchange="if ($(this).val() == 'CREDIT') { $('#key_word').show(); } else { $('#key_word').hide(); }">
                <?php foreach ($payment_methods as $payment_method) { ?>
                <?php if ($payment_method['code'] == $econt_payment_method) { ?>
                <option value="<?php echo $payment_method['code']; ?>" selected="selected"><?php echo $payment_method['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $payment_method['code']; ?>"><?php echo $payment_method['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
              <span id="key_word" <?php if ($econt_payment_method != 'CREDIT') { ?> style="display: none;"<?php } ?>>
                <label class="control-label" for="econt_key_word"><?php echo $entry_key_word; ?></label>
                <input class="form-control" type="text" id="econt_key_word" name="econt_key_word" value="<?php echo $econt_key_word; ?>" />
                <select class="form-control" id="econt_key_word_id" name="econt_key_word_id" onchange="fillKeyWord();" style="margin: 10px 0;">
                  <option value="0"><?php echo $text_get_key_word; ?></option>
                </select>
                <a onclick="getKeyWords();" class="btn btn-primary"><span><?php echo $button_get_key_word; ?></span></a>
              </span>
              <span id="key_word_error"></span>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_cd_agreement"><?php echo $entry_cd_agreement; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_cd_agreement" name="econt_cd_agreement" onchange="$('#cd_agreement_num').toggle();" <?php if (!$econt_cd) { ?> disabled="disabled"<?php } ?>>
                <?php if ($econt_cd_agreement) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
              <span id="cd_agreement_num" <?php if (!$econt_cd_agreement) { ?> style="display: none;"<?php } ?>>
                <label class="control-label" for="econt_cd_agreement_num"><?php echo $entry_cd_agreement_num; ?></label>
                <input class="form-control" type="text" id="econt_cd_agreement_num" name="econt_cd_agreement_num" value="<?php echo $econt_cd_agreement_num; ?>" />
                <select class="form-control" id="econt_cd_agreement_num_id" name="econt_cd_agreement_num_id" onchange="fillCDAgreementNum();" style="margin: 10px 0;">
                  <option value="0"><?php echo $text_get_cd_agreement_num; ?></option>
                </select>
                <a onclick="getCDAgreementNums();" class="btn btn-primary"><span><?php echo $button_get_cd_agreement_num; ?></span></a>
              </span>
              <span id="cd_agreement_num_error"></span>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_total_for_free"><?php echo $entry_total_for_free; ?></label>
            <div class="col-sm-9">
              <input type="text" id="econt_total_for_free" name="econt_total_for_free" value="<?php echo $econt_total_for_free; ?>" placeholder="<?php echo $econt_total_for_free; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_weight_for_free"><?php echo $entry_weight_for_free; ?></label>
            <div class="col-sm-9">
              <input type="text" id="econt_weight_for_free" name="econt_weight_for_free" value="<?php echo $econt_weight_for_free; ?>" placeholder="<?php echo $econt_weight_for_free; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_count_for_free"><?php echo $entry_count_for_free; ?></label>
            <div class="col-sm-9">
              <input type="text" type="text" id="econt_count_for_free" name="econt_count_for_free" value="<?php echo $econt_count_for_free; ?>" placeholder="<?php echo $econt_count_for_free; ?>" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label"><?php echo $entry_shipping_payment; ?></label>
            <div class="col-sm-9">
             <div class="table-responsive">
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <td><?php echo $entry_order_amount; ?></td>
                    <td><?php echo $entry_receiver_amount; ?></td>
                    <td><?php echo $entry_receiver_amount_office; ?></td>
                    <td>&nbsp;</td>
                  </tr>
                </thead>
                <tfoot>
                  <tr>
                    <td colspan="3">&nbsp;</td>
                    <td class="left"><a onclick="addShippingPayment();" class="btn btn-primary"><span><?php echo $button_add; ?></span></a></td>
                  </tr>
                </tfoot>
                <tbody id="econt_shipping_payments">
                  <?php $shipping_payment_row = 0; ?>
                  <?php foreach ($econt_shipping_payments as $shipping_payment) { ?>
                  <tr id="econt_shipping_payment_<?php echo $shipping_payment_row; ?>">
                    <td class="left"><input class="form-control" type="text" name="econt_shipping_payments[<?php echo $shipping_payment_row; ?>][order_amount]" value="<?php echo $shipping_payment['order_amount']; ?>" /></td>
                    <td class="left"><input class="form-control" type="text" name="econt_shipping_payments[<?php echo $shipping_payment_row; ?>][receiver_amount]" value="<?php echo $shipping_payment['receiver_amount']; ?>" /></td>
                    <td class="left"><input class="form-control" type="text" name="econt_shipping_payments[<?php echo $shipping_payment_row; ?>][receiver_amount_office]" value="<?php echo $shipping_payment['receiver_amount_office']; ?>" /></td>
                    <td class="left"><a onclick="$('#econt_shipping_payment_<?php echo $shipping_payment_row; ?>').remove();" class="btn btn-primary"><span><?php echo $button_remove; ?></span></a></td>
                  </tr>
                  <?php $shipping_payment_row++; ?>
                  <?php } ?>
                </tbody>
              </table>
             </div>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_priority_time"><?php echo $entry_priority_time; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_priority_time" name="econt_priority_time">
                <?php if ($econt_priority_time) { ?>
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
            <label class="col-sm-3 control-label" for="econt_delivery_day"><?php echo $entry_delivery_day; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_delivery_day" name="econt_delivery_day">
                <?php if ($econt_delivery_day) { ?>
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
            <label class="col-sm-3 control-label" for="econt_partial_delivery"><?php echo $entry_partial_delivery; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_partial_delivery" name="econt_partial_delivery" onchange="$('#partial_delivery_instruction').toggle();">
                <?php if ($econt_partial_delivery) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
              <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group" id="partial_delivery_instruction" <?php if (!$econt_partial_delivery) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="econt_partial_delivery_instruction"><?php echo $entry_partial_delivery_instruction; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_partial_delivery_instruction" name="econt_partial_delivery_instruction">
                <?php foreach ($partial_delivery_instructions as $partial_delivery_instruction) { ?>
                <?php if ($partial_delivery_instruction['code'] == $econt_partial_delivery_instruction) { ?>
                <option value="<?php echo $partial_delivery_instruction['code']; ?>" selected="selected"><?php echo $partial_delivery_instruction['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $partial_delivery_instruction['code']; ?>"><?php echo $partial_delivery_instruction['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_inventory"><?php echo $entry_inventory; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_inventory" name="econt_inventory" onchange="$('#inventory_types').toggle();">
                <?php if ($econt_inventory) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group" id="inventory_types" <?php if (!$econt_inventory) { ?>style="display: none;"<?php } ?>>
            <label class="col-sm-3 control-label" for="econt_inventory_type"><?php echo $entry_inventory_type; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_inventory_type" name="econt_inventory_type">
                <?php foreach ($inventory_types as $inventory_type) { ?>
                <?php if ($inventory_type['code'] == $econt_inventory_type) { ?>
                <option value="<?php echo $inventory_type['code']; ?>" selected="selected"><?php echo $inventory_type['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $inventory_type['code']; ?>"><?php echo $inventory_type['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_return_loading"><?php echo $entry_return_loading; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_return_loading" name="econt_return_loading">
                <?php if ($econt_return_loading) { ?>
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
            <label class="col-sm-3 control-label" for="econt_instruction" class="control-label"><span data-toggle="tooltip" title="<?php echo $help_entry_instructions; ?>"><?php echo $entry_instructions; ?></span></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_instruction" style="margin-bottom: 5px;" name="econt_instruction" onchange="$('#get_instructions').toggle(); $('#instructions').toggle();">
                <?php if ($econt_instruction) { ?>
                <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                <option value="0"><?php echo $text_no; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_yes; ?></option>
                <option value="0" selected="selected"><?php echo $text_no; ?></option>
                <?php } ?>
              </select>
              <span id="get_instructions" <?php if (!$econt_instruction) { ?> style="display: none;"<?php } ?>>
                <a onclick="getInstructions();" class="btn btn-primary"><span><?php echo $button_get_instructions; ?></span></a>
                <a onclick="getInstructionsForm();" class="btn btn-primary"><span><?php echo $button_instructions_form; ?></span></a>
              </span>
              <span id="instructions_error"></span>
              <table class="table table-bordered table-hover" id="instructions" class="list" style="margin-bottom: 0; <?php if (!$econt_instruction) { ?> display: none;<?php } ?>">
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
                    <td class="left"><?php echo $instructions_type['title']; ?></td>
                    <td class="left"><input class="form-control" type="text" id="econt_instructions_<?php echo $instructions_type['code']; ?>" name="econt_instructions[<?php echo $instructions_type['code']; ?>]" value="<?php echo isset($econt_instructions[$instructions_type['code']]) ? $econt_instructions[$instructions_type['code']] : ''; ?>" /></td>
                    <td class="left"><select class="form-control" id="econt_instructions_id_<?php echo $instructions_type['code']; ?>" name="econt_instructions_id_<?php echo $instructions_type['code']; ?>" onchange="fillInstructions('<?php echo $instructions_type['code']; ?>');" style="width: 300px;">
                        <option value=""><?php echo $text_get_instructions; ?></option>
                        <?php if (isset($econt_instructions_id[$instructions_type['code']])) { ?>
                        <?php foreach ($econt_instructions_id[$instructions_type['code']] as $instructions_id) { ?>
                        <?php if (isset($econt_instructions[$instructions_type['code']]) && $econt_instructions[$instructions_type['code']] == $instructions_id) { ?>
                        <option value="<?php echo $instructions_id; ?>" selected="selected"><?php echo $instructions_id; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $instructions_id; ?>"><?php echo $instructions_id; ?></option>
                        <?php } ?>
                        <?php } ?>
                        <?php } ?>
                      </select>
                      <?php if (isset($econt_instructions_id[$instructions_type['code']])) { ?>
                      <?php foreach ($econt_instructions_id[$instructions_type['code']] as $instructions_id) { ?>
                      <input class="form-control" type="hidden" name="econt_instructions_id[<?php echo $instructions_type['code']; ?>][]" value="<?php echo $instructions_id; ?>" />
                      <?php } ?>
                      <?php } ?></td>
                  </tr>
                  <?php } ?>
                </tbody>
              </table>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_currency"><?php echo $entry_currency; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_currency" name="econt_currency">
                <?php foreach ($currencies as $currency) { ?>
                <?php if ($currency['code'] == $econt_currency) { ?>
                <option value="<?php echo $currency['code']; ?>" selected="selected"><?php echo $currency['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $currency['code']; ?>"><?php echo $currency['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_weight_class_id"><?php echo $entry_weight_class; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_weight_class_id" name="econt_weight_class_id">
                <?php foreach ($weight_classes as $weight_class) { ?>
                <?php if ($weight_class['weight_class_id'] == $econt_weight_class_id) { ?>
                <option value="<?php echo $weight_class['weight_class_id']; ?>" selected="selected"><?php echo $weight_class['title']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $weight_class['weight_class_id']; ?>"><?php echo $weight_class['title']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_order_status_id"><?php echo $entry_order_status; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_order_status_id" name="econt_order_status_id">
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $econt_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_geo_zone_id"><?php echo $entry_geo_zone; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_geo_zone_id" name="econt_geo_zone_id">
                <option value="0"><?php echo $text_all_zones; ?></option>
                <?php foreach ($geo_zones as $geo_zone) { ?>
                <?php if ($geo_zone['geo_zone_id'] == $econt_geo_zone_id) { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_status"><?php echo $entry_status; ?></label>
            <div class="col-sm-9">
              <select class="form-control" id="econt_status" name="econt_status">
                <?php if ($econt_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-3 control-label" for="econt_sort_order"><?php echo $entry_sort_order; ?></label>
            <div class="col-sm-9">
              <input class="form-control" type="text" id="econt_sort_order" name="econt_sort_order" value="<?php echo $econt_sort_order; ?>" size="1" />
            </div>
          </div>
        </div>
       </div>
      </form>
      <div class="pull-right">
        <button type="submit" onclick="$('#form-econt :input').removeAttr('disabled');" form="form-econt" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
		if ($('#econt_office_city_id').val()) {
			url = '<?php echo $office_locator; ?>&address=' + $('#econt_office_city_id option:selected').text();
		} else {
			url = '<?php echo $office_locator; ?>';
		}

		$('a#office_locator_button').magnificPopup({
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

		$('#econt_office_city_id').change(function () {
			if ($('#econt_office_city_id').val()) {
				url = '<?php echo $office_locator; ?>&address=' + $('#econt_office_city_id option:selected').text();
			} else {
				url = '<?php echo $office_locator; ?>';
			}

			$('a#office_locator_button').magnificPopup({
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
						$('#econt_office_city_id').val(data.city_id);
						html = '<option value="0"><?php echo $text_select; ?></option>';

						for (i = 0; i < data.offices.length; i++) {
							html += '<option ';
							if (data.offices[i]['office_id'] == data.office_id) {
								html += 'selected="selected"';
							}
							html += 'value="' + data.offices[i]['office_id'] + '">' + data.offices[i]['office_code'] + ', ' + data.offices[i]['name'] + ', ' + data.offices[i]['address'] +  '</option>';
						}

						$('#econt_office_id').html(html);
						$('#econt_office_code').val(office_code);
					}
				}
			});
		}
	}
//--></script>
<script type="text/javascript"><!--
var addresses;
var step = 0;

function refreshData() {
	$('#loading').remove();
	$('#data_error').html('').removeClass("text-danger");
	$('#get_data').after('<span id="loading" class="attention" style="padding: 5px;"><?php echo $text_get_data; ?></span>');
	$('#econt_office_city_id').html('<option value="0"><?php echo $text_wait; ?></option>');
	$('#econt_office_id').html('<option value="0"><?php echo $text_wait; ?></option>');

	$.ajax({
		url: 'index.php?route=shipping/econt/refreshData&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'username=' + encodeURIComponent($('#econt_username').val()) + '&password=' + encodeURIComponent($('#econt_password').val()) + '&test=' + encodeURIComponent($('#econt_test').val()) + '&step=' + step,
		dataType: 'json',
		success: function(data) {
			if (data) {
				$('#loading').remove();

				if (data.step) {
					step = data.step;
					refreshData();
				} else if (data.cities) {
					$('#get_data_text').text('<?php echo $button_refresh_data; ?>');
					$('#additional_table').show();

					html = '<option value="0"><?php echo $text_select; ?></option>';

					for (i = 0; i < data.cities.length; i++) {
						html += '<option value="' + data.cities[i]['city_id'] + '">' + data.cities[i]['name'] + '</option>';
					}

					$('#econt_office_city_id').html(html);
					$('#econt_office_city_id').val('<?php echo $econt_office_city_id; ?>').attr('selected', 'selected');

					getOfficesByCityId();
					$('#econt_office_id').val('<?php echo $econt_office_id; ?>').attr('selected', 'selected');

					$('#econt_office_code').val('<?php echo $econt_office_code; ?>');
				} else if (data.error) {
					$('#data_error').html(data.error).addClass('text-danger');
				}
			}
		},
		error: function(request) {
			$('#loading').remove();

			$('#data_error').html('<?php echo $error_general; ?>').addClass("text-danger");
		}
	});
}

function getProfile() {
	$('#address_error').html('').removeClass("text-danger");
	$('#econt_address_id').html('<option value="*"><?php echo $text_wait; ?></option>');

	$.ajax({
		url: 'index.php?route=shipping/econt/getProfile&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'username=' + encodeURIComponent($('#econt_username').val()) + '&password=' + encodeURIComponent($('#econt_password').val()) + '&test=' + encodeURIComponent($('#econt_test').val()),
		dataType: 'json',
		success: function(data) {
			if (data) {
				if (data.client_info && data.client_info.name) {
					$('#econt_name_person').val(data.client_info.name);
				} else if (data.client_info && data.client_info.mol) {
					$('#econt_name_person').val(data.client_info.mol);
				}

				if (data.client_info && data.client_info.business_phone) {
					$('#econt_phone').val(data.client_info.business_phone);
				}

				if (data.addresses) {
					addresses = data.addresses;
					html = '<option value="*"><?php echo $text_select; ?></option>';

					for (i = 0; i < data.addresses.length; i++) {
						html += '<option value="' + i + '">';

						html += data.addresses[i]['city_post_code'] + ', ' + data.addresses[i]['city'];

						if (data.addresses[i]['quarter'] && data.addresses[i]['quarter'].length) {
							html += ', ' + data.addresses[i]['quarter'];
						}

						if (data.addresses[i]['street'] && data.addresses[i]['street'].length) {
							html += ', ' + data.addresses[i]['street'];

							if (data.addresses[i]['street_num'] && data.addresses[i]['street_num'].length) {
								html += ' ' + data.addresses[i]['street_num'];
							}
						}

						if (data.addresses[i]['other'] && data.addresses[i]['other'].length) {
							html += ', ' + data.addresses[i]['other'];
						}

						html += '</option>';
					}

					$('#econt_address_id').html(html);
				} else if (data.error) {
					$('#address_error').html(data.error).addClass("text-danger");
				}
			}
		}
	});
}

var address_row = <?php echo $address_row; ?>;

function addAddress() {
	address_row++;

	html  = '<tr id="econt_address_' + address_row + '">';
	html += '  <td class="left"><input class="form-control" type="text" id="econt_post_code_' + address_row + '" name="econt_addresses[' + address_row + '][post_code]" value="" size="3" disabled="disabled" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" id="econt_city_' + address_row + '" name="econt_addresses[' + address_row + '][city]" value="" />';
	html += '    <input class="form-control" type="hidden" id="econt_city_id_' + address_row + '" name="econt_addresses[' + address_row + '][city_id]" value="" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" id="econt_quarter_' + address_row + '" name="econt_addresses[' + address_row + '][quarter]" value="" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" id="econt_street_' + address_row + '" name="econt_addresses[' + address_row + '][street]" value="" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" id="econt_street_num_' + address_row + '" name="econt_addresses[' + address_row + '][street_num]" value="" size="1" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" id="econt_other_' + address_row + '" name="econt_addresses[' + address_row + '][other]" value="" /></td>';
	html += '  <td class="left"><a onclick="$(\'#econt_address_' + address_row + '\').remove();" class="btn btn-primary"><span><?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';

	$('#econt_addresses').append(html);

	autocompleteAddress(address_row);
}

function fillAddress() {
	index = $('#econt_address_id').val();

	if (addresses && addresses[index]) {
		addAddress();

		$('#econt_post_code_' + address_row).val(addresses[index]['city_post_code']);

		$('#econt_city_' + address_row).val(addresses[index]['city']);

		if (addresses[index]['city_id'] && addresses[index]['city_id'].length) {
			$('#econt_city_id_' + address_row).val(addresses[index]['city_id']);
		}

		if (addresses[index]['quarter'] && addresses[index]['quarter'].length) {
			$('#econt_quarter_' + address_row).val(addresses[index]['quarter']);
		} else {
			$('#econt_quarter_' + address_row).val('');
		}

		if (addresses[index]['street'] && addresses[index]['street'].length) {
			$('#econt_street_' + address_row).val(addresses[index]['street']);
		} else {
			$('#econt_street_' + address_row).val('');
		}

		if (addresses[index]['street_num'] && addresses[index]['street_num'].length) {
			$('#econt_street_num_' + address_row).val(addresses[index]['street_num']);
		} else {
			$('#econt_street_num_' + address_row).val('');
		}

		if (addresses[index]['other'] && addresses[index]['other'].length) {
			$('#econt_other_' + address_row).val(addresses[index]['other']);
		} else {
			$('#econt_other_' + address_row).val('');
		}
	}
}

function getOfficesByCityId() {
	$('#econt_office_id').html('<option value="0"><?php echo $text_wait; ?></option>');
	$('#econt_office_code').val('');

	$.ajax({
		url: 'index.php?route=shipping/econt/getOfficesByCityId&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'city_id=' + encodeURIComponent($('#econt_office_city_id').val()),
		dataType: 'json',
		success: function(data) {
			if (data) {
				html = '<option value="0"><?php echo $text_select; ?></option>';

				for (i = 0; i < data.length; i++) {
					html += '<option value="' + data[i]['office_id'] + '">' + data[i]['office_code'] + ', ' + data[i]['name'] + ', ' + data[i]['address'] +  '</option>';
				}

				$('#econt_office_id').html(html);
			}
		}
	});
}

function getOffice() {
	$('#econt_office_code').val('');

	$.ajax({
		url: 'index.php?route=shipping/econt/getOffice&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'office_id=' + encodeURIComponent($('#econt_office_id').val()),
		dataType: 'json',
		success: function(data) {
			if (data) {
				$('#econt_office_code').val(data.office_code);
			}
		}
	});
}

function displayCDAgreement() {
	cd = $('#econt_cd').val();

	if (cd == 1) {
		$('#econt_cd_agreement').removeAttr('disabled');
	} else {
		$('#econt_cd_agreement').attr('disabled', 'disabled');
		$('#econt_cd_agreement').val('0').attr('selected', 'selected');
		$('#cd_agreement_num').hide();
	}
}

function getKeyWords() {
	$('#key_word_error').html('').removeClass("text-danger");
	$('#econt_key_word_id').html('<option value="0"><?php echo $text_wait; ?></option>');

	$.ajax({
		url: 'index.php?route=shipping/econt/getClients&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'username=' + encodeURIComponent($('#econt_username').val()) + '&password=' + encodeURIComponent($('#econt_password').val()) + '&test=' + encodeURIComponent($('#econt_test').val()),
		dataType: 'json',
		success: function(data) {
			if (data) {
				if (data.key_words) {
					html = '<option value="0"><?php echo $text_select; ?></option>';

					for (i = 0; i < data.key_words.length; i++) {
						if (data.key_words[i] && data.key_words[i].length) {
							html += '<option value="' + data.key_words[i] + '">' + data.key_words[i] + '</option>';
						}
					}

					$('#econt_key_word_id').html(html);
					$('#econt_key_word_id').val($('#econt_key_word').val()).attr('selected', 'selected');
				} else if (data.error) {
					$('#key_word_error').html(data.error).addClass("text-danger");
				}
			}
		}
	});
}

function fillKeyWord() {
	if ($('#econt_key_word_id').val() != 0) {
		$('#econt_key_word').val($('#econt_key_word_id').val());
	} else {
		$('#econt_key_word').val('');
	}
}

function getCDAgreementNums() {
	$('#cd_agreement_num_error').html('').removeClass("text-danger");;
	$('#econt_cd_agreement_num_id').html('<option value="0"><?php echo $text_wait; ?></option>');

	$.ajax({
		url: 'index.php?route=shipping/econt/getClients&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'username=' + encodeURIComponent($('#econt_username').val()) + '&password=' + encodeURIComponent($('#econt_password').val()) + '&test=' + encodeURIComponent($('#econt_test').val()),
		dataType: 'json',
		success: function(data) {
			if (data) {
				if (data.cd_agreement_nums) {
					html = '<option value="0"><?php echo $text_select; ?></option>';

					for (i = 0; i < data.cd_agreement_nums.length; i++) {
						if (data.cd_agreement_nums[i] && data.cd_agreement_nums[i].length) {
							html += '<option value="' + data.cd_agreement_nums[i] + '">' + data.cd_agreement_nums[i] + '</option>';
						}
					}

					$('#econt_cd_agreement_num_id').html(html);
					$('#econt_cd_agreement_num_id').val($('#econt_cd_agreement_num').val()).attr('selected', 'selected');
				} else if (data.error) {
					$('#cd_agreement_num_error').html(data.error).addClass("text-danger");
				}
			}
		}
	});
}

function fillCDAgreementNum() {
	if ($('#econt_cd_agreement_num_id').val() != 0) {
		$('#econt_cd_agreement_num').val($('#econt_cd_agreement_num_id').val());
	} else {
		$('#econt_cd_agreement_num').val('');
	}
}

function getInstructions() {
	$('#instructions_error').html('').removeClass("text-danger");
<?php foreach ($instructions_types as $instructions_type) { ?>
	$('#econt_instructions_id_<?php echo $instructions_type['code']; ?>').html('<option value="0"><?php echo $text_wait; ?></option>');
	$('input[name=\'econt_instructions_id[<?php echo $instructions_type['code']; ?>][]\']').remove();
<?php } ?>

	$.ajax({
		url: 'index.php?route=shipping/econt/getClients&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'username=' + encodeURIComponent($('#econt_username').val()) + '&password=' + encodeURIComponent($('#econt_password').val()) + '&test=' + encodeURIComponent($('#econt_test').val()),
		dataType: 'json',
		success: function(data) {
			if (data) {
				if (data.instructions) {
<?php foreach ($instructions_types as $instructions_type) { ?>
					html = '<option value=""><?php echo $text_select; ?></option>';
					html_hidden = '';

					if (data.instructions['<?php echo $instructions_type['code']; ?>']) {
						for (i = 0; i < data.instructions['<?php echo $instructions_type['code']; ?>'].length; i++) {
							if (data.instructions['<?php echo $instructions_type['code']; ?>'][i] && data.instructions['<?php echo $instructions_type['code']; ?>'][i].length) {
								html += '<option value="' + data.instructions['<?php echo $instructions_type['code']; ?>'][i] + '">' + data.instructions['<?php echo $instructions_type['code']; ?>'][i] + '</option>';
								html_hidden += '<input class="form-control" type="hidden" name="econt_instructions_id[<?php echo $instructions_type['code']; ?>][]" value="' + data.instructions['<?php echo $instructions_type['code']; ?>'][i] + '" />';
							}
						}
					}

					$('#econt_instructions_id_<?php echo $instructions_type['code']; ?>').html(html);
					$('#econt_instructions_id_<?php echo $instructions_type['code']; ?>').val($('#econt_instructions_<?php echo $instructions_type['code']; ?>').val()).attr('selected', 'selected');
					$('#econt_instructions_id_<?php echo $instructions_type['code']; ?>').after(html_hidden);
<?php } ?>
				} else if (data.error) {
					$('#instructions_error').html(data.error).addClass("text-danger");
				}
			}
		}
	});
}

function fillInstructions(type) {
	if ($('#econt_instructions_id_' + type).val() != '') {
		$('#econt_instructions_' + type).val($('#econt_instructions_id_' + type).val());
	} else {
		$('#econt_instructions_' + type).val('');
	}
}

function getInstructionsForm() {
	$.ajax({
		url: 'index.php?route=shipping/econt/getProfile&token=<?php echo $token; ?>',
		type: 'POST',
		data: 'username=' + encodeURIComponent($('#econt_username').val()) + '&password=' + encodeURIComponent($('#econt_password').val()) + '&test=' + encodeURIComponent($('#econt_test').val()),
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

var shipping_payment_row = <?php echo $shipping_payment_row; ?>;

function addShippingPayment() {
	html  = '<tr id="econt_shipping_payment_' + shipping_payment_row + '">';
	html += '  <td class="left"><input class="form-control" type="text" name="econt_shipping_payments[' + shipping_payment_row + '][order_amount]" value="" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" name="econt_shipping_payments[' + shipping_payment_row + '][receiver_amount]" value="" /></td>';
	html += '  <td class="left"><input class="form-control" type="text" name="econt_shipping_payments[' + shipping_payment_row + '][receiver_amount_office]" value="" /></td>';
	html += '  <td class="left"><a onclick="$(\'#econt_shipping_payment_' + shipping_payment_row + '\').remove();" class="btn btn-primary"><span><?php echo $button_remove; ?></span></a></td>';
	html += '</tr>';

	$('#econt_shipping_payments').append(html);

	shipping_payment_row++;
}
//--></script>

<script type="text/javascript"><!--
$(document).ready(function() {
	for (i = 0; i <= address_row; i++) {
		autocompleteAddress(i);
	}
});

function autocompleteAddress(index) {
	var econt_city = $('#econt_city_' + index).val();
	var econt_quarter = $('#econt_quarter_' + index).val();
	var econt_street = $('#econt_street_' + index).val();

	$('#econt_city_' + index).autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=shipping/econt/getCitiesByName&token=<?php echo $token; ?>&filter_name=' + encodeURIComponent(request),
				dataType: 'json',
				success: function(json) {
					response($.map(json, function(item) {
						return {
							label:     item['name'],
							value:     item['name'],
							city_id:   item['city_id'],
							post_code: item['post_code']
						}
					}));
				}
			});
		},
		'select': function(item) {
			if (item) {
				econt_city = item.label;
				$('#econt_city_' + index).val(item.label);
				$('#econt_city_id_' + index).val(item.city_id);
				$('#econt_post_code_' + index).val(item.post_code);
			}
		},
		'change': function(item) {
			if(!item) {
				$('#econt_city_' + index).val('');
				$('#econt_city_id_' + index).val('');
				$('#econt_post_code_' + index).val('');
			}
		}
	});

	$('#econt_city_' + index).blur(function() {
		if ($(this).val() != econt_city) {
			$(this).val('');
			$('#econt_city_id_' + index).val('');
			$('#econt_post_code_' + index).val('');
		}
	});

	$('#econt_quarter_' + index).autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=shipping/econt/getQuartersByName&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request) + '&city_id=' +  encodeURIComponent($('#econt_city_id_' + index).val()),
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
				$('#econt_quarter_' + index).val(item['label']);
			}
		},
		'change': function(item) {
			if(!item) {
				$('#econt_quarter_' + index).val('');
			}
		}
	});

	$('#econt_quarter_' + index).blur(function() {
		if ($(this).val() != econt_quarter) {
			$('#econt_quarter_' + index).val('');
		}
	});

	$('#econt_street_' + index).autocomplete({
		'source': function(request, response) {
			$.ajax({
				url: 'index.php?route=shipping/econt/getStreetsByName&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request) + '&city_id=' +  encodeURIComponent($('#econt_city_id_' + index).val()),
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
				$('#econt_street_' + index).val(item['label']);
			}
		},
		'change': function(item) {
			if(!item) {
				$('#econt_street_' + index).val('');
			}
		}
	});

	$('#econt_street_' + index).blur(function() {
		if ($(this).val() != econt_street) {
			$('#econt_street_' + index).val('');
		}
	});
}
//--></script>
<?php echo $footer; ?>
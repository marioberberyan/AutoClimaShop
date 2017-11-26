<?php
/*
#################################################################################
#  Module TOTAL IMPORT PRO for Opencart 2.0 From HostJars opencart.hostjars.com #
#################################################################################
*/
?>
<?php echo $header; ?><?php echo $menu; ?>
<div id="content">

<div class="page-header">
<div class="container-fluid">
	<div class="pull-right">
		<button onclick="$('#import_form').submit();" data-toggle="tooltip" title="<?php echo $button_next; ?>" class="btn btn-primary"><i class="fa fa-check"></i></button>
        <button onclick="saveSettings();return false;" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-info"><i class="fa fa-save"></i></button>
        <a href="<?php echo $skip_url;?>" data-toggle="tooltip" title="<?php echo $button_skip; ?>" class="btn btn-warning"><i class="fa fa-share"></i></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-danger"><i class="fa fa-home"></i></a>
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
<?php if ($success) { ?>
	<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
	  <button type="button" class="close" data-dismiss="alert">&times;</button>
	</div>
<?php } ?>

<div class="panel panel-default">
<div class="panel-body">
<!-- START MAIN CONTENT -->



<form class="form-horizontal" action="<?php echo $action; ?>" method="post" name="settings_form" enctype="multipart/form-data" id="import_form">
<input type='hidden' value='import_step2' name='step'/>
    <ul id="tabs" class="nav nav-tabs"><li class="active"><a data-toggle="tab" href="#tab_global"><?php echo $tab_global ?></a></li><!-- <a href="#tab_adjust"><?php echo $tab_adjust; ?></a><a href="#tab_global"><?php echo $tab_global; ?></a><a href="#tab_mapping"><?php echo $tab_mapping; ?></a><a href="#tab_import"><?php echo $tab_import; ?></a> --></ul>
    <input type='hidden' value='import_step2' name='step'/>
    <div id="tab_global">
        <div class="tab-pane active" id="tab_global">


        <!-- Out of Stock Status -->
        <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_out_of_stock; ?></label>
            <div class="col-sm-10">
                <select name="out_of_stock_status" id="input-account" class="form-control">
                    <?php foreach ($stock_status_selections as $status) { ?>
                    <option value="<?php echo $status['stock_status_id']; ?>" <?php if (isset($out_of_stock_status) && $out_of_stock_status == $status['stock_status_id']) { echo "selected='true'"; } ?>><?php echo $status['name']; ?></option>
                    <?php } ?>
                </select>
             </div>
        </div>


            <!-- Subtract Stock -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_subtract_stock; ?></label>
                <div class="col-sm-10">
                    <select name="subtract_stock" id="input-account" class="form-control">
                        <option value="1">Yes</option>
                        <option value="0" <?php if (isset($subtract_stock) && !$subtract_stock) { echo 'selected="true"'; }?>>No</option>
                    </select>
                </div>
            </div>

            <!-- Shipping Required -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_requires_shipping; ?></label>
                <div class="col-sm-10">
                    <select name="requires_shipping" id="input-account" class="form-control">
                        <option value="1">Yes</option>
                        <option value="0" <?php if (isset($requires_shipping) && !$requires_shipping) { echo 'selected="true"'; }?>>No</option>
                    </select>
                </div>
            </div>

            <!-- Minimum Quantity -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_minimum_quantity; ?></label>
                <div class="col-sm-10">
                    <input type="text" name="minimum_quantity" value="<?php echo (isset($minimum_quantity)) ? $minimum_quantity : '1';?>" class="form-control">
                </div>
            </div>

            <!-- Product Status -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_product_status; ?></label>
                <div class="col-sm-10">
                    <select name="product_status" id="input-account" class="form-control">
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" <?php if (isset($product_status) && !$product_status) { echo 'selected="true"'; }?>><?php echo $text_disabled; ?></option>
                    </select>
                </div>
            </div>

            <!-- Weight Class -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_weight_class; ?></label>
                <div class="col-sm-10">
                    <select name="weight_class" class="form-control">
                        <?php foreach ($weight_class_selections as $weight) { ?>
                        <option value="<?php echo $weight['weight_class_id']; ?>" <?php if (isset($weight_class) && $weight_class == $weight['weight_class_id']) { echo 'selected="true"'; }?>><?php echo $weight['title']; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>

            <!-- Length Class -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_length_class; ?></label>
                <div class="col-sm-10">
                    <select name="length_class" class="form-control">
                        <?php foreach ($length_class_selections as $length) { ?>
                        <option value="<?php echo $length['length_class_id']; ?>" <?php if (isset($length_class) && $length_class == $length['length_class_id']) { echo 'selected="true"'; }?>><?php echo $length['title']; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>

            <!-- Tax Class -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_tax_class; ?></label>
                <div class="col-sm-10">
                    <select name="tax_class" class="form-control">
                        <option value="0">--- None ---</option>
                        <?php foreach ($tax_class_selections as $tax) { ?>
                        <option value="<?php echo $tax['tax_class_id']; ?>" <?php if (isset($tax_class) && $tax_class == $tax['tax_class_id']) { echo 'selected="true"'; }?>><?php echo $tax['title']; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>


        <!-- ########################################################### -->
            <!-- Customer Group -->
            <?php if (count($customer_group_selections) > 1) { ?>
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_customer_group; ?></label>
                <div class="col-sm-10">
                    <select name="customer_group" class="form-control">
                        <?php foreach ($customer_group_selections as $group) { ?>
                        <option value="<?php echo $group['customer_group_id']; ?>" <?php if (isset($customer_group) && $customer_group == $group['customer_group_id']) { echo 'selected="true"'; }?>><?php echo $group['name']; ?></option>
                        <?php } ?>
                    </select>
                    <?php foreach ($customer_group_selections as $group) { ?>
                    <input type="hidden" name="customer_group_ids[<?php echo strtolower($group['name']); ?>]" value="<?php echo $group['customer_group_id']; ?>">
                    <?php } ?>
                </div>
            </div>

            <?php }	else { foreach ($customer_group_selections as $group) { ?>
            <input type="hidden" name="customer_group" value="<?php echo $group['customer_group_id']; ?>">
            <input type="hidden" name="customer_group_ids[<?php echo strtolower($group['name']); ?>]" value="<?php echo $group['customer_group_id']; ?>">
            <?php }} ?>

            <!-- Add categories to top bar -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_top_categories; ?></label>
                <div class="col-sm-10">
                    <select name="top_categories" class="form-control">
                        <option value="0"><?php echo $entry_no; ?></option>
                        <option value="1" <?php if (isset($top_categories) && $top_categories) echo 'selected="true"'; ?>><?php echo $entry_yes; ?></option>
                    </select>
                </div>
            </div>


            <!-- Add products only to bottom category -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_bottom_category; ?></label>
                <div class="col-sm-10">
                    <select name="bottom_category_only" class="form-control">
                        <option value="0" ><?php echo $entry_all_categories; ?></option>
                        <option value="1" <?php if (isset($bottom_category_only) && $bottom_category_only) echo 'selected="true"'; ?>><?php echo $entry_bottom_category_only; ?></option>
                    </select>
                </div>
            </div>


            <!-- Categories delimited -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_split_category; ?>&nbsp;<a href="http://helpdesk.hostjars.com/entries/21816598-how-do-i-import-categories" target="_blank" alt="Importing Categories"><i class="fa fa-question-circle fa-lg"></i></a></label>
                <div class="col-sm-10">
                    <input type="text" name="split_category" value="<?php if (isset($split_category)) echo $split_category; ?>" class="form-control">
                </div>
            </div>

            <!-- Related Field -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_related_field; ?></label>
                <div class="col-sm-10">
                    <select name="related_field" class="form-control">
                        <option value="product_id" ><?php echo $text_field_id; ?></option>
                        <option value="model" <?php if (isset($related_field) && $related_field == 'model') echo 'selected="true"'; ?>><?php echo $text_field_model; ?></option>
                        <option value="sku" <?php if (isset($related_field) && $related_field == 'sku') echo 'selected="true"'; ?>><?php echo $text_field_sku; ?></option>
                        <option value="upc" <?php if (isset($related_field) && $related_field == 'upc') echo 'selected="true"'; ?>><?php echo $text_field_upc; ?></option>
                    </select>
                </div>
            </div>

            <!-- Related delimited -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_split_related; ?>&nbsp;<a href="http://helpdesk.hostjars.com/entries/28343993-Can-I-import-Related-Products-" target="_blank" alt="Importing Related Products"><i class="fa fa-question-circle fa-lg"></i></a></label>
                <div class="col-sm-10">
                    <input type="text" name="split_related" value="<?php if (isset($split_related)) echo $split_related; ?>" class="form-control">
                </div>
            </div>

            <!-- Download Remote Images -->
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_remote_images; ?></label>
                <div class="col-sm-10">
                    <select name="remote_images" onchange="toggleImage(this.value);" class="form-control">
                        <option value="0"><?php echo $entry_no; ?></option>
                        <option value="1" <?php if (isset($remote_images) && $remote_images) echo 'selected="true"'; ?>><?php echo $entry_yes; ?></option>
                    </select>
                </div>
            </div>

            <!-- Download Image Subfolder -->
            <div class="form-group" id="image_subfolder" <?php if (!isset($remote_images) || $remote_images == 0) echo "style='display:none'"; ?>>
                <label class="col-sm-2 control-label"><?php echo $entry_image_subfolder; ?></label>
                <div class="col-sm-10">
                    <?php echo $image_folder_path ?><input type="text" name="image_subfolder" value="<?php if (isset($image_subfolder)) echo $image_subfolder; ?>" class="form-control">
                </div>
            </div>

            <!-- Stores -->
            <?php if (count($store_selections)) { ?>
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
                <div class="col-sm-10">
                    <div class="checkbox">
                        <label class="col-sm-4">
                            <input type="checkbox" name="store[]" value="0" <?php if (isset($store) && in_array(0, $store)) { ?>checked="true" <?php } ?> id="store_selection"/><label for="store_selection">Default
                        </label>
                    </div>
                    <?php foreach ($store_selections as $sto) { ?>
                    <div class="checkbox">
                        <label class="col-sm-4">
                            <input type="checkbox" name="store[]" value="<?php echo $sto['store_id']; ?>" id="store_selection_<?php echo $sto['store_id'] ?>" for="store_selection"<?php if (isset($store) && in_array($sto['store_id'], $store)) { echo ' checked="true"'; } ?>><label for="store_selection_<?php echo $sto['store_id'] ?>"><?php echo $sto['name']; ?></label>
                        </label>
                    </div>
                    <?php } ?>
                </div>
             </div>

            <?php }	else { ?>
            <input type="hidden" name="store[]" value="0"/>
            <?php } ?>

            <!-- Languages -->
            <?php if (count($language_selections) > 1) { ?>
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_language; ?></label>
                <div class="col-sm-10">

                        <?php foreach ($language_selections as $lang) { ?>
                    <div class="checkbox">
                        <label>
                        <input type="checkbox" name="language[]" value="<?php echo $lang['language_id']; ?>"<?php if (isset($language) && in_array($lang['language_id'], $language)) { echo ' checked="true"'; } ?>><?php echo ' ' . $lang['name']; ?>
                        </label>
                    </div>
                        <?php } ?>
                    </div>
                <?php }	else { foreach ($language_selections as $lang) { ?>
                <input type="hidden" name="language[]" value="<?php echo $lang['language_id']; ?>">
                <?php }} ?>
            </div>
        </div>
    </div>
</form>

<!-- END MAIN CONTENT -->
</div>
</div>
</div>
<!-- Start of HostJars Support Zendesk Widget script -->
<script>/*<![CDATA[*/window.zEmbed||function(e,t){var n,o,d,i,s,a=[],r=document.createElement("iframe");window.zEmbed=function(){a.push(arguments)},window.zE=window.zE||window.zEmbed,r.src="javascript:false",r.title="",r.role="presentation",(r.frameElement||r).style.cssText="display: none",d=document.getElementsByTagName("script"),d=d[d.length-1],d.parentNode.insertBefore(r,d),i=r.contentWindow,s=i.document;try{o=s}catch(c){n=document.domain,r.src='javascript:var d=document.open();d.domain="'+n+'";void(0);',o=s}o.open()._l=function(){var o=this.createElement("script");n&&(this.domain=n),o.id="js-iframe-async",o.src=e,this.t=+new Date,this.zendeskHost=t,this.zEQueue=a,this.body.appendChild(o)},o.write('<body onload="document._l();">'),o.close()}("//assets.zendesk.com/embeddable_framework/main.js","hostjars.zendesk.com");/*]]>*/</script>
<!-- End of HostJars Support Zendesk Widget script -->
<script type="text/javascript"><!--
	function toggleImage(state) {
		if (state == 1)
			$('#image_subfolder').show();
		else
			$('#image_subfolder').hide();
	}
    function saveSettings() {
        var data = $('#import_form').serialize();
        var url = 'index.php?route=tool/total_import/saveSettings&token=<?php echo $token ?>';
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            success: function(result) {
                addSave(result);
            }
        });
    }

    function addSave(result) {
        $('.success').remove();
        $('.warning').hide();
        $('.breadcrumb').after('<div class="alert alert-success">'+result+'<button type="button" class="close" data-dismiss="alert">×</button></div>');
    }
    //--></script>
<?php echo $footer; ?>
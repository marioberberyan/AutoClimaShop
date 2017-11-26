<?php
#####################################################################################
#  Module TOTAL IMPORT PRO for Opencart 2.0.0 From HostJars opencart.hostjars.com   #
#####################################################################################
?>
<?php echo $header; ?><?php echo $menu; ?>
<div id="content">

<form action="<?php echo $action; ?>" method="post" name="settings_form" enctype="multipart/form-data" id="import_form">
<input type='hidden' value='import_step5' name='step'/>

<div class="page-header">
<div class="container-fluid">
    <div class="pull-right">
        <?php echo $text_save_profile; ?><input type="text" name="save_settings_name" value="">
        <button onclick="saveSettings();$('#import_form').submit();return false;" data-toggle="tooltip" title="<?php echo $button_next; ?>" class="btn btn-primary"><i class="fa fa-check"></i></button>
        <button onclick="saveSettings();return false;" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-info"><i class="fa fa-save"></i></button>
        <a href="<?php echo $skip_url;?>" data-toggle="tooltip" title="<?php echo $button_skip; ?>" class="btn btn-warning"><i class="fa fa-share"></i></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-danger"><i class="fa fa-home"></i></a>
    </div>
  <h1><?php echo $heading_title; ?>(<a title='<?php echo $text_documentation; ?>' target="_blank" href='<?php echo $help_link; ?>'><?php echo $text_documentation; ?></a>)</h1>
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

<script type="text/javascript">
function enableRange(check) {
    if(check) {
        $('#showRanges').slideDown();
        $("#import_range_start").removeAttr("disabled");
        $("#import_range_end").removeAttr("disabled");
    } else {
        $('#showRanges').hide();
        $("#import_range_start").attr("disabled",true);
        $("#import_range_end").attr("disabled",true);
    }
}
$(function () {
    if ($('input[id*="reset_"]:checked'))
        $('span[data-toggle="data-reset"]').click();
});
</script>
<style>
.progress {
height: 20px;
margin-bottom: 20px;
overflow: hidden;
background-color: #f5f5f5;
border-radius: 4px;
-webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
}
.progress-bar {
float: left;
width: 0;
height: 100%;
font-size: 12px;
line-height: 20px;
color: #fff;
text-align: center;
background-color: #428bca;
-webkit-box-shadow: inset 0 -1px 0 rgba(0,0,0,.15);
box-shadow: inset 0 -1px 0 rgba(0,0,0,.15);
-webkit-transition: width .6s ease;
-o-transition: width .6s ease;
transition: width .6s ease;
}
</style>
<div class="panel panel-default">
<div class="panel-body">

    <ul id="tabs" class="nav nav-tabs"><li class="active"><a data-toggle="tab" href="#tab_import"><?php echo $tab_import; ?></a></li></ul>
        <div id="tab_import">
           <div class="tab-pane active form-horizontal" id="tab_import">
                    <div class="form-group" id="progress-items" style="display:none;">
                        <div class="col-md-2 control-label">
                        </div>
                        <div class="col-md-10">
                            <div class="progress">
                                <div id="progress-bar" class="progress-bar" style="width: 0%;"></div>
                            </div>
                            <div id="progress-text">
                                <span id="import-status">Importing...</span> Updated: <span id="prod_update">0</span> Added: <span id="prod_add">0</span>
                                <a id="log-btn" href=index.php?route=tool/total_import/log&token=<?php echo $token; ?>>View Log</a>
                            </div>
                        </div>
                    </div>

                    <!-- Reset Store -->
                    <div class="panel-group" id="data-reset">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="title">
                                    <i class="fa fa-caret-square-o-down"></i>
                                    <span data-toggle="collapse" data-parent="data-reset" href="#table-reset" class="collapsed" aria-expanded="false" style="cursor: pointer;">Table Reset (Changes to your database are permanent, it is recommended you <a href="<?php echo $backup_link; ?>">backup</a> you store)</span>
                                </h4>
                            </div>
                            <div id="table-reset" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                                <div class="form-group">
                                    <label class="col-md-2 control-label"><?php echo $entry_reset; ?> <i class="fa fa-question-circle" data-toggle="tooltip" data-placement="top" title="" data-original-title="Tick the tables you would like to reset"></i></label>
                                    <div class="col-md-10">
                                        <div class="well well-sm">
                                            <div class="checkbox">
                                                <label for="reset_products">
                                                    <input type="checkbox" name="reset_products" id="reset_products" <?php if (isset($reset_products)) echo 'checked="1"'?>>
                                                    <?php echo $table_products; ?>
                                                </label>
                                            </div>
                                            <div class="checkbox">
                                                <label for="reset_categories">
                                                    <input type="checkbox" name="reset_categories" id="reset_categories" <?php if (isset($reset_categories)) echo 'checked="1"'?>>
                                                    <?php echo $table_categories; ?>
                                                </label>
                                            </div>
                                            <div class="checkbox">
                                                <label for="reset_products">
                                                    <input type="checkbox" name="reset_manufacturers" id="reset_manufacturers" <?php if (isset($reset_manufacturers)) echo 'checked="1"'?>>
                                                    <?php echo $table_manufacturers; ?>
                                                </label>
                                            </div>
                                            <div class="checkbox">
                                                <label for="reset_attributes">
                                                    <input type="checkbox" name="reset_attributes" id="reset_attributes" <?php if (isset($reset_attributes)) echo 'checked="1"'?>>
                                                    <?php echo $table_attributes; ?>
                                                </label>
                                            </div>
                                            <div class="checkbox">
                                                <label for="reset_options">
                                                    <input type="checkbox" name="reset_options" id="reset_options" <?php if (isset($reset_options)) echo 'checked="1"'?>>
                                                    <?php echo $table_options; ?>
                                                </label>
                                            </div>
                                            <div class="checkbox">
                                                <label for="reset_downloads">
                                                    <input type="checkbox" name="reset_downloads" id="reset_downloads" <?php if (isset($reset_downloads)) echo 'checked="1"'?>>
                                                    <?php echo $table_downloads; ?>
                                                </label>
                                            </div>
                                            <div class="checkbox">
                                                <label for="reset_filters">
                                                    <input type="checkbox" name="reset_filters" id="reset_filters" <?php if (isset($reset_filters)) echo 'checked="1"'?>>
                                                    <?php echo $table_filters; ?>
                                                </label>
                                            </div>
                                    </div>
                                    <a onclick="$(this).parent().find(':checkbox').prop('checked', true);">Select All</a> / <a onclick="$(this).parent().find(':checkbox').prop('checked', false);">Unselect All</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- New Items -->
                    <div class="form-group">
                        <label class="col-md-2 control-label"><?php echo $entry_new_items; ?></label>
                        <div class="col-md-10">
                            <select name="new_items" class="form-control">
                                <option value="add"><?php echo $entry_add; ?></option>
                                <option value="skip" <?php if (isset($new_items) && $new_items == 'skip') echo 'selected="true"'; ?>><?php echo $entry_skip; ?></option>
                            </select>
                        </div>
                    </div>

                    <!-- Existing Items -->
                    <div class="form-group">
                        <label class="col-md-2 control-label"><?php echo $entry_existing_items; ?></label>
                        <div class="col-md-10">
                            <select name="existing_items" class="form-control">
                                <option value="update"><?php echo $entry_update; ?></option>
                                <option value="skip" <?php if (isset($existing_items) && $existing_items == 'skip') echo 'selected="true"'; ?>><?php echo $entry_skip; ?></option>
                            </select>
                        </div>
                    </div>

                    <!-- Identify Existing Items -->
                    <div class="form-group">
                        <label class="col-md-2 control-label"><?php echo $text_identify_existing; ?></label>
                        <div class="col-md-10">
                            <select name="update_field" class="form-control">
                                <option value="model"><?php echo $text_field_model; ?></option>
                                <option value="sku" <?php if (isset($update_field) && $update_field == 'sku') echo 'selected="true"'; ?>><?php echo $text_field_sku; ?></option>
                                <option value="upc" <?php if (isset($update_field) && $update_field == 'upc') echo 'selected="true"'; ?>><?php echo $text_field_upc; ?></option>
                                <option value="ean" <?php if (isset($update_field) && $update_field == 'ean') echo 'selected="true"'; ?>><?php echo $text_field_ean; ?></option>
                                <option value="jan" <?php if (isset($update_field) && $update_field == 'jan') echo 'selected="true"'; ?>><?php echo $text_field_jan; ?></option>
                                <option value="isbn" <?php if (isset($update_field) && $update_field == 'isbn') echo 'selected="true"'; ?>><?php echo $text_field_isbn; ?></option>
                                <option value="mpn" <?php if (isset($update_field) && $update_field == 'mpn') echo 'selected="true"'; ?>><?php echo $text_field_mpn; ?></option>
                            </select>
                        </div>
                    </div>

                    <!-- Items in store, not in feed -->
                    <div class="form-group">
                        <label class="col-md-2 control-label"><?php echo $entry_delete_diff; ?></label>
                        <div class="col-md-10">
                            <select name="delete_diff" class="form-control">
                                <option value="ignore"><?php echo $entry_ignore; ?></option>
                                <option value="delete" <?php if (isset($delete_diff) && $delete_diff == 'delete') echo 'selected="true"'; ?>><?php echo $entry_delete; ?></option>
                                <option value="disable" <?php if (isset($delete_diff) && $delete_diff == 'disable') echo 'selected="true"'; ?>><?php echo $entry_disable; ?></option>
                                <option value="zero_quantity" <?php if (isset($delete_diff) && $delete_diff == 'zero_quantity') echo 'selected="true"'; ?>><?php echo $entry_zero_quantity; ?></option>
                            </select>
                        </div>
                    </div>

                    <!-- Product Range to Import -->
                    <div class="form-group">
                        <label class="col-md-2 control-label"><?php echo $entry_import_range;?></label>
                        <!-- Use Safe Headers -->
                        <div class="col-md-10">

                            <div class="col-md-4">
                                <label for='import_range_all' class="radio-inline">
                                    <input type="radio" id="import_range_all" name="import_range" onclick='javascript:enableRange(false);' value="all" <?php if ((isset($import_range) && $import_range == 'all') || !isset($import_range)) echo 'checked="checked"'; ?>>
                                    <?php echo $entry_all; ?>
                                </label>
                                <label for='import_range_partial' class="radio-inline">
                                    <input type="radio" id="import_range_partial" onclick='javascript:enableRange(true);' name="import_range" value="partial" <?php if (isset($import_range) && $import_range == 'partial') echo 'checked="checked"'; ?>>
                                    <?php echo $entry_range; ?>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div id="showRanges" class="form-group">
                    <div class="col-md-10 col-md-offset-2">
                        <div class="col-md-2">
                            <label class="control-label"><?php echo $entry_from; ?></label>
                        </div>
                        <div class="col-md-2">
                            <input type="text" id="import_range_start" class="form-control" name="import_range_start" size="6" value="<?php if(!isset($import_range_start))  echo '1'; if(isset($import_range_start)) echo $import_range_start; ?>">
                        </div>
                        <div class="col-md-1">
                            <label class="control-label"><?php echo $entry_to; ?></label>
                        </div>
                        <div class="col-md-2">
                            <input type="text" id="import_range_end" class="form-control" name="import_range_end" size="6" value="<?php if(!isset($import_range_end)) echo '100'; if(isset($import_range_end)) echo $import_range_end; ?>"></span>
                        </div>
                    </div>
                    <span class="help-block col-md-10 col-md-offset-2"><?php echo $entry_import_range_help;?></span>
                    </div>
       </div>
  </div>
</div>
<!-- Start of HostJars Support Zendesk Widget script -->
<script>/*<![CDATA[*/window.zEmbed||function(e,t){var n,o,d,i,s,a=[],r=document.createElement("iframe");window.zEmbed=function(){a.push(arguments)},window.zE=window.zE||window.zEmbed,r.src="javascript:false",r.title="",r.role="presentation",(r.frameElement||r).style.cssText="display: none",d=document.getElementsByTagName("script"),d=d[d.length-1],d.parentNode.insertBefore(r,d),i=r.contentWindow,s=i.document;try{o=s}catch(c){n=document.domain,r.src='javascript:var d=document.open();d.domain="'+n+'";void(0);',o=s}o.open()._l=function(){var o=this.createElement("script");n&&(this.domain=n),o.id="js-iframe-async",o.src=e,this.t=+new Date,this.zendeskHost=t,this.zEQueue=a,this.body.appendChild(o)},o.write('<body onload="document._l();">'),o.close()}("//assets.zendesk.com/embeddable_framework/main.js","hostjars.zendesk.com");/*]]>*/</script>
<!-- End of HostJars Support Zendesk Widget script -->
<script type="text/javascript"><!--
$(document).ready(function() {
    if ($('#import_range_all').is(':checked')) {
        enableRange(false);
    } else {
        enableRange(true);
    }
});

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

function showAlert(msg, alert_type) {
    // Default to success
    alert_type = typeof alert_type !== 'undefined' ? alert_type : 'success';

    $('.panel').before('<div class="alert alert-'+alert_type+'"><i class="fa fa-check-circle"></i> '+msg+'<button type="button" class="close" data-dismiss="alert">×</button></div>');
}

function addSave(result) {
    $('.success').remove();
    $('.warning').hide();
    showAlert(result);
}


function next(cur_start, import_end, firstRun) {
    var_step_amount = <?php echo ($remote_images == 1) ? "10" : "50" ?>;
    firstRun = typeof firstRun !== 'undefined' ? '&FIRSTRUN=1' : '';
    // -1 as the start number is included
    cur_end = Math.min((cur_start + var_step_amount - 1), import_end);
    $.ajax({
        url: 'index.php?route=tool/total_import/step5_ajax&token=<?php echo $token; ?>',
        type: 'post',
        dataType: 'json',
        data: $('#import_form').serialize() + '&START=' + cur_start + '&END=' + cur_end + firstRun,
        success: function(json) {
            $('#prod_update').text(json['updated'] + parseInt($('#prod_update').text()));
            $('#prod_add').text(json['added'] + parseInt($('#prod_add').text()));
            // Draw Progress bars
            if ($('#import_range_all').is(':checked')) {
                $('#progress-bar').css('width', ((cur_start / import_end) * 100) + '%');
            } else {
                range_difference = +$('#import_range_end').val() - +$('#import_range_start').val();
                num_imported = cur_start - +$('#import_range_start').val();
                $('#progress-bar').css('width', ((num_imported / range_difference) * 100) + '%');
            }
            // Recursive call or end
            if (cur_end < import_end) {
                next(cur_end + 1, import_end);
            } else {
                $('#import-status').text('Complete!');
                $('.success .warning').hide();
                resultText = 'Success: '+parseInt($('#prod_update').text())+' products updated, '+parseInt($('#prod_add').text())+' products added.';
                showAlert(resultText);
                $('#progress-bar').css('width', 100 + '%').addClass('progress-bar-success');

                ajax_data = 'DELETE_DIFF=' + $('[name="delete_diff"]').val();
                ajax_data += '&UPDATE_FIELD=' + $('[name="update_field"]').val();
                ajax_data += '&TOTAL_UPDATED=' + $('#prod_update').text();
                ajax_data += '&TOTAL_ADDED=' + $('#prod_add').text();
                if ($('[name="reset_products"]').is(':checked')) {
                    ajax_data += '&RESET_PRODUCTS=1';
                }
                $.ajax({
                    url: 'index.php?route=tool/total_import/importEnd&token=<?php echo $token; ?>',
                    type: 'post',
                    dataType: 'json',
                    data: ajax_data,
                    success: function(json) {
                        if (typeof json['affected_products'] !== 'undefined') {
                            verb = 'affected';
                            switch ($('[name="delete_diff"]').val()) {
                                case 'delete':
                                    verb = 'deleted';
                                    break;
                                case 'zero_quantity':
                                    verb = 'set to quantity zero';
                                    break;
                                case 'disable':
                                    verb = 'disabled';
                                    break;
                            }
                            showAlert(json['affected_products'] + ' items in store but not in file have been ' + verb + '.');
                        }
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        showAlert('The server returned an error during the post import cleanup. If you believe this is a bug then get in touch and attach the following error message:<br />'+ xhr.responseText, 'warning');
                    }
                });
                enableInputs();
                import_running = false;
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            $('.warning').hide();
            showAlert('The server returned an error. If you believe this is a bug then get in touch and attach the following error message:<br />'+ xhr.responseText, 'warning');
            import_running = false;
            enableInputs();
            $('#import-status').text('Error!');
            //console.log(xhr.responseText);
        }
    });
}
function enableInputs() {
    if (!$('#import_range_all').is(':checked')) {
        $("#import_range_start").removeAttr("disabled", "disabled");
        $("#import_range_end").removeAttr("disabled", "disabled");
    }
    $("#import_range_partial").removeAttr("disabled", "disabled");
    $("#import_range_all").removeAttr("disabled", "disabled");
}

var import_running = false;

$('#btn-import').on("click", function (e) {
    if (import_running) {
        e.preventDefault();
    } else {
        $('#import_form').submit()
    }
});
$("[name='delete_diff']").on('mousedown', function (e) {
    if (import_running)
        e.preventDefault();
});
$("[name='update_field']").on('mousedown', function (e) {
    if (import_running)
        e.preventDefault();
});
$("[name='existing_items']").on('mousedown', function (e) {
    if (import_running)
        e.preventDefault();
});
$("[name='new_items']").on('mousedown', function (e) {
    if (import_running)
        e.preventDefault();
});

$('#import_form').submit(function(event) {
    // Non-ajax import if hj_dev set
    if (<?php if ($hj_dev) { echo "false";} else {echo "true";} ?>) {
        event.preventDefault();
        var isFullImport = $('#import_range_all').is(':checked');
        if (isFullImport) {
            var_start = 1;
            var_end = -1;
            $.ajax({
                url: 'index.php?route=tool/total_import/getNumItemsInFeed&token=<?php echo $token; ?>',
                type: 'get',
                async: false,
                success: function(data) {
                    var_end = parseInt(data);
                }
            });
        } else {
            var_start = +$('#import_range_start').val();
            var_end = +$('#import_range_end').val();
        }
        $('#progress-items').slideDown();
        $('#import-status').text('Importing...');
        $('#prod_update').text(0);
        $('#prod_add').text(0);
        $('#progress-bar').css('width', 0 + '%').removeClass('progress-bar-success');
        $("#import_range_start").attr("disabled", true);
        $("#import_range_end").attr("disabled", true);
        $("#import_range_all").attr("disabled", true);
        $("#import_range_partial").attr("disabled", true);
        import_running = true;
        next(Math.max(var_start, 1), var_end, true);
    }
});
//--></script>
</form>
<?php echo $footer; ?>
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

<div class="alert alert-info">
    <i class="fa fa-info-circle"></i>
    &nbsp;The OpenCart field column contains the name of the field in OpenCart, the Feed Field is where you must enter the heading name of the column that you want to import to each OpenCart field. You can set each field to "None" if you do not have anything to import there. None of the fields are required, but the more you can provide the better your import will be.
    <button type="button" class="close" data-dismiss="alert">×</button>
</div>
<div class="panel panel-default">
<div class="panel-body">
<!-- START MAIN CONTENT -->
<script type="text/javascript" src="view/javascript/selectize.js/selectize.min.js"></script>

<link href="view/javascript/selectize.js/css/selectize.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/selectize.js/css/selectize.bootstrap3.css" type="text/css" rel="stylesheet" />

<script type="text/javascript">

    function addSub(el) {
        var oldSub = $(el).closest('.hori').children('.col-sm-3').last();
        if (oldSub.children('select')[0].selectize)
        {
            var inputOptions = oldSub.children('select')[0].selectize.options;
            var inputValue =   oldSub.children('select')[0].selectize.getValue();
            oldSub.children('select')[0].selectize.destroy();
        }
        var newSub = oldSub.clone();
        $(el).before(newSub);
        selectizeInputs();
        oldSub.children('select')[0].selectize.addOption(inputOptions);
        oldSub.children('select')[0].selectize.setValue(inputValue);
        return false;
    }

    function addVert(el, multi) {
        newEl = '<div class="form-group vert';
        if (multi) {
            newEl += ' hori';
        }
        newEl += '">';

        var oldSub = $(el).closest('.vert').children('.col-sm-3').first();
        if (oldSub.children('select')[0].selectize)
        {
            var inputOptions = oldSub.children('select')[0].selectize.options;
            var inputValue =   oldSub.children('select')[0].selectize.getValue();
            oldSub.children('select')[0].selectize.destroy();
        }

        var oldRow = $(el).closest('.vert').clone();
        oldRow.children('.col-sm-3').not(':first').remove();

        newEl += oldRow.html();

        newEl += '</div>';
        if (multi == true) {
            matches = newEl.match(/\]\[(\d+)\]\[\]/);
            count = parseInt(matches[1]);
            count = count + 1;
            newEl = newEl.replace(']['+(count-1).toString()+'][]', ']['+count.toString()+'][]');
        }
        $(el).hide();
        $(el).closest('.vert').after(newEl);

        selectizeInputs();
        oldSub.children('select')[0].selectize.addOption(inputOptions);
        oldSub.children('select')[0].selectize.setValue(inputValue);
        return false;
    }

</script>
<form action="<?php echo $action; ?>" method="post" name="settings_form" enctype="multipart/form-data" id="import_form">
<ul id="tabs" class="nav nav-tabs"><li class="active"><a><?php echo $tab_mapping; ?></a></li></ul>
<input type='hidden' value='import_step4' name='step'/>

<div class="tab-pane active" id="tab_mapping">
    <tr><td><?php echo $text_feed_sample; ?></td></tr>
    <div id="sample" class="table" style="overflow: auto;">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <?php foreach ($fields as $field) { ?>
                <td class="center"><?php echo $field; ?></td>
                <?php } ?>
            </tr>
            </thead>
            <tbody>
            <tr>
                <?php foreach ($feed_sample as $key=>$value) { ?>
                <td class="center"><?php $value = strip_tags($value); echo (strlen($value) > 90) ? substr($value, 0, 90) . '...' : $value; ?></td>
                <?php } ?>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div class="form-group">
    <button type="button" id="nextRow" value="1" class="btn btn-primary">View Next Row</button>
</div>
<!-- Simple Update -->
<div class="form-horizontal">
<div class="form-group">
    <label class="col-sm-2 control-label"><?php echo $entry_simple; ?></label>
    <div class="col-sm-10">
        <select name="simple" id="simple" class="form-control" onchange="updateText(this, 'simple')">
            <option value="0"><?php echo $entry_no; ?></option>
            <option value="1" <?php if (isset($simple) && $simple == 1) echo 'selected="true"'; ?>><?php echo $entry_yes; ?></option>
        </select>
    </div>
</div>
</div>

<div id="simple_update">
    <ul id="simple_tabs" class="nav nav-tabs">
        <li class="active"><a href="#tab_simple" data-toggle="tab"><?php echo $entry_simple_fields; ?></a></li>
        <li><a href="#tab_matching" data-toggle="tab"><?php echo $entry_simple_matching; ?></a></li>
    </ul>
    <div class="tab-content form-horizontal">
        <div class="tab-pane active" id="tab_simple">
            <div class="form-group">
                <h3 class="col-sm-2 control-label"><?php echo $text_field_oc_title; ?></h3>
                <div class="col-sm-10">
                    <h3 class="control-label" style="text-align:left"><?php echo $text_field_feed_title;?></h3>
                </div>
            </div>

            <!-- Simple Single Field -->
            <?php foreach ($simple_fields as $simple_field) { ?>
            <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $field_map[$simple_field]; ?></label>
                <div class="col-sm-10">
                    <select name="simple_names[<?php echo $simple_field?>]" class="form-control">
                        <option value=''><?php echo $entry_none; ?></option>
                        <?php foreach ($fields as $field) { ?>
                        <option value="<?php echo $field; ?>" <?php if (isset($simple_names) && isset($simple_names[$simple_field]) && $simple_names[$simple_field] == $field) echo 'selected="true"'; ?>><?php echo $field; ?></option>
                        <?php } ?>
                    </select>
                </div>
            </div>
            <?php } ?>
            <!-- END Simple Single Field -->

            <!-- Specials Vert Field -->
            <?php for ($i=0; (isset($simple_names['product_special']) && $i<count($simple_names['product_special'])) || (!$i && !count($simple_names['product_special'])); $i++) { ?>
            <?php if ($i == 0 || (isset($simple_names['product_special']) && $simple_names['product_special'][$i])) { ?>

            <div class="form-group vert">
                <label class="col-sm-2 control-label"><?php echo $field_map['product_special'][0]; ?>
                </label>
                <div class="col-sm-10">
                    <select name="simple_names[product_special][]" class="form-control">
                        <option value=''><?php echo $entry_none; ?></option>
                        <?php foreach ($fields as $field) { ?>
                        <option value="<?php echo $field; ?>" <?php if (isset($simple_names) && $simple_names['product_special'][$i] == $field) echo 'selected="true"'; ?>><?php echo $field; ?></option>
                        <?php } ?>
                    </select>
                    <?php if (!isset($simple_names['product_special']) || !count($simple_names['product_special']) || ($i+1) == count($simple_names['product_special'])) { ?>
                        <a onclick="return addVert(this, false);" class="btn btn-primary"><span>More&nbsp;&darr;&nbsp;</span></a>
                    <?php } ?></label>
                </div>
            </div>
            <?php } ?>
            <?php } ?>
            <!-- END Specials Vert Field -->
        </div>
        <div class="tab-pane" id="tab_matching">
            <table>
                <div class="form-group">
                    <h3 class="col-sm-2 control-label"><?php echo $text_field_oc_title; ?></h3>
                    <div class="col-sm-10">
                        <h3 class="control-label" style="text-align:left"><?php echo $text_field_feed_title;?></h3>
                    </div>
                </div>
                <!-- Simple Matching Field -->
                <?php foreach ($matching_fields as $matching_field) { ?>
                <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $field_map[$matching_field]; ?></label>
                    <div class="col-sm-10">
                        <select class="form-control" name="simple_names[<?php echo $matching_field?>]">
                            <option value=''><?php echo $entry_none; ?></option>
                            <?php foreach ($fields as $field) { ?>
                            <option value="<?php echo $field; ?>" <?php if (isset($simple_names) && isset($simple_names[$matching_field]) && $simple_names[$matching_field] == $field) echo 'selected="true"'; ?>><?php echo $field; ?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                <?php } ?>
                <!-- END Simple Matching Field -->
            </table>
        </div>
    </div>
</div>
<!-- mapping fields to names -->
<div id="full">
    <ul id="mapping_tabs" class="nav nav-tabs">
        <?php foreach($tab_field as $tab => $value) { ?>
        <li><a href="#tab_<?php echo $tab; ?>" data-toggle="tab"><?php echo $tab; ?></a></li>
        <?php } ?>
    </ul>
    <div class="tab-content">
        <?php foreach($tab_field as $tab => $value) { ?>
        <div class="tab-pane" id="tab_<?php echo $tab; ?>">
            <div class="form-horizontal">
                <div class="form-group">
                    <h3 class="col-sm-2 control-label"><?php echo $text_field_oc_title; ?></h3>
                    <div class="col-sm-10">
                        <h3 class="control-label" style="text-align:left"><?php echo $text_field_feed_title;?></h3>
                    </div>
                </div>
                <?php foreach ($field_map as $input_name => $pretty_name) { ?>
                    <?php if (in_array($input_name, $value)) { ?>
                    <?php if (!is_array($pretty_name)) { ?>
                    <?php if (in_array($input_name, $multi_language_fields)) { ?>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $pretty_name; ?></label>
                        <div class="col-sm-10">
                        <?php foreach ($languages as $lang) { ?>
                        <!-- Normal Field (Multi Language) -->
                                <div class="input-group">
                                    <span class="input-group-addon"><img src="view/image/flags/<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" /></span>
                                    <select name="field_names[<?php echo $input_name?>][<?php echo $lang['language_id']; ?>]">
                                        <option value=''><?php echo $entry_none; ?></option>
                                        <?php foreach ($fields as $field) { ?>
                                        <option value="<?php echo $field; ?>" <?php if (isset($field_names) && isset($field_names[$input_name]) && isset($field_names[$input_name][$lang['language_id']]) && $field_names[$input_name][$lang['language_id']] == $field) echo 'selected="true"'; ?>><?php echo $field; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                        <!-- END Normal Field (Multi Language) -->
                        <?php } ?>
                            </div>
                        </div>
                <?php } elseif (in_array($input_name, $multi_stores)) { ?>
                    <!-- Multi Stores -->
                    <div class="form-group">
                        <label class="col-sm-2 control-label"><?php echo $pretty_name; ?></label>
                        <div class="col-sm-10">
                        <?php foreach ($stores as $store) { ?>
                            <div class="input-group">
                                <span class="input-group-addon"><?php echo $store['name'] ?></span>
                                <select name="field_names[<?php echo $input_name?>][<?php echo $store['store_id']; ?>]" class="form-control">
                                    <option value=''><?php echo $entry_none; ?></option>
                                        <?php foreach ($fields as $field) { ?>
                                        <option value="<?php echo $field; ?>"
                                        <?php
                                        if (isset($field_names) &&
                                            isset($field_names[$input_name]) &&
                                            isset($field_names[$input_name][$store['store_id']]) &&
                                            $field_names[$input_name][$store['store_id']] == $field)
                                            echo 'selected="true"';
                                        ?>
                                        ><?php echo $field; ?></option>
                                        <?php } ?>
                                </select>
                            </div>
                        <?php } ?>
                        </div>
                    </div>
                    <!-- END Multi Stores -->
                <?php } else { ?>
                <!-- Normal Field -->
                <div class="form-group">
                    <label class="col-sm-2 control-label"><?php echo $pretty_name; ?></label>
                    <div class="col-sm-10">
                        <select name="field_names[<?php echo $input_name?>]" class="form-control">
                            <option value=''><?php echo $entry_none; ?></option>
                            <?php foreach ($fields as $field) { ?>
                            <option value="<?php echo $field; ?>" <?php if (isset($field_names) && isset($field_names[$input_name]) && $field_names[$input_name] == $field) echo 'selected="true"'; ?>><?php echo $field; ?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                <!-- END Normal Field -->
                <?php } ?>
                <?php } elseif ($pretty_name[1] == 'both') { ?>
                <!-- Multi downwards/sideways Field -->

                <?php for ($i=0; (isset($field_names[$input_name]) && $i<count($field_names[$input_name]) || !$i && !count($field_names[$input_name])); $i++) { ?>
                <div class="form-group hori vert">
                    <label class="col-sm-2 control-label"><?php echo $pretty_name[0]; ?>
                        <?php if($pretty_name[0] == 'Category') { ?>
                            <a href="http://helpdesk.hostjars.com/entries/21816598-how-do-i-import-categories" target="_blank" alt="Importing Categories"><i class="fa fa-question-circle fa-lg"></i></a>
                        <?php } ?>
                    </label>
                    <?php for ($j=0; $j<count($field_names[$input_name][$i]) || ($j==0 && !count($field_names[$input_name][$i])); $j++) { ?>
                    	<div class="col-sm-3">
                   		<select class="form-control" name="field_names[<?php echo $input_name; ?>][<?php echo $i; ?>][]">
                            <option value=''><?php echo $entry_none; ?></option>
                            <?php foreach ($fields as $field) { ?>
                            <option value="<?php echo $field; ?>" <?php if (isset($field_names) && $field_names[$input_name][$i][$j] == $field) echo 'selected="true"'; ?>><?php echo $field; ?></option>
                            <?php } ?>
                        </select>
                    	</div>
                        <?php if (($j+1) == count($field_names[$input_name][$i])) { ?>
                       		<a onclick="return addSub(this);" class="btn btn-primary"><span>Add Sub-<?php echo $pretty_name[0]; ?>&nbsp;&rarr;&nbsp;</span></a>
                            <?php if (!isset($field_names[$input_name]) || !count($field_names[$input_name]) || ($i+1) == count($field_names[$input_name])) { ?>
                                <a onclick="return addVert(this, true);" class="btn btn-primary"><span>Add <?php echo $pretty_name[0]; ?>&nbsp;&darr;&nbsp;</span></a>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
                </div>
                <!-- END Multi downwards/sideways Field -->
                <?php } ?>
                <?php } else { ?>
                <!-- Multi downwards Field -->
                <?php
                for ($i=0; (isset($field_names[$input_name]) && $i<count($field_names[$input_name])) || (!$i && !count($field_names[$input_name])); $i++) { ?>
                <?php if ($i == 0 || (isset($field_names[$input_name]) && $field_names[$input_name][$i])) { ?>
                <div class="form-group vert">
                    <label class="col-sm-2 control-label"><?php echo $pretty_name[0]; ?>
                        <?php if($pretty_name[0] == 'Options') { ?>
                        <a href="http://helpdesk.hostjars.com/entries/21766242-how-do-i-import-options" target="_blank" alt="Importing Options"><i class="fa fa-question-circle fa-lg" data-toggle="tooltip" data-placement="top" title="" data-original-title="This field accepts optional formatting, click to read more."></i></a>
                        <?php } ?>
                        <?php if($pretty_name[0] == 'Discount Price') { ?>
                        <a href="http://helpdesk.hostjars.com/entries/21782977-can-i-import-discounts" target="_blank" alt="Importing Discount Prices"><i class="fa fa-question-circle fa-lg"></i></a>
                        <?php } ?>
                        <?php if($pretty_name[0] == 'Download') { ?>
                        <a href="http://helpdesk.hostjars.com/entries/22194853-can-i-import-downloads" target="_blank" alt="Importing Downloadable Products"><i class="fa fa-question-circle fa-lg"></i></a>
                        <?php } ?>
                    </label>
                    <div class="col-sm-3">
                        <?php if (in_array($input_name, $multi_language_fields)) { ?>
                            <?php foreach ($languages as $lang) { ?>
                                <!-- Normal Field (Multi Language) -->
                                <div class="input-group">
                                    <span class="input-group-addon"><img src="view/image/flags/<?php echo $lang['image']; ?>" title="<?php echo $lang['name']; ?>" /></span>
                                    <select name="field_names[<?php echo $input_name?>][<?php echo $lang['language_id']; ?>]" class="form-control">
                                        <option value=''><?php echo $entry_none; ?></option>
                                        <?php foreach ($fields as $field) { ?>
                                        <option value="<?php echo $field; ?>" <?php if (isset($field_names) && isset($field_names[$input_name]) && isset($field_names[$input_name][$lang['language_id']]) && $field_names[$input_name][$lang['language_id']] == $field) echo 'selected="true"'; ?>><?php echo $field; ?></option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <!-- END Normal Field (Multi Language) -->
                            <?php } ?>
                      	<?php } else { ?>
                        <select name="field_names[<?php echo $input_name; ?>][]" class="form-control">
                            <option value=''><?php echo $entry_none; ?></option>
                            <?php foreach ($fields as $field) { ?>
                            <option value="<?php echo $field; ?>" <?php if (isset($field_names) && $field_names[$input_name][$i] == $field) echo 'selected="true"'; ?>><?php echo $field; ?></option>
                            <?php } ?>
                        </select>
                        <?php } ?>
                    </div>
                    <?php if (!isset($field_names[$input_name]) || !count($field_names[$input_name]) || ($i+1) == count($field_names[$input_name])) { ?>
                        <a onclick="return addVert(this, false);" class="btn btn-primary"><span>More&nbsp;&darr;&nbsp;</span></a>
                    <?php } ?>
                </div>
                <?php } ?>
                <?php } ?>
                <!-- END Multi downwards Field -->
                <?php } ?>
                <?php } ?>
                <?php } ?>
            </div>
        </div>
        <?php } ?>
    </div>
</div>
</div>

</form>
<!-- END MAIN CONTENT -->
</div>
</div>
<!-- Start of HostJars Support Zendesk Widget script -->
<script>/*<![CDATA[*/window.zEmbed||function(e,t){var n,o,d,i,s,a=[],r=document.createElement("iframe");window.zEmbed=function(){a.push(arguments)},window.zE=window.zE||window.zEmbed,r.src="javascript:false",r.title="",r.role="presentation",(r.frameElement||r).style.cssText="display: none",d=document.getElementsByTagName("script"),d=d[d.length-1],d.parentNode.insertBefore(r,d),i=r.contentWindow,s=i.document;try{o=s}catch(c){n=document.domain,r.src='javascript:var d=document.open();d.domain="'+n+'";void(0);',o=s}o.open()._l=function(){var o=this.createElement("script");n&&(this.domain=n),o.id="js-iframe-async",o.src=e,this.t=+new Date,this.zendeskHost=t,this.zEQueue=a,this.body.appendChild(o)},o.write('<body onload="document._l();">'),o.close()}("//assets.zendesk.com/embeddable_framework/main.js","hostjars.zendesk.com");/*]]>*/</script>
<!-- End of HostJars Support Zendesk Widget script -->
<script type="text/javascript"><!--

    function selectizeInputs() {
        $('#full select').each(function(i, v) {
            if (!$(this)[0].selectize) {
                $(this).selectize({
                    inputClass: 'form-control selectize-input',
                    create: false,
                    sortField: "text",
                });
            }
        });
        $('.selectize-control').attr('placeholder', 'None');
    }

    $(document).ready(function() {
        selectizeInputs();
        // Tab links and tab panes are created dynamically, so the first tab is set active here
        $('#tab_General').addClass('active');
        $('a[href="#tab_General"').closest('li').addClass('active');

        if ($('#simple option:selected').text() == 'No') {
            $('#full').show();
            $('#full').attr("disabled",false);
            $('#simple_update').hide();
            $('#simple_update').attr("disabled",true);
        } else {
            $('#simple_update').show();
            $('#simple_update').attr("disabled",false);
            $('#full').hide();
            $('#full').attr("disabled",true);
        }
    });

    function updateText(el, name) {
        var action = el.value;
        if (name == 'simple') {
            if ( action == 1) {
                $('#simple_update').show();
                $('#simple_update').attr("disabled",false);
                $('#full').hide();
                $('#full').attr("disabled",true);
            } else {
                $('#full').show();
                $('#full').attr("disabled",false);
                $('#simple_update').hide();
                $('#simple_update').attr("disabled",true);
            }
        }
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

    function strip_tags (input, allowed) {
        allowed = (((allowed || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join(''); // making sure the allowed arg is a string containing only tags in lowercase (<a><b><c>)
        var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
                commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
        return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
            return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
        });
    }

    function buildSampleRow() {
        $.ajax({
            url: 'index.php?route=tool/total_import/getNextRow&token=<?php echo $token; ?>',
            type: 'post',
            data: {nextRow: $('#nextRow').attr('value')},
            dataType: 'json',
            async: false,
            success: function(json) {
                if (json.length != 0) {
                    $('#nextRow').val(parseInt($('#nextRow').val()) + 1);
                    $('#sample tbody').empty().append('<tr>');
                    $.each($('#sample thead tr td'), function(i, item) {
                        tmp = strip_tags(json[item.innerText]);
                        $('#sample tbody tr').append('<td class="text-left">'+ ((tmp.length > 90) ? tmp.substr(0, 90) + '...' : tmp) + "</td>");
                    });
                }
                else {
                    $('#nextRow').val(0);
                    buildSampleRow();
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    $('#nextRow').click(function() {
        buildSampleRow();
    });
    //--></script>
<?php echo $footer; ?>
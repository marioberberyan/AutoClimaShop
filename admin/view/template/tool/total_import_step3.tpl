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

            <script type="text/javascript">
                function addSub(el) {
                    sub = $(el).closest('.left').children('select').last().clone();
                    $(el).before(sub);
                    return false;
                }
            </script>
            <form action="<?php echo $action; ?>" method="post" name="settings_form" enctype="multipart/form-data" id="import_form">
                <input type='hidden' value='import_step3' name='step'/>
                <ul id="tabs" class="nav nav-tabs"><li class="active"><a data-toggle="tab" href="#tab_adjust"><?php echo $tab_adjust; ?></a></li><!-- <a href="#tab_adjust"><?php echo $tab_adjust; ?></a><a href="#tab_global"><?php echo $tab_global; ?></a><a href="#tab_mapping"><?php echo $tab_mapping; ?></a><a href="#tab_import"><?php echo $tab_import; ?></a> --></ul>
                <input type='hidden' value='import_step3' name='step'/>
                <div id="tab_adjust">
                    <div class="tab-pane active" id="tab_adjust" style="overflow: auto;">

                        <table id="sample" class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <?php foreach ($fields as $field) { ?>
                                    <td class="text-left"><?php echo $field; ?></td>
                                <?php } ?>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <?php foreach ($feed_sample as $key=>$value) { ?>
                                    <td class="text-left"><?php $value = strip_tags($value); echo (strlen($value) > 90) ? substr($value, 0, 90) . '...' : $value; ?></td>
                                <?php } ?>
                            </tr>
                            </tbody>
                        </table>
                        <div class="form-group">
                            <button type="button" id="nextRow" value="1" class="btn btn-primary">View Next Row</button>
                        </div>
                    </div>

                    <table class="table table-bordered table-hover" id="addOperation" style="overflow: auto;">
                        <thead>
                        <tr>
                            <td class="text-left"><?php echo $text_operation_type; ?></td>
                            <td class="text-left"><?php echo $text_operation_desc; ?></td>
                            <td></td>
                        </tr>
                        </thead>
                        <tbody id="operations">
                        <?php if (isset($adjust)) { ?>
                        <?php $adjust_count = 0; ?>
                        <?php foreach ($adjust as $row => $previous_data) { ?>
                        <tr id="adjustment_row_<?php echo $adjust_count; ?>">
                            <td class="text-left">
                                <?php echo $operations[$adjust[$row][0]]['name']; ?>
                                <input type="hidden" name="adjust[<?php echo $adjust_count; ?>][]" value="<?php echo $adjust[$row][0]; ?>"/>
                            </td>
                            <?php $i = 1; ?>
                            <td class="left">
                                <?php foreach ($operations[$adjust[$row][0]]['inputs'] as $field => $value) { ?>
                                &nbsp;<?php echo $value['prepend']; ?>&nbsp;
                                <?php if ($value['type'] == 'text') { ?>
                                    <input type="text" name="adjust[<?php echo $adjust_count; ?>][]" value="<?php echo $previous_data[$i] ?>" />
                                <?php } elseif ($value['type'] == 'field') { ?>
                                    <select class="<?php echo $value['type'] ?>" name="adjust[<?php echo $adjust_count ?>][]">
                                        <option><?php echo $text_select; ?></option>
                                        <?php foreach ($fields as $field) { ?>
                                        <option value="<?php echo $field ?>" <?php if ($previous_data[$i] == $field) echo 'selected="selected"'; ?>><?php echo $field; ?></option>
                                        <?php } ?>
                                    </select>
                                <?php } ?>
                                <?php $i++;	} ?>
                                <?php while(isset($previous_data[$i])) { ?>
                                <select class="<?php echo $value['type'] ?>" name="adjust[<?php echo $adjust_count ?>][]">
                                    <option><?php echo $text_select; ?></option>
                                    <?php foreach ($fields as $field) { ?>
                                    <option value="<?php echo $field ?>" <?php if ($previous_data[$i] == $field) echo 'selected="selected"'; ?>>
                                        <?php echo $field; ?>
                                    </option>
                                    <?php } ?>
                                </select>
                                <?php $i++; } ?>
                                <?php if(isset($value['option']) &&  $value['option'] == 'addMore') { ?>
                                <a onclick="return addSub(this);" class="button btn btn-primary"><span>More&nbsp;&rarr;&nbsp;</span></a>
                                <?php } ?>
                            </td><td class="text-left"><a onclick="$('#adjustment_row_<?php echo $adjust_count; ?>').remove();" class="button btn btn-danger"><?php echo $button_remove; ?></a></td>
                            <?php $adjust_count++; ?>
                        </tr>
                        <?php } ?>
                        <?php } ?>
                        </tbody>
                        <tfoot>
                        <td class="center" colspan="2"></td>
                        <td class="left">
                            <select id="operationToAdd">
                                <option><?php echo $text_select_operation; ?></option>
                                <?php foreach ($labels as $text) { ?>
                                <optgroup label="<?php echo $text ?>">
                                    <?php foreach ($operations as $key => $value) { ?>
                                    <?php if($value['label'] == $text) { ?>
                                    <option value="<?php echo $key; ?>"><?php echo $value['name']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                </optgroup>
                                <?php } ?>
                            </select>
                            <a class="button btn btn-primary" id="addOperation" onclick="addOperation();"><?php echo $button_add_operation; ?></a>
                        </td>
                        </tfoot>
                    </table>
                    </div>
            </form>
            <!-- END MAIN CONTENT -->
        </div>
    </div>
</div>
<!-- Start of HostJars Support Zendesk Widget script -->
<script>/*<![CDATA[*/window.zEmbed||function(e,t){var n,o,d,i,s,a=[],r=document.createElement("iframe");window.zEmbed=function(){a.push(arguments)},window.zE=window.zE||window.zEmbed,r.src="javascript:false",r.title="",r.role="presentation",(r.frameElement||r).style.cssText="display: none",d=document.getElementsByTagName("script"),d=d[d.length-1],d.parentNode.insertBefore(r,d),i=r.contentWindow,s=i.document;try{o=s}catch(c){n=document.domain,r.src='javascript:var d=document.open();d.domain="'+n+'";void(0);',o=s}o.open()._l=function(){var o=this.createElement("script");n&&(this.domain=n),o.id="js-iframe-async",o.src=e,this.t=+new Date,this.zendeskHost=t,this.zEQueue=a,this.body.appendChild(o)},o.write('<body onload="document._l();">'),o.close()}("//assets.zendesk.com/embeddable_framework/main.js","hostjars.zendesk.com");/*]]>*/</script>
<!-- End of HostJars Support Zendesk Widget script -->
<script type="text/javascript">
    var operation_row = <?php echo (isset($adjust)) ? count($adjust) : '0'; ?>;
    var operations = <?php echo json_encode($operations); ?>;

    function addOperation(){
        selected_op = $("#operationToAdd option:selected").val();
        if (operations[selected_op]) {
            ops = operations[selected_op];
            inputs = ops['inputs'];
            html = '<tr id="adjustment_row_' + operation_row + '">';
            html += '<td class="center">'+ops['name'];
            html += '<input type="hidden" name="adjust[' + operation_row + '][]" value="' + selected_op + '"/></td><td class="left">';
            for(i in inputs) {
                if (inputs[i]["prepend"]) {
                    html += '&nbsp;' + inputs[i]["prepend"] + '&nbsp;';
                }
                if (inputs[i]["type"] == 'text') {
                    html += '<input type="text" name="adjust[' + operation_row + '][]" />';
                } else if (inputs[i]["type"] == 'field') {
                    html += '<select name="adjust[' + operation_row + '][]"><option><?php echo $text_select; ?></option>';
                    html += '<?php foreach ($fields as $field) { ?><option value="<?php echo $field; ?>"><?php echo $field; ?></option><?php } ?></select>';
                }
                if(inputs[i]["option"] == 'addMore') {
                    html += '<a onclick="return addSub(this);" class="button btn btn-primary"><span>More&nbsp;&rarr;&nbsp;</span></a>';
                }
            }
            html += '</td><td class="left"><a onclick="$(\'#adjustment_row_' + operation_row + '\').remove();" class="button btn btn-danger"><?php echo $button_remove; ?></a></td>';
            html += '</tr>';

            $('#operations').append(html);
            operation_row++;
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
            data: {nextRow: $('#nextRow').val()},
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


    -->
</script>
<?php echo $footer; ?>
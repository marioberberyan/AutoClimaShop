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



            <form action="<?php echo $action; ?>" method="post" name="settings_form" enctype="multipart/form-data" id="import_form" class="form-horizontal">
                <input type='hidden' value='import_step1' name='step'/>
                <ul id="tabs" class="nav nav-tabs"><li class="active"><a data-toggle="tab" href="#tab_fetch">Step 1: Fetch Feed</a></li><!-- <a href="#tab_adjust"><?php echo $tab_adjust; ?></a><a href="#tab_global"><?php echo $tab_global; ?></a><a href="#tab_mapping"><?php echo $tab_mapping; ?></a><a href="#tab_import"><?php echo $tab_import; ?></a> --></ul>
                <div class="tab_fetch">
                    <div class="tab-pane active" id="tab_fetch">
                        <!-- Feed Source -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><?php echo $entry_feed_source; ?></label>
                            <div class="col-sm-10">
                                <input class="form-control" type='hidden' value='import_step1' name='step'/>
                                <select class="form-control" name="source" id="source" onchange="updateText(this, 'source');" class="form-control">
                                    <option value="file" <?php if (isset($source) && $source == 'file') echo 'selected="true"';?>><?php echo $entry_file_upload; ?></option>
                                    <option value="url" <?php if (isset($source) && $source == 'url') echo 'selected="true"';?>>URL</option>
                                    <option value="ftp" <?php if (isset($source) && $source == 'ftp') echo 'selected="true"';?>>FTP</option>
                                    <option value="filepath" <?php if (isset($source) && $source == 'filepath') echo 'selected="true"';?>><?php echo $entry_file_system; ?></option>
                                </select>
                            </div>
                        </div>
                        <!-- File -->
                        <div class="form-group required" id="file">
                            <label class="col-sm-2 control-label"><?php echo $entry_import_file; ?></label>
                            <div class="col-sm-10">
                                <input class="form-control" type="file" name="feed_file" id="feed_file"/>
                                <span class="help-block"><?php echo $entry_max_file_size; ?></span>
                            </div>
                        </div>
                        <!-- ...or URL -->
                        <div class="form-group required" id="url">
                            <label class="col-sm-2 control-label"><?php echo $entry_import_url; ?></label>
                            <div class="col-sm-10"><input class="form-control" type="text" size="70" name="feed_url" id="feed_url" value="<?php if (isset($feed_url)) echo $feed_url; ?>" /></div>
                        </div>
                        <!-- ...or FTP -->
                        <div class="form-group required ftp">
                            <label class="col-sm-2 control-label"><?php echo $entry_ftp_server; ?></label>
                            <div class="col-sm-10"><input class="form-control" type="text" size="70" name="feed_ftpserver" id="feed_ftpserver" value="<?php if (isset($feed_ftpserver)) echo $feed_ftpserver; ?>" /></div>
                        </div>
                        <div class="form-group required ftp">
                            <label class="col-sm-2 control-label"><?php echo $entry_ftp_user; ?></label>
                            <div class="col-sm-10"><input class="form-control" type="text" size="70" name="feed_ftpuser" id="feed_ftpuser" value="<?php if (isset($feed_ftpuser)) echo $feed_ftpuser; ?>" /></div>
                        </div>
                        <div class="form-group required ftp">
                            <label class="col-sm-2 control-label"><?php echo $entry_ftp_pass; ?></label>
                            <div class="col-sm-10"><input class="form-control" type="password" size="70" name="feed_ftppass" id="feed_ftppass" value="<?php if (isset($feed_ftppass)) echo $feed_ftppass; ?>" /></div>
                        </div>
                        <div class="form-group required ftp">
                            <label class="col-sm-2 control-label"><?php echo $entry_ftp_path; ?></label>
                            <div class="col-sm-10"><input class="form-control" type="text" size="70" name="feed_ftppath" value="<?php if (isset($feed_ftppath)) echo $feed_ftppath; ?>" /></div>
                        </div>
                        <!-- ...or File Path -->
                        <div class="form-group" id="filepath">
                            <label class="col-sm-2 control-label"><?php echo $entry_import_filepath; ?></label>
                            <div class="col-sm-10"><input class="form-control" type="text" name="feed_filepath" id="feed_filepath" value="<?php if (isset($feed_filepath)) echo $feed_filepath; ?>"/></div>
                        </div>
                        <!-- Feed Format -->
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><?php echo $entry_feed_format; ?></label>
                            <div class="col-sm-10">
                                <select class="form-control" name="format" onchange="updateText(this, 'format');" id="format">
                                    <option value="csv">CSV</option>
                                    <option value="xml" <?php if (isset($format) && $format == 'xml') echo 'selected="true"'; ?>>XML</option>
                                </select>
                            </div>
                        </div>
                        <!-- (XML Only) Product Tag -->
                        <div class="form-group required" id="xml">
                            <label class="col-sm-2 control-label"><?php echo $entry_xml_product_tag; ?>
                             <a href="http://helpdesk.hostjars.com/entries/33325855-Acceptable-XML-import-format" target="_blank" alt="Profiles"><i class="fa fa-question-circle fa-lg" data-toggle="tooltip" data-placement="top" title="" data-original-title="Our helpdesk article has more info."></i></a></label>
                            <div class="col-sm-10">
                                <input class="form-control" type="text" name="xml_product_tag" id="xml_product_tag" value="<?php if (isset($xml_product_tag)) echo $xml_product_tag; ?>">
                                <span class="help-block">This is the XML tag surrounding each product in your feed</span>
                            </div>
                        </div>
                        <!-- (CSV Only) Delimiter -->
                        <div class="form-group csv" id="csv">
                            <label class="col-sm-2 control-label"><?php echo $entry_delimiter; ?></label>
                            <div class="col-sm-10">
                                <select class="form-control" name="delimiter" id="delimiter">
                                    <option value="," <?php if (isset($delimiter) && $delimiter == ',') { echo 'selected="true"'; } ?>>,</option>
                                    <option value="\t" <?php if (isset($delimiter) && $delimiter == '\t') { echo 'selected="true"'; } ?>>Tab</option>
                                    <option value="|" <?php if (isset($delimiter) && $delimiter == '|') { echo 'selected="true"'; } ?>>|</option>
                                    <option value=";" <?php if (isset($delimiter) && $delimiter == ';') { echo 'selected="true"'; } ?>>;</option>
                                    <option value="^" <?php if (isset($delimiter) && $delimiter == '^') { echo 'selected="true"'; } ?>>^</option>
                                    <option value="~" <?php if (isset($delimiter) && $delimiter == '~') { echo 'selected="true"'; } ?>>~</option>
                                </select>
                            </div>
                        </div>
                    </div>


                    <div class="panel-group" id="accordion">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#advancedCollapse"><?php echo $entry_advanced; ?></a></h4>
                            </div>
                            <div id="advancedCollapse" class="panel-collapse collapse">

								<div class="form-group url">
                                    <label class="col-sm-2 control-label" for="basic_auth"><?php echo $entry_basic_authentication; ?> <a href="http://helpdesk.hostjars.com/entries/41791105" target="_blank"><i class="fa fa-question-circle fa-lg"></i></a></label>
                                    <div class="col-sm-10">
                                        <div class="checkbox">
                                        <label>
                                        <input type="checkbox" name="basic_auth" id="basic_auth" <?php if (isset($basic_auth) && $basic_auth == 'on') echo 'checked="1"';?>/>
                                        </label>
                                        </div>
                                    </div>
                                </div>

                               <div class="form-group auth">
                                    <label class="col-sm-2 control-label" for="user_basicauth"><?php echo $entry_auth_user; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" name="user_basicauth" id="user_basicauth" value="<?php if (isset($user_basicauth)) { echo $user_basicauth; } ?>">
                                    </div>
                                </div>

                                <div class="form-group auth">
                                    <label class="col-sm-2 control-label" for="pass_basicauth"><?php echo $entry_auth_pass; ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" name="pass_basicauth" id="pass_basicauth" value="<?php if (isset($pass_basicauth)) echo $pass_basicauth; ?>">
                                    </div>
                                </div>

                                <div class="form-group csv">
                                    <label class="col-sm-2 control-label" for="has_headers"><?php echo $entry_first_row_is_headings; ?></label>
                                    <div class="col-sm-10">
                                        <div class="checkbox">
                                        <label>
                                        <input type="checkbox" name="has_headers" id="has_headers" <?php if (isset($has_headers)) echo 'checked="1" '; ?>/>
                                    	</div>
                                    	</label>
                                	</div>
                            	</div>

                                <div class="form-group csv">
                                    <label class="col-sm-2 control-label" for="safe_headers"><?php echo $entry_use_safe_headings; ?></label>
                                    <!-- Use Safe Headers -->
                                    <div class="col-sm-10">
                                        <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="safe_headers" id="safe_headers" <?php if (isset($safe_headers)) echo 'checked="1" '; ?>/>
                                            </label>
                                        </div>
                                        <span class="help-block"><?php echo $entry_use_safe_headings_help; ?></span>
                                    </div>
                                </div>

                                <!-- Unzip feed -->
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="unzip_feed"><?php echo $entry_unzip_feed; ?></label>
                                    <div class="col-sm-10">
                                    <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="unzip_feed" id="unzip_feed" <?php if (isset($unzip_feed)) echo 'checked="1" '; ?>/>
									</label>
                                        </div>
                                    </div>
                                </div>
                                <!-- File Encoding -->
                                <div class="form-group">
                                    <label class="col-sm-2 control-label"><?php echo $entry_file_encoding; ?>
                                        <a href="http://helpdesk.hostjars.com/entries/21806583-file-encoding-for-imports" target="_blank"><i class="fa fa-question-circle fa-lg"></i></a>

                                    </label>
                                    <div class="col-sm-10">
                                        <select class="form-control" name="file_encoding" id="file_encoding">
                                            <option value="UTF-8" <?php if (isset($file_encoding) && $file_encoding == 'UTF-8') { echo 'selected="true"'; } ?>>UTF-8</option>
                                            <option value="ISO-8859-1" <?php if (isset($file_encoding) && $file_encoding == 'ISO-8859-1') { echo 'selected="true"'; } ?>>ISO-8859-1</option>
                                            <option value="US-ASCII" <?php if (isset($file_encoding) && $file_encoding == 'US-ASCII') { echo 'selected="true"'; } ?>>ASCII</option>
                                        </select>
                                        <span class="help-block"><?php echo $entry_file_encoding_help; ?></span>
                                    </div>
                                </div>

                        	    <!-- Cron Fetch -->
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="cron_fetch"><?php echo $entry_cron_fetch; ?></label>
                                    <div class="col-sm-10">
                               	 		<div class="checkbox">
	                                    <label>
	                                        <input type="checkbox" name="cron_fetch" id="cron_fetch" <?php if (isset($cron_fetch)) echo 'checked="1" '; ?>/>
										</label>
                                        </div>
                                         <span class="help-block"><?php echo $entry_cron_fetch_help; ?></span>
                                    </div>
                                </div>

                            </div>
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
    function updateText(el, name) {
        var action = el.value;
        if (name == 'source') {
            $("#file, #url, .url, .auth, #filepath, .ftp").hide();
        } else {
            $("#xml, .csv").hide();
        }
        $("#"+action+", ."+action).show();
        if ($('#basic_auth').is(':checked') && $('#source').val() == 'url') {
			$('.auth').show();
		}
    }

    $(document).ready(function() {
        updateText(document.settings_form.source, 'source');
        updateText(document.settings_form.format, 'format');
		$('#basic_auth').click(function() {
			$('.auth').toggle();
		});
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

    function addSave(result) {
        $('.success').remove();
        $('.warning').hide();
        $('.breadcrumb').after('<div class="alert alert-success">'+result+'<button type="button" class="close" data-dismiss="alert">×</button></div>');
    }

    //--></script>
<?php echo $footer; ?>
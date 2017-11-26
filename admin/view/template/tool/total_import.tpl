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
        &nbsp;You can use the buttons below to skip to the steps you require. You will usually need to run at least Step 1 and Step 5. If you are using this module for the first time, you should run all steps in order from Step 1.
        <button type="button" class="close" data-dismiss="alert">×</button>
    </div>
    <div class="panel panel-default">
        <div class="panel-body">
            <!-- START MAIN CONTENT -->

            <form action="<?php echo $action; ?>" method="post" name="settings_form" enctype="multipart/form-data" id="settings_form" class="form-horizontal">

                <div class="col-md-6">
                    <div class="form-group">
                        <label for="settings_groupname" class="col-md-5 control-label">Load Settings Profile:&nbsp;<a href="http://helpdesk.hostjars.com/entries/21991386-using-profiles" target="_blank" alt="Profiles" data-toggle="tooltip" data-placement="top" title="" data-original-title="Click to read more about using import profiles"><i class="fa fa-question-circle fa-lg"></i></a></label>
                        <div class="col-md-7">
                            <select class="form-control" name="settings_groupname">
                            <option value=""><?php echo $text_profile_default; ?></option>
                            <?php if (count($preset_settings)) { ?>
                                <option class='preset_option' value="">--- PRESET PROFILES ---</option>
                                <?php foreach ($preset_settings as $setting_name) { ?>
                                    <option class='preset_option' value="preset_<?php echo $setting_name; ?>"><?php echo $setting_name; ?></option>
                                <?php } ?>
                            <?php } ?>
                            <?php if (count($saved_settings)) { ?>
                                <option value="">--- SAVED PROFILES ---</option>
                                <?php foreach ($saved_settings as $setting_name) { ?>
                                    <option value="<?php echo $setting_name; ?>"><?php echo $setting_name; ?></option>
                                <?php } ?>
                            <?php } ?>
                            </select>
                            <span class="help-block"><?php echo $text_profile_help; ?></span>
                        </div>
                        <div class="col-md-7 col-md-offset-5">
                            <a href="#" class="btn btn-primary" onclick="$('#settings_form').submit();return false;" ><span>Load</span></a>
                            <a href="#" class="btn btn-primary" id="deleteProfile"><span>Delete</span></a>
                        </div>
                    </div>
                    <h3>New Import? Start here.</h3>
                    <?php foreach ($pages as $page => $page_info) { ?>
                    <div class="form-group">
                        <div class="col-md-5" style="text-align: center">
                            <a href="<?php echo $page_info['link']; ?>" class="button btn <?php if ($page_info['button'] == 'Step 1') { ?>btn-success <?php } else { ?>btn-primary<?php } ?>" 
                            <?php if ($page_info['button'] != 'Step 1' && $db_exists == false) {?> disabled <?php } ?> ><span><?php echo $page_info['button']?></span></a>&nbsp;&nbsp;
                        </div>
                        <div class="col-md-7">
                            <a href="<?php echo $page_info['helpdesk']; ?>" target="_blank" alt="Profiles">
                                <i class="fa fa-question-circle fa-lg" data-toggle="tooltip" data-placement="top" title="" data-original-title="<?php echo $page_info['tooltip']; ?>"></i>
                            </a>&nbsp;<?php echo $page_info['title']?>
                        </div>
                        </div>
                        <?php } ?>

                    <div class="col-md-7 col-md-offset-5">
                        <a class="btn btn-primary" href=index.php?route=tool/total_import/log&token=<?php echo $token; ?>>View Log</a>
                    </div>
                </div>

                <div class="col-md-5 col-md-offset-1">
                    <div class="panel well">
                        <div class="panel-heading">
                            <i class="icon-question-circle"></i>
                            <strong>Need some help?</strong>
                        </div>

                        <div class="list-group">
                            <a class="list-group-item" href="http://feeds.hostjars.com" target="_blank">
                                Sample Product Feeds
                            </a>
                            <a class="list-group-item" href="http://helpdesk.hostjars.com/entries/33325855-Acceptable-XML-import-format" target="_blank">
                                XML Format Guide
                            </a> <a class="list-group-item" href="http://helpdesk.hostjars.com/entries/26254297-Acceptable-CSV-import-format" target="_blank">
                                CSV Format Guide
                            </a>
                            <a class="list-group-item" href="http://helpdesk.hostjars.com/forums" target="_blank">
                                Knowledge Base Articles
                            </a>
                            <a class="list-group-item" href="http://helpdesk.hostjars.com/entries/58365959-Getting-Started" target="_blank">
                                Getting Started with Total Import PRO
                            </a>
                            <a class="list-group-item" href="http://helpdesk.hostjars.com/tickets/new" target="_blank">
                                Submit a ticket to our helpdesk
                            </a>
                            <a class="list-group-item" href="http://helpdesk.hostjars.com/tickets/new" target="_blank">
                                Have a feature idea that would save you time? Please get in touch for a free quote.
                            </a>
                        </div>
                    </div>
                </div>

            </form>
            <!-- END MAIN CONTENT -->
        </div>
    </div>
</div>
<script type="text/javascript">
    <!-- Start of HostJars Support Zendesk Widget script -->
    /*<![CDATA[*/window.zEmbed||function(e,t){var n,o,d,i,s,a=[],r=document.createElement("iframe");window.zEmbed=function(){a.push(arguments)},window.zE=window.zE||window.zEmbed,r.src="javascript:false",r.title="",r.role="presentation",(r.frameElement||r).style.cssText="display: none",d=document.getElementsByTagName("script"),d=d[d.length-1],d.parentNode.insertBefore(r,d),i=r.contentWindow,s=i.document;try{o=s}catch(c){n=document.domain,r.src='javascript:var d=document.open();d.domain="'+n+'";void(0);',o=s}o.open()._l=function(){var o=this.createElement("script");n&&(this.domain=n),o.id="js-iframe-async",o.src=e,this.t=+new Date,this.zendeskHost=t,this.zEQueue=a,this.body.appendChild(o)},o.write('<body onload="document._l();">'),o.close()}("//assets.zendesk.com/embeddable_framework/main.js","hostjars.zendesk.com");/*]]>*/
    <!-- End of HostJars Support Zendesk Widget script -->

    $("#deleteProfile").click(function(e) {
        current_selected = document.settings_form.settings_groupname.value;
        if (current_selected) {
            $.post('<?php echo $ajax_action ?>', {'profile_name':current_selected}, function(data) {
                if (data != 'error') {
                    $("option[value='"+current_selected+"']").remove();
                }
                alert(data);
            });
        }
        e.preventDefault();
        return false;
    });
</script>
<?php echo $footer; ?>
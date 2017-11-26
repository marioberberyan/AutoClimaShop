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
        <a href="<?php echo $download_log; ?>" type="button" data-toggle="tooltip" title="Download Log" class='btn btn-primary'><i class="fa fa-download"></i></a>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="Home" class="btn btn-primary"><i class="fa fa-home"></i></a>
    </div>
    <h1><?php echo $heading_title; ?></h1>
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-question-circle"></i> <?php echo $error_warning; ?>
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
            <ul id="tabs" class="nav nav-tabs"><li class="active"><a data-toggle="tab" href="#tab_fetch"><?php echo $tab_log;?></a></li></ul>
            <textarea wrap="off" rows="15" readonly="readonly" class="form-control"><?php echo $log;?></textarea>
        </div>
    </div>
</div>
<?php echo $footer; ?>
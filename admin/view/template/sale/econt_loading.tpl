<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
	    <a onclick="window.open('<?php echo $courier; ?>');" class="btn btn-primary"><?php echo $button_courier; ?></a>
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
    <table class="table table-bordered table-hover">
      <tr>
        <td style="width: 300px;"><?php echo $entry_loading_num; ?></td>
        <td><?php echo $loading['loading_num']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_is_imported; ?></td>
        <td><?php if ((int)$loading['is_imported']) { ?>
          <?php echo $text_yes; ?>
          <?php } else { ?>
          <?php echo $text_no; ?>
          <?php } ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_storage; ?></td>
        <td><?php echo $loading['storage']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_person; ?></td>
        <td><?php echo $loading['receiver_person']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_person_phone; ?></td>
        <td><?php echo $loading['receiver_person_phone']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_courier; ?></td>
        <td><?php echo $loading['receiver_courier']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_courier_phone; ?></td>
        <td><?php echo $loading['receiver_courier_phone']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_time; ?></td>
        <td><?php echo $loading['receiver_time']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_cd_get_sum; ?></td>
        <td><?php echo $loading['cd_get_sum']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_cd_get_time; ?></td>
        <td><?php echo $loading['cd_get_time']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_cd_send_sum; ?></td>
        <td><?php echo $loading['cd_send_sum']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_cd_send_time; ?></td>
        <td><?php echo $loading['cd_send_time']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_total_sum; ?></td>
        <td><?php echo $loading['total_sum']; ?> <?php echo $loading['currency']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_sender_ammount_due; ?></td>
        <td><?php echo $loading['sender_ammount_due']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_ammount_due; ?></td>
        <td><?php echo $loading['receiver_ammount_due']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_other_ammount_due; ?></td>
        <td><?php echo $loading['other_ammount_due']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_delivery_attempt_count; ?></td>
        <td><?php echo $loading['delivery_attempt_count']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_blank_yes; ?></td>
        <td><?php if ($loading['blank_yes']) { ?>
          <a href="<?php echo $loading['blank_yes']; ?>" target="_blank"><?php echo $text_view; ?></a>
          <?php } ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_blank_no; ?></td>
        <td><?php if ($loading['blank_no']) { ?>
          <a href="<?php echo $loading['blank_no']; ?>" target="_blank"><?php echo $text_view; ?></a>
          <?php } ?></td>
      </tr>
      <?php if ($loading['pdf_url']) { ?>
      <tr>
        <td><?php echo $entry_pdf_url; ?></td>
        <td><a href="<?php echo $loading['pdf_url']; ?>" target="_blank"><?php echo $text_view; ?></a></td>
      </tr>
      <?php } ?>
    </table>
    <?php if ($loading['trackings']) { ?>
    <b><?php echo $entry_tracking; ?></b>
    <table class="list">
      <thead>
        <tr>
          <td class="left"><?php echo $entry_time; ?></td>
          <td class="left"><?php echo $entry_is_receipt; ?></td>
          <td class="left"><?php echo $entry_event; ?></td>
          <td class="left"><?php echo $entry_name; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($loading['trackings'] as $tracking) { ?>
        <tr>
          <td class="left"><?php echo $tracking['time']; ?></td>
          <td class="left"><?php echo $tracking['is_receipt']; ?></td>
          <td class="left"><?php echo $tracking['event']; ?></td>
          <td class="left"><?php echo $tracking['name']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
    <?php } ?>
    <?php if ($loading['next_parcels']) { ?>
    <b><?php echo $entry_next_parcels; ?></b>
    <?php foreach ($loading['next_parcels'] as $next_parcel) { ?>
    <table class="form">
      <tr>
        <td style="width: 300px;"><?php echo $entry_loading_num; ?></td>
        <td><?php echo $next_parcel['loading_num']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_is_imported; ?></td>
        <td><?php if ((int)$next_parcel['is_imported']) { ?>
          <?php echo $text_yes; ?>
          <?php } else { ?>
          <?php echo $text_no; ?>
          <?php } ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_storage; ?></td>
        <td><?php echo $next_parcel['storage']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_person; ?></td>
        <td><?php echo $next_parcel['receiver_person']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_person_phone; ?></td>
        <td><?php echo $next_parcel['receiver_person_phone']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_courier; ?></td>
        <td><?php echo $next_parcel['receiver_courier']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_courier_phone; ?></td>
        <td><?php echo $next_parcel['receiver_courier_phone']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_time; ?></td>
        <td><?php echo $next_parcel['receiver_time']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_cd_get_sum; ?></td>
        <td><?php echo $next_parcel['cd_get_sum']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_cd_get_time; ?></td>
        <td><?php echo $next_parcel['cd_get_time']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_cd_send_sum; ?></td>
        <td><?php echo $next_parcel['cd_send_sum']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_cd_send_time; ?></td>
        <td><?php echo $next_parcel['cd_send_time']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_total_sum; ?></td>
        <td><?php echo $next_parcel['total_sum']; ?> <?php echo $next_parcel['currency']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_sender_ammount_due; ?></td>
        <td><?php echo $next_parcel['sender_ammount_due']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_receiver_ammount_due; ?></td>
        <td><?php echo $next_parcel['receiver_ammount_due']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_other_ammount_due; ?></td>
        <td><?php echo $next_parcel['other_ammount_due']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_delivery_attempt_count; ?></td>
        <td><?php echo $next_parcel['delivery_attempt_count']; ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_blank_yes; ?></td>
        <td><?php if ($next_parcel['blank_yes']) { ?>
          <a href="<?php echo $next_parcel['blank_yes']; ?>" target="_blank"><?php echo $text_view; ?></a>
          <?php } ?></td>
      </tr>
      <tr>
        <td><?php echo $entry_blank_no; ?></td>
        <td><?php if ($next_parcel['blank_no']) { ?>
          <a href="<?php echo $next_parcel['blank_no']; ?>" target="_blank"><?php echo $text_view; ?></a>
          <?php } ?></td>
      </tr>
      <?php if ($next_parcel['pdf_url']) { ?>
      <tr>
        <td><?php echo $entry_pdf_url; ?></td>
        <td><a href="<?php echo $next_parcel['pdf_url']; ?>" target="_blank"><?php echo $text_view; ?></a></td>
      </tr>
      <?php } ?>
    </table>
    <?php if ($next_parcel['trackings']) { ?>
    <b><?php echo $entry_tracking; ?></b>
    <table class="list">
      <thead>
        <tr>
          <td class="left"><?php echo $entry_time; ?></td>
          <td class="left"><?php echo $entry_is_receipt; ?></td>
          <td class="left"><?php echo $entry_event; ?></td>
          <td class="left"><?php echo $entry_name; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($next_parcel['trackings'] as $tracking) { ?>
        <tr>
          <td class="left"><?php echo $tracking['time']; ?></td>
          <td class="left"><?php echo $tracking['is_receipt']; ?></td>
          <td class="left"><?php echo $tracking['event']; ?></td>
          <td class="left"><?php echo $tracking['name']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
    </table>
    <?php } ?>
    <?php } ?>
    <?php } ?>
    </div>
  </div>
</div>
<?php echo $footer; ?>
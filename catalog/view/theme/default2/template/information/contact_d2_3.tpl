<?php echo $header; ?>

<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>

  <div class="row">
    <?php if ($position_top_a || $position_top_b || $position_top_c) { ?>
      <div class="col-sm-12 position-container position-top">
        <?php echo $position_top_a . $position_top_b . $position_top_c; ?>
      </div>
    <?php } ?>
    <?php echo $column_left; ?>

    <?php
      if ($column_left && $column_right) {
        $class = 'col-sm-6';
      } elseif ($column_left || $column_right) {
        $class = 'col-sm-9';
      } else {
        $class = 'col-sm-12';
      }
    ?>
    <div id="content" class="<?php echo $class; ?>">
      <?php echo $content_top; ?>

      <h1 class="page-title"><?php echo $heading_title; ?></h1>

      <div class="row">
        <div class="col-xs-12">
          <h3 class="section-title"><?php echo $text_location; ?></h3>
        </div>

        <?php if ($default2['contact_map'] && $geocode) { ?>
          <div class="col-md-6">
            <div class="bs-google-map">
              <div id="map-container" class="map-container" style="height:225px;"></div>

              <script src="//maps.google.com/maps/api/js?sensor=false"></script>
              <script>
                function init_map() {
                  var var_location    = new google.maps.LatLng(<?php echo $geocode; ?>);
                  var var_mapoptions  = {
                    center: var_location,
                    zoom: 15
                  };
                  var var_marker      = new google.maps.Marker({
                    position: var_location,
                    map: var_map,
                    title:"Venice"});
                  var var_map         = new google.maps.Map(document.getElementById('map-container'),
                      var_mapoptions);

                  var_marker.setMap(var_map); 
                }

                google.maps.event.addDomListener(window, 'load', init_map);
              </script>
            </div>
          </div>
        <?php } ?>

        <div class="col-md-6">
          <div class="info-address">
            <div class="row">
              <?php if ($image) { ?>
                <div class="col-sm-4">
                  <img src="<?php echo $image; ?>" itemprop="logo" alt="<?php echo $store; ?>" title="<?php echo $store; ?>" class="img-thumbnail store-logo" />

                  <?php if (!$default2['contact_map'] && $geocode) { ?>
                    <div class="text-center">
                      <a href="https://maps.google.com/maps?q=<?php echo urlencode($geocode); ?>&hl=en&t=m&z=15" target="_blank" class="btn btn-info btn-xs">
                        <i class="fa fa-map-marker"></i> <?php echo $button_map; ?>
                      </a>
                    </div>
                  <?php } ?>
                </div>
              <?php } ?>
              <div class="col-sm-8">
                <div class="store-name"><?php echo $store; ?></div>
                <div class="store-address"><?php echo $address; ?></div>

                <dl class="dl-horizontal store-contact">
                  <dt><?php echo $text_telephone; ?></dt>
                    <dd><?php echo $telephone; ?></dd>
                  <?php if ($fax) { ?>
                    <dt><?php echo $text_fax; ?></dt>
                      <dd><?php echo $fax; ?></dd>
                  <?php } ?>
                  <?php if ($open) { ?>
                    <dt><?php echo $text_open; ?></dt>
                      <dd><?php echo $open; ?></dd>
                  <?php } ?>
                  <?php if ($comment) { ?>
                    <dt><?php echo $text_comment; ?></dt>
                      <dd><?php echo $comment; ?></dd>
                  <?php } ?>
                </dl>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="row">
        <div class="col-md-6">
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal info-form">
            <fieldset>
              <h3 class="section-title"><?php echo $text_contact; ?></h3>

              <div class="form-group required">
                <label class="col-sm-4 control-label" for="input-name"><?php echo $entry_name; ?></label>
                <div class="col-sm-8">
                  <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
                  <?php if ($error_name) { ?>
                  <div class="text-danger"><?php echo $error_name; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-4 control-label" for="input-email"><?php echo $entry_email; ?></label>
                <div class="col-sm-8">
                  <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
                  <?php if ($error_email) { ?>
                  <div class="text-danger"><?php echo $error_email; ?></div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group required">
                <label class="col-sm-4 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
                <div class="col-sm-8">
                  <textarea name="enquiry" rows="7" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
                  <?php if ($error_enquiry) { ?>
                  <div class="text-danger"><?php echo $error_enquiry; ?></div>
                  <?php } ?>
                </div>
              </div>
              <?php echo $captcha; ?>
            </fieldset>
            <div class="buttons">
              <div class="pull-right">
                <input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" />
              </div>
            </div>
          </form>
        </div>

        <div class="col-md-6">
          <?php if ($locations) { ?>
            <div class="info-store">
              <h4 class="section-title"><?php echo $text_store; ?></h4>

              <div class="row row-condensed">
                <?php foreach ($locations as $location) { ?>
                  <div class="col-xs-6 col-sm-4 col-md-6 store-list mh-location">
                    <div class="panel-condensed">
                      <div class="panel-body">
                        <div class="store-name"><?php echo $location['name']; ?></div>
                        <div class="store-address"><?php echo $location['address']; ?></div>

                        <ul class="list-unstyled">
                          <li><i class="fa fa-phone fa-fw"></i> <?php echo $location['telephone']; ?></li>
                          <?php if ($location['fax']) { ?>
                            <li><i class="fa fa-fax fa-fw"></i> <?php echo $location['fax']; ?></li>
                          <?php } ?>
                          <?php if ($location['open']) { ?>
                            <li class="clearfix">
                                <i class="fa fa-clock-o fa-fw pull-left"></i> <div class="pull-left"><?php echo $location['open']; ?></div>
                            </li>
                          <?php } ?>
                          <?php if ($location['comment']) { ?>
                            <li class="clearfix">
                              <i class="fa fa-comment fa-fw pull-left"></i> <div class="pull-left"><?php echo $location['comment']; ?></div>
                            </li>
                          <?php } ?>
                        </ul>

                        <?php if ($location['geocode']) { ?>
                          <div class="text-right">
                            <a href="https://maps.google.com/maps?q=<?php echo urlencode($location['geocode']); ?>&hl=en&t=m&z=15" target="_blank" class="btn btn-info btn-xs">
                              <i class="fa fa-map-marker"></i> <?php echo $button_map; ?>
                            </a>
                          </div>
                        <?php } ?>
                      </div>
                    </div>
                  </div>
                <?php } ?>
              </div>
            </div>

            <script>
            $(document).ready(function()
            {
              $('.mh-location').matchHeight();
            });
            </script>
          <?php } ?>
        </div>
      </div>

      <?php echo $content_bottom; ?>
    </div>

    <?php echo $column_right; ?>
    <?php if ($position_bottom_a || $position_bottom_b || $position_bottom_c) { ?>
      <div class="col-sm-12 position-container position-bottom">
        <?php echo $position_bottom_a . $position_bottom_b . $position_bottom_c; ?>
      </div>
    <?php } ?>
  </div>

</div>
<?php echo $footer; ?>
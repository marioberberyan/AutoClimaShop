<div class="module-carousel">
  <div id="carousel<?php echo $module; ?>" class="owl-carousel">
    <?php foreach ($banners as $banner) { ?>
      <div class="item text-center">
        <?php if ($banner['link']) { ?>
          <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
        <?php } else { ?>
          <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
        <?php } ?>
      </div>
    <?php } ?>
  </div>
  <script>
  $('#carousel<?php echo $module; ?>').owlCarousel({
    items : 7,
    itemsDesktop : [1199,6],
    itemsDesktopSmall : [980,4],
    itemsTablet: [768,4],
    itemsTabletSmall: [630,3],
    itemsMobile : [479,2],
    autoPlay: 3000,
    navigation: true,
    scrollPerPage: true,
    navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
    pagination: true
  });
  </script>
</div>
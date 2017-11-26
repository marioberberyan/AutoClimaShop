<?php if ($reviews) { ?>
  <?php $class = 'odd'; ?>
  <ul class="list-unstyled">
    <?php foreach ($reviews as $review) { ?>
      <?php $class = ($class == 'even') ? 'odd' : 'even'; ?>

      <li class="<?php echo $class; ?>">
        <div class="panel panel-default">
          <div class="panel-heading">
            <b><?php echo $review['author']; ?></b> - <?php echo $review['date_added']; ?>
            <div class="pull-right">
              <div class="rating">
                <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <span class="star">
                    <?php if ($review['rating'] < $i) { ?>
                        <i class="fa fa-star-o fa-lg text-muted"></i>
                    <?php } else { ?>
                        <i class="fa fa-star fa-lg text-warning"></i>
                    <?php } ?>
                  </span>
                <?php } ?>
              </div>
            </div>
          </div>
          <div class="panel-body">
            <?php echo $review['text']; ?>
          </div>
        </div>
      </li>
    <?php } ?>
  </ul>

  <div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
  <p><?php echo $text_no_reviews; ?></p>
<?php } ?>

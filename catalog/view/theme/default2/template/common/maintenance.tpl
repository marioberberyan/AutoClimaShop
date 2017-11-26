<?php echo $header; ?>

<div class="maintenance">
  <div class="container">
    <div class="row">
      <div class="col-sm-8 col-sm-offset-2 text-center">
        <div class="panel panel-default">
          <div class="panel-body">
            <?php echo $message; ?>
          </div>
        </div>
      </div>
    </div>
  </div>

<script>
$('body').addClass('blank-mode');
</script>

</div>
<?php echo $footer; ?>
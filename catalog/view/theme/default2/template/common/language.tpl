<?php if (count($languages) > 1) { ?>
  <form action="<?php echo $action; ?>" method="post" id="language">
    <div class="dropdown dropdown-hover bs-dropdown-tight">
      <a class="dropdown-toggle" data-toggle="dropdown">
        <?php foreach ($languages as $language) { ?>
          <?php if ($language['code'] == $code) { ?>
            <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" class="visible-xs-inline">
            <span class="hidden-xs"><?php echo $language['name']; ?></span>
            <span class="caret"></span>
          <?php } ?>
        <?php } ?>
      </a>
      <ul class="dropdown-menu bs-dropdown-sm">
        <?php foreach ($languages as $language) { ?>
          <li>
            <a class="language-select" href="<?php echo $language['code']; ?>">
              <img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" />
              <?php echo $language['name']; ?>
            </a>
          </li>
        <?php } ?>
      </ul>
    </div>
    <input type="hidden" name="code" value="" />
    <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
  </form>
<?php } ?>
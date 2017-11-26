<?php
/**
 * @package     default2 Theme
 * @author      EchoThemes, http://www.echothemes.com
 * @copyright   Copyright (c) 2015, EchoThemes
 * @license     GPLv3 or later, http://www.gnu.org/licenses/gpl-3.0.html
 */

echo $header; ?>
<?php echo $menu; ?>

<div id="content">

<ul class="uk-breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php if ($breadcrumb['href']) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>" class="uk-link"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } else { ?>
            <li class="<?php echo ($breadcrumb['class'] == 'active') ? 'uk-active' : ''; ?>"><span><?php echo $breadcrumb['text']; ?></span></li>
        <?php } ?>
    <?php } ?>
</ul>

<div class="uk-container uk-container-center">
<form id="js-app-form" action="<?php echo $form_action; ?>" method="post" class="uk-form">

<div class="uk-grid app-header">
    <div class="uk-width-1-3">
        <h2 class="app-title">
            <?php echo $ext_name; ?>
            <span class="uk-text-medium">v<?php echo $ext_version; ?></span>
        </h2>
    </div>
    <div class="uk-width-2-3">
        <div class="app-action uk-float-right">
            <div class="uk-display-inline">
                <?php echo $text_store; ?>
                <select name="store_id" class="uk-form-small uk-margin-right store-select">
                    <option value="0" <?php echo (!$store_id) ? 'selected' : ''; ?>><?php echo $store_default; ?></option>
                    <?php foreach ($stores as $store) { ?>
                        <option value="<?php echo $store['store_id']; ?>" <?php echo ($store['store_id'] == $store_id) ? 'selected' : ''; ?>><?php echo $store['name']; ?></option>
                    <?php } ?>
                </select>
            </div>
            <div class="uk-display-inline">
                <?php echo $text_preset; ?>
                <select name="preset_id" class="uk-form-small uk-margin-right preset-select">
                    <?php foreach ($presets as $preset) { ?>
                        <option value="<?php echo $preset['preset_id']; ?>" <?php echo ($preset['preset_id'] == $preset_id) ? 'selected' : ''; ?>><?php echo ($preset['preset_id'] == $store_preset_id) ? '[v]' : ''; ?> <?php echo $preset['preset_name']; ?></option>
                    <?php } ?>
                </select>
            </div>
        </div>
    </div>
</div>

<?php foreach ($alerts as $alert) { ?>
    <?php if (isset(${'alert_'.$alert})) { ?>
        <div class="uk-alert uk-alert-<?php echo $alert; ?>" data-uk-alert>
            <a class="uk-alert-close uk-close"></a>
            <p><?php echo ${'alert_'.$alert}; ?></p>
        </div>
    <?php } ?>
<?php } ?>

<div class="et-content-border">
    <div id="et-content">

    <div class="uk-grid">
        <div class="uk-width-1-1">
            <div class="uk-panel preset-panel">
                <h3 class="preset-title uk-margin-remove uk-float-left">
                    <i class="uk-icon-qrcode uk-icon-nano"></i>
                    <input type="text" name="preset_name" value="<?php echo $setting['preset_name'] ?>" class="uk-form-blank" data-uk-tooltip="{pos:'right'}" title="Change preset name">
                </h3>
                
                <div class="uk-float-right save-action">
                    <a id="js-actionSave" class="uk-button uk-button-success"><i class="uk-icon-save uk-icon-nano"></i> <?php echo $text_save; ?></a>
                    <div class="uk-button-dropdown" data-uk-dropdown="">
                        <a class="uk-button"><i class="uk-icon-qrcode uk-icon-nano"></i> <?php echo $text_preset; ?></a>
                        <div class="uk-dropdown uk-dropdown-small uk-dropdown-flip">
                            <ul class="uk-nav uk-nav-dropdown">
                                <li><a id="js-actionNew"><i class="uk-icon-file-o"></i> <?php echo $text_new; ?></a></li>
                                <li><a id="js-actionCopy"><i class="uk-icon-copy"></i> <?php echo $text_save_as_copy; ?></a></li>
                                <li class="uk-nav-divider"></li>
                                <!--<li><a id="js-actionReset"><i class="uk-icon-undo"></i> Reset</a></li>-->
                                <li><a id="js-actionDelete"><i class="uk-icon-trash-o"></i> <?php echo $text_delete; ?></a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <?php if ($store_preset_id != $preset_id) { ?>
                        <a id="js-actionActivate" class="uk-button uk-margin-small-left" data-uk-tooltip="{pos:'bottom-right'}" title="Activate preset for current store"><i class="uk-icon-check-circle uk-icon-nano"></i> <?php echo $text_activate; ?></a>
                    <?php } ?>
                </div>

                <div class="uk-hidden">
                    <input type="hidden" id="is-activate" name="is_activate" value="<?php echo ($store_preset_id == $preset_id) ? 1 : 0; ?>">
                </div>
            </div>

            <div class="uk-divider uk-margin-medium-bottom"></div>

            <div class="uk-grid content-setting">
                <div class="uk-width-1-6 et-sidebar-tab">
                    <ul class="uk-tab uk-tab-left" data-uk-tab="{connect:'#content-main'}">
                        <li><a><?php echo $text_styling; ?></a></li>
                        <li><a><?php echo $text_template; ?></a></li>
                        <li><a><?php echo $text_block_layout; ?></a></li>
                        <li><a><?php echo $text_about; ?></a></li>
                    </ul>
                </div>
                <div class="uk-width-5-6 uk-form-horizontal et-label-narrow">
                    <div id="content-main" class="uk-switcher">
                        <!-- Styling -->
                        <div class="uk-animation-fade tab-styling et-form-striped-row">
                            <h2 class="uk-section"><?php echo $text_sec_typography; ?></h2>

                            <div class="uk-form-row">
                                <label class="uk-form-label" for="heading-font"><?php echo $text_heading_font; ?></label>
                                <div class="uk-form-controls">
                                    <select name="font_header" id="heading-font" class="uk-width-9-20">
                                        <?php foreach ($fonts as $key => $font) { ?>
                                            <optgroup label="<?php echo $key; ?>">
                                                <?php foreach ($font as $key => $value) { ?>
                                                    <option value="<?php echo $key; ?>" <?php echo ($key == $setting['font_header']) ? 'selected' : ''; ?>><?php echo $value; ?></option>
                                                <?php } ?>
                                            </optgroup>
                                        <?php } ?>
                                    </select>
                                    <div class="et-form-help et-form-help-right"><?php echo $text_heading_font_help; ?></div>
                                </div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label" for="base-font"><?php echo $text_body_font; ?></label>
                                <div class="uk-form-controls">
                                    <select name="font_base" id="base-font" class="uk-width-9-20">
                                        <?php foreach ($fonts as $key => $font) { ?>
                                            <optgroup label="<?php echo $key; ?>">
                                                <?php foreach ($font as $key => $value) { ?>
                                                    <option value="<?php echo $key; ?>" <?php echo ($key == $setting['font_base']) ? 'selected' : ''; ?>><?php echo $value; ?></option>
                                                <?php } ?>
                                            </optgroup>
                                        <?php } ?>
                                    </select>
                                    <div class="et-form-help et-form-help-right"><?php echo $text_body_font_help; ?></div>
                                </div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label" for="font-size"><?php echo $text_font_size; ?></label>
                                <div class="uk-form-controls">
                                    <input type="text" id="font-size" name="font_size" value="<?php echo $setting['font_size'] ?>" placeholder="14px" class="uk-width-1-10">
                                    <div class="et-form-help et-form-help-right"><?php echo $text_font_size_help; ?></div>
                                </div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label" for="font-color"><?php echo $text_font_color; ?></label>
                                <div class="uk-form-controls">
                                    <input type="text" id="font-color" name="font_color" value="<?php echo $setting['font_color'] ?>" placeholder="#383838" class="js-minicolors">
                                    <div class="et-form-help et-form-help-right"><?php echo $text_font_color_help; ?></div>
                                </div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label" for="link-color"><?php echo $text_link_color; ?></label>
                                <div class="uk-form-controls">
                                    <input type="text" id="link-color" name="link_color" value="<?php echo $setting['link_color'] ?>" placeholder="#4365e0" class="js-minicolors">
                                    <div class="et-form-help et-form-help-right"><?php echo $text_link_color_help; ?></div>
                                </div>
                            </div>

                            <h2 class="uk-section"><?php echo $text_btn; ?></h2>
                            <div class="uk-form-row">
                                <div class="uk-form-controls">
                                    <div class="uk-width-1-6 uk-text-center uk-text-bold uk-float-left"><?php echo $text_btn_text; ?></div>
                                    <div class="uk-width-2-6 uk-text-center uk-text-bold uk-float-left"><?php echo $text_btn_background; ?></div>
                                </div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label" for="btn-primary-color"><?php echo $text_btn_primary; ?></label>
                                <div class="uk-form-controls">
                                    <div class="uk-width-1-4 uk-float-left">
                                        <input type="text" id="btn-primary-color" name="btn_primary_color" value="<?php echo $setting['btn_primary_color'] ?>" placeholder="#fff" class="js-minicolors">
                                    </div>
                                    <div class="uk-width-1-4 uk-float-left">
                                        <input type="text" id="btn-primary-bg" name="btn_primary_bg" value="<?php echo $setting['btn_primary_bg'] ?>" placeholder="#4365e0" class="js-minicolors">
                                    </div>
                                    <div class="et-form-help et-form-help-right"><?php echo $text_btn_primary_help; ?></div>
                                </div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label" for="btn-cart-color"><?php echo $text_btn_cart; ?></label>
                                <div class="uk-form-controls">
                                    <div class="uk-width-1-4 uk-float-left">
                                        <input type="text" id="btn-cart-color" name="btn_cart_color" value="<?php echo $setting['btn_cart_color'] ?>" placeholder="#fff" class="js-minicolors">
                                    </div>
                                    <div class="uk-width-1-4 uk-float-left">
                                        <input type="text" id="btn-cart-bg" name="btn_cart_bg" value="<?php echo $setting['btn_cart_bg'] ?>" placeholder="#4365e0" class="js-minicolors">
                                    </div>
                                    <div class="et-form-help et-form-help-right"><?php echo $text_btn_cart_help; ?></div>
                                </div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label" for="btn-wishlist-color"><?php echo $text_btn_wishlist; ?></label>
                                <div class="uk-form-controls">
                                    <div class="uk-width-1-4 uk-float-left">
                                        <input type="text" id="btn-wishlist-color" name="btn_wishlist_color" value="<?php echo $setting['btn_wishlist_color'] ?>" placeholder="#383838" class="js-minicolors">
                                    </div>
                                    <div class="uk-width-1-4 uk-float-left">
                                        <input type="text" id="btn-wishlist-bg" name="btn_wishlist_bg" value="<?php echo $setting['btn_wishlist_bg'] ?>" placeholder="#fff" class="js-minicolors">
                                    </div>
                                    <div class="et-form-help et-form-help-right"><?php echo $text_btn_wishlist_help; ?></div>
                                </div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label" for="btn-compare-color"><?php echo $text_btn_compare; ?></label>
                                <div class="uk-form-controls">
                                    <div class="uk-width-1-4 uk-float-left">
                                        <input type="text" id="btn-compare-color" name="btn_compare_color" value="<?php echo $setting['btn_compare_color'] ?>" placeholder="#383838" class="js-minicolors">
                                    </div>
                                    <div class="uk-width-1-4 uk-float-left">
                                        <input type="text" id="btn-compare-bg" name="btn_compare_bg" value="<?php echo $setting['btn_compare_bg'] ?>" placeholder="#fff" class="js-minicolors">
                                    </div>
                                    <div class="et-form-help et-form-help-right"><?php echo $text_btn_compare_help; ?></div>
                                </div>
                            </div>
                        </div>

                        <!-- Templates -->
                        <div class="uk-animation-fade tab-template">
                            <ul class="uk-tab" data-uk-tab="{connect:'#content-templates'}">
                                <li><a><?php echo $text_category; ?></a></li>
                                <li><a><?php echo $text_product; ?></a></li>
                                <li><a><?php echo $text_contact; ?></a></li>
                                <li><a><?php echo $text_404_notfound; ?></a></li>
                                <li><a><?php echo $text_modules; ?></a></li>
                            </ul>

                            <div id="content-templates" class="uk-switcher uk-margin-top">
                                <!-- Category -->
                                <div class="uk-animation-fade">
                                    <h2 class="uk-section"><?php echo $text_sec_template; ?></h2>
                                    <p class="et-form-help"><?php echo $text_cat_template_help; ?></p>

                                    <div class="uk-button-group uk-button-layout-chooser" data-uk-button-radio>
                                        <label for="template-category-1" class="uk-button <?php echo ($setting['template_category'] == '1') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-category-1.png" alt=""></label>
                                        <label for="template-category-2" class="uk-button <?php echo ($setting['template_category'] == '2') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-category-2.png" alt=""></label>
                                    </div>
                                    <div class="uk-hidden">
                                        <input type="radio" id="template-category-1" name="template_category" value="1" <?php echo ($setting['template_category'] == '1') ? 'checked' : ''; ?>>
                                        <input type="radio" id="template-category-2" name="template_category" value="2" <?php echo ($setting['template_category'] == '2') ? 'checked' : ''; ?>>
                                    </div>
                                    <div class="uk-grid uk-text-center">
                                        <div class="uk-width-1-4"><?php echo $text_hash1; ?></div>
                                        <div class="uk-width-1-4"><?php echo $text_hash2; ?></div>
                                    </div>

                                    <h4><?php echo $text_specific_template; ?></h4>
                                    <p class="et-form-help"><?php echo $text_specific_cat_template_help; ?></p>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label" for="template-category-specific-1"><?php echo $text_sec_template_1; ?></label>
                                        <div class="uk-form-controls">
                                            <input type="text" id="template-category-specific-1" name="template_category_specific_1" value="<?php echo $setting['template_category_specific_1']; ?>" class="uk-width-8-10" placeholder="1, 2, 3">
                                        </div>
                                    </div>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label" for="template-category-specific-2"><?php echo $text_sec_template_2; ?></label>
                                        <div class="uk-form-controls">
                                            <input type="text" id="template-category-specific-2" name="template_category_specific_2" value="<?php echo $setting['template_category_specific_2']; ?>" class="uk-width-8-10" placeholder="1, 2, 3">
                                        </div>
                                    </div>

                                    <h2 class="uk-section"><?php echo $text_sec_template_1; ?></h2>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label"><?php echo $text_child_category_thumb; ?></label>
                                        <div class="uk-form-controls">
                                            <div class="uk-button-group" data-uk-button-radio>
                                                <label for="child-category-thumb-1" class="uk-button uk-button-primary-active <?php echo ($setting['child_category_thumb']) ? 'uk-active' : ''; ?>"><?php echo $text_show; ?></label>
                                                <label for="child-category-thumb-0" class="uk-button uk-button-danger-active  <?php echo (!$setting['child_category_thumb']) ? 'uk-active' : ''; ?>"><?php echo $text_hide; ?></label>
                                            </div>
                                            <div class="uk-hidden">
                                                <input type="radio" id="child-category-thumb-1" name="child_category_thumb" value="1" <?php echo ($setting['child_category_thumb']) ? 'checked' : ''; ?>>
                                                <input type="radio" id="child-category-thumb-0" name="child_category_thumb" value="0" <?php echo (!$setting['child_category_thumb']) ? 'checked' : ''; ?>>
                                            </div>
                                            <div class="et-form-help et-form-help-right"><?php echo $text_child_category_thumb_help; ?></div>
                                        </div>
                                    </div>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label"><?php echo $text_grid_product_desc; ?></label>
                                        <div class="uk-form-controls">
                                            <div class="uk-button-group" data-uk-button-radio>
                                                <label for="grid-product-desc-1" class="uk-button uk-button-primary-active <?php echo ($setting['grid_product_desc']) ? 'uk-active' : ''; ?>"><?php echo $text_show; ?></label>
                                                <label for="grid-product-desc-0" class="uk-button uk-button-danger-active  <?php echo (!$setting['grid_product_desc']) ? 'uk-active' : ''; ?>"><?php echo $text_hide; ?></label>
                                            </div>
                                            <div class="uk-hidden">
                                                <input type="radio" id="grid-product-desc-1" name="grid_product_desc" value="1" <?php echo ($setting['grid_product_desc']) ? 'checked' : ''; ?>>
                                                <input type="radio" id="grid-product-desc-0" name="grid_product_desc" value="0" <?php echo (!$setting['grid_product_desc']) ? 'checked' : ''; ?>>
                                            </div>
                                            <div class="et-form-help et-form-help-right"><?php echo $text_grid_product_desc_help; ?></div>
                                        </div>
                                    </div>

                                    <h2 class="uk-section"><?php echo $text_sec_template_2; ?></h2>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label" for="child-thumb-size-width"><?php echo $text_child_thumb_size; ?></label>
                                        <div class="uk-form-controls">
                                            <input type="text" id="child-thumb-size-width" name="child_thumb_size_width" value="<?php echo $setting['child_thumb_size_width']; ?>" class="uk-width-3-40"> x 
                                            <input type="text" id="" name="child_thumb_size_height" value="<?php echo $setting['child_thumb_size_height']; ?>" id="bm-cat-article-feat-image2" class="uk-width-3-40">
                                            <div class="et-form-help et-form-help-right"><?php echo $text_child_thumb_size_help; ?></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Product -->
                                <div class="uk-animation-fade">
                                    <h2 class="uk-section"><?php echo $text_sec_template; ?></h2>
                                    <p class="et-form-help"><?php echo $text_prd_template_help; ?></p>

                                    <div class="uk-button-group uk-button-layout-chooser" data-uk-button-radio>
                                        <label for="template-product-1" class="uk-button <?php echo ($setting['template_product'] == '1') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-product-1.png" alt=""></label>
                                        <label for="template-product-2" class="uk-button <?php echo ($setting['template_product'] == '2') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-product-2.png" alt=""></label>
                                    </div>
                                    <div class="uk-hidden">
                                        <input type="radio" id="template-product-1" name="template_product" value="1" <?php echo ($setting['template_product'] == '1') ? 'checked' : ''; ?>>
                                        <input type="radio" id="template-product-2" name="template_product" value="2" <?php echo ($setting['template_product'] == '2') ? 'checked' : ''; ?>>
                                    </div>
                                    <div class="uk-grid uk-text-center">
                                        <div class="uk-width-1-4"><?php echo $text_hash1; ?></div>
                                        <div class="uk-width-1-4"><?php echo $text_hash2; ?></div>
                                    </div>

                                    <h4><?php echo $text_specific_template; ?></h4>
                                    <p class="et-form-help"><?php echo $text_specific_prd_template_help; ?></p>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label" for="template-product-specific-1"><?php echo $text_sec_template_1; ?></label>
                                        <div class="uk-form-controls">
                                            <input type="text" id="template-product-specific-1" name="template_product_specific_1" value="<?php echo $setting['template_product_specific_1']; ?>" class="uk-width-8-10" placeholder="1, 2, 3">
                                        </div>
                                    </div>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label" for="template-product-specific-2"><?php echo $text_sec_template_2; ?></label>
                                        <div class="uk-form-controls">
                                            <input type="text" id="template-product-specific-2" name="template_product_specific_2" value="<?php echo $setting['template_product_specific_2']; ?>" class="uk-width-8-10" placeholder="1, 2, 3">
                                        </div>
                                    </div>

                                    <h2 class="uk-section"><?php echo $text_option; ?></h2>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label"><?php echo $text_rel_prd_desc; ?></label>
                                        <div class="uk-form-controls">
                                            <div class="uk-button-group" data-uk-button-radio>
                                                <label for="related-product-desc-1" class="uk-button uk-button-primary-active <?php echo ($setting['related_product_desc']) ? 'uk-active' : ''; ?>"><?php echo $text_show; ?></label>
                                                <label for="related-product-desc-0" class="uk-button uk-button-danger-active  <?php echo (!$setting['related_product_desc']) ? 'uk-active' : ''; ?>"><?php echo $text_hide; ?></label>
                                            </div>
                                            <div class="uk-hidden">
                                                <input type="radio" id="related-product-desc-1" name="related_product_desc" value="1" <?php echo ($setting['related_product_desc']) ? 'checked' : ''; ?>>
                                                <input type="radio" id="related-product-desc-0" name="related_product_desc" value="0" <?php echo (!$setting['related_product_desc']) ? 'checked' : ''; ?>>
                                            </div>
                                            <div class="et-form-help et-form-help-right"><?php echo $text_rel_prd_desc_help; ?></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Contact -->
                                <div class="uk-animation-fade">
                                    <h2 class="uk-section"><?php echo $text_sec_template; ?></h2>
                                    <p class="et-form-help"><?php echo $text_ctc_template_help; ?></p>

                                    <div class="uk-button-group uk-button-layout-chooser" data-uk-button-radio>
                                        <label for="template-contact-1" class="uk-button <?php echo ($setting['template_contact'] == '1') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-contact-1.png" alt=""></label>
                                        <label for="template-contact-2" class="uk-button <?php echo ($setting['template_contact'] == '2') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-contact-2.png" alt=""></label>
                                        <label for="template-contact-3" class="uk-button <?php echo ($setting['template_contact'] == '3') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-contact-3.png" alt=""></label>
                                    </div>
                                    <div class="uk-hidden">
                                        <input type="radio" id="template-contact-1" name="template_contact" value="1" <?php echo ($setting['template_contact'] == '1') ? 'checked' : ''; ?>>
                                        <input type="radio" id="template-contact-2" name="template_contact" value="2" <?php echo ($setting['template_contact'] == '2') ? 'checked' : ''; ?>>
                                        <input type="radio" id="template-contact-3" name="template_contact" value="3" <?php echo ($setting['template_contact'] == '3') ? 'checked' : ''; ?>>
                                    </div>
                                    <div class="uk-grid uk-text-center">
                                        <div class="uk-width-1-4"><?php echo $text_hash1; ?></div>
                                        <div class="uk-width-1-4"><?php echo $text_hash2; ?></div>
                                        <div class="uk-width-1-4"><?php echo $text_hash3; ?></div>
                                    </div>

                                    <h2 class="uk-section"><?php echo $text_option; ?></h2>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label"><?php echo $text_maps; ?></label>
                                        <div class="uk-form-controls">
                                            <div class="uk-button-group" data-uk-button-radio>
                                                <label for="contact-map-1" class="uk-button uk-button-primary-active <?php echo ($setting['contact_map']) ? 'uk-active' : ''; ?>"><?php echo $text_show; ?></label>
                                                <label for="contact-map-0" class="uk-button uk-button-danger-active  <?php echo (!$setting['contact_map']) ? 'uk-active' : ''; ?>"><?php echo $text_hide; ?></label>
                                            </div>
                                            <div class="uk-hidden">
                                                <input type="radio" id="contact-map-1" name="contact_map" value="1" <?php echo ($setting['contact_map']) ? 'checked' : ''; ?>>
                                                <input type="radio" id="contact-map-0" name="contact_map" value="0" <?php echo (!$setting['contact_map']) ? 'checked' : ''; ?>>
                                            </div>
                                            <div class="et-form-help et-form-help-right"><?php echo $text_ctc_map_help; ?></div>
                                        </div>
                                    </div>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label" for="geocode"><?php echo $text_geocode; ?></label>
                                        <div class="uk-form-controls">
                                            <input type="text" id="geocode" name="geocode" value="<?php echo $setting['geocode'] ?>" class="uk-width-4-10">
                                            <div class="et-form-help et-form-help-right"><?php echo $text_ctc_geocode_help; ?></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 404 -->
                                <div class="uk-animation-fade">
                                    <h2 class="uk-section"><?php echo $text_sec_template; ?></h2>
                                    <p class="et-form-help"><?php echo $text_404_template_help; ?></p>

                                    <div class="uk-button-group uk-button-layout-chooser" data-uk-button-radio>
                                        <label for="template-404-1" class="uk-button <?php echo ($setting['template_404'] == '1') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-404-1.png" alt=""></label>
                                        <label for="template-404-2" class="uk-button <?php echo ($setting['template_404'] == '2') ? 'uk-active' : ''; ?>"><img src="view/stylesheet/default2/image/layout-404-2.png" alt=""></label>
                                    </div>
                                    <div class="uk-hidden">
                                        <input type="radio" id="template-404-1" name="template_404" value="1" <?php echo ($setting['template_404'] == '1') ? 'checked' : ''; ?>>
                                        <input type="radio" id="template-404-2" name="template_404" value="2" <?php echo ($setting['template_404'] == '2') ? 'checked' : ''; ?>>
                                    </div>
                                    <div class="uk-grid uk-text-center">
                                        <div class="uk-width-1-4"><?php echo $text_hash1; ?></div>
                                        <div class="uk-width-1-4"><?php echo $text_hash2; ?></div>
                                    </div>
                                </div>

                                <!-- Modules -->
                                <div class="uk-animation-fade">
                                    <h2 class="uk-section"><?php echo $text_option; ?></h2>
                                    <div class="uk-form-row">
                                        <label class="uk-form-label"><?php echo $text_module_prd_desc; ?></label>
                                        <div class="uk-form-controls">
                                            <div class="uk-button-group" data-uk-button-radio>
                                                <label for="product-module-desc-1" class="uk-button uk-button-primary-active <?php echo ($setting['product_module_desc']) ? 'uk-active' : ''; ?>"><?php echo $text_show; ?></label>
                                                <label for="product-module-desc-0" class="uk-button uk-button-danger-active  <?php echo (!$setting['product_module_desc']) ? 'uk-active' : ''; ?>"><?php echo $text_hide; ?></label>
                                            </div>
                                            <div class="uk-hidden">
                                                <input type="radio" id="product-module-desc-1" name="product_module_desc" value="1" <?php echo ($setting['product_module_desc']) ? 'checked' : ''; ?>>
                                                <input type="radio" id="product-module-desc-0" name="product_module_desc" value="0" <?php echo (!$setting['product_module_desc']) ? 'checked' : ''; ?>>
                                            </div>
                                            <div class="et-form-help et-form-help-right"><?php echo $text_module_prd_desc_help; ?></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Block Layouts -->
                        <div class="uk-animation-fade tab-block-layouts">
                            <div class="uk-grid">
                                <div class="uk-width-4-10">
                                    <h2 class="uk-section"><?php echo $text_block_visual; ?></h2>

                                    <div class="block-visual">
                                        <div class="uk-grid">
                                            <div class="uk-width-1-2">
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary" style="padding:1px 5px;">
                                                    <?php echo $text_toolbar_top_left; ?>
                                                </div>
                                            </div>
                                            <div class="uk-width-1-2">
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary" style="padding:1px 5px;">
                                                    <?php echo $text_toolbar_top_right; ?>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="uk-grid" style="margin-bottom:15px;">
                                            <div class="uk-width-1-1">
                                                <div class="uk-panel uk-panel-box">
                                                    <?php echo $text_block_header; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary" style="padding:3px 5px;">
                                                    <?php echo $text_block_main_menu; ?>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="uk-grid">
                                            <div class="uk-width-1-1">
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_top_a; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_top_b; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_top_c; ?>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="uk-grid">
                                            <div class="uk-width-1-4">
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary" style="padding:101px 5px;">
                                                    <?php echo $text_sidebar; ?>
                                                </div>
                                            </div>
                                            <div class="uk-width-2-4">
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_content_top_a; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_content_top_a; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary">
                                                    <?php echo $text_content_top; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box">
                                                    <?php echo $text_output_content; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary">
                                                    <?php echo $text_content_bottom; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_content_bottom_a; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_content_bottom_b; ?>
                                                </div>
                                            </div>
                                            <div class="uk-width-1-4">
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary" style="padding:101px 5px;">
                                                    <?php echo $text_sidebar; ?>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="uk-grid">
                                            <div class="uk-width-1-1">
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_bottom_a; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_bottom_b; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_bottom_c; ?>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="uk-grid" style="margin-top:15px;">
                                            <div class="uk-width-1-1">
                                                <div class="uk-panel uk-panel-box uk-panel-box-red" style="padding:3px 5px;">
                                                    <?php echo $text_footer_ribbon; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_footer_a; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_footer_b; ?>
                                                </div>
                                                <div class="uk-panel uk-panel-box uk-panel-box-red">
                                                    <?php echo $text_footer_c; ?>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="uk-grid">
                                            <div class="uk-width-1-2">
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary" style="padding:1px 5px;">
                                                    <?php echo $text_toolbar_btm_left; ?>
                                                </div>
                                            </div>
                                            <div class="uk-width-1-2">
                                                <div class="uk-panel uk-panel-box uk-panel-box-primary" style="padding:1px 5px;">
                                                    <?php echo $text_toolbar_btm_right; ?>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="uk-width-6-10">
                                    <h2 class="uk-section"><?php echo $text_block_options; ?></h2>

                                    <?php foreach ($positions as $name => $title) { ?>
                                        <div class="uk-form-row">
                                            <label class="uk-form-label" for="<?php echo $name; ?>"><?php echo $title; ?></label>
                                            <div class="uk-form-controls">
                                                <select name="position_<?php echo $name; ?>" id="<?php echo $name; ?>" class="uk-width-8-10">
                                                    <?php foreach ($block_widths as $type => $blocks) { ?>
                                                        <optgroup label="<?php echo $type; ?>">
                                                            <?php foreach ($blocks as $width => $format) { ?>
                                                                <option value="<?php echo $width; ?>" <?php echo ($width == $setting['position_'.$name]) ? 'selected' : ''; ?>><?php echo $format; ?></option>
                                                            <?php } ?>
                                                        </optgroup>
                                                    <?php } ?>
                                                </select>
                                            </div>
                                        </div>
                                    <?php } ?>
                                </div>

                                <div class="uk-width-1-1 uk-margin-medium-top">
                                    <hr class="uk-grid-divider">
                                    <h2 class="uk-section"><?php echo $text_information; ?></h2>

                                    <ol>
                                        <li><b><?php echo $text_information_1; ?></b>
                                            <ol>
                                                <li><?php echo $text_information_1_1; ?></li>
                                                <li><?php echo $text_information_1_2; ?></li>
                                                <li><?php echo $text_information_1_3; ?></li>
                                            </ol>
                                        </li>
                                        <li><b><?php echo $text_information_2; ?></b>
                                            <ol>
                                                <li><?php echo $text_information_2_1; ?></li>
                                                <li><?php echo $text_information_2_2; ?></li>
                                                <li><?php echo $text_information_2_3; ?></li>
                                                <li><?php echo $text_information_2_4; ?>
                                                    <ul>
                                                        <li><?php echo $text_information_2_4_1; ?></li>
                                                        <li><?php echo $text_information_2_4_2; ?></li>
                                                        <li><?php echo $text_information_2_4_3; ?></li>
                                                        <li><?php echo $text_information_2_4_4; ?></li>
                                                    </ul>
                                                </li>
                                            </ol>
                                        </li>
                                        <li><b><?php echo $text_information_3; ?></b><br>
                                            <ol>
                                                <li><?php echo $text_information_3_1; ?>
                                                    <ul>
                                                        <li><?php echo $text_toolbar_top_left; ?></li>
                                                        <li><?php echo $text_toolbar_top_right; ?></li>
                                                        <li><?php echo $text_block_main_menu; ?></li>
                                                        <li><?php echo $text_sidebar_left; ?></li>
                                                        <li><?php echo $text_content_top_a; ?></li>
                                                        <li><?php echo $text_content_top_b; ?></li>
                                                        <li><?php echo $text_content_bottom_a; ?></li>
                                                        <li><?php echo $text_content_bottom_b; ?></li>
                                                        <li><?php echo $text_sidebar_right; ?></li>
                                                        <li><?php echo $text_footer_ribbon; ?></li>
                                                        <li><?php echo $text_footer_a; ?></li>
                                                        <li><?php echo $text_footer_b; ?></li>
                                                        <li><?php echo $text_footer_c; ?></li>
                                                        <li><?php echo $text_toolbar_btm_left; ?></li>
                                                        <li><?php echo $text_toolbar_btm_right; ?></li>
                                                        <li><?php echo $text_hidden_block_top; ?></li>
                                                        <li><?php echo $text_hidden_block_bottom; ?></li>
                                                    </ul>
                                                </li>
                                                <li><?php echo $text_information_3_2; ?>
                                                    <ul>
                                                        <li><?php echo $text_top_a; ?></li>
                                                        <li><?php echo $text_top_b; ?></li>
                                                        <li><?php echo $text_top_c; ?></li>
                                                        <li><?php echo $text_bottom_a; ?></li>
                                                        <li><?php echo $text_bottom_b; ?></li>
                                                        <li><?php echo $text_bottom_c; ?></li>
                                                    </ul>
                                                </li>
                                            </ol>
                                        </li>
                                    </ol>
                                </div>
                            </div>
                        </div>

                        <!-- About -->
                        <div class="uk-animation-fade tab-about">
                            <div class="uk-form-row">
                                <label class="uk-form-label"><?php echo $text_name; ?></label>
                                <div class="uk-form-controls"><?php echo $text_product_name; ?></div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label"><?php echo $text_version; ?></label>
                                <div class="uk-form-controls"><?php echo $text_product_version; ?></div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label"><?php echo $text_author; ?></label>
                                <div class="uk-form-controls">EchoThemes</div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label"><?php echo $text_author_url; ?></label>
                                <div class="uk-form-controls"><a href="http://www.echothemes.com" target="_blank" title="EchoThemes">www.echothemes.com</a></div>
                            </div>

                            <!-- <hr class="uk-grid-divider uk-margin-small"> -->

                            <div class="uk-form-row">
                                <label class="uk-form-label"><?php echo $text_doc; ?></label>
                                <div class="uk-form-controls"><a href="https://octave.atlassian.net/wiki/display/EXTDOCS/d2+Usages" target="_blank"><?php echo $text_doc; ?></a></div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label"><?php echo $text_support; ?></label>
                                <div class="uk-form-controls"><a href="http://forum.opencart.com/viewtopic.php?f=120&t=141723" target="_blank" title="Community Support"><?php echo $text_community_support; ?></a></div>
                            </div>
                            <div class="uk-form-row">
                                <label class="uk-form-label"><?php echo $text_changelog; ?></label>
                                <div class="uk-form-controls"><a href="https://octave.atlassian.net/wiki/display/EXTDOCS/d2+Changelog" target="_blank"><?php echo $text_changelog; ?></a></div>
                            </div>

                            <hr class="uk-grid-divider uk-margin-small">

                            <p class="uk-text-small">Other Products by EchoThemes</p>
                            <div class="uk-grid">
                                <div class="uk-width-1-3">
                                    <a href="http://www.echothemes.com/extensions/blog-manager-2.html" target="_blank">
                                        <img src="view/stylesheet/default2/image/opencart-blog-manager-2.png" alt="">
                                    </a>
                                </div>
                                <div class="uk-width-1-3">
                                    <a href="http://www.echothemes.com/extensions/customer-summary.html" target="_blank">
                                        <img src="view/stylesheet/default2/image/opencart-customer-summary.png" alt="">
                                    </a>
                                </div>
                                <div class="uk-width-1-3">
                                    <a href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=15550" target="_blank">
                                        <img src="view/stylesheet/default2/image/opencart-shortcodes.png" alt="">
                                    </a>
                                </div>
                            </div>
                        </div>

                    </div> <!-- #content-main -->
                </div>
            </div> <!-- #.content-setting -->
        </div>
    </div>

    </div> <!-- /#et-content -->
</div>

</form>
</div>

<script>
$(document).ready(function() {
    var initialSelect   = getInitStorePreset();

    swal.setDefaults({ confirmButtonColor: '#4365e0' });
    $('.js-minicolors').minicolors();

    $('.store-select').on('change', function() {
        var data = getStorePreset(),
            url  = $('base').attr('href') + 'index.php?route=extension/default2&store=' + data.store_id + '&token=<?php echo $token; ?>';

        swal({
            title: '<?php echo $js_attention; ?>',
            text: '<?php echo $js_load_store; ?>'.replace('{{store_name}}', data.store_name),
            html: true,
            showCancelButton: true,
            confirmButtonText: '<?php echo $text_continue; ?>',
            cancelButtonText: '<?php echo $text_cancel; ?>',
            closeOnConfirm: false,
        }, function(isConfirm) {
            if (isConfirm) {
                location.href = url;
            } else {
                $('.store-select').val(initialSelect.store_id);
            }
        });
    });
    $('.preset-select').on('change', function() {
        var data = getStorePreset(),
            url  = $('base').attr('href') + 'index.php?route=extension/default2&store=' + data.store_id + '&preset=' + data.preset_id + '&token=<?php echo $token; ?>';

        swal({
            title: '<?php echo $js_attention; ?>',
            text: '<?php echo $js_load_preset; ?>'.replace('{{preset_name}}', data.preset_name),
            html: true,
            showCancelButton: true,
            confirmButtonText: '<?php echo $text_continue; ?>',
            cancelButtonText: '<?php echo $text_cancel; ?>',
            closeOnConfirm: false,
        }, function(isConfirm) {
            if (isConfirm) {
                location.href = url;
            } else {
                $('.preset-select').val(initialSelect.preset_id);
            }
        });
    });

    $('#js-actionActivate').on('click', function() {
        var data = getStorePreset();

        swal({
            title: '<?php echo $js_attention; ?>',
            text: '<?php echo $js_activate_preset; ?>'.replace('{{preset_name}}', data.preset_name).replace('{{store_name}}', data.store_name),
            html: true,
            showCancelButton: true,
            confirmButtonText: "<?php echo $js_confirm_yes; ?>",
            cancelButtonText: '<?php echo $text_cancel; ?>',
            closeOnConfirm: true,
        }, function(isConfirm) {
            if (isConfirm) {
                $('#js-app-form').ajaxSubmit({
                    dataType    : 'json',
                    data        : { activate: '1' },
                    beforeSend  : function (data) {
                        $.etNotify({
                            message     : '<?php echo $js_general_activate; ?>',
                            icon        : 'refresh uk-icon-spin',
                            timeout     : 120000,
                            clear       : true,
                        });
                    },
                    success     : function (data) {
                        if (!data.error) {
                            $('.preset-select option:contains("[v]")').each(function(){
                               $(this).text($(this).text().replace('[v] ',''));    
                            });
                            $('.preset-select option:selected').text('[v] ' + data.preset_name);

                            $('#is-activate').val(1);
                            $('#js-actionActivate').hide();

                            $.etNotify({
                                message     : '<?php echo $js_success_activate; ?>',
                                icon        : 'check',
                                status      : 'success',
                                clear       : true,
                            });
                        } else {
                            $.etNotify({
                                message : data.errorMsg ? data.errorMsg : '<?php echo $js_general_error; ?>',
                                icon    : 'exclamation',
                                status  : 'danger',
                                clear   : true
                            });
                        }
                    }
                });
            }
        });
    });

    //=== Save
    $('#js-actionSave').on('click', function() {
        $('#js-app-form').ajaxSubmit({
            dataType    : 'json',
            beforeSubmit: validateBeforeSubmit,
            beforeSend  : function (data) {
                $.etNotify({
                    message     : '<?php echo $js_general_saving; ?>',
                    icon        : 'refresh uk-icon-spin',
                    timeout     : 120000,
                    clear       : true,
                });
            },
            success     : function (data) {
                if (!data.error) {
                    var preset_id   = '<?php echo $store_preset_id; ?>',
                        preset_name = (data.preset_id == preset_id) ? '[v] ' + data.preset_name : data.preset_name;

                    $('.preset-select option:selected').text(preset_name);

                    $.etNotify({
                        message     : '<?php echo $js_success_save; ?>',
                        icon        : 'check',
                        status      : 'success',
                        clear       : true,
                    });
                } else {
                    $.etNotify({
                        message : data.errorMsg ? data.errorMsg : '<?php echo $js_general_error; ?>',
                        icon    : 'exclamation',
                        status  : 'danger',
                        clear   : true
                    });
                }
            }
        });
    });

    $('#js-actionNew').on('click', function() {
        $('#js-app-form').ajaxSubmit({
            dataType    : 'json',
            data        : { newPresetId: findMaxValue($('.preset-select')) },
            beforeSend  : function (data) {
                $.etNotify({
                    message     : '<?php echo $js_general_creating; ?>',
                    icon        : 'refresh uk-icon-spin',
                    timeout     : 120000,
                    clear       : true,
                });
            },
            success     : function (data) {
                if (!data.error) {
                    $.etNotify({
                        message     : '<?php echo $js_success_create; ?>',
                        icon        : 'check',
                        status      : 'success',
                        clear       : true,
                    });
                } else {
                    $.etNotify({
                        message : data.errorMsg ? data.errorMsg : '<?php echo $js_general_error; ?>',
                        icon    : 'exclamation',
                        status  : 'danger',
                        clear   : true
                    });
                }

                if (data.redirect) {
                    $.etNotify({
                        message     : '<?php echo $js_redirect; ?>',
                        icon        : 'location-arrow',
                        status      : 'primary',
                        clear       : true,
                    });
                    setTimeout(function() {
                        window.location.replace(data.redirect);
                    }, 1000);
                }
            }
        });
    });

    $('#js-actionCopy').on('click', function() {
        $('#js-app-form').ajaxSubmit({
            dataType    : 'json',
            data        : { copyPresetId: findMaxValue($('.preset-select')) },
            beforeSubmit: validateBeforeSubmit,
            beforeSend  : function (data) {
                $.etNotify({
                    message     : '<?php echo $js_general_copying; ?>',
                    icon        : 'refresh uk-icon-spin',
                    timeout     : 120000,
                    clear       : true,
                });
            },
            success     : function (data) {
                if (!data.error) {
                    $.etNotify({
                        message     : '<?php echo $js_success_copy; ?>',
                        icon        : 'check',
                        status      : 'success',
                        clear       : true,
                    });
                } else {
                    $.etNotify({
                        message : data.errorMsg ? data.errorMsg : '<?php echo $js_general_error; ?>',
                        icon    : 'exclamation',
                        status  : 'danger',
                        clear   : true
                    });
                }

                if (data.redirect) {
                    $.etNotify({
                        message     : '<?php echo $js_redirect; ?>',
                        icon        : 'location-arrow',
                        status      : 'primary',
                        clear       : true,
                    });
                    setTimeout(function() {
                        window.location.replace(data.redirect);
                    }, 1000);
                }
            }
        });
    });

    $('#js-actionDelete').on('click', function() {
        $('#js-app-form').ajaxSubmit({
            dataType    : 'json',
            data        : { delPresetId: 1},
            beforeSend  : function (data) {
                var all_preset_store = '<?php echo $all_preset_store; ?>',
                    isActivate       = $.inArray(initialSelect.preset_id, all_preset_store);

                if (isActivate < 0) {
                    console.log('deleting');
                    $.etNotify({
                        message     : '<?php echo $js_general_delete; ?>',
                        icon        : 'refresh uk-icon-spin',
                        timeout     : 120000,
                        clear       : true,
                    });
                } else {
                    console.log('error delete');
                    $.etNotify({
                        message : '<?php echo $js_error_delete_activate; ?>',
                        icon    : 'exclamation',
                        status  : 'warning',
                        timeout     : 2000,
                        clear   : true
                    });
                    return false;
                }
            },
            success     : function (data) {
                if (!data.error) {
                    $.etNotify({
                        message     : '<?php echo $js_success_delete; ?>',
                        icon        : 'check',
                        status      : 'success',
                        clear       : true,
                    });
                } else {
                    $.etNotify({
                        message : data.errorMsg ? data.errorMsg : '<?php echo $js_general_error; ?>',
                        icon    : 'exclamation',
                        status  : 'danger',
                        clear   : true
                    });
                }

                if (data.redirect) {
                    $.etNotify({
                        message     : '<?php echo $js_redirect; ?>',
                        icon        : 'location-arrow',
                        status      : 'primary',
                        clear       : true,
                    });
                    setTimeout(function() {
                        window.location.replace(data.redirect);
                    }, 1000);
                }
            }
        });
    });
});

function validateBeforeSubmit(formData, jqForm, options) { 
    var valid = true;
}

function getInitStorePreset() {
    var data = {};

    data.store_id    = $('.store-select').val();
    data.preset_id   = $('.preset-select').val();

    return data;
}
function getStorePreset() {
    var data = {};

    data.store_id    = $('.store-select').val();
    data.store_name  = $('.store-select option:selected').text();
    data.preset_id   = $('.preset-select').val();
    data.preset_name = $('.preset-select option:selected').text().replace('[v] ','');

    return data;
}
function findMaxValue(element) {
    var maxValue = undefined;
    $('option', element).each(function() {
        var val = $(this).attr('value');
        val = parseInt(val, 10);
        if (maxValue === undefined || maxValue < val) {
            maxValue = val;
        }
    });
    return maxValue;
}

</script>

</div> <!-- /#content -->

<?php echo $footer; ?>
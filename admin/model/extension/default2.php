<?php
/**
 * @package     default2 Theme
 * @author      EchoThemes, http://www.echothemes.com
 * @copyright   Copyright (c) 2015, EchoThemes
 * @license     GPLv3 or later, http://www.gnu.org/licenses/gpl-3.0.html
 */

class ModelExtensionDefault2 extends Model
{
    public function installApp($version)
    {
        //=== Setting
        $rows   = array();
        $rows[] = array(
            'store_id'      => 0,
            'code'          => 'default2',
            'key'           => 'version',
            'value'         => $version,
        );
        $rows[] = array(
            'store_id'      => 0,
            'code'          => 'default2',
            'key'           => 'preset_id',
            'value'         => 1,
        );
        $rows[] = array(
            'store_id'      => 0,
            'code'          => 'default2_preset',
            'key'           => 1,
            'value'         => json_decode('{"store_id":"0","preset_id":"1","preset_name":"White-Blue","is_activate":"1","font_header":"lato","font_base":"droid-sans","font_size":"14px","font_color":"#333333","link_color":"#4365e0","btn_primary_color":"#ffffff","btn_primary_bg":"#4365e0","btn_cart_color":"#ffffff","btn_cart_bg":"#4365e0","btn_wishlist_color":"#333333","btn_wishlist_bg":"#ffffff","btn_compare_color":"#333333","btn_compare_bg":"#ffffff","template_category":"1","template_category_specific_1":"","template_category_specific_2":"","child_category_thumb":"1","grid_product_desc":"0","child_thumb_size_width":"700","child_thumb_size_height":"250","template_product":"2","template_product_specific_1":"","template_product_specific_2":"","related_product_desc":"0","template_contact":"1","contact_map":"1","geocode":"","template_404":"2","product_module_desc":"0","position_top_a":"12","position_top_b":"6-3-3","position_top_c":"3-3-3-3","position_content_top_a":"6-6","position_content_top_b":"6-6","position_content_btm_a":"6-6","position_content_btm_b":"6-6","position_bottom_a":"4-4-4","position_bottom_b":"3-6-3","position_bottom_c":"12","position_footer_ribbon":"12","position_footer_a":"6-6","position_footer_b":"3-3-3-3","position_footer_c":"8-4","uniqid":"55664cfc9dc73"}', true),
        );

        foreach ($rows as $row) {
            if (!is_array($row['value'])) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$row['store_id'] . "', `code` = '" . $this->db->escape($row['code']) . "', `key` = '" . $this->db->escape($row['key']) . "', `value` = '" . $this->db->escape($row['value']) . "'");
            }else {
                $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$row['store_id'] . "', `code` = '" . $this->db->escape($row['code']) . "', `key` = '" . $this->db->escape($row['key']) . "', `value` = '" . $this->db->escape(json_encode($row['value'])) . "', serialized = '1'");
            }
        }

        //=== Layout
        $this->db->query("INSERT INTO " . DB_PREFIX . "layout SET name = 'default2 - All Page Layout'");
        $layout_id = $this->db->getLastId();
        $this->db->query("INSERT INTO " . DB_PREFIX . "layout_route SET layout_id = '" . (int)$layout_id . "', store_id = '0', route = 'layout_all_pages'");

        //=== Block Position Demo
        $this->blockPositionDemo();
    }

    public function updateApp($oldVersion, $newVersion)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape($newVersion) . "' WHERE `code` = 'default2' AND `key` = 'version'");
    }

    //
    //=======================================================================================
    //

    public function getSetting($code, $store_id=0) {
        $setting_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `code` = '" . $this->db->escape($code) . "'");

        foreach ($query->rows as $result) {
            if (!$result['serialized']) {
                $setting_data[$result['key']] = $result['value'];
            } else {
                $setting_data[$result['key']] = json_decode($result['value'], true);
            }
        }

        return $setting_data;
    }

    public function getAllPresets()
    {
        $presets = $this->getSetting('default2_preset');
        ksort($presets);

        return $presets;
    }

    public function getPresetStore($store_id)
    {
        $store = $this->getSetting('default2', $store_id);

        return $store['preset_id'];
    }

    public function getAllPresetId()
    {
        $query = $this->db->query("SELECT `key` FROM " . DB_PREFIX . "setting WHERE store_id = '0' AND `code` = 'default2_preset'");

        $output = array();
        asort($query->rows);
        foreach ($query->rows as $result) {
            $output[] = (int)$result['key'];
        }

        return $output;
    }

    public function getAllPresetStore()
    {
        $query = $this->db->query("SELECT `value` FROM " . DB_PREFIX . "setting WHERE `code` = 'default2' AND `key` = 'preset_id'");

        $output = array();
        asort($query->rows);
        foreach ($query->rows as $result) {
            $output[] = (int)$result['value'];
        }

        return $output;
    }

    public function save($code='', $key='', $value='', $store_id = 0)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `code` = '" . $this->db->escape($code) . "' AND `key` = '" . $this->db->escape($key) . "'");

        if ($query->row) {
            if (!is_array($value)) {
                $this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape($value) . "' WHERE `code` = '" . $this->db->escape($code) . "' AND `key` = '" . $this->db->escape($key) . "' AND store_id = '" . (int)$store_id . "'");
            } else {
                $this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape(json_encode($value)) . "', serialized = '1' WHERE `code` = '" . $this->db->escape($code) . "' AND `key` = '" . $this->db->escape($key) . "' AND store_id = '" . (int)$store_id . "'");
            }
        } else {
            if (!is_array($value)) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `code` = '" . $this->db->escape($code) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
            } else {
                $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '" . (int)$store_id . "', `code` = '" . $this->db->escape($code) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape(json_encode($value)) . "', serialized = '1'");
            }
        }
    }

    public function newPreset($preset_id)
    {
        $value = $this->defaultSetting($preset_id, 'New Preset #' . $preset_id);

        $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET store_id = '0', `code` = 'default2_preset', `key` = '" . $this->db->escape($preset_id) . "', `value` = '" . $this->db->escape(json_encode($value)) . "', serialized = '1'");
    }

    public function delPreset($preset_id)
    {
        $this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE store_id = '0' AND `code` = 'default2_preset' AND `key` = '" . $this->db->escape($preset_id) . "'");
    }

    public function defaultSetting($id=0, $name='Default')
    {
        return array(
            'store_id'                      => 0,
            'preset_id'                     => $id,
            'preset_name'                   => $name,

            // Styling
            'font_header'                   => 'lato',
            'font_base'                     => 'droid-sans',
            'font_size'                     => '14px',
            'font_color'                    => '#383838',
            'link_color'                    => '#4365e0',
            'btn_primary_color'             => '#fff',
            'btn_primary_bg'                => '#4365e0',
            'btn_cart_color'                => '#fff',
            'btn_cart_bg'                   => '#4365e0',
            'btn_wishlist_color'            => '#383838',
            'btn_wishlist_bg'               => '#fff',
            'btn_compare_color'             => '#383838',
            'btn_compare_bg'                => '#fff',

            // Templates
            'template_category'             => '1',
            'template_category_specific_1'  => '',
            'template_category_specific_2'  => '',
            'child_category_thumb'          => '1',
            'grid_product_desc'             => '0',
            'child_thumb_size_width'        => '700',
            'child_thumb_size_height'       => '250',

            'template_product'              => '1',
            'template_product_specific_1'   => '',
            'template_product_specific_2'   => '',
            'related_product_desc'          => '0',

            'template_contact'              => '1',
            'contact_map'                   => '1',
            'geocode'                       => '',
            'template_404'                  => '2',
            'product_module_desc'           => '0',

            // Block Layouts
            'position_top_a'                => '12',
            'position_top_b'                => '6-3-3',
            'position_top_c'                => '12',
            'position_content_top_a'        => '12',
            'position_content_top_b'        => '12',
            'position_content_btm_a'        => '12',
            'position_content_btm_b'        => '12',
            'position_bottom_a'             => '12',
            'position_bottom_b'             => '12',
            'position_bottom_c'             => '12',
            'position_footer_ribbon'        => '12',
            'position_footer_a'             => '6-6',
            'position_footer_b'             => '3-3-3-3',
            'position_footer_c'             => '4-4-4',
        );
    }

    private function blockPositionDemo()
    {
        $this->load->model('localisation/language');
        $this->load->model('catalog/information');

        $languages  = $this->model_localisation_language->getLanguages();

        //=== Insert layout
        $this->db->query("INSERT INTO " . DB_PREFIX . "layout SET name = 'default2 - Layout Block Demo'");
        $layout_id = $this->db->getLastId();

        //=== Insert information page
        $description = array();
        foreach ($languages as $language) {
            $description[$language['language_id']] = array(
                'title'             => 'Block Position Demo',
                'description'       => "<style>.position-block { margin: -5px; padding: 4px 5px 5px; background: #FFF7D0;}#column-left .oc-module,#column-right .oc-module,#content-top .oc-module,#content-bottom .oc-module { margin: -5px; padding: 4px 5px 5px; background: #FFF7D0;}#column-left .example-block-blue,#column-right .example-block-blue,#column-left .example-block-red,#column-right .example-block-red { padding: 296px 10px;}.example-block-gray { padding: 38px 20px;}#column-left .oc-module:before,#column-right .oc-module:before,#content-top .oc-module:before,#content-bottom .oc-module:before,.position-block:before { font-size: 12px; font-family: monospace; margin-bottom: 10px; display: inline-block; background: #d00; line-height: 12px; color: #fff; padding: 2px 5px; border-radius: 3px;}#position-tlb-top-left:before { content: '#tlb-top-left';}#position-tlb-top-right:before { content: '#tlb-top-right';}#position-main-menu:before { content: '#main-menu';}#position-top-a:before { content: '#top-a';}#position-top-b:before { content: '#top-b';}#position-top-c:before { content: '#top-c';}#column-left .position-block:before { content: '#column-left';}#column-right .position-block:before { content: '#column-right';}#position-content-top-a:before { content: '#content-top-a';}#position-content-top-b:before { content: '#content-top-b';}#content-top .oc-module:before{ content: '#content-top';}#content-bottom .oc-module:before{ content: '#content-bottom';}#position-content-btm-a:before { content: '#content-btm-a';}#position-content-btm-b:before { content: '#content-btm-b';}#position-bottom-a:before { content: '#bottom-a';}#position-bottom-b:before { content: '#bottom-b';}#position-bottom-c:before { content: '#bottom-c';}.position-toolbar .position-block { margin: 5px -5px;}#position-tlb-btm-left:before { content: '#tlb-btm-left';}#position-tlb-btm-right:before { content: '#tlb-btm-right';}#position-footer-ribbon:before { content: '#footer-ribbon';}#position-footer-a:before { content: '#footer-a';}#position-footer-b:before { content: '#footer-b';}#position-footer-c:before { content: '#footer-c';}</style><p>Visual example of block-position</p>",
                'meta_title'        => 'Block Position Demo',
                'meta_description'  => '',
                'meta_keyword'      => '',
            );
        }

        $information = array(
            'sort_order'    => 1,
            'bottom'        => 1,
            'status'        => 1,
            'keyword'       => 'block_position_demo',
            'information_store'       => array( 0 => 0 ),
            'information_layout'      => array( 0 => $layout_id ),
            'information_description' => $description,
        );

        $this->model_catalog_information->addInformation($information);

        //=== Insert module
        $modules        = array(
            array('Example Module Blue', '<div class="example-block-blue">Modules</div>'),
            array('Example Module Red #1', '<div class="example-block-red">Module #1</div>'),
            array('Example Module Red #2', '<div class="example-block-red">Module #2</div>'),
            array('Example Module Red #3', '<div class="example-block-red">Module #3</div>'),
            array('Example Module Red #4', '<div class="example-block-red">Module #4</div>'),
            array('Example Responsive Utilities', '<div style="width:200px; position:fixed;  left:50%; margin-left:-100px; background:rgba(0,0,0,.65); color:#fff; font-size:11px; padding:2px 0; z-index:10000" class="text-danger text-center"><span class="visible-xs-block">Extra Small - Phones (&lt;768px)</span><span class="visible-sm-block">Small - Tablets (≥768px)</span><span class="visible-md-block">Medium - Desktops (≥992px)</span><span class="visible-lg-block">Large - Desktops (≥1200px)</span></div>'),
        );

        $modules_data = array();
        foreach ($modules as $module) {
            $lang_desc = array();
            foreach ($languages as $language) {
                $lang_desc[$language['language_id']] = array(
                    'title'         => '',
                    'description'   => $module[1],
                );
            }

            $modules_data[] = array(
                'name'                  => $module[0],
                'module_description'    => $lang_desc,
                'status'                => 1
            );
        }

        $modules_id   = array();
        foreach ($modules_data as $module) {
            $this->db->query("INSERT INTO `" . DB_PREFIX . "module` SET `name` = '" . $this->db->escape($module['name']) . "', `code` = 'html', `setting` = '" . $this->db->escape(json_encode($module)) . "'");
            $modules_id[] = $this->db->getLastId();
        }

        //=== Attach module to layout
        $layout_modules     = array();
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'tlb_top_left',     'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'tlb_top_right',    'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'main_menu',        'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'top_a',            'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'top_b',            'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'top_b',            'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[3], 'position' => 'top_b',            'sort_order' => 301);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'top_c',            'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'top_c',            'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[3], 'position' => 'top_c',            'sort_order' => 301);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[4], 'position' => 'top_c',            'sort_order' => 401);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'content_top_a',    'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'content_top_a',    'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'content_top_b',    'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'content_top_b',    'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[0], 'position' => 'content_top',      'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[0], 'position' => 'sidebar_left',     'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[0], 'position' => 'sidebar_right',    'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[0], 'position' => 'content_bottom',   'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'content_btm_a',    'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'content_btm_a',    'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'content_btm_b',    'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'content_btm_b',    'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'bottom_a',         'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'bottom_a',         'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[3], 'position' => 'bottom_a',         'sort_order' => 301);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'bottom_b',         'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'bottom_b',         'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[3], 'position' => 'bottom_b',         'sort_order' => 301);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'bottom_c',         'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'footer_ribbon',    'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'footer_a',         'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'footer_a',         'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'footer_b',         'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'footer_b',         'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[3], 'position' => 'footer_b',         'sort_order' => 301);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[4], 'position' => 'footer_b',         'sort_order' => 401);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'footer_c',         'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'footer_c',         'sort_order' => 201);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[1], 'position' => 'tlb_btm_left',     'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[2], 'position' => 'tlb_btm_right',    'sort_order' => 1);
        $layout_modules[]   = array('code' => 'html.'.$modules_id[5], 'position' => 'hide_blk_top',     'sort_order' => 1);

        foreach ($layout_modules as $module) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "layout_module SET layout_id = '" . (int)$layout_id . "', code = '" . $this->db->escape($module['code']) . "', position = '" . $this->db->escape($module['position']) . "', sort_order = '" . (int)$module['sort_order'] . "'");
        }
    }
}
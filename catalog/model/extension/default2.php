<?php
/**
 * @package     default2 Theme
 * @author      EchoThemes, http://www.echothemes.com
 * @copyright   Copyright (c) 2015, EchoThemes
 * @license     GPLv3 or later, http://www.gnu.org/licenses/gpl-3.0.html
 */

class ModelExtensionDefault2 extends Model
{
    public function getAllPosition($blockToLoad=array())
    {
        $output = array();
        $blocks = $blockToLoad ? array_intersect_key($this->positionMap(), array_flip($blockToLoad)) : $this->positionMap();

        foreach ($blocks as $block => $args) {
            $output['position_' . $block] = $this->position($block, $args);
        }

        return $output;
    }

    public function position($position, $args)
    {
        $layout_id          = 0;
        $route              = 'common/home';

        $this->load->model('design/layout');
        $this->load->model('extension/module');

        if (isset($this->request->get['route'])) {
            $route = (string)$this->request->get['route'];
        }

        // Specific Layout
        if ($route == 'product/category' && isset($this->request->get['path'])) {
            $this->load->model('catalog/category');

            $path = explode('_', (string)$this->request->get['path']);

            $layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));
        }
        if ($route == 'product/product' && isset($this->request->get['product_id'])) {
            $this->load->model('catalog/product');

            $layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
        }
        if ($route == 'information/information' && isset($this->request->get['information_id'])) {
            $this->load->model('catalog/information');

            $layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
        }

        // Layout by Route
        if (!$layout_id) {
            $layout_id = $this->model_design_layout->getLayout($route);
        }

        // Default Layout
        if (!$layout_id) {
            $layout_id = $this->config->get('config_layout_id');
        }

        // All Pages Layout
        $all_page_id = $this->getAllPagesLayoutId();

        $data['modules']    = array();
        $data['default2']   = $this->config->get('default2');
        $data['position']   = $args;
        $data['blocks']     = isset($data['default2']['position_' . $position]) ? explode('-', $data['default2']['position_' . $position]) : array();

        $page_modules       = $this->model_design_layout->getLayoutModules($layout_id, $position);
        $all_modules        = $this->model_design_layout->getLayoutModules($all_page_id, $position);
        $modules            = array_merge($page_modules, $all_modules);

        if (count($data['blocks']) > 1) {
            foreach ($modules as $module) {
                $part = explode('.', $module['code']);

                switch (true) {
                    case ($module['sort_order'] > 199 && $module['sort_order'] < 300):
                        $col    = 1;
                        break;
                    case ($module['sort_order'] > 299 && $module['sort_order'] < 400):
                        $col    = 2;
                        break;
                    case ($module['sort_order'] > 399 && $module['sort_order'] < 500):
                        $col    = 3;
                        break;
                    case ($module['sort_order'] < 200):
                    default:
                        $col    = 0;
                        break;
                }

                if (!isset($data['blocks'][$col])) {
                    $col = 0;
                }

                if (isset($part[0]) && $this->config->get($part[0] . '_status')) {
                    $data['modules'][$col][] = $this->load->controller('module/' . $part[0]);
                }

                if (isset($part[1])) {
                    $setting_info = $this->model_extension_module->getModule($part[1]);

                    if ($setting_info && $setting_info['status']) {
                        $data['modules'][$col][] = $this->load->controller('module/' . $part[0], $setting_info);
                    }
                }
            }
        } else {
            foreach ($modules as $module) {
                $part = explode('.', $module['code']);

                if (isset($part[0]) && $this->config->get($part[0] . '_status')) {
                    $data['modules'][] = $this->load->controller('module/' . $part[0]);
                }

                if (isset($part[1])) {
                    $setting_info = $this->model_extension_module->getModule($part[1]);

                    if ($setting_info && $setting_info['status']) {
                        $data['modules'][] = $this->load->controller('module/' . $part[0], $setting_info);
                    }
                }
            }
        }

        $template = 'position_general';
        $position = isset($args['tpl']) ? $args['tpl'] : $position;
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/position_' . $position . '.tpl')) {
            $template = 'position_' . $position;
        }
        return $this->load->view($this->config->get('config_template') . '/template/common/' . $template . '.tpl', $data);
    }

    public function getAllPagesLayoutId()
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "layout_route WHERE route = 'layout_all_pages' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");

        if ($query->num_rows) {
            return $query->row['layout_id'];
        } else {
            return 0;
        }
    }

    private function positionMap()
    {
        $positions = array();
        $positions['tlb_top_left'] = array(
            'id'    => 'position-tlb-top-left',
            'class' => ''
        );
        $positions['tlb_top_right'] = array(
            'id'    => 'position-tlb-top-right',
            'class' => ''
        );
        $positions['main_menu'] = array(
            'id'    => 'position-main-menu',
            'class' => ''
        );
        $positions['top_a'] = array(
            'id'    => 'position-top-a',
            'class' => ''
        );
        $positions['top_b'] = array(
            'id'    => 'position-top-b',
            'class' => ''
        );
        $positions['top_c'] = array(
            'id'    => 'position-top-c',
            'class' => ''
        );
        $positions['sidebar_left'] = array(
            'id'    => 'column-left',
            'class' => 'module-vert',
            'tpl'   => 'sidebar'
        );
        $positions['sidebar_right'] = array(
            'id'    => 'column-right',
            'class' => 'module-vert',
            'tpl'   => 'sidebar'
        );
        $positions['content_top_a'] = array(
            'id'    => 'position-content-top-a',
            'class' => ''
        );
        $positions['content_top_b'] = array(
            'id'    => 'position-content-top-b',
            'class' => ''
        );
        $positions['content_btm_a'] = array(
            'id'    => 'position-content-btm-a',
            'class' => ''
        );
        $positions['content_btm_b'] = array(
            'id'    => 'position-content-btm-b',
            'class' => ''
        );
        $positions['bottom_a'] = array(
            'id'    => 'position-bottom-a',
            'class' => ''
        );
        $positions['bottom_b'] = array(
            'id'    => 'position-bottom-b',
            'class' => ''
        );
        $positions['bottom_c'] = array(
            'id'    => 'position-bottom-c',
            'class' => ''
        );
        $positions['footer_ribbon'] = array(
            'id'    => 'position-footer-ribbon',
            'class' => ''
        );
        $positions['footer_a'] = array(
            'id'    => 'position-footer-a',
            'class' => ''
        );
        $positions['footer_b'] = array(
            'id'    => 'position-footer-b',
            'class' => ''
        );
        $positions['footer_c'] = array(
            'id'    => 'position-footer-c',
            'class' => ''
        );
        $positions['tlb_btm_left'] = array(
            'id'    => 'position-tlb-btm-left',
            'class' => ''
        );
        $positions['tlb_btm_right'] = array(
            'id'    => 'position-tlb-btm-right',
            'class' => ''
        );
        $positions['hide_blk_top'] = array(
            'id'    => '',
            'class' => '',
            'tpl'   => 'hide_blk'
        );
        $positions['hide_blk_btm'] = array(
            'id'    => '',
            'class' => '',
            'tpl'   => 'hide_blk'
        );

       return $positions;
    }
}
<?php
/**
 * @package     default2 Theme
 * @author      EchoThemes, http://www.echothemes.com
 * @copyright   Copyright (c) 2015, EchoThemes
 * @license     GPLv3 or later, http://www.gnu.org/licenses/gpl-3.0.html
 */

class ControllerExtensionDefault2 extends Controller
{
    public function index()
    {
        //=== Init
        $this->load->model('extension/default2');
        $this->load->model('setting/store');

        $data  = array();
        $data += $this->load->language('extension/default2');

        $default2   = $this->model_extension_default2->getSetting('default2', 0);
        $version    = isset($default2['version']) ? $default2['version'] : '1.0.0';

        // If version in database is lower, time to install or update
        if (version_compare($version, $this->language->get('ext_version'), '<')) {
            if (isset($default2['preset_id'])) {
                $this->model_extension_default2->updateApp($version, $this->language->get('ext_version'));
                $this->session->data['d2_alert_success'] = $this->language->get('text_update_success');
            } else {
                $this->model_extension_default2->installApp($this->language->get('ext_version'));
                $this->session->data['d2_alert_success'] = $this->language->get('text_install_success');
            }
        }

        //=== Document
        $this->document->setTitle($this->language->get('ext_name'));

        $this->document->addStyle('view/stylesheet/default2/css/uikit-echothemes.min.css?v=1.2.0', 'stylesheet');
        $this->document->addStyle('view/stylesheet/default2/css/sweetalert.min.css?v=1.0.0-beta', 'stylesheet');
        $this->document->addStyle('view/stylesheet/default2/css/minicolors.min.css?v=2.1.7', 'stylesheet');
        $this->document->addStyle('view/stylesheet/default2/default2.css?v=' . $this->language->get('ext_version'), 'stylesheet');
        $this->document->addScript('view/stylesheet/default2/js/uikit.min.js?v=2.8.0');
        $this->document->addScript('view/stylesheet/default2/js/uikit-notify.min.js?v=2.8.0');
        $this->document->addScript('view/stylesheet/default2/js/uikit-sticky.min.js?v=2.8.0');
        $this->document->addScript('view/stylesheet/default2/js/uikit-extra.min.js?v=2.8.0');
        $this->document->addScript('view/stylesheet/default2/js/form.min.js?v=3.5.0');
        $this->document->addScript('view/stylesheet/default2/js/minicolors.min.js?v=2.1.7');
        $this->document->addScript('view/stylesheet/default2/js/sweetalert.min.js?v=1.0.0-beta');

        //=== Breadcrumbs
        $data['breadcrumbs']    = array();
        $data['breadcrumbs'][]  = array(
            'text'  => '<i class="uk-icon-home uk-icon-nano"></i>',
            'href'  => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
            'class' => ''
        );
        $data['breadcrumbs'][]  = array(
            'text'  => $this->language->get('ext_name'),
            'href'  => $this->url->link('extension/default2', 'token=' . $this->session->data['token'], 'SSL'),
            'class' => 'active',
        );

        //=== Content
        $data['token']              = $this->session->data['token'];
        $data['form_action']        = $this->url->link('extension/default2/save', 'token=' . $this->session->data['token'], 'SSL');

        $all_preset_id              = $this->model_extension_default2->getAllPresetId();
        $all_preset_store           = $this->model_extension_default2->getAllPresetStore();

        $store_id                   = isset($this->request->get['store']) ? $this->request->get['store'] : 0;
        $preset_store               = $this->model_extension_default2->getPresetStore($store_id);
        $preset_id                  = isset($this->request->get['preset']) ? $this->request->get['preset'] : $preset_store;
        $preset_id                  = in_array($preset_id, $all_preset_id) ? $preset_id : $all_preset_id[0];
        $presets                    = $this->model_extension_default2->getAllPresets();

        $data['store_id']           = $store_id;
        $data['preset_id']          = $preset_id;
        $data['stores']             = $this->model_setting_store->getStores();
        $data['store_default']      = $this->config->get('config_name');
        $data['presets']            = $presets;
        $data['store_preset_id']    = $preset_store;
        $data['all_preset_store']   = json_encode($all_preset_store);

        // Options
        $data['fonts'] = array(
            'System' => array(
                'verdana'       => 'Verdana, Arial, sans-serif',
                'arial'         => 'Arial, Helvetica, sans-serif',
                'serif'         => 'Georgia, "Times New Roman", Times, serif',
                'sans-serif'    => '"Helvetica Neue", Helvetica, Arial, sans-serif',
            ),
            'Google' => array(
                'pt-sans'       => 'PT Sans',
                'open-sans'     => 'Open Sans',
                'droid-sans'    => 'Droid Sans',
                'source-sans'   => 'Source Sans Pro',
                'roboto'        => 'Roboto',
                'roboto-slab'   => 'Roboto Slab',
                'lato'          => 'Lato',
                'arvo'          => 'Arvo',
                'raleway'       => 'Raleway',
                'ubuntu'        => 'Ubuntu',
                'oswald'        => 'Oswald',
                'fanwood'       => 'Fanwood Text',
                'josefin-slab'  => 'Josefin Slab',
            )
        );

        $data['positions'] = array(
            'top_a'             => 'Top A',
            'top_b'             => 'Top B',
            'top_c'             => 'Top C',
            'content_top_a'     => 'Content Top A',
            'content_top_b'     => 'Content Top B',
            'content_btm_a'     => 'Content Bottom A',
            'content_btm_b'     => 'Content Bottom B',
            'bottom_a'          => 'Bottom A',
            'bottom_b'          => 'Bottom B',
            'bottom_c'          => 'Bottom C',
            'footer_ribbon'     => 'Footer Ribbon',
            'footer_a'          => 'Footer A',
            'footer_b'          => 'Footer B',
            'footer_c'          => 'Footer C',
        );
        $data['block_widths'] = array(
            'Full'  => array(
                '12'        => '100%',
            ),
            'Equal' => array(
                '6-6'       => '50% | 50%',
                '4-4-4'     => '33% | 33% | 33%',
                '3-3-3-3'   => '25% | 25% | 25% | 25%',
            ),
            'Stack' => array(
                '8-4'       => '66% | 33%',
                '4-8'       => '33% | 66%',
                '9-3'       => '75% | 25%',
                '3-9'       => '25% | 75%',
                '6-3-3'     => '50% | 25% | 25%',
                '3-6-3'     => '25% | 50% | 25%',
                '3-3-6'     => '25% | 25% | 50%',
            )
        );

        // Setting
        $default_setting    = $this->model_extension_default2->defaultSetting();
        $data['setting']    = array_merge($default_setting, $presets[$preset_id]);

        // Global Alerts
        $alerts     = array('success', 'danger', 'warning');
        foreach ($alerts as $alert) {
            if (isset($this->session->data['d2_alert_'.$alert])) {
                $data['alert_'.$alert]    = $this->session->data['d2_alert_'.$alert];
                unset($this->session->data['d2_alert_'.$alert]);
            }
        }
        $data['alerts'] = $alerts;

        //=== H-MVC
        $data['header']     = $this->load->controller('common/header');
        $data['menu']       = $this->load->controller('common/column_left');
        $data['footer']     = $this->load->controller('common/footer');;

        //=== Render
        $template   = 'extension/default2.tpl';
        $render     = $this->load->view($template, $data);

        $this->response->setOutput($render);
    }

    public function save()
    {
        $this->load->language('extension/default2');

        if (!$this->user->hasPermission('modify', 'extension/default2')) {
            $post['error']   = true;
            $post['errorMsg'] = $this->language->get('js_error_permission');

            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($post));
        }
        else {
            $this->load->model('extension/default2');

            $post           = $this->request->post;
            $post['uniqid'] = uniqid();

            if (isset($post['activate'])) {
                $this->model_extension_default2->save('default2_preset', $post['preset_id'], $post, 0);
                $this->model_extension_default2->save('default2', 'preset_id', $post['preset_id'], $post['store_id']);
            }
            elseif (isset($post['newPresetId'])) {
                $newPresetId         = (int)$post['newPresetId'] + 1;

                $this->model_extension_default2->newPreset($newPresetId);

                $post['redirect'] = str_replace('&amp;', '&', $this->url->link('extension/default2', 'store=' . $post['store_id'] . '&preset=' . $newPresetId . '&token=' . $this->session->data['token'], 'SSL'));
            }
            elseif (isset($post['copyPresetId'])) {
                $newPresetId         = (int)$post['copyPresetId'] + 1;
                $post['preset_id']   = $newPresetId;
                $post['preset_name'] = $post['preset_name'] . ' - COPY';

                $this->model_extension_default2->save('default2_preset', $newPresetId, $post, 0);

                $post['redirect'] = str_replace('&amp;', '&', $this->url->link('extension/default2', 'store=' . $post['store_id'] . '&preset=' . $newPresetId . '&token=' . $this->session->data['token'], 'SSL'));
            }
            elseif (isset($post['delPresetId'])) {
                $this->model_extension_default2->delPreset($post['preset_id']);

                $post['redirect'] = str_replace('&amp;', '&', $this->url->link('extension/default2', 'token=' . $this->session->data['token'], 'SSL'));
            }
            else {
                $this->model_extension_default2->save('default2_preset', $post['preset_id'], $post, 0);
            }

            // Generate preset stylesheet
            if ($post['is_activate'] || isset($post['activate'])) {
                $path   = DIR_CATALOG . 'view/theme/default2/stylesheet/';
                $fonts  = array(
                    'verdana'       => 'Verdana, Arial, sans-serif',
                    'arial'         => 'Arial, Helvetica, sans-serif',
                    'serif'         => 'Georgia, "Times New Roman", Times, serif',
                    'sans-serif'    => '"Helvetica Neue", Helvetica, Arial, sans-serif',
                    'open-sans'     => '"Open Sans", Arial, sans-serif',
                    'droid-sans'    => '"Droid Sans", Arial, sans-serif',
                    'source-sans'   => '"Source Sans Pro", Arial, sans-serif',
                    'pt-sans'       => '"PT Sans", Arial, sans-serif',
                    'roboto'        => '"Roboto", Arial, sans-serif',
                    'roboto-slab'   => '"Roboto Slab", Arial, sans-serif',
                    'lato'          => '"Lato", Arial, sans-serif',
                    'arvo'          => '"Arvo", Arial, sans-serif',
                    'marvel'        => '"Marvel", Arial, sans-serif',
                    'raleway'       => '"Raleway", Arial, sans-serif',
                    'ubuntu'        => '"Ubuntu", Arial, sans-serif',
                    'oswald'        => '"Oswald", Arial, sans-serif',
                    'fanwood'       => '"Fanwood Text", Arial, sans-serif',
                    'josefin-slab'  => '"Josefin Slab", Arial, sans-serif',
                );

                if (file_exists(DIR_APPLICATION . 'view/stylesheet/default2/lessc.inc.php')) {
                    include_once(DIR_APPLICATION . 'view/stylesheet/default2/lessc.inc.php');

                    $less = new lessc;
                    $less->setFormatter('compressed');
                    $less->setPreserveComments(true);
                    $less->setVariables(array(
                        'font-heading'          => $fonts[$post['font_header']],
                        'font-base'             => $fonts[$post['font_base']],
                        'font-size'             => $post['font_size'],
                        'font-color'            => $post['font_color'],
                        'link-color'            => $post['link_color'],
                        'btn-primary-color'     => $post['btn_primary_color'],
                        'btn-primary-bg'        => $post['btn_primary_bg'],
                        'btn-cart-color'        => $post['btn_cart_color'],
                        'btn-cart-bg'           => $post['btn_cart_bg'],
                        'btn-wishlist-color'    => $post['btn_wishlist_color'],
                        'btn-wishlist-bg'       => $post['btn_wishlist_bg'],
                        'btn-compare-color'     => $post['btn_compare_color'],
                        'btn-compare-bg'        => $post['btn_compare_bg'],
                    ));

                    $less->compileFile($path . 'less/admin-preset.less', $path . 'default2-preset-' . $post['preset_id'] . '.css');
                }
            }
        }

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($post));
    }
}
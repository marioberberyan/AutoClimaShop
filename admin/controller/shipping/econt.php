<?php
class ControllerShippingEcont extends Controller {
	private $error = array();
	private $delivery_type = 'from_office';

	public function index() {
		$this->document->addScript('view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
		$this->document->addStyle('view/javascript/jquery/magnific/magnific-popup.css');

		if (!$this->config->get('econt_updated_rs')) { //for Return Solution
			$this->update_rs();
		}

		$this->language->load('shipping/econt');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('shipping/econt');

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->request->post['econt_updated_rs'] = true; //for Return Solution

			$this->model_setting_setting->editSetting('econt', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_all_zones'] = $this->language->get('text_all_zones');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_get_data'] = $this->language->get('text_get_data');
		$data['text_get_address'] = $this->language->get('text_get_address');
		$data['text_wait'] = $this->language->get('text_wait');
		$data['text_from_office'] = $this->language->get('text_from_office');
		$data['text_from_door'] = $this->language->get('text_from_door');
		$data['text_sender'] = $this->language->get('text_sender');
		$data['text_receiver'] = $this->language->get('text_receiver');
		$data['text_get_key_word'] = $this->language->get('text_get_key_word');
		$data['text_get_cd_agreement_num'] = $this->language->get('text_get_cd_agreement_num');
		$data['text_get_instructions'] = $this->language->get('text_get_instructions');

		$data['entry_test'] = $this->language->get('entry_test');
		$data['entry_username'] = $this->language->get('entry_username');
		$data['entry_password'] = $this->language->get('entry_password');
		$data['entry_get_data'] = $this->language->get('entry_get_data');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_name_person'] = $this->language->get('entry_name_person');
		$data['entry_phone'] = $this->language->get('entry_phone');
		$data['entry_addresses'] = $this->language->get('entry_addresses');
		$data['entry_address'] = $this->language->get('entry_address');
		$data['entry_post_code'] = $this->language->get('entry_post_code');
		$data['entry_city'] = $this->language->get('entry_city');
		$data['entry_quarter'] = $this->language->get('entry_quarter');
		$data['entry_street'] = $this->language->get('entry_street');
		$data['entry_street_num'] = $this->language->get('entry_street_num');
		$data['entry_other'] = $this->language->get('entry_other');
		$data['entry_office'] = $this->language->get('entry_office');
		$data['entry_office_code'] = $this->language->get('entry_office_code');
		$data['entry_to_door'] = $this->language->get('entry_to_door');
		$data['entry_to_office'] = $this->language->get('entry_to_office');
		$data['entry_cd'] = $this->language->get('entry_cd');
		$data['entry_shipping_from'] = $this->language->get('entry_shipping_from');
		$data['entry_oc'] = $this->language->get('entry_oc');
		$data['entry_total_for_oc'] = $this->language->get('entry_total_for_oc');
		$data['entry_dc'] = $this->language->get('entry_dc');
		$data['entry_dc_cp'] = $this->language->get('entry_dc_cp');
		$data['entry_sms'] = $this->language->get('entry_sms');
		$data['entry_sms_no'] = $this->language->get('entry_sms_no');
		$data['entry_invoice_before_cd'] = $this->language->get('entry_invoice_before_cd');
		$data['entry_disposition'] = $this->language->get('entry_disposition');
		$data['entry_pay_after_accept'] = $this->language->get('entry_pay_after_accept');
		$data['entry_pay_after_test'] = $this->language->get('entry_pay_after_test');
		$data['entry_instruction_shipping_returns'] = $this->language->get('entry_instruction_shipping_returns');
		$data['entry_instruction_returns'] = $this->language->get('entry_instruction_returns');
		$data['entry_side'] = $this->language->get('entry_side');
		$data['entry_payment_method'] = $this->language->get('entry_payment_method');
		$data['entry_key_word'] = $this->language->get('entry_key_word');
		$data['entry_cd_agreement'] = $this->language->get('entry_cd_agreement');
		$data['entry_cd_agreement_num'] = $this->language->get('entry_cd_agreement_num');
		$data['entry_total_for_free'] = $this->language->get('entry_total_for_free');
		$data['entry_weight_for_free'] = $this->language->get('entry_weight_for_free');
		$data['entry_count_for_free'] = $this->language->get('entry_count_for_free');
		$data['entry_shipping_payment'] = $this->language->get('entry_shipping_payment');
		$data['entry_order_amount'] = $this->language->get('entry_order_amount');
		$data['entry_receiver_amount'] = $this->language->get('entry_receiver_amount');
		$data['entry_receiver_amount_office'] = $this->language->get('entry_receiver_amount_office');
		$data['entry_priority_time'] = $this->language->get('entry_priority_time');
		$data['entry_delivery_day'] = $this->language->get('entry_delivery_day');
		$data['entry_partial_delivery'] = $this->language->get('entry_partial_delivery');
		$data['entry_partial_delivery_instruction'] = $this->language->get('entry_partial_delivery_instruction');
		$data['entry_inventory'] = $this->language->get('entry_inventory');
		$data['entry_inventory_type'] = $this->language->get('entry_inventory_type');
		$data['entry_return_loading'] = $this->language->get('entry_return_loading');
		$data['entry_instructions'] = $this->language->get('entry_instructions');
		$data['help_entry_instructions'] = $this->language->get('help_entry_instructions');
		$data['entry_instructions_type'] = $this->language->get('entry_instructions_type');
		$data['entry_instructions_name'] = $this->language->get('entry_instructions_name');
		$data['entry_instructions_list'] = $this->language->get('entry_instructions_list');
		$data['entry_currency'] = $this->language->get('entry_currency');
		$data['entry_weight_class'] = $this->language->get('entry_weight_class');
		$data['entry_order_status'] = $this->language->get('entry_order_status');
		$data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_remove'] = $this->language->get('button_remove');
		$data['button_get_address'] = $this->language->get('button_get_address');
		$data['button_get_data'] = $this->language->get('button_get_data');
		$data['button_refresh_data'] = $this->language->get('button_refresh_data');
		$data['button_office_locator'] = $this->language->get('button_office_locator');
		$data['button_get_key_word'] = $this->language->get('button_get_key_word');
		$data['button_get_cd_agreement_num'] = $this->language->get('button_get_cd_agreement_num');
		$data['button_get_instructions'] = $this->language->get('button_get_instructions');
		$data['button_instructions_form'] = $this->language->get('button_instructions_form');

		$data['error_general'] = $this->language->get('error_general');

		$data['token'] = (isset($this->session->data['token']) ? $this->session->data['token'] : '');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['username'])) {
			$data['error_username'] = $this->error['username'];
		} else {
			$data['error_username'] = '';
		}

		if (isset($this->error['password'])) {
			$data['error_password'] = $this->error['password'];
		} else {
			$data['error_password'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		if (isset($this->error['name_person'])) {
			$data['error_name_person'] = $this->error['name_person'];
		} else {
			$data['error_name_person'] = '';
		}

		if (isset($this->error['phone'])) {
			$data['error_phone'] = $this->error['phone'];
		} else {
			$data['error_phone'] = '';
		}

		if (isset($this->error['addresses'])) {
			$data['error_addresses'] = $this->error['addresses'];
		} else {
			$data['error_addresses'] = '';
		}

		if (isset($this->error['get_data'])) {
			$data['error_get_data'] = $this->error['get_data'];
		} else {
			$data['error_get_data'] = '';
		}

		if (isset($this->error['office'])) {
			$data['error_office'] = $this->error['office'];
		} else {
			$data['error_office'] = '';
		}

		if (isset($this->error['sms'])) {
			$data['error_sms'] = $this->error['sms'];
		} else {
			$data['error_sms'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(

			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_shipping'),
			'href'      => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('shipping/econt', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$data['action'] = $this->url->link('shipping/econt', 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');

		$data['office_locator'] = 'https://www.bgmaps.com/templates/econt?office_type=to_office_courier&shop_url=' . HTTPS_SERVER;
		$data['office_locator_domain'] = 'https://www.bgmaps.com';

		if (isset($this->request->post['econt_test'])) {
			$data['econt_test'] = $this->request->post['econt_test'];
		} else {
			$data['econt_test'] = $this->config->get('econt_test');
		}

		if (isset($this->request->post['econt_username'])) {
			$data['econt_username'] = $this->request->post['econt_username'];
		} else {
			$data['econt_username'] = htmlspecialchars_decode($this->config->get('econt_username'));
		}

		if (isset($this->request->post['econt_password'])) {
			$data['econt_password'] = $this->request->post['econt_password'];
		} else {
			$data['econt_password'] = htmlspecialchars_decode($this->config->get('econt_password'));
		}

		if (isset($this->request->post['econt_name'])) {
			$data['econt_name'] = $this->request->post['econt_name'];
		} else {
			$data['econt_name'] = $this->config->get('econt_name');
		}

		if (isset($this->request->post['econt_name_person'])) {
			$data['econt_name_person'] = $this->request->post['econt_name_person'];
		} else {
			$data['econt_name_person'] = $this->config->get('econt_name_person');
		}

		if (isset($this->request->post['econt_phone'])) {
			$data['econt_phone'] = $this->request->post['econt_phone'];
		} else {
			$data['econt_phone'] = $this->config->get('econt_phone');
		}

		if (isset($this->request->post['econt_addresses'])) {
			$data['econt_addresses'] = $this->request->post['econt_addresses'];
		} elseif ($this->config->get('econt_addresses')) {
			if (!is_array($this->config->get('econt_addresses'))) {
				$data['econt_addresses'] = unserialize($this->config->get('econt_addresses'));
			} else {
				$data['econt_addresses'] = $this->config->get('econt_addresses');
			}
		} else {
			$data['econt_addresses'] = array();
		}

		if (isset($this->request->post['econt_office_id'])) {
			$data['econt_office_id'] = $this->request->post['econt_office_id'];
		} else {
			$data['econt_office_id'] = $this->config->get('econt_office_id');
		}

		if (isset($this->request->post['econt_to_door'])) {
			$data['econt_to_door'] = $this->request->post['econt_to_door'];
		} else {
			$data['econt_to_door'] = $this->config->get('econt_to_door');
		}

		if (isset($this->request->post['econt_to_office'])) {
			$data['econt_to_office'] = $this->request->post['econt_to_office'];
		} else {
			$data['econt_to_office'] = $this->config->get('econt_to_office');
		}

		if (isset($this->request->post['econt_cd'])) {
			$data['econt_cd'] = $this->request->post['econt_cd'];
		} else {
			$data['econt_cd'] = $this->config->get('econt_cd');
		}

		if (isset($this->request->post['econt_shipping_from'])) {
			$data['econt_shipping_from'] = $this->request->post['econt_shipping_from'];
		} else {
			$data['econt_shipping_from'] = $this->config->get('econt_shipping_from');
		}

		if (isset($this->request->post['econt_oc'])) {
			$data['econt_oc'] = $this->request->post['econt_oc'];
		} else {
			$data['econt_oc'] = $this->config->get('econt_oc');
		}

		if (isset($this->request->post['econt_total_for_oc'])) {
			$data['econt_total_for_oc'] = $this->request->post['econt_total_for_oc'];
		} else {
			$data['econt_total_for_oc'] = $this->config->get('econt_total_for_oc');
		}

		if (isset($this->request->post['econt_dc'])) {
			$data['econt_dc'] = $this->request->post['econt_dc'];
		} else {
			$data['econt_dc'] = $this->config->get('econt_dc');
		}

		if (isset($this->request->post['econt_dc_cp'])) {
			$data['econt_dc_cp'] = $this->request->post['econt_dc_cp'];
		} else {
			$data['econt_dc_cp'] = $this->config->get('econt_dc_cp');
		}

		if (isset($this->request->post['econt_sms'])) {
			$data['econt_sms'] = $this->request->post['econt_sms'];
		} else {
			$data['econt_sms'] = $this->config->get('econt_sms');
		}

		if (isset($this->request->post['econt_sms_no'])) {
			$data['econt_sms_no'] = $this->request->post['econt_sms_no'];
		} else {
			$data['econt_sms_no'] = $this->config->get('econt_sms_no');
		}

		if (isset($this->request->post['econt_invoice_before_cd'])) {
			$data['econt_invoice_before_cd'] = $this->request->post['econt_invoice_before_cd'];
		} else {
			$data['econt_invoice_before_cd'] = $this->config->get('econt_invoice_before_cd');
		}

		if (isset($this->request->post['econt_pay_after_accept'])) {
			$data['econt_pay_after_accept'] = $this->request->post['econt_pay_after_accept'];
		} else {
			$data['econt_pay_after_accept'] = $this->config->get('econt_pay_after_accept');
		}

		if (isset($this->request->post['econt_pay_after_test'])) {
			$data['econt_pay_after_test'] = $this->request->post['econt_pay_after_test'];
		} else {
			$data['econt_pay_after_test'] = $this->config->get('econt_pay_after_test');
		}

		if (isset($this->request->post['econt_instruction_returns'])) {
			$data['econt_instruction_returns'] = $this->request->post['econt_instruction_returns'];
		} else {
			$data['econt_instruction_returns'] = $this->config->get('econt_instruction_returns');
		}

		if (isset($this->request->post['econt_side'])) {
			$data['econt_side'] = $this->request->post['econt_side'];
		} else {
			$data['econt_side'] = $this->config->get('econt_side');
		}

		if (isset($this->request->post['econt_payment_method'])) {
			$data['econt_payment_method'] = $this->request->post['econt_payment_method'];
		} else {
			$data['econt_payment_method'] = $this->config->get('econt_payment_method');
		}

		if (isset($this->request->post['econt_key_word'])) {
			$data['econt_key_word'] = $this->request->post['econt_key_word'];
		} else {
			$data['econt_key_word'] = $this->config->get('econt_key_word');
		}

		if (isset($this->request->post['econt_cd_agreement'])) {
			$data['econt_cd_agreement'] = $this->request->post['econt_cd_agreement'];
		} else {
			$data['econt_cd_agreement'] = $this->config->get('econt_cd_agreement');
		}

		if (isset($this->request->post['econt_cd_agreement_num'])) {
			$data['econt_cd_agreement_num'] = $this->request->post['econt_cd_agreement_num'];
		} else {
			$data['econt_cd_agreement_num'] = $this->config->get('econt_cd_agreement_num');
		}

		if (isset($this->request->post['econt_total_for_free'])) {
			$data['econt_total_for_free'] = $this->request->post['econt_total_for_free'];
		} else {
			$data['econt_total_for_free'] = $this->config->get('econt_total_for_free');
		}

		if (isset($this->request->post['econt_weight_for_free'])) {
			$data['econt_weight_for_free'] = $this->request->post['econt_weight_for_free'];
		} else {
			$data['econt_weight_for_free'] = $this->config->get('econt_weight_for_free');
		}

		if (isset($this->request->post['econt_count_for_free'])) {
			$data['econt_count_for_free'] = $this->request->post['econt_count_for_free'];
		} else {
			$data['econt_count_for_free'] = $this->config->get('econt_count_for_free');
		}

		if (isset($this->request->post['econt_shipping_payments'])) {
			$data['econt_shipping_payments'] = $this->request->post['econt_shipping_payments'];
		} elseif ($this->config->get('econt_shipping_payments')) {
			if (!is_array($this->config->get('econt_shipping_payments'))) {
				$data['econt_shipping_payments'] = unserialize($this->config->get('econt_shipping_payments'));
			} else {
				$data['econt_shipping_payments'] = $this->config->get('econt_shipping_payments');
			}
		} else {
			$data['econt_shipping_payments'] = array();
		}

		if (isset($this->request->post['econt_priority_time'])) {
			$data['econt_priority_time'] = $this->request->post['econt_priority_time'];
		} else {
			$data['econt_priority_time'] = $this->config->get('econt_priority_time');
		}

		if (isset($this->request->post['econt_delivery_day'])) {
			$data['econt_delivery_day'] = $this->request->post['econt_delivery_day'];
		} else {
			$data['econt_delivery_day'] = $this->config->get('econt_delivery_day');
		}

		if (isset($this->request->post['econt_partial_delivery'])) {
			$data['econt_partial_delivery'] = $this->request->post['econt_partial_delivery'];
		} else {
			$data['econt_partial_delivery'] = $this->config->get('econt_partial_delivery');
		}

		if (isset($this->request->post['econt_partial_delivery_instruction'])) {
			$data['econt_partial_delivery_instruction'] = $this->request->post['econt_partial_delivery_instruction'];
		} else {
			$data['econt_partial_delivery_instruction'] = $this->config->get('econt_partial_delivery_instruction');
		}

		if (isset($this->request->post['econt_inventory'])) {
			$data['econt_inventory'] = $this->request->post['econt_inventory'];
		} else {
			$data['econt_inventory'] = $this->config->get('econt_inventory');
		}

		if (isset($this->request->post['econt_inventory_type'])) {
			$data['econt_inventory_type'] = $this->request->post['econt_inventory_type'];
		} else {
			$data['econt_inventory_type'] = $this->config->get('econt_inventory_type');
		}

		if (isset($this->request->post['econt_return_loading'])) {
			$data['econt_return_loading'] = $this->request->post['econt_return_loading'];
		} else {
			$data['econt_return_loading'] = $this->config->get('econt_return_loading');
		}

		if (isset($this->request->post['econt_instruction'])) {
			$data['econt_instruction'] = $this->request->post['econt_instruction'];
		} else {
			$data['econt_instruction'] = $this->config->get('econt_instruction');
		}

		if (isset($this->request->post['econt_instructions'])) {
			$data['econt_instructions'] = $this->request->post['econt_instructions'];
		} elseif ($this->config->get('econt_instructions')) {
			if (!is_array($this->config->get('econt_instructions'))) {
				$data['econt_instructions'] = unserialize($this->config->get('econt_instructions'));
			} else {
				$data['econt_instructions'] = $this->config->get('econt_instructions');
			}
		} else {
			$data['econt_instructions'] = array();
		}

		if (isset($this->request->post['econt_instructions_id'])) {
			$data['econt_instructions_id'] = $this->request->post['econt_instructions_id'];
		} elseif ($this->config->get('econt_instructions_id')) {
			if (!is_array($this->config->get('econt_instructions_id'))) {
				$data['econt_instructions_id'] = unserialize($this->config->get('econt_instructions_id'));
			} else {
				$data['econt_instructions_id'] = $this->config->get('econt_instructions_id');
			}
		} else {
			$data['econt_instructions_id'] = array();
		}

		if (isset($this->request->post['econt_currency'])) {
			$data['econt_currency'] = $this->request->post['econt_currency'];
		} else {
			$data['econt_currency'] = $this->config->get('econt_currency');
		}

		if (isset($this->request->post['econt_weight_class_id'])) {
			$data['econt_weight_class_id'] = $this->request->post['econt_weight_class_id'];
		} else {
			$data['econt_weight_class_id'] = $this->config->get('econt_weight_class_id');
		}

		if (isset($this->request->post['econt_order_status_id'])) {
			$data['econt_order_status_id'] = $this->request->post['econt_order_status_id'];
		} else {
			$data['econt_order_status_id'] = $this->config->get('econt_order_status_id');
		}

		if (isset($this->request->post['econt_geo_zone_id'])) {
			$data['econt_geo_zone_id'] = $this->request->post['econt_geo_zone_id'];
		} else {
			$data['econt_geo_zone_id'] = $this->config->get('econt_geo_zone_id');
		}

		if (isset($this->request->post['econt_status'])) {
			$data['econt_status'] = $this->request->post['econt_status'];
		} else {
			$data['econt_status'] = $this->config->get('econt_status');
		}

		if (isset($this->request->post['econt_sort_order'])) {
			$data['econt_sort_order'] = $this->request->post['econt_sort_order'];
		} else {
			$data['econt_sort_order'] = $this->config->get('econt_sort_order');
		}

		$data['payment_methods'] = array(
			array('code' => 'CASH', 'title' => $this->language->get('text_cash')),
			array('code' => 'CREDIT', 'title' => $this->language->get('text_credit')),
			array('code' => 'BONUS', 'title' => $this->language->get('text_bonus')),
			array('code' => 'VOUCHER', 'title' => $this->language->get('text_voucher'))
		);

		$data['partial_delivery_instructions'] = array(
			array('code' => 'ACCEPT', 'title' => $this->language->get('text_partial_delivery_accept')),
			array('code' => 'TEST', 'title' => $this->language->get('text_partial_delivery_test'))
		);

		$data['inventory_types'] = array(
			array('code' => 'DIGITAL', 'title' => $this->language->get('text_digital')),
			array('code' => 'LOADING', 'title' => $this->language->get('text_loading'))
		);

		$data['instructions_types'] = array(
			array('code' => 'take', 'title' => $this->language->get('text_instructions_take')),
			array('code' => 'give', 'title' => $this->language->get('text_instructions_give')),
			array('code' => 'return', 'title' => $this->language->get('text_instructions_return')),
			array('code' => 'services', 'title' => $this->language->get('text_instructions_services'))
		);

		$this->load->model('localisation/currency');

		$data['currencies'] = $this->model_localisation_currency->getCurrencies();

		$this->load->model('localisation/weight_class');

		$data['weight_classes'] = $this->model_localisation_weight_class->getWeightClasses();

		$this->load->model('localisation/order_status');

		$data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		$this->load->model('localisation/geo_zone');

		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();

		$data['cities'] = $this->model_shipping_econt->getCitiesWithOffices($this->delivery_type);

		$office = $this->model_shipping_econt->getOffice($data['econt_office_id']);

		if ($office) {
			$data['econt_office_city_id'] = $office['city_id'];
			$data['econt_office_code'] = $office['office_code'];
		} else {
			$data['econt_office_city_id'] = 0;
			$data['econt_office_code'] = '';
		}

		$data['offices'] = $this->model_shipping_econt->getOfficesByCityId($data['econt_office_city_id'], $this->delivery_type);

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('shipping/econt.tpl', $data));
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'shipping/econt')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['econt_username']) {
			$this->error['username'] = $this->language->get('error_username');
		}

		if (!$this->request->post['econt_password']) {
			$this->error['password'] = $this->language->get('error_password');
		}

		if (!$this->request->post['econt_name']) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if (!$this->request->post['econt_name_person']) {
			$this->error['name_person'] = $this->language->get('error_name_person');
		}

		if (!$this->request->post['econt_phone']) {
			$this->error['phone'] = $this->language->get('error_phone');
		}

		if ($this->request->post['econt_username'] && $this->request->post['econt_password']) {
			$data = array(
				'test'     => $this->request->post['econt_test'],
				'username' => $this->request->post['econt_username'],
				'password' => $this->request->post['econt_password'],
				'type'     => 'profile'
			);

			$results = $this->serviceTool($data);
			if (!$results) {
				$this->error['warning'] = $this->language->get('error_connect');
			} elseif ($results->error) {
				$this->error['warning'] = (string)$results->error->message;
			}
		}

		if (!$this->model_shipping_econt->getCitiesWithOffices($this->delivery_type)) {
			$this->error['get_data'] = $this->language->get('error_get_data');
		}

		if (!isset($this->request->post['econt_addresses'])) {
			$this->error['addresses'] = $this->language->get('error_addresses');
		} else {
			foreach ($this->request->post['econt_addresses'] as $address) {
				if ($address['post_code'] && $address['city'] && ($address['quarter'] && $address['other'] || $address['street'] && $address['street_num'])) {
					if (!$this->model_shipping_econt->validateAddress($address)) {
						$this->error['addresses'] = $this->language->get('error_address');
					}
				} else {
					$this->error['addresses'] = $this->language->get('error_address');
				}
			}
		}

		if ($this->request->post['econt_shipping_from'] == 'OFFICE') {
			if (!$this->request->post['econt_office_id']) {
				$this->error['office'] = $this->language->get('error_office');
			}
		}

		if ($this->request->post['econt_sms']) {
			if (!$this->request->post['econt_sms_no']) {
				$this->error['sms'] = $this->language->get('error_sms');
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function refreshData() {
		@ini_set('memory_limit', '512M');
		@ini_set('max_execution_time', 3600);

		$this->language->load('shipping/econt');

		$this->load->model('shipping/econt');

		if (isset($this->request->post['test'])) {
			$test = $this->request->post['test'];
		} else {
			$test = 0;
		}

		if (isset($this->request->post['username'])) {
			$username = $this->request->post['username'];
		} else {
			$username = '';
		}

		if (isset($this->request->post['password'])) {
			$password = $this->request->post['password'];
		} else {
			$password = '';
		}

		if (isset($this->request->post['step'])) {
			$step = $this->request->post['step'];
		} else {
			$step = 0;
		}

		$data = array(
			'test'     => $test,
			'username' => $username,
			'password' => $password
		);

		$results_data = array();

		if (!isset($results_data['error']) && !$step) {
			$data['type'] = 'countries';

			$results = $this->serviceTool($data);

			if ($results) {
				if (isset($results->error)) {
					$results_data['error'] = (string)$results->error->message;
				} else {
					if (isset($results->e)) {
						$this->model_shipping_econt->deleteCountries();

						foreach ($results->e as $country) {
							$country_data = array(
								'name'    => $country->country_name,
								'name_en' => $country->country_name_en,
								'zone_id' => $country->id_zone
							);

							$this->model_shipping_econt->addCountry($country_data);
						}
					}

					$results_data['step'] = $step + 1;
				}
			} else {
				$results_data['error'] = $this->language->get('error_connect');
			}
		}

		if (!isset($results_data['error']) && $step == 1) {
			$data['type'] = 'cities_zones';

			$results = $this->serviceTool($data);

			if ($results) {
				if (isset($results->error)) {
					$results_data['error'] = (string)$results->error->message;
				} else {
					if (isset($results->zones)) {
						$this->model_shipping_econt->deleteZones();

						foreach ($results->zones->e as $zone) {
							$zone_data = array(
								'zone_id'  => $zone->id,
								'name'     => $zone->name,
								'name_en'  => $zone->name_en,
								'national' => $zone->national,
								'is_ee'    => $zone->is_ee
							);

							$this->model_shipping_econt->addZone($zone_data);
						}
					}

					$results_data['step'] = $step + 1;
				}
			} else {
				$results_data['error'] = $this->language->get('error_connect');
			}
		}

		if (!isset($results_data['error']) && $step == 2) {
			$data['type'] = 'cities_regions';

			$results = $this->serviceTool($data);

			if ($results) {
				if (isset($results->error)) {
					$results_data['error'] = (string)$results->error->message;
				} else {
					if (isset($results->cities_regions)) {
						$this->model_shipping_econt->deleteRegions();

						foreach ($results->cities_regions->e as $region) {
							$region_data = array(
								'region_id' => $region->id,
								'name'      => $region->name,
								'code'      => $region->code,
								'city_id'   => $region->id_city
							);

							$this->model_shipping_econt->addRegion($region_data);
						}
					}

					$results_data['step'] = $step + 1;
				}
			} else {
				$results_data['error'] = $this->language->get('error_connect');
			}
		}

		if (!isset($results_data['error']) && $step == 3) {
			$data['type'] = 'cities_quarters';

			$results = $this->serviceTool($data);

			if ($results) {
				if (isset($results->error)) {
					$results_data['error'] = (string)$results->error->message;
				} else {
					if (isset($results->cities_quarters)) {
						$this->model_shipping_econt->deleteQuarters();

						foreach ($results->cities_quarters->e as $quarter) {
							$quarter_data = array(
								'quarter_id'     => $quarter->id,
								'name'           => $quarter->name,
								'name_en'        => $quarter->name_en,
								'city_id'        => $quarter->id_city
							);

							$this->model_shipping_econt->addQuarter($quarter_data);
						}
					}

					$results_data['step'] = $step + 1;
				}
			} else {
				$results_data['error'] = $this->language->get('error_connect');
			}
		}

		if (!isset($results_data['error']) && $step == 4) {
			$data['type'] = 'cities_streets';

			$results = $this->serviceTool($data);

			if ($results) {
				if (isset($results->error)) {
					$results_data['error'] = (string)$results->error->message;
				} else {
					if (isset($results->cities_street)) {
						$this->model_shipping_econt->deleteStreets();

						foreach ($results->cities_street->e as $street) {
							$street_data = array(
								'street_id'      => $street->id,
								'name'           => $street->name,
								'name_en'        => $street->name_en,
								'city_id'        => $street->id_city
							);

							$this->model_shipping_econt->addStreet($street_data);
						}
					}
					
					$results_data['step'] = $step + 1;
				}
			} else {
				$results_data['error'] = $this->language->get('error_connect');
			}
		}

		if (!isset($results_data['error']) && $step == 5) {
			$data['type'] = 'offices';

			$results = $this->serviceTool($data);

			if ($results) {
				if (isset($results->error)) {
					$results_data['error'] = (string)$results->error->message;
				} else {
					if (isset($results->offices)) {
						$this->model_shipping_econt->deleteOffices();

						foreach ($results->offices->e as $office) {
							$office_data = array(
								'office_id'           => $office->id,
								'name'                => $office->name,
								'name_en'             => $office->name_en,
								'office_code'         => $office->office_code,
								'address'             => $office->address,
								'address_en'          => $office->address_en,
								'phone'               => $office->phone,
								'work_begin'          => $office->work_begin,
								'work_end'            => $office->work_end,
								'work_begin_saturday' => $office->work_begin_saturday,
								'work_end_saturday'   => $office->work_end_saturday,
								'time_priority'       => $office->time_priority,
								'city_id'             => $office->id_city
							);

							$this->model_shipping_econt->addOffice($office_data);
						}
					}

					$results_data['step'] = $step + 1;
				}
			} else {
				$results_data['error'] = $this->language->get('error_connect');
			}
		}

		if (!isset($results_data['error']) && $step == 6) {
			$data['type'] = 'cities';

			$results = $this->serviceTool($data);

			if ($results) {
				if (isset($results->error)) {
					$results_data['error'] = (string)$results->error->message;
				} else {
					if (isset($results->cities)) {
						$this->model_shipping_econt->deleteCities();
						$this->model_shipping_econt->deleteCitiesOffices();

						foreach ($results->cities->e as $city) {
							$city_data = array(
								'city_id'    => $city->id,
								'post_code'  => $city->post_code,
								'type'       => $city->type,
								'name'       => $city->name,
								'name_en'    => $city->name_en,
								'zone_id'    => $city->id_zone,
								'country_id' => $city->id_country,
								'office_id'  => $city->id_office
							);

							$this->model_shipping_econt->addCity($city_data);

							if (isset($city->attach_offices)) {
								foreach ($city->attach_offices->children() as $shipment_type) {
									foreach ($shipment_type->children() as $delivery_type) {
										foreach ($delivery_type->office_code as $office_code) {
											$city_office_data = array(
												'office_code' => $office_code,
												'shipment_type' => $shipment_type->getName(),
												'delivery_type' => $delivery_type->getName(),
												'city_id' => $city->id
											);

											$this->model_shipping_econt->addCityOffice($city_office_data);
										}
									}
								}
							}
						}

						$results_data['cities'] = $this->model_shipping_econt->getCitiesWithOffices($this->delivery_type);
					}
				}
			} else {
				$results_data['error'] = $this->language->get('error_connect');
			}
		}

		$this->response->setOutput(json_encode($results_data));
	}

	public function getProfile() {
		$this->language->load('shipping/econt');

		$this->load->model('shipping/econt');

		if (isset($this->request->post['test'])) {
			$test = $this->request->post['test'];
		} else {
			$test = 0;
		}

		if (isset($this->request->post['username'])) {
			$username = $this->request->post['username'];
		} else {
			$username = '';
		}

		if (isset($this->request->post['password'])) {
			$password = $this->request->post['password'];
		} else {
			$password = '';
		}

		$data = array(
			'test'     => $test,
			'username' => $username,
			'password' => $password,
			'type'     => 'profile'
		);

		$profile_data = array();

		$results = $this->serviceTool($data);

		if ($results) {
			if (isset($results->error)) {
				$profile_data['error'] = (string)$results->error->message;
			} else {
				if (isset($results->client_info)) {
					$profile_data['client_info'] = $results->client_info;

					if (!empty($results->client_info->id)) {
						if (!$test) {
							$instructions_form_url = 'http://ee.econt.com/load_direct.php?target=EeLoadingInstructions';
						} else {
							$instructions_form_url = 'http://demo.econt.com/ee/load_direct.php?target=EeLoadingInstructions';
						}

						$profile_data['instructions_form_url'] = $instructions_form_url . '&login_username=' . $username . '&login_password=' . md5($password) . '&target_type=client&id_target=' . (string)$results->client_info->id;
					}
				}

				if (isset($results->addresses)) {
					foreach ($results->addresses->e as $address) {

						if (isset($address->city) && isset($address->city_post_code)) {
							$city = $this->model_shipping_econt->getCityByNameAndPostcode($address->city, $address->city_post_code);

							if ($city) {
								$address->city_id = $city['city_id'];
							}
						}

						$profile_data['addresses'][] = $address;
					}
				}
			}
		} else {
			$profile_data['error'] = $this->language->get('error_connect');
		}

		$this->response->setOutput(json_encode($profile_data));
	}

	public function getOfficeByOfficeCode() {
		$this->load->model('shipping/econt');

		$json = array();

		if (isset($this->request->post['office_code']) && $this->request->post['office_code']) {
			$office = $this->model_shipping_econt->getOfficeByOfficeCode(trim($this->request->post['office_code']));
			if (!empty($office)) {
				$json['office_id'] = $office['office_id'];
				$json['city_id'] = $office['city_id'];

				$json['offices'] = $this->model_shipping_econt->getOfficesByCityId($office['city_id'], $this->delivery_type);
			} else {
				$json['error'] = $this->language->get('error_office_not_found');
			}
		} else {
			$json['error'] = $this->language->get('error_office_not_found');
		}

		$this->response->setOutput(json_encode($json));
	}

	public function getCitiesByName() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('shipping/econt');

			$filter_name = $this->request->get['filter_name'];

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 10;
			}

			$json = $this->model_shipping_econt->getCitiesByName($filter_name, $limit);
		}

		$this->response->setOutput(json_encode($json));
	}

	public function getQuartersByName() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('shipping/econt');

			$filter_name = $this->request->get['filter_name'];

			if (isset($this->request->get['city_id'])) {
				$city_id = $this->request->get['city_id'];
			} else {
				$city_id = 0;
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 10;
			}

			$json = $this->model_shipping_econt->getQuartersByName($filter_name, $city_id, $limit);
		}

		$this->response->setOutput(json_encode($json));
	}

	public function getStreetsByName() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('shipping/econt');

			$filter_name = $this->request->get['filter_name'];

			if (isset($this->request->get['city_id'])) {
				$city_id = $this->request->get['city_id'];
			} else {
				$city_id = 0;
			}

			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];
			} else {
				$limit = 10;
			}

			$json = $this->model_shipping_econt->getStreetsByName($filter_name, $city_id, $limit);
		}

		$this->response->setOutput(json_encode($json));
	}

	public function getOfficesByCityId() {
		$this->load->model('shipping/econt');

		if (isset($this->request->post['city_id'])) {
			$city_id = $this->request->post['city_id'];
		} else {
			$city_id = 0;
		}

		$results = $this->model_shipping_econt->getOfficesByCityId($city_id, $this->delivery_type);

		$this->response->setOutput(json_encode($results));
	}

	public function getOffice() {
		$this->load->model('shipping/econt');

		if (isset($this->request->post['office_id'])) {
			$office_id = $this->request->post['office_id'];
		} else {
			$office_id = 0;
		}

		$results = $this->model_shipping_econt->getOffice($office_id);

		$this->response->setOutput(json_encode($results));
	}

	public function getClients() {
		$this->language->load('shipping/econt');

		if (isset($this->request->post['test'])) {
			$test = $this->request->post['test'];
		} else {
			$test = 0;
		}

		if (isset($this->request->post['username'])) {
			$username = $this->request->post['username'];
		} else {
			$username = '';
		}

		if (isset($this->request->post['password'])) {
			$password = $this->request->post['password'];
		} else {
			$password = '';
		}

		$data = array(
			'test'     => $test,
			'username' => $username,
			'password' => $password,
			'type'     => 'access_clients'
		);

		$clients_data = array();

		$results = $this->serviceTool($data);

		if ($results) {
			if (isset($results->error)) {
				$clients_data['error'] = (string)$results->error->message;
			} else {
				if (isset($results->clients)) {
					foreach ($results->clients->client as $client) {
						$clients_data['key_words'][] = (string)$client->key_word;

						if (isset($client->cd_agreements)) {
							foreach ($client->cd_agreements->cd_agreement as $cd_agreement) {
								$clients_data['cd_agreement_nums'][] = (string)$cd_agreement->num;
							}
						}

						if (isset($client->instructions)) {
							foreach ($client->instructions->e as $instruction) {
								$clients_data['instructions'][(string)$instruction->type][] = (string)$instruction->template;
							}
						}
					}
				}
			}
		} else {
			$clients_data['error'] = $this->language->get('error_connect');
		}

		$this->response->setOutput(json_encode($clients_data));
	}

	protected function serviceTool($data) {
		if (!$data['test']) {
			$url = 'http://www.econt.com/e-econt/xml_service_tool.php';
		} else {
			$url = 'http://demo.econt.com/e-econt/xml_service_tool.php';
		}

		$request = '<?xml version="1.0" ?>
					<request>
						<client>
							<username>' . $data['username'] . '</username>
							<password>' . $data['password'] . '</password>
						</client>
						<request_type>' . $data['type'] . '</request_type>
						<mediator>extensa</mediator>';

		if (isset($data['xml'])) {
			$request .= $data['xml'];
		}

		$request .= '</request>';

		$ch = curl_init();

		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, array('xml' => $request));

		$response = curl_exec($ch);

		curl_close($ch);

		libxml_use_internal_errors(true);
		return simplexml_load_string($response);
	}

	public function install() {
		$this->load->model('setting/setting');

		$shipping_data = array(
			'shipping_estimator'  => 0,
			'shipping_status'     => 1,
			'shipping_sort_order' => $this->config->get('shipping_sort_order')
		);

		$this->model_setting_setting->editSetting('shipping', $shipping_data);

		$cod_data = array(
			'cod_status' => 0
		);

		$this->model_setting_setting->editSetting('cod', $cod_data);

		$this->load->model('shipping/econt');

		$this->model_shipping_econt->createTables();

		@mail('support@extensadev.com', 'Econt Express Shipping Module installed (OpenCart)', HTTP_CATALOG . ' - ' . $this->config->get('config_name') . "\r\n" . 'version - ' . VERSION . "\r\n" . 'IP - ' . $this->request->server['REMOTE_ADDR'], 'MIME-Version: 1.0' . "\r\n" . 'Content-type: text/plain; charset=UTF-8' . "\r\n" . 'From: ' . $this->config->get('config_owner') . ' <' . $this->config->get('config_email') . '>' . "\r\n");
	}

	public function uninstall() {
		$this->load->model('shipping/econt');

		$this->model_shipping_econt->deleteTables();
	}

	private function update_rs() { //for Return Solution
		$this->load->model('shipping/econt');

		$this->model_shipping_econt->updateTablesRS();

		$this->load->model('setting/setting');

		$data = $this->model_setting_setting->getSetting('econt');
		$data['econt_updated_rs'] = TRUE;

		$this->model_setting_setting->editSetting('econt', $data);
	}
}
?>
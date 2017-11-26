<?php
class ControllerShippingEcont extends Controller {
	private $error = array();
	private $delivery_type = 'to_office';

	public function index() {
		$this->load->language('shipping/econt');
		$this->load->language('checkout/checkout');

		$this->load->model('shipping/econt');

		$results = array();

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if ($this->customer->isLogged()) {
				$this->model_shipping_econt->addCustomer($this->request->post);
			}

			$this->session->data['econt'] = $this->request->post;
			$this->session->data['econt']['econt_validate'] = TRUE;

			$results['submit'] = true;
			$this->response->setOutput(json_encode($results));
		}

		if ((!$this->cart->hasProducts() && (!isset($this->session->data['vouchers']) || !$this->session->data['vouchers'])) || (!$this->cart->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$results['redirect'] = $this->url->link('checkout/cart');

			$this->response->setOutput(json_encode($results));
		}

		if (!$this->customer->isLogged() && !isset($this->session->data['guest'])) {
			$results['redirect'] = $this->url->link('checkout/checkout', '', 'SSL');


			$this->response->setOutput(json_encode($results));
		}

		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_select'] = $this->language->get('text_select');
		$data['text_calculate'] = $this->language->get('text_calculate');
		$data['text_wait'] = $this->language->get('text_wait');
		$data['text_to_office'] = $this->language->get('text_to_office');
		$data['text_to_door'] = $this->language->get('text_to_door');
		$data['text_value'] = $this->language->get('text_value');
		$data['text_hour'] = $this->language->get('text_hour');
		$data['text_e1'] = $this->language->get('text_e1');
		$data['text_e2'] = $this->language->get('text_e2');
		$data['text_e3'] = $this->language->get('text_e3');
		$data['text_dc'] = $this->language->get('text_dc');
		$data['text_dc_cp'] = $this->language->get('text_dc_cp');
		$data['text_invoice_before_cd'] = $this->language->get('text_invoice_before_cd');
		$data['text_pay_after_accept'] = $this->language->get('text_pay_after_accept');
		$data['text_pay_after_test'] = $this->language->get('text_pay_after_test');
		$data['text_instruction_shipping_returns'] = $this->language->get('text_instruction_shipping_returns');
		$data['text_instruction_returns'] = $this->language->get('text_instruction_returns');
		$data['text_partial_delivery'] = $this->language->get('text_partial_delivery');
		$data['text_modify'] = $this->language->get('text_modify');
		$data['text_checkout_confirm'] = $this->language->get('text_checkout_confirm');
		$data['text_checkout_payment_method'] = $this->language->get('text_checkout_payment_method');

		$data['entry_shipping_to'] = $this->language->get('entry_shipping_to');
		$data['entry_post_code'] = $this->language->get('entry_post_code');
		$data['entry_city'] = $this->language->get('entry_city');
		$data['entry_quarter'] = $this->language->get('entry_quarter');
		$data['entry_street'] = $this->language->get('entry_street');
		$data['entry_street_num'] = $this->language->get('entry_street_num');
		$data['entry_other'] = $this->language->get('entry_other');
		$data['entry_office'] = $this->language->get('entry_office');
		$data['entry_office_code'] = $this->language->get('entry_office_code');
		$data['entry_cd'] = $this->language->get('entry_cd');
		$data['entry_priority_time'] = $this->language->get('entry_priority_time');
		$data['entry_express_city_courier'] = $this->language->get('entry_express_city_courier');
		$data['entry_delivery_day'] = $this->language->get('entry_delivery_day');

		$data['button_office_locator'] = $this->language->get('button_office_locator');
		$data['button_calculate'] = $this->language->get('button_calculate');

		if (isset($this->error['address'])) {
			$data['error_address'] = $this->error['address'];
		} else {
			$data['error_address'] = '';
		}

		if (isset($this->error['office'])) {
			$data['error_office'] = $this->error['office'];
		} else {
			$data['error_office'] = '';
		}

		if (isset($this->error['priority_time'])) {
			$data['error_priority_time'] = $this->error['priority_time'];
		} else {
			$data['error_priority_time'] = '';
		}

		$data['action'] = $this->url->link('shipping/econt', '', 'SSL');

		$data['office_locator'] = 'https://www.bgmaps.com/templates/econt?office_type=to_office_courier&shop_url=' . HTTPS_SERVER;
		$data['office_locator_domain'] = 'https://www.bgmaps.com';

		if ($this->customer->isLogged()) {
			$shipping_address = $this->model_shipping_econt->getCustomer($this->customer->getId());

			if (!$shipping_address) {
				$this->load->model('account/address');

				$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address']['address_id']);
			}
		} elseif (isset($this->session->data['econt'])) {
			$shipping_address = $this->session->data['econt'];
		}

		if (isset($this->request->post['shipping_to']) && (($this->request->post['shipping_to'] == 'DOOR' && $this->config->get('econt_to_door')) || ($this->request->post['shipping_to'] == 'OFFICE' && $this->config->get('econt_to_office')))) {
			$data['shipping_to'] = $this->request->post['shipping_to'];
		} elseif (isset($shipping_address['shipping_to']) && (($shipping_address['shipping_to'] == 'DOOR' && $this->config->get('econt_to_door')) || ($shipping_address['shipping_to'] == 'OFFICE' && $this->config->get('econt_to_office')))) {
			$data['shipping_to'] = $shipping_address['shipping_to'];
		} elseif (!$this->config->get('econt_to_door') && $this->config->get('econt_to_office')) {
			$data['shipping_to'] = 'OFFICE';
		} elseif ($this->config->get('econt_to_door') && !$this->config->get('econt_to_office')) {
			$data['shipping_to'] = 'DOOR';
		} else {
			$data['shipping_to'] = 'OFFICE';
		}

		if (isset($this->request->post['postcode'])) {
			$data['postcode'] = $this->request->post['postcode'];
		} elseif (isset($shipping_address['postcode'])) {
			$data['postcode'] = $shipping_address['postcode'];
		} else {
			$data['postcode'] = $this->session->data['shipping_address']['postcode'];
		}

		if (isset($this->request->post['city'])) {
			$data['city'] = $this->request->post['city'];
		} elseif (isset($shipping_address['city'])) {
			$data['city'] = $shipping_address['city'];
		} else {
			$data['city'] = $this->session->data['shipping_address']['city'];
		}

		if (isset($this->request->post['city_id'])) {
			$data['city_id'] = $this->request->post['city_id'];
		} elseif (isset($shipping_address['city_id'])) {
			$data['city_id'] = $shipping_address['city_id'];
		} elseif ($data['city']) {
			$city_name = $data['city'];
			$postcode = $data['postcode'];
			$data['city_id'] = 0;
			$data['postcode'] = '';
			$data['city'] = '';

			$cities = $this->model_shipping_econt->getCitiesByName($city_name);

			if ($cities) {
				if (count($cities) > 1) {
					foreach ($cities as $city) {
						if (trim($city['post_code']) == trim($postcode)) {
							$data['city_id'] = $city['city_id'];
							$data['postcode'] = $city['post_code'];
							$data['city'] = $city_name;
							break;
						}
					}
				} else {
					$data['city_id'] = $cities[0]['city_id'];
					$data['postcode'] = $cities[0]['post_code'];
					$data['city'] = $city_name;
				}
			}
		} else {
			$data['city_id'] = 0;
		}

		if (isset($this->request->post['quarter'])) {
			$data['quarter'] = $this->request->post['quarter'];
		} elseif (isset($shipping_address['quarter'])) {
			$data['quarter'] = $shipping_address['quarter'];
		} else {
			$data['quarter'] = '';
		}

		if (isset($this->request->post['street'])) {
			$data['street'] = $this->request->post['street'];
		} elseif (isset($shipping_address['street'])) {
			$data['street'] = $shipping_address['street'];
		} else {
			$data['street'] = '';
		}

		if (isset($this->request->post['street_num'])) {
			$data['street_num'] = $this->request->post['street_num'];
		} elseif (isset($shipping_address['street_num'])) {
			$data['street_num'] = $shipping_address['street_num'];
		} else {
			$data['street_num'] = '';
		}

		if (isset($this->request->post['other'])) {
			$data['other'] = $this->request->post['other'];
		} elseif (isset($shipping_address['other'])) {
			$data['other'] = $shipping_address['other'];
		} else {
			$data['other'] = '';
		}

		if (isset($this->request->post['office_city_id'])) {
			$data['office_city_id'] = $this->request->post['office_city_id'];
		} elseif (isset($this->session->data['econt']['office_city_id'])) {
			$data['office_city_id'] = $this->session->data['econt']['office_city_id'];
		} else {
			$data['office_city_id'] = 0;
		}

		if (isset($this->request->post['office_id'])) {
			$data['office_id'] = $this->request->post['office_id'];
		} elseif (isset($shipping_address['office_id'])) {
			$data['office_id'] = $shipping_address['office_id'];
		} else {
			$data['office_id'] = 0;
		}

		if (isset($this->request->post['office_code'])) {
			$data['office_code'] = $this->request->post['office_code'];
		} elseif (isset($this->session->data['econt']['office_code'])) {
			$data['office_code'] = $this->session->data['econt']['office_code'];
		} else {
			$data['office_code'] = '';
		}

		if (isset($this->request->post['priority_time_cb'])) {
			$data['priority_time_cb'] = $this->request->post['priority_time_cb'];
		} elseif (isset($this->session->data['econt']['priority_time_cb'])) {
			$data['priority_time_cb'] = $this->session->data['econt']['priority_time_cb'];
		} else {
			$data['priority_time_cb'] = false;
		}

		if (isset($this->request->post['priority_time_type_id'])) {
			$data['priority_time_type_id'] = $this->request->post['priority_time_type_id'];
		} elseif (isset($this->session->data['econt']['priority_time_type_id'])) {
			$data['priority_time_type_id'] = $this->session->data['econt']['priority_time_type_id'];
		} else {
			$data['priority_time_type_id'] = 'BEFORE';
		}

		if (isset($this->request->post['priority_time_hour_id'])) {
			$data['priority_time_hour_id'] = $this->request->post['priority_time_hour_id'];
		} elseif (isset($this->session->data['econt']['priority_time_hour_id'])) {
			$data['priority_time_hour_id'] = $this->session->data['econt']['priority_time_hour_id'];
		} else {
			$data['priority_time_hour_id'] = '';
		}

		if (isset($this->request->post['delivery_day_id'])) {
			$data['delivery_day_id'] = $this->request->post['delivery_day_id'];
		} elseif (isset($this->session->data['econt']['delivery_day_id'])) {
			$data['delivery_day_id'] = $this->session->data['econt']['delivery_day_id'];
		} else {
			$data['delivery_day_id'] = '';
		}

		if (isset($this->request->post['express_city_courier_cb'])) {
			$data['express_city_courier_cb'] = $this->request->post['express_city_courier_cb'];
		} elseif (isset($this->session->data['econt']['express_city_courier_cb'])) {
			$data['express_city_courier_cb'] = $this->session->data['econt']['express_city_courier_cb'];
		} else {
			$data['express_city_courier_cb'] = false;
		}

		if (isset($this->request->post['express_city_courier_e'])) {
			$data['express_city_courier_e'] = $this->request->post['express_city_courier_e'];
		} elseif (isset($this->session->data['econt']['express_city_courier_e'])) {
			$data['express_city_courier_e'] = $this->session->data['econt']['express_city_courier_e'];
		} else {
			$data['express_city_courier_e'] = 'e1';
		}

		if (!$this->config->get('econt_to_door') && !$this->config->get('econt_to_office')) {
			$data['to_door'] = true;
		} else {
			$data['to_door'] = $this->config->get('econt_to_door');
		}

		$data['to_office'] = $this->config->get('econt_to_office');

		if ($this->config->get('econt_cod_status') && $this->config->get('econt_cd')) {
			$data['cd'] = true;
		} else {
			$data['cd'] = false;
		}

		if (!$data['cd']) {
			$data['cd_payment'] = FALSE;
		} elseif (isset($this->request->post['cd_payment'])) {
			$data['cd_payment'] = $this->request->post['cd_payment'];
		} elseif (isset($this->session->data['econt']['cd_payment'])) {
			$data['cd_payment'] = $this->session->data['econt']['cd_payment'];
		} else {
			$data['cd_payment'] = TRUE;
		}

		$total = $this->currency->format($this->cart->getTotal(), $this->config->get('econt_currency'), '', false);

		$data['priority_time'] = $this->config->get('econt_priority_time');

		$data['priority_time_types'] = array(
			array('id' => 'BEFORE', 'name' => $this->language->get('text_before'), 'hours' => array(10, 11, 12, 13, 14, 15, 16, 17, 18)),
			array('id' => 'IN', 'name' => $this->language->get('text_in'), 'hours' => array(9, 10, 11, 12, 13, 14, 15, 16, 17, 18)),
			array('id' => 'AFTER', 'name' => $this->language->get('text_after'), 'hours' => array(9, 10, 11, 12, 13, 14, 15, 16, 17))
		);

		if (!is_array($this->config->get('econt_addresses'))) {
			$addresses = unserialize($this->config->get('econt_addresses'));
		} else {
			$addresses = $this->config->get('econt_addresses');
		}
		reset($addresses);
		$address = current($addresses);

		if ((count($addresses) == 1) && ($address['post_code'] == $data['postcode'])) {
			$data['express_city_courier'] = true;
		} else {
			$data['express_city_courier'] = false;
		}

		$data['sender_post_code'] = $address['post_code'];

		$data['cities'] = $this->model_shipping_econt->getCitiesWithOffices($this->delivery_type);

		if ((!$data['office_city_id'] || !$data['office_code']) && $data['office_id']) {
			$office = $this->model_shipping_econt->getOffice($data['office_id']);

			if ($office) {
				$data['office_city_id'] = $office['city_id'];
				$data['office_code'] = $office['office_code'];
			}
		}

		if (!$data['office_city_id'] && $data['city'] && $data['city_id']) {
			$data['office_city_id'] = $data['city_id'];
		}

		$data['offices'] = array();

		if ($data['office_city_id']) {
			$data['offices'] = $this->model_shipping_econt->getOfficesByCityId($data['office_city_id'], $this->delivery_type);
		}

		$data['delivery_day'] = $this->config->get('econt_delivery_day');

		$data['error_delivery_day'] = '';
		$data['delivery_days'] = array();
		$data['priority_date'] = '';

		if ($this->config->get('econt_delivery_day')) {
			$delivery_days_data = array(
				'test'     => $this->config->get('econt_test'),
				'username' => htmlspecialchars_decode($this->config->get('econt_username')),
				'password' => htmlspecialchars_decode($this->config->get('econt_password')),
				'type'     => 'delivery_days',
				'xml'      => '<delivery_days>' . date('Y-m-d') . '</delivery_days>'
			);

			$delivery_days_results = $this->serviceTool($delivery_days_data);

			if ($delivery_days_results) {
				if (isset($delivery_days_results->error)) {
					$data['error_delivery_day'] = (string)$delivery_days_results->error->message;
				} else {
					if (isset($delivery_days_results->delivery_days)) {
						foreach ($delivery_days_results->delivery_days->e as $delivery_day) {
							$data['delivery_days'][] = array(
								'id' => $delivery_day->date,
								'day' => date('w', strtotime($delivery_day->date)),
								'name' => $this->language->get('text_day_' . date('w', strtotime($delivery_day->date)))
							);

							if (date('w', strtotime($delivery_day->date)) == 6) {
								$data['priority_date'] = $delivery_day->date;
							} elseif (!$data['delivery_day_id']) {
								$data['delivery_day_id'] = $delivery_day->date;
							}
						}
					}
				}
			} else {
				$data['error_delivery_day'] = $this->language->get('error_connect');
			}
		}

		$data['dc_cp'] = $this->config->get('econt_dc_cp');

		if ($this->config->get('econt_dc_cp')) {
			$data['dc'] = false;
		} else {
			$data['dc'] = $this->config->get('econt_dc');
		}

		$data['invoice_before_cd'] = $this->config->get('econt_invoice_before_cd');

		$data['pay_after_test'] = $this->config->get('econt_pay_after_test');

		if ($this->config->get('pay_after_test')) {
			$data['pay_after_accept'] = false;
		} else {
			$data['pay_after_accept'] = $this->config->get('econt_pay_after_accept');
		}

		if ($this->config->get('econt_instruction_returns') == 'shipping_returns') {
			$data['instruction_shipping_returns'] = true;
			$data['instruction_returns'] = false;
		} elseif ($this->config->get('econt_instruction_returns') == 'returns') {
			$data['instruction_shipping_returns'] = false;
			$data['instruction_returns'] = true;
		} else {
			$data['instruction_shipping_returns'] = false;
			$data['instruction_returns'] = false;
		}

		if ($this->config->get('econt_partial_delivery') && ($this->cart->countProducts() > 1)) {
			$data['partial_delivery'] = true;
		} else {
			$data['partial_delivery'] = false;
		}

		if (!empty($this->session->data['shipping_methods']['econt']['quote']['econt_office']['text'])) {
			$data['office_calculated'] = true;
		} else {
			$data['office_calculated'] = false;
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/shipping/econt.tpl')) {
			$results['html'] = $this->load->view($this->config->get('config_template') . '/template/shipping/econt.tpl', $data);
		} else {
			$results['html'] = $this->load->view('default/template/shipping/econt.tpl', $data);
		}
		
		$this->response->setOutput(json_encode($results));
	}

	protected function validate() {
		if (empty($this->request->post['next_step'])) {
			return true;
		}

		if ($this->request->post['shipping_to'] == 'DOOR' && $this->request->post['postcode'] && $this->request->post['city'] && ($this->request->post['quarter'] && $this->request->post['other'] || $this->request->post['street'] && $this->request->post['street_num'])) {
			if (!$this->model_shipping_econt->validateAddress($this->request->post)) {
				$this->error['address'] = $this->language->get('error_address');
			}
		} elseif ($this->request->post['shipping_to'] == 'DOOR') {
			$this->error['address'] = $this->language->get('error_address');
		}

		if ($this->request->post['shipping_to'] == 'OFFICE') {
			if (!$this->request->post['office_id']) {
				$this->error['office'] = $this->language->get('error_office');
			}
		}

		if (isset($this->request->post['priority_time_cb'])) {
			if (!$this->request->post['priority_time_hour_id'] || $this->request->post['priority_time_hour_id'] < 9 || $this->request->post['priority_time_hour_id'] > 18) {
				$this->error['priority_time'] = $this->language->get('error_priority_time');
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
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
}
?>
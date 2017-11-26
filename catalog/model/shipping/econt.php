<?php
class ModelShippingEcont extends Model {
	private $delivery_type = 'to_office';

	function getQuote($address) {
		$this->load->language('shipping/econt');

		if (isset($address['validate'])) {
			$status = true;
		} else {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('econt_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");

			if (!$this->config->get('econt_geo_zone_id')) {
				$status = true;
			} elseif ($query->num_rows) {
				$status = true;
			} else {
				$status = false;
			}
		}

		$method_data = array();

		if ($status) {
			$quote_data = array();

			$to_office = false;
			$to_door = false;

			if ($this->config->get('econt_to_office')) {
				$to_office = true;
			}
			if ($this->config->get('econt_to_door') || !$to_office) {
				$to_door = true;
			}

			if ($to_office) {
				$quote_data['econt_office'] = array(
					'code'         => 'econt.econt_office',
					'title'        => $this->language->get('text_description') . ' - ' . $this->language->get('text_to_office'),
					'cost'         => 0.00,
					'tax_class_id' => 0,
					'text'         => $this->currency->format(0.00)
				);
			}

			if ($to_door) {
				$quote_data['econt_door'] = array(
					'code'         => 'econt.econt_door',
					'title'        => $this->language->get('text_description') . ' - ' . $this->language->get('text_to_door'),
					'cost'         => 0.00,
					'tax_class_id' => 0,
					'text'         => $this->currency->format(0.00)
				);
			}

			$method_data = array(
				'code'       => 'econt',
				'title'      => $this->language->get('text_title'),
				'quote'      => $quote_data,
				'sort_order' => $this->config->get('econt_sort_order'),
				'error'      => false
			);

			$receiver_address = array();

			if (!empty($this->session->data['econt']['city_id']) || !empty($this->session->data['econt']['office_city_id'])) {
				$receiver_address['post_code'] = $this->session->data['econt']['postcode'];
				$receiver_address['city'] = $this->session->data['econt']['city'];
				$receiver_address['city_id'] = $this->session->data['econt']['city_id'];
				$receiver_address['office_city_id'] = $this->session->data['econt']['office_city_id'];
				$receiver_address['office_id'] = $this->session->data['econt']['office_id'];
				$receiver_address['quarter'] = $this->session->data['econt']['quarter'];
				$receiver_address['street'] = $this->session->data['econt']['street'];
				$receiver_address['street_num'] = $this->session->data['econt']['street_num'];
				$receiver_address['other'] = $this->session->data['econt']['other'];
			} else {
				if ($this->customer->isLogged()) {
					$shipping_address = $this->getCustomer($this->customer->getId());

					if ($shipping_address) {
						$receiver_address['post_code'] = $shipping_address['postcode'];
						$receiver_address['city'] = $shipping_address['city'];
						$receiver_address['city_id'] = $shipping_address['city_id'];
						$receiver_address['office_id'] = $shipping_address['office_id'];
						$receiver_address['quarter'] = $shipping_address['quarter'];
						$receiver_address['street'] = $shipping_address['street'];
						$receiver_address['street_num'] = $shipping_address['street_num'];
						$receiver_address['other'] = $shipping_address['other'];
					} else {
						$this->load->model('account/address');

						$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address']['address_id']);

						$receiver_address['post_code'] = $shipping_address['postcode'];
						$receiver_address['city'] = $shipping_address['city'];
					}
				} else {
					$receiver_address['post_code'] = $this->session->data['shipping_address']['postcode'];
					$receiver_address['city'] = $this->session->data['shipping_address']['city'];
				} 
			}

			if (empty($receiver_address['city_id'])) {
				if (!empty($receiver_address['office_city_id'])) {
					$city = $this->getCityByCityId($receiver_address['office_city_id']);
					$receiver_address['post_code'] = $city['post_code'];
					$receiver_address['city'] = $city['name'];
					$receiver_address['city_id'] = $city['city_id'];
				} else {
					$cities = $this->getCitiesByName($receiver_address['city']);

					if ($cities) {
						if (count($cities) > 1) {
							foreach ($cities as $city) {
								if (trim($city['post_code']) == trim($receiver_address['post_code'])) {
									$receiver_address['post_code'] = $city['post_code'];
									$receiver_address['city_id'] = $city['city_id'];
									break;
								}
							}
						} else {
							$receiver_address['post_code'] = $cities[0]['post_code'];
							$receiver_address['city_id'] = $cities[0]['city_id'];
						}
					}
				}
			}

			if (!empty($receiver_address['city_id'])) {
				$data = array();

				//$total = round($this->currency->format($this->cart->getTotal(), $this->config->get('econt_currency'), '', false), 2);

				$this->load->model('extension/extension');

				$total_data = array();
				$total = 0;
				$taxes = $this->cart->getTaxes();
				$sort_order = array();

				$results = $this->model_extension_extension->getExtensions('total');

				foreach ($results as $key => $value) {
					$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
				}

				array_multisort($sort_order, SORT_ASC, $results);

				foreach ($results as $result) {
					if ($this->config->get($result['code'] . '_status')) {
						$this->load->model('total/' . $result['code']);

						if ($result['code'] != 'shipping') {
							$this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
						}
					}
				}

				$total = round($this->currency->format($total, $this->config->get('econt_currency'), '', false), 2);

				$data['system']['validate'] = 1;
				$data['system']['response_type'] = 'XML';
				$data['system']['only_calculate'] = 1;

				$data['client']['username'] = htmlspecialchars_decode($this->config->get('econt_username'));
				$data['client']['password'] = htmlspecialchars_decode($this->config->get('econt_password'));

				$row = array();
				$row2 = array();

				if (!is_array($this->config->get('econt_addresses'))) {
					$sender_addresses = unserialize($this->config->get('econt_addresses'));
				} else {
					$sender_addresses = $this->config->get('econt_addresses');
				}
				reset($sender_addresses);
				$sender_address = current($sender_addresses);

				$row['sender']['city'] = $sender_address['city'];
				$row['sender']['post_code'] = $sender_address['post_code'];

				$sender_office_code = '';

				if ($this->config->get('econt_shipping_from') == 'OFFICE') {
					$sender_office = $this->getOffice($this->config->get('econt_office_id'));

					if ($sender_office) {
						$sender_office_code = $sender_office['office_code'];
					}
				}

				$row['sender']['office_code'] = $sender_office_code;
				$row['sender']['name'] = $this->config->get('econt_name');
				$row['sender']['name_person'] = $this->config->get('econt_name_person');
				$row['sender']['quarter'] = $sender_address['quarter'];
				$row['sender']['street'] = $sender_address['street'];
				$row['sender']['street_num'] = $sender_address['street_num'];
				$row['sender']['street_bl'] = '';
				$row['sender']['street_vh'] = '';
				$row['sender']['street_et'] = '';
				$row['sender']['street_ap'] = '';
				$row['sender']['street_other'] = $sender_address['other'];
				$row['sender']['phone_num'] = $this->config->get('econt_phone');

				if ($this->customer->isLogged()) {
					$receiver_name_person = $this->customer->getFirstName() . ' ' . $this->customer->getLastName();
					$receiver_email = $this->customer->getEmail();
					$receiver_phone_num = $this->customer->getTelephone();
	
				} elseif (isset($this->session->data['guest'])) {
					$receiver_name_person = $this->session->data['guest']['firstname'] . ' ' . $this->session->data['guest']['lastname'];
					$receiver_email = $this->session->data['guest']['email'];
					$receiver_phone_num = $this->session->data['guest']['telephone'];
				} else {
					$receiver_name_person = $this->session->data['customer']['firstname'] . ' ' . $this->session->data['customer']['lastname'];
					$receiver_email = $this->session->data['customer']['email'];
					$receiver_phone_num = $this->session->data['customer']['telephone'];
				}

				if (!empty($this->session->data['shipping_address']['company'])) {
					$company = $this->session->data['shipping_address']['company'];
				} else {
					$company = $receiver_name_person;
				}

				$row['receiver']['name'] = $company;
				$row['receiver']['name_person'] = $receiver_name_person;
				$row['receiver']['receiver_email'] = $receiver_email;
				$row['receiver']['street_bl'] = '';
				$row['receiver']['street_vh'] = '';
				$row['receiver']['street_et'] = '';
				$row['receiver']['street_ap'] = '';
				$row['receiver']['phone_num'] = $receiver_phone_num;

				if ($this->config->get('econt_sms')) {
					$sms_no = $this->config->get('econt_sms_no');
				} else {
					$sms_no = '';
				}

				$row['receiver']['sms_no'] = $sms_no;
				$row['shipment']['envelope_num'] = '';

				$weight = 0;
				$description = array();

				foreach ($this->cart->getProducts() as $product) {
					$description[] = $product['name'];

					if ($product['shipping']) {
						$product_weight = (float)$product['weight'];
						if (!empty($product_weight)) {
							$weight += $this->weight->convert($product['weight'], $product['weight_class_id'], $this->config->get('econt_weight_class_id'));
						} else {
							$data['error']['weight'][$product['product_id']] = $product;
						}
					}
				}

				if (!empty($weight)) {
					$data['error']['no_weight'] = false;
				} else {
					$data['error']['no_weight'] = true;

					$weight = 1;
				}

				$row['shipment']['description'] = implode(', ', $description);
				$row['shipment']['pack_count'] = $this->cart->countProducts();
				$row['shipment']['weight'] = $weight;

				if ($weight > 100) {
					$row['shipment']['shipment_type'] = 'CARGO';
					$row['shipment']['cargo_code'] = 81;
				} else {
					$row['shipment']['shipment_type'] = 'PACK';
				}

				$row['shipment']['invoice_before_pay_CD'] = (int)$this->config->get('econt_invoice_before_cd');
				$row['shipment']['pay_after_accept'] = (int)$this->config->get('econt_pay_after_accept');
				$row['shipment']['pay_after_test'] = (int)$this->config->get('econt_pay_after_test');
				$row['shipment']['instruction_returns'] = $this->config->get('econt_instruction_returns');

				if (isset($this->session->data['econt']['delivery_day_id']) && $this->config->get('econt_delivery_day')) {
					$delivery_day = $this->session->data['econt']['delivery_day_id'];
				} else {
					$delivery_day = '';
				}

				$row['shipment']['delivery_day'] = $delivery_day;

				$row['payment']['side'] = $this->config->get('econt_side');
				$row['payment']['method'] = $this->config->get('econt_payment_method');

				$receiver_share_sum_door = '';
				$receiver_share_sum_office = '';

				if ((float)$this->config->get('econt_total_for_free') && ($total >= $this->config->get('econt_total_for_free')) || (int)$this->config->get('econt_count_for_free') && ($this->cart->countProducts() >= $this->config->get('econt_count_for_free')) || (float)$this->config->get('econt_weight_for_free') && ($weight >= $this->config->get('econt_weight_for_free'))) {
					$row['payment']['side'] = 'SENDER';
				} elseif ($this->config->get('econt_shipping_payments')) {
					if (!is_array($this->config->get('econt_shipping_payments'))) {
						$shipping_payments = unserialize($this->config->get('econt_shipping_payments'));
					} else {
						$shipping_payments = $this->config->get('econt_shipping_payments');
					}
					$order_amount = 0;

					foreach ($shipping_payments as $shipping_payment) {
						if ($total >= $shipping_payment['order_amount'] && $shipping_payment['order_amount'] >= $order_amount) {
							$order_amount = $shipping_payment['order_amount'];
							$receiver_share_sum_door = $shipping_payment['receiver_amount'];
							$receiver_share_sum_office = $shipping_payment['receiver_amount_office'];
						}
					}
				}

				if ($row['payment']['method'] == 'CREDIT') {
					$key_word = $this->config->get('econt_key_word');
				} else {
					$key_word = '';
				}

				$row['payment']['key_word'] = $key_word;

				$row['services']['e'] = '';

				if ($this->config->get('econt_dc')) {
					$dc = 'ON';
				} else {
					$dc = '';
				}

				$row['services']['dc'] = $dc;

				if ($this->config->get('econt_dc_cp')) {
					$dc_cp = 'ON';
				} else {
					$dc_cp = '';
				}

				$row['services']['dc_cp'] = $dc_cp;
				$row['services']['dp'] = '';

				if ($this->config->get('econt_oc') && ($total >= $this->config->get('econt_total_for_oc'))) {
					$oc = $total;
					$oc_currency = $this->config->get('econt_currency');
				} else {
					$oc = '';
					$oc_currency = '';
				}

				$row['services']['oc'] = $oc;
				$row['services']['oc_currency'] = $oc_currency;

				if (!empty($this->request->post) && isset($this->request->post['payment'])) {
					if ($this->request->post['payment'] == 'econt_cod') {
						$cd_type = 'GET';
						$cd_value = $total;
						$cd_currency = $this->config->get('econt_currency');

						if ($this->config->get('econt_cd_agreement')) {
							$cd_agreement_num = $this->config->get('econt_cd_agreement_num');
						} else {
							$cd_agreement_num = '';
						}
					} else {
						$cd_type = '';
						$cd_value = '';
						$cd_currency = '';
						$cd_agreement_num = '';
					}
				} else {
					if ((!isset($this->session->data['econt']['cd_payment']) || $this->session->data['econt']['cd_payment']) && $this->config->get('econt_cd') && $this->config->get('econt_cod_status')) {
						$cd_type = 'GET';
						$cd_value = $total;
						$cd_currency = $this->config->get('econt_currency');

						if ($this->config->get('econt_cd_agreement')) {
							$cd_agreement_num = $this->config->get('econt_cd_agreement_num');
						} else {
							$cd_agreement_num = '';
						}
					} else {
						$cd_type = '';
						$cd_value = '';
						$cd_currency = '';
						$cd_agreement_num = '';
						$this->session->data['econt']['cd_payment'] = false;
					}
				}

				$row['services']['cd'] = array('type' => $cd_type, 'value' => $cd_value);
				$row['services']['cd_currency'] = $cd_currency;
				$row['services']['cd_agreement_num'] = $cd_agreement_num;
				$row['services']['pack1'] = '';
				$row['services']['pack2'] = '';
				$row['services']['pack3'] = '';
				$row['services']['pack4'] = '';
				$row['services']['pack5'] = '';
				$row['services']['pack6'] = '';
				$row['services']['pack7'] = '';
				$row['services']['pack8'] = '';
				$row['services']['ref'] = '';

				$row2 = $row;

				if ($to_office) {
					if ($receiver_share_sum_office) {
						$row2['payment']['side'] = 'SENDER';
					}

					$row2['payment']['receiver_share_sum'] = $receiver_share_sum_office;
					$row2['payment']['share_percent'] = '';

					if ($row2['payment']['side'] == 'RECEIVER') {
						$row2['payment']['method'] = 'CASH';
					}

					$row2['receiver']['quarter'] = '';
					$row2['receiver']['street'] = '';
					$row2['receiver']['street_num'] = '';
					$row2['receiver']['street_other'] = '';

					if (!empty($receiver_address['office_id'])) {
						$receiver_office = $this->getOffice($receiver_address['office_id']);
						$row2['receiver']['office_code'] = $receiver_office['office_code'];

						$receiver_city = $this->getCityByCityId($receiver_office['city_id']);
						$row2['receiver']['city'] = $receiver_city['name'];
						$row2['receiver']['post_code'] = $receiver_city['post_code'];
					} elseif (!empty($receiver_address['office_city_id'])) {
						$receiver_city = $this->getCityByCityId($receiver_address['office_city_id']);
						$row2['receiver']['city'] = $receiver_city['name'];
						$row2['receiver']['post_code'] = $receiver_city['post_code'];
					} else {
						$offices = $this->getOfficesByCityId($receiver_address['city_id'], $this->delivery_type);

						if ($offices) {
							$row2['receiver']['city'] = $receiver_address['city'];
							$row2['receiver']['post_code'] = $receiver_address['post_code'];
						} else {
							$to_office = false;
							$method_data['quote']['econt_office']['text'] = '';
						}
					}

					$tariff_sub_code = $this->config->get('econt_shipping_from') . '_OFFICE';

					$tariff_code = 0;

					if ($tariff_sub_code == 'OFFICE_OFFICE') {
						$tariff_code = 2;
					} elseif ($tariff_sub_code == 'DOOR_OFFICE') {
						$tariff_code = 3;
					}

					$row2['shipment']['tariff_code'] = $tariff_code;
					$row2['shipment']['tariff_sub_code'] = $tariff_sub_code;

					$row2['services']['e1'] = '';
					$row2['services']['e2'] = '';
					$row2['services']['e3'] = '';

					$row2['services']['p'] = array('type' => '', 'value' => '');
				}

				if ($to_door) {
					if ($receiver_share_sum_door) {
						$row['payment']['side'] = 'SENDER';
					}

					$row['payment']['receiver_share_sum'] = $receiver_share_sum_door;
					$row['payment']['share_percent'] = '';

					if ($row['payment']['side'] == 'RECEIVER') {
						$row['payment']['method'] = 'CASH';
					}

					$row['receiver']['office_code'] = '';

					$row['receiver']['city'] = $receiver_address['city'];
					$row['receiver']['post_code'] = $receiver_address['post_code'];
					$row['receiver']['quarter'] = (isset($receiver_address['quarter']) ? $receiver_address['quarter'] : '');
					$row['receiver']['street'] = (isset($receiver_address['street']) ? $receiver_address['street'] : '');
					$row['receiver']['street_num'] = (isset($receiver_address['street_num']) ? $receiver_address['street_num'] : '');
					$row['receiver']['street_other'] = (isset($receiver_address['other']) ? $receiver_address['other'] : '');

					$tariff_sub_code = $this->config->get('econt_shipping_from') . '_DOOR';

					$tariff_code = 0;

					if (isset($this->session->data['econt']['express_city_courier_cb'])) {
						$tariff_code = 1;
					} elseif ($tariff_sub_code == 'OFFICE_DOOR') {
						$tariff_code = 3;
					} elseif ($tariff_sub_code == 'DOOR_DOOR') {
						$tariff_code = 4;
					}

					$row['shipment']['tariff_code'] = $tariff_code;
					$row['shipment']['tariff_sub_code'] = $tariff_sub_code;

					$city_courier_e1 = '';
					$city_courier_e2 = '';
					$city_courier_e3 = '';

					if (isset($this->session->data['econt']['express_city_courier_cb'])) {
						if ($this->session->data['econt']['express_city_courier_e'] == 'e1') {
							$city_courier_e1 = 'ON';
						} elseif ($this->session->data['econt']['express_city_courier_e'] == 'e2') {
							$city_courier_e2 = 'ON';
						} elseif ($this->session->data['econt']['express_city_courier_e'] == 'e3') {
							$city_courier_e3 = 'ON';
						}
					}

					$row['services']['e1'] = $city_courier_e1;
					$row['services']['e2'] = $city_courier_e2;
					$row['services']['e3'] = $city_courier_e3;

					if (isset($this->session->data['econt']['priority_time_cb'])) {
						$priority_time_type = $this->session->data['econt']['priority_time_type_id'];
						$priority_time_value = $this->session->data['econt']['priority_time_hour_id'];
					} else {
						$priority_time_type = '';
						$priority_time_value = '';
					}

					$row['services']['p'] = array('type' => $priority_time_type, 'value' => $priority_time_value);
				}

				if ($to_door) {
					$data['loadings']['to_door']['row'] = $row;
				}
				if ($to_office) {
					$data['loadings']['to_office']['row'] = $row2;
				}

				$results = $this->parcelImport($data);
				$key = 0;

				if ($results && !empty($results->result->e)) {
					foreach ($results->result->e as $result) {
						if ($key == 0 && $to_door) {
							$method_code = 'econt_door';
							$receiver_share_sum = $receiver_share_sum_door;
						} else {
							$method_code = 'econt_office';
							$receiver_share_sum = $receiver_share_sum_office;
						}

						if (!empty($result->error)) {
							$method_data['econt_error'] = (string)$result->error;
							$method_data['quote'][$method_code]['text'] = '';
						} elseif (isset($result->loading_price->total)) {
							$data['error']['fixed'] = false;

							if ((float)$this->config->get('econt_total_for_free') && ($total >= $this->config->get('econt_total_for_free')) || (int)$this->config->get('econt_count_for_free') && ($this->cart->countProducts() >= $this->config->get('econt_count_for_free')) || (float)$this->config->get('econt_weight_for_free') && ($weight >= $this->config->get('econt_weight_for_free')) || !$receiver_share_sum && $this->config->get('econt_side') == 'SENDER') {
								$data['error']['fixed'] = true;

								$method_data['quote'][$method_code]['cost'] = 0.00;
								$method_data['quote'][$method_code]['text'] = $this->currency->format(0.00);
							} elseif (isset($data['error']['weight'])) {
								$method_data['quote'][$method_code]['cost'] = 0.00;
								$method_data['quote'][$method_code]['text'] = $this->language->get('text_processing');
							} elseif ($receiver_share_sum) {
								$data['error']['fixed'] = true;

								$method_data['quote'][$method_code]['cost'] = $this->currency->convert((float)$receiver_share_sum, $this->config->get('econt_currency'), $this->config->get('config_currency'));
								$method_data['quote'][$method_code]['text'] = $this->currency->format($method_data['quote'][$method_code]['cost']);
							} else {
								$method_data['quote'][$method_code]['cost'] = $this->currency->convert((float)$result->loading_price->total, $this->config->get('econt_currency'), $this->config->get('config_currency'));
								$method_data['quote'][$method_code]['text'] = $this->currency->format($method_data['quote'][$method_code]['cost']);
							}
						}

						$key++;
					}
				} else {
					$method_data['econt_error'] = $this->language->get('error_connect');
					if (isset($method_data['quote']['econt_office'])) {
						$method_data['quote']['econt_office']['text'] = '';
					}
					if (isset($method_data['quote']['econt_door'])) {
						$method_data['quote']['econt_door']['text'] = '';
					}
				}
			} else {
				$method_data['econt_error'] = $this->language->get('error_calculate');
				if (isset($method_data['quote']['econt_office'])) {
					$method_data['quote']['econt_office']['text'] = '';
				}
				if (isset($method_data['quote']['econt_door'])) {
					$method_data['quote']['econt_door']['text'] = '';
				}
			}

			if (!isset($method_data['econt_error'])) {
				$this->session->data['econt']['order_id'] = $this->addOrder($data);
			}
		}

		return $method_data;
	}

	protected function prepareXML($data) {
		$xml = '';

		foreach ($data as $key => $value) {
			if ($key && $key == 'error') {
				continue;
			}

			if ($key && ($key == 'p' || $key == 'cd')) {
				$xml .= '<' . $key . ' type="' . $value['type'] . '">' . $value['value'] . '</' . $key . '>' . "\r\n";
			} else {
				if (!is_numeric($key) && $key != 'to_door' && $key != 'to_office') {
					$xml .= '<' . $key . '>';
				}

				if (is_array($value)) {
					$xml .= "\r\n" . $this->prepareXML($value);
				} else {
					$xml .= $value;
				}

				if (!is_numeric($key) && $key != 'to_door' && $key != 'to_office') {
					$xml .= '</' . $key . '>' . "\r\n";
				}
			}
		}

		return $xml;
	}

	private function parcelImport($data) {
		if (!$this->config->get('econt_test')) {
			$url = 'http://www.econt.com/e-econt/xml_parcel_import2.php';
		} else {
			$url = 'http://demo.econt.com/e-econt/xml_parcel_import2.php';
		}

		foreach ($data['loadings'] as $key => $row) {
			$data['loadings'][$key]['row']['mediator'] = 'extensa';
		}

		$request = '<?xml version="1.0" ?>';
		$request .= '<parcels>';
		$request .= $this->prepareXML($data);
		$request .= '</parcels>';

		$ch = curl_init();

		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_HEADER, 0);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_POST, 1);
		curl_setopt($ch, CURLOPT_POSTFIELDS, array('xml' => $request));

		$response = curl_exec($ch);

		curl_close($ch);

		libxml_use_internal_errors(TRUE);
		return simplexml_load_string($response);
	}

	public function addCustomer($data) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "econt_customer WHERE customer_id = '" . (int)$this->customer->getId() . "'");

		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_customer SET customer_id = '" . (int)$this->customer->getId() . "', shipping_to = '" . $this->db->escape($data['shipping_to']) . "', postcode = '" . $this->db->escape($data['postcode']) . "', city = '" . $this->db->escape($data['city']) . "', quarter = '" . $this->db->escape($data['quarter']) . "', street = '" . $this->db->escape($data['street']) . "', street_num = '" . $this->db->escape($data['street_num']) . "', other = '" . $this->db->escape($data['other']) . "', city_id = '" . (int)$data['city_id'] . "', office_id = '" . (int)$data['office_id'] . "'");
	}

	public function getCustomer() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "econt_customer WHERE customer_id = '" . (int)$this->customer->getId() . "'");

		return $query->row;
	}

	public function getOrder($econt_order_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "econt_order WHERE econt_order_id = '" . (int)$econt_order_id . "'");

		return $query->row;
	}

	public function addOrder($data, $order_id = 0) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_order SET order_id = '" . (int)$order_id . "', data = '" . $this->db->escape(serialize($data)) . "'");

		$econt_order_id = $this->db->getLastId();

		return $econt_order_id;
	}

	public function editOrder($econt_order_id, $order_id, $data = array()) {
		$sql = "UPDATE " . DB_PREFIX . "econt_order SET order_id = '" . (int)$order_id . "'";

		if ($data) {
			$sql .= ", data = '" . $this->db->escape(serialize($data)) . "'";
		}

		$sql .= " WHERE econt_order_id = '" . (int)$econt_order_id . "'";

		$this->db->query($sql);
	}

	public function getCitiesByName($name, $limit = 10) {
		if (strtolower($this->config->get('config_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$sql = "SELECT *, c.name" . $suffix . " AS name FROM " . DB_PREFIX . "econt_city c";

		if ($name) {
			$sql .= " WHERE (LCASE(c.name) LIKE '%" . $this->db->escape(utf8_strtolower($name)) . "%' OR LCASE(c.name_en) LIKE '%" . $this->db->escape(utf8_strtolower($name)) . "%')";
		}

		$sql .= " ORDER BY c.name" . $suffix;

		$sql .= " LIMIT " . (int)$limit;

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getQuartersByName($name, $city_id, $limit = 10) {
		if (strtolower($this->config->get('config_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$sql = "SELECT *, q.name" . $suffix . " AS name FROM " . DB_PREFIX . "econt_quarter q WHERE 1";

		if ($name) {
			$sql .= " AND (LCASE(q.name) LIKE '%" . $this->db->escape(utf8_strtolower($name)) . "%' OR LCASE(q.name_en) LIKE '%" . $this->db->escape(utf8_strtolower($name)) . "%')";
		}

		if ($city_id) {
			$sql .= " AND q.city_id = '" . (int)$city_id . "'";
		}

		$sql .= " ORDER BY q.name" . $suffix;

		$sql .= " LIMIT " . (int)$limit;

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getStreetsByName($name, $city_id, $limit = 10) {
		if (strtolower($this->config->get('config_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$sql = "SELECT *, s.name" . $suffix . " AS name FROM " . DB_PREFIX . "econt_street s WHERE 1";

		if ($name) {
			$sql .= " AND (LCASE(s.name) LIKE '%" . $this->db->escape(utf8_strtolower($name)) . "%' OR LCASE(s.name_en) LIKE '%" . $this->db->escape(utf8_strtolower($name)) . "%')";
		}

		if ($city_id) {
			$sql .= " AND s.city_id = '" . (int)$city_id . "'";
		}

		$sql .= " ORDER BY s.name" . $suffix;

		$sql .= " LIMIT " . (int)$limit;

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getCitiesWithOffices($delivery_type = '') {
		if (strtolower($this->config->get('config_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$sql = "SELECT c.city_id, c.name" . $suffix . " AS name FROM " . DB_PREFIX . "econt_city c INNER JOIN " . DB_PREFIX . "econt_office o ON (c.city_id = o.city_id) ";

		if ($delivery_type) {
			$sql .= " INNER JOIN " . DB_PREFIX . "econt_city_office eco ON o.office_code = eco.office_code AND o.city_id = eco.city_id AND eco.delivery_type = '" . $delivery_type . "' ";
		}

		$sql .= " GROUP BY c.city_id ORDER BY c.name" . $suffix;

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getOfficesByCityId($city_id, $delivery_type = '') {
		if (strtolower($this->config->get('config_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$sql = "SELECT *, o.name" . $suffix . " AS name, o.address" . $suffix . " AS address FROM " . DB_PREFIX . "econt_office o ";

		if ($delivery_type) {
			$sql .= " INNER JOIN " . DB_PREFIX . "econt_city_office eco ON o.office_code = eco.office_code AND o.city_id = eco.city_id AND eco.delivery_type = '" . $delivery_type . "' ";
		}

		$sql .= " WHERE o.city_id = '" . (int)$city_id . "' GROUP BY o.office_id ORDER BY o.name" . $suffix;

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function getOffice($office_id) {
		if (strtolower($this->config->get('config_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$query = $this->db->query("SELECT *, o.name" . $suffix . " AS name, o.address" . $suffix . " AS address FROM " . DB_PREFIX . "econt_office o WHERE o.office_id = '" . (int)$office_id . "'");

		return $query->row;
	}

	public function getOfficeByOfficeCode($office_code) {
		if (strtolower($this->config->get('config_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$sql = "SELECT o.*, o.name" . $suffix . " AS name, o.address" . $suffix . " AS address, c.name" . $suffix . " as city_name FROM " . DB_PREFIX . "econt_office o INNER JOIN " . DB_PREFIX . "econt_city c ON o.city_id = c.city_id WHERE o.office_code = '" . (int)$office_code . "' ";

		$query = $this->db->query($sql);
		if ($query->num_rows == 1) {
			return $query->row;
		} else {
			return false;
		}
	}

	public function getCityByCityId($city_id) {
		if (strtolower($this->config->get('config_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$sql = "SELECT c.city_id, c.post_code, c.name" . $suffix . " AS name FROM " . DB_PREFIX . "econt_city c WHERE city_id = '" . (int)$city_id . "'";

		$query = $this->db->query($sql);
		if ($query->num_rows == 1) {
			return $query->row;
		} else {
			return false;
		}
	}

	public function validateAddress($data) {
		$sql = "SELECT COUNT(c.city_id) AS total FROM " . DB_PREFIX . "econt_city c LEFT JOIN " . DB_PREFIX . "econt_quarter q ON (c.city_id = q.city_id) LEFT JOIN " . DB_PREFIX . "econt_street s ON (c.city_id = s.city_id) WHERE TRIM(c.post_code) = '". $this->db->escape(trim($data['postcode'])) . "' AND (LCASE(TRIM(c.name)) = '" . $this->db->escape(utf8_strtolower(trim($data['city']))) . "' OR LCASE(TRIM(c.name_en)) = '" . $this->db->escape(utf8_strtolower(trim($data['city']))) . "')";

		if ($data['quarter']) {
			$sql .= " AND (LCASE(TRIM(q.name)) = '" . $this->db->escape(utf8_strtolower(trim($data['quarter']))) . "' OR LCASE(TRIM(q.name_en)) = '" . $this->db->escape(utf8_strtolower(trim($data['quarter']))) . "')";
		}

		if ($data['street']) {
			$sql .= " AND (LCASE(TRIM(s.name)) = '" . $this->db->escape(utf8_strtolower(trim($data['street']))) . "' OR LCASE(TRIM(s.name_en)) = '" . $this->db->escape(utf8_strtolower(trim($data['street']))) . "')";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}
?>
<?php
class ControllerSaleEcont extends Controller {
	private $error = array();
	private $delivery_type = 'to_office';

	public function index() {
		$this->load->language('sale/econt');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('sale/econt');

		$url = '';
 
		$filters = array(
			'filter_order_id',
			'filter_name',
			'filter_order_status_id',
			'filter_date_added',
			'filter_total',
			'page',
			'sort',
			'order'
		);

		foreach($filters as $filter) {
			if (isset($this->request->get[$filter])) {
				$url .= '&' . $filter . '=' . $this->request->get[$filter];
			}
		}

		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}

		$loading_info = $this->model_sale_econt->getLoading($order_id);

		if ($loading_info) {
			if ($loading_info['cd_send_sum'] && (strtotime($loading_info['cd_send_time']) > 0)) {
				$loading_info['trackings'] = $this->model_sale_econt->getLoadingTrackings($loading_info['econt_loading_id']);

				$loading_info['next_parcels'] = $this->model_sale_econt->getLoadingNextParcels($loading_info['loading_num']);

				foreach ($loading_info['next_parcels'] as $key => $next_parcel) {
					$loading_info['next_parcels'][$key]['trackings'] = $this->model_sale_econt->getLoadingTrackings($next_parcel['econt_loading_id']);
				}
			} else {
				$data = array(
					'type' => 'shipments',
					'xml'  => "<shipments full_tracking='ON'><num>" . $loading_info['loading_num'] . '</num></shipments>'
				);

				$results = $this->serviceTool($data);

				$loading_info['trackings'] = array();
				$loading_info['next_parcels'] = array();

				if ($results) {
					if (isset($results->shipments->e->error)) {
						$this->error['warning'] = (string)$results->shipments->e->error;
					} elseif (isset($results->error)) {
						$this->error['warning'] = (string)$results->error->message;
					} elseif (isset($results->shipments->e)) {
						$loading_info['is_imported'] = $results->shipments->e->is_imported;
						$loading_info['storage'] = $results->shipments->e->storage;
						$loading_info['receiver_person'] = $results->shipments->e->receiver_person;
						$loading_info['receiver_person_phone'] = $results->shipments->e->receiver_person_phone;
						$loading_info['receiver_courier'] = $results->shipments->e->receiver_courier;
						$loading_info['receiver_courier_phone'] = $results->shipments->e->receiver_courier_phone;
						$loading_info['receiver_time'] = $results->shipments->e->receiver_time;
						$loading_info['cd_get_sum'] = $results->shipments->e->CD_get_sum;
						$loading_info['cd_get_time'] = $results->shipments->e->CD_get_time;
						$loading_info['cd_send_sum'] = $results->shipments->e->CD_send_sum;
						$loading_info['cd_send_time'] = $results->shipments->e->CD_send_time;
						$loading_info['total_sum'] = $results->shipments->e->total_sum;
						$loading_info['currency'] = $results->shipments->e->currency;
						$loading_info['sender_ammount_due'] = $results->shipments->e->sender_ammount_due;
						$loading_info['receiver_ammount_due'] = $results->shipments->e->receiver_ammount_due;
						$loading_info['other_ammount_due'] = $results->shipments->e->other_ammount_due;
						$loading_info['delivery_attempt_count'] = $results->shipments->e->delivery_attempt_count;
						$loading_info['blank_yes'] = $results->shipments->e->blank_yes;
						$loading_info['blank_no'] = $results->shipments->e->blank_no;

						if (isset($results->shipments->e->tracking)) {
							foreach ($results->shipments->e->tracking->row as $tracking) {
								$loading_info['trackings'][] = array(
									'time'       => $tracking->time,
									'is_receipt' => $tracking->is_receipt,
									'event'      => $tracking->event,
									'name'       => $tracking->name,
									'name_en'    => $tracking->name_en
								);
							}
						}

						if (isset($results->shipments->e->next_parcels)) {
							foreach ($results->shipments->e->next_parcels->e as $next_parcel) {
								$data_next_parcel = array(
									'type' => 'shipments',
									'xml'  => "<shipments full_tracking='ON'><num>" . $next_parcel->num . '</num></shipments>'
								);

								$results_next_parcel = $this->serviceTool($data_next_parcel);

								if ($results_next_parcel) {
									if (isset($results_next_parcel->shipments->e->error)) {
										$this->error['warning'] = (string)$results_next_parcel->shipments->e->error;
									} elseif (isset($results_next_parcel->error)) {
										$this->error['warning'] = (string)$results_next_parcel->error->message;
									} elseif (isset($results_next_parcel->shipments->e)) {
										$trackings_next_parcel = array();

										if (isset($results_next_parcel->shipments->e->tracking)) {
											foreach ($results_next_parcel->shipments->e->tracking->row as $tracking) {
												$trackings_next_parcel[] = array(
													'time'       => $tracking->time,
													'is_receipt' => $tracking->is_receipt,
													'event'      => $tracking->event,
													'name'       => $tracking->name,
													'name_en'    => $tracking->name_en
												);
											}
										}

										$loading_info['next_parcels'][] = array(
											'loading_num'            => $results_next_parcel->shipments->e->loading_num,
											'is_imported'            => $results_next_parcel->shipments->e->is_imported,
											'storage'                => $results_next_parcel->shipments->e->storage,
											'receiver_person'        => $results_next_parcel->shipments->e->receiver_person,
											'receiver_person_phone'  => $results_next_parcel->shipments->e->receiver_person_phone,
											'receiver_courier'       => $results_next_parcel->shipments->e->receiver_courier,
											'receiver_courier_phone' => $results_next_parcel->shipments->e->receiver_courier_phone,
											'receiver_time'          => $results_next_parcel->shipments->e->receiver_time,
											'cd_get_sum'             => $results_next_parcel->shipments->e->CD_get_sum,
											'cd_get_time'            => $results_next_parcel->shipments->e->CD_get_time,
											'cd_send_sum'            => $results_next_parcel->shipments->e->CD_send_sum,
											'cd_send_time'           => $results_next_parcel->shipments->e->CD_send_time,
											'total_sum'              => $results_next_parcel->shipments->e->total_sum,
											'currency'               => $results_next_parcel->shipments->e->currency,
											'sender_ammount_due'     => $results_next_parcel->shipments->e->sender_ammount_due,
											'receiver_ammount_due'   => $results_next_parcel->shipments->e->receiver_ammount_due,
											'other_ammount_due'      => $results_next_parcel->shipments->e->other_ammount_due,
											'delivery_attempt_count' => $results_next_parcel->shipments->e->delivery_attempt_count,
											'blank_yes'              => $results_next_parcel->shipments->e->blank_yes,
											'blank_no'               => $results_next_parcel->shipments->e->blank_no,
											'pdf_url'                => $next_parcel->pdf_url,
											'reason'                 => $next_parcel->reason,
											'trackings'              => $trackings_next_parcel
										);
									}
								} else {
									$this->error['warning'] = $this->language->get('error_connect');
								}
							}
						}

						if (!$this->error) {
							$this->model_sale_econt->updateLoading($loading_info);
						}
					}
				} else {
					$this->error['warning'] = $this->language->get('error_connect');
				}
			}

			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_yes'] = $this->language->get('text_yes');
			$data['text_no'] = $this->language->get('text_no');
			$data['text_view'] = $this->language->get('text_view');

			$data['entry_loading_num'] = $this->language->get('entry_loading_num');
			$data['entry_is_imported'] = $this->language->get('entry_is_imported');
			$data['entry_storage'] = $this->language->get('entry_storage');
			$data['entry_receiver_person'] = $this->language->get('entry_receiver_person');
			$data['entry_receiver_person_phone'] = $this->language->get('entry_receiver_person_phone');
			$data['entry_receiver_courier'] = $this->language->get('entry_receiver_courier');
			$data['entry_receiver_courier_phone'] = $this->language->get('entry_receiver_courier_phone');
			$data['entry_receiver_time'] = $this->language->get('entry_receiver_time');
			$data['entry_cd_get_sum'] = $this->language->get('entry_cd_get_sum');
			$data['entry_cd_get_time'] = $this->language->get('entry_cd_get_time');
			$data['entry_cd_send_sum'] = $this->language->get('entry_cd_send_sum');
			$data['entry_cd_send_time'] = $this->language->get('entry_cd_send_time');
			$data['entry_total_sum'] = $this->language->get('entry_total_sum');
			$data['entry_sender_ammount_due'] = $this->language->get('entry_sender_ammount_due');
			$data['entry_receiver_ammount_due'] = $this->language->get('entry_receiver_ammount_due');
			$data['entry_other_ammount_due'] = $this->language->get('entry_other_ammount_due');
			$data['entry_delivery_attempt_count'] = $this->language->get('entry_delivery_attempt_count');
			$data['entry_blank_yes'] = $this->language->get('entry_blank_yes');
			$data['entry_blank_no'] = $this->language->get('entry_blank_no');
			$data['entry_pdf_url'] = $this->language->get('entry_pdf_url');
			$data['entry_tracking'] = $this->language->get('entry_tracking');
			$data['entry_time'] = $this->language->get('entry_time');
			$data['entry_is_receipt'] = $this->language->get('entry_is_receipt');
			$data['entry_event'] = $this->language->get('entry_event');
			$data['entry_name'] = $this->language->get('entry_name');
			$data['entry_next_parcels'] = $this->language->get('entry_next_parcels');

			$data['button_courier'] = $this->language->get('button_courier');
			$data['button_cancel'] = $this->language->get('button_cancel');

			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
			}

			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			);

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_orders'),
				'href'      => $this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			);

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('sale/econt', 'token=' . $this->session->data['token'] . '&order_id=' . $this->request->get['order_id'] . $url, 'SSL'),
				'separator' => ' :: '
			);

			$data['courier'] = 'http://ee.econt.com/?target=EeRequestOfCourier&eshop=1';
			$data['cancel'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'] . $url, 'SSL');

			$loading_info['receiver_time'] = (strtotime($loading_info['receiver_time']) > 0 ? date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($loading_info['receiver_time'])) : '');
			$loading_info['cd_get_time'] = (strtotime($loading_info['cd_get_time']) > 0 ? date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($loading_info['cd_get_time'])) : '');
			$loading_info['cd_send_time'] = (strtotime($loading_info['cd_send_time']) > 0 ? date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($loading_info['cd_send_time'])) : '');

			foreach ($loading_info['trackings'] as $key => $tracking) {
				$loading_info['trackings'][$key] = array(
					'time'       => date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($tracking['time'])),
					'is_receipt' => ((int)$tracking['is_receipt'] ? $this->language->get('text_yes') : $this->language->get('text_no')),
					'event'      => $this->language->get('text_' . $tracking['event']),
					'name'       => (strtolower($this->config->get('config_admin_language')) == 'bg' ? $tracking['name'] : $tracking['name_en'])
				);
			}

			foreach ($loading_info['next_parcels'] as $key => $next_parcel) {
				$loading_info['next_parcels'][$key]['receiver_time'] = (strtotime($next_parcel['receiver_time']) > 0 ? date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($next_parcel['receiver_time'])) : '');
				$loading_info['next_parcels'][$key]['cd_get_time'] = (strtotime($next_parcel['cd_get_time']) > 0 ? date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($next_parcel['cd_get_time'])) : '');
				$loading_info['next_parcels'][$key]['cd_send_time'] = (strtotime($next_parcel['cd_send_time']) > 0 ? date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($next_parcel['cd_send_time'])) : '');

				foreach ($next_parcel['trackings'] as $key2 => $tracking) {
					$loading_info['next_parcels'][$key]['trackings'][$key2] = array(
						'time'       => date($this->language->get('date_format_short') . ' ' . $this->language->get('time_format'), strtotime($tracking['time'])),
						'is_receipt' => ((int)$tracking['is_receipt'] ? $this->language->get('text_yes') : $this->language->get('text_no')),
						'event'      => $this->language->get('text_' . $tracking['event']),
						'name'       => (strtolower($this->config->get('config_admin_language')) == 'bg' ? $tracking['name'] : $tracking['name_en'])
					);
				}
			}

			$data['loading'] = $loading_info;
			
			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');
		
			$this->response->setOutput($this->load->view('sale/econt_loading.tpl', $data));
		} else {
			if (isset($this->request->get['order_id'])) {
				$this->response->redirect($this->url->link('sale/econt/generate', 'token=' . $this->session->data['token'] . '&order_id=' . $this->request->get['order_id'] . $url, 'SSL'));
			} else {
				$this->response->redirect($this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL'));
			}
		}
	}

	public function generate() {
		$this->language->load('sale/econt');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->document->addScript('view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
		$this->document->addStyle('view/javascript/jquery/magnific/magnific-popup.css');

		$this->load->model('sale/econt');

		$url = '';

		$filters = array(
			'filter_order_id',
			'filter_name',
			'filter_order_status_id',
			'filter_date_added',
			'filter_total',
			'page',
			'sort',
			'order'
		);

		foreach($filters as $filter) {
			if (isset($this->request->get[$filter])) {
				$url .= '&' . $filter . '=' . $this->request->get[$filter];
			}
		}

		if (isset($this->request->get['order_id'])) {
			$order_id = $this->request->get['order_id'];
		} else {
			$order_id = 0;
		}

		$loading_info = $this->model_sale_econt->getLoading($order_id);

		if ($loading_info) {
			$this->response->redirect($this->url->link('sale/econt', 'token=' . $this->session->data['token'] . '&order_id=' . $this->request->get['order_id'] . $url, 'SSL'));
		}

		$econt_order_info = $this->model_sale_econt->getOrder($order_id);

		if ($econt_order_info) {
			$this->load->model('sale/order');
			$this->load->model('shipping/econt');

			$order_data = unserialize($econt_order_info['data']);
			$order_info = $this->model_sale_order->getOrder($order_id);

			if ($order_info['shipping_code'] == 'econt.econt_office') {
				$order_data_row = $order_data['loadings']['to_office']['row'];
				unset($order_data['loadings']['to_office'], $order_data['loadings']['to_door']);
				$order_data['loadings']['row'] = $order_data_row;
			} elseif ($order_info['shipping_code'] == 'econt.econt_door') {
				$order_data_row = $order_data['loadings']['to_door']['row'];
				unset($order_data['loadings']['to_office'], $order_data['loadings']['to_door']);
				$order_data['loadings']['row'] = $order_data_row;
			}

			if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateGenerate($order_data) && $this->generateLoading($order_data)) {
				$loading_info = $this->model_sale_econt->getLoading($order_id);

				if (!empty($loading_info['pdf_url'])) {
					$this->response->redirect(trim($loading_info['pdf_url']));
				} elseif (!empty($loading_info['blank_yes'])) {
					$this->response->redirect(trim($loading_info['blank_yes']));
				} else {
					$this->session->data['success'] = $this->language->get('text_success');

					$this->response->redirect($this->url->link('sale/order', 'token=' . $this->session->data['token'] . $url, 'SSL'));
				}
			}

			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_yes'] = $this->language->get('text_yes');
			$data['text_no'] = $this->language->get('text_no');
			$data['text_select'] = $this->language->get('text_select');
			$data['text_wait'] = $this->language->get('text_wait');
			$data['text_hour'] = $this->language->get('text_hour');
			$data['text_e1'] = $this->language->get('text_e1');
			$data['text_e2'] = $this->language->get('text_e2');
			$data['text_e3'] = $this->language->get('text_e3');
			$data['text_get_instructions'] = $this->language->get('text_get_instructions');
			$data['text_receiver_shipping_to'] = $this->language->get('text_receiver_shipping_to');
			$data['text_receiver_postcode'] = $this->language->get('text_receiver_postcode');
			$data['text_receiver_city'] = $this->language->get('text_receiver_city');
			$data['text_receiver_quarter'] = $this->language->get('text_receiver_quarter');
			$data['text_receiver_street'] = $this->language->get('text_receiver_street');
			$data['text_receiver_street_num'] = $this->language->get('text_receiver_street_num');
			$data['text_receiver_other'] = $this->language->get('text_receiver_other');
			$data['text_receiver_office'] = $this->language->get('text_receiver_office');
			$data['text_receiver_office_code'] = $this->language->get('text_receiver_office_code');
			$data['text_to_office'] = $this->language->get('text_to_office');
			$data['text_to_door'] = $this->language->get('text_to_door');
			$data['text_loading_note'] = $this->language->get('text_loading_note');

			$data['entry_address'] = $this->language->get('entry_address');
			$data['entry_products_weight'] = $this->language->get('entry_products_weight');
			$data['entry_sms'] = $this->language->get('entry_sms');
			$data['entry_sms_no'] = $this->language->get('entry_sms_no');
			$data['entry_invoice_before_cd'] = $this->language->get('entry_invoice_before_cd');
			$data['entry_dc'] = $this->language->get('entry_dc');
			$data['entry_dc_cp'] = $this->language->get('entry_dc_cp');
			$data['entry_disposition'] = $this->language->get('entry_disposition');
			$data['entry_pay_after_accept'] = $this->language->get('entry_pay_after_accept');
			$data['entry_pay_after_test'] = $this->language->get('entry_pay_after_test');
			$data['entry_instruction_shipping_returns'] = $this->language->get('entry_instruction_shipping_returns');
			$data['entry_instruction_returns'] = $this->language->get('entry_instruction_returns');
			$data['entry_priority_time'] = $this->language->get('entry_priority_time');
			$data['entry_express_city_courier'] = $this->language->get('entry_express_city_courier');
			$data['entry_delivery_day'] = $this->language->get('entry_delivery_day');
			$data['entry_pack_count'] = $this->language->get('entry_pack_count');
			$data['entry_partial_delivery'] = $this->language->get('entry_partial_delivery');
			$data['entry_partial_delivery_instruction'] = $this->language->get('entry_partial_delivery_instruction');
			$data['entry_inventory'] = $this->language->get('entry_inventory');
			$data['entry_inventory_type'] = $this->language->get('entry_inventory_type');
			$data['entry_product_id'] = $this->language->get('entry_product_id');
			$data['entry_product_name'] = $this->language->get('entry_product_name');
			$data['entry_product_weight'] = $this->language->get('entry_product_weight');
			$data['entry_product_price'] = $this->language->get('entry_product_price');
			$data['entry_instructions'] = $this->language->get('entry_instructions');
			$data['help_entry_instructions'] = $this->language->get('help_entry_instructions');
			$data['entry_instructions_type'] = $this->language->get('entry_instructions_type');
			$data['entry_instructions_name'] = $this->language->get('entry_instructions_name');
			$data['entry_instructions_list'] = $this->language->get('entry_instructions_list');
			$data['entry_receiver_address'] = $this->language->get('entry_receiver_address');
			$data['entry_sender_data'] = $this->language->get('entry_sender_data');

			$data['button_generate'] = $this->language->get('button_generate');
			$data['button_cancel'] = $this->language->get('button_cancel');
			$data['button_add'] = $this->language->get('button_add');
			$data['button_remove'] = $this->language->get('button_remove');
			$data['button_get_instructions'] = $this->language->get('button_get_instructions');
			$data['button_instructions_form'] = $this->language->get('button_instructions_form');
			$data['button_office_locator'] = $this->language->get('button_office_locator');

			$data['token'] = (isset($this->session->data['token']) ? $this->session->data['token'] : '');

			if (isset($this->error['warning'])) {
				$data['error_warning'] = $this->error['warning'];
			} else {
				$data['error_warning'] = '';
			}

			if (isset($this->error['address'])) {
				$data['error_address'] = $this->error['address'];
			} else {
				$data['error_address'] = '';
			}

			if (isset($this->error['products_weight'])) {
				$data['error_products_weight'] = $this->error['products_weight'];
			} else {
				$data['error_products_weight'] = '';
			}

			if (isset($this->error['receiver_address'])) {
				$data['error_receiver_address'] = $this->error['receiver_address'];
			} else {
				$data['error_receiver_address'] = '';
			}

			if (isset($this->error['office'])) {
				$data['error_office'] = $this->error['office'];
			} else {
				$data['error_office'] = '';
			}

			if (isset($this->error['receiver_office'])) {
				$data['error_receiver_office'] = $this->error['receiver_office'];
			} else {
				$data['error_receiver_office'] = '';
			}

			if (isset($this->error['sms'])) {
				$data['error_sms'] = $this->error['sms'];
			} else {
				$data['error_sms'] = '';
			}

			if (isset($this->error['priority_time'])) {
				$data['error_priority_time'] = $this->error['priority_time'];
			} else {
				$data['error_priority_time'] = '';
			}

			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			);

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_orders'),
				'href'      => $this->url->link('sale/order', 'token=' . $this->session->data['token'] . $url, 'SSL'),
				'separator' => ' :: '
			);

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('sale/econt/generate', 'token=' . $this->session->data['token'] . '&order_id=' . $this->request->get['order_id'] . $url, 'SSL'),
				'separator' => ' :: '
			);

			$data['action'] = $this->url->link('sale/econt/generate', 'token=' . $this->session->data['token'] . '&order_id=' . $this->request->get['order_id'] . $url, 'SSL');
			$data['cancel'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'] . $url, 'SSL');

			$data['econt_username'] = htmlspecialchars_decode($this->config->get('econt_username'));
			$data['econt_password'] = htmlspecialchars_decode($this->config->get('econt_password'));
			$data['econt_test'] = $this->config->get('econt_test');

			if (isset($this->request->post['address_id'])) {
				$data['address_id'] = $this->request->post['address_id'];
			} else {
				$data['address_id'] = 0;
			}

			$data['office_locator'] = 'https://www.bgmaps.com/templates/econt?office_type=to_office_courier&shop_url=' . HTTPS_SERVER;
			$data['office_locator_domain'] = 'https://www.bgmaps.com';

			$receiver = array();

			if (isset($this->request->post['shipping_to'])) {
				$receiver['shipping_to'] = $this->request->post['shipping_to'];
			} else {
				$shipping_to = explode('_', $order_data['loadings']['row']['shipment']['tariff_sub_code']);
				$receiver['shipping_to'] = $shipping_to[1];
			}

			if (isset($this->request->post['post_code'])) {
				$receiver['post_code'] = $this->request->post['post_code'];
			} else {
				$receiver['post_code'] = $order_data['loadings']['row']['receiver']['post_code'];
			}

			if (isset($this->request->post['city'])) {
				$receiver['city'] = $this->request->post['city'];
			} else {
				$receiver['city'] = $order_data['loadings']['row']['receiver']['city'];
			}

			if (isset($this->request->post['quarter'])) {
				$receiver['quarter'] = $this->request->post['quarter'];
			} else {
				$receiver['quarter'] = $order_data['loadings']['row']['receiver']['quarter'];
			}

			if (isset($this->request->post['street'])) {
				$receiver['street'] = $this->request->post['street'];
			} else {
				$receiver['street'] = $order_data['loadings']['row']['receiver']['street'];
			}

			if (isset($this->request->post['street_num'])) {
				$receiver['street_num'] = $this->request->post['street_num'];
			} else {
				$receiver['street_num'] = $order_data['loadings']['row']['receiver']['street_num'];
			}

			if (isset($this->request->post['other'])) {
				$receiver['other'] = $this->request->post['other'];
			} else {
				$receiver['other'] = $order_data['loadings']['row']['receiver']['street_other'];
			}

			if (isset($this->request->post['city_id'])) {
				$receiver['city_id'] = $this->request->post['city_id'];
			} else {
				$city = $this->model_shipping_econt->getCityByNameAndPostcode($receiver['city'], $receiver['post_code']);

				if ($city) {
					$receiver['city_id'] = $city['city_id'];
				}
			}

			if (isset($this->request->post['office_id'])) {
				$receiver['office_code'] = $this->request->post['office_code'];
				$receiver['office_id'] = $this->request->post['office_id'];
				$receiver['office_city_id'] = $this->request->post['office_city_id'];
			} else {
				if (!empty($order_data['loadings']['row']['receiver']['office_code'])) {
					$econt_office = $this->model_shipping_econt->getOfficeByOfficeCode($order_data['loadings']['row']['receiver']['office_code']);
					if ($econt_office) {
						$receiver['office_code'] = $econt_office['office_code'];
						$receiver['office_id'] = $econt_office['office_id'];
						$receiver['office_city_id'] = $econt_office['city_id'];
					} else {
						$receiver['office_code'] = '';
						$receiver['office_id'] = 0;
						$receiver['office_city_id'] = 0;
					}
				} else {
					$receiver['office_code'] = '';
					$receiver['office_id'] = 0;
					$receiver['office_city_id'] = 0;
				}
			}

			$receiver['to_door'] = true;

			$receiver['to_office'] = true;

			$receiver['cities'] = $this->model_shipping_econt->getCitiesWithOffices($this->delivery_type);

			$receiver['offices'] = $this->model_shipping_econt->getOfficesByCityId($receiver['office_city_id'], $this->delivery_type);

			$data['addresses'] = array();

			if (!is_array($this->config->get('econt_addresses'))) {
				$addresses = unserialize($this->config->get('econt_addresses'));
			} else {
				$addresses = $this->config->get('econt_addresses');
			}

			$data['express_city_courier'] = false;

			foreach ($addresses as $address_id => $address) {
				if ($address['post_code'] == $order_data['loadings']['row']['receiver']['post_code']) {
					$data['express_city_courier_id'] = $address_id;

					if ($address_id == $data['address_id']) {
						$data['express_city_courier'] = true;
					}
				}

				$name = $address['post_code'] . ', ' . $address['city'];

				if ($address['quarter']) {
					$name .= ', ' . $address['quarter'];
				}

				if ($address['street']) {
					$name .= ', ' . $address['street'];

					if ($address['street_num']) {
						$name .= ' ' . $address['street_num'];
					}
				}

				if ($address['other']) {
					$name .= ', ' . $address['other'];
				}

				$data['addresses'][] = array(
					'address_id' => $address_id,
					'name'       => $name
				);
			}

			reset($addresses);
			$address = current($addresses);
			$receiver['sender_post_code'] = $address['post_code'];

			$data['receiver_address'] = $receiver;

			$this->load->model('catalog/product');

			$data['products_weight'] = array();

			$this->load->model('catalog/product');
			$order_products = $this->model_sale_order->getOrderProducts($order_id);
			foreach ($order_products as $product) {

				$product = $this->model_catalog_product->getProduct($product['product_id']);

				if ($product) {
						$product_weight = (float)$product['weight'];

						if (empty($product_weight)) {
							$data['products_weight'][] = array(
								'text' => $product['name'],
								'href' => $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $product['product_id'], 'SSL')
							);
						}
				}
			}

			if (isset($this->request->post['sms'])) {
				$data['sms'] = $this->request->post['sms'];
			} elseif ($order_data['loadings']['row']['receiver']['sms_no']) {
				$data['sms'] = true;
			} else {
				$data['sms'] = false;
			}

			if (isset($this->request->post['sms_no'])) {
				$data['sms_no'] = $this->request->post['sms_no'];
			} else {
				$data['sms_no'] = $order_data['loadings']['row']['receiver']['sms_no'];
			}

			if (isset($this->request->post['invoice_before_cd'])) {
				$data['invoice_before_cd'] = $this->request->post['invoice_before_cd'];
			} else {
				$data['invoice_before_cd'] = $order_data['loadings']['row']['shipment']['invoice_before_pay_CD'];
			}

			if (isset($this->request->post['dc'])) {
				$data['dc'] = $this->request->post['dc'];
			} else {
				$data['dc'] = $order_data['loadings']['row']['services']['dc'];
			}

			if (isset($this->request->post['dc_cp'])) {
				$data['dc_cp'] = $this->request->post['dc_cp'];
			} else {
				$data['dc_cp'] = $order_data['loadings']['row']['services']['dc_cp'];
			}

			if (isset($this->request->post['pay_after_accept'])) {
				$data['pay_after_accept'] = $this->request->post['pay_after_accept'];
			} else {
				$data['pay_after_accept'] = $order_data['loadings']['row']['shipment']['pay_after_accept'];
			}

			if (isset($this->request->post['pay_after_test'])) {
				$data['pay_after_test'] = $this->request->post['pay_after_test'];
			} else {
				$data['pay_after_test'] = $order_data['loadings']['row']['shipment']['pay_after_test'];
			}

			if (isset($this->request->post['instruction_returns'])) {
				$data['instruction_returns'] = $this->request->post['instruction_returns'];
			} else {
				$data['instruction_returns'] = $order_data['loadings']['row']['shipment']['instruction_returns'];
			}

			if (isset($this->request->post['priority_time_cb'])) {
				$data['priority_time_cb'] = $this->request->post['priority_time_cb'];
			} elseif ($order_data['loadings']['row']['services']['p']['type'] && $order_data['loadings']['row']['services']['p']['value']) {
				$data['priority_time_cb'] = true;
			} else {
				$data['priority_time_cb'] = false;
			}

			if (isset($this->request->post['priority_time_type_id'])) {
				$data['priority_time_type_id'] = $this->request->post['priority_time_type_id'];
			} elseif ($order_data['loadings']['row']['services']['p']['type']) {
				$data['priority_time_type_id'] = $order_data['loadings']['row']['services']['p']['type'];
			} else {
				$data['priority_time_type_id'] = 'BEFORE';
			}

			if (isset($this->request->post['priority_time_hour_id'])) {
				$data['priority_time_hour_id'] = $this->request->post['priority_time_hour_id'];
			} elseif ($order_data['loadings']['row']['services']['p']['value']) {
				$data['priority_time_hour_id'] = $order_data['loadings']['row']['services']['p']['value'];
			} else {
				$data['priority_time_hour_id'] = '';
			}

			if (isset($this->request->post['express_city_courier_cb'])) {
				$data['express_city_courier_cb'] = $this->request->post['express_city_courier_cb'];
			} elseif ($order_data['loadings']['row']['services']['e1'] || $order_data['loadings']['row']['services']['e2'] || $order_data['loadings']['row']['services']['e3']) {
				$data['express_city_courier_cb'] = true;
			} else {
				$data['express_city_courier_cb'] = false;
			}

			if (isset($this->request->post['express_city_courier_e'])) {
				$data['express_city_courier_e'] = $this->request->post['express_city_courier_e'];
			} elseif ($order_data['loadings']['row']['services']['e1']) {
				$data['express_city_courier_e'] = 'e1';
			} elseif ($order_data['loadings']['row']['services']['e2']) {
				$data['express_city_courier_e'] = 'e2';
			} elseif ($order_data['loadings']['row']['services']['e3']) {
				$data['express_city_courier_e'] = 'e3';
			} else {
				$data['express_city_courier_e'] = 'e1';
			}

			if (isset($this->request->post['delivery_day_cb'])) {
				$data['delivery_day_cb'] = $this->request->post['delivery_day_cb'];
			} elseif ($order_data['loadings']['row']['shipment']['delivery_day']) {
				$data['delivery_day_cb'] = true;
			} else {
				$data['delivery_day_cb'] = false;
			}

			if (isset($this->request->post['delivery_day_id'])) {
				$data['delivery_day_id'] = $this->request->post['delivery_day_id'];
			} elseif ($order_data['loadings']['row']['shipment']['delivery_day']) {
				$data['delivery_day_id'] = $order_data['loadings']['row']['shipment']['delivery_day'];
			} else {
				$data['delivery_day_id'] = '';
			}

			$data['priority_time_types'] = array(
				array('id' => 'BEFORE', 'name' => $this->language->get('text_before'), 'hours' => array(10, 11, 12, 13, 14, 15, 16, 17, 18)),
				array('id' => 'IN', 'name' => $this->language->get('text_in'), 'hours' => array(9, 10, 11, 12, 13, 14, 15, 16, 17, 18)),
				array('id' => 'AFTER', 'name' => $this->language->get('text_after'), 'hours' => array(9, 10, 11, 12, 13, 14, 15, 16, 17))
			);

			$data['error_delivery_day'] = '';
			$data['delivery_days'] = array();
			$data['priority_date'] = '';

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

			if (isset($this->request->post['pack_count'])) {
				$data['pack_count'] = $this->request->post['pack_count'];
			} else {
				$data['pack_count'] = 1; //$order_data['loadings']['row']['shipment']['pack_count'];
			}


			if (isset($this->request->post['partial_delivery'])) {
				$data['partial_delivery'] = $this->request->post['partial_delivery'];
			} else {
				$data['partial_delivery'] = $this->config->get('econt_partial_delivery');
			}

			if (isset($this->request->post['partial_delivery_instruction'])) {
				$data['partial_delivery_instruction'] = $this->request->post['partial_delivery_instruction'];
			} else {
				$data['partial_delivery_instruction'] = $this->config->get('econt_partial_delivery_instruction');
			}

			$data['partial_delivery_instructions'] = array(
				array('code' => 'ACCEPT', 'title' => $this->language->get('text_partial_delivery_accept')),
				array('code' => 'TEST', 'title' => $this->language->get('text_partial_delivery_test'))
			);

			if (isset($this->request->post['inventory'])) {
				$data['inventory'] = $this->request->post['inventory'];
			} else {
				$data['inventory'] = $this->config->get('econt_inventory');
			}

			if (isset($this->request->post['inventory_type'])) {
				$data['inventory_type'] = $this->request->post['inventory_type'];
			} else {
				$data['inventory_type'] = $this->config->get('econt_inventory_type');
			}

			$data['inventory_types'] = array(
				array('code' => 'DIGITAL', 'title' => $this->language->get('text_digital')),
				array('code' => 'LOADING', 'title' => $this->language->get('text_loading'))
			);

			$this->load->model('sale/order');

			$products = $this->model_sale_order->getOrderProducts($order_id);

			if (isset($this->request->post['products_count'])) {
				$data['products_count'] = $this->request->post['products_count'];
			} else {
				$data['products_count'] = count($products);
			}

			if (isset($this->request->post['products'])) {
				$data['products'] = $this->request->post['products'];
			} else {
				$data['products'] = array();

				$order_info = $this->model_sale_order->getOrder($order_id);

				foreach ($products as $product) {
					$product_info = $this->model_catalog_product->getProduct($product['product_id']);

					for ($i = 0; $i < $product['quantity']; $i++) {
						$data['products'][] = array(
							'product_id' => $product['product_id'],
							'name'       => $product['name'],
							'weight'     => $this->weight->convert($product_info['weight'], $product_info['weight_class_id'], $this->config->get('econt_weight_class_id')),
							'price'      => round($this->currency->convert($this->currency->format($product['price'], $order_info['currency_id'], $order_info['currency_value'], FALSE), $order_info['currency_code'], $this->config->get('econt_currency')), 2)
						);
					}
				}
			}

			if (isset($this->request->post['instruction'])) {
				$data['instruction'] = $this->request->post['instruction'];
			} else {
				$data['instruction'] = $this->config->get('econt_instruction');
			}

			if (isset($this->request->post['instructions'])) {
				$data['instructions'] = $this->request->post['instructions'];
			} elseif ($this->config->get('econt_instructions')) {
				if (!is_array($this->config->get('econt_instructions'))) {
					$data['instructions'] = unserialize($this->config->get('econt_instructions'));
				} else {
					$data['instructions'] = $this->config->get('econt_instructions');
				}
			} else {
				$data['instructions'] = array();
			}

			if (isset($this->request->post['instructions_id'])) {
				$data['instructions_id'] = $this->request->post['instructions_id'];
			} elseif ($this->config->get('econt_instructions_id')) {
				if (!is_array($this->config->get('econt_instructions_id'))) {
					$data['instructions_id'] = unserialize($this->config->get('econt_instructions_id'));
				} else {
					$data['instructions_id'] = $this->config->get('econt_instructions_id');
				}
			} else {
				$data['instructions_id'] = array();
			}

			$data['instructions_types'] = array(
				array('code' => 'take', 'title' => $this->language->get('text_instructions_take')),
				array('code' => 'give', 'title' => $this->language->get('text_instructions_give')),
				array('code' => 'return', 'title' => $this->language->get('text_instructions_return')),
				array('code' => 'services', 'title' => $this->language->get('text_instructions_services'))
			);
			
			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');
			
			$this->response->setOutput($this->load->view('sale/econt_generate.tpl', $data));
		} else {
			$this->language->load('error/not_found');

			$this->document->setTitle($this->language->get('heading_title'));

			$data['heading_title'] = $this->language->get('heading_title');

			$data['text_not_found'] = $this->language->get('text_not_found');

			$data['breadcrumbs'] = array();

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			);

			$data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_orders'),
				'href'      => $this->url->link('error/not_found', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			);

			$data['header'] = $this->load->controller('common/header');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['footer'] = $this->load->controller('common/footer');
			
			$this->response->setOutput($this->load->view('error/not_found.tpl', $data));
		}
	}

	protected function validateGenerate($data) {
		if (!$this->user->hasPermission('modify', 'sale/econt')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ($this->request->post['shipping_to'] == 'DOOR' && $this->request->post['post_code'] && $this->request->post['city'] && ($this->request->post['quarter'] && $this->request->post['other'] || $this->request->post['street'] && $this->request->post['street_num'])) {
			if (!$this->model_shipping_econt->validateAddress($this->request->post)) {
				$this->error['receiver_address'] = $this->language->get('error_receiver_address');
			}
		} elseif ($this->request->post['shipping_to'] == 'DOOR') {
			$this->error['receiver_address'] = $this->language->get('error_receiver_address');
		}

		if ($this->request->post['shipping_to'] == 'OFFICE') {
			if (!$this->request->post['office_id']) {
				$this->error['receiver_office'] = $this->language->get('error_receiver_office');
			}
		}

		if (!isset($this->request->post['address_id'])) {
			$this->error['address'] = $this->language->get('error_address');
		}
		
		$this->load->model('sale/order');
		$this->load->model('catalog/product');

		$order_products = $this->model_sale_order->getOrderProducts($this->request->get['order_id']);
		foreach ($order_products as $product) {

			$product = $this->model_catalog_product->getProduct($product['product_id']);

			if ($product['shipping']) {
					$product_weight = (float)$product['weight'];

					if (empty($product_weight)) {
						$this->error['products_weight'] = $this->language->get('error_products_weight');

						break;
					}
			}
		}

		if ($this->request->post['sms']) {
			if (!$this->request->post['sms_no']) {
				$this->error['sms'] = $this->language->get('error_sms');
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

	private function generateLoading($data) {
		$order_id = $this->request->get['order_id'];

		$data['system']['validate'] = 0;
		$data['system']['only_calculate'] = 0;

		if (!is_array($this->config->get('econt_addresses'))) {
			$addresses = unserialize($this->config->get('econt_addresses'));
		} else {
			$addresses = $this->config->get('econt_addresses');
		}

		$address_id = $this->request->post['address_id'];

		if (isset($addresses[$address_id])) {
			$address = $addresses[$address_id];

			$data['loadings']['row']['sender']['city'] = $address['city'];
			$data['loadings']['row']['sender']['post_code'] = $address['post_code'];
			$data['loadings']['row']['sender']['quarter'] = $address['quarter'];
			$data['loadings']['row']['sender']['street'] = $address['street'];
			$data['loadings']['row']['sender']['street_num'] = $address['street_num'];
			$data['loadings']['row']['sender']['street_other'] = $address['other'];
		}

		if ($this->request->post['sms']) {
			$sms_no = $this->request->post['sms_no'];
		} else {
			$sms_no = '';
		}

		$data['loadings']['row']['receiver']['sms_no'] = $sms_no;

		if ($this->request->post['shipping_to'] == 'OFFICE') {
			if (isset($this->request->post['office_city_id'])) {
				$econt_city = $this->model_shipping_econt->getCityByCityId($this->request->post['office_city_id']);
				$data['loadings']['row']['receiver']['city'] = $econt_city['name'];
				$data['loadings']['row']['receiver']['post_code'] = $econt_city['post_code'];
			}

			$receiver_office_code = '';

			if (isset($this->request->post['office_id'])) {
				$receiver_office = $this->model_shipping_econt->getOffice($this->request->post['office_id']);
				if ($receiver_office) {
					$receiver_office_code = $receiver_office['office_code'];
				}
			}

			$data['loadings']['row']['receiver']['office_code'] = $receiver_office_code;
			$data['loadings']['row']['receiver']['quarter'] = '';
			$data['loadings']['row']['receiver']['street'] = '';
			$data['loadings']['row']['receiver']['street_num'] = '';
			$data['loadings']['row']['receiver']['street_other'] = '';
		} else {
			if (isset($this->request->post['city'])) {
				$data['loadings']['row']['receiver']['city'] = $this->request->post['city'];
			}

			if (isset($this->request->post['post_code'])) {
				$data['loadings']['row']['receiver']['post_code'] = $this->request->post['post_code'];
			}

			if (isset($this->request->post['quarter'])) {
				$data['loadings']['row']['receiver']['quarter'] = $this->request->post['quarter'];
			}

			if (isset($this->request->post['street'])) {
				$data['loadings']['row']['receiver']['street'] = $this->request->post['street'];
			}

			if (isset($this->request->post['street_num'])) {
				$data['loadings']['row']['receiver']['street_num'] = $this->request->post['street_num'];
			}

			if (isset($this->request->post['other'])) {
				$data['loadings']['row']['receiver']['street_other'] = $this->request->post['other'];
			}
		}

		$weight = 0;
		$description = array();
		$product_count = 0;
		$total = 0;

		$this->load->model('catalog/product');
		$order_products = $this->model_sale_order->getOrderProducts($order_id);

		foreach ($order_products as $product) {
			$description[] = $product['name'];
			$product_count += (int)$product['quantity'];

			$product_info = $this->model_catalog_product->getProduct($product['product_id']);

			if ($product_info) {
				$weight += $this->weight->convert($product_info['weight'] * $product['quantity'], $product_info['weight_class_id'], $this->config->get('econt_weight_class_id'));
			}
		}

		$this->load->model('sale/order');
		$order_totals = $this->model_sale_order->getOrderTotals($order_id);	
		foreach ($order_totals as $order_total) {
			if ($order_total['code'] == 'shipping') {
				$order_totals_shipping = (float)$order_total['value'];
			}
			if ($order_total['code'] == 'total') {
				$order_totals_total = (float)$order_total['value'];
			}
		}
		$total = $order_totals_total - $order_totals_shipping;

		$data['loadings']['row']['shipment']['description'] = implode(', ', $description);

		$data['loadings']['row']['shipment']['weight'] = $weight;

		if ($data['loadings']['row']['shipment']['weight'] > 100) {
			$data['loadings']['row']['shipment']['shipment_type'] = 'CARGO';
			$data['loadings']['row']['shipment']['cargo_code'] = 81;
		} else {
			$data['loadings']['row']['shipment']['shipment_type'] = 'PACK';
		}

		$total = round($this->currency->format($total, $this->config->get('econt_currency'), '', false), 2);

		$order_info = $this->model_sale_order->getOrder($order_id);

		if ($order_info['payment_code'] == 'econt_cod') {
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

		$data['loadings']['row']['services']['cd'] = array('type' => $cd_type, 'value' => $cd_value);
		$data['loadings']['row']['services']['cd_currency'] = $cd_currency;
		$data['loadings']['row']['services']['cd_agreement_num'] = $cd_agreement_num;

		$data['loadings']['row']['payment']['side'] = $this->config->get('econt_side');
		$data['loadings']['row']['payment']['method'] = $this->config->get('econt_payment_method');

		$receiver_share_sum_door = '';
		$receiver_share_sum_office = '';

		if ((float)$this->config->get('econt_total_for_free') && ($total >= $this->config->get('econt_total_for_free')) || (int)$this->config->get('econt_count_for_free') && ($product_count >= $this->config->get('econt_count_for_free')) || (float)$this->config->get('econt_weight_for_free') && ($weight >= $this->config->get('econt_weight_for_free'))) {
			$data['loadings']['row']['payment']['side'] = 'SENDER';
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

		if ($this->request->post['shipping_to'] == 'OFFICE') {
			$receiver_share_sum = $receiver_share_sum_office;
		} else {
			$receiver_share_sum = $receiver_share_sum_door;
		}

		if ($receiver_share_sum) {
			$data['loadings']['row']['payment']['side'] = 'SENDER';
		}

		$data['loadings']['row']['payment']['receiver_share_sum'] = $receiver_share_sum;
		$data['loadings']['row']['payment']['share_percent'] = '';

		if ($data['loadings']['row']['payment']['side'] == 'RECEIVER') {
			$data['loadings']['row']['payment']['method'] = 'CASH';
		}

		if ($data['loadings']['row']['payment']['method'] == 'CREDIT') {
			$key_word = $this->config->get('econt_key_word');
		} else {
			$key_word = '';
		}

		$data['loadings']['row']['payment']['key_word'] = $key_word;

		if ($this->config->get('econt_oc') && ($total >= $this->config->get('econt_total_for_oc'))) {
			$oc = $total;
			$oc_currency = $this->config->get('econt_currency');
		} else {
			$oc = '';
			$oc_currency = '';
		}

		$data['loadings']['row']['services']['oc'] = $oc;
		$data['loadings']['row']['services']['oc_currency'] = $oc_currency;

		if ($data['loadings']['row']['payment']['side'] == 'RECEIVER') {
			$data['loadings']['row']['payment']['method'] = 'CASH';
		}

		$data['loadings']['row']['shipment']['invoice_before_pay_CD'] = (int)$this->request->post['invoice_before_cd'];

		if (isset($this->request->post['pay_after_accept'])) {
			$pay_after_accept = (int)$this->request->post['pay_after_accept'];
		} else {
			$pay_after_accept = 0;
		}

		$data['loadings']['row']['shipment']['pay_after_accept'] = $pay_after_accept;

		$tariff_sub_code = $this->config->get('econt_shipping_from') . '_' . $this->request->post['shipping_to'];

		$tariff_code = 0;

		if (isset($this->request->post['express_city_courier_cb']) && $this->request->post['shipping_to'] == 'DOOR') {
			$tariff_code = 1;
		} elseif ($tariff_sub_code == 'OFFICE_OFFICE') {
			$tariff_code = 2;
		} elseif ($tariff_sub_code == 'OFFICE_DOOR' || $tariff_sub_code == 'DOOR_OFFICE') {
			$tariff_code = 3;
		} elseif ($tariff_sub_code == 'DOOR_DOOR') {
			$tariff_code = 4;
		}

		$data['loadings']['row']['shipment']['tariff_code'] = $tariff_code;
		$data['loadings']['row']['shipment']['tariff_sub_code'] = $tariff_sub_code;

		if (isset($this->request->post['pay_after_test'])) {
			$pay_after_test = (int)$this->request->post['pay_after_test'];
		} else {
			$pay_after_test = 0;
		}

		$data['loadings']['row']['shipment']['pay_after_test'] = $pay_after_test;

		if (isset($this->request->post['instruction_returns'])) {
			$instruction_returns = $this->request->post['instruction_returns'];
		} else {
			$instruction_returns = '';
		}

		$data['loadings']['row']['shipment']['instruction_returns'] = $instruction_returns;

		if (isset($this->request->post['delivery_day_cb']) && isset($this->request->post['delivery_day_id'])) {
			$delivery_day = $this->request->post['delivery_day_id'];
		} else {
			$delivery_day = '';
		}

		$data['loadings']['row']['shipment']['delivery_day'] = $delivery_day;

		$data['loadings']['row']['shipment']['pack_count'] = (int)$this->request->post['pack_count'];

		if (isset($this->request->post['priority_time_cb']) && $this->request->post['shipping_to'] == 'DOOR') {
			$priority_time_type = $this->request->post['priority_time_type_id'];
			$priority_time_value = $this->request->post['priority_time_hour_id'];
		} else {
			$priority_time_type = '';
			$priority_time_value = '';
		}

		$data['loadings']['row']['services']['p'] = array('type' => $priority_time_type, 'value' => $priority_time_value);

		$city_courier_e1 = '';
		$city_courier_e2 = '';
		$city_courier_e3 = '';

		if (isset($this->request->post['express_city_courier_cb']) && $this->request->post['shipping_to'] == 'DOOR') {
			if ($this->request->post['express_city_courier_e'] == 'e1') {
				$city_courier_e1 = 'ON';
			} elseif ($this->request->post['express_city_courier_e'] == 'e2') {
				$city_courier_e2 = 'ON';
			} elseif ($this->request->post['express_city_courier_e'] == 'e3') {
				$city_courier_e3 = 'ON';
			}
		}

		$data['loadings']['row']['services']['e1'] = $city_courier_e1;
		$data['loadings']['row']['services']['e2'] = $city_courier_e2;
		$data['loadings']['row']['services']['e3'] = $city_courier_e3;

		if ($this->request->post['dc']) {
			$dc = 'ON';
		} else {
			$dc = '';
		}

		$data['loadings']['row']['services']['dc'] = $dc;

		if ($this->request->post['dc_cp']) {
			$dc_cp = 'ON';
		} else {
			$dc_cp = '';
		}

		$data['loadings']['row']['services']['dc_cp'] = $dc_cp;

		if ($this->request->post['products_count'] > 1 && $this->request->post['partial_delivery']) {
			$data['loadings']['row']['packing_list']['partial_delivery'] = $this->request->post['partial_delivery_instruction'];
		}

		if ($this->request->post['inventory']) {
			$data['loadings']['row']['packing_list']['type'] = $this->request->post['inventory_type'];

			if ($this->request->post['inventory_type'] == 'DIGITAL') {
				foreach ($this->request->post['products'] as $product) {
					$data['loadings']['row']['packing_list']['row'][]['e'] = array(
						'inventory_num' => $product['product_id'],
						'description'   => $product['name'],
						'weight'        => $product['weight'],
						'price'         => $product['price']
					);
				}
			}
		}

		if ($this->request->post['instruction']) {
			foreach ($this->request->post['instructions'] as $type => $instruction) {
				if ($instruction != '') {
					$data['loadings']['row']['instructions'][]['e'] = array(
						'type'     => $type,
						'template' => $instruction
					);
				}
			}
		}

		$results = $this->parcelImport($data);

		if ($results) {
			if (!empty($results->result->e->error)) {
				$this->error['warning'] = (string)$results->result->e->error;
			} elseif (isset($results->result->e->loading_price->total)) {
				$loading_data = array(
					'order_id'    => $order_id,
					'loading_id'  => $results->result->e->loading_id,
					'loading_num' => $results->result->e->loading_num,
					'pdf_url'     => $results->result->e->pdf_url
				);

				if (isset($results->pdf)) {
					$loading_data['blank_yes'] = $results->pdf->blank_yes;
					$loading_data['blank_no'] = $results->pdf->blank_no;
				} else {
					$loading_data['blank_yes'] = '';
					$loading_data['blank_no'] = '';
				}

				$this->model_sale_econt->addLoading($loading_data);

				if ((float)$this->config->get('econt_total_for_free') && ($total >= $this->config->get('econt_total_for_free')) || (int)$this->config->get('econt_count_for_free') && ($product_count >= $this->config->get('econt_count_for_free')) || (float)$this->config->get('econt_weight_for_free') && ($weight >= $this->config->get('econt_weight_for_free')) || !$receiver_share_sum && $this->config->get('econt_side') == 'SENDER') {
					$order_total = 0.00;
				} elseif (isset($data['error']['weight'])) {
					$order_total = 0.00;
				} elseif ($receiver_share_sum) {
					$order_total = (float)$receiver_share_sum;
				} else {
					$order_total = (float)$results->result->e->loading_price->total;
				}

				$comment = $this->model_sale_econt->updateOrderTotal($order_id, (float)$order_total);

				$history_data = array(
					'order_status_id' => $this->config->get('econt_order_status_id'),
					'append' => true,
					'notify' => true,
					'comment' => $comment
				);

				// API - Add Order History
				if (!isset($this->session->data['cookie'])) {
					$this->load->model('user/api');

					$api_info = $this->model_user_api->getApi($this->config->get('config_api_id'));

					if ($api_info) {
						$curl = curl_init();

						// Set SSL if required
						if (substr(HTTPS_CATALOG, 0, 5) == 'https') {
							curl_setopt($curl, CURLOPT_PORT, 443);
						}

						curl_setopt($curl, CURLOPT_HEADER, false);
						curl_setopt($curl, CURLINFO_HEADER_OUT, true);
						curl_setopt($curl, CURLOPT_USERAGENT, $this->request->server['HTTP_USER_AGENT']);
						curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
						curl_setopt($curl, CURLOPT_FORBID_REUSE, false);
						curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
						curl_setopt($curl, CURLOPT_URL, HTTPS_CATALOG . 'index.php?route=api/login');
						curl_setopt($curl, CURLOPT_POST, true);
						curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($api_info));

						$json = curl_exec($curl);

						if (!$json) {
							$this->error['warning'] = sprintf($this->language->get('error_curl'), curl_error($curl), curl_errno($curl));
						} else {
							$response = json_decode($json, true);

							if (isset($response['cookie'])) {
								$this->session->data['cookie'] = $response['cookie'];
							}

							curl_close($curl);
						}
					}
				}

				if (isset($this->session->data['cookie'])) {
					$curl = curl_init();

					// Set SSL if required
					if (substr(HTTPS_CATALOG, 0, 5) == 'https') {
						curl_setopt($curl, CURLOPT_PORT, 443);
					}

					curl_setopt($curl, CURLOPT_HEADER, false);
					curl_setopt($curl, CURLINFO_HEADER_OUT, true);
					curl_setopt($curl, CURLOPT_USERAGENT, $this->request->server['HTTP_USER_AGENT']);
					curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
					curl_setopt($curl, CURLOPT_FORBID_REUSE, false);
					curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
					curl_setopt($curl, CURLOPT_URL, HTTPS_CATALOG . 'index.php?route=api/order/history&order_id=' . $order_id);
					curl_setopt($curl, CURLOPT_POST, true);
					curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($history_data));
					curl_setopt($curl, CURLOPT_COOKIE, session_name() . '=' . $this->session->data['cookie'] . ';');


					$response = curl_exec($curl);
				}
				// End API
			}
		} else {
			$this->error['warning'] = $this->language->get('error_connect');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function prepareXML($data) {
		$xml = '';

		foreach ($data as $key => $value) {
			if ($key && $key == 'error') {
				continue;
			}

			if ($key && ($key == 'p' || $key == 'cd')) {
				$xml .= '<' . $key . ' type="' . $value['type'] . '">' . $value['value'] . '</' . $key . '>' . "\r\n";
			} else {
				if (!is_numeric($key)) {
					$xml .= '<' . $key . '>';
				}

				if (is_array($value)) {
					$xml .= "\r\n" . $this->prepareXML($value);
				} else {
					$xml .= $value;
				}

				if (!is_numeric($key)) {
					$xml .= '</' . $key . '>' . "\r\n";
				}
			}
		}

		return $xml;
	}

	private function serviceTool($data) {
		if (!$this->config->get('econt_test')) {
			$url = 'http://www.econt.com/e-econt/xml_service_tool.php';
		} else {
			$url = 'http://demo.econt.com/e-econt/xml_service_tool.php';
		}

		$request = '<?xml version="1.0" ?>
					<request>
						<client>
							<username>' . htmlspecialchars_decode($this->config->get('econt_username')) . '</username>
							<password>' . htmlspecialchars_decode($this->config->get('econt_password')) . '</password>
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

		libxml_use_internal_errors(TRUE);
		return simplexml_load_string($response);
	}

	private function parcelImport($data) {
		if (!$this->config->get('econt_test')) {
			$url = 'http://www.econt.com/e-econt/xml_parcel_import2.php';
		} else {
			$url = 'http://demo.econt.com/e-econt/xml_parcel_import2.php';
		}

		$data['loadings']['row']['mediator'] = 'extensa';

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
}
?>
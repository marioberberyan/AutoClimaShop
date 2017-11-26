<?php
class ModelSaleEcont extends Model {
	public function getOrder($order_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "econt_order WHERE order_id = '" . (int)$order_id . "'");

		return $query->row;
	}

	public function getLoading($order_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "econt_loading WHERE order_id = '" . (int)$order_id . "'");

		return $query->row;
	}

	public function getLoadingNextParcels($loading_num) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "econt_loading WHERE prev_parcel_num = '" . $this->db->escape($loading_num) . "'");

		return $query->rows;
	}

	public function getLoadingTrackings($econt_loading_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "econt_loading_tracking WHERE econt_loading_id = '" . (int)$econt_loading_id . "'");

		return $query->rows;
	}

	public function addLoading($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_loading SET order_id = '" . (int)$data['order_id'] . "', loading_id = '" . $this->db->escape($data['loading_id']) . "', loading_num = '" . $this->db->escape($data['loading_num']) . "', blank_yes = '" . $this->db->escape(trim($data['blank_yes'])) . "', blank_no = '" . $this->db->escape(trim($data['blank_no'])) . "', pdf_url = '" . $this->db->escape(trim($data['pdf_url'])) . "'");
	}

	public function updateLoading($data) {
		$this->db->query("UPDATE " . DB_PREFIX . "econt_loading SET is_imported = '" . (int)$data['is_imported'] . "', storage = '" . $this->db->escape($data['storage']) . "', receiver_person = '" . $this->db->escape($data['receiver_person']) . "', receiver_person_phone = '" . $this->db->escape($data['receiver_person_phone']) . "', receiver_courier = '" . $this->db->escape($data['receiver_courier']) . "', receiver_courier_phone = '" . $this->db->escape($data['receiver_courier_phone']) . "', receiver_time = '" . date('Y-m-d H:i:s', strtotime($data['receiver_time'])) . "', cd_get_sum = '" . $this->db->escape($data['cd_get_sum']) . "', cd_get_time = '" . date('Y-m-d H:i:s', strtotime($data['cd_get_time'])) . "', cd_send_sum = '" . $this->db->escape($data['cd_send_sum']) . "', cd_send_time = '" . date('Y-m-d H:i:s', strtotime($data['cd_send_time'])) . "', total_sum = '" . $this->db->escape($data['total_sum']) . "', currency = '" . $this->db->escape($data['currency']) . "', sender_ammount_due = '" . $this->db->escape($data['sender_ammount_due']) . "', receiver_ammount_due = '" . $this->db->escape($data['receiver_ammount_due']) . "', other_ammount_due = '" . $this->db->escape($data['other_ammount_due']) . "', delivery_attempt_count = '" . $this->db->escape($data['delivery_attempt_count']) . "', blank_yes = '" . $this->db->escape(trim($data['blank_yes'])) . "', blank_no = '" . $this->db->escape(trim($data['blank_no'])) . "', pdf_url = '" . $this->db->escape(trim($data['pdf_url'])) . "' WHERE econt_loading_id  = '" . (int)$data['econt_loading_id'] . "'");

		if (isset($data['trackings'])) {
			foreach ($data['trackings'] as $tracking) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "econt_loading_tracking SET econt_loading_id = '" . (int)$data['econt_loading_id'] . "', loading_num = '" . $this->db->escape($data['loading_num']) . "', time = '" . date('Y-m-d H:i:s', strtotime($tracking['time'])) . "', is_receipt = '" . (int)$tracking['is_receipt'] . "', event = '" . $this->db->escape($tracking['event']) . "', name = '" . $this->db->escape($tracking['name']) . "', name_en = '" . $this->db->escape($tracking['name_en']) . "'");
			}
		}

		if (isset($data['next_parcels'])) {
			foreach ($data['next_parcels'] as $next_parcel) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "econt_loading SET loading_num = '" . $this->db->escape($next_parcel['loading_num']) . "', is_imported = '" . (int)$next_parcel['is_imported'] . "', storage = '" . $this->db->escape($next_parcel['storage']) . "', receiver_person = '" . $this->db->escape($next_parcel['receiver_person']) . "', receiver_person_phone = '" . $this->db->escape($next_parcel['receiver_person_phone']) . "', receiver_courier = '" . $this->db->escape($next_parcel['receiver_courier']) . "', receiver_courier_phone = '" . $this->db->escape($next_parcel['receiver_courier_phone']) . "', receiver_time = '" . date('Y-m-d H:i:s', strtotime($next_parcel['receiver_time'])) . "', cd_get_sum = '" . $this->db->escape($next_parcel['cd_get_sum']) . "', cd_get_time = '" . date('Y-m-d H:i:s', strtotime($next_parcel['cd_get_time'])) . "', cd_send_sum = '" . $this->db->escape($next_parcel['cd_send_sum']) . "', cd_send_time = '" . date('Y-m-d H:i:s', strtotime($next_parcel['cd_send_time'])) . "', total_sum = '" . $this->db->escape($next_parcel['total_sum']) . "', currency = '" . $this->db->escape($next_parcel['currency']) . "', sender_ammount_due = '" . $this->db->escape($next_parcel['sender_ammount_due']) . "', receiver_ammount_due = '" . $this->db->escape($next_parcel['receiver_ammount_due']) . "', other_ammount_due = '" . $this->db->escape($next_parcel['other_ammount_due']) . "', delivery_attempt_count = '" . $this->db->escape($next_parcel['delivery_attempt_count']) . "', blank_yes = '" . $this->db->escape(trim($next_parcel['blank_yes'])) . "', blank_no = '" . $this->db->escape(trim($next_parcel['blank_no'])) . "', pdf_url = '" . $this->db->escape(trim($next_parcel['pdf_url'])) . "', prev_parcel_num = '" . $this->db->escape(trim($data['loading_num'])) . "', next_parcel_reason = '" . $this->db->escape(trim($next_parcel['reason'])) . "'");

				if (isset($next_parcel['trackings'])) {
					$econt_loading_next_id = $this->db->getLastId();

					foreach ($next_parcel['trackings'] as $tracking) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "econt_loading_tracking SET econt_loading_id = '" . (int)$econt_loading_next_id . "', loading_num = '" . $this->db->escape($next_parcel['loading_num']) . "', time = '" . date('Y-m-d H:i:s', strtotime($tracking['time'])) . "', is_receipt = '" . (int)$tracking['is_receipt'] . "', event = '" . $this->db->escape($tracking['event']) . "', name = '" . $this->db->escape($tracking['name']) . "', name_en = '" . $this->db->escape($tracking['name_en']) . "'");
					}
				}
			}
		}
	}

	public function updateOrderTotal($order_id, $cost) {
		$comment = '';

		$order_query = $this->db->query("SELECT *, os.name AS status FROM `" . DB_PREFIX . "order` o LEFT JOIN " . DB_PREFIX . "order_status os ON (o.order_status_id = os.order_status_id AND os.language_id = o.language_id) WHERE o.order_id = '" . (int)$order_id . "'");

		if ($order_query->num_rows) {

			$order_shipping_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "' AND code = 'shipping'");

			if ($order_shipping_query->num_rows) {
				$old_shipping_value = $order_shipping_query->row['value'];
				$shipping_value = $this->currency->convert($cost, $this->config->get('econt_currency'), $order_query->row['currency_code']);
				$shipping_text = $this->currency->format($shipping_value, $order_query->row['currency_code'], $order_query->row['currency_value']);

				$this->db->query("UPDATE " . DB_PREFIX . "order_total SET value = '" . (float)$shipping_value . "' WHERE order_total_id = '" . (int)$order_shipping_query->row['order_total_id'] . "'");

				$comment .= $order_shipping_query->row['title'] . ' ' . $shipping_text;

				$order_total_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "' AND code = 'total'");

				if ($order_total_query->num_rows) {
					$total_value = $order_total_query->row['value'] - $old_shipping_value + $shipping_value;
					$total_text = $this->currency->format($total_value, $order_query->row['currency_code'], $order_query->row['currency_value']);

					$this->db->query("UPDATE " . DB_PREFIX . "order_total SET value = '" . (float)$total_value . "' WHERE order_total_id = '" . (int)$order_total_query->row['order_total_id'] . "'");

					$this->db->query("UPDATE `" . DB_PREFIX . "order` SET total = '" . (float)$total_value . "' WHERE order_id = '" . (int)$order_id . "'");

					$comment .= "\n" . $order_total_query->row['title'] . ' ' . $total_text;
				}
			}
		}

		return $comment;
	}
}
?>

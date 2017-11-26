<?php
class ModelShippingEcont extends Model {
	public function createTables() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_city` (
		  `city_id` int(11) NOT NULL AUTO_INCREMENT,
		  `post_code` varchar(10) NOT NULL DEFAULT '',
		  `type` varchar(3) NOT NULL DEFAULT '' COMMENT '‘гр.’ или ‘с.’',
		  `name` varchar(255) NOT NULL DEFAULT '',
		  `name_en` varchar(255) NOT NULL DEFAULT '',
		  `zone_id` int(11) NOT NULL DEFAULT '3' COMMENT '3 - Зона В',
		  `country_id` int(11) NOT NULL DEFAULT '1033' COMMENT '1033 - България',
		  `office_id` int(11) NOT NULL DEFAULT '0' COMMENT 'главния офис',
		  PRIMARY KEY (`city_id`),
		  KEY `post_code` (`post_code`),
		  KEY `name` (`name`),
		  KEY `name_en` (`name_en`),
		  KEY `office_id` (`office_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_city_office` (
		  `city_office_id` int(11) NOT NULL AUTO_INCREMENT,
		  `office_code` varchar(10) NOT NULL DEFAULT '',
		  `shipment_type` varchar(32) NOT NULL DEFAULT '',
		  `delivery_type` varchar(32) NOT NULL DEFAULT '',
		  `city_id` int(11) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`city_office_id`),
		  KEY `office_code` (`office_code`),
		  KEY `city_id` (`city_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_country` (
		  `country_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(255) NOT NULL DEFAULT '',
		  `name_en` varchar(255) NOT NULL DEFAULT '',
		  `zone_id` int(11) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`country_id`),
		  KEY `zone_id` (`zone_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_customer` (
		  `customer_id` int(11) NOT NULL,
		  `shipping_to` varchar(32) NOT NULL DEFAULT '',
		  `postcode` varchar(10) NOT NULL DEFAULT '',
		  `city` varchar(255) NOT NULL DEFAULT '',
		  `quarter` varchar(255) NOT NULL DEFAULT '',
		  `street` varchar(255) NOT NULL DEFAULT '',
		  `street_num` varchar(10) NOT NULL DEFAULT '',
		  `other` varchar(255) NOT NULL DEFAULT '',
		  `city_id` int(11) NOT NULL DEFAULT '0',
		  `office_id` int(11) NOT NULL DEFAULT '0',
		  KEY `customer_id` (`customer_id`),
		  KEY `city_id` (`city_id`),
		  KEY `office_id` (`office_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_loading` (
		  `econt_loading_id` int(11) NOT NULL AUTO_INCREMENT,
		  `order_id` int(11) NOT NULL DEFAULT '0',
		  `loading_id` varchar(32) NOT NULL DEFAULT '',
		  `loading_num` varchar(32) NOT NULL DEFAULT '',
		  `is_imported` tinyint(1) NOT NULL DEFAULT '0',
		  `storage` varchar(255) NOT NULL DEFAULT '',
		  `receiver_person` varchar(255) NOT NULL DEFAULT '',
		  `receiver_person_phone` varchar(255) NOT NULL DEFAULT '',
		  `receiver_courier` varchar(255) NOT NULL DEFAULT '',
		  `receiver_courier_phone` varchar(255) NOT NULL DEFAULT '',
		  `receiver_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
		  `cd_get_sum` varchar(32) NOT NULL DEFAULT '',
		  `cd_get_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
		  `cd_send_sum` varchar(32) NOT NULL DEFAULT '',
		  `cd_send_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
		  `total_sum` varchar(32) NOT NULL DEFAULT '',
		  `currency` varchar(10) NOT NULL DEFAULT '',
		  `sender_ammount_due` varchar(32) NOT NULL DEFAULT '',
		  `receiver_ammount_due` varchar(32) NOT NULL DEFAULT '',
		  `other_ammount_due` varchar(32) NOT NULL DEFAULT '',
		  `delivery_attempt_count` varchar(10) NOT NULL DEFAULT '',
		  `blank_yes` varchar(255) NOT NULL DEFAULT '',
		  `blank_no` varchar(255) NOT NULL DEFAULT '',
		  PRIMARY KEY (`econt_loading_id`),
		  KEY `order_id` (`order_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_office` (
		  `office_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(255) NOT NULL DEFAULT '',
		  `name_en` varchar(255) NOT NULL DEFAULT '',
		  `office_code` varchar(10) NOT NULL DEFAULT '',
		  `address` varchar(255) NOT NULL DEFAULT '',
		  `address_en` varchar(255) NOT NULL DEFAULT '',
		  `phone` varchar(32) NOT NULL DEFAULT '',
		  `work_begin` time DEFAULT '09:00:00',
		  `work_end` time DEFAULT '18:00:00',
		  `work_begin_saturday` time DEFAULT '09:00:00',
		  `work_end_saturday` time DEFAULT '13:00:00',
		  `time_priority` time DEFAULT '12:00:00' COMMENT 'минимален приоритетен час',
		  `city_id` int(11) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`office_id`),
		  KEY `office_code` (`office_code`),
		  KEY `city_id` (`city_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_order` (
		  `econt_order_id` int(11) NOT NULL AUTO_INCREMENT,
		  `order_id` int(11) NOT NULL DEFAULT '0',
		  `data` text NOT NULL,
		  PRIMARY KEY (`econt_order_id`),
		  KEY `order_id` (`order_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_quarter` (
		  `quarter_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(255) NOT NULL DEFAULT '',
		  `name_en` varchar(255) NOT NULL DEFAULT '',
		  `city_id` int(11) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`quarter_id`),
		  KEY `name` (`name`),
		  KEY `name_en` (`name_en`),
		  KEY `city_id` (`city_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_region` (
		  `region_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(255) NOT NULL DEFAULT '',
		  `code` varchar(10) NOT NULL DEFAULT '',
		  `city_id` int(11) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`region_id`),
		  KEY `name` (`name`),
		  KEY `code` (`code`),
		  KEY `city_id` (`city_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_street` (
		  `street_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(255) NOT NULL DEFAULT '',
		  `name_en` varchar(255) NOT NULL DEFAULT '',
		  `city_id` int(11) NOT NULL DEFAULT '0',
		  PRIMARY KEY (`street_id`),
		  KEY `name` (`name`),
		  KEY `name_en` (`name_en`),
		  KEY `city_id` (`city_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_zone` (
		  `zone_id` int(11) NOT NULL AUTO_INCREMENT,
		  `name` varchar(255) NOT NULL DEFAULT '',
		  `name_en` varchar(255) NOT NULL DEFAULT '',
		  `national` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - в България; 0 - международна',
		  `is_ee` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - обслужва се от Еконт Експрес; 0 - от подизпълнител',
		  PRIMARY KEY (`zone_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");
	}

	public function updateTablesRS() {
		$this->db->query("CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "econt_loading_tracking` (
		  `econt_loading_tracking_id` int(11) NOT NULL AUTO_INCREMENT,
		  `econt_loading_id` int(11) NOT NULL DEFAULT '0',
		  `loading_num` varchar(32) NOT NULL DEFAULT '',
		  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
		  `is_receipt` tinyint(1) NOT NULL DEFAULT '0',
		  `event` varchar(32) NOT NULL DEFAULT '',
		  `name` varchar(255) NOT NULL DEFAULT '',
		  `name_en` varchar(255) NOT NULL DEFAULT '',
		  PRIMARY KEY (`econt_loading_tracking_id`),
		  KEY `econt_loading_id` (`econt_loading_id`)
		) ENGINE=MyISAM DEFAULT CHARSET=utf8");

		$this->db->query("ALTER TABLE `" . DB_PREFIX . "econt_loading` ADD `pdf_url` varchar(255) NOT NULL DEFAULT ''");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "econt_loading` ADD `prev_parcel_num` varchar(32) NOT NULL DEFAULT ''");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "econt_loading` ADD `next_parcel_reason` varchar(32) NOT NULL DEFAULT ''");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "econt_loading` ADD `is_returned` tinyint(1) NOT NULL DEFAULT '0'");
		$this->db->query("ALTER TABLE `" . DB_PREFIX . "econt_loading` ADD `returned_blank_yes` varchar(255) NOT NULL DEFAULT ''");
	}

	public function deleteTables() {
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_city`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_city_office`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_country`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_customer`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_loading`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_office`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_order`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_quarter`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_region`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_street`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_zone`");
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "econt_loading_tracking`");
	}

	public function deleteCountries() {
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "econt_country");
	}

	public function addCountry($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_country SET name = '" . $this->db->escape($data['name']) . "', name_en = '" . $this->db->escape($data['name_en']) . "', zone_id = '" . (int)$data['zone_id'] . "'");
	}

	public function deleteZones() {
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "econt_zone");
	}

	public function addZone($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_zone SET zone_id = '" . (int)$data['zone_id'] . "', name = '" . $this->db->escape($data['name']) . "', name_en = '" . $this->db->escape($data['name_en']) . "', national = '" . (int)$data['national'] . "', is_ee = '" . (int)$data['is_ee'] . "'");
	}

	public function deleteRegions() {
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "econt_region");
	}

	public function addRegion($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_region SET region_id = '" . (int)$data['region_id'] . "', name = '" . $this->db->escape($data['name']) . "', code = '" . $this->db->escape($data['code']) . "', city_id = '" . (int)$data['city_id'] . "'");
	}

	public function deleteQuarters() {
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "econt_quarter");
	}

	public function addQuarter($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_quarter SET quarter_id = '" . (int)$data['quarter_id'] . "', name = '" . $this->db->escape($data['name']) . "', name_en = '" . $this->db->escape($data['name_en']) . "', city_id = '" . (int)$data['city_id'] . "'");
	}

	public function deleteStreets() {
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "econt_street");
	}

	public function addStreet($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_street SET street_id = '" . (int)$data['street_id'] . "', name = '" . $this->db->escape($data['name']) . "', name_en = '" . $this->db->escape($data['name_en']) . "', city_id = '" . (int)$data['city_id'] . "'");
	}

	public function deleteOffices() {
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "econt_office");
	}

	public function addOffice($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_office SET office_id = '" . (int)$data['office_id'] . "', name = '" . $this->db->escape($data['name']) . "', name_en = '" . $this->db->escape($data['name_en']) . "', office_code = '" . $this->db->escape($data['office_code']) . "', address = '" . $this->db->escape($data['address']) . "', address_en = '" . $this->db->escape($data['address_en']) . "', phone = '" . $this->db->escape($data['phone']) . "', work_begin = '" . $this->db->escape($data['work_begin']) . "', work_end = '" . $this->db->escape($data['work_end']) . "', work_begin_saturday = '" . $this->db->escape($data['work_begin_saturday']) . "', work_end_saturday = '" . $this->db->escape($data['work_end_saturday']) . "', time_priority = '" . $this->db->escape($data['time_priority']) . "', city_id = '" . (int)$data['city_id'] . "'");
	}

	public function deleteCities() {
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "econt_city");
	}

	public function addCity($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_city SET city_id = '" . (int)$data['city_id'] . "', post_code = '" . $this->db->escape($data['post_code']) . "', type = '" . $this->db->escape($data['type']) . "', name = '" . $this->db->escape($data['name']) . "', name_en = '" . $this->db->escape($data['name_en']) . "', zone_id = '" . (int)$data['zone_id'] . "', country_id = '" . (int)$data['country_id'] . "', office_id = '" . (int)$data['office_id'] . "'");
	}

	public function deleteCitiesOffices() {
		$this->db->query("TRUNCATE TABLE " . DB_PREFIX . "econt_city_office");
	}

	public function addCityOffice($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "econt_city_office SET office_code = '" . $this->db->escape($data['office_code']) . "', shipment_type = '" . $this->db->escape($data['shipment_type']) . "', delivery_type = '" . $this->db->escape($data['delivery_type']) . "', city_id = '" . (int)$data['city_id'] . "'");
	}

	public function getCitiesByName($name, $limit = 10) {
		if (strtolower($this->config->get('config_admin_language')) == 'bg') {
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

	public function getCityByNameAndPostcode($name, $postcode) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "econt_city c WHERE (LCASE(TRIM(c.name)) = '" . $this->db->escape(utf8_strtolower(trim($name))) . "' OR LCASE(TRIM(c.name_en)) = '" . $this->db->escape(utf8_strtolower(trim($name))) . "') AND TRIM(c.post_code) = '" . $this->db->escape(trim($postcode)) . "'");

		return $query->row;
	}

	public function getQuartersByName($name, $city_id, $limit = 10) {
		if (strtolower($this->config->get('config_admin_language')) == 'bg') {
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
		if (strtolower($this->config->get('config_admin_language')) == 'bg') {
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
		if (strtolower($this->config->get('config_admin_language')) == 'bg') {
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
		if (strtolower($this->config->get('config_admin_language')) == 'bg') {
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
		if (strtolower($this->config->get('config_admin_language')) == 'bg') {
			$suffix = '';
		} else {
			$suffix = '_en';
		}

		$query = $this->db->query("SELECT *, o.name" . $suffix . " AS name, o.address" . $suffix . " AS address FROM " . DB_PREFIX . "econt_office o WHERE o.office_id = '" . (int)$office_id . "'");

		return $query->row;
	}

	public function getCityByCityId($city_id) {
		if (strtolower($this->config->get('config_admin_language')) == 'bg') {
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

	public function getOfficeByOfficeCode($office_code) {
		if (strtolower($this->config->get('config_admin_language')) == 'bg') {
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

	public function validateAddress($data) {
		$sql = "SELECT COUNT(c.city_id) AS total FROM " . DB_PREFIX . "econt_city c LEFT JOIN " . DB_PREFIX . "econt_quarter q ON (c.city_id = q.city_id) LEFT JOIN " . DB_PREFIX . "econt_street s ON (c.city_id = s.city_id) WHERE TRIM(c.post_code) = '". $this->db->escape(trim($data['post_code'])) . "' AND (LCASE(TRIM(c.name)) = '" . $this->db->escape(utf8_strtolower(trim($data['city']))) . "' OR LCASE(TRIM(c.name_en)) = '" . $this->db->escape(utf8_strtolower(trim($data['city']))) . "')";

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
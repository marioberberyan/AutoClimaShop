<?php
#####################################################################################
#  Module TOTAL IMPORT PRO for Opencart 1.5.x From HostJars opencart.hostjars.com 	#
#####################################################################################

define('CRON_FETCH_NUM', 3);

class ModelToolTotalImport extends Model
{

	private $xml_product;
	private $xml_existing_fields = array();
	private $total_items_added = 0;
	private $total_items_updated = 0;
	private $total_items_missed = 0;	//wrong number of fields in CSV row
	private $total_items_ready = 0;		//in hj_import db ready for store import
	private $file_encoding = 'UTF-8';	//file encoding of input file
	private $cron_fetch = false;

	public function checkUpdates() {
		define('CURRENT_VERSION', 12);
		return 0;
		//$latest = @file_get_contents('http://demo.hostjars.com/version.php?mod=TotalImportPRO');
	}

	public function getNumItemsInFeed() {
		return $this->db->query('SELECT COUNT(*) FROM ' . DB_PREFIX . 'hj_import')->row['COUNT(*)'];
	}

    public function doesDatabaseExist() {
        $result = @$this->db->query('SELECT * FROM ' . DB_PREFIX . 'hj_import');
        return $result;
    }

	public function getExistingProducts($identifier='model') {
		$query = $this->db->query("SELECT " . $identifier . " FROM " . DB_PREFIX . "product");
		$prod_array = array();
		foreach ($query->rows as $row) {
			$prod_array[$row[$identifier]] = 0;
		}
		return $prod_array;
	}

	public function disableProduct($product_id) {
		$query = $this->db->query('UPDATE ' . DB_PREFIX . 'product SET status = 0 WHERE product_id = ' . (int)$product_id);
	}

	public function zeroQuantityProduct($product_id) {
		$query = $this->db->query('UPDATE ' . DB_PREFIX . 'product SET quantity = 0 WHERE product_id = ' . (int)$product_id);
	}

	public function getProductId($id_field, $id_value) {
		if ($id_field == 'name') {
			$query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product_description WHERE name = '" . $this->db->escape($id_value) . "'");
		} elseif ($id_field == 'product_id'){
			//verify it exists
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product WHERE  " . $this->db->escape($id_field) . " = '" . $this->db->escape($id_value) . "'");
		}
		else {
			$query = $this->db->query("SELECT product_id FROM " . DB_PREFIX . "product WHERE " . $this->db->escape($id_field) . " = '" . $this->db->escape($id_value) . "'");
		}
		return (isset($query->row['product_id'])) ?	$query->row['product_id'] : 0;
	}

	public function getManufacturerId($manufacturer_name) {
		$query = $this->db->query("SELECT manufacturer_id FROM " . DB_PREFIX . "manufacturer WHERE name = '" . $this->db->escape($manufacturer_name) . "'OR name = '" . $this->db->escape(htmlentities($manufacturer_name)) ."'");
		return (isset($query->row['manufacturer_id'])) ? $query->row['manufacturer_id'] : 0;
	}

	public function getCategoryId($category_name, $parentid) {
		$query = $this->db->query("SELECT c.category_id FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE (cd.name = '" . $this->db->escape($category_name) . "' OR cd.name = '" . $this->db->escape(htmlentities($category_name)) . "') AND c.parent_id = '" . (int)$parentid . "'");
		return (isset($query->row['category_id'])) ? $query->row['category_id'] : 0;
	}

	public function getDownloadIdByName($download_file) {
		$query = $this->db->query("SELECT d.download_id FROM " . DB_PREFIX . "download d LEFT JOIN " . DB_PREFIX . "download_description dd ON (d.download_id = dd.download_id) WHERE (dd.name = '" . $this->db->escape($download_file) . "' OR dd.name = '" . $this->db->escape(htmlentities($download_file)) . "')");
		return (isset($query->row['download_id'])) ? $query->row['download_id'] : 0;
	}

	public function getAttributeId($attribute_name, $attribute_group) {
		$query = $this->db->query("SELECT a.attribute_id FROM " . DB_PREFIX . "attribute a LEFT JOIN " . DB_PREFIX . "attribute_description ad ON (a.attribute_id = ad.attribute_id) WHERE ad.name = '" . $this->db->escape($attribute_name) . "' AND a.attribute_group_id = '" . (int)$attribute_group . "'");
		return (isset($query->row['attribute_id'])) ? $query->row['attribute_id'] : 0;
	}

	public function getAttributeGroupId($attribute_name) {
		$query = $this->db->query("SELECT attribute_group_id FROM " . DB_PREFIX . "attribute_group_description WHERE name = '" . $this->db->escape($attribute_name) . "'");
		return (isset($query->row['attribute_group_id'])) ? $query->row['attribute_group_id'] : 0;
	}

	public function getFilterNameId($filter_name, $filter_group) {

		$query = $this->db->query("SELECT f.filter_id FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_description fd ON (f.filter_id = fd.filter_id) WHERE fd.name = '" . $this->db->escape($filter_name) . "' AND f.filter_group_id = '" . (int)$filter_group . "'");

		return (isset($query->row['filter_id'])) ? $query->row['filter_id'] : 0;
	}

	public function getFilterGroupId($filter_name) {

		$query = $this->db->query("SELECT filter_group_id FROM " . DB_PREFIX . "filter_group_description WHERE name = '" . $this->db->escape($filter_name) . "'");

		return (isset($query->row['filter_group_id'])) ? $query->row['filter_group_id'] : 0;
	}

	public function getStockStatusId($status_name) {
		$query = $this->db->query("SELECT stock_status_id FROM " . DB_PREFIX . "stock_status WHERE name = '" . $this->db->escape($status_name) . "'");
		return (isset($query->row['stock_status_id'])) ? $query->row['stock_status_id'] : 0;
	}

	public function getOptions($options) {
		$all_values = array();
		foreach ($options as $option) {
			if ($option) {
				$sql = 'SELECT `' . $option . '` FROM ' . DB_PREFIX . 'hj_import';
				$query = $this->db->query($sql);
				$values = array();
				$exists = array();
				foreach ($query->rows as $row) {
					$opt_values = explode('|', $row[$option]);
					foreach ($opt_values as $opt_value) {
						$opt_value_details = explode(':', $opt_value);
						if(!in_array($opt_value_details[0], $exists)) {
							if (count($opt_value_details) >= 4) { //we have a sort order & type
								if (!empty($opt_value_details[6])) {
									$option_types = array('checkbox', 'radio', 'select');
									$opt_value_type = (in_array($opt_value_details[6], $option_types)) ? $opt_value_details[6] : 'select';
								} else {
								    $opt_value_type = 'select';
								}
								$values[] = $opt_value_details[0] . '|' . $opt_value_details[4] . '|' . $opt_value_type;
								$exists[] = $opt_value_details[0];
							} else {
								$values[] = $opt_value_details[0];
								$exists[] = $opt_value_details[0];
							}
						}
					}
				}
				$all_values[$option] = array_unique($values);
			}
		}
		return $all_values;
	}

	public function getOptionIdByName($name) {
		$query = $this->db->query("SELECT option_id FROM " . DB_PREFIX . "option_description WHERE name='" . $this->db->escape($name) . "'");
		return (count($query->rows)) ? $query->rows[0]['option_id'] : 0;
	}

	public function getOptionValueIdByName($name, $option_id) {
		$query = $this->db->query("SELECT option_value_id FROM " . DB_PREFIX . "option_value_description WHERE name='" . $this->db->escape($name) . "' AND option_id='" . (int)$option_id . "'");
		return (count($query->rows)) ? $query->rows[0]['option_value_id'] : 0;
	}

	public function emptyTables($table_list=array()) {
		if (isset($table_list['product']) && $table_list['product']) {
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_attribute`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_description`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_discount`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_image`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_option`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_option_value`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_related`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_reward`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_special`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_to_category`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_to_download`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_to_layout`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_to_store`");
			if(version_compare($this->getVersion(), '1.5.4', '<')) {
	   			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_tag`");
	  		}

			if(version_compare($this->getVersion(), '1.5.5', '>=')) {
				$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "product_filter`");
			}

			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "review`");
			$query = $this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query LIKE 'product_id=%'");


			$this->cache->delete('product');
		}
		if (isset($table_list['attribute']) && $table_list['attribute']) {
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "attribute`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "attribute_description`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "attribute_group`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "attribute_group_description`");
		}
		if (isset($table_list['manufacturer']) && $table_list['manufacturer']) {
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "manufacturer`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "manufacturer_to_store`");
			$query = $this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query LIKE 'manufacturer_id=%'");

		}
		if (isset($table_list['category']) && $table_list['category']) {
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "category`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "category_description`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "category_to_layout`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "category_to_store`");
			if(version_compare($this->getVersion(), '1.5.5', '>=')) {
				$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "category_path`");
				$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "category_filter`");
			}
			$query = $this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE query LIKE 'category_id=%'");
		}
		if (isset($table_list['option']) && $table_list['option']) {
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "option`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "option_description`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "option_value`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "option_value_description`");
		}
		if (isset($table_list['download']) && $table_list['download']) {
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "download`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "download_description`");
		}
		if (isset($table_list['filter']) && $table_list['filter']) {
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "filter`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "filter_description`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "filter_group`");
			$query = $this->db->query("TRUNCATE TABLE `" . DB_PREFIX . "filter_group_description`");
		}
	}

	//Functions to adjust data on the way in:

	public function getOperations($hide_func=true) {
		$operations = array(
			'multiplyPrice' => array(
				'name' => $this->language->get('operation_multiply_price'),
				'function' => ($hide_func) ? '' : 'multiply',
				'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_multiply')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_by'))
				),
				'label' => $this->language->get('operation_label_most_popular'),
			),
			'addPrice' => array(
				'name' => $this->language->get('operation_add_price'),
				'function' => ($hide_func) ? '' : 'add',
				'inputs'=>array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_add')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_to'))
				),
				'label' => $this->language->get('operation_label_most_popular'),
			),
			'splitFieldsCategory' => array(
				'name' => $this->language->get('operation_split_fields_category'),
				'function' => ($hide_func) ? '' : 'splitFields',
				'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_split')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_on')),
				),
				'label' => $this->language->get('operation_label_most_popular'),
			),
			'appendImage' => array(
		   		'name' => $this->language->get('operation_append_image'),
		   		'function' => ($hide_func) ? '' : "appendText",
			   	'inputs'=>array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_append')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_after'))
				),
				'label' => $this->language->get('operation_label_most_popular'),
			),
			'prependImage' => array(
				'name' => $this->language->get('operation_prepend_image'),
				'function' => ($hide_func) ? '' : 'prependText',
				'inputs'=>array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_prepend')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_to'))
				),
				'label' => $this->language->get('operation_label_most_popular'),
			),
			'append' => array(
			  	'name' => $this->language->get('operation_append_text'),
				'function' => ($hide_func) ? '' : "appendText",
				'inputs'=>array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_append')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_after'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'prepend' => array(
				'name' => $this->language->get('operation_prepend_text'),
				'function' => ($hide_func) ? '' : 'prependText',
				'inputs'=>array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_prepend')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_to'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'multiply' => array(
				'name' => $this->language->get('operation_multiply_field'),
				'function' => ($hide_func) ? '' : 'multiply',
				'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_multiply')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_by'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'add' => array(
				'name' => $this->language->get('operation_add_field'),
				'function' => ($hide_func) ? '' : 'add',
				'inputs'=>array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_add'),),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_to'),)
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'splitFields' => array(
				'name' => $this->language->get('operation_split_fields'),
				'function' => ($hide_func) ? '' : 'splitFields',
				'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_split')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_on')),
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'replace' => array(
				'name'=> $this->language->get('operation_replace_text'),
		   		'function' => ($hide_func) ? '' : 'replaceText',
				'inputs'=>array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_replace')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_with')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_in'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'replaceNewLines' => array(
				'name'=> $this->language->get('operation_replace_newlines'),
		   		'function' => ($hide_func) ? '' : 'replaceNewLines',
				'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_in'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'remove' => array(
				'name'=> $this->language->get('operation_remove_text'),
		   		'function' => ($hide_func) ? '' : 'removeText',
				'inputs'=>array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_remove')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_in'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'deleteRow' => array(
		   		'name' => $this->language->get('operation_delete_row_equals'),
		   		'function' => ($hide_func) ? '' : 'deleteRowsWhere',
		   		'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_exclude_products')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_equals'))
				),
				'label' => $this->language->get('operation_label_most_popular'),
			),
			'deleteRowWhereNot' => array(
		   		'name' => $this->language->get('operation_delete_row_not_equal'),
		   		'function' => ($hide_func) ? '' : 'deleteRowsWhereNot',
		   		'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_exclude_products')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_does_not_equal'))
				),
				'label' => $this->language->get('operation_label_most_popular'),
			),
			'deleteRowContains' => array(
		   		'name' => $this->language->get('operation_delete_row_containing'),
		   		'function' => ($hide_func) ? '' : 'deleteRowsWhereContains',
		   		'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_exclude_products')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_contains'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'deleteRowWhereNotContains' => array(
		   		'name' => $this->language->get('operation_delete_row_not_containing'),
		   		'function' => ($hide_func) ? '' : 'deleteRowsWhereNotContains',
		   		'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_exclude_products')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_does_not_contain'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'duplicateField' => array(
				'name' => $this->language->get('operation_duplicate_feed'),
			   	'function' => ($hide_func) ? '' : 'duplicateField',
				'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_duplicate')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_to'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'mergeColumns' => array(
				'name' => $this->language->get('operation_merge_columns'),
			   	'function' => ($hide_func) ? '' : 'mergeColumns',
				'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_append')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_to')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_separated_by'))
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
			'mergeRows' => array(
				'name' => $this->language->get('operation_merge_rows'),
			   	'function' => ($hide_func) ? '' : 'mergeRows',
				'inputs'=>array(
					array('type'=>'field', 'prepend'=>$this->language->get('operation_common_field')),
					array('type'=>'field', 'prepend'=>$this->language->get('operation_merge_the_following'), 'option' => 'addMore'),
				),

				'label' => $this->language->get('operation_label_advanced'),
			),
			'customColumn' => array(
				'name' => $this->language->get('operation_custom_column'),
				'function' => ($hide_func) ? '' : 'customColumn',
				'inputs' => array(
					array('type'=>'text', 'prepend'=>$this->language->get('operation_column_name')),
					array('type'=>'text', 'prepend'=>$this->language->get('operation_column_value')),
				),
				'label' => $this->language->get('operation_label_advanced'),
			),
		);
		return $operations;
	}


	public function runAdjustments(&$adjustments) {
		$operations = $this->getOperations(false);
		foreach ($adjustments as $adjustment) {
			//ensure all adjustment values are decoder for operations
			$adjustment = array_map('html_entity_decode', $adjustment);
			$op_name = array_shift($adjustment);
			//run each adjustment
			if (is_callable(array($this, $operations[$op_name]['function']))) {
				$adjustment_fields = array();
				$adjustment_fields[] = $adjustment;
				if (!in_array($this->language->get('text_select'), $adjustment)) {
					call_user_func_array(array($this, $operations[$op_name]['function']), $adjustment_fields);
				}
			}
		}
	}

	/**
	 * @param (mixed) array(text to append to, field to adjust)
	 */
	public function appendText($adjustment) {
		$append_text = $adjustment[0];
		$field = $adjustment[1];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" .$field . "` = CONCAT( `" . $field . "`, '" . $this->db->escape($append_text) . "' ) WHERE `" .$field . "` != ''");
	}

	/**
	 * @param (mixed) array(text to prepend to, field to adjust)
	 */
	public function prependText($adjustment) {
		$prepend_text = $adjustment[0];
		$field = $adjustment[1];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $field . "` = CONCAT( '" . $this->db->escape($prepend_text) . "', `" . $field . "` ) WHERE `" .$field . "` != ''");
	}

	/**
	 * @param (mixed) array(text to remove, field to adjust)
	 */
	public function removeText($adjustment) {
		$remove_text = $adjustment[0];
		$field = $adjustment[1];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" .$field . "` = REPLACE( `" . $field . "`, '" . $this->db->escape($remove_text) . "', '' )");
	}

	/**
	 * @param (mixed) array(text to find, text to replace with, field to adjust)
	 */
	public function replaceText($adjustment) {
		$str = $adjustment[0];
		$replacement = $adjustment[1];
		$field = $adjustment[2];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $field . "` = REPLACE( `" . $field . "`, '" . $this->db->escape($str) . "', '" . $this->db->escape($replacement) . "' )");
	}

	/**
	* @param (mixed) array(field to adjust)
	*/
	public function replaceNewLines($adjustment) {
		$new_lines = array("\r\n", "\n", "\r");
		$replacement = "<br />";
		$field = $adjustment[0];
		foreach($new_lines as $str) {
			$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $field . "` = REPLACE( `" . $field . "`, '" . $this->db->escape($str) . "', '" . $this->db->escape($replacement) . "' )");
		}
	}

	/**
	* @param (mixed) array(field to adjust, multiplication factor)
	*/
	public function multiply($adjustment) {
		$field = $adjustment[0];
		$multiplier = $adjustment[1];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $field . "` = (`" . $field . "` * " . (float)$multiplier . " )");
	}

	/**
	* @param (mixed) array(field to  add value, adjust)
	*/
	public function add($adjustment) {
		$add = $adjustment[0];
		$field = $adjustment[1];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $field . "` = (`" . $field . "` + " . (float)$add . " )");
	}

	/**
	* @param (mixed) array(field to  adjust, new field)
	*/
	public function duplicateField($adjustment) {
		$field = $adjustment[0];
		$newfield = $adjustment[1];
		$this->db->query('ALTER TABLE ' . DB_PREFIX . "hj_import ADD `" . $newfield . "` BLOB");
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $newfield . "` = (`" . $field . "`)");
	}

	/**
	* @param (mixed) array(field to adjust)
	*/
	public function lowerCase($adjustment) {
		$field = $adjustment[0];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $field . "` = LCASE( `" . $field . "` )");
	}

	/**
	* @param (mixed) array(field to adjust)
	*/
	public function upperCase($adjustment) {
		$field = $adjustment[0];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $field . "` = UCASE( " . $field . " )");
	}

	/**
	* @param (mixed) array(field to adjust)
	*/
//	public function capitalize(&$adjust) {
//		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $adjust[0] . "` = CAP_FIRST( '" . $adjust[0] . "' )");
//	}

	/**
	* @param (mixed) array(field to adjust, text to look for)
	*/
	public function deleteRowsWhereContains($adjustment) {
		$field = $adjustment[0];
		$value = $adjustment[1];
		$this->db->query('DELETE FROM ' . DB_PREFIX . "hj_import WHERE `" . $field . "` LIKE '%" . $this->db->escape($value) . "%'");
	}

	/**
	* @param (mixed) array(field to adjust, text to look for)
	*/
	public function deleteRowsWhereNotContains($adjustment) {
		$field = $adjustment[0];
		$value = $adjustment[1];
		$this->db->query('DELETE FROM ' . DB_PREFIX . "hj_import WHERE `" . $field . "` NOT LIKE '%" . $this->db->escape($value) . "%'");
	}
	/**
	* @param (mixed) array(field to adjust, text to look for)
	*/
	public function deleteRowsWhere($adjustment) {
		$field = $adjustment[0];
		$value = $adjustment[1];
		$this->db->query('DELETE FROM ' . DB_PREFIX . "hj_import WHERE `" . $field . "` = '" . $this->db->escape($value) . "'");
	}

	/**
	* @param (mixed) array(field to adjust, text to look for)
	*/
	public function deleteRowsWhereNot($adjustment) {
		$field = $adjustment[0];
		$value = $adjustment[1];
		$this->db->query('DELETE FROM ' . DB_PREFIX . "hj_import WHERE `" . $field . "` != '" . $this->db->escape($value) . "'");
	}

	/**
	* @param (mixed) array(field to adjust, text to look for)
	*/
	public function mergeColumns($adjustment) {
		$field1 = $adjustment[0];
		$field2 = $adjustment[1];
		$separator = $adjustment[2];
		$this->db->query('UPDATE ' . DB_PREFIX . "hj_import SET `" . $field2 . "` = CONCAT(`" . $field2 . "`, '" . $this->db->escape($separator) . "', `" . $field1 . "`)");
	}

	public function customColumn($adjustment)
	{
		$column_name = $adjustment[0];
		$column_value = $adjustment[1];
		if (!$this->columnExists(DB_PREFIX.'hj_import', $column_name))
			$this->alterImportTable(array($column_name));
		$sql = 'UPDATE '.DB_PREFIX.'hj_import SET `'.$this->db->escape($column_name).'` = \''.$this->db->escape($column_value).'\'';
		$this->db->query($sql);
	}


	/**
	* @param (mixed) array(field to adjust, text to look for)
	*/
	public function mergeRows($adjustment) {
		$common_field = array_shift($adjustment);

		//get all unique product id's
		$sql = 'SELECT DISTINCT `' . $this->db->escape($common_field) . '` FROM ' . DB_PREFIX . 'hj_import ORDER BY `' . $this->db->escape($common_field) . '` DESC';
		$query = $this->db->query($sql);
		foreach($query->rows as $model) {
			$unique_products[] = $model[$common_field];
		}
		foreach($unique_products as $unique) {
			//get each of the adjustment values and concatonate
			$sql = 'SELECT *, ';
			foreach($adjustment as $adjust) {
				$sql .= "GROUP_CONCAT(`".$this->db->escape($adjust) . "` SEPARATOR '|') as `" . $this->db->escape($adjust) . "`, ";
			}
			$sql = substr($sql, 0, -2);
			$sql .= " FROM `" . DB_PREFIX ."hj_import` WHERE  `" .$this->db->escape($common_field)."`='". $this->db->escape($unique) ."' GROUP BY `". $this->db->escape($common_field) . "`";
			$query = $this->db->query($sql);

			$current_products = $query->row;

			//update the first product with the set sku
			$sql = 'UPDATE `' . DB_PREFIX . "hj_import` SET ";
			foreach($adjustment as $adjust) {
				$sql .= "`" . $this->db->escape($adjust) . "` = '". $this->db->escape($current_products[$adjust]) . "', ";
			}
			$sql = substr($sql, 0, -2);
			$sql .= " WHERE `hj_id` = '" . $this->db->escape($current_products['hj_id']) . "'";
			$query = $this->db->query($sql);

			//remove all additional products
			$sql = 'DELETE FROM `' . DB_PREFIX . "hj_import` WHERE ";
			$sql .= "`hj_id` != '" . $this->db->escape($current_products['hj_id']) . "' AND `". $this->db->escape($common_field) . "` = '" . $this->db->escape($unique) . "'";
			$query = $this->db->query($sql);
		}

	}

	public function getNextProductOrdered($start, $update_column) {
		$query = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'hj_import ORDER BY ' . $this->db->escape($update_column) . ' DESC LIMIT ' . (int)$start . ', 1');
		return (isset($query->row)) ? $query->row : 0;
	}

	/**
	* @param (mixed) array(field name, separator to split on, and new column prefix)
	*/
	public function splitFields($adjustment) {
		$field1 = $adjustment[0];
		$separator = $adjustment[1];

		//get the max number of columns required
		$sql = 'SELECT MAX(LENGTH(`' . $field1 . "`) - LENGTH(REPLACE(`" . $field1 . "`, '" . $separator . "', ''))) AS 'new_columns' FROM `" . DB_PREFIX . "hj_import`";
		$query = $this->db->query($sql);
		$new_columns = $query->row['new_columns'] + 1;

		//create the new columns
		for($i = 1; $i <= $new_columns; $i++){
			$new_field = $field1 . "_split_" . $i;
			if(!$this->columnExists(DB_PREFIX . 'hj_import', $new_field)) {
				$new_field = array($new_field);
				$this->alterImportTable($new_field);
			}
		}

		//update each column with the correct values
		$sql = 'SELECT `hj_id`, `' . $field1 . '` FROM `' . DB_PREFIX . 'hj_import`';
		$query = $this->db->query($sql);
		foreach($query->rows as $row) {
			$values = explode($separator, $row[$field1]);
			//create the new columns
			for($i = 1; $i <= count($values); $i++){
				$new_field = $field1 . "_split_" . $i;
				$sql = 'UPDATE `' . DB_PREFIX . "hj_import` SET `" . $this->db->escape($new_field) . "` = '". $this->db->escape($values[$i-1]) . "' WHERE `hj_id` = '" . $this->db->escape($row['hj_id']) . "'";
				$query = $this->db->query($sql);
			}
		}
	}

	//Internal database table functions:

	public function createDeleteDiffTable($update_field, $settings) {
		$this->db->query('DROP TABLE IF EXISTS ' . DB_PREFIX . 'hj_existing_prods');

		$sql = 'CREATE TABLE ' . DB_PREFIX . 'hj_existing_prods (product_id INT(11) AUTO_INCREMENT, product_id_field VARCHAR(64), PRIMARY KEY (product_id))';
		$query = $this->db->query($sql);

		$sql = "SELECT p.product_id, " . $update_field . " FROM `" . DB_PREFIX . "product` p";

		if (isset($settings['store'])) {
			$sql .= " JOIN  `" . DB_PREFIX . "product_to_store` ps ON p.product_id = ps.product_id WHERE ps.store_id IN (";
			$store_id_array = array();
			foreach ($settings['store'] as $key => $store_id) {
				$store_id_array[] = $store_id;
			}
			$sql .= implode(', ', $store_id_array);
			$sql .= ")";
		}

		$existing = $this->db->query($sql);

		if (isset($existing->rows)) {
			$sql = 'INSERT INTO ' . DB_PREFIX . 'hj_existing_prods (product_id, product_id_field) VALUES (' . $existing->rows[0]['product_id'] . ', \'' . $existing->rows[0][$update_field] . '\')';

			$num_prods = count($existing->rows);
			for ($i = 1; $i < $num_prods; $i++) {
				$sql .= ', (' . $existing->rows[$i]['product_id'] . ', \'' . $existing->rows[$i][$update_field] . '\')';
				// The maximum number of rows allowed in one VALUES clause is 1000 so run the query every 1000 prods
				if ($i % 999 == 0) {
					$this->db->query($sql);
					$i++;
					$sql = 'INSERT INTO ' . DB_PREFIX . 'hj_existing_prods (product_id, product_id_field) VALUES (' . $existing->rows[$i]['product_id'] . ', \'' . $existing->rows[$i][$update_field] . '\')';
				}
			}
			$this->db->query($sql);
		}
	}

	public function deleteExistingProdHash($prod_hash) {
		$this->db->query('DELETE FROM ' . DB_PREFIX . 'hj_existing_prods WHERE product_id_field=\'' . $prod_hash .'\'');
	}

	public function getExistingProds() {
		$query = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'hj_existing_prods');
		return isset($query->rows) ? $query->rows : '';
	}


	public function createEmptyTable($headings) {
		$this->db->query('DROP TABLE IF EXISTS ' . DB_PREFIX . 'hj_import');
		$sql = 'CREATE TABLE ' . DB_PREFIX . 'hj_import (hj_id INT(11) AUTO_INCREMENT, ';
		foreach ($headings as $heading) {
			$sql .= "`" . $heading . "` BLOB, ";
		}
		$sql .= 'PRIMARY KEY (hj_id))';
		$query = $this->db->query($sql);
	}

	public function alterImportTable($new_fields) {
		if (!empty($new_fields)) {
			$sql = "ALTER TABLE " . DB_PREFIX . "hj_import ADD COLUMN ";
			$fields_sql = array();
			foreach ($new_fields as $field) {
				$fields_sql[] = '`' . $this->db->escape($field) . "` BLOB NOT NULL ";
			}
			$sql .= '(' . $this->db->escape(implode(', ', $fields_sql)) . ')';
			$sql = str_replace(', )', ')', $sql);
			$this->db->query($sql);
		}
	}

	public function columnExists($table, $column_name){
		$sql = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = '" . $table . "' AND TABLE_SCHEMA = '" . DB_DATABASE . "'
		AND COLUMN_NAME = '" . $column_name . "'";
		$query = $this->db->query($sql);
		return (isset($query->row['COLUMN_NAME']) && $query->row['COLUMN_NAME'] == $column_name) ? true : false;
	}

	public function dbReady() {
		$query = $this->db->query("SHOW TABLES WHERE `Tables_in_" . DB_DATABASE . "` = '" . DB_PREFIX . "hj_import'");
		return ($query->num_rows == 1);
	}

	public function presetFeedsExist() {
		$query = $this->db->query("SHOW TABLES WHERE `Tables_in_" . DB_DATABASE . "` = '" . DB_PREFIX . "hj_preset_settings'");
		return ($query->num_rows == 1);
	}

	public function insertProduct($product) {
		$sql = 'INSERT INTO ' . DB_PREFIX . 'hj_import SET ';
		$values = array();
		foreach ($product as $key => $value) {
			if($this->file_encoding != 'UTF-8') {
				$value = iconv($this->file_encoding, 'UTF-8//TRANSLIT', $value);
				$key = iconv($this->file_encoding, 'UTF-8//TRANSLIT', $key);
			}
			$key = trim($key);
			$value = trim($value);
			$values[] = '`' . $key . "`='" . $this->db->escape($value) . "'";
		}
		$sql .= implode(',', $values);
		$query = $this->db->query($sql);
	}

	public function getNextProduct($start=0) {
		$query = $this->db->query('SELECT * FROM ' . DB_PREFIX . 'hj_import LIMIT ' . (int)$start . ', 1');
		return $query->row;
	}

	public function addPresetProfile($profile_name, $profile_settings) {
		$this->db->query('DELETE FROM ' . DB_PREFIX . "hj_preset_settings WHERE `group` = '" . $this->db->escape($profile_name) . "'");

		foreach ($profile_settings as $setting_name => $setting_data) {
			$this->db->query('INSERT INTO ' . DB_PREFIX . "hj_preset_settings SET `group` = '" . $this->db->escape($profile_name) . "', `step` = '" . $this->db->escape(substr($setting_name, 11, 1)) . "', `name` = '" . $this->db->escape($setting_name) . "', `value` = '" . $this->db->escape($setting_data) . "'");
		}
	}

	public function createPresetTable() {
		$this->db->query('CREATE TABLE IF NOT EXISTS ' . DB_PREFIX . 'hj_preset_settings (`id` INT(11) AUTO_INCREMENT, `group` VARCHAR(255), `step` INT(11), `name` BLOB, `value` BLOB, PRIMARY KEY (id))');

		$chinabuye_settings = array(
			'import_step1_file_encoding' => 's:5:"UTF-8";',
			'import_step1_has_headers' => 's:2:"on";',
			'import_step1_pass_basicauth' => 's:0:"";',
			'import_step1_user_basicauth' => 's:0:"";',
			'import_step1_delimiter' => 's:1:",";',
			'import_step1_xml_product_tag' => 's:4:"item";',
			'import_step1_format' => 's:3:"xml";',
			'import_step1_feed_filepath' => 's:0:"";',
			'import_step1_feed_ftppath' => 's:0:"";',
			'import_step1_feed_ftppass' => 's:0:"";',
			'import_step1_feed_ftpuser' => 's:0:"";',
			'import_step1_feed_ftpserver' => 's:0:"";',
			'import_step1_source' => 's:4:"file";',
			'import_step1_step' => 's:12:"import_step1";',
			'import_step2_store' => 'a:1:{i:0;s:1:"0";}',
			'import_step2_image_subfolder' => 's:9:"chinabuye";',
			'import_step2_remote_images' => 's:1:"1";',
			'import_step2_related_field' => 's:10:"product_id";',
			'import_step2_split_category' => 's:1:"^";',
			'import_step2_bottom_category_only' => 's:1:"0";',
			'import_step2_top_categories' => 's:1:"0";',
			'import_step2_customer_group_ids' => 'a:1:{s:7:"default";s:1:"1";}',
			'import_step2_customer_group' => 's:1:"1";',
			'import_step2_length_class' => 's:1:"1";',
			'import_step2_tax_class' => 's:1:"0";',
			'import_step2_weight_class' => 's:1:"1";',
			'import_step2_product_status' => 's:1:"1";',
			'import_step2_minimum_quantity' => 's:1:"1";',
			'import_step2_requires_shipping' => 's:1:"1";',
			'import_step2_subtract_stock' => 's:1:"1";',
			'import_step2_out_of_stock_status' => 's:1:"6";',
			'import_step2_step' => 's:12:"import_step2";',
			'import_step2_language' => 'a:1:{i:0;s:1:"1";}',
			'import_step3_step' => 's:12:"import_step3";',
			'import_step3_adjust' => 'a:1:{i:2;a:3:{i:0;s:11:"splitFields";i:1;s:6:"images";i:2;s:1:"^";}}',
			'import_step4_step' => 's:12:"import_step4";',
			'import_step4_simple' => 's:1:"0";',
			'import_step4_simple_names' => 'a:10:{s:8:"quantity";s:0:"";s:5:"price";s:0:"";s:6:"status";s:0:"";s:15:"product_special";a:1:{i:0;s:0:"";}s:5:"model";s:0:"";s:3:"sku";s:0:"";s:3:"ean";s:0:"";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";}',
			'import_step4_field_names' => 'a:41:{s:4:"name";a:1:{i:1;s:4:"name";}s:11:"description";a:1:{i:1;s:11:"description";}s:3:"tag";a:1:{i:1;s:0:"";}s:10:"meta_title";a:1:{i:1;s:0:"";}s:16:"meta_description";a:1:{i:1;s:0:"";}s:12:"meta_keyword";a:1:{i:1;s:0:"";}s:5:"model";s:0:"";s:3:"sku";s:3:"sku";s:3:"upc";s:0:"";s:3:"ean";s:0:"";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";s:8:"location";s:0:"";s:5:"price";s:5:"Price";s:8:"quantity";s:0:"";s:7:"minimum";s:0:"";s:8:"subtract";s:0:"";s:8:"shipping";s:0:"";s:7:"keyword";s:0:"";s:12:"stock_status";s:0:"";s:5:"image";s:14:"images_split_1";s:6:"length";s:0:"";s:6:"height";s:0:"";s:5:"width";s:0:"";s:6:"weight";s:6:"weight";s:6:"status";s:0:"";s:10:"sort_order";s:0:"";s:12:"manufacturer";s:0:"";s:8:"category";a:1:{i:0;a:1:{i:0;s:13:"category_name";}}s:8:"download";a:1:{i:0;s:0:"";}s:15:"product_related";s:0:"";s:6:"filter";a:1:{i:0;s:0:"";}s:17:"product_attribute";a:1:{i:1;s:0:"";}s:14:"product_option";a:1:{i:1;s:0:"";}s:16:"product_discount";a:1:{i:0;s:0:"";}s:15:"product_special";a:1:{i:0;s:0:"";}s:13:"product_image";a:18:{i:0;s:14:"images_split_2";i:1;s:14:"images_split_3";i:2;s:14:"images_split_4";i:3;s:14:"images_split_5";i:4;s:14:"images_split_6";i:5;s:14:"images_split_7";i:6;s:14:"images_split_8";i:7;s:14:"images_split_9";i:8;s:15:"images_split_10";i:9;s:15:"images_split_11";i:10;s:15:"images_split_12";i:11;s:15:"images_split_13";i:12;s:15:"images_split_14";i:13;s:15:"images_split_15";i:14;s:15:"images_split_16";i:15;s:15:"images_split_17";i:16;s:15:"images_split_18";i:17;s:15:"images_split_19";}s:6:"points";s:0:"";s:14:"product_reward";s:0:"";s:6:"layout";a:1:{i:0;s:0:"";}}',
			'import_step5_import_range' => 's:3:"all";',
			'import_step5_delete_diff' => 's:6:"ignore";',
			'import_step5_update_field' => 's:3:"sku";',
			'import_step5_existing_items' => 's:6:"update";',
			'import_step5_new_items' => 's:3:"add";',
			'import_step5_step' => 's:12:"import_step5";',
			'import_step5_save_settings_name' => 's:9:"Chinabuye";',
		);

		$sexshop365_settings = array(
			'import_step1_feed_ftppath' => 's:0:"";',
			'import_step1_feed_filepath' => 's:0:"";',
			'import_step1_format' => 's:3:"csv";',
			'import_step1_xml_product_tag' => 's:7:"product";',
			'import_step1_delimiter' => 's:1:"|";',
			'import_step1_user_basicauth' => 's:0:"";',
			'import_step1_pass_basicauth' => 's:0:"";',
			'import_step1_has_headers' => 's:2:"on";',
			'import_step1_file_encoding' => 's:5:"UTF-8";',
			'import_step1_feed_ftppass' => 's:0:"";',
			'import_step1_feed_ftpuser' => 's:0:"";',
			'import_step1_feed_ftpserver' => 's:0:"";',
			'import_step1_feed_url' => 's:0:"";',
			'import_step1_source' => 's:4:"file";',
			'import_step1_step' => 's:12:"import_step1";',
			'import_step2_language' => 'a:1:{i:0;s:1:"1";}',
			'import_step2_store' => 'a:1:{i:0;s:1:"0";}',
			'import_step2_image_subfolder' => 's:10:"sexshop365";',
			'import_step2_remote_images' => 's:1:"0";',
			'import_step2_split_related' => 's:0:"";',
			'import_step2_related_field' => 's:10:"product_id";',
			'import_step2_split_category' => 's:5:"-&gt;";',
			'import_step2_bottom_category_only' => 's:1:"0";',
			'import_step2_top_categories' => 's:1:"0";',
			'import_step2_customer_group' => 's:1:"1";',
			'import_step2_customer_group_ids' => 'a:1:{s:7:"default";s:1:"1";}',
			'import_step2_tax_class' => 's:1:"0";',
			'import_step2_length_class' => 's:1:"1";',
			'import_step2_weight_class' => 's:1:"1";',
			'import_step2_product_status' => 's:1:"1";',
			'import_step2_minimum_quantity' => 's:1:"1";',
			'import_step2_requires_shipping' => 's:1:"1";',
			'import_step2_subtract_stock' => 's:1:"1";',
			'import_step2_out_of_stock_status' => 's:1:"6";',
			'import_step2_step' => 's:12:"import_step2";',
			'import_step3_adjust' => 'a:15:{i:1;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:17:"Product Thumbnail";}i:2;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:17:"Product Big Image";}i:3;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:19:"Small Multi Image 1";}i:4;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:19:"Small Multi Image 2";}i:5;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:19:"Small Multi Image 3";}i:6;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:19:"Small Multi Image 4";}i:7;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:17:"Big Multi Image 1";}i:8;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:17:"Big Multi Image 2";}i:9;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:17:"Big Multi Image 3";}i:10;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:8:"XL Image";}i:11;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:10:"XL Image 2";}i:12;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:10:"XL Image 3";}i:13;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:10:"XL Image 4";}i:14;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:10:"XL Image 5";}i:15;a:3:{i:0;s:7:"prepend";i:1;s:5:"data/";i:2;s:5:"Image";}}',
			'import_step3_step' => 's:12:"import_step3";',
			'import_step4_field_names' => 'a:41:{s:4:"name";a:1:{i:1;s:4:"Name";}s:11:"description";a:1:{i:1;s:11:"Description";}s:3:"tag";a:1:{i:1;s:0:"";}s:10:"meta_title";a:1:{i:1;s:0:"";}s:16:"meta_description";a:1:{i:1;s:0:"";}s:12:"meta_keyword";a:1:{i:1;s:0:"";}s:5:"model";s:5:"Model";s:3:"sku";s:0:"";s:3:"upc";s:0:"";s:3:"ean";s:12:"Products EAN";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";s:8:"location";s:0:"";s:5:"price";s:0:"";s:8:"quantity";s:0:"";s:7:"minimum";s:0:"";s:8:"subtract";s:0:"";s:8:"shipping";s:0:"";s:7:"keyword";s:0:"";s:12:"stock_status";s:0:"";s:5:"image";s:5:"Image";s:6:"length";s:0:"";s:6:"height";s:0:"";s:5:"width";s:13:"Product Width";s:6:"weight";s:12:"Weight in Kg";s:6:"status";s:0:"";s:10:"sort_order";s:0:"";s:12:"manufacturer";s:0:"";s:8:"category";a:1:{i:0;a:1:{i:0;s:13:"Category List";}}s:8:"download";a:1:{i:0;s:0:"";}s:15:"product_related";s:0:"";s:6:"filter";a:1:{i:0;s:0:"";}s:17:"product_attribute";a:1:{i:1;s:10:"Controller";}s:14:"product_option";a:1:{i:1;s:0:"";}s:16:"product_discount";a:1:{i:0;s:0:"";}s:15:"product_special";a:1:{i:0;s:0:"";}s:13:"product_image";a:12:{i:0;s:19:"Small Multi Image 1";i:1;s:19:"Small Multi Image 2";i:2;s:19:"Small Multi Image 3";i:3;s:19:"Small Multi Image 4";i:4;s:17:"Big Multi Image 1";i:5;s:17:"Big Multi Image 2";i:6;s:17:"Big Multi Image 3";i:7;s:8:"XL Image";i:8;s:10:"XL Image 2";i:9;s:10:"XL Image 3";i:10;s:10:"XL Image 4";i:11;s:10:"XL Image 5";}s:6:"points";s:0:"";s:14:"product_reward";s:0:"";s:6:"layout";a:1:{i:0;s:0:"";}}',
			'import_step4_simple_names' => 'a:10:{s:8:"quantity";s:0:"";s:5:"price";s:0:"";s:6:"status";s:0:"";s:15:"product_special";a:1:{i:0;s:0:"";}s:5:"model";s:0:"";s:3:"sku";s:0:"";s:3:"ean";s:0:"";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";}',
			'import_step4_simple' => 's:1:"0";',
			'import_step4_step' => 's:12:"import_step4";',
			'import_step5_import_range' => 's:3:"all";',
			'import_step5_update_field' => 's:5:"model";',
			'import_step5_delete_diff' => 's:6:"ignore";',
			'import_step5_existing_items' => 's:6:"update";',
			'import_step5_new_items' => 's:3:"add";',
			'import_step5_save_settings_name' => 's:10:"Sexshop365";',
			'import_step5_step' => 's:12:"import_step5";',
		);

		$pixmaniapro_settings = array(
			'import_step1_file_encoding' => 's:5:"UTF-8";',
			'import_step1_has_headers' => 's:2:"on";',
			'import_step1_pass_basicauth' => 's:0:"";',
			'import_step1_user_basicauth' => 's:0:"";',
			'import_step1_delimiter' => 's:1:";";',
			'import_step1_xml_product_tag' => 's:7:"product";',
			'import_step1_format' => 's:3:"csv";',
			'import_step1_feed_filepath' => 's:0:"";',
			'import_step1_feed_ftppath' => 's:0:"";',
			'import_step1_feed_ftppass' => 's:0:"";',
			'import_step1_feed_ftpuser' => 's:0:"";',
			'import_step1_feed_ftpserver' => 's:0:"";',
			'import_step1_feed_url' => 's:0:"";',
			'import_step1_source' => 's:4:"file";',
			'import_step1_step' => 's:12:"import_step1";',
			'import_step2_language' => 'a:1:{i:0;s:1:"1";}',
			'import_step2_store' => 'a:1:{i:0;s:1:"0";}',
			'import_step2_related_field' => 's:10:"product_id";',
			'import_step2_image_subfolder' => 's:11:"pixmaniapro";',
			'import_step2_remote_images' => 's:1:"1";',
			'import_step2_split_related' => 's:0:"";',
			'import_step2_split_category' => 's:0:"";',
			'import_step2_bottom_category_only' => 's:1:"0";',
			'import_step2_top_categories' => 's:1:"0";',
			'import_step2_customer_group_ids' => 'a:1:{s:7:"default";s:1:"1";}',
			'import_step2_customer_group' => 's:1:"1";',
			'import_step2_tax_class' => 's:1:"0";',
			'import_step2_length_class' => 's:1:"1";',
			'import_step2_weight_class' => 's:1:"1";',
			'import_step2_product_status' => 's:1:"1";',
			'import_step2_minimum_quantity' => 's:1:"1";',
			'import_step2_subtract_stock' => 's:1:"1";',
			'import_step2_requires_shipping' => 's:1:"1";',
			'import_step2_step' => 's:12:"import_step2";',
			'import_step2_out_of_stock_status' => 's:1:"6";',
			'import_step3_step' => 's:12:"import_step3";',
			'import_step4_step' => 's:12:"import_step4";',
			'import_step4_simple' => 's:1:"0";',
			'import_step4_simple_names' => 'a:10:{s:8:"quantity";s:0:"";s:5:"price";s:0:"";s:6:"status";s:0:"";s:15:"product_special";a:1:{i:0;s:0:"";}s:5:"model";s:0:"";s:3:"sku";s:0:"";s:3:"ean";s:0:"";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";}',
			'import_step4_field_names' => 'a:41:{s:4:"name";a:1:{i:1;s:5:"Label";}s:11:"description";a:1:{i:1;s:11:"Description";}s:3:"tag";a:1:{i:1;s:0:"";}s:10:"meta_title";a:1:{i:1;s:0:"";}s:16:"meta_description";a:1:{i:1;s:0:"";}s:12:"meta_keyword";a:1:{i:1;s:0:"";}s:5:"model";s:22:"Manufacturer Reference";s:3:"sku";s:10:"PIXpro SKU";s:3:"upc";s:0:"";s:3:"ean";s:3:"EAN";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";s:8:"location";s:0:"";s:5:"price";s:5:"Price";s:8:"quantity";s:0:"";s:7:"minimum";s:0:"";s:8:"subtract";s:0:"";s:8:"shipping";s:0:"";s:7:"keyword";s:0:"";s:12:"stock_status";s:0:"";s:5:"image";s:7:"Picture";s:6:"length";s:0:"";s:6:"height";s:0:"";s:5:"width";s:0:"";s:6:"weight";s:6:"Weight";s:6:"status";s:0:"";s:10:"sort_order";s:0:"";s:12:"manufacturer";s:5:"Brand";s:8:"category";a:1:{i:0;a:1:{i:0;s:11:"﻿Category";}}s:8:"download";a:1:{i:0;s:0:"";}s:15:"product_related";s:0:"";s:6:"filter";a:1:{i:0;s:0:"";}s:17:"product_attribute";a:1:{i:1;s:0:"";}s:14:"product_option";a:1:{i:1;s:0:"";}s:16:"product_discount";a:1:{i:0;s:0:"";}s:15:"product_special";a:1:{i:0;s:0:"";}s:13:"product_image";a:1:{i:0;s:0:"";}s:6:"points";s:0:"";s:14:"product_reward";s:0:"";s:6:"layout";a:1:{i:0;s:0:"";}}',
			'import_step5_import_range' => 's:3:"all";',
			'import_step5_delete_diff' => 's:6:"ignore";',
			'import_step5_update_field' => 's:3:"sku";',
			'import_step5_existing_items' => 's:6:"update";',
			'import_step5_new_items' => 's:3:"add";',
			'import_step5_save_settings_name' => 's:11:"Pixmaniapro";',
			'import_step5_step' => 's:12:"import_step5";',
		);

		/*
		$chinavision_settings = array(
			'import_step1_pass_basicauth' => 's:0:"";',
			'import_step1_has_headers' => 's:2:"on";',
			'import_step1_file_encoding' => 's:5:"UTF-8";',
			'import_step1_user_basicauth' => 's:0:"";',
			'import_step1_delimiter' => 's:1:",";',
			'import_step1_format' => 's:3:"csv";',
			'import_step1_feed_filepath' => 's:0:"";',
			'import_step1_feed_ftppath' => 's:0:"";',
			'import_step1_feed_ftppass' => 's:0:"";',
			'import_step1_feed_ftpuser' => 's:0:"";',
			'import_step1_feed_ftpserver' => 's:0:"";',
			'import_step1_step' => 's:12:"import_step1";',
			'import_step1_source' => 's:4:"file";',
			'import_step2_language' => 'a:1:{i:0;s:1:"1";}',
			'import_step2_store' => 'a:1:{i:0;s:1:"0";}',
			'import_step2_image_subfolder' => 's:11:"chinavision";',
			'import_step2_remote_images' => 's:1:"1";',
			'import_step2_related_field' => 's:3:"sku";',
			'import_step2_bottom_category_only' => 's:1:"0";',
			'import_step2_split_related' => 's:1:";";',
			'import_step2_tax_class' => 's:1:"0";',
			'import_step2_top_categories' => 's:1:"0";',
			'import_step2_customer_group_ids' => 'a:1:{s:7:"default";s:1:"1";}',
			'import_step2_customer_group' => 's:1:"1";',
			'import_step2_length_class' => 's:1:"1";',
			'import_step2_weight_class' => 's:1:"1";',
			'import_step2_product_status' => 's:1:"1";',
			'import_step2_minimum_quantity' => 's:1:"1";',
			'import_step2_requires_shipping' => 's:1:"1";',
			'import_step2_subtract_stock' => 's:1:"1";',
			'import_step2_out_of_stock_status' => 's:1:"6";',
			'import_step2_step' => 's:12:"import_step2";',
			'import_step3_step' => 's:12:"import_step3";',
			'import_step4_step' => 's:12:"import_step4";',
			'import_step4_simple' => 's:1:"0";',
			'import_step4_simple_names' => 'a:10:{s:8:"quantity";s:0:"";s:5:"price";s:0:"";s:6:"status";s:0:"";s:15:"product_special";a:1:{i:0;s:0:"";}s:5:"model";s:0:"";s:3:"sku";s:0:"";s:3:"ean";s:0:"";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";}',
			'import_step4_field_names' => 'a:41:{s:4:"name";a:1:{i:1;s:17:"Full Product Name";}s:11:"description";a:1:{i:1;s:31:"Full Product Description Part 1";}s:3:"tag";a:1:{i:1;s:0:"";}s:10:"meta_title";a:1:{i:1;s:18:"Short Product Name";}s:16:"meta_description";a:1:{i:1;s:17:"Short Description";}s:12:"meta_keyword";a:1:{i:1;s:0:"";}s:5:"model";s:0:"";s:3:"sku";s:10:"Product ID";s:3:"upc";s:0:"";s:3:"ean";s:3:"EAN";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";s:8:"location";s:0:"";s:5:"price";s:12:"Retail Price";s:8:"quantity";s:0:"";s:7:"minimum";s:0:"";s:8:"subtract";s:0:"";s:8:"shipping";s:0:"";s:7:"keyword";s:0:"";s:12:"stock_status";s:0:"";s:5:"image";s:20:"Main Product Picture";s:6:"length";s:0:"";s:6:"height";s:9:"Height mm";s:5:"width";s:8:"Width mm";s:6:"weight";s:9:"Weight Kg";s:6:"status";s:0:"";s:10:"sort_order";s:0:"";s:12:"manufacturer";s:0:"";s:8:"category";a:1:{i:0;a:2:{i:0;s:13:"Category Name";i:1;s:16:"Subcategory Name";}}s:8:"download";a:1:{i:0;s:0:"";}s:15:"product_related";s:16:"Related Products";s:6:"filter";a:1:{i:0;s:0:"";}s:17:"product_attribute";a:1:{i:1;s:0:"";}s:14:"product_option";a:1:{i:1;s:0:"";}s:16:"product_discount";a:1:{i:0;s:0:"";}s:15:"product_special";a:1:{i:0;s:0:"";}s:13:"product_image";a:10:{i:0;s:28:"Additional Product Picture 1";i:1;s:28:"Additional Product Picture 2";i:2;s:28:"Additional Product Picture 3";i:3;s:28:"Additional Product Picture 4";i:4;s:28:"Additional Product Picture 5";i:5;s:28:"Additional Product Picture 6";i:6;s:28:"Additional Product Picture 7";i:7;s:28:"Additional Product Picture 8";i:8;s:28:"Additional Product Picture 9";i:9;s:29:"Additional Product Picture 10";}s:6:"points";s:0:"";s:14:"product_reward";s:0:"";s:6:"layout";a:1:{i:0;s:0:"";}}',
			'import_step5_import_range' => 's:3:"all";',
			'import_step5_delete_diff' => 's:6:"ignore";',
			'import_step5_update_field' => 's:3:"sku";',
			'import_step5_existing_items' => 's:6:"update";',
			'import_step5_new_items' => 's:3:"add";',
			'import_step5_save_settings_name' => 's:11:"Chinavision";',
			'import_step5_step' => 's:12:"import_step5";',
		);

		$overstock_settings = array(
			'import_step1_has_headers' => 's:2:"on";',
			'import_step1_file_encoding' => 's:5:"UTF-8";',
			'import_step1_pass_basicauth' => 's:0:"";',
			'import_step1_delimiter' => 's:1:",";',
			'import_step1_user_basicauth' => 's:0:"";',
			'import_step1_format' => 's:3:"csv";',
			'import_step1_xml_product_tag' => 's:4:"item";',
			'import_step1_feed_filepath' => 's:0:"";',
			'import_step1_feed_ftppath' => 's:0:"";',
			'import_step1_feed_ftppass' => 's:0:"";',
			'import_step1_feed_ftpuser' => 's:0:"";',
			'import_step1_feed_ftpserver' => 's:0:"";',
			'import_step1_step' => 's:12:"import_step1";',
			'import_step1_source' => 's:4:"file";',
			'import_step2_language' => 'a:1:{i:0;s:1:"1";}',
			'import_step2_store' => 'a:1:{i:0;s:1:"0";}',
			'import_step2_image_subfolder' => 's:9:"overstock";',
			'import_step2_remote_images' => 's:1:"1";',
			'import_step2_split_related' => 's:0:"";',
			'import_step2_related_field' => 's:3:"sku";',
			'import_step2_split_category' => 's:0:"";',
			'import_step2_bottom_category_only' => 's:1:"0";',
			'import_step2_top_categories' => 's:1:"0";',
			'import_step2_customer_group' => 's:1:"1";',
			'import_step2_customer_group_ids' => 'a:1:{s:7:"default";s:1:"1";}',
			'import_step2_tax_class' => 's:1:"0";',
			'import_step2_length_class' => 's:1:"1";',
			'import_step2_weight_class' => 's:1:"1";',
			'import_step2_product_status' => 's:1:"1";',
			'import_step2_minimum_quantity' => 's:1:"1";',
			'import_step2_requires_shipping' => 's:1:"1";',
			'import_step2_out_of_stock_status' => 's:1:"6";',
			'import_step2_subtract_stock' => 's:1:"1";',
			'import_step2_step' => 's:12:"import_step2";',
			'import_step3_step' => 's:12:"import_step3";',
			'import_step4_step' => 's:12:"import_step4";',
			'import_step4_simple' => 's:1:"0";',
			'import_step4_simple_names' => 'a:10:{s:8:"quantity";s:0:"";s:5:"price";s:0:"";s:6:"status";s:0:"";s:15:"product_special";a:1:{i:0;s:0:"";}s:5:"model";s:0:"";s:3:"sku";s:0:"";s:3:"ean";s:0:"";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";}',
			'import_step4_field_names' => 'a:41:{s:4:"name";a:1:{i:1;s:12:"Product Name";}s:11:"description";a:1:{i:1;s:16:"Long Description";}s:3:"tag";a:1:{i:1;s:0:"";}s:10:"meta_title";a:1:{i:1;s:18:"Product Short Name";}s:16:"meta_description";a:1:{i:1;s:17:"Short Description";}s:12:"meta_keyword";a:1:{i:1;s:0:"";}s:5:"model";s:9:"Model No.";s:3:"sku";s:11:"Product SKU";s:3:"upc";s:0:"";s:3:"ean";s:0:"";s:3:"jan";s:0:"";s:4:"isbn";s:0:"";s:3:"mpn";s:0:"";s:8:"location";s:0:"";s:5:"price";s:4:"MSRP";s:8:"quantity";s:0:"";s:7:"minimum";s:0:"";s:8:"subtract";s:0:"";s:8:"shipping";s:0:"";s:7:"keyword";s:0:"";s:12:"stock_status";s:0:"";s:5:"image";s:11:"Large Image";s:6:"length";s:0:"";s:6:"height";s:0:"";s:5:"width";s:0:"";s:6:"weight";s:0:"";s:6:"status";s:0:"";s:10:"sort_order";s:0:"";s:12:"manufacturer";s:12:"Manufacturer";s:8:"category";a:1:{i:0;a:2:{i:0;s:8:"Category";i:1;s:12:"Sub-category";}}s:8:"download";a:1:{i:0;s:0:"";}s:15:"product_related";s:0:"";s:6:"filter";a:1:{i:0;s:0:"";}s:17:"product_attribute";a:1:{i:1;s:14:"Product Origin";}s:14:"product_option";a:1:{i:1;s:0:"";}s:16:"product_discount";a:1:{i:0;s:0:"";}s:15:"product_special";a:1:{i:0;s:0:"";}s:13:"product_image";a:1:{i:0;s:0:"";}s:6:"points";s:0:"";s:14:"product_reward";s:0:"";s:6:"layout";a:1:{i:0;s:0:"";}}',
			'import_step5_import_range' => 's:3:"all";',
			'import_step5_delete_diff' => 's:6:"ignore";',
			'import_step5_update_field' => 's:3:"sku";',
			'import_step5_existing_items' => 's:6:"update";',
			'import_step5_new_items' => 's:3:"add";',
			'import_step5_save_settings_name' => 's:9:"Overstock";',
			'import_step5_step' => 's:12:"import_step5";',
		);
		$this->addPresetprofile('Overstock', $overstock_settings);
		$this->addPresetprofile('Chinavision', $chinavision_settings);
		*/

		$this->addPresetprofile('Chinabuye', $chinabuye_settings);
		$this->addPresetprofile('Sexshop365', $sexshop365_settings);
		$this->addPresetprofile('Pixmaniapro', $pixmaniapro_settings);

	}

	public function getSavedPresetSettingNames() {
		//create db if doesn't exist.
		if (!$this->presetFeedsExist()) {
			$this->createPresetTable();
		}
		$query = $this->db->query("SELECT DISTINCT(`group`) FROM " . DB_PREFIX . "hj_preset_settings");
		$names = array();
		foreach ($query->rows as $row) {
			$names[] = $row['group'];
		}
		return $names;
	}

	public function getSavedSettingNames() {
		//create db if doesn't exist.
		$sql = 'CREATE TABLE IF NOT EXISTS ' . DB_PREFIX . 'hj_import_settings (`id` INT(11) AUTO_INCREMENT, `group` VARCHAR(255), `step` INT(11), `name` BLOB, `value` BLOB, PRIMARY KEY (id))';
		$this->db->query($sql);
		$query = $this->db->query("SELECT DISTINCT(`group`) FROM " . DB_PREFIX . "hj_import_settings");
		$names = array();
		foreach ($query->rows as $row) {
			$names[] = $row['group'];
		}
		return $names;
	}

	public function saveSettings($name) {

		$this->load->model('setting/setting');
		$settings = array(
			$this->model_setting_setting->getSetting('import_step1'),
			$this->model_setting_setting->getSetting('import_step2'),
			$this->model_setting_setting->getSetting('import_step3'),
			$this->model_setting_setting->getSetting('import_step4'),
			$this->model_setting_setting->getSetting('import_step5')
		);
		//get settings from step1-5 and save them with a name in $data
		$this->db->query('DELETE FROM ' . DB_PREFIX . "hj_import_settings WHERE `group` = '" . $this->db->escape($name) . "'");
		for ($i=0; $i<count($settings); $i++) {
			foreach ($settings[$i] as $key => $value) {
				$this->db->query('INSERT INTO ' . DB_PREFIX . "hj_import_settings SET `group` = '" . $this->db->escape($name) . "', `step` = '" . (int)($i+1) . "', `name` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
			}
		}
	}

	public function loadSettings($name) {
		$this->load->model('setting/setting');
		$setting_location = 'hj_import_settings';
		// Presets have a prefix added to their option value
		if (strpos($name, 'preset_') === 0) {
			$setting_location = 'hj_preset_settings';
			$name = substr($name, 7);
		}
		for ($i=1; $i<=5; $i++) {
			$settings = array();
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . $setting_location . " WHERE `group` = '" . $this->db->escape($name) . "' AND `step` = " . $i);
			foreach ($query->rows as $result) {
				$settings[$result['name']] = $result['value'];
			}
			$this->model_setting_setting->editSetting('import_step' . $i, $settings);
		}
	}

	public function deleteSettings($group) {
		$query = $this->db->query("DELETE FROM " . DB_PREFIX . "hj_import_settings WHERE `group` = '" . $this->db->escape($group) . "'");
	}

	public function deleteSpecials($product_id){
		$query = $this->db->query("DELETE FROM " . DB_PREFIX . "product_special WHERE product_id = '" . (int)$product_id. "'");
	}

	public function fetchFeed(&$settings, $unzip_feed=false, $use_auth=false) {
		$this->logger = new Log("hj_tip.log");
		$this->logger->write(sprintf('[%s] - %s', $this->language->get('log_level_info'), 'Starting feed fetch.'));
		$success = false;
		$filename = DIR_APPLICATION . 'feed.txt';
		if(isset($settings['source'])) {
			if ($settings['source'] == 'file') {
				if (defined('CLI_INITIATED')) {
					$success = true; //we will do it with whatever feed is on the filesystem, no need to fetch.
				} elseif (is_uploaded_file($this->request->files['feed_file']['tmp_name'])) {
					if ($this->request->files['feed_file']['error'] == UPLOAD_ERR_OK) {
						$success = move_uploaded_file($this->request->files['feed_file']['tmp_name'], $filename);
					} else {
						$success = false;
					}
				}
			} elseif ($settings['source'] == 'url') {
				$this->logger->write(sprintf('[%s] - %s', $this->language->get('log_level_info'), 'Source: URL, Location: '.$settings['feed_url']));
				$ch = curl_init();
				$fp = fopen($filename, 'w');
				$url = str_replace('&amp;', '&', $settings['feed_url']);
				$ports = array();
				if (preg_match('/:(\d+)/', $url, $ports)) {
                    $url = preg_replace('/:\d+/', '', $url);
                    curl_setopt($ch, CURLOPT_PORT, (int)$ports[1]);
                }
				curl_setopt($ch, CURLOPT_URL, $url);
				if ($use_auth) {
					curl_setopt($ch, CURLOPT_USERPWD, $use_auth['user'] . ":" . $use_auth['pass']);
					curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
				}
				curl_setopt($ch, CURLOPT_FILE, $fp);
				if (ini_get('open_basedir') == '') {
					curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
				}
				curl_setopt($ch, CURLOPT_MAXREDIRS, 2);
				curl_exec($ch);
				$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
				curl_close($ch);
				fclose($fp);
				$this->logger->write(sprintf('[%s] - %s', $this->language->get('log_level_info'), 'HTTP Status: '.$httpCode));
				$success = ($httpCode != '404' && $httpCode != '401');
			} elseif ($settings['source'] == 'ftp' && $settings['feed_ftpuser'] && $settings['feed_ftpserver'] && $settings['feed_ftppass'] && $settings['feed_ftppath']) {
				$success = $this->fetchFtp($settings['feed_ftpserver'], $settings['feed_ftpuser'], $settings['feed_ftppass'], $settings['feed_ftppath'], $filename);
			} elseif ($settings['source'] == 'filepath') {
				$success = copy($settings['feed_filepath'], $filename);
			} elseif ($settings['source'] == 'db') {
				//@todo implement direct from DB.
			}

			if ($unzip_feed) {
				$temp_file = $this->unzip($filename);
				rename($temp_file, $filename);
			}
		}
		return ($success) ? $filename : '';
	}

	private function fetchFtp($server, $user, $pass, $remote_file, $local_file) {
		$this->logger = new Log("hj_tip.log");
		$this->logger->write(sprintf('[%s] - %s', $this->language->get('log_level_info'), 'Starting FTP Feed Fetch from server: '.$server));
		$conn_id = ftp_connect($server);
		$login_result = ftp_login($conn_id, $user, $pass);
		$success = ftp_get($conn_id, $local_file, $remote_file, FTP_BINARY);
		ftp_close($conn_id);
		return $success;
	}
	/*
	 *
	 * function fetchImage
	 *
	 * @desc - fetches an image from a URL. If the URL contains a ? character the new image's filename
	 * will be the md5 of the full URL. If not, it will be the last portion of the URL (after the last /).
	 * If the image URL returns a 404 the image will be deleted and an empty string returned.
	 *
	 * @param (string) the image url to fetch
	 * @return (string) the name of the fetched file on disk relative to the image/ dir or empty string on 404
	 *
	 */
	public function fetchImage($image_url, $folder='') {

		$error = '';
		$info = '';
		$filename = '';

		$image_url = trim($image_url);

		if (strstr($image_url, 'data/') == 0 && file_exists(DIR_IMAGE . $folder . $image_url)) {
			$error = sprintf("[%s] - %s", $this->language->get('log_level_info'), $image_url . ' is not a URL, using local file instead.');
            $filename = $image_url;
        }

		if (strpos($image_url, 'http') !== 0) {
			$error = sprintf("[%s] - %s", $this->language->get('log_level_info'), $image_url . ' is not a valid URL, skipping image.');
		}

		if (empty($error)) {

			if($folder != '') {
				$new_folder = DIR_IMAGE . 'data/' . $folder;
				if (!file_exists($new_folder)) {
					mkdir($new_folder, 0777, true);
				}
			}

			if (strstr($image_url, '?')) {
				if($folder != '' && $folder != '/') {
					$filename = 'data/' . $folder . '/' . md5($image_url) . '.jpg';
				} else {
					$filename = 'data/' . md5($image_url) . '.jpg';
				}
			} else {
				$url_parts = explode('/', $image_url);
				// Decode html space for image filename
				$end = str_replace('%20', ' ', end($url_parts));
				if($folder != '' && $folder != '/') {
					$filename = 'data/' . $folder . '/' . $end;
				} else {
					$filename = 'data/' . $end;
				}
			}

			if (!file_exists(DIR_IMAGE . $filename)) {
				$fp = fopen(DIR_IMAGE . $filename, 'w');
				$ch = curl_init();
				$ports = array();
				// Encode spaces in url
				$image_url = str_replace(' ', '%20', $image_url);
				if (preg_match('/:(\d+)/', $image_url, $ports)) {
                    $image_url = preg_replace('/:\d+/', '', $image_url);
                    curl_setopt($ch, CURLOPT_PORT, (int)$ports[1]);
                }
				curl_setopt($ch, CURLOPT_URL, $image_url);
				curl_setopt($ch, CURLOPT_FILE, $fp);
				if (ini_get('open_basedir') == '') {
					curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
					curl_setopt($ch, CURLOPT_MAXREDIRS, 2);
				}
				curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
				curl_exec($ch);
				$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
				$info = curl_getinfo($ch);
				curl_close($ch);
				fclose($fp);
				$file_info = "";
				if (file_exists(DIR_IMAGE . $filename) && filesize(DIR_IMAGE . $filename) > 0)
					$file_info = getimagesize(DIR_IMAGE . $filename);
				if($httpCode == 404 || empty($file_info) || (isset($file_info['mime']) && strpos($file_info['mime'], 'image/') !== 0)) {
					unlink(DIR_IMAGE . $filename);
					$filename = '';
					if (isset($file_info['mime']) && strpos($file_info['mime'], 'image/') !== 0) {
						$error = sprintf("[%s] - %s", $this->language->get('log_level_warning'), $image_url . " was not an image.");
					}
					if($httpCode == 404) {
						$error = sprintf("[%s] - %s", $this->language->get('log_level_warning'), $image_url . " not found. (404)");
					}
					if(empty($file_info)) {
						$error = sprintf("[%s] - %s", $this->language->get('log_level_warning'), $image_url . " was empty.");
					}
				}
			}
		}
		return array('filename' => $filename, 'error' => $error, 'info' => $info);
	}


	public function importFile($filename, &$settings) {
		$this->logger = new Log("hj_tip.log");
		$this->logger->write(sprintf('[%s] - %s', $this->language->get('log_level_info'), 'Importing file: '.$filename));
		if(!empty($settings['file_encoding']) && $settings['file_encoding'] != 'UTF-8') {
			$this->file_encoding = $settings['file_encoding'];
		}
		if ($settings['format'] == 'csv') {
			if ($settings['delimiter'] == '\t' ) {
				$settings['delimiter'] = "\t";
			} elseif ($settings['delimiter'] == '') {
				$settings['delimiter'] = ',';
			}
			$csv_options = array();
			if(!empty($settings['safe_headers'])) {
				$csv_options['safe_headers'] = $settings['safe_headers'];
			}
			if(!empty($settings['has_headers'])) {
				$csv_options['has_headers'] = $settings['has_headers'];
			}
			if (!empty($settings['cron_fetch']) && !defined('CLI_INITIATED')) {
				$this->cron_fetch = true;
			}
			$this->importCSV($filename, $settings['delimiter'], $csv_options);
		} elseif ($settings['format'] == 'xml') {
			$this->table_created = false;
			$xml_options = array();
			if (!empty($settings['cron_fetch']) && !defined('CLI_INITIATED')) {
				$this->cron_fetch = true;
			}
			$this->importXML($filename, $settings['xml_product_tag'], $xml_options);
		}

		return array('total_items_ready'=>$this->total_items_ready, 'total_items_missed'=>$this->total_items_missed);
	}

	private function importXML($filename, $product_tag, $xml_options) {
		$this->product_tag = $product_tag;
		$this->xml_data = '';
		$fh = fopen($filename, 'r');
		$xml_parser = xml_parser_create($this->file_encoding);
		xml_set_object($xml_parser, $this);
		xml_set_element_handler($xml_parser, 'startTag', 'endTag');
		xml_set_character_data_handler($xml_parser, 'cData');
		xml_parser_set_option($xml_parser, XML_OPTION_CASE_FOLDING, false);
		while ($data = fread($fh, 4096)) {
			if (!xml_parse($xml_parser, $data, feof($fh))) {
				xml_parser_free($xml_parser);
				return false;
			}
			if ($this->cron_fetch && $this->total_items_ready >= CRON_FETCH_NUM)
			{
				xml_parser_free($xml_parser);
				return true;
			}
		}
		xml_parser_free($xml_parser);
		return true;
	}

	private function importCSV($filename, $delimiter, $csv_options) {
		$fh = fopen($filename, 'r');
		if (!empty($csv_options['safe_headers']) || empty($csv_options['has_headers'])) {
			$count = count(fgetcsv($fh, 0, $delimiter));
			//if there are no file headers, reset the file read after doing the count
			if (empty($csv_options['has_headers'])) {
				$fh = fopen($filename, 'r');
			}
			for ($i = 0; $i < $count; $i++) {
				$headings[$i] = 'column_' . $i;
			}
		} else {
			$headings = array_map('trim', fgetcsv($fh, 0, $delimiter)); //trim white space from all headings for db insertion.
			$headings = str_replace('\'', '', $headings);
		}

		for ($i=0; $i<count($headings); $i++) {
			if (empty($headings[$i])) {
				$headings[$i] = ' column_' . ($i+1);
			}
		}

		$this->createEmptyTable($headings);
		$num_cols = count($headings);
		//most complicated do-while ever written.
		do {
			//miss items that have incorrect column count:
			while (($row = fgetcsv($fh, 0, $delimiter)) !== FALSE && count($row) != $num_cols) {
				$this->total_items_missed++;
			}
			if ($row) {
				if ($this->cron_fetch)
				{
					if ($this->total_items_ready >= CRON_FETCH_NUM)
						break;
				}
				$this->insertProduct(array_combine($headings, $row));
				$this->total_items_ready++;
			}
		} while ($row);
	}

	private function unzip($file) {
		$filename = $file;
		$zip = zip_open($file);
		if (is_resource($zip)) {
			$zip_entry = zip_read($zip);
			$filename = zip_entry_name($zip_entry);
			$fp = fopen($filename, 'w');
			if (zip_entry_open($zip, $zip_entry, 'r')) {
				$buf = zip_entry_read($zip_entry, zip_entry_filesize($zip_entry));
				fwrite($fp,"$buf");
				zip_entry_close($zip_entry);
				fclose($fp);
			}
			zip_close($zip);
		}
		return $filename;
	}

	public function fileUploadErrorMessage($error_code) {
		switch ($error_code) {
			case UPLOAD_ERR_INI_SIZE:
				return 'The uploaded file exceeds the upload_max_filesize directive in php.ini';
			case UPLOAD_ERR_FORM_SIZE:
				return 'The uploaded file exceeds the MAX_FILE_SIZE directive that was specified in the HTML form';
			case UPLOAD_ERR_PARTIAL:
				return 'The uploaded file was only partially uploaded';
			case UPLOAD_ERR_NO_FILE:
				return 'No file was uploaded';
			case UPLOAD_ERR_NO_TMP_DIR:
				return 'Missing a temporary folder';
			case UPLOAD_ERR_CANT_WRITE:
				return 'Failed to write file to disk';
			case UPLOAD_ERR_EXTENSION:
				return 'File upload stopped by extension';
			default:
				return 'Unknown upload error';
		}
	}

	/*
	*
	* XML parser support functions:
	*
	* startTag
	* endTag
	* cData
	*
	*/
	private function startTag ($parser, $name, $attr) {
		if (strcmp($name, $this->product_tag) == 0) {
			$this->xml_product = array();
		}
		//Get attributes
		foreach ($attr as $key=>$value) {
			if (!isset($this->xml_product[$name.'_attr_'.$key])) {
				$this->xml_product[$name.'_attr_'.$key] = $value;
			} else {
				$this->xml_product[$name.'_attr_'.$key] .= '^' . $value;
			}
		}
	}

	private function endTag ($parser, $name) {
		if (strcmp($name, $this->product_tag) == 0) {
			if (!$this->table_created) {
				$columns_to_add = array();
				$columns_to_check = array_keys($this->xml_product);
				foreach ($columns_to_check as $xml_tag) {
					$found = false;
					foreach ($columns_to_add as $existing_col) {
						if (strtolower($existing_col) == strtolower($xml_tag)) {
							unset($this->xml_product[$xml_tag]);
							$found = true;
						}
					}
					if (!$found)
						$columns_to_add[] = $xml_tag;
				}
				$this->createEmptyTable($columns_to_add);
				$this->xml_existing_fields = $columns_to_add;
				$this->table_created = true;
			}
			$new_columns = array_diff(array_keys($this->xml_product), $this->xml_existing_fields);
			//make sure new columns aren't just existing columns with different case:
			$not_new_columns = array();
			foreach ($new_columns as $new_col) {
				foreach ($this->xml_existing_fields as $existing_col) {
					if (strtolower($new_col) == strtolower($existing_col)) {
						$not_new_columns[] = $new_col;
						$col_data = $this->xml_product[$new_col];
						unset($this->xml_product[$new_col]);
						$this->xml_product[$existing_col] = $col_data;
					}
				}
			}
			$new_columns = array_diff($new_columns, $not_new_columns);
			if (!empty($new_columns)) {
				$this->alterImportTable($new_columns);
				$this->xml_existing_fields = array_unique(array_merge($this->xml_existing_fields, $new_columns));
			}
			if (!($this->cron_fetch && $this->total_items_ready >= CRON_FETCH_NUM)) {
				$this->insertProduct($this->xml_product);
				$this->total_items_ready++;
			}
		} else {
			if (isset($this->xml_product[$name])) {
				$this->xml_product[$name] .= '^' . $this->xml_data;
			} else {
				$this->xml_product[$name] = $this->xml_data;
			}
		}
		$this->xml_data = '';

	}

	private function cData($parser, $content) {
		$this->xml_data .= $content;
	}

	//Auto Seo generation deprecated
	/*public function makeSeoKeyword($text='') {
		//Title to friendly URL conversion
		$text = trim(str_replace('&quot;', ' ', $text)); //remove &quot; added to name
		$urltitle= preg_replace('/[^\p{L}\p{N}]/u',' ', $text);
		$newurltitle= str_replace(" ","-",$urltitle);
		$seo_keyword= $newurltitle; // Final URL

		//if the alias is taken, set it to blank
		if($this->checkUrlAlias($seo_keyword)) {
			$seo_keyword = '';
		}
		return $seo_keyword;
	}*/

	//checks if the URL alias is in use, if not it uses it
	public function checkUrlAlias($text) {
		$query = $this->db->query("SELECT keyword FROM `" . DB_PREFIX . "url_alias` WHERE keyword = '" . $this->db->escape($text) . "'");
		return (isset($query->row['keyword'])) ? true : false;
	}


	public function getVersion() {
		return VERSION;
	}

	/* Update simple fields for product table & specials
	 *
	 * @param int $update_id
	 * @param array $fields field name and field value
	 */
	public function simpleUpdate($update_id, $fields){
		$field_amount = count($fields);
		$field_update = 0;
		if (isset($fields['product_special'])){
			$this->deleteSpecials($update_id);
			foreach ($fields['product_special'] as $special){
				$sql = "INSERT " . DB_PREFIX . "product_special SET product_id = '" . (int)$update_id . "', customer_group_id = '" . (int)$special['customer_group_id'] . "', priority = '" . (int)$special['priority'] . "', price = '" . (float)$special['price'] . "', date_start = '" . $this->db->escape($special['date_start']) . "', date_end = '" . $this->db->escape($special['date_end']). "' ";
				$this->db->query($sql);
			}
			//remove from product table fields
			unset($fields['product_special']);
			$field_update++;
		}
		if (count($fields) >= 1){
			$sql = "UPDATE " . DB_PREFIX . "product SET ";
			foreach ($fields as $field_name => $field_value){
				$field_update++;
				$sql .= $this->db->escape($field_name)." = '".(float)$field_value."'";
				if ($field_update !== $field_amount){
						$sql .= ", ";
				}
			}
			$sql .= " WHERE product_id = '".(int)$update_id."'";
			$this->db->query($sql);
		}
	}
}

?>
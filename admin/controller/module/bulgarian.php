<?php
class ControllerModuleBulgarian extends Controller{
	private $error = array();
	
	public function index() 
	{
					
		$this->load->language('module/bulgarian');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_license'] = $this->language->get('text_license');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['text_edit'] = $this->language->get('text_edit');
		
		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link(
                'common/home', 'token=' . $this->session->data['token'], 'SSL'
            ),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link(
				'extension/module', 'token=' . $this->session->data['token'], 'SSL'
			),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link(
				'module/bulgarian', 'token=' . $this->session->data['token'], 'SSL'
			),
      		'separator' => ' :: '
   		);
		
		$data['action'] = $this->url->link(
			'module/bulgarian', 
			'token=' . $this->session->data['token'], 
			'SSL'
		);
		
		$data['cancel'] = $this->url->link(
			'extension/module', 'token=' . $this->session->data['token'], 'SSL'
		);

		if (isset($this->request->post['bulgarian_module'])) {
			$modules = explode(',', $this->request->post['bulgarian_module']);
		} elseif ($this->config->get('bulgarian_module') != '') { 
			$modules = explode(',', $this->config->get('bulgarian_module'));
		} else {
			$modules = array();
		}		
		
		$this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();

		$data['modules'] = $modules;
		
		if (isset($this->request->post['bulgarian_module'])) {
			$data['bulgarian_module'] = $this->request->post['bulgarian_module'];
		} else {
			$data['bulgarian_module'] = $this->config->get('bulgarian_module');
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		
		$this->response->setOutput($this->load->view('module/bulgarian.tpl', $data));

	}
	
	public function install() 
	{
		if ($this->request->server['HTTPS']) {
			$data['base'] = HTTPS_SERVER;
		} else {
			$data['base'] = HTTP_SERVER;
		}
		// Език
		$this->load->model('localisation/language');
		$lang = new ModelLocalisationLanguage($this->registry);
		$languages = $lang->getLanguages();
		if (!isset($languages["bg"])) {
			// Езикови настройки
			$data["name"]		= 'Български';
			$data["code"]		= 'bg';
			$data["locale"]		= 'bg.UTF-8,BG,bulgarian';
			$data["directory"]	= 'bulgarian';
			$data["filename"]	= 'bulgarian';
			$data["image"]		= 'bg.png';
			$data["sort_order"]	= 2;
			$data["status"]		= 1;
			$lang->addLanguage($data);
			$languages = $lang->getLanguages();
			if (isset($languages["bg"])) {
				$language_id = $languages["bg"]["language_id"];
				$this->db->query("UPDATE " . DB_PREFIX . "information_description SET title = 'Поверителност', description= '&lt;p&gt;Поверителност&lt;/p&gt;' WHERE information_id=3 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "information_description SET title = 'За нас', description='&lt;p&gt;За нас&lt;/p&gt;' WHERE information_id=4 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "information_description SET title = 'Условия за ползване', description='&lt;p&gt;Условия за ползване&lt;/p&gt;' WHERE information_id=5 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "information_description SET title = 'Условия за доставка', description='&lt;p&gt;Условия за доставка&lt;/p&gt;' WHERE information_id=6 AND language_id =" . $language_id);
				
				$this->db->query("UPDATE " . DB_PREFIX . "length_class_description SET title = 'Сантиметър',unit = 'см' WHERE length_class_id=1 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "length_class_description SET title = 'Милиметър',unit = 'мм' WHERE length_class_id=2 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "length_class_description SET title = 'Инч',unit = 'in' WHERE length_class_id=3 AND language_id =" . $language_id);
				
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Чакаща' WHERE order_status_id=1 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Обработва се' WHERE order_status_id=2 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Изпратена' WHERE order_status_id=3 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Приключена' WHERE order_status_id=5 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Отказана' WHERE order_status_id=7 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Отхвърлена' WHERE order_status_id=8 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Отменено сторниране' WHERE order_status_id=9 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Неуспешна' WHERE order_status_id=10 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Възстановена сума' WHERE order_status_id=11 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'За плащане' WHERE order_status_id=12 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Сторнирана' WHERE order_status_id=13 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Изтекла' WHERE order_status_id=14 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Обработена' WHERE order_status_id=15 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "order_status SET name = 'Отменена' WHERE order_status_id=16 AND language_id =" . $language_id);
				
				$this->db->query("UPDATE " . DB_PREFIX . "stock_status SET name = 'няма' WHERE stock_status_id=5 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "stock_status SET name = 'до 2-3 дни' WHERE stock_status_id=6 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "stock_status SET name = 'има' WHERE stock_status_id=7 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "stock_status SET name = 'с поръчка' WHERE stock_status_id=8 AND language_id =" . $language_id);
				
				$this->db->query("UPDATE " . DB_PREFIX . "weight_class_description SET title= 'Килограм', unit='кг' WHERE weight_class_id=1 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "weight_class_description SET title= 'Грам', unit='гр' WHERE weight_class_id=2 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "weight_class_description SET title= 'Паунд', unit='lb' WHERE weight_class_id=5 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "weight_class_description SET title= 'Унция', unit='oz' WHERE weight_class_id=6 AND language_id =" . $language_id);
				
				$this->db->query("UPDATE " . DB_PREFIX . "return_status SET name= 'В процес на разглеждане' WHERE return_status_id=1 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "return_status SET name= 'Чакащи връщане продукти' WHERE return_status_id=2 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "return_status SET name= 'Приключен' WHERE return_status_id=3 AND language_id =" . $language_id);
				
				$this->db->query("UPDATE " . DB_PREFIX . "return_action SET name= 'Възстановена сума' WHERE return_action_id=1 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "return_action SET name= 'Издаден кредит' WHERE return_action_id=2 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "return_action SET name= 'Подменен продукт' WHERE return_action_id=3 AND language_id =" . $language_id);
				
				$this->db->query("UPDATE " . DB_PREFIX . "return_reason SET name= 'Не работи' WHERE return_reason_id=1 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "return_reason SET name= 'Грешен продукт' WHERE return_reason_id=2 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "return_reason SET name= 'Грешка в поръчката' WHERE return_reason_id=3 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "return_reason SET name= 'С дефект (моля, дайте детайли)' WHERE return_reason_id=4 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "return_reason SET name= 'Друга (моля, дайте детайли)' WHERE return_reason_id=5 AND language_id =" . $language_id);
				
				$this->db->query("UPDATE " . DB_PREFIX . "voucher_theme_description SET name= 'Коледна' WHERE voucher_theme_id=6 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "voucher_theme_description SET name= 'Рожден ден' WHERE voucher_theme_id=7 AND language_id =" . $language_id);
				$this->db->query("UPDATE " . DB_PREFIX . "voucher_theme_description SET name= 'Обща' WHERE voucher_theme_id=8 AND language_id =" . $language_id);
			}
		}
		
	}

	public function uninstall() 
	{
		$this->load->model('localisation/language');
		$this->load->model('setting/setting');
		$lang = new ModelLocalisationLanguage($this->registry);
		$languages = $lang->getLanguages();
		if (isset($languages["bg"])) {
			$language_id = $languages["bg"]["language_id"];
			$lang->deleteLanguage($language_id);
		}

		// Change admin language and store language, if it is Bulgarian
		$set = new ModelSettingSetting($this->registry);
		$config_values = $set->getSetting('config', 0);

		$values_changed = false;
		if (isset($config_values["config_admin_language"]) 
			and $config_values["config_admin_language"]==='bg'
		) {
			$config_values["config_admin_language"] = 'en';
			$values_changed = true;
		}
		if (isset($config_values["config_language"]) 
			and $config_values["config_language"]==='bg'
		) {
			$config_values["config_language"] = 'en';
			$values_changed = true;
		}
		if ($values_changed===true) {
			$set->editSetting('config', $config_values, 0);
		}
	}
}
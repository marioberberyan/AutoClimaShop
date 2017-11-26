<?php
class ControllerModuleC2c extends Controller {
  private $error = array();

  public function index()
  {
    $this->language->load('module/c2c');

    $this->document->setTitle($this->language->get('heading_title'));
    $this->document->addStyle('view/stylesheet/cart2cart/c2c.css');
    $this->document->addStyle('http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css');
    $this->document->addScript('view/javascript/cart2cart/md5-min.js');
    $this->document->addScript('view/javascript/cart2cart/c2c.js');

    $this->load->model('cart2cart/worker');

    $worker =  $this->model_cart2cart_worker;

    $settings = $this->getSettings();

    $showButton = 'install';
    if ($worker->isBridgeExist()) {
      $showButton = 'uninstall';
    }
    $data['showButton'] = $showButton;
    $loginStatus = $settings['Cart2CartLoginStatus'];

    if ($loginStatus == '') {
      $loginStatus = 'No';
    }
    $data['loginStatus']              = $loginStatus;
    $data['cartName']                 = $this->language->get('cartName');
    $data['sourceCartName']           = $sourceCartName = $this->language->get('sourceCartName');
    $data['sourceCartNameImg']        = $sourceCartNameImg = $this->language->get('sourceCartNameImg');
    $data['sourceCartNameLink']       = $sourceCartNameLink = $this->language->get('sourceCartNameLink');
    $data['storeToken']               = $settings['Cart2CartStoreToken'];
    $data['Cart2CartRemoteHost']      = $settings['Cart2CartRemoteHost'];
    $data['Cart2CartRemoteUsername']  = $settings['Cart2CartRemoteUsername'];
    $data['Cart2CartRemoteDirectory'] = $settings['Cart2CartRemoteDirectory'];
    $data['Cart2CartLoginEmail']      = $settings['Cart2CartLoginEmail'];
    $data['Cart2CartLoginKey']        = $settings['Cart2CartLoginKey'];
    $data['sourceCartLogo']           = 'http://www.shopping-cart-migration.com/images/stories/'.strtolower($sourceCartNameImg).'.gif';
    $data['banner']                   = $this->language->get('banner');
    $data['cart2cart_logo']           = $this->language->get('cart2cart_logo');
    $data['referer_text']             = $this->language->get('referer_text');

    $data['breadcrumbs'] = array(
      array(
        'text'      => $this->language->get('text_home'),
        'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
        'separator' => ' :: '
      ),
      array(
        'text'      => $this->language->get('text_module'),
        'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
        'separator' => ' :: '
      ),
      array(
        'text'      => $this->language->get('heading_title'),
        'href'      => $this->url->link('module/c2c', 'token=' . $this->session->data['token'], 'SSL'),
        'separator' => ' :: '
      )
    );

    $data['cancel']         = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
    $data['heading_title']  = $this->language->get('heading_title');
    $data['button_cancel']  = $this->language->get('button_cancel');
    $data['text_installed'] = $this->language->get('text_installed');

    if (property_exists($this,'data')) {
      $this->template = 'module/c2c.tpl';
      $this->children = array(
        'common/header',
        'common/footer'
      );

      $data['version'] = 1;
      $this->data = $data;

      $this->response->setOutput($this->render());
    } else {
      $data['header']         = $this->load->controller('common/header');
      $data['column_left']    = $this->load->controller('common/column_left');
      $data['footer']         = $this->load->controller('common/footer');

      $data['version']        = 2;

      $this->response->setOutput($this->load->view('module/c2c.tpl', $data));
    }

    unset($class_for_version);
  }

  protected function validate()
  {
    if (!$this->user->hasPermission('modify', 'module/c2c')) {
      $this->error['warning'] = $this->language->get('error_permission');
    }

    if (!$this->error) {
      return true;
    } else {
      return false;
    }
  }

  public function saveToken()
  {
    $settings = $this->getSettings();
    $settings['Cart2CartStoreToken'] = $_REQUEST['c2c_token'];
    $this->setSettings($settings);
  }

  public function saveFtp()
  {
    $this->load->model('cart2cart/ftpUpload');
    $settings = $this->getSettings();
    $settings['Cart2CartRemoteHost'] = $_REQUEST['host'];
    $settings['Cart2CartRemoteUsername'] = $_REQUEST['user'];
    $settings['Cart2CartRemoteDirectory'] = $_REQUEST['dir'];
    $this->setSettings($settings);

    set_error_handler(array($this, 'warning_handler'), E_WARNING);

    $c2cFtpUpload = $this->model_cart2cart_ftpUpload;
    if ($c2cFtpUpload->init(
      $_REQUEST['host'],
      $_REQUEST['user'],
      $_REQUEST['pass'],
      $_REQUEST['dir'],
      $settings['Cart2CartStoreToken'])
    ) {
      $c2cFtpUpload->uploadBridge();
    }

    echo json_encode(array(
      'messages' => $c2cFtpUpload->messages,
      'messageType' => $c2cFtpUpload->messageType
    ));

  }

  public function installBridge()
  {
    $settings = $this->getSettings();
    $this->load->model('cart2cart/worker');
    $worker =  $this->model_cart2cart_worker;
    $worker->installBridge($settings['Cart2CartStoreToken']);
  }

  public function removeBridge()
  {
    $this->load->model('cart2cart/worker');
    $worker =  $this->model_cart2cart_worker;
    $worker->unInstallBridge();
  }

  public function saveLoginStatus()
  {
    $settings = $this->getSettings();
    $settings['Cart2CartLoginStatus']	= $_REQUEST['status'];
    $settings['Cart2CartLoginEmail']	= $_REQUEST['email'];
    $settings['Cart2CartLoginKey']		= $_REQUEST['encPass'];
    echo 'set status ' . $_REQUEST['status'];
    $this->setSettings($settings);
  }

  protected function getSettings()
  {
    $this->load->model('setting/setting');
    $settings = $this->model_setting_setting->getSetting('Cart2Cart');
    if (count($settings) == 0) {
      $settings = $this->clearFtpInfo();
    }
    return $settings;
  }

  public function clearFtpInfo()
  {
    $this->load->model('setting/setting');
    $settings = array(
      'Cart2CartStoreToken'       => '',
      'Cart2CartRemoteHost'       => '',
      'Cart2CartRemoteUsername'   => '',
      'Cart2CartRemoteDirectory'  =>'',
      'Cart2CartLoginStatus'      => 'No',
      'Cart2CartLoginEmail'       => '',
      'Cart2CartLoginKey'         => ''
    );
    $this->model_setting_setting->editSetting('Cart2Cart', $settings);
    return $settings;
  }

  protected function setSettings($settings)
  {
    $this->load->model('setting/setting');
    $this->model_setting_setting->editSetting('Cart2Cart', $settings);
  }

  static function warning_handler($errno, $errstr)
  {
    //echo "error handled $errstr";
    // need to suppress  ftp warnings
  }
}
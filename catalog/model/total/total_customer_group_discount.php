<?php
class ModelTotalTotalCustomerGroupDiscount extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		if($user_id = $this->customer->isLogged()){
			$this->load->model('account/customer');
			$customer = $this->model_account_customer->getCustomer($user_id);
			$discounts = $this->config->get('total_customer_group_discount_customer_group_id');
			foreach ($discounts as $group_id => $discount){
				if($group_id == $customer['customer_group_id']){
					$this->load->language('total/total_customer_group_discount');
					$subtraction = $total*($discount/100);
					$total_data[] = array(
						'code'       => 'total_customer_group_discount',
						'title'      => sprintf($this->language->get('text_total_discount'), $discount),
						'text'       => $this->currency->format(-$subtraction),
						'value'      => -$subtraction,
						'sort_order' => $this->config->get('total_customer_group_discount_sort_order')
					);
					$total -= $subtraction;
				}
			}
		}
	}
}
?>